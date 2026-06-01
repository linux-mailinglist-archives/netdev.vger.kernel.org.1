Return-Path: <netdev+bounces-293878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAeIHdXLHWrHeQkAu9opvQ
	(envelope-from <netdev+bounces-293878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4150623CEA
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 636EB30AEF48
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9EA3E5A15;
	Mon,  1 Jun 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDByOU/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC303E5A13
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337272; cv=none; b=qA7LvHMqyZoB3d729Nk5BYw34NQCLvERyckwqERQ1E0/32dJQSdCiatL5Ujht8Dvtjt0yREfwM/G55C5l6AROHUB4qKawVCwOJ5tDqhrV22blRqMoTxweahkQ7zR2DzR4nq9ucngv9CUW5nFw+t/zlhpZm18r//qgKlrrx/AefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337272; c=relaxed/simple;
	bh=ka4I5LIiQBnHNvY/EZOZsTEKE+R6lb4aAN9hkXUw03g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI4I7gt0VwVsaoPv3unAVJlN4umwg6s+vcKP8d8C4dgkCuSt8DJBI7EWkS75oiTcA4piF4T11KKdcjNIm8KI3X0sHgWsCE+JEE7VNsLJS8AwJjTtPY+Ki2owun8n4R7nAr9b4UswuxrjY6Pa+bZ/QlI228eaIh+zMKO1dd+IgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDByOU/r; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422871b42dso1265715b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337269; x=1780942069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pSIam+Zmfc1zu7BLy+A4wZtk1mlnebSbErGhuWkvnc=;
        b=PDByOU/r8eGvGbH+E6Nm4MH9GMamN3C5qRP0F+zRH5+quzM/uFAtVuDVRBeQ0Gjlkm
         xHdgJUB07oZYKy3+uEz1rWis52jD8XYiS0t6XrmFTIMzSXx9f3Tz1I7A1UdOGgSNoN2i
         NHZX2ump0LsTi+UM8YSvL0IuOiXijeV2CkIMSe4w6yMY7NVDEtODhlosfIS8iAdTTwAH
         QfsUXijQ/GXkePY5pE/FsDFapjeJgCXVEhSgWxPZKNlC4t9U5/PteWC7WjwQ8R/zsUXf
         7fF0aPC52SFZXpJm8vUV4TgUL61nmX5wfQpoIVYWg0tIw8inDU3JRVOR1amXGWg3ef6t
         zykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337269; x=1780942069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pSIam+Zmfc1zu7BLy+A4wZtk1mlnebSbErGhuWkvnc=;
        b=mirA0vOzOBHiw+MkZnG8VzeidpDUV8B/obsPdnfmIP+c2njfdkN5vNCLiIvwabXol2
         i15Th9L3lt5mFg1fWCCM+QCxVQ1CnP4H/gtYccLpRckPjvxCfkCUbkxb+Ubi3XaUpDJO
         uSo9B9nGZx8fUqpv6qzoABP8nyhuwXogACLk6pKjgWT3Sm62N1keXicQsRuw2W41WKoq
         +cfe2ubeOqIARqQnIUSNMOydI1Iyl+sVV5Tf0tQdsRFSi3HtRl+QpfE/eqsCass+TdO6
         1/AgJ2Ssm6YRBzUCNsSXgau4SI2qNqqt7LOGBxV8GGoR3wxE1uW4f//HiC887cD2LM55
         9Ohw==
X-Gm-Message-State: AOJu0Yym3BW+KUDYpSgmPfa/ds5PUrW3chQ00/6U88bMnl49NvzlEpHL
	50sJZNX8KMcQ1HCSAvIpzFan5SjGc/J+4gNDSY+Y8MKJJtPTF3ZxcWcx
X-Gm-Gg: Acq92OGbfO9I9Ifd8Ehi8E3C2fDMasCl21RKELa/UUFrj+ZIdaoafS3u5UAL68hdmW5
	UHx50FhJ7jEy0St5OYkoUOk0FGIibxdA5OPMPbKkWqNQPjQi+9iQxUqBWRGM5ZKazkl4E7CdGRB
	n+OUdYzufdWpPgwfWhStT+hEc6xM0h3Q2sn2ZsaoX4/eRKjIHY98WI8SxdS3AbwTw5Dimt/ooyl
	ZMWZHGnvTuT8nHD2p8MZfcJIPg/ULHhkA5MCa0DitPIsgvWOobmC2Z39FyC00g5qTSAHOyyCVTj
	NGwf4e9coi/3ykNl8Gcas+9XkIWpCnF2tXaRzxzLkt2949dwsqkk8CmJJYVytAUZ8kC2aO8BBQZ
	LCfPiJkFMTMyUbZRK6h0pi99ruMAME0ZwOnjJcMdAx0qUl3VKlo+6fPmi8f1fWX5+FA6ke6YrS+
	cZqiWw6SnpnLvTaeHpzdzw9lv0KGEGqiV4kKVoiR5qraE=
X-Received: by 2002:a05:6a00:928c:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-8422572beddmr11155406b3a.4.1780337268885;
        Mon, 01 Jun 2026 11:07:48 -0700 (PDT)
Received: from localhost.localdomain ([212.107.31.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm7389702b3a.22.2026.06.01.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:07:48 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	tamird@kernel.org
Subject: [RFC PATCH 6.1.y 2/2] bpf: make the verifier tracks the "not equal" for regs
Date: Tue,  2 Jun 2026 02:04:00 +0800
Message-ID: <20260601180400.1381736-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601180400.1381736-1-jt26wzz@gmail.com>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293878-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: E4150623CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit d028f87517d6775dccff4ddbca2740826f9e53f1 ]

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u32 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231219134800.1550388-2-menglong8.dong@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: adapt to 6.1.y reg_set_min_max() layout. The upstream
  change lives in regs_refine_cond_op(); 6.1.y still refines true/false
  branch states in reg_set_min_max(), so apply the not-equal range
  exclusion to BPF_JEQ's false_reg and BPF_JNE's true_reg there. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e029d1..e51f44b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9954,18 +9954,50 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		if (is_jmp32) {
 			__mark_reg32_known(true_reg, val32);
 			true_32off = tnum_subreg(true_reg->var_off);
+			if (false_reg->u32_min_value == val32)
+				false_reg->u32_min_value++;
+			if (false_reg->u32_max_value == val32)
+				false_reg->u32_max_value--;
+			if (false_reg->s32_min_value == sval32)
+				false_reg->s32_min_value++;
+			if (false_reg->s32_max_value == sval32)
+				false_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(true_reg, val);
 			true_64off = true_reg->var_off;
+			if (false_reg->umin_value == val)
+				false_reg->umin_value++;
+			if (false_reg->umax_value == val)
+				false_reg->umax_value--;
+			if (false_reg->smin_value == sval)
+				false_reg->smin_value++;
+			if (false_reg->smax_value == sval)
+				false_reg->smax_value--;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
 			__mark_reg32_known(false_reg, val32);
 			false_32off = tnum_subreg(false_reg->var_off);
+			if (true_reg->u32_min_value == val32)
+				true_reg->u32_min_value++;
+			if (true_reg->u32_max_value == val32)
+				true_reg->u32_max_value--;
+			if (true_reg->s32_min_value == sval32)
+				true_reg->s32_min_value++;
+			if (true_reg->s32_max_value == sval32)
+				true_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(false_reg, val);
 			false_64off = false_reg->var_off;
+			if (true_reg->umin_value == val)
+				true_reg->umin_value++;
+			if (true_reg->umax_value == val)
+				true_reg->umax_value--;
+			if (true_reg->smin_value == sval)
+				true_reg->smin_value++;
+			if (true_reg->smax_value == sval)
+				true_reg->smax_value--;
 		}
 		break;
 	case BPF_JSET:
-- 
2.43.0

