Return-Path: <netdev+bounces-147929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B202C9DF2BF
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 20:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52052B209EF
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7F1A9B3E;
	Sat, 30 Nov 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLuBxbao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175A132103
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993656; cv=none; b=kTtLpgSsPuYQPDo552kmtGWes5xEM22ErKaa3PJWjUo9Kx1Z0ybmRi4bf7UkzIGYzYXM4CnpGplf9cZX4nlAUT2u4yWuI1+Y/vqodVwughq7G0kOLBZuw0TNaj62wvRQ2phUpNK+Oq/uQXkjYgf2edoXK22JyQ1JpxCEQlpVWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993656; c=relaxed/simple;
	bh=/48JhtWShl+3UFo2gKA/3dIPyA9h2yZVEhHZSJ05WGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXkVyXepHXrc1vtG0Xow5iKUg+glO4inZAklZlTHWMa0JEz50C6RvQkakmQgydZw2/mDdPQMWTi699W6k4dmakpHd0g6fWCHPIHtMzznGJewoC9uTB/GVpm4e5rlQYoDA7AsplhFpkdqu6Au99+F9PjdLl33ku5cKTaiafeCGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLuBxbao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8403DC4CECC;
	Sat, 30 Nov 2024 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993655;
	bh=/48JhtWShl+3UFo2gKA/3dIPyA9h2yZVEhHZSJ05WGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eLuBxbaoq0/7JlJsuOvxepUqDb/Upx3tou5bX5boabn4zI9pAXdS8R3DnxebdofRd
	 UuJ17y7esQZhpPPUWFCcxNyZcKICwXV1rPSFr87GjpclavvOYglW/2o2Z1VugUMv24
	 jKR93cRj5WYoxDLD9sIxGhdmiHrqvrE3HzrlGPjX0fMy/0bAdzJSZPhE+9G52YTxfs
	 XcAn2Iig0/CfhJT9cBnJlu42RRbjirVtoh68PUopfGcazzfmjA8TR0eZ/psTN219+O
	 wUPPvBUjuNWJHauvJG4lCs4PIwK2p79Y9jxSUB3nTU7XymCNI61Ea4KHJUrxE+Ifx0
	 wj6E7JEQ8h0bw==
Date: Sat, 30 Nov 2024 11:07:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com, Kuniyuki Iwashima
 <kuniyu@amazon.com>
Subject: Re: [Patch net v2] rtnetlink: fix double call of
 rtnl_link_get_net_ifla()
Message-ID: <20241130110734.354f73d7@kernel.org>
In-Reply-To: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
References: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
	<20241129212519.825567-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 13:25:19 -0800 Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Currently rtnl_link_get_net_ifla() gets called twice when we create
> peer devices, once in rtnl_add_peer_net() and once in each ->newlink()
> implementation.
> 
> This looks safer, however, it leads to a classic Time-of-Check to
> Time-of-Use (TOCTOU) bug since IFLA_NET_NS_PID is very dynamic. And
> because of the lack of checking error pointer of the second call, it
> also leads to a kernel crash as reported by syzbot.
> 
> Fix this by getting rid of the second call, which already becomes
> redudant after Kuniyuki's work. We have to propagate the result of the
> first rtnl_link_get_net_ifla() down to each ->newlink().

Two process notes:
 - please wait 24h between postings;
 - please don't post new versions in reply to an old one.

