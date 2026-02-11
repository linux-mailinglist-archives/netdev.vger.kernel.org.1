Return-Path: <netdev+bounces-258352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EEAIenbjGm3uAAAu9opvQ
	(envelope-from <netdev+bounces-258352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:43:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D11273D4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CF13009F83
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BB352C5C;
	Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZV3+YpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24426352C4F
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839013; cv=none; b=MmxA3hOQGFgEH6FCcDBf0vT2wCN/W0V+2+ocVK0QVAuG1c55sa7kfTvHmdQUtxlIyXDJHHJSqekj+3ALs4TDTNvTUhMh0vBGUAL1ySG8G3eByHsRriVXHdDww0oyleW5fRsCOde/hqZorxDBI7sWAKIxmQ1DtA70tRS89OfyWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839013; c=relaxed/simple;
	bh=ZWbPqJQii6H8WyeXZM+tCMZQu3W2Yff2gbsayOOGiPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYHeRrdFxbDrRWbYZ/oLA2vjxeexsJx7uh1bznVnC88x+Xvpygo/3ZtzErym1NGo6QPqcRI+prGuvkjZRDBZzeD3iFmzqOkkT4zHl/mg/smZ7a8pCW/DYrvnR9gUiv6+zkHDwJLqo5LSRp/oTK/HOYjg16FLABJJ4Bsy6KsceIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZV3+YpQ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4042cd2a336so1572942fac.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839010; x=1771443810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a9gQYVVISPj2gmgBnG3tylapu0SzuOdddpgIvGc12s=;
        b=iZV3+YpQp/V6DKuuOwLiVZJRJlURIwsjjAKm3aid2r3/5/qDfyFdrn8wP+ekZ76kYO
         cJBiVlS6Xe6qPXedhx+PSYC7FiVNwFDTGIXdrGxtDYM8ou0BNoVm3mIrPhDHpyl+VZuZ
         k0hIMmdlACa9IznX3a/CRmjM6YxKMdYiQgX46/2vYMa9Ot5ge9IM+2sUwh1mQGz+PbCT
         PzcIAA5hxlthhqKUCZQuxHrjvnz29lIGwNCcN4oiVl9t/NNyQ+ogMv1p3BHonA/b2dTD
         x/3/k60wKt/SotaXjw88XRmVcZIulqfSZyk3UyL5DjxoKKSj7ij5m+iwAJdZFHvl3xHI
         pdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839010; x=1771443810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0a9gQYVVISPj2gmgBnG3tylapu0SzuOdddpgIvGc12s=;
        b=MsopLPCaYYAkVC/JKfHFTP5wF4xxkO5ZWqXy8MCDLSSZjqd/2FW8lxsUqkrbq4dClG
         wG05dysTAnyKPRm5t7Iq8yFAlP25xDE148Ug49cwub0gFAS+82OPi2VXL5F1/XwGxJT7
         Fz8xqluAeWbsCB9D8mQUiFctNuI9N92gDDBOFr0nBKcTzPnizpTKVUKM64xBK2JdreHp
         BeFblXd6l1+qSvPZR5AWb+3p4RX2nVFCsxdQWpp7W/ng1YbQWbrEKnso4jWXgymnpT0R
         lsJ8UPYZBa1FkLwJoGKJ0FHfJA1fQLzGrcy+FWC9RdHL+IcSo28lLopdxlADVd/L6VIy
         Jdsg==
X-Gm-Message-State: AOJu0Yw2OfBJP2RLfwUWfQVlIyDufaD2YXu6pPZ/xWcw17khpgBOV8xI
	jO3uB8c95hNib3wxtwm55mFeGvq9YNnGunMUViJIUW6VQt4r/F6MrUqPpy/GIA==
X-Gm-Gg: AZuq6aK1e6X5sqp9Vft4CDXRsAB4rSzsfym6Vcj1WxbW3hjWaWIAoVMIjaGWGEnQLCF
	KmRcZRT6SqA6YN6qr6BiDK4Rlfitq4sL6MwvBdrGEWlkU7JcXn5tys97FWRx9qo6hAiNIuNQaKz
	SSkMCDIRjI4XM+GnUuDTXysuTx89LcDvd7i3K8cyiiYh6wl67uHZDDWaP5QVqg59EZe9Qu9eJFb
	CfjgyF44SaLH0qiIdyLVu8DNC4G4Z8KWhzBxGW6sVidhiPPWxsdK+6byC2Pd14MnA/vf++t0lCC
	FtWNdUSn0f6zddNbZtpDnHIG2tdNZQN+4sPhf2OghLnCkwLuTb4swiQnfD4Ik76CznRHq75K972
	GaGtCKPra31901q/YrIGUaII+qY5EKrq5qCxRUB0ZqmlLV9IE+YxvjfmquAo2Bwhp7DCIHAuZ+J
	2inI2KAUGJOAwYEDNXOnn9O+gzMq1INgsN+MlRT0ljax3xX5xgmv8PpOsahNRRUwZl+SARhWHS
X-Received: by 2002:a05:6870:3342:b0:409:794e:fe9 with SMTP id 586e51a60fabf-40ec74775e9mr153681fac.54.1770839010010;
        Wed, 11 Feb 2026 11:43:30 -0800 (PST)
Received: from ubuntu-BQM5.tailafa00.ts.net (cs244-84-dhcp.cs.colorado.edu. [128.138.244.84])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf1e858bsm1989412fac.19.2026.02.11.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:43:28 -0800 (PST)
From: Ruitong Liu <cnitlrt@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ruitong Liu <cnitlrt@gmail.com>,
	stable@vger.kernel.org,
	Shuyuan Liu <L0x1c3r@gmail.com>
Subject: [PATCH v2] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
Date: Thu, 12 Feb 2026 03:43:25 +0800
Message-Id: <20260211194325.797963-1-cnitlrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211184848.731894-1-cnitlrt@gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-258352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnitlrt@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 264D11273D4
X-Rspamd-Action: no action

Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
added SKBEDIT_F_TXQ_SKBHASH support. mapping_mod is computed as:

  mapping_mod = queue_mapping_max - queue_mapping + 1;

mapping_mod is stored as u16, so the calculation can overflow when the
requested range covers 65536 queues (e.g. queue_mapping=0 and
queue_mapping_max=0xffff). In that case mapping_mod wraps to 0 and
tcf_skbedit_hash() triggers a divide-by-zero:

  queue_mapping += skb_get_hash(skb) % params->mapping_mod;

Reject such invalid configuration to prevent mapping_mod from becoming
0 and avoid the crash.

Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
Cc: stable@vger.kernel.org # 6.12+
Reported-by: Ruitong Liu <cnitlrt@gmail.com>
Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
---
 net/sched/act_skbedit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f657..b6f5c21651fc 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 			}
 
 			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
+			if (!mapping_mod) {
+				NL_SET_ERR_MSG_MOD(extack, "Invalid queue_mapping range: range too large");
+				return -EINVAL;
+			}
 			flags |= SKBEDIT_F_TXQ_SKBHASH;
 		}
 		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
-- 
2.34.1


