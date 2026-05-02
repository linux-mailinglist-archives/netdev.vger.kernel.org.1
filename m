Return-Path: <netdev+bounces-283490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKbBaVy9ml0VAIAu9opvQ
	(envelope-from <netdev+bounces-283490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84B4B38BB
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69523002301
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229232BF52;
	Sat,  2 May 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5hfW5gO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486039E6F5
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758853; cv=none; b=EPZRkRKs2vbp11Q2i6pfz2BFMg6rF/8r2FDOUcFE/raGyUMBnstRazE4mnfV2/yLCMg2Icrc4K5TPlI6mTA7nUdwm20S8GRX9PqowIErVBMQ6RTfJq1h7hgL62Z131l1NOEldK24Yu7UlKmRD4xzTAHzPpvhFDrfojL0WLfcraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758853; c=relaxed/simple;
	bh=GBdaPFRBndABu+g6xyTPCYH9U8koFL/3jkPmvZnpAtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsVF2h9uVJdOWLqhgNjzwsCk+Ow+pLJZyk2tEGh6jQIen8ZrsF+g5FwW+ne24MHJW0TLWYISF/FPx4d1Z0WzM/EsdlZ31LpGfJ8W0ALFUQS56+dlEU4fLNbV7j4NF7bHWD7D38038o2hgd8Wizpd3mQip3Ba4pZgZpS4CAOekWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5hfW5gO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-365313b86bfso10443a91.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758851; x=1778363651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/HtMUR8y8tNvQTsqYRM6w8nnbZCwy6OiBJMOowLZxI=;
        b=o5hfW5gOG21dH4qgHm11/f5yasqoj160VqW7W0DSF6xbtUll/tmqQP2V95O/R2p6jj
         1KG3TZf+DK8JQGGyouNAVTaphpQG4BbVMY9H8tbjtKxeCqNlt4jPdNCQ2dcic5LrgsNq
         POaJ1Bzsf4CqD74n248hGF49O1YGBF9jAdpvyZXQ+cKdesiOCskB3CFHNuDVE/PoLvZa
         Hp9EsFziMqe3U1IY0DEbEQlecsIdI6K9VSXv9C9YG3h1plFVBlPSMdkvC6wUPA5lRfYD
         SfGWErFmS+sYuocpII6hN4EFAZo1lcBUXmscpoaEX49OLrqmtGtEbhUh3/Jn9ysbwrGa
         0/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758851; x=1778363651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/HtMUR8y8tNvQTsqYRM6w8nnbZCwy6OiBJMOowLZxI=;
        b=Cp3lCENGEJP/g2WpBT3YUwbblRKOEG2hr/in3LnlOS8EEqAzvR6k+tG6j8t9kNJrNJ
         FiANNiANPAOx1KgwzjlpGk1+SJdK8nO10A2HTOgrISGSfuz+d/X6NiGj8Un0OVhx7YCn
         B16u84lh0cmL6ALY3nHFF3m01Ms1umSS87YVbN0sSCdvGJi7mgeVOjOFfIAgZspPOqkL
         /BnZlCg+9VnXr0/D4q1mH4YrbPsq4AHPORUVmcjvcK7313UiKnunePJh7G8vgXq3VBG+
         VEKMzeIj/CprIdRPXiOJjQC8A4gVTTy+KvsXFL4aNKwmk/LyKUxwLmIXT7aQkuympzj3
         3EeA==
X-Gm-Message-State: AOJu0YwvVK6Q/qf9/4djrPWBhy8BHMlsuMofQs/H4exjKgXJByBfSrtR
	Esw/WRHkYEZSTOBcN9FNYDalOILhWClJ+HrHUzfq4LffEUDkm79jtK/lk2iaaha0
X-Gm-Gg: AeBDietpsmDZwCQFoUOQABsBGiJkRdwkarXeL5/aE77/9dum+GXDSbb5ccv3TDDEe9e
	yLqqkZWgw+OnxeKa4GVd6NRJHOkl+iEz35uPkcstwnauXT7lU8ZGfVQNUvTBxuT2jhQi1sRzwEK
	PqCyyBw7E5s0DOLcbYeyHjottVwOf826uVsgnNh2lMV1rUeSebXmeRVIDjewBtQm+fSusv5ujvL
	dbw5B5VXg16jC3qctrfTrEN4oFxSTPpNRIT1nPymLX7uP+m0K9Jv3uKXAw0hDEhh4YhGWRu52m1
	0QJfZNZZ6CS6RQr+GSgL6z0nTfXYjALvEvRDrMvSJ7FFRtutfUq9slLVBFE0ZZ8QVJqIdWm6xXf
	UGeEoUtyhJ9CnQ5ymL0AO0mlH3qbdJDx7TF7/SDS/7a03hk1xE3456pEuhDOQ8dvTl3/d1ZXJft
	aFCR9f4m7CajzbFk/hC+lotImbtpkboOLs2+3IFxTp6X2qbyM+A2wiScmNN05T
X-Received: by 2002:a17:90b:2888:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-3650cecebbdmr4147392a91.15.1777758851385;
        Sat, 02 May 2026 14:54:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae1e293sm60508315ad.45.2026.05.02.14.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:54:11 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: sched: tbf: pass all params to offload users
Date: Sun,  3 May 2026 05:53:09 +0800
Message-ID: <20260502215314.917687-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502215314.917687-1-mmyangfl@gmail.com>
References: <20260502215314.917687-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC84B4B38BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,replace_params.limit:url]

Drivers might have fine-grained control over queues. Pass all available
params so they can make use of them.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/pkt_cls.h | 6 +++++-
 net/sched/sch_tbf.c   | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..d73c04e3d919 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -1040,8 +1040,12 @@ enum tc_tbf_command {
 };
 
 struct tc_tbf_qopt_offload_replace_params {
+	u32		limit;
+	u32		max_size;
+	s64		buffer;
+	s64		mtu;
 	struct psched_ratecfg rate;
-	u32 max_size;
+	struct psched_ratecfg peak;
 	struct gnet_stats_queue *qstats;
 };
 
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 4576111fe075..8a1110d59dec 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -153,8 +153,12 @@ static void tbf_offload_change(struct Qdisc *sch,
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	qopt.replace_params.rate = q->rate;
+	qopt.replace_params.limit = q->limit;
 	qopt.replace_params.max_size = q->max_size;
+	qopt.replace_params.buffer = q->buffer;
+	qopt.replace_params.mtu = q->mtu;
+	qopt.replace_params.rate = q->rate;
+	qopt.replace_params.peak = q->peak;
 	qopt.replace_params.qstats = &sch->qstats;
 
 	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
-- 
2.53.0


