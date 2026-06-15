Return-Path: <netdev+bounces-299352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mfrQNISsL2qYEQUAu9opvQ
	(envelope-from <netdev+bounces-299352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CAA68446C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:40:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="rr4/Y4Qt";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299352-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84E16302FB7B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE03BE633;
	Mon, 15 Jun 2026 07:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F9305698
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:39:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509173; cv=none; b=IbIVcBY/qvx6KBJGH+heedrlf9lgBoEOz8oRChkSq3qPSHSosQmw2iDpqRZl7F4P0Ut+5i53Sel4rLPg8O7T/aUwthPhw0MuZHdr+bzs2hNly2eksHcMt7GNAwqyYhVrOru4vf6Jyu/ULkdQHlSqMYV36Uxb95A0ige/lzPMehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509173; c=relaxed/simple;
	bh=GhXEyKkP29VXLeRmonNXmZuNyFF8Y5CTi4bvaeAk+uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbKkEURk1duxGVzUaVR7DQIJgGvWQrAjM9gjXS59H5NaFAc+8MJ2tLyk4Pk+v0viQqnCOghXPsyM8tj2EFZYRTwvyxipBEhxatI1a7iaQgFmy+RH9zK5zHNrxWfveAwA+DddxEDYSF+eQGdZuHfAHv9nEn2e09hioSfB+CcLVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rr4/Y4Qt; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf20f6be6bso22028575ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509171; x=1782113971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLEgrGhLLiPgaGmE3Is2kQZUG4Kfq7t6C+1yr+NyMNM=;
        b=rr4/Y4QtNFmxPXRI+sAgboLescjFzj4MrCOekGhnAvbvmaas6yt5MoE5+a0rhxYyAT
         nzAmqJcRzaFXzLvkcdjYRJc+pGJRnwz2zSmorFZilPdlSensyNzkn4zhYvph2nP7JRjo
         dgv5+63AH2BYBShK+iyx7whSnunCjUDX0UcaH2QNgy01X7L8PPfocovBAlimw2jLkFkW
         BscXnZadeg+GxdDEjHd4Y+Y/p2dGmdn0IQiXcvp0w+Q5wVJeDRb0JyawZzt2OSrNLVB3
         Dp7in6an2SI9lw7gAA4KF2p/hVzBDnWd1bvhBb+cCvNNvojPg+FEoEmTPSPIB9wZYrGl
         zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509171; x=1782113971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLEgrGhLLiPgaGmE3Is2kQZUG4Kfq7t6C+1yr+NyMNM=;
        b=JT+p/HaItDR7n+kikT2GxQCubAooxHOvnmAhBOfZdbvVrNm3t9Rp2xtuZAXY43Wuks
         Yq7R+kE6ofGtFfFZWPAWsojnysk2eWj86uh8IGEh2T3l7CFzBR0fQ4RI/pWyIerPyJOu
         V6ycIzSY41j87nJ0ldXoISRGt6IYZbIvu4WEGnOPpqz0qA39/F/+EwHiNjvJOLVi7eoq
         sKUEsIMFrUjuV8pv6vbC/xaB0PQXR5W8jTkapQCdgSal7uLfLfpH8qai6DR1aMu5IPez
         pJh2bJuKiu4SAFVEpgiNYiEEgOzCyyjQpsMdmbCctKa3C1UcuBB2YjZELSoO0U94jRW6
         XFrQ==
X-Gm-Message-State: AOJu0YykI9lFghlsIZDgi6gEKglaf1WGTxAuDRd+ZgID2fdVjLB/H2wn
	PtRH7Fa2soTtcWBO0amMRoDLK8d6ATksSOhPjOASWw8haP8VZBNCOYsz
X-Gm-Gg: Acq92OEPHyzsOsPeYt4Qn18Nbj7o6wOv0SBeCtVdOCautZ3JWT3LFid+bw5xtv6tuKW
	7NI0OAbFgYzZBvJLXHyIpv9C0hSMkeRAQ+tghI/81zeWpTeDMcbqPn4ZsjN6Csvm1gRS2O66Vrn
	al5C+9VaJqLTaFQ8EahCVGG2XjbaUzjnrzXLbQltUVPx7q+H6pqSa9964bZw8gf4X0V2ebQ4/8B
	M3qQikjlyBKYD2YMynyC79IHNSqtjFzJfsENDI8Z4pkRqnXAShP3Cp81dsDGXWxP+pxOiS8tyWY
	chi1YNJdFl/xfiChIW/ekDEiYYtLTOiTGa1HKNeur5LUavaKbR//iQnyeCbwSyQW/FOqsrccEho
	Rs6aZ8kFLhCnNti3kXLE2M9VOFAJ/4gu2uWpgWBL+ZFaZpes6OiQnZ2+zAvSzhVC6+flwnhpRiS
	MM7vsnPEjgFop48Dt26qwEU1lvuqdwe7H7hLulloHETxaqNXn1L3yMAJ2a5VSmXyo=
X-Received: by 2002:a17:903:1acc:b0:2b0:b016:773f with SMTP id d9443c01a7336-2c410414f4emr136000405ad.11.1781509171045;
        Mon, 15 Jun 2026 00:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm91271345ad.68.2026.06.15.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:30 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run output
Date: Mon, 15 Jun 2026 15:38:55 +0800
Message-ID: <20260615073856.152479-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299352-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35CAA68446C

For non-linear skbs, bpf_test_finish() derives the linear head copy
length from copy_size - frag_size. This only matches the skb head length
when copy_size is the full packet size.

When userspace provides a short data_out buffer, copy_size is clamped to
that buffer size. If copy_size is smaller than frag_size, the computed
length becomes negative and bpf_test_finish() returns -ENOSPC before
copying the packet prefix or updating data_size_out.

Compute the linear head length from the skb layout instead, and clamp the
head copy length to copy_size. This preserves the expected partial-copy
semantics: return -ENOSPC, copy the packet prefix that fits in data_out,
and report the full packet length through data_size_out.

Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..976e8fa31bc9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - frag_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
+		u32 head_len = size - frag_size;
+		u32 len = min(copy_size, head_len);
 
 		if (copy_to_user(data_out, data, len))
 			goto out;
 
 		if (sinfo) {
-			int i, offset = len;
+			u32 offset = len;
 			u32 data_len;
+			int i;
 
 			for (i = 0; i < sinfo->nr_frags; i++) {
 				skb_frag_t *frag = &sinfo->frags[i];
-- 
2.43.0


