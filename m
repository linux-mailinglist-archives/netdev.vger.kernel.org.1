Return-Path: <netdev+bounces-248381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3ADD07860
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FCB73004789
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01862EB85E;
	Fri,  9 Jan 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFurzW9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB202E22AA
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942731; cv=none; b=I7+BEMgq1d1y7rU9wBOOCbZRTOsPLRcYq7ZUy/TEWFd4V4xC+NOMpun34URTwuycvwmYkoOBLHTKJtr73HkQ4LtcEUwU9K5tH0JzVHmR8b1+oVVHdpGaFjCaQs5fVp8KFDlx7o60cRpWuVAVUfqoDoSyORfq54pYtzqx/aGYTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942731; c=relaxed/simple;
	bh=V1rQXE+eUN7DNfjhzRLAFHimoakueJkcAJTWHiBBUA0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bEnahawsXaGDnZCvYTIrHNDb5gynEipzN+VhkqlitCT+0/jfYA6fvCxwR2eJkhonoWVg+8ePnDIbOKc9NQi88o3vmia58JwHIS1/sS9QzrG/dduZ0M11aOtjQdae5F3GlGr1/VbCwvByZkd3FEeITXhw+dW6sXKSrc4n8U1ttXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFurzW9l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so21996675e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 23:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767942728; x=1768547528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxGn5/OE39MpZemngI+D3oZNq6iEFjmHB6+jYLQ2MgA=;
        b=iFurzW9lf8vHiocHVlXzIedL77thvEJjhVfks9n1OByQ0nZkRuBJRZV+CDBap11hpr
         BYfYZ63EfhyghaQ/0zLcuq1uqRY42hwaDJ/IfT0AQODEnDYKACXxrtU+5sEPmlHo7lTO
         PQBVls6fnUeTrYWD+1Tg1P3v8D1y2CfZXukpohx5ghfa098HwwFpIMT8mU0Vp/VCU/cX
         ZHocCKRH6/wfMZUjgv7ZnOeAnc9UlgZ3YtUoPnUlbVM0OWyShshzTYwEhc7sLavuTxNf
         v7HFVEE34Lhf7CDx+n0RO8aKuBbhMPgl8+YFlTZmGk1X+92nzb1YzaQDxaIBawvZXSp6
         10Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767942728; x=1768547528;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxGn5/OE39MpZemngI+D3oZNq6iEFjmHB6+jYLQ2MgA=;
        b=jf9Y3h6YOxI3MR6yThuQafQvrmbPIWXXNh3i8OYqFPb4X6QqHZ3c0GBAepTUbESul1
         /UbdcrjUoOBGsuWg6WB1R5zodkvDwQ67QcMbLMLJqCi1AFwOlc84N6MkbclqpKBwWd28
         IQX5k0jf3b/OLzdGC8N/afobBXsnes7nMAD3JMaayjVt/VzgnDJc5btl0pOnWNSA80/e
         1URBycaeZuzvrVuJ8aHEcK7vOh6Izx+6iG4vwONbajFp0jyyCBjgReXLmmorm98NOGIi
         RgEJWh1KzUdSdcrMRfcthTmNhPgfmwNxRUbaZNCnfAh9LZepl4LdHgAf2X3PXHdm10jn
         8+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVO4NkZeV4/oQtpegMMyTuQYUiL4IlzFP4LTajevfL0OXdOdNJ0jl/piXnXfDdOY1ug/wL2L7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1io574yakS9SCx2HHbQ2t9SauDiD1W9bnQCMLBlFzUSt40/s
	nSazwdlgvBj/tdig7lZ6+YEs+APmcG6QGNlBJaLsfvOXFj4EXj+gzYL4
X-Gm-Gg: AY/fxX7GSaVS5LiR3cQm4tCMtGrNQowL6SIwoCnCzpFHadFsN2oi3s6hKOyuWASCgK4
	DMXizDUO4Vxd6Iuy74I/jQOYuBD9Qd5kF6a9qx2VGPSNfky8c8XzCnIwkcEODOORqjXTWr1RkaU
	8JBaUTV0u+mL4PdQFkvm42bpmcIV+Qz+01AT/kGlmpgMS+cV1NArieye1hliaGBWpMsWCwAwTfj
	gWlVpj2tCTTV4ehNNvtsEMmOnQvxke4ZV6WFyv6hZvl96KTXhIsjPh3mHf3py85yx6k++XefluC
	5V+VDLoi1QcSMEsSIitNKBAlrJ+DEE5leoKGOFQLADCqtSBSCslWrE42S3aFoXxn3RkIcBKSYYq
	OJYdNs2Dh86IBSmAN6J0dy4b12zWaNiJv1gdtUO50uw6Hsv7wCf+OaKG1L7sfwJfvPZx6JgQQeP
	uTrHuE2BOOnc4lG0c4gjlGtTJ0ChFkiBUBjg==
X-Google-Smtp-Source: AGHT+IEXchnztikZ6TBC5dh/zTMNJS+2BRCBmoom+2odvuMesN69tQriWc0PXoqqOi/s946zAImISQ==
X-Received: by 2002:a05:600c:458e:b0:47b:e29f:e067 with SMTP id 5b1f17b1804b1-47d84b0b21dmr91582815e9.6.1767942728137;
        Thu, 08 Jan 2026 23:12:08 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm20360905f8f.4.2026.01.08.23.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 23:12:07 -0800 (PST)
