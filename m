Return-Path: <netdev+bounces-243685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6ECA5DA7
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5643016349
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878B18027;
	Fri,  5 Dec 2025 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ISEVtaMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED401398FB7
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899360; cv=none; b=R8pzGLEoJ7l0LBkpwaAyNGze6tXLvjnRHw9W8gNfFPH+klP3zUXmJL58HBN5HXtWOpW4fk1JB4oRXSrOzmlzFlsilpxBiNYMTMOhMYQCcoxdi8/QkMLymLY3WzXUJyyOFJS4vDtkT7Mf9SGpClyM6zMiBeOk8M9cl/apfY6Dva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899360; c=relaxed/simple;
	bh=GCCe3SdP+LRBLU/9RTGCSz08sJUxl3nAwl+5lkmQqsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XobRUCSHRpHysWLGMH3qPe5mz/eMDMcvV1yWf/uxc7U8XP6GzYEqc3xRg8OYPF0ed6dJ5e4NuZYDdOGBtcZXtFzwblWMqGLw6C9/DpqDNrO1fTiz6A4VO9/yQ2JmuC4m7a+bVA2JQrEL/8H8KJifmd0MOIyLNtbld9qp44kQ/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ISEVtaMJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7df022360aeso1302730b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 17:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764899358; x=1765504158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V77VUVuEufZsqTPrUMnObz13hW2gnHmuo64kCdt8C2c=;
        b=ISEVtaMJa5d5XYF0ijqFqdZwhC0coCkwKa4excjz81WmAXYHBK+WFcEh1xn2RN6r1z
         PXdeNohcgJ8vJsKPeAEIoPqf+vtOqp0useBRj739Ae+pN/QMIJtCxeRB7x/0Dwa6+l6P
         IUB08qOqMNxqIAzPjZ/A0CXL4I9l6yWXyGE1Xng4pQioceDl36KA66UL64RW1qDaYyVp
         vblrIIN2BfzPsVqwt/KlIrkVlR8oQz6bP1jsliVynlsJq9jhSzJkw+CWpKWx35sXDsxh
         NaOlpi0AN7NN4vn/VjUhtJK3iv++jsg+DzEoSVCFh5+ZcVMnrmvxjYSK/tsj8LZldfOM
         leag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764899358; x=1765504158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V77VUVuEufZsqTPrUMnObz13hW2gnHmuo64kCdt8C2c=;
        b=cIJalC1+WykDVS9lZZgxopCZgJRUA+4qsq+vwOSiH6SPaoVQL989mHnoPf6i20b27K
         1vUN5+NSP/sfpY3bKdrN31PTX7G98yz35jSGufV9BwKmS1/0lICrtd42AnwbaoPPpuMY
         6JtqyCha6/i2TM7TaNe0YoE/jnJp9UNNjoyVfQwrrL18YVo+tv3KpLrlQcMolsNFXuJS
         YjtWk5yN/64WzJmdPE3JBIj6jJSSsUFatmJJIZbhTILAxWy5JUVEtPtRRf3qjxQvUnaw
         YM9HgEr/thRayk2wfRRMq/2LRYsDAyZnAJgbPwrIQosGAhdEkgrW+MpdHjCpJOk6RvbC
         J/zA==
X-Gm-Message-State: AOJu0YznDq1SplTVmwH2txErsivLBLhMZNapZHTDM4oNZO954e/SGyNd
	J7tnZmLKIrlh/JvoGXhYfmWCAs4I/8hHt2UirpeCOgD2aAR27W3ae2xxcG8qfCKyJyiE4I0JZSP
	3Y+I=
X-Gm-Gg: ASbGncv5PXyhI/Fed2aMkwlCNJjPkWtzgTojox4lx5iFM5efNchPMS83x+ena4BaNQE
	chi1cIIMq6OMqXqSv1IFhS88948iaOKvqOHldMVvAXMbaFIWWzNCOOClrPOFSYmZwjTdgsGhEA+
	HQtFxmL9pGnOkXBhOhv/DrVfzuSfzPBNb6g8dS9Plr2an8MVpMWo+wKf4PaP/660WCLzl2fG4hF
	oezjGSiX3Fca93Cs4UH/xazPpZvxxSLfiLkI6EKSgyRIv+l3/Qr0QdmIMCoZBL/7GEZwRIns1kC
	A6gQsgTRik7hcXylvVWDRFTydlD2IVTaz+2h7A6PCjpiVgnXsTTh1g/ttGOi7R/6GuJTZSgM4wh
	NUmX91eHloZlAMOHy8Kg6JF+3EJbO7qrydoMUQA4hAT6JK+LzExfPRrXORvDLJ/KxywD4xvqG1V
	plGLEaNfhT96abHpdlieYipmZI7/jS45Z5PviLyi0a3uR9
X-Google-Smtp-Source: AGHT+IHb0WWg5OrRtAsNkF9VYtOnLnC0gOnwjuwT58PYtAnyxv84xUVAbKbMTVawQalvzx3EDxsZZA==
X-Received: by 2002:a05:6a21:993:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-36403304a44mr4600114637.16.1764899358154;
        Thu, 04 Dec 2025 17:49:18 -0800 (PST)
Received: from p1.dhcp.asu.edu (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f3e52c8sm3436094b3a.10.2025.12.04.17.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 17:49:17 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/sched: sch_qfq: Fix NULL deref when deactivating
Date: Thu,  4 Dec 2025 18:48:55 -0700
Message-ID: <20251205014855.736723-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
itself is active.

Two qfq_class objects may point to the same leaf_qdisc. This happens
when:

1. one QFQ qdisc is attached to the dev as the root qdisc, and

2. another QFQ qdisc is temporarily referenced (e.g., via qdisc_get()
/ qdisc_put()) and is pending to be destroyed, as in function
tc_new_tfilter.

When packets are enqueued through the root QFQ qdisc, the shared
leaf_qdisc->q.qlen increases. At the same time, the second QFQ
qdisc triggers qdisc_put and qdisc_destroy: the qdisc enters
qfq_reset() with its own q->q.qlen == 0, but its class's leaf
qdisc->q.qlen > 0. Therefore, the qfq_reset would wrongly deactivate
an inactive aggregate and trigger a null-deref in qfq_deactivate_agg.

Fixes: 0545a3037773 ("pkt_sched: QFQ - quick fair queue scheduler")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d920f57dc6d7..f4013b547438 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1481,7 +1481,7 @@ static void qfq_reset_qdisc(struct Qdisc *sch)
 
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
-			if (cl->qdisc->q.qlen > 0)
+			if (cl_is_active(cl))
 				qfq_deactivate_class(q, cl);
 
 			qdisc_reset(cl->qdisc);
-- 
2.43.0


