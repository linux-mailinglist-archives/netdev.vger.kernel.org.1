Return-Path: <netdev+bounces-19882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204475CA8F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525E82821F2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A627F18;
	Fri, 21 Jul 2023 14:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DAA27F05
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE46C433CB;
	Fri, 21 Jul 2023 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689951014;
	bh=HxvP9qwzVXvPydklMJxjI8bn17kFxn3qJ9hluGqcBFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoxGc3Cw1i8K8D5k4XplMTkRAq9/LrA/DzDu8xxyn8dXLN/VuP8ajnu9WI902q5I6
	 /a4TctMIp9dYzqn19hU7QvsaiwM8OmEX1PB/t+NcYbicGPhUPkXgnzD9ngi7o9RCi/
	 GH/t50nZdkfGhk0W4T/j/tVIJYeaiuOg9X17XPDOAwwKypkirFI8RJVSWQ2Gz+EJaB
	 xHqF2coagCMcfPPaCuLRJGfH8anFeNsrLCBkRtvUcvEv7K0yJZ1EbWxsEuWE2jvE7M
	 n9ldFTvCNfnYU5xkzlYmoMxfoGiDFUenblDX61kkxcax//warLmwmItv7JEWGj0TWn
	 Yylu0hsLPQBdg==
Date: Fri, 21 Jul 2023 07:50:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Message-ID: <20230721075013.0d71e21b@kernel.org>
In-Reply-To: <a3184117-751a-c582-6295-f45a26398deb@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
	<20230719113836.68859-7-hare@suse.de>
	<20230720200216.4bf1bf4b@kernel.org>
	<a3184117-751a-c582-6295-f45a26398deb@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 15:53:05 +0200 Hannes Reinecke wrote:
> >> +			err = tls_rx_one_record(sk, NULL, &darg);
> >> +			if (err < 0) {
> >> +				tls_err_abort(sk, -EBADMSG);
> >> +				goto read_sock_end;
> >> +			}
> >> +
> >> +			sk_flush_backlog(sk);  
> > 
> > Hm, could be a bit often but okay.
> >   
> When would you suggest to do it?
> (Do I need to do it at all?)

I picked every 128kB for the normal Rx path. I looked thru my old notes
and it seems I didn't measure smaller batches :( Only 128kB - 4MB.
Flush every 128kB was showing a 4% throughput hit, but much better TCP
behavior. Not sure how the perf hit would scale below 128kB, maybe 
the lower the threshold the lower the overhead because statistically
only one of every 4 calls will have something to do? (GRO coalesces
to 64kB == 4 TLS records). Dunno. You'd have to measure.

But its not a blocker for me, FWIW, you can keep the flushing on every
record.

