Return-Path: <netdev+bounces-178079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6250EA746BA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB47165BF4
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C7214233;
	Fri, 28 Mar 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="B/c4or1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12142A97
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155919; cv=none; b=QYLpN83DEXtAVTDAeI7Nr0yolPPVvjrv2Yd9IDq49tm/ILQK6Q6zDwgoEOedZVN71KPwJvgiXLb4OFLBsju+tikNGXuNlT3X+1rA+jRhFXvvHR/ELlkAHlcefTmADR/CwbczyOex8egdIaHhvIU3GSUjk9WMZ24ofG1d0tC/P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155919; c=relaxed/simple;
	bh=Oyny21S+sLeKaXTP/0stQMGI4J+EhP6JMNALuIHA8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPW5vnyG9LjkXac4hojpyIA3N8YE7Y3abs9Uw6phLxWiMHAGtadv29Ud6eX4sGimUTm+5eihMQBErIMBALteizBHp/995rq+OadjuQAzrd54yDd+N7Z1KJMmwlU2pZLlN00HVLv3spg1h9WSxWSRQxeM4gPtj1THW9i1eKrPgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=B/c4or1Z; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-43ce4e47a85so2478015e9.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1743155916; x=1743760716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYaSHKfPPvwLjiP2xQ7+MgpWxbp4Ml/lTFTHT/Sinog=;
        b=B/c4or1ZnUjMtbMMNAE8mNowPJ3lWBkTAzWsghwtAdRYMM1mJMKicm811xkPOoiBMn
         fcvupYoNhGDejw4OQoT+RzC8LLBXVjrGJZdu6lsNJOape2werNds9koNYuheBzhdYmij
         k+sxJ7pMBrFzimUC1tuBSrShoO6mX0uK3GqW5kPgA/w0yR1x9WVrdu8zjv8Es4koZEEX
         xdqy7junR5QBJEGM8ec7Cr6HxxtHkHpbg8MYUURL+oiRFvFBoDbLxFhP0TqJH8qdg6Dl
         d8u2mm2tV0kPTSUoDOJ2FBR16QvRNic2ixpT70EBvl3c+WkFMcI/TkZeXhpUvDRvs61D
         +Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743155916; x=1743760716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYaSHKfPPvwLjiP2xQ7+MgpWxbp4Ml/lTFTHT/Sinog=;
        b=BVqkMaIJmGbcpAu99nTwGQ0kBIYNk/ufU+tqt66+PuleBzk0gxmn5FfrHEJY1N9wvM
         /vaJ++H4kODHB+nRnCHDqvJ4xWoTMjbXDV8+q47rvmMtk96nGkqf/oYRJurQbCmmAiN6
         0hbRrWsupZ/yzxUEX6q2CjPy/bMlNOfachrZitUmvYyKvo0xuavZabgcP8RHwnRFpdnh
         SxyGXNX0BAX5NguQfiKgAwEad2hCrEjo/OVAeTjGd/vCqmGyDOPOiSgYeV5fFsu82SUm
         lYSzByC9eMLussp4nyJpCSnSaAcWhEAOMPtoOzkgnp/ETxS+EECyO8EYhnYdUUSA6CAx
         awzw==
X-Forwarded-Encrypted: i=1; AJvYcCX2qbZ1RUtXNcK412tUUwOV9pc6Ow16au/P0xAtHJicu/Ae7M190zYa8JeYdf+0APb2zXJ4vtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBibQNPjUH1mAac0s65ww4T4Ql+fxb+l+VX2/cpyWZHD01ka2
	WEeLtS8KVraG87XfsBW7Kdn5+dSPJCrplPQ3d4rfNL+1nGYZS6gzd3f3qwjZm8l9TH+AN96bAEl
	EXIksCJzyd5hoM8OdyfS6Ig3Vs/dztRUR
X-Gm-Gg: ASbGncvYC4LLhoE8y04iaqfB/n+9L3pQcN3gTAAe91eSrkPBUSUBMJq7QSp/vsJN6Fi
	YE/L6k40Po/g7bNcGUttHNA1+8qbIsTdWJaoknkPudINWgleqt9k2OCq3SH/NO+pI7lIRUjWH36
	8P/bK5QnLiKtmQzUr3/elAmQG9KsLxVeHM8py/Nppza2Y+f4Qv9QbNvikKkqYLRTJYysll/JP1F
	34HZqIMR6Gepexg9f8K3UsH0lxkL1lN3huvJExgslmH6NwN+TX0V0URqcOZ8fCsSXONeMeYjurK
	4BGbTrXhlPzY7SUobMP+E/YXEwq5R756FSkuksy+RL4ndTeyqzGJ0Kuue7s2cHGrQyzM21c=
X-Google-Smtp-Source: AGHT+IGkBFYaOUlFvyfoqRX+gm6raQgjrDsChcQXSb27cCdnWzJ8fnh7s8EUHkDfFNlDNNnSadGfyUIufC+A
X-Received: by 2002:a05:600c:3107:b0:43b:bbb9:e25f with SMTP id 5b1f17b1804b1-43d866956d6mr22824725e9.6.1743155915771;
        Fri, 28 Mar 2025 02:58:35 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-39c0b65e4adsm85134f8f.2.2025.03.28.02.58.35;
        Fri, 28 Mar 2025 02:58:35 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 92F99284CB;
	Fri, 28 Mar 2025 10:58:35 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1ty6Tz-002xj8-BI; Fri, 28 Mar 2025 10:58:35 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH iproute2] ip: display the 'netns-immutable' property
Date: Fri, 28 Mar 2025 10:58:26 +0100
Message-ID: <20250328095826.706221-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user needs to specify '-details' to have it.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 ip/ipaddress.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 70b3d513e510..91d78874699b 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1182,6 +1182,11 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 				   "max_mtu", "maxmtu %u ",
 				   rta_getattr_u32(tb[IFLA_MAX_MTU]));
 
+		if (tb[IFLA_NETNS_IMMUTABLE] &&
+		    rta_getattr_u8(tb[IFLA_NETNS_IMMUTABLE]))
+			print_bool(PRINT_ANY, "netns-immutable", "netns-immutable ",
+				   true);
+
 		if (tb[IFLA_LINKINFO])
 			print_linktype(fp, tb[IFLA_LINKINFO]);
 
-- 
2.47.1