Date: Fri, 09 Jan 2026 09:11:58 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Slark Xiao <slark_xiao@163.com>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>, Daniele Palmas <dnlplm@gmail.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Johan Hovold <johan@kernel.org>
Subject: Re:[RFC PATCH v5 0/7] net: wwan: add NMEA port type support
User-Agent: K-9 Mail for Android
In-Reply-To: <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com> <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
Message-ID: <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 9, 2026 5:21:34 AM, Slark Xiao <slark_xiao@163=2Ecom> wrote:
>At 2026-01-09 09:09:02, "Sergey Ryazanov" <ryazanov=2Es=2Ea@gmail=2Ecom> =
wrote:
>>The series introduces a long discussed NMEA port type support for the
>>WWAN subsystem=2E There are two goals=2E From the WWAN driver perspectiv=
e,
>>NMEA exported as any other port type (e=2Eg=2E AT, MBIM, QMI, etc=2E)=2E=
 From
>>user space software perspective, the exported chardev belongs to the
>>GNSS class what makes it easy to distinguish desired port and the WWAN
>>device common to both NMEA and control (AT, MBIM, etc=2E) ports makes it
>>easy to locate a control port for the GNSS receiver activation=2E
>>
>>Done by exporting the NMEA port via the GNSS subsystem with the WWAN
>>core acting as proxy between the WWAN modem driver and the GNSS
>>subsystem=2E
>>
>>The series starts from a cleanup patch=2E Then three patches prepares th=
e
>>WWAN core for the proxy style operation=2E Followed by a patch introding=
 a
>>new WWNA port type, integration with the GNSS subsystem and demux=2E The
>>series ends with a couple of patches that introduce emulated EMEA port
>>to the WWAN HW simulator=2E
>>
>>The series is the product of the discussion with Loic about the pros and
>>cons of possible models and implementation=2E Also Muhammad and Slark di=
d
>>a great job defining the problem, sharing the code and pushing me to
>>finish the implementation=2E Daniele has caught an issue on driver
>>unloading and suggested an investigation direction=2E What was concluded
>>by Loic=2E Many thanks=2E
>>
>>Slark, if this series with the unregister fix suits you, please bundle
>>it with your MHI patch, and (re-)send for final inclusion=2E
>>
>>Changes RFCv1->RFCv2:
>>* Uniformly use put_device() to release port memory=2E This made code le=
ss
>>  weird and way more clear=2E Thank you, Loic, for noticing and the fix
>>  discussion!
>>Changes RFCv2->RFCv5:
>>* Fix premature WWAN device unregister; new patch 2/7, thus, all
>>  subsequent patches have been renumbered
>>* Minor adjustments here and there
>>
>Shall I keep these RFC changes info in my next commit?
>Also these RFC changes info in these single patch=2E

Generally, yeah, it's a good idea to keep information about changes, espec=
ially per item patch=2E Keeping the cover latter changelog is up to you=2E

>And I want to know whether  v5 or v6 shall be used for my next serial?

Any of them will work=2E If you asking me, then I would suggest to send it=
 as v6 to continue numbering=2E

>Is there a review progress for these RFC patches ( for patch 2/7 and=20
>3/7 especially)=2E If yes, I will hold my commit until these review progr=
ess
>finished=2E If not, I will combine these changes with my MHI patch and se=
nd
>them out asap=2E

I have collected all the feedback=2E E=2Eg=2E, minor number leak was fixed=
=2E Fixed one long noticed mistype=2E And collected two new review tags giv=
en by Loic=2E So, my advice is to use these patches as base and put your MH=
I patch on top of them=2E

>>CC: Slark Xiao <slark_xiao@163=2Ecom>
>>CC: Muhammad Nuzaihan <zaihan@unrealasia=2Enet>
>>CC: Daniele Palmas <dnlplm@gmail=2Ecom>
>>CC: Qiang Yu <quic_qianyu@quicinc=2Ecom>
>>CC: Manivannan Sadhasivam <mani@kernel=2Eorg>
>>CC: Johan Hovold <johan@kernel=2Eorg>
>>
>>Sergey Ryazanov (7):
>>  net: wwan: core: remove unused port_id field
>>  net: wwan: core: explicit WWAN device reference counting
>>  net: wwan: core: split port creation and registration
>>  net: wwan: core: split port unregister and stop
>>  net: wwan: add NMEA port support
>>  net: wwan: hwsim: refactor to support more port types
>>  net: wwan: hwsim: support NMEA port emulation
>>
>> drivers/net/wwan/Kconfig      |   1 +
>> drivers/net/wwan/wwan_core=2Ec  | 280 +++++++++++++++++++++++++++------=
-
>> drivers/net/wwan/wwan_hwsim=2Ec | 201 +++++++++++++++++++-----
>> include/linux/wwan=2Eh          |   2 +
>> 4 files changed, 396 insertions(+), 88 deletions(-)
>>
>>--=20
>>2=2E52=2E0

Hi Slark

