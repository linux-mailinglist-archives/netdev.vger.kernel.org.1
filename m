Return-Path: <netdev+bounces-74392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1F86127F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77601F23F0E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37437EF1D;
	Fri, 23 Feb 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZjvhX9X+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533777E798
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694264; cv=none; b=n/QvtawtAPfBvZ2/HV5Vo19jB/Ia48M7c8Lo0xNZ0uxqzj5xOMIKY2H2uQXhqJqH0cE0BkvEDSPk8z0iLTcGgPojDa00Cnw6VPaDkE5btKgH/sjekyoAQnUxjtx9DWtwgItGD7tAXvnWA240FuA9pXyUMa5NttHFFcoR0kH0pXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694264; c=relaxed/simple;
	bh=h2OjL8DTef4pDIjurdT4Gb7ejDmXMDQVGK1rQdmsTzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVXAOQ52XBlrl5XFPJ9P6XrGnknEovJNdXP+5jouYtIh8miyQnUrMEn64isMeDiyhfu5NS8PjbT1OstGw1H0xhb6oYs/cDxK6+pJRkwIW/tQ/24f9nPPSPhe4KT1z3W/LPdsvcppJ912k9c+ZQrbDRhVpC6TmQxVEAOGlUXj0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZjvhX9X+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7879e69af35so48850785a.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694262; x=1709299062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itaq/2pNFLS1usTIRCj/iY6c0mWm3fl7hW59JF53sZ4=;
        b=ZjvhX9X+kCqhXTST4m1yDPobUT6FETcJCBWyU+VMSAJ/iASpoc3bwm0oKAyDi09zzd
         vZhYujBvQlnyAqNV/wzSFo4pDzb8Ox35MHWR+yA2gwIj+syn0+XF0HilraebyUtSCGCT
         SjTeZ6Hv+vnZFwDGivrHG2Mpwf8rDnIulXoZY/S9FJ66jbhOPHpXEGRsDQINHAgaezrn
         /u9qrJpsv+UaLern4bC3OiWfgPklLBluj2o727pSRbS8p2O+pYf85y/5pfNfaWuS7hSi
         OFunoyZbhyaCLrLRzQn7oU91TdXRviwhD2DqztOZ8tY+Z8E++5iddTWdleVh4JdBcRjq
         ZUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694262; x=1709299062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Itaq/2pNFLS1usTIRCj/iY6c0mWm3fl7hW59JF53sZ4=;
        b=dzl1cjANNsCU6eeebdbWIjdIEKsMFWazFoTvLMHfJHztvD6y62keKsSIC6dAMLXdTs
         1DnDlcGT8cOmBFBskmvGFHJaTaYJqOmxDrqAP6+WErhmfUKKQp4pajGGf5d9jihXH28n
         POYDcKKHQfVBoV+ZZYkiGpYeGAUzQuhqMf2ATZmE+n12CSgmlgfAomkUD9IZz2l0VGW/
         bRZy3jlVMeEsCvX3zV9Eg3ObdRlfHdGJ0qXhXUXO9sKeLLfUk7iuT07a2PrNLHy63/aZ
         vZPl8+mS4C0deMzVEH7S1XF1fwGhz9/fRelGw76C0v5VCCohRGVrslv79BrLFcOKuEcb
         CUmA==
X-Gm-Message-State: AOJu0YxdGq8QgzpQ7ItMSgF3cIj2rPhuP74bysA13oLvSwdPcQYkME8X
	wWP6K6tN2bDcQN8c4tf7gF5u3DK6vU+Y0ZhF4DIOqfQCfpq0uUiVkkd9bPUth4LuOoih7v0QZZs
	=
X-Google-Smtp-Source: AGHT+IHE39YBoKYgoopYX/X+/C4d2FHXKyFQcFjDaDHA2t7OS/xDrhW0jJ6H5htoef1bDgWG9Ikq+Q==
X-Received: by 2002:a05:620a:5652:b0:787:2224:5cbb with SMTP id vw18-20020a05620a565200b0078722245cbbmr1931974qkn.50.1708694261538;
        Fri, 23 Feb 2024 05:17:41 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:41 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 2/5] net/sched: act_api: increase action kind string length
Date: Fri, 23 Feb 2024 08:17:25 -0500
Message-Id: <20240223131728.116717-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase action kind string length from IFNAMSIZ to 64

The new P4 actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
and change its definition from IFNAMSIZ to ACTNAMSIZ to account for this
extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index f22be14bb..c839ff57c 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head p4_head;
-	char    kind[IFNAMSIZ];
+	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
 	size_t	size;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index ea277039f..dd313a727 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 23ef394f2..ce10d2c6e 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -476,7 +476,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1424,7 +1424,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1439,12 +1439,12 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
 	} else {
-		if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
+		if (strscpy(act_name, "police", ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.34.1


