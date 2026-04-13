Return-Path: <netdev+bounces-277990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP1oHvqt3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 232BF3E9526
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE783008749
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436937C93A;
	Mon, 13 Apr 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/lvf609"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC035A397
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069977; cv=none; b=MPaktWsxN+dE1a+IZrSAI6dsjtupdl+ejjbBU0aFx4ykvA7myUDwlxyS2dRvUlhDNlpVAaEx4Qz2O0KhV5ygoOLmYjDfYichLg1khALMx8jF4goplL5k9npWxD1GIna0xaoFbfwCZPwYy16n4lBBrup67af59pa3amW51q7aFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069977; c=relaxed/simple;
	bh=GmnjbGflMBWDxjEtHIFXgRz1TxxPkLEe/a5xxNFgs8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TsKYi/jvFhEHi8lsxpuye22KeidD+p+HN8VVBe2KSF7crUdMXFB9ugP8GzUTfUjolfh8FKTC9JZILeFmElsOkJCfZntBFF+wFTH2KjSW3lCUAlrJGB92XBYyTqlpRghY+8kjBUatKgyMEUg58lKSAjNkWfX/QO9WcRonfZ2uUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/lvf609; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso3644512a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776069975; x=1776674775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwrub6IAUK7fbf/KIL4RIUjCioeQIHLj6YmidJS4fts=;
        b=Q/lvf609t7SWWOB0cy9BS/0eFC44ybLMl2f4g9OUoE++trt1+zngYxeUninpVG8jwC
         ffziSJyF9jJ97tSNBYRTMu0JD+Uv5kFoDKsa3ccCiYWXhsOpvHMU/w5WpQIUaze2RzFV
         C93zeyySmEHk2cYPWzaXli8yidmWZi6nKyyodoq1pc3MN38AmpdlbTJXS4O6FHyWjcnu
         jRlyundlWSzppiFzx8oOfFpQ+hBcrKKdzSRG5tvdHpG+YI4hvpuDMZbCYlLCtQXnZqh0
         R3O/GVsHF/5PpjllmeQtbFm+ngBMVvTps7vQvMIPBA2IBRnwFRy8lTH5ac7ESplfUjdl
         d/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069975; x=1776674775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwrub6IAUK7fbf/KIL4RIUjCioeQIHLj6YmidJS4fts=;
        b=lf42zXwX9p/J4JBdpoVpPE//RnD0/yEsP29MbUqne2bUkkPAHykNNdPoP3XwT8jH0Z
         brczJpXiuf4vYaMsvBVE1oEB4xsRPAYvyhGAsIMFW7zzZhsg7wIhNbjY/8FTfpz5IRCv
         L8VLJPJJUn+KH1U5ndS0El7hFpA3bhKG5/yO2cii1xcqnXX9gne1TyfhfzLE2v/+mWt6
         ry0wkoPeFJXhATzz6iyas/cRa9TksJN3kzDs0Q+9uVd4c9RNL0k/m7Hbfa8tQ/NrWcuf
         T4MUyee6U4fe0D9DnZlE2nUq/tksr/Qsb3I+11Jfo0qW33xz/bvvqmVRm72/CmhMC+qn
         ECrg==
X-Gm-Message-State: AOJu0YxoXg23kz/WMdgOqHZXG/474kz3jovwbsShGHZ5xxSWkzdiEljT
	PAO4ggEfLZOg21unIJat2lkgD7bXj45g1sXHTlg6Pc8z8FfyvdGNVq5WUti3iQ==
X-Gm-Gg: AeBDiesAHJssyLqBqgL2/x96+RhJjSIzt/DCKnkWq1OsiNUZat58b3HSUgq9A/+dw+j
	5Z4K5X2tsqXPVy85iZwz5X2QRS5qLw6PWThUinBSYIycpgcPk+HChmaI3dgmJQU2O/rUuH+te0Y
	iwW8EMSoNOfMOgwOYGW1JyKGBK6xUhDGcSzK58gTetoUiksfOEPqSu6ig7GuT6JKcp9vuIziQYO
	TdH9TMA9ximpq2D/d919TQhB8Iitt9dPdDEMnSaOFxmUlqrYmvrrWq70Fym1KjMLLUma1sgC8zf
	fyEAxoX+JxobKfXaY5B5D3zIyKTnj5DRyUqqwkXTU/cSBWLubVtwlFOSx1MisJqKcvPP4kFCUOT
	GYV9RzQ+uSwvHrg4JzZWKCVSN6LV+BbCnQ68BkfoKXUIZ4OhhA3YX7FK/febdQd3WSMq6PsNrAF
	7ax4c9NjVTdO4UaYhphPV1xtQgRqA68MqogjU59y/BTLzP5h5e07368EmbHL3wLFhx
X-Received: by 2002:a17:90b:1804:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35e42853374mr14071037a91.23.1776069975450;
        Mon, 13 Apr 2026 01:46:15 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e5aebb15esm4133903a91.4.2026.04.13.01.46.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:46:14 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] net/sched: act_ct: fix skb leak on fragment check failure
Date: Mon, 13 Apr 2026 16:46:09 +0800
Message-Id: <20260413084609.69560-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277990-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 232BF3E9526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcf_ct_handle_fragments() returns TC_ACT_CONSUMED when
tcf_ct_ipv4/6_is_fragment() fails. This causes the caller to
believe the skb was consumed, but it was not freed. Each
malformed fragment leaks one skb, leading to OOM DoS under
sustained traffic.

Change the return value to TC_ACT_SHOT so the skb is properly
freed by the caller.

Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/sched/act_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7d5e50c921a0..870655f682bd 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	return retval;
 
 out_frag:
-	if (err != -EINPROGRESS)
+	if (err != -EINPROGRESS) {
 		tcf_action_inc_drop_qstats(&c->common);
+		return TC_ACT_SHOT;
+	}
 	return TC_ACT_CONSUMED;
 
 drop:
-- 
2.39.3 (Apple Git-145)


