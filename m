Return-Path: <netdev+bounces-122383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D5960E3E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72EC1C22665
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5EC1C86F3;
	Tue, 27 Aug 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLQhnZbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC791C86F0
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769982; cv=none; b=g3whB6nNWaW7uD5/TE3q93DAr0RrKr36/lk0x5nRVwXXgLXYKENViImn85FPcLHOfafJ+6JlexDB9rV9QOBx9SU6vMI+30ZkBtflma4Nytye6DGybu5MV0UefZptYLBs57KpDxMi8DHtGWgyBL606aehM7E0QN50lggY3UGslU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769982; c=relaxed/simple;
	bh=OJPEq/yU40/DuZNgAVS4bXy/RN30Jzg7BMAg2KwZTwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8LzuFnFwft+eevXq1ortg3TEQJnhUfIVbSB6Cxi5U+j7RgFUtxLPfYw83bevTHYPT21WcAVWihZvLyBbOwFviXgewcBQBoxliIJ3vFt4Oo3jVPqRswMqvidLhUlfB/a6DsX4hOFakEvSlbXzQBPc/+z8WD6HnLvOslziBETxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLQhnZbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5DC6107C;
	Tue, 27 Aug 2024 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769981;
	bh=OJPEq/yU40/DuZNgAVS4bXy/RN30Jzg7BMAg2KwZTwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLQhnZbx3U+jccPA9omUEmN0WLR2qkVhn2c1UkdsN/yCxbWhShERg59q1Iucqum2E
	 eWfqRkMaqBsGd3P6StnS/nPilDI2lNcVVhB4n6qF4XBj7LDRsOXlFg2DiFBMN5opum
	 JosV+gTeAkWP7OP1Acb6d5qgNm2GUV+zVZNWlzd4f34bz7cflN7l6n4M7SBVE1WRCp
	 tmLxXr1jSKbEFOYqzXZ7A+/BNrvXFnXMKFM+edcuMEvTavVC0HAOMex7k7559pK5R4
	 nE0LLqFulc/NXE8dkrkJdgKcCxRsN8xXRsyFSPslR0OGx0jK/290lkzPyptaSXKWRI
	 CH0xiPcqNrRWA==
Date: Tue, 27 Aug 2024 07:46:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Message-ID: <20240827074620.03f4d92a@kernel.org>
In-Reply-To: <20240825152440.93054-2-kerneljasonxing@gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
	<20240825152440.93054-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 23:24:39 +0800 Jason Xing wrote:
> However, there is one particular case that fails the selftests with
> "./rxtimestamp: Expected swtstamp to not be set." error printing in
> testcase 6.

In case you ever find yourself looking for ways to improve our tests 
may I suggest trying to speed up fcnal_test.sh?  That'd be a very
productive use of time.

