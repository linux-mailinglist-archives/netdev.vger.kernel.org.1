Return-Path: <netdev+bounces-71613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB38542C9
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 07:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CD5284E90
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE05111AE;
	Wed, 14 Feb 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adgevdfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3610A33
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892096; cv=none; b=PSOO7ElJod/rPiUy1ROm5P+v8Vrcj0a81k2JqCF8SUmvDdegomt8BRbmUEn4s+ib99LEFU23vqqGUud2fQ8X68sFcbyBZxUBDetCbGEMiRWhCbDQT2fgbQIBAE3BsUlicp4RAkokgkJt5HmgTsjAoRp9oAnN6jbwHmDEh6EBjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892096; c=relaxed/simple;
	bh=+JyyijEwDhHnEzka8K2uG/gVh7fdnOMcjWQmvBzyf8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtTqv3Ok3KkrGPNVeBPCpAVR0991aVbb6GW+K7En7mbDq46NVHDwIPYYN+DNxpYYfYQBRoQjHnqoVV3vvRQDTDztfNjz8SbJgwhmQpY7tMXN4TUpQS10QxRInD5WremqwJTOgm6hKGIcF+Yae6W1FjkkwL0q2T08aLzmbCC3Xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adgevdfh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7881b1843so46972105ad.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892094; x=1708496894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqyYxOeglUuSSo9617mVWGErw/1xl/DIHj8YhnK6gWQ=;
        b=AdgevdfhH4hpaWFkZN+fF14Hkj2UHCHPHhV1q0cUjuJrSUsfKXzWwURE1vEBLsqMq1
         diXGuL/sr0vnYzNOqJMEy0lRYvR9GM6xDF3uMo1T/sPaXXEA9ANklQo9k70SShLOujfo
         pFE9kRM/8z2T/A0CCkpQFjRpj8y7GvKAfc3sYpwidNppmxshxjNNAexoEee0G5DNQwTG
         KDh2KFzhuM1dxeEunjigA5+XJ9p6qgZHIf5rwgGG4QUjj2EOPumHYV23d1HLfuL5lVMQ
         M0KbzGpl9yBVf/0sgnZOmgO1Glfkd+OdgbhKIYPE0XzbK0YySP4hDLv/yfNcZVSBwJj5
         ykLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892094; x=1708496894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqyYxOeglUuSSo9617mVWGErw/1xl/DIHj8YhnK6gWQ=;
        b=qtSrELkbXbNxA9o+O7uDy9KLrAtGttody3fImZeUTIvjAuIbqb4QDkoMBYkyS7Rd8u
         58U86TyGqsOx5rulkdplDT6Pt8M0lKHzYq921LgZYtCtZAv+4RpUKTTMLVGfwn4aerrG
         U2xvQaBj0f/4NA9+yvM7g8A8F8ZnCTjAq9thDHVS89eMsQUKOQYC2lVIAO/f3Aa8eEgr
         xQM3txZhI67Yv5+lLBRtSlBfq4+X5uA59dQJFUHvb4kATfiwofIMWJDO9Dp7wypDLX0i
         VXzRk2xJZohsaf+nrvTA0vlFjH/qtt7JWNzzIOTotxrhge7ES7oH18FDAipZT/fO00sT
         Ulkw==
X-Gm-Message-State: AOJu0YzqKiNbicBweZ0lZ+61/oWjosD1SyolDzRM0RtUAMox+MQOABC6
	4NqUJZ/HPEbo5xO+I0W5lv+lLCQQfjj3/H2MEtOQ+j8Qbi1snGT6TvzhBanjGsM=
X-Google-Smtp-Source: AGHT+IH+XcQFWIxZyt6nBaFDi/t94c4yW4iL3m9jo1gfgGumd+JrxvRDsa9mn275OwjRVp3GI2wjUg==
X-Received: by 2002:a17:902:b589:b0:1db:3d36:507b with SMTP id a9-20020a170902b58900b001db3d36507bmr1725270pls.44.1707892094100;
        Tue, 13 Feb 2024 22:28:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVybW7aXUYjMQD3n4UHMxnwDjvRZDWgwfhnl1GRzXMMdtYInzEF52uOEMcUSegQ67gs2UuGWUeoU6f9jAIdjsyON6RJkDZ7qG+YTaD/A6oke3c9Ew0GbhF56mFWnBjuw810yYV9jC2UctLReHzKc0DO+YSakmWK2P/dZOXRJC3OvJuh4LEzza2MTxitMkzhEiBAozwua3Sca/CxIPWNpc26TcXnr0rCdTMKgJ1UOkeh6j5ZBP9IwwRyTt7S3wwA8YFcc3ZJbw=
