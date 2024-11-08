Return-Path: <netdev+bounces-143133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4849C13A8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EB9283D1E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10BBA4A;
	Fri,  8 Nov 2024 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="nuRj+//0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yoyb3ZZP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA438F5B
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029555; cv=none; b=ulOypKJqrgWv6vmFXwJEODD1ThoUmXESV33j6mPYmNCGyoUI9Yul+hKOOhXtj3nkAuAQbeSTJsNgo9KpTFuBRELofUY5Sd5eNvk1iaPP4DxuaS2eofYN5cS5wpd7SDYClFUWt2DnL2wSibPspnVkUEzRMSPyYV5D+ntvQPLIAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029555; c=relaxed/simple;
	bh=/dBC+RBXX3/4aPp0iqkKL4aA9xia1nrMaFjKD2f8LlE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=IYqcAm3f6sBqSuOj0xiGi1hzz+VbShIByMWky0ejXiWsw2qOv5zF9ENZ8IwDASsH9j3dTzLJsJGLx6gY4FhESbqSw65hPt5g06kirC3SVqOy5nWDUJozmdO2GfWb0aXtNAVw5CdmrtL3WnBQePWLovFdWy2MVrecyHIlSrfb5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=nuRj+//0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yoyb3ZZP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 915B92540090;
	Thu,  7 Nov 2024 20:32:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 07 Nov 2024 20:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731029551; x=
	1731115951; bh=mczvRC/1b9w9EWAZs3inFwaLV/Y06dBOnTy23E2LIQc=; b=n
	uRj+//0IgrP1T1wJetA3732f0/IoIN7qetVLglcD/3awuGtnTtcoCu3SAg+PuL/Y
	WKHeyUUNPBtW5DPwcBa55hsD9QVUKOqM+t4NYQoBL0carun1iAiATy8oIz8DVJhW
	Bmf/0lzI8eJ2JILHYhdszVBZz6QqNzfN8td54t7Aa3FGyd1v7C96QB6ZU7yXdedw
	V4V0mb0n9QpDQ3o587PLMM2QmBthRW8UGa0pYGeV1GVbGwZVhvokBVE7m/2oIZiy
	ZgWXfdmEJ7ezTLQ9uhmJ4WasK7m6VMZmI8wqQTzHT8Pjg6jgUrKOyqBzW1kUYv1J
	fH98C0VovFH5UVTuLzN/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731029551; x=1731115951; bh=m
	czvRC/1b9w9EWAZs3inFwaLV/Y06dBOnTy23E2LIQc=; b=Yoyb3ZZPbvYmjj53B
	7720O7ySQmJw8r+QoFxOMiUX6ikI/U35PYtooSnBXKW+2NV4wTp/sKCqfTUSvmhd
	KXSsJOSJE2JmWM5/ISZT35EvR1vQTkJcmHvTTmNZ5Bc/F7P1jNCDVjbrUp+lLaec
	nYWeEIFNoHPyyU5UijTvQzQi6IYIYVGlLALC+66iKgDft2z6QZgPg5oOp/4oQL4t
	7Zxc4wBsNxwoGhwoTNov7p5N9ehfSp+25MGcqxQS/ZP6Rfl7/OdAI6llh0vQsAoO
	nCZLgJWxKxa3o6DGLbFUOO5iUULrNluDUM7QlRTWVF8SaPIf6q+keKmMbHtjq2F6
	6BVPA==
X-ME-Sender: <xms:L2otZ5asxpO_VjqT6KUPHXJOE18UI1kC0jamxwuum6_MCfbftgy2fA>
    <xme:L2otZwZc5OAxxOV_TF_744ogT2B5CujsqsZUPFZhG3DbBWLBEKdAwtPeL_HR9Yku6
    97GSOt0ImdiQ4mWD5I>
X-ME-Received: <xmr:L2otZ7_q0Ox2r683ShYztv354mcQQq2-yQy85NZFHQdK7UZMFo0i3R64KadyTY4u6d-8jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtfffksehttdertdertddvnecu
    hfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvth
    eqnecuggftrfgrthhtvghrnhepjedvgffhteevvddufedvjeegleetveekveegtdfhudek
    veeijeeuheekgeffjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:L2otZ3r50takJBz9ifyggCsOPT66NMZQw7F2LaX5vDjSHZlH5nvKcw>
    <xmx:L2otZ0qZswhyZ03sINsdXodMSQj8m_TG4L4fPli7zoMS_Tr7JkHaFA>
    <xmx:L2otZ9RcTw38uAY3LwEnQGDSq4HOpkBzew_O2NtEw53yCRYacmcxjg>
    <xmx:L2otZ8qPPtaex6awljMKmwkoWsA4hbUuDf48VQDod16tDbMCUaBY_g>
    <xmx:L2otZ73F2IX-K7-5OujGAazuI7oC9J3wb5aeQzX-5C5VxOxI5VAqTn9L>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 20:32:31 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id BDE9B9FC56; Thu,  7 Nov 2024 17:32:29 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id BBB8E9FB62;
	Thu,  7 Nov 2024 17:32:29 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
In-reply-to: <ZysdRHul2pWy44Rh@fedora>
References: <ZysdRHul2pWy44Rh@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 06 Nov 2024 07:39:48 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <316684.1731029549.1@famine>
Date: Thu, 07 Nov 2024 17:32:29 -0800
Message-ID: <316685.1731029549@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>
>Our QE reported that, when there is no active slave during
>bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
>will flap the switch's mac table quickly, sometimes even make the switch stop
>learning mac address. So should we consider the arp missed max during
>bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
>before switch to another slave. What do you think?

	Well, "quickly" here depends entirely on what the value of
arp_interval is.  It's been quite a while since I looked into the
details of this particular behavior, but at the time I didn't see the
switches I had issue flap warnings.  If memory serves, I usually tested
with arp_interval in the realm of 100ms, with anywhere from 2 to 6
interfaces in the bond.

	What settings are you using for the bond, and what model of
switch exhibits the behavior you describe?

	That said, the intent of the current implementation is to cycle
through the interfaces in the bond relatively quickly when no interfaces
are up, under the theory that such behavior finds an available interface
in the minimum time.

	I'm not necessarily opposed to having each probe "step," so to
speak, perform multiple ARP probe checks.  However, I wonder if this is
a complicated workaround for not wanting to change a configuration
setting on a switch, and it would only make things better by chance
(i.e., that the probes just happen to now take long enough to not run
afoul of the switch's time limit for some flap parameter).

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

