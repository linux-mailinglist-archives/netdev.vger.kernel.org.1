Return-Path: <netdev+bounces-65737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A883B886
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7675F1C21489
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C296FCA;
	Thu, 25 Jan 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNdzEAwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6066FC3
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155071; cv=none; b=bRj22AmFNsT5e2vM5ciJvQtAMWgKUJZdz9h7TFjex4tZSe6K/WQy+zD3MuIFX/TrvqfyB5hCD4cB+sF/cevepHOwzbVtwPqbG+4ExkHFeVAqMK0DCsuEadSZmS+lMDWB9Fs5HU/ZRyz7ts+OrcdokTXtpqzM5gCG/WRP+8OlHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155071; c=relaxed/simple;
	bh=u5cpuDX7VeunhX9X+nzoJMuIqWttFa13DlHLwqS/TsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq2dqZa0DeD1PbTTtCd0dHTr+z+oJ7dLa45CgVBZCPk3M4yhIrOaxPSb6rkiUmGrh6D3OkNgjLfBmKw3sNNh4ZkE0HNHpK7V1qSYvkfqYW6Jw/FbA0FCskIkrh7WZ9NQLKXrb8DSDKz5fBeGXXTX/hmIJlLI1bsyGPbP+Svm69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNdzEAwS; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb9d54575cso4297266b6e.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706155068; x=1706759868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E4079ibVinIdGps59KvFdwr6rMljC3CIAqrs9YlyJ8=;
        b=XNdzEAwSGgttm4RbVP87GGD9B2x4vsn8C2Coca8j85CVpy6tBQafSWYTH6pxlOgQjo
         0MZpJRKOCnxHPXJPYRtXsC7RG/R+DKkj/SjWNRPyKd3fjlREonMd6+6/jhDNOpwDMG1t
         dEgfpKViIyFiolMT7BbZpE8mVm7jQ3Xw4PUnW864iAmsW9tJ23L/AmZp1t4fs+CETdyL
         9HTJYG8k01CFrrQwZR6n1K/eN1UpWYWQxfHLYDLk062Db+/9sDsL2vG/fn4liio5OxhS
         T5gH8558pjk746yGA+MaGZ4kS2HAAbAX6aKFHqZoUCGvNkFvQ056XxSmOcqPzcl3nf6F
         piAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706155068; x=1706759868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E4079ibVinIdGps59KvFdwr6rMljC3CIAqrs9YlyJ8=;
        b=TgCMm2/tux4/JGnpyLJZcsK/MJOoeWO/84mOlNobxfOtIpKzSLU8PzvYUkPZy+ooaO
         2cxji91/kAUZPb0ALImo/umKjGcD1mXCLIcIvMjBpqtgJ8jj/gVXqj98e2eEmpF0ddm6
         ngbGOAG60XOKwm5FVlNfknwK5XRW1BWCp3kokK+qu2mGdVyW5CIB3dtmGpdDDYiO/ZYc
         43lpTu/DVqaykKmqxq54EnfUukMy1qdR/8VY6kW8oxLvjb9QESYfpKhVOEonxxZi5DYH
         VjZc8aNZJT5Uo2hLfNNOPn5afHFGKtDNRcn0z43fwOCCiMZ0c5wjRqiSbz58nbnHC9uX
         TZjQ==
X-Gm-Message-State: AOJu0YwhTR0lFc6btvOlvLoPEQUnL2C9bOQouC1SvpbwWqthng3jkvgC
	/+fBpo7EYwJ53oZKXUVjO2dTL6QDE4BHK18wIIRp8iGKX9QxjbJyngOcTVnxWok=
X-Google-Smtp-Source: AGHT+IH1hJS7sgA8uJ4GIkk6nCSq7p8JoUMb85Kjqy8cZNdZfhXb1TZMSAdfEc9jq+kqNhhPmoxb1g==
X-Received: by 2002:a05:6808:6089:b0:3bd:a273:27c4 with SMTP id de9-20020a056808608900b003bda27327c4mr313795oib.73.1706155068422;
        Wed, 24 Jan 2024 19:57:48 -0800 (PST)
Received: from xavier.lan ([136.38.127.248])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b006ddce451a4fsm306322pfn.22.2024.01.24.19.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 19:57:48 -0800 (PST)
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
Subject: [PATCH net-next] net: ipv6/addrconf: make regen_advance independent of retrans time
Date: Wed, 24 Jan 2024 20:57:06 -0700
Message-ID: <20240125035710.32118-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RFC 4941, REGEN_ADVANCE is a constant value of 5 seconds, and the RFC
does not permit the creation of temporary addresses with lifetimes
shorter than that:

> When processing a Router Advertisement with a Prefix
> Information option carrying a global scope prefix for the purposes of
> address autoconfiguration (i.e., the A bit is set), the node MUST
> perform the following steps:

> 5.  A temporary address is created only if this calculated Preferred
>     Lifetime is greater than REGEN_ADVANCE time units.

Moreover, using a non-constant regen_advance has undesirable side
effects. If regen_advance swelled above temp_prefered_lft,
ipv6_create_tempaddr would error out without creating any new address.
On my machine and network, this error happened immediately with the
preferred lifetime set to 1 second, after a few minutes with the
preferred lifetime set to 4 seconds, and not at all with the preferred
lifetime set to 5 seconds. During my investigation, I found a Stack
Exchange post from another person who seems to have had the same
problem: They stopped getting new addresses if they lowered the
preferred lifetime below 3 seconds, and they didn't really know why.

Some users want to change their IPv6 address as frequently as possible
regardless of the RFC's arbitrary minimum lifetime. For the benefit of
those users, add a regen_advance sysctl parameter that can be set to
below or above 5 seconds.

Link: https://datatracker.ietf.org/doc/html/rfc4941#section-3.3
Link: https://serverfault.com/a/1031168/310447
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 20 +++++++++++++-------
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  5 +++--
 net/ipv6/addrconf.c                    | 17 +++++++++++------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7afff42612e9..0f121eda2978 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2502,18 +2502,17 @@ use_tempaddr - INTEGER
 		* -1 (for point-to-point devices and loopback devices)
 
 temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses. If less than the
-	minimum required lifetime (typically 5 seconds), temporary addresses
-	will not be created.
+	valid lifetime (in seconds) for temporary addresses. If temp_valid_lft
+	is less than or equal to regen_advance, temporary addresses will not be
+	created.
 
 	Default: 172800 (2 days)
 
 temp_prefered_lft - INTEGER
 	Preferred lifetime (in seconds) for temporary addresses. If
-	temp_prefered_lft is less than the minimum required lifetime (typically
-	5 seconds), temporary addresses will not be created. If
-	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
-	is temp_valid_lft.
+	temp_prefered_lft is less than or equal to regen_advance, temporary
+	addresses will not be created. If temp_prefered_lft is greater than
+	temp_valid_lft, the preferred lifetime is temp_valid_lft.
 
 	Default: 86400 (1 day)
 
@@ -2535,6 +2534,13 @@ max_desync_factor - INTEGER
 
 	Default: 600
 
+regen_advance - INTEGER
+
+	How far in advance (in seconds) to create a new temporary address before
+	the current one is deprecated.
+
+	Default: 5
+
 regen_max_retry - INTEGER
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5e605e384aac..1ff10ef9abb6 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -27,6 +27,7 @@ struct ipv6_devconf {
 	__s32		use_tempaddr;
 	__s32		temp_valid_lft;
 	__s32		temp_prefered_lft;
+	__s32		regen_advance;
 	__s32		regen_max_retry;
 	__s32		max_desync_factor;
 	__s32		max_addresses;
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 61ebe723ee4d..b8f9d88959c7 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -8,8 +8,9 @@
 
 #define MIN_VALID_LIFETIME		(2*3600)	/* 2 hours */
 
-#define TEMP_VALID_LIFETIME		(7*86400)
-#define TEMP_PREFERRED_LIFETIME		(86400)
+#define TEMP_VALID_LIFETIME		(7*86400)	/* 1 week */
+#define TEMP_PREFERRED_LIFETIME		(86400)		/* 24 hours */
+#define REGEN_ADVANCE			(5)		/* 5 seconds */
 #define REGEN_MAX_RETRY			(3)
 #define MAX_DESYNC_FACTOR		(600)
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c..047ac97ae3c8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -195,6 +195,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_advance		= REGEN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -257,6 +258,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_advance		= REGEN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -1372,9 +1374,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	age = (now - ifp->tstamp) / HZ;
 
-	regen_advance = idev->cnf.regen_max_retry *
-			idev->cnf.dad_transmits *
-			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	regen_advance = idev->cnf.regen_advance;
 
 	/* recalculate max_desync_factor each time and update
 	 * idev->desync_factor if it's larger
@@ -4577,9 +4577,7 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
-				unsigned long regen_advance = ifp->idev->cnf.regen_max_retry *
-					ifp->idev->cnf.dad_transmits *
-					max(NEIGH_VAR(ifp->idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+				unsigned long regen_advance = ifp->idev->cnf.regen_advance;
 
 				if (age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
@@ -6789,6 +6787,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "regen_advance",
+		.data		= &ipv6_devconf.regen_advance,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "regen_max_retry",
 		.data		= &ipv6_devconf.regen_max_retry,
-- 
2.43.0


