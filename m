Return-Path: <netdev+bounces-170804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A00A49F5A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AFA16F245
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D3276021;
	Fri, 28 Feb 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTkDYpJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FC27293A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761543; cv=none; b=islV5KQRFw/bXfuHc1sdlNhFgH71I8NkeWiXFsJs63hSjOS8M0mRzSClYOlz0Cnt48uTXO7UftdKJMy8PErtVPNMuXZLNsfMSVU8hUHZiWqY3ykd3ICm/o6lDRpydh4ERqDO+VVX4rRd8esnQ8VKUWBco6pY9J6FL5wmCS6TLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761543; c=relaxed/simple;
	bh=NsYtIP9Mw2b/nhaNRRDG6qj+beqFgzVf9yFx5qbgPTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G4yCD71umi3AefZo4RvlqINOp9msVnvR2lhOwWctcRNJkrdN381AAlXjsdj9WNflqUV2EuzKMnQ8UBzMpBganBn3agupVzy4YPFPe+NnfI7UQZGe12PBJix7KhUzEvK04fmjZVAr3B/dJO5Kfxqa0z2hSXUf4+0o603lCVGKQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTkDYpJS; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-abf3d64849dso83815666b.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740761538; x=1741366338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMEGjq6WjEVsV0tBdx2rpYvL0pVPJ8Xct6E1Q4Bt1js=;
        b=YTkDYpJS9a21ha422hVk0M8FVi/r7w5KDTgauOPejHxA01oz21EZNje4EDQpBVgejx
         G3uvmDgSjBjnPvTWQsCnaqX2miIy2PwJL+Wo6rqlHmcWfe9dha4dtAaPp7Uj0ixE4nK6
         IovPR0tWI2cyyilIJNq32XUiwoEtmmaNOTbWYfo+czwwuM234dNhSYgGYot0QW5JvCXN
         C9dV/Uy8A08m623K5emrCA6nu19+2NwAOxsipR/93D8rrujFYQZOPbPTvC3yGgvpyvtw
         qRsHLUbM+eAjLjb4g+kck3HAgMjOziYyQag1o+3lMyZ7bqlfUB6SMMndfb1lOoWrbUsY
         B10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761538; x=1741366338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMEGjq6WjEVsV0tBdx2rpYvL0pVPJ8Xct6E1Q4Bt1js=;
        b=RolOoZG1GywQ4Hee7gcEhdf7kjpRw6UsmHNYaE5jz68D3ZajwsYyb3fkLdp3to/SGF
         mK0PirBsQeptBpeM6zR/0enTaxtNBqohW9siv8PJ5P63dYrrfcWIECfe4ABjBFystGpE
         bhGx1neVmvJ0FITJRlVZ5StAzOK3BXB48adG2xc1gIT2k8rGR12CQ4zAZAVALZH/ZVFI
         n2ai+tEnyd5sH9daBllOBMpG4HnVQv7pgTHFqSUN+HyNI0H7gSyTG20fFVUWA071/4al
         fNA891RMzomsn3lEOuzzhd9b3CSj+JyQnMgoGKbkhdY30Ft6gQb72IgGXJRwJ0rlCPWH
         ze7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE2p/ay/oEY7ZCq6D6xi0pJQlmEoV+UzpgnFpWJ4C+UvirHE+9+A8f89HeAOGcUtG2fWrRaz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzN68W+lk+1mCX0GEhByndghx9SHdZoJEa5We9+eBDE2ycpBq+
	T30tikfNPp/wijtB0CqDsX3fhiToKx+EtvxzH5oijA+ErHfz9glcFkQNYt3sy80=
X-Gm-Gg: ASbGncvwfg9MV6skucx544LgMxt8K1xaRN0qbGuGL1UGoDfMlmRCzZwy2ct+PlhZHBN
	wbG8NQRDAb41a1IA4uFl+rAUXmIKI3RHAN6uAIRN6oNYT3qbia+mq2RnbJ6eP5lkNJr6+nRQ7l9
	JR5fngUzhVKnvmZifBfPmgu1sgODX94AWdmY4Rza0ZCg9TQcZ65T13/u6o91r54sDNey5mqhN1e
	d8UZ4RCAgSpu+t7RpzyNlIzknEPW4gE4z4cfGuNwl8bnn+cvPDPhGlTrDn3Bd11WUpXpMKRXAH6
	27XxSUaTsgGQGjjrMCrRtU7zi8sL
X-Google-Smtp-Source: AGHT+IEs+LalzKtbPFpkKQgFWFd0Lu/RhKgnHSlViKu4ecCAJmjCZ0T6cL/fwlL89/H2Lwl2Cv9zFw==
X-Received: by 2002:a05:6402:2790:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e4d6adc7a0mr7561214a12.11.1740761538383;
        Fri, 28 Feb 2025 08:52:18 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d252sm2764784a12.26.2025.02.28.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:52:17 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cgroups@vger.kernel.org
Subject: [PATCH] netfilter: Make xt_cgroup independent from net_cls
Date: Fri, 28 Feb 2025 17:52:16 +0100
Message-ID: <20250228165216.339407-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
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
path) are rather independent. Adjust Kconfig so that xt_group can be
built even without CONFIG_NET_CLS_CGROUP for path matching. Also add a
message for users when they attempt to specify any non-trivial clsid.

Link: https://lists.opensuse.org/archives/list/kernel@lists.opensuse.org/thread/S23NOILB7MUIRHSKPBOQKJHVSK26GP6X/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/netfilter/Kconfig     |  1 -
 net/netfilter/xt_cgroup.c | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index df2dc21304efb..af9350386033e 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1180,7 +1180,6 @@ config NETFILTER_XT_MATCH_CGROUP
 	tristate '"control group" match support'
 	depends on NETFILTER_ADVANCED
 	depends on CGROUPS
-	select CGROUP_NET_CLASSID
 	help
 	Socket/process control group matching allows you to match locally
 	generated packets based on which net_cls control group processes
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index c0f5e9a4f3c65..f30a62e803d22 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -23,6 +23,14 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
 MODULE_ALIAS("ipt_cgroup");
 MODULE_ALIAS("ip6t_cgroup");
 
+static bool possible_classid(u32 classid)
+{
+	if (!IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) && classid > 0)
+		return false;
+	else
+		return true;
+}
+
 static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 {
 	struct xt_cgroup_info_v0 *info = par->matchinfo;
@@ -30,6 +38,11 @@ static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 	if (info->invert & ~1)
 		return -EINVAL;
 
+	if (!possible_classid(info->id)) {
+		pr_info("xt_cgroup: invalid classid\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -51,6 +64,11 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (!possible_classid(info->classid)) {
+		pr_info("xt_cgroup: invalid classid\n");
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
@@ -83,6 +101,11 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (info->has_classid && !possible_classid(info->classid)) {
+		pr_info("xt_cgroup: invalid classid\n");
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);

base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


