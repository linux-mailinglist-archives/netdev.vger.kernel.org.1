Return-Path: <netdev+bounces-74763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5A862C0A
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A684DB2190E
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9831B810;
	Sun, 25 Feb 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oK46quuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E717C95
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880103; cv=none; b=mnZEL1ukfihHj/ucQjPflgFEbj0zYzplG06w4IzE5bqVTvWHHT/ioqwSKyQlFNI8F34lfGjpKdcrQxU5fcb9DfmGaA7wE6H8qLI1h3wmHBA/EiLPR4QTn0T03YautR5PhqCSMTpSIKSr4+Pv3TDJPcjRdCO4/OTVxr5gACRAPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880103; c=relaxed/simple;
	bh=h2OjL8DTef4pDIjurdT4Gb7ejDmXMDQVGK1rQdmsTzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojNso2j65JLn0+AflV06L7J2wOuWsHFMmE+ihHPeChJxqfepEVoDqN5+NENEMdXu2AOBWtV49vSX5Tl2ukzs0nzrslyWXSZ9Nd7/tW801lFTuJ5PlsTWf2lkYAckyaOpHgsS0UTgK8AF3M+tagUBgPY34+eTdR7MbomJcGeF8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oK46quuV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787bb0d85eeso156447185a.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880100; x=1709484900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itaq/2pNFLS1usTIRCj/iY6c0mWm3fl7hW59JF53sZ4=;
        b=oK46quuV1s1h+jAUnuvgMArImQ2qOJy0OEo1+8HKNLxfLBGdoVQ9XUeZBiJmUjm/pA
         +n5V14p0jmD0FELVe1CxYVLs9Rmiek6ptbzQXf+8ENTmWK35o2u5SwW+Zl6YDTIUHQbw
         hC5gBfRzvnS+AnlzU8sJDen/iu6fjKQUXyrDPHKt1ynfiET8/82i1jthX842vm+ys0T4
         +FBNzrCZAmVxSxR26ZqiHkC1ZenukOrsCsmL8zQy0R6LiSuPl+ZAHrYkzMVZcONu26su
         m0ExchTHkMl1CNEtoEB5naJRMtCAMnLlHDNeA0SRvGHN4jDvm4pkSX/N2Ns9Ad+TvJoG
         nB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880100; x=1709484900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Itaq/2pNFLS1usTIRCj/iY6c0mWm3fl7hW59JF53sZ4=;
        b=uQ3JMNNyLg/ZOMvNsH84JbkMoOJ1JHirzkMxxSz1jLXtZPSZchPt6qj8b2RLipqBxy
         h91XXYtlcoB4CkABSIbFUDoeNYQ3xNzTIdQUskY7YfwHCtGElG0QKWjjYYpM0cFWzYeW
         txbi7uO6GfzvTFIImTpVZQquxtTneeRJwF3m1tQTu2IemzptOrRR0YpQ76KPrbJhzVNl
         xpFVL3Uxk4K0/O4SLibQAn8zVFpoixrTyOyKhflSHTp0YXSIHuKEOvhVPpTULZaun/60
         XANFI566uJ3HI/a9plu7ka/Daov/vDu0XMIAwaDCO/90hH2ahA18229+87aj5rmRwaSR
         Mmuw==
X-Gm-Message-State: AOJu0YwaPn/+Pw+f5NAT72Q9AgQ0T6so7XZRNSqZLiwAUytokNhiQLpa
	NLjeqOr2d1bOs+ukR7QjyVZD4Sd/Qek3RJbQVZ3V+MIbI1loJ1ERHEdd4SF7IOMTimIVQVY2YoQ
	=
X-Google-Smtp-Source: AGHT+IEZRWlcWpoMoFcywBRZDKM653Iiqz6NJPC1bcLH9vIRoki0cbKKWgPtkJqoPY1go3S2w13LHg==
X-Received: by 2002:a05:620a:4554:b0:787:9cd0:132 with SMTP id u20-20020a05620a455400b007879cd00132mr7756743qkp.34.1708880100416;
        Sun, 25 Feb 2024 08:55:00 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:54:59 -0800 (PST)
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
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v12  02/15] net/sched: act_api: increase action kind string length
Date: Sun, 25 Feb 2024 11:54:33 -0500
Message-Id: <20240225165447.156954-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
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


