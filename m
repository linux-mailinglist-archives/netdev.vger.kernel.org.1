Return-Path: <netdev+bounces-100324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311648D88E4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFE7282610
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2591386C2;
	Mon,  3 Jun 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGvZ2y6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE2F9E9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440571; cv=none; b=jI7FF3i1WGgcbzy7auahDc08d3Vx6smokXNNje/l7szhyMFoCGVdzDaBq7hfCDdhgCg4rAL9mDLBGnAMVFrvnE1W0QijYR+mpUXSXbBN3QEKcE02/Rld0DqLRlydIqHEClGahyig2Y0puW7jNpuP6+tmrtJik5pHtRGp56c14tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440571; c=relaxed/simple;
	bh=i1jINBwUJnIY9MwYvhfr1JYrXe/V64u65gZCSAd7qW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwdooWCZ5SHMU5KFu0iowjJ1htPOJQrF6/fsCyNpbit98i1YNIC4IXaPV6Yj144g/pCGuym9iknU+MZYuWBCSp4FHqeXW8CsFcnPIOl8dpDq6p4OTs8zrNLa0TELED7L2fNFVnAYis/X+3y2pV2zb0RzFG8EL3Ndqeg716AbNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGvZ2y6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3043C2BD10;
	Mon,  3 Jun 2024 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717440570;
	bh=i1jINBwUJnIY9MwYvhfr1JYrXe/V64u65gZCSAd7qW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGvZ2y6E+tPPoz5+/PPwBvbKZOYMLJcMDbQ9j35b0I9zC5FSLX0AkKcIMjgcxykvz
	 E7pj15MWHlbzrLLt0O62Xs6GSzg5cPA7eDPM5b+1Nz/0aIRPa67spqyie7cE8s+yyA
	 dfcgzxrO/vcekbiCjnLtEv5dKUYL7lceGlpdGMeSIickVYHDb173hZVSh5n547ptcD
	 p61GNDGxhsFDZekt9BzWCgFHND0frJrDnyCFnHbb0+RRX5FazvXMXLLfk74cNYm3ld
	 2VTrBBz3sW+DnhDI8Rre5Ablcfj2/dbIsxJJnK3uDk+ll8NAz7ZkQ/at0dS8DF6i27
	 /Ns2VKyTMgQWA==
Date: Mon, 3 Jun 2024 11:49:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
Message-ID: <20240603114929.5db96e58@kernel.org>
In-Reply-To: <CAK8fFZ5S24+YqsTW0ZWCOU++ADzffovpty4pd0ZAVEba1RBotA@mail.gmail.com>
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
	<20240530173324.378acb1f@kernel.org>
	<CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
	<20240531142607.5123c3f0@kernel.org>
	<CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
	<20240601142527.475cdc0f@kernel.org>
	<CAK8fFZ76h79N76D+OJe6nbvnLA7Bsx_bdpvjP2j=_a5aEzgw-g@mail.gmail.com>
	<20240602145654.296f62e4@kernel.org>
	<CAK8fFZ5S24+YqsTW0ZWCOU++ADzffovpty4pd0ZAVEba1RBotA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 07:44:59 +0200 Jaroslav Pulchart wrote:
> > > I built the kernel with the new patch but still do not works but we
> > > might hit another issue (strace is different): See attached strace.log  
> >
> > Thanks, added that one and sent v2.  
> 
> Great! With v2 it WORKS! Thank you

Thanks! I'm sorry to report that I found a bug in v2, it loop forever
on filtered address dumps :S So I sent v3. Third time is the charm?

