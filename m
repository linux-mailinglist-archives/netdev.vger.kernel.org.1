Return-Path: <netdev+bounces-12345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2198D737252
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3041C20C8F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F272AB39;
	Tue, 20 Jun 2023 17:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C72AB32
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB83DC433C0;
	Tue, 20 Jun 2023 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687280925;
	bh=9XMSvSviQQ2SqbOXexMPo6NJSkzOB+ptmGdPgshU+E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBzycsSeJaIqBmmfsWAHQDSMYfsY11xUSJnNtaDBtZfnwTQR4vZ0YA8FIKd+MMxVa
	 HC7Dbv4gbB9cVy4WiQTGnG/dseLaBeZZBHD6C88ygRZxzJ4UFsSWG/BjJXNFvxuEOm
	 ryQlCISpVCFED3rC+h5+Y32HQgLm4spvps+P4dDW9pphNFdFPo6nt7Bk7RlhR8C2d2
	 lLE18nZGePBjMOyooDN3AoMZG1ZD/qXZPtHc6d/l5DlOl23J/rxr85WrAaS2AZc+4e
	 lf1oP/mamy1RL/n+cgNDe0NjF1udou3b2iNvZcjnoVibjyieoUI7JWg/c7nzXPK9kZ
	 REdRd4EqffUVQ==
Date: Tue, 20 Jun 2023 10:08:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <20230620100843.19569d60@kernel.org>
In-Reply-To: <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
References: <20230620102856.56074-1-hare@suse.de>
	<20230620102856.56074-5-hare@suse.de>
	<5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
> > +	err = tls_rx_reader_lock(sk, ctx, true);
> > +	if (err < 0)
> > +		return err;  
> 
> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
> how is this not a deadlock?

Yeah :|

> I'm not exactly clear why the lock is needed here or what is the subtle
> distinction between tls_rx_reader_lock and what lock_sock provides.

It's a bit of a workaround for the consistency of the data stream.
There's bunch of state in the TLS ULP and waiting for mem or data
releases and re-takes the socket lock. So to stop the flow annoying
corner case races I slapped a lock around all of the reader.

IMHO depending on the socket lock for anything non-trivial and outside
of the socket itself is a bad idea in general.

The immediate need at the time was that if you did a read() and someone
else did a peek() at the same time from a stream of A B C D you may read
A D B C.

