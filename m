Return-Path: <netdev+bounces-216217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E3B32987
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C635C1B6A
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D42DC320;
	Sat, 23 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="QtrMJBR/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrFJ39QL"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26E293B73
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962486; cv=none; b=Jt55XPZ7jgwDRL5P6H9lVrb/m3s/Wx8Ds0vpULHqoAXG8cxRqQCxkldQ4XEAeOJ6/W8wVt97lxSxUehi8N2Wlk2LNAX2oQe13bJIQi0EMnHUtorQKiYzL4mBW3NZNJkhpVfA+cttyzhzMAKywt/mRhXwK0ARePzX/5ZncYkXJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962486; c=relaxed/simple;
	bh=MlNZF5vIrg88WDM3FKHIV6iH+1Gk1QyAh2wFWXhYYxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BAFskqfIWKL1MEXHMwcZBwcak13Vf3wADTHJxQo5fJ+7dpS7rJ0AxW5lrJg6d+sH2kIb4d1xgDblZEfcPy45ScVlAo8Idpnj4BTOex7Ca3Vh8p2mdtddmzK6C6TOHl+yVTsVpzUkxaMvN7XQNBwAs2hHKqP552hWKdDOeZO8Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=QtrMJBR/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrFJ39QL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3628A1D00053;
	Sat, 23 Aug 2025 11:21:22 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-11.internal (MEProxy); Sat, 23 Aug 2025 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1755962482; x=1756048882; bh=3YzzoaStgTMjIplLfwP25H3ce0c0LGzk
	DJtapkst03g=; b=QtrMJBR/W+OvTYFCCCHDTuZtPULeCxN4ftbgcopNMBXILJ/k
	I7CnLsIYG6iNCR/rSp5xA9C+aIZHx4IWwAK2LaQMdh5V9uFQNiAj6ElwA5GwxkLw
	LCD1GAyjjyQiD1/EMm6fJQ40tHtk7qARX7OMM6GL4e1SBd9d/jkVcdT9/2jr9DhL
	NbBFrUVKoR65VgsCa/L82bY0E/fDq3ZIYoE4gHrfEenzsC3tS+5tYRji3V6GmMxi
	1LVZ9Fnd71epKqsgaG8jtovtGX8QkggR6C9fa+ZIuMMfR+iXTEh1T1pbBFDeZYxq
	hhZJR1+AQfijnimcz/SsEoDmuGSK+KXfTf9UEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755962482; x=
	1756048882; bh=3YzzoaStgTMjIplLfwP25H3ce0c0LGzkDJtapkst03g=; b=H
	rFJ39QL6m2Ebv0MPj0fSmuZqTI1DX7XO2pSSmyzf9Z/Uc1bDRPAaUCiSCToTFHpB
	G6T7a+yrsvhJJ7BVaPyaHFRScG0s2SyniJPazKuHUN8kO04Mu40qTro4oLgR49Y5
	wWpDuXt+yGjmfHUrGh3ZZ4eAXK/1rfw/I3ozfJPZgRuVf4TetMKa3fgFDDu8nQZ1
	m1krPQV0Fl9d5/qP+hhA3+lG95QC/d7SZiEdyePouT4uDs/le56haYsnUrPWoSXb
	hOwBWbjt8kuCFqmUwJATQSztKXofTLN+H/Tvbee1NF7jmMBWMzuTTYkaECwmLdW5
	Kvxly5ZOBpskMsintDjHA==
X-ME-Sender: <xms:cdypaOIxZHOKyteXFA0wFdsUJ_OTfz73rdth67BB_yH3PAJrmiNAUw>
    <xme:cdypaGJlyGYaLqdXXhzw8Wo8J3YiINkaAP5Nxs9Fzw2-IfwwPf2XHYMZW8Gy-Q7ke
    ewamOpbObZfTbqulmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhohhhn
    ucfgrhhitghsohhnfdcuoehmrghilhesjhhohhhnvghrihgtshhonhdrmhgvqeenucggtf
    frrghtthgvrhhnpeelveejgfegtdeggeethedutdeifeffveduteelieeiveeliefhhfff
    uefgjedukeenucffohhmrghinhepihgvthhfrdhorhhgpdhmrghnjedrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesjhho
    hhhnvghrihgtshhonhdrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrghilhdrtghomhdprhgtphht
    thhopegurhgrfhhtqdhlgihinhdqqhhuihgtqdhsohgtkhgvthdqrghpihhssehivghtfh
    drohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cdypaJTkQSGNGKRebCxfeWAaJOkUAUhqMZt7xlfvBCmUo-5dTAQNmQ>
    <xmx:cdypaJrGPNdfjYDnizfHVmUnTbIFjKapwWaUA22WxwyegJOY2GwoNw>
    <xmx:cdypaLxs2OvWKukBKcprdehNwLQHORVSWDU_EoAK94wrjkfV4mUI5w>
    <xmx:cdypaOI9-o_Oe0eB7o10AW_MLaVJEoskacZpgjJ6QGstJQSZJ1gpjg>
    <xmx:ctypaIezFMPlLTKzUML8zdGj1drIzaFcgdRYTu5ehDr9fVs8koj629vy>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC856700065; Sat, 23 Aug 2025 11:21:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsYvG0Y22C5R
Date: Sat, 23 Aug 2025 11:20:31 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Xin Long" <lucien.xin@gmail.com>, "network dev" <netdev@vger.kernel.org>
Cc: draft-lxin-quic-socket-apis@ietf.org
Message-Id: <cb74facd-aa28-4c9d-b05f-84be3a135b20@app.fastmail.com>
In-Reply-To: <cover.1755525878.git.lucien.xin@gmail.com>
References: <cover.1755525878.git.lucien.xin@gmail.com>
Subject: Re: [PATCH net-next v2 00/15] net: introduce QUIC infrastructure and core
 subcomponents
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(Note: This is an interface more than implementation question --- apologies in advanced if this is not the right place to ask. I originally sent this message to [0] about the IETF internet draft [1], but then I realized that is just an alias for the draft authors, and not a public mailing list, so I figured this would be better in order to have something in the public record.)

---

I was surprised to see that (if I understand correctly) in the current design, all communication over one connection must happen with the same socket, and instead stream ids are the sole mechanism to distinguish between different streams (e.g. for sending and receiving).

This does work, but it is bad for application programming which wants to take advantage of separate streams while being transport-agnostic. For example, it would be very nice to run an arbitrary program with stdout and stderr hooked up to separate QUIC streams. This can be elegantly accomplished if there is an option to create a fresh socket / file descriptor which is just associated with a single stream. Then "regular" send/rescv, or even read/write, can be used with multiple streams.  

I see that the SCTP socket interface has sctp_peeloff [2] for this purpose. Could something similar be included in this specification?

John

[0]: draft-lxin-quic-socket-apis@ietf.org
[1]: https://datatracker.ietf.org/doc/draft-lxin-quic-socket-apis/
[2]: https://man7.org/linux/man-pages/man3/sctp_peeloff.3.html

