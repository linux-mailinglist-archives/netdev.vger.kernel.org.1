Return-Path: <netdev+bounces-70338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91D84E6BC
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5101A1F23B30
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94185276;
	Thu,  8 Feb 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kUu//KbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76C82D80
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413221; cv=none; b=MZ28di8inIJ4E7QSIkuXOVGpfVyZnbO0EZDH9iMO9WrS/qO7yCxQ9+zKpjHFmpniMACUJyaI/1hRSY3erkAycysNG2BNmUU/tQ5BbPyj4nXYGlmBjpKBZyHJ07MfyJ6nRkM5X+deadgdekHeVd3ctl9GJzo4RTWvy8yUxdEFDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413221; c=relaxed/simple;
	bh=0sjHTzzr+dbcbbs7st9ExWkm7Ltx/7R4IK6V1Jxa52c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOiMV8Sf4vdR1f3O98TP5OjCilzvdvA8YZTaQp8ZdmSgdx+LrTh0v/cCKpSZmTLnc3whtlXka/X6vmHsdJGexlRJQOmp8yoYc+pmyZIFM6M588OaQ4lP161EdYKZcxDUGVCEnn65XpPcD0rxBZPqaznKAVGVEQ8NZYYPLa1uUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kUu//KbQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d918008b99so15465ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707413219; x=1708018019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnMiPqmjn/oepx8HbNSJF8pOdO7gvdJPOYCj2/WsvRg=;
        b=kUu//KbQbMOHtOOW+/cUZ0/IfleKZIueGTCmo3fS4/7Xd6d3x4hduBRc+ogbSrEUHF
         dFywDSsGbxUjVxQejpzdW38dI0FrI/KjfvzPWEzHKYeOZd4wj1zIGCecy4J6rkk4rWA6
         pcKGiWR1Q84Ovz618cZU38wMj2F1R12NHgJ9s23XsQjc/S7jxIbuXwgl8Q25Q1Vo2m9U
         TdatHKRM/fbStzm2EG1Drb8Cm0XNS0kNuMID6vaDcsJFUOPyhqut9VdcMACkWY5S/TCi
         +pulRz1Ef9Nk2QOZeLzupihjhbOe5yx7LQ+EQ0QI/qyFQKgsaZHh9bKmSW6VVv7AapZL
         T98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413219; x=1708018019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnMiPqmjn/oepx8HbNSJF8pOdO7gvdJPOYCj2/WsvRg=;
        b=d8WwX96tKHtYOmYx4sl3yCe+Pl4hPkikvc6J4eYWPqAmzCQ15uyOVSRYs/MrDou5Jx
         MYRCxNnEwtJOWvFrfDECU0IZcMxR9Jh4Ww+9hgOISDWT6YvfyucXUohGSSMoihQxsoBM
         GG8PzBVviVEW3hYXlgJdlG/Ec3+QqDX8TlaKF0/noSbG2AqfszL1inbVtwZM51aGIG+o
         39svokXYCCNIb1+nK3tGPaPUx8C54J0uVCC55vie/ckGlPPSrUGUZqpomrDJ6YMNCU0Z
         zmZNOaEfVmwxSP8fBgFzwazeF++aSSi4IGgk1s5/SBqkEyfSzPX8A2jLSH47lOcPMTpm
         42gQ==
X-Gm-Message-State: AOJu0YxIvg3UJFfkaUEXGrsK7P0WAFGQ9Swb68URIL/DB9dQBXCYOw3P
	WjaOv7LxNeBmm6tvLzHRH+N27BYr7lz2HjfMuyy4/FTyNuRVm4r0KrUGD+uyM72w+tmIwWbcBo/
	cY3w=
X-Google-Smtp-Source: AGHT+IE1sco5gKCgkeefCH6kM6qGG7W40SUUjeUdPjoItgVKYaEvZRZhSfcnDafE2YeseVHo437J0g==
X-Received: by 2002:a17:902:6849:b0:1d7:8382:322e with SMTP id f9-20020a170902684900b001d78382322emr9411561pln.56.1707413218890;
        Thu, 08 Feb 2024 09:26:58 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902f74e00b001d9d4375149sm42265plw.215.2024.02.08.09.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:26:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/3] ip: detect rtnl_listen errors while monitoring netns
Date: Thu,  8 Feb 2024 09:26:29 -0800
Message-ID: <20240208172647.324168-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208172647.324168-1-stephen@networkplumber.org>
References: <20240208172647.324168-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rtnl_listen detects error (such as netlink socket EOF),
then exit with status 2 like other iproute2 monitor commands.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipnetns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 0ae46a874a0c..594b2ef15d0c 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -96,7 +96,8 @@ static int ipnetns_have_nsid(void)
 			close(fd);
 			return 0;
 		}
-		rtnl_listen(&rth, ipnetns_accept_msg, NULL);
+		if (rtnl_listen(&rth, ipnetns_accept_msg, NULL) < 0)
+			exit(2);
 		close(fd);
 	}
 
-- 
2.43.0


