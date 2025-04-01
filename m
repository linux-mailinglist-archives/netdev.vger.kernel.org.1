Return-Path: <netdev+bounces-178689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D5A78405
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D85618909B2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43DB20AF77;
	Tue,  1 Apr 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+oXQbsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E551EFF96
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543016; cv=none; b=tlK/vCCue5VOZsPMM54T2RS1kCJW9uX3lCC3oKWWegmXnjpw7G9mhxHFHFVEfrDWrgGa9giPjYR6aIporn7pxsns4+I2VWbRp/bI3d+wzvTsIYw1lkHBkzvKpkmhuy+U5wPxy+O+94jCi1gXUSCEvzcX+MR8fA3eRquvvtxVBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543016; c=relaxed/simple;
	bh=3T6senwk4kmjD3k4TYcRopBQIBs+dg6rxgGdS3SkxJM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfW1t02KdVnCLpsA1O4tXjuSMoLHxPJ8uZ0BT2YA4uOaAXcOf1US71MgrmzGcP6MpGGb7pnVKttoMkqa6Y100juPNr8OH0naltirphe/RKz3DSPgocv0Tl1fBSD+mVMxh6z1x+D5cuFKpRnM33A4wjnB9dyvYPFEDTXy6Z5qkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+oXQbsp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227aaa82fafso117621215ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743543015; x=1744147815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/fSpXDjzv9lRFDd8D9PPZpOC7fC5+qSFEn/Fu2i7ro=;
        b=e+oXQbspWSTndfmIcXZblZ7A4KF2ut4B4a+Wi4d/SU5wUzJfNZCaCVsPuVyfi3rWv/
         FjX0VXGg3VgctyBcGhGeiNxVtuCb49EwrI++el5ajHteixWDAyn+B4vqD7rc6v5bWb9y
         Gl4rN7dELS1D6Z1gxaNa2GjaxaRwyUt6DCvNN424+OqvlPBlmrhTeqE6kjV2bEghRBpt
         A9bsR/7iMGLURccrc+NaugecHtH177ntl2hCesibVUVT/05KlTuNFTtsA1TMx6M8FAFE
         ZeqHwNjrToAcIuWyAgEROcoDzj8rn5iw7meAp2IOq1o96oJ81jwZ5oX3ZL6auK0knq7l
         hQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543015; x=1744147815;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/fSpXDjzv9lRFDd8D9PPZpOC7fC5+qSFEn/Fu2i7ro=;
        b=Ak9QZqnwovivGCjhBqIUC0L0c9inY/uVNSluN3DgkuffewRdyrnNQzx+C2kR5q/ZrF
         u7ES/TcPt92UwtZeXCBeoqypwTkkMYKsclyjvfwlaKgm4s77naWC7beHud4ykr3tSn8g
         XoVZVi8vg0CWt9Pndp5mly6PTChCZKHB7cDObr68/LJ3smGyRQsOmXJmr1osHcmr4LeV
         osv5ALDj1t0v7z3d652bfnNQ6dzSBtH2uA/n1qZ+yIhR/aRUOrqegG5WGd1dXGZp8Grf
         9IfInkJOyNMUXNYB2UiCzArwvFvkOFm0Zqs8brLGakhmDWuZl81VehlWiIxAPyGu8LP+
         hvig==
X-Gm-Message-State: AOJu0YyBI1LANHIjjc7n/YzvePmSUGeTvDztXnYYCLliIwJBjOv7LT12
	jwS1P6hvWncO7DJPDc9aO4JU89f0hGOvVF4E/JLXkApatPR1VX9x
X-Gm-Gg: ASbGnctV8IX04ia7aijZXj9qKAJYjcD+ZfSAtOeABtBwy1qwh4ONVIOkWPC+mysTwXV
	9lsldlnxuJqy7Bos/rVsvOh1PTZEL7Y4n9p5OGa75PZfxWJOBOrfbdwSH8dq+FHOWMH5hakLYia
	Rx+yIXNZA2ZMr0TwlsA2jB8VO4nwJGJm+TEFohorT2pbCFa5h5GVqOjyGM+Fmr5UMk3RXoXVmVN
	QLn3Q/UkjwR8QJHffilfI4/LqXSkhcvtCBWg13pAjpP/ctTWxCW3BGugBtH5oM2doa3Wedl2D5j
	iSQpUKF7NMUp5WGvfq3dDjwpWKIwSYvYJ/fIwAGKxJiSckAZBd16yxKsFQIwvSDcIzwoLsso866
	vDd4=
X-Google-Smtp-Source: AGHT+IEL5ZmF6gw8On6RjZDTO1j4Npd+KuixASNNeWQWRZY7yeX0HfyE0tJfwvjioEn990GUWwdiyA==
X-Received: by 2002:a17:903:3d05:b0:220:e1e6:4457 with SMTP id d9443c01a7336-2292f974b94mr227174965ad.26.1743543014529;
        Tue, 01 Apr 2025 14:30:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee0d37sm94492275ad.91.2025.04.01.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:30:14 -0700 (PDT)
Subject: [net PATCH 2/2] net: phylink: Set advertising based on
 phy_lookup_setting in ksettings_set
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com
Date: Tue, 01 Apr 2025 14:30:13 -0700
Message-ID: 
 <174354301312.26800.4565150748823347100.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

While testing a driver that supports mulitple speeds on the same SFP module
I noticed I wasn't able to change them when I was not using
autonegotiation. I would attempt to update the speed, but it had no effect.

A bit of digging led me to the fact that we weren't updating the advertised
link mask and as a result the interface wasn't being updated when I
requested an updated speed. This change makes it so that we apply the speed
from the phy settings to the config.advertised following a behavior similar
to what we already do when setting up a fixed-link.

Fixes: ea269a6f7207 ("net: phylink: Update SFP selected interface on advertising changes")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phylink.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 380e51c5bdaa..f561a803e5ce 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2763,6 +2763,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 
 		config.speed = c->speed;
 		config.duplex = c->duplex;
+		linkmode_and(config.advertising, c->linkmodes, pl->supported);
 		break;
 
 	case AUTONEG_ENABLE:



