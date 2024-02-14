Return-Path: <netdev+bounces-71614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6E8542CA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 07:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEF284850
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965911706;
	Wed, 14 Feb 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjNRKo6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F0111A4
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892098; cv=none; b=POmPPOpTGUTIpAV8UngsTHknU2lv1vO2G30lvsuICr4zsDfR/2Di3HQD5X61u8uNFNqqfqryl8YccSISPG78c5DBdRl0wNBsumdx4hNklpveKXDXX8LQGM12N99THGn5geP9Ghf6tDVX8ou+i/j7yLzoxh3rBRVNL2svId/DAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892098; c=relaxed/simple;
	bh=7zJ13E+9+aQFGrZM8A/ZDvNnVVPby3yTLqROxXTbhaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2CGpa93lK2Td//8UJhDZtpCIu2VWt762yfZbrVGp+oiIhciFuXszX3KPuJotDlCILMrByHVS/GVebWECdn5UFFcw4i6mJfOKAz2/OZvv2lhHR8WFFWJFAR3Fb1nrjS83BDuMkGIIWZ+urJkr/EjRXvPkvqOnn8DF8xf1ODG+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjNRKo6h; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-218642337c9so3309235fac.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892095; x=1708496895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJs862MZYxWmxS7n9joCUN3cXOWsaiCJCk0ksXMqllE=;
        b=gjNRKo6hNmKiQ6fUHoxPjpsHmIH7IXtkkloTfthXL7a06rooklexhqRAMb+8o86uak
         uw3rSGraxoY4+44f7ffEZTkgpNundwrxjKJqdi9ZtAAd5JC77u1ul0LpCy/MsvXGeN1j
         ZV2wta2VCLPb0mz7ZWPHw88DHscKwPDRwmuBwUxz6WE5BngWPYL6+9mKDRnqtlMsXTZG
         wwRoWUnzk1799tXywT86sFp61gP3U+8BUooboCIEpjQodfk6KD7Dkq5CmI91e31SktSg
         DgoToToVzsV51NPogfuE/hPWt5ViXRgyUShZRKW9juFqQ9ccbe4Dz18ltojJDujWUq/y
         ZEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892095; x=1708496895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJs862MZYxWmxS7n9joCUN3cXOWsaiCJCk0ksXMqllE=;
        b=AWSJeotMfx4MWPJsQMO+S/NX42t4MTBN05y3utTqNQxgXAXZ0Qql34SfpTe3cvOQDH
         qqm3mqaX7bR7xgKuW4DfpH3tNx9AkaXVdLEDtl/+AgrAFUlMmX+WM7s0cSAfjVPFl0gg
         LR2E7gjahqifxvYVBdxodsSTV5GG/b/iHUumB8rtCDEOJXYe3TFltGzo/vII85oRdYVC
         I5Zu6SHEngWv7ZpkYpJolzH29R3NNsKEl3ZmGCRizV6d+2bZEzf+Qx0XKI3OvXPCXctE
         dRB85tWeTIRHVV4GJhyzLde+/OdEAhFKQyKLGlNiZ8znCFEqnSefO97i7LYRT5gN7OG8
         SRZg==
X-Gm-Message-State: AOJu0Yw5xjP+zcAy782LEDQYwBZauio+n6saA3y9EFRQGrP4EZyPKQau
	rQ9fRBm1NTB2xogWZiaF3rJ7yJVy65NwIrB1J5/K0QHVTCox3tnc2NnJeLTJdkQ=
X-Google-Smtp-Source: AGHT+IFxJI2KlEClzLh9wrIy5ZHtWgSAbKRzjLS0pHeXJ13UDhdYGiT9myQnt30Mp8u7CR33ZlfzcQ==
X-Received: by 2002:a05:6358:5295:b0:17a:e013:9586 with SMTP id g21-20020a056358529500b0017ae0139586mr2085941rwa.29.1707892095154;
        Tue, 13 Feb 2024 22:28:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyaNSQZDP6eKaQfsCL5WB9q4SF2aAXWdRNhSaoycuDRy64Xr6jlgJpORtuJqo1f7Z16fLdt2uq4kjIHRBXHXhmM9TAlPN255OaZ67nVXpuUa8a8tmU/nWidzjVpxhXtKXMU4TNG33NqIWLNNLzWLyMHRo2n09X72bn/kUyKbPSRK6JdbE5j8uBFZGxTFuQQR2PbBoOAmlXy00ZMazZVlNBrzBtjhADpQpnRElOpqLjzqZo1ktGxgiAjOsmzkMgAeHJiYKvyZo=
Received: from xavier.lan ([2607:fa18:9ffd::2a2])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902e31300b001d8dd636705sm1983843plc.190.2024.02.13.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:28:14 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Tue, 13 Feb 2024 23:26:32 -0700
Message-ID: <20240214062711.608363-4-alexhenrie24@gmail.com>
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

If the preferred lifetime was less than the minimum required lifetime,
ipv6_create_tempaddr would error out without creating any new address.
On my machine and network, this error happened immediately with the
preferred lifetime set to 5 seconds or less, after a few minutes with
the preferred lifetime set to 6 seconds, and not at all with the
preferred lifetime set to 7 seconds. During my investigation, I found a
Stack Exchange post from another person who seems to have had the same
problem: They stopped getting new addresses if they lowered the
preferred lifetime below 3 seconds, and they didn't really know why.

The preferred lifetime is a preference, not a hard requirement. The
kernel does not strictly forbid new connections on a deprecated address,
nor does it guarantee that the address will be disposed of the instant
its total valid lifetime expires. So rather than disable IPv6 privacy
extensions altogether if the minimum required lifetime swells above the
preferred lifetime, it is more in keeping with the user's intent to
increase the temporary address's lifetime to the minimum necessary for
the current network conditions.

With these fixes, setting the preferred lifetime to 5 or 6 seconds "just
works" because the extra fraction of a second is practically
unnoticeable. It's even possible to reduce the time before deprecation
to 1 or 2 seconds by setting /proc/sys/net/ipv6/conf/*/regen_min_advance
and /proc/sys/net/ipv6/conf/*/dad_transmits to 0. I realize that that is
a pretty niche use case, but I know at least one person who would gladly
sacrifice performance and convenience to be sure that they are getting
the maximum possible level of privacy.

Link: https://serverfault.com/a/1031168/310447
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  2 +-
 net/ipv6/addrconf.c                    | 43 ++++++++++++++++++++------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 407d917d1a36..bd50df6a5a42 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2511,7 +2511,7 @@ temp_valid_lft - INTEGER
 temp_prefered_lft - INTEGER
 	Preferred lifetime (in seconds) for temporary addresses. If
 	temp_prefered_lft is less than the minimum required lifetime (typically
-	5-7 seconds), temporary addresses will not be created. If
+	5-7 seconds), the preferred lifetime is the minimum required. If
 	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
 	is temp_valid_lft.
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9af56b73d08c..f31ab973864a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1354,6 +1354,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	unsigned long tmp_tstamp, age;
 	unsigned long regen_advance;
 	unsigned long now = jiffies;
+	u32 if_public_preferred_lft;
 	s32 cnf_temp_preferred_lft;
 	struct inet6_ifaddr *ift;
 	struct ifa6_config cfg;
@@ -1409,11 +1410,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		}
 	}
 
+	if_public_preferred_lft = ifp->prefered_lft;
+
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
-	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
 	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
@@ -1422,19 +1425,41 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	write_unlock_bh(&idev->lock);
 
-	/* A temporary address is created only if this calculated Preferred
-	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
-	 * an implementation must not create a temporary address with a zero
-	 * Preferred Lifetime.
+	/* From RFC 4941:
+	 *
+	 *     A temporary address is created only if this calculated Preferred
+	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
+	 *     particular, an implementation must not create a temporary address
+	 *     with a zero Preferred Lifetime.
+	 *
+	 *     ...
+	 *
+	 *     When creating a temporary address, the lifetime values MUST be
+	 *     derived from the corresponding prefix as follows:
+	 *
+	 *     ...
+	 *
+	 *     *  Its Preferred Lifetime is the lower of the Preferred Lifetime
+	 *        of the public address or TEMP_PREFERRED_LIFETIME -
+	 *        DESYNC_FACTOR.
+	 *
+	 * To comply with the RFC's requirements, clamp the preferred lifetime
+	 * to a minimum of regen_advance, unless that would exceed valid_lft or
+	 * ifp->prefered_lft.
+	 *
 	 * Use age calculation as in addrconf_verify to avoid unnecessary
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 	if (cfg.preferred_lft <= regen_advance + age) {
-		in6_ifa_put(ifp);
-		in6_dev_put(idev);
-		ret = -1;
-		goto out;
+		cfg.preferred_lft = regen_advance + age + 1;
+		if (cfg.preferred_lft > cfg.valid_lft ||
+		    cfg.preferred_lft > if_public_preferred_lft) {
+			in6_ifa_put(ifp);
+			in6_dev_put(idev);
+			ret = -1;
+			goto out;
+		}
 	}
 
 	cfg.ifa_flags = IFA_F_TEMPORARY;
-- 
2.43.1


