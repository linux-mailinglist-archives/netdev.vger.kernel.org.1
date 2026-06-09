Return-Path: <netdev+bounces-296976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xM7OHiXRJ2o52wIAu9opvQ
	(envelope-from <netdev+bounces-296976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C265DDDA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=temperror reason="query timed out" header.from=lzu.edu.cn (policy=temperror);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296976-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296976-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1F2B306623C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD353EE1D6;
	Tue,  9 Jun 2026 08:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FB33EDE66
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:35:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994124; cv=none; b=M4KD49sl/y3Y0h0iXpwUuz5of1fnUKOhI2i9YuC101UUcdTi3FGRHRfXOi+sNlds4xNJYGXSEjp04LRYhNHanMvifAhzpkzbqx7Rw8U6yddiXT1w+Vspiu5bq9IlYqaey+iV7QSk6m6om5ampX90i3Aa3vELLfEu5C+BpZ+1hbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994124; c=relaxed/simple;
	bh=mepLCHozR+iEtSg5thwHV+kujH9CFQ1+KvS6CA5I4Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtU1TuFDuCFZYAVjkdvMAFemhfzx92gFvOo0a75uM/7mYTNdr9CdNopweFwCSM/xpoJ4d2gSaQPRKK9xvXIo0A34pPSahzQPrzOa9BhbE+Eh06YMyf0c+7BWkZ1C/GS78EA7y0avYWpxzgzfh9YR7Fi9kqvXjgz+gsAxd/1lml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAAXVv450Cdq+EAdAA--.35770S3;
	Tue, 09 Jun 2026 16:35:15 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Cc: 3chas3@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	zcliangcn@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: atm: reject out-of-range traffic classes in QoS validation
Date: Tue,  9 Jun 2026 16:34:37 +0800
Message-ID: <58f02c6f73d9818fd5d2022e1116759fdde6116b.1780965530.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780965530.git.zcliangcn@gmail.com>
References: <cover.1780965530.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAAXVv450Cdq+EAdAA--.35770S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUuFW3tFyxuw17urW7urg_yoW8XF48pa
	9xGFnrKrWqga48Gas7Z34vgFW8WF9xCFW7XFWDAan5ZFnYgF1Fya4SgFZF9r98ArWrGrWr
	urZFvF9xZwn8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVCm
	-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQANCWonzNEAMQAAsk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296976-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:3chas3@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:zcliangcn@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 658C265DDDA

From: Zhengchuan Liang <zcliangcn@gmail.com>

Reject ATM traffic classes above ATM_ANYCLASS in check_tp().
SO_ATMQOS stores the supplied QoS after check_qos() succeeds, so
accepting larger values leaves invalid traffic_class values in
vcc->qos.

That bad state later reaches pvc_info(), which indexes class_name[]
with vcc->qos.{rx,tp}.traffic_class. Values above ATM_ANYCLASS cause
an out-of-bounds read when /proc/net/atm/pvc is read.

Tighten the existing QoS validation so invalid traffic_class values
are rejected at the point where user supplied QoS is accepted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/atm/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/common.c b/net/atm/common.c
index fe77f51f6ce1..6eb78c34c284 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -720,6 +720,8 @@ static int atm_change_qos(struct atm_vcc *vcc, struct atm_qos *qos)
 static int check_tp(const struct atm_trafprm *tp)
 {
 	/* @@@ Should be merged with adjust_tp */
+	if (tp->traffic_class > ATM_ANYCLASS)
+		return -EINVAL;
 	if (!tp->traffic_class || tp->traffic_class == ATM_ANYCLASS)
 		return 0;
 	if (tp->traffic_class != ATM_UBR && !tp->min_pcr && !tp->pcr &&
-- 
2.47.3