Received: from xavier.lan ([2607:fa18:9ffd::2a2])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902e31300b001d8dd636705sm1983843plc.190.2024.02.13.22.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:28:13 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	dan@danm.net,
	bagasdotme@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jikos@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next v2 2/3] net: ipv6/addrconf: introduce a regen_min_advance sysctl
Date: Tue, 13 Feb 2024 23:26:31 -0700
Message-ID: <20240214062711.608363-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240214062711.608363-1-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240214062711.608363-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RFC 8981, REGEN_ADVANCE cannot be less than 2 seconds, and the RFC
does not permit the creation of temporary addresses with lifetimes
shorter than that:

> When processing a Router Advertisement with a
> Prefix Information option carrying a prefix for the purposes of
> address autoconfiguration (i.e., the A bit is set), the host MUST
> perform the following steps:

> 5.  A temporary address is created only if this calculated preferred
>     lifetime is greater than REGEN_ADVANCE time units.

However, some users want to change their IPv6 address as frequently as
possible regardless of the RFC's arbitrary minimum lifetime. For the
benefit of those users, add a regen_min_advance sysctl parameter that
can be set to below or above 2 seconds.

Link: https://datatracker.ietf.org/doc/html/rfc8981
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 10 ++++++++++
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  5 +++--
 net/ipv6/addrconf.c                    | 11 ++++++++++-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 458305931345..407d917d1a36 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2535,6 +2535,16 @@ max_desync_factor - INTEGER
 
 	Default: 600
 
+regen_min_advance - INTEGER
+	How far in advance (in seconds), at minimum, to create a new temporary
+	address before the current one is deprecated. This value is added to
+	the amount of time that may be required for duplicate address detection
+	to determine when to create a new address. Linux permits setting this
+	value to less than the default of 2 seconds, but a value less than 2
+	does not conform to RFC 8981.
+
+	Default: 2
+
 regen_max_retry - INTEGER
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5e605e384aac..ef3aa060a289 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -27,6 +27,7 @@ struct ipv6_devconf {
 	__s32		use_tempaddr;
 	__s32		temp_valid_lft;
 	__s32		temp_prefered_lft;
+	__s32		regen_min_advance;
 	__s32		regen_max_retry;
 	__s32		max_desync_factor;
 	__s32		max_addresses;
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 61ebe723ee4d..30d6f1e84e46 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -8,8 +8,9 @@
 
 #define MIN_VALID_LIFETIME		(2*3600)	/* 2 hours */
 
-#define TEMP_VALID_LIFETIME		(7*86400)
-#define TEMP_PREFERRED_LIFETIME		(86400)
+#define TEMP_VALID_LIFETIME		(7*86400)       /* 1 week */
+#define TEMP_PREFERRED_LIFETIME		(86400)         /* 24 hours */
+#define REGEN_MIN_ADVANCE		(2)             /* 2 seconds */
 #define REGEN_MAX_RETRY			(3)
 #define MAX_DESYNC_FACTOR		(600)
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 68516493404a..9af56b73d08c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -195,6 +195,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_min_advance	= REGEN_MIN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -257,6 +258,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_min_advance	= REGEN_MIN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -1341,7 +1343,7 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 
 static unsigned long ipv6_get_regen_advance(struct inet6_dev *idev)
 {
-	return 2 + idev->cnf.regen_max_retry *
+	return idev->cnf.regen_min_advance + idev->cnf.regen_max_retry *
 			idev->cnf.dad_transmits *
 			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
 }
@@ -6819,6 +6821,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "regen_min_advance",
+		.data           = &ipv6_devconf.regen_min_advance,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 	{
 		.procname	= "regen_max_retry",
 		.data		= &ipv6_devconf.regen_max_retry,
-- 
2.43.1


