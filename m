Return-Path: <netdev+bounces-202741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8EAEECD5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B321BC4301
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E571E5B99;
	Tue,  1 Jul 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEVu55Iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403E1DED47;
	Tue,  1 Jul 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339591; cv=none; b=ZqJxgynYHo2vChpHupDQfcVNgF79DJxsVQSLL5iOj6IZjTaec5Oq4Wzhc55eoANDNOE1Rj2yQkTQcDMPCfBn83SoxiMMB36zjtVtCLWKnAxE3TDVlqPPkFOqJZt0GIcredJgmFZO5RuHYnW1Bs9eDXE85Yr1Vdc30Dg3/QziLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339591; c=relaxed/simple;
	bh=TbfuqO+oiExItVVZKGu9k12YQAusqExdNOR9scGFVHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUV2IGMCvUHWVSWMPGepPi3kZKkK43iirGXYGdkiH5yG5MDZPPyXyTVgam0BQuNEMnse5mnd5rvt3rbcA+Vv2JnDpESsK/DcXH6HXouGXxYYQQ9b9pLT+CNxthyIeu7MPUkiYGcDEVajAT6yCL0XbfgP2pQj26rqc10OmXD3VlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEVu55Iz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748d982e97cso2865361b3a.1;
        Mon, 30 Jun 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339590; x=1751944390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvORWdGCiM2xqrB891WnMSm1ITtVfMmoaVxEh+eMh8Y=;
        b=FEVu55IzZBdXu1QeHdIy2ti/HukIIMMUl1UXjOSTTI2N9/+N/xhYFaMhmJ9h1KGBEp
         BXVUz8XMWnnsPMv2aXWivYBbVNqpd/B9iZ2XE9YB0Xx14vhvsjzsBgbushKWHA3xs4z0
         MbMzkK3cfpjWzSl25Ssv76C074xoqxqgk1RXAOnHfbPF7I0hvam10N0Cc1s9cHJuKDiU
         qERosMCbVENXbDlF/v6L3B8AfxNRhB7ABzJB10UpYJprIPI7SKRlEECQYRbDFoQpeeor
         p3EtPLL+QD4bUY+7b552qRmx3S9QkKwxgOLLFyT/yaxZCA7oL9ZoyHhhgHzV+iT4Gn2y
         HxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339590; x=1751944390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvORWdGCiM2xqrB891WnMSm1ITtVfMmoaVxEh+eMh8Y=;
        b=ZIH9Mp2ZsbnT/NK4+v6BndA/8PD14lBDH0lOMvdN2MHvrWobeejNYVeS1CB/jd4HoA
         KMRe3A/UFT6FTm6PijBIsJxL7P1WPaQHlvDDp6I5MwaCFPfkPd3C2gaLEXZS8eqh3ZBB
         IlUzuDz8UOFp9fceW4663ebVXIT+VZdHpYYGwrE22ncJzcx+5uwe04K5vZ71NwGzTknq
         aX/tr5tUsr0hCMte6uO88cIb64hdkPaAN90pEkz2xNUcCpzuUSiVD/8ULUTCD8YF2Daz
         AYv60xZvsdh92vOsZ0LCqO1A1/cB8TCHHKaFlfLee6AqflEC6y0EWHUkUWAQzkM3g+Fv
         WEPA==
X-Forwarded-Encrypted: i=1; AJvYcCWlH06m+dJrFS1LWHCAvhUhqBZ9ovAwJT5VWn4uOJigDTfeOvLrk1/JaWxleFAOfvWdWLb7DILcUnY=@vger.kernel.org, AJvYcCXs39QjisDDdqCESrJnJvEL/2mqyvGinvyW3rRPoRaHVtlfzcQNQ40pxYyhLaHrzTrDAhumpdzt@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgfvh6/I0mIg5zPkt811LL8MMFurLs9y7YcPLaQ0wt3qCiFRL
	EIpSg6WatnXilYC8SfbQ+LdW7SV0H4KInu624Behg7H5gF7fHyzRaTAm
