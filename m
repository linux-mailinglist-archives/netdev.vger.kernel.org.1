Return-Path: <netdev+bounces-70447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8E84F01F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AEC1C21C3D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9AE5731B;
	Fri,  9 Feb 2024 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP5i3Dwk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A457308
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459094; cv=none; b=QtuanpQEKLd7anVr7JOz3JaQJaZwsk5wzEPNVl7dYJfnbRAcIu6YjTs2LBdJ3PEoRTIJ4wI/1jRqD2vPhD3W5vzzMnnIZXOlycu/BJLEjkYYiwf3YSPTSuzTS11dc8pIbvswoNqaKPpfyTL26g98pyrsr051t1yMlUSnuk7PW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459094; c=relaxed/simple;
	bh=ubL92FcxkIpFyfIcPM3CeT/GkW1OZXKjwcbZjfWmAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmQO1SLfh0MuJ66qEapF8kfzBuuTvgEb0aqSTDi8YtKPIbmyQxkuTyEwG5UBncFnz1g1TvbTACR/lYQ8wlwHzJwZJbZ/Vz0EZULOuovm33rxiRjWiCRtKmEk1QCX2nQ1fJfJM/Ohx3U2RGFL9sdpzbc5XMfq9nkS+zX9nKvg9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP5i3Dwk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso432656a12.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459092; x=1708063892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o7CI6YlNbi9i5nZkaLe03hZgpe+O5Hl3abf4ZeJwMo=;
        b=WP5i3DwkOU7ZWLLIO1ZEWRNd6rljSrMks9ZoJ6WMNzPUHm1IP976E9WsUiyps+hRBX
         iABEooMCcU/k0cyFimv3zLl6uKsYRg6D6pt9/jnpOTJ8/mHCsic71WTxHwTUf5lXtJLp
         HP+MZlQ5NK0uWShbTyrNNqvweGrj5JZVz5OMzEDi+AEpMIq0s5nZ1bJCnh4UtL5BcxFM
         DSl7/rowlPNNDDsJ6rBTYQJYSWpS/cqaRWmbA7bgcpU/5keIXuX0s1YkyBuaGBuLA52I
         TMW99pN6tL1onTpiF/IlZEYe5yrFtnrAI1Hq0vuodgc4VD28dU4+ME5lcocGJjnVY3dO
         3xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459092; x=1708063892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o7CI6YlNbi9i5nZkaLe03hZgpe+O5Hl3abf4ZeJwMo=;
        b=bbY+r8u9Qq3w+dSqzfhfO7Y6Ajfx4Lcqr3j5igU6P2zKjWiN66R0qzxMzSJUQ/WBG+
         ourSIoVfSpt+B7LP1lexYw6Db4OQBzrdAhy+4YXgP0WSkITDIDLzyefIC85yyAh9Av9/
         rNwGjEc+a1Fxa9laU0BXgCThkh0iIynE4RNrftWBjI4d5HQvS3UXrBOJW9aDXemu9kwS
         Ho6v63rz/uZ0TkLIvY2JUQhRuhMLCCyTdyP4U6G/SmrY4VNlTZXoO9MH0z6anlPIwvjS
         BW8MGZ6mYjMAqssk5V794QZ5iUWa/mo3MnhPAzgfH9XBnaVeU8Fu1IyB2rEwdAA/IAbx
         DSuA==
X-Gm-Message-State: AOJu0YyVtB7SMEK5LourAJeMlh5633k2+uVEq+AGjmZv+emc+QtngZKL
	nTLdMI5ptryiEwi+/yZYLeYjaLiPylHD+Pww4CqJPUC0aQCkAqDjYMQwDXRPN60=
X-Google-Smtp-Source: AGHT+IHFGax0aWIMgO1hIgbV3MDH0/ZY6YljXIB0Ya8XUEEl9fUK7QOUqtt4yvNfbYtWtqWlsTEHkw==
X-Received: by 2002:a05:6a20:9e47:b0:19e:4a98:ba84 with SMTP id mt7-20020a056a209e4700b0019e4a98ba84mr995947pzb.22.1707459091735;
        Thu, 08 Feb 2024 22:11:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnAfzC6pHcZqEvGPXh39azpeQToHKwW5KTNrAE2+lzionLtaACwW49trxYdthEP2uGb9l9Ch7G0t09kW89kaRHShHmpXJZeZDK2nJoJt3w6aa9fm4LBA4N5o+9cQdtKSDmPj66ZniFmKKeP1K7ZM4PI7SAnF7oNqJUSn2LbuI9aPuGhVcZSasYY2pLxOK+HkPegPWZq/Hkq4cI/HGjneccI6dKyIOLscf76T6rh60o4sCvAK57VR9GB1DB2lkdv/EaWRwoUHA=
Received: from petra.lan ([2607:fa18:9ffd:1:3fa5:2e62:9e44:c48d])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b001d93765f38dsm740843plb.228.2024.02.08.22.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:11:31 -0800 (PST)
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
Subject: [PATCH net-next 2/3] net: ipv6/addrconf: introduce a regen_min_advance sysctl
Date: Thu,  8 Feb 2024 23:10:27 -0700
Message-ID: <20240209061035.3757-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209061035.3757-1-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
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
 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  5 +++--
 net/ipv6/addrconf.c                    | 11 ++++++++++-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7afff42612e9..fcd6aa71b4fa 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2535,6 +2535,14 @@ max_desync_factor - INTEGER
 
 	Default: 600
 
+regen_min_advance - INTEGER
+	How far in advance (in seconds), at minimum, to create a new temporary
+	address before the current one is deprecated. This value is added to
+	the amount of time that may be required for duplicate address detection
+	to detemine when to create a new address.
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
index 99a3ab6ec9d2..0b78ffc101ef 100644
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
@@ -1333,7 +1335,7 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 
 static unsigned long ipv6_get_regen_advance(struct inet6_dev *idev)
 {
-	return 2 + idev->cnf.regen_max_retry *
+	return idev->cnf.regen_min_advance + idev->cnf.regen_max_retry *
 			idev->cnf.dad_transmits *
 			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
 }
@@ -6792,6 +6794,13 @@ static const struct ctl_table addrconf_sysctl[] = {
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
2.43.0


