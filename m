Return-Path: <netdev+bounces-116026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A0948D48
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31331C224F0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207211C0DCC;
	Tue,  6 Aug 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="V6aedmQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB11BD015
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941760; cv=none; b=dtFHYsoHITR335Oe50EeYnDT9Nb40ErQl+d+R6sguaTdSIh6y1DXAUNMOB7gisfjBY/xhlc6dRwLsrCTXZsqT0vWXM8d2SM8BLqyTBlnnzca9bFr9JTI56z6IEBwK8j/lkK1aB10wWzcGkigfDEtptOZ9ehsX2Vacx1ubp0XgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941760; c=relaxed/simple;
	bh=VUb+OiMIzldvBddl22qgZ5q44Sc6Y9OF1U+iB37E934=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7kaaPkS6xbf07nj16uEnzOP3mHjbbF/Rl9OxqI0oHUL1k0JRGquP4e5aR6Xw6YotLdT+St7xmIPE33wnH0dsQDrG1Hc0BwPnzTJyFGb9Lb/s1jX6SjYbqJyyrEFfOhwWrAEqvrkfeBCcRRDawa+3pfzVBHP2qkQD543FULFllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=V6aedmQz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36ba3b06186so255583f8f.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1722941756; x=1723546556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ah1OeNL1GOaIuH3FhDmNjN62yMaxK8CYHJAcPTan14w=;
        b=V6aedmQz09LMhcWKbXVnxN7I8vPE/+7xmZk6xO1vrLybdsbIsqrg7JIAYofP7MxlDT
         z9ZHI5MyYpLtMcyrMfWqabJnEg/Qt35W3phEaztl4gQUvFF6UOTMhUQnyw0PEMTikVDy
         KXUKXID3l8WRyh8ob6zBz2OhkyxHydCuxC1hqgeZX9eLRwsxPTLobI2WMHkyrSs9O5pp
         8+xm02i5d3rdEpGF4b9zzAO0TUd7LFfTaJGMBkMmD8tJtOk3ebUvYM+Z+tghY8war3uP
         3kpS+IBY3py1Sjee1PmJx/QILVs1RZschD5qViGnl0TZSiBP572ZGUxovSpM1GTu6ZYs
         Szsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722941756; x=1723546556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah1OeNL1GOaIuH3FhDmNjN62yMaxK8CYHJAcPTan14w=;
        b=adN19bPA22brjMi7CFStBMfEw5glnfJ4Z1HvPMDHwTj+3cHYlSDuyyrZF/EizM5wGB
         hfSri7wU1K2d63PzrI9WUFhbgsd4Jo6sCRSKtEuXhSvzTpIJhro33wv0hVhZTQopzoAe
         i2abQIkx49n1THheUomxjsmWOZG6KGoKfpPtgEcXkMW7skBownnJApeJ+1/4LsiISdAA
         WL5xpUVowSNfle/IemlPPrpfMCxirOVekdAgE5hcOuC0FpuVfbyViEeL3QslvKLykYG4
         Oe665rKyz98nWV2f20fWbE8Ieies2fZyeznSlMScHHKEQX1K7fQ59VMHNdGGIvSStnlP
         6Lpw==
X-Gm-Message-State: AOJu0YzZWPvYL7aTY0vjhc0rizgSVOHxf4iHV5XdyfVwn/uj5SBUJuAo
	DFbJpTX6CCDsNWO6Oyj6DFozcC+217ldhxsgzcARfEv1QW3YDXTDy+CbZSEm7O5NFFDCiRdeg40
	3
X-Google-Smtp-Source: AGHT+IG9BYGXiMvIYVMEaBc+IaNs10Rvw6rTZLWQCsNiuy7+Mnh24NYW8+5feJw5sqNaMOXqbD48+w==
X-Received: by 2002:a5d:62c8:0:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-36bbc1bd492mr10845232f8f.49.1722941755837;
        Tue, 06 Aug 2024 03:55:55 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0597a7sm12674250f8f.75.2024.08.06.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:55:55 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	daniel@iogearbox.net,
	dsahern@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH iproute2-next] ip/netkit: print peer policy
Date: Tue,  6 Aug 2024 13:55:48 +0300
Message-ID: <20240806105548.3297249-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print also the peer policy, example:
$ ip -d l sh dev netkit0
...
 netkit mode l2 type primary policy blackhole peer policy forward
...

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 ip/iplink_netkit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index a838a41078f9..49550a2e74ca 100644
--- a/ip/iplink_netkit.c
+++ b/ip/iplink_netkit.c
@@ -166,6 +166,12 @@ static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_string(PRINT_ANY, "policy", "policy %s ",
 			     netkit_print_policy(policy));
 	}
+	if (tb[IFLA_NETKIT_PEER_POLICY]) {
+		__u32 policy = rta_getattr_u32(tb[IFLA_NETKIT_PEER_POLICY]);
+
+		print_string(PRINT_ANY, "peer_policy", "peer policy %s ",
+			     netkit_print_policy(policy));
+	}
 }
 
 static void netkit_print_help(struct link_util *lu,
-- 
2.44.0