X-Gm-Gg: ASbGnctyU43r8/no42Zhf7yF0kAx5lcO3AiQQGcUQV4I2pi+f3IWhQmJlto53MmZw7O
	O80QiYEeaPpXjdX+xBTh6XuMCQGCjFk9VF60Rg1M3WC+as2defvj7zbOgVw8UvlXNmpdMadOg2F
	oSv7fl0DU3SENbbtoBk6G+BL0y8NEY4WsrnWIYfb/nSKb3UINbyFaodCJaCzgWS++tcfvzQYKjq
	GHp3KIBdlYXlr2VqmyX/ZR7FPG4NzOI4Y8JQdDPFSsHhpoIJtuIOrr47dk6kDICaHdl9KpEj564
	awYD1ybH8ZyiMnZvQ1G7kA3WPpkcWvk58Yzx0jS6qArC7DpIqgtpRSPitDVzAt6h26PO31Pz
X-Google-Smtp-Source: AGHT+IHrIun90nUsKSinRDQkjpG4deLf+kKUcf0pr03c2rOVp5ieEfXjzdE9Z7q/EVTa8Jt3IwBNjw==
X-Received: by 2002:a05:6a00:2e98:b0:748:311a:8aef with SMTP id d2e1a72fcca58-74af6fcd65bmr22811809b3a.12.1751339589502;
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31beaa7sm9321476a12.35.2025.06.30.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 789B5420A829; Tue, 01 Jul 2025 10:13:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 3/5] net: ip-sysctl: Format pf_{enable,expose} boolean lists as bullet lists
Date: Tue,  1 Jul 2025 10:12:58 +0700
Message-ID: <20250701031300.19088-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=bagasdotme@gmail.com; h=from:subject; bh=TbfuqO+oiExItVVZKGu9k12YQAusqExdNOR9scGFVHY=; b=kA0DAAoW9rmJSVVRTqMByyZiAGhjT8ainoVz70j/ZB7P3IDXCKsb7JkvFtDJRbKy6j/h8lkjv oh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmhjT8YACgkQ9rmJSVVRTqP2ygD+PMA/ Ja59EPrN+q8DYrxcjWdCI04fWMsXRjFWWykRhzEBAMEQ41FD8CJqe805ZoojjBQ66hxgWD84WLF nNI8fKIcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

These lists' items were separated by newlines but without bullet list
marker. Turn the lists into proper bullet list.

While at it, also reword values description for pf_expose to not repeat
mentioning SCTP_PEER_ADDR_CHANGE and SCTP_GET_PEER_ADDR_INFO sockopt.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 28 +++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6c2bb3347885c3..774fbf462ccd65 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3326,31 +3326,27 @@ pf_enable - INTEGER
 	https://datatracker.ietf.org/doc/draft-ietf-tsvwg-sctp-failover for
 	details.
 
-	1: Enable pf.
+	Possible values:
 
-	0: Disable pf.
+	- 1: Enable pf.
+	- 0: Disable pf.
 
 	Default: 1
 
 pf_expose - INTEGER
 	Unset or enable/disable pf (pf is short for potentially failed) state
 	exposure.  Applications can control the exposure of the PF path state
-	in the SCTP_PEER_ADDR_CHANGE event and the SCTP_GET_PEER_ADDR_INFO
-	sockopt.   When it's unset, no SCTP_PEER_ADDR_CHANGE event with
-	SCTP_ADDR_PF state will be sent and a SCTP_PF-state transport info
-	can be got via SCTP_GET_PEER_ADDR_INFO sockopt;  When it's enabled,
-	a SCTP_PEER_ADDR_CHANGE event will be sent for a transport becoming
-	SCTP_PF state and a SCTP_PF-state transport info can be got via
-	SCTP_GET_PEER_ADDR_INFO sockopt;  When it's disabled, no
-	SCTP_PEER_ADDR_CHANGE event will be sent and it returns -EACCES when
-	trying to get a SCTP_PF-state transport info via SCTP_GET_PEER_ADDR_INFO
-	sockopt.
+	in the SCTP_PEER_ADDR_CHANGE event and access of SCTP_PF-state
+	transport info via SCTP_GET_PEER_ADDR_INFO sockopt.
 
-	0: Unset pf state exposure, Compatible with old applications.
+	Possible values:
 
-	1: Disable pf state exposure.
-
-	2: Enable pf state exposure.
+	- 0: Unset pf state exposure (compatible with old applications). No
+	  event will be sent but the transport info can be queried.
+	- 1: Disable pf state exposure. No event will be sent and trying to
+	  obtain transport info will return -EACCESS.
+	- 2: Enable pf state exposure. The event will be sent for a transport
+	  becoming SCTP_PF state and transport info can be obtained.
 
 	Default: 0
 
-- 
An old man doll... just what I always wanted! - Clara


