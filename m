Return-Path: <netdev+bounces-178581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076DA77A39
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A33A668A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB7202985;
	Tue,  1 Apr 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DwaWVLd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AF2010E6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508670; cv=none; b=A7z+s+oL6ZtGa9aTGKiwa9mMDnv3CkrKzqjGxosiPMyKFiV6Kxrmz/szmmYBfAxlrCasTgeL6cIa7+Hl9oq6Xh7V4XcSCawrPw6k1UXkyp8y6HEie2t4p+AeFxzZpnapmQwrIE2sqAgD/kVLEoVqGYyCXHWiNSx54rq+H7lG+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508670; c=relaxed/simple;
	bh=0nF+xuWoBYdZV0D86oQiQH2Vwm5eF02ZJMZE7MDdRmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH31BZMr/p184SntqzFDv7ofEt2HZgfwHSVlaFvb10H4VHDBnXuQpD9FcoD7BHwlKv1Fn2ddgZAnZQlWKzZ9biQh8eaocNnZQQLxnfJy/U7yWvYN/QeWebziX2G/UUCHzp/WWwCj6uSCUePSq24J4d8FibQiA6mcZgaAzk+QWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DwaWVLd3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c1389so257171f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743508666; x=1744113466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QES0z4GKQZ/03VJyRHrdN6C5fCNjDAjguyeu9jRmFsw=;
        b=DwaWVLd3S1DkuWMm1lSXsFQg7ulbNgQpfwCCVUiCFybu6QOp397A3uFhgvrfjkVOh/
         RVQ2Thxkn+by3rPERCqRA78wx7CLJ+hRMhQ0qRRz+Ol5VlCG2HfVAVeDtELVQIX/n0HF
         gVJSfT6vpH1OJYLEI0anrTVXoW5Z1pD6iqieHS9HQKhM6ot9YN4Kz0zluKJJGi9w/zeQ
         g5pnNQwwJK0MzsSNSJmm+EIuMswc/GOpYD3H+aiWhyqblo2VOkfONqFBOt+JrrauoSWk
         6upiWFPQWzMFmYikfsMHiqe12GWyC3noYHv7QqHVtyLQgClJ7X4IIbmIej5O24TDmVpx
         AyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508666; x=1744113466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QES0z4GKQZ/03VJyRHrdN6C5fCNjDAjguyeu9jRmFsw=;
        b=aNzHJctNiOV3YqR+koN032CaKiiaysHPaNMp5QrwIZa0IYyBJi78oesmNtZ1gUlNDU
         /on4lBJv4meF9q8GGM/j11F/m7gcPIFMUUA2+H6SwlcglTF9gERt+V8cS4EAsxPwBvNs
         /iVsbbLnI0fqgM29nUK4QSRtSBfJO/Di1EBHrzecVBEW8gBkJjdZpzMFHJKSwTLJg3Ky
         5CPkybgZ7Roy6Em8/zJZNUrL6xkncaOdNZJWzwgKK93laEbtnO6a/yLirRY2SEHNCUUX
         gGWySVZET5dWFe9pT1P2zkCJ5kGvW9r41610am5JH5k+hSrbV5G0dNxTO950I88kbHAx
         eFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJhiFCbiFCzQGquWdNiJxiDp3NEMg0VI3fZckj68Ky5Q+1C5e0CHtitgZIihpY6EefgqaAtb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxUBW1MFuk7GiS8quJI/LL5dP8S1ivykeDeb4PTdkgRj9excX
	fnKqOm/nfZ84C/23iEjyQZXqbwuJaEbuJcntXyjXI7jY1TjhoJot8VKNiJNpxTXl+h4JDRYTk8Q
	O
X-Gm-Gg: ASbGncu+IqagOB++2fqSMM4av8zVwCe5BQyE2vgB7fm770BLV1yCSSPr34TlLXlzpNw
	TPBrLFACS64CTKUajsY9mdBbrqoUx87y+IwpWerfUgl3ZrIIyPgCUK70u4LJ4HYLpRbeAs7u6IP
	ixpYeJRYPUzgvSZxy9bsZK5Ldn0O246TNjdWPbjRxEpUcjwXQHK2GV0zCPNXT0EAn2Ret0uE/v2
	BzYxev4iMwwiAho1bAYouYNz/nh/dcKABNaal7DQ6ZLF1CVF2A4n2zj8wERUXrtO8jkVpQ5M+K/
	mMm8HOdH7t7JWe1fDz7ITMr842Z2KAq2FT0o3UHwuOBGoaIZrZsUKtxZ/Q==
X-Google-Smtp-Source: AGHT+IGbkEZGFrvbkbtiGNNuU6I3p4pFZhW/qtEV+/o0HWkjf6ohu6IRuXXV/ov23+gGbTey36rZSg==
X-Received: by 2002:a5d:5f45:0:b0:391:2306:5131 with SMTP id ffacd0b85a97d-39c1211b902mr10393579f8f.45.1743508666586;
        Tue, 01 Apr 2025 04:57:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm14130150f8f.91.2025.04.01.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:57:46 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jan Engelhardt <ej@inai.de>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v3 1/3] netfilter: Make xt_cgroup independent from net_cls
Date: Tue,  1 Apr 2025 13:57:30 +0200
Message-ID: <20250401115736.1046942-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401115736.1046942-1-mkoutny@suse.com>
References: <20250401115736.1046942-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The xt_group matching supports the default hierarchy since commit
c38c4597e4bf3 ("netfilter: implement xt_cgroup cgroup2 path match").
The cgroup v1 matching (based on clsid) and cgroup v2 matching (based on
path) are rather independent. Downgrade the Kconfig dependency to
mere CONFIG_SOCK_GROUP_DATA so that xt_group can be built even without
CONFIG_NET_CLS_CGROUP for path matching.
Also add a message for users when they attempt to specify any clsid.

Link: https://lists.opensuse.org/archives/list/kernel@lists.opensuse.org/thread/S23NOILB7MUIRHSKPBOQKJHVSK26GP6X/
Cc: Jan Engelhardt <ej@inai.de>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/netfilter/Kconfig     |  2 +-
 net/netfilter/xt_cgroup.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index df2dc21304efb..346ac2152fa18 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1180,7 +1180,7 @@ config NETFILTER_XT_MATCH_CGROUP
 	tristate '"control group" match support'
 	depends on NETFILTER_ADVANCED
 	depends on CGROUPS
-	select CGROUP_NET_CLASSID
+	select SOCK_CGROUP_DATA
 	help
 	Socket/process control group matching allows you to match locally
 	generated packets based on which net_cls control group processes
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index c0f5e9a4f3c65..66915bf0d89ad 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -23,6 +23,8 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
 MODULE_ALIAS("ipt_cgroup");
 MODULE_ALIAS("ip6t_cgroup");
 
+#define NET_CLS_CLASSID_INVALID_MSG "xt_cgroup: classid invalid without net_cls cgroups\n"
+
 static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 {
 	struct xt_cgroup_info_v0 *info = par->matchinfo;
@@ -30,6 +32,11 @@ static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 	if (info->invert & ~1)
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_CGROUP_NET_CLASSID)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -51,6 +58,11 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (info->has_classid && !IS_ENABLED(CONFIG_CGROUP_NET_CLASSID)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
@@ -83,6 +95,11 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (info->has_classid && !IS_ENABLED(CONFIG_CGROUP_NET_CLASSID)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
-- 
2.48.1


