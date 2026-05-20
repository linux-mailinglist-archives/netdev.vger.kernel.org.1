Return-Path: <netdev+bounces-289902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMVyNducDWoU0AUAu9opvQ
	(envelope-from <netdev+bounces-289902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:36:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266958CAB5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9903031036B9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57CF3D75B9;
	Wed, 20 May 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At51JHLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02B2E8B64
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276214; cv=none; b=UzL0ixCCwijHB20iPF2W/JqLlPr2TnMqFo7TQSXpYgIEFAim28aWif4BHBEmw1p4a3USOSEO6I7tfLznGpz+d68gbX8ZC8Ap9JnqRcuoU3gziGuKuFN2OH3gLZtNSh1hloKTMqz95AFpreTaDrnSmFS97fMvWvGajSZWWX203y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276214; c=relaxed/simple;
	bh=7rsUPt1tduntxvqWGRDK+3R1RqTZuELegUeUx6qEvBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=io26xZMi8xeFLqg/vK5NimE0KX5AVpuxM9zODDD3nF2eOH3GYK2N34Ivk4xytjbaCQEvk068vOhQmYSTPkRMbaxyvTz7fUflOI7hzzcK0urQB80ML15NMt+JLhOOP+LakPFujEIGcESskFSGGGUTAAFIahjuh5V9+WdynH+qtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At51JHLs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-366be8040a9so1909591a91.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779276213; x=1779881013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhaoB8u6zHtRNjD6pdvvJsZ7im80YuxbV9CFFPE8/do=;
        b=At51JHLsbUP6Ql3dwI8t6ezJRRxcbgPYa2ZvX7j1HC4RZeH6LhJLHSAF22sq1p74EW
         3WZTEQKCaopoKFHeeKpmkD8pDKpy4MfHd4JpUwR6Hn4lPfV/TdQ2EdzOipOZPznxJRkh
         zOihUORIXqo/Exlv7ip+ARFF/nnRG97F8lzA/KQiEAV8P4oDF2KAYGgTLUu/dz/OyaM3
         TmrSbt1Qg6a39v6SRXxgJsj4ssKops6IiiQGmQvAr3Tm0kOkSj8EZPnJpOzJY6glfHxp
         VTss8k+sGOMe51hP5L9i0dVGBA2qbmBRKrz7Vkl7xo6dS2ZDpSKInv6IpQC9TbLaDLMA
         89fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276213; x=1779881013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhaoB8u6zHtRNjD6pdvvJsZ7im80YuxbV9CFFPE8/do=;
        b=plQn3mZSWYydY3SR0WzwThCzoBiY/lCiuSA/DWWkr1+N/fIXs8qWj3tb3dOH+CGbMW
         bdzYqScGdFCi20PecdVOBePZM1aO6Bns78M/U5uN5uoBSBiIyHgJPJMfnWIZpAMctE7O
         MiZ+LvLUDsRMpkJx5nMh2i1JTfRdyX7UnfYAY3rMyTRCTp1c4qKXPs2qcb/NMr+twz7G
         JqzQhPT3W0RdHIDOXURNPjuZxb4IqnAyqUES6D/lBlrgR77LZWz3nv+3gCl1Pl51ayv/
         JF1qSsT1NG1JqfuHgcAkqEc2xchmJZLD0ml04XSWFMPgHc+jLgXDNgM0w1LMyjPZ8SQE
         Ph+g==
X-Forwarded-Encrypted: i=1; AFNElJ9wtGEVycnmbCLEm2wPXV6RVFMl6pyl2UVIWpezmMF15GdCG2NAT3zuogAvebRjFxzMzDaqCZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9zWNtbqIklJ+ec0tkh4aab3aLrWP6zQlitT1eAEdx3dv/2rN
	Om+GNMkMc4fqrZrP0eAM6An3Nk8yGJL5alcU+V3urXJKJsTzwd7P2FhU
X-Gm-Gg: Acq92OHaCBlCFDci1TcQqfZaThdVXKe4jQ2wMsCRr/m/t0cELY3t7IrcEu3z+hr/laS
	dAT/tVMYovBEfQpYvXS2pH+kYyBC3CL+aPN+Z8L7IbTbUWolmADK9LWCMr/9TeflmlMgAfueAN8
	paGbnDnoJKKcIgQ+Bvm7ibgJz9LNMnJgbFRmF1yHaPUL/pxDr4HwB8WfueLUTpBcqCGuHIk4ftk
	TTWHL/yPLhfuiK/LFqAQXQAqV23L97Tbf2mdP2Ys3FYfnl2tsQJzSQjxpFjnDo5BH7daQsX0Tte
	wn8jTR/KrtVyCKd+J+ReOjLn/5Yub1dv6UxjiO0NLgvB5aPoGdj/6YiiD2ZpAEzZXTfqSS+O8Mn
	AhHLBJBeEeGh2KW7JqH/5piHrbktxVDK1Fo680fGI1Tx2l8AjtXU8v9fxmUpqsLqQao7ixNyOvD
	qZQQw6e0OyAcLuYFJ5DrW5Wl7m82YiErfmzDRwDl0jEMECdsFLVA==
X-Received: by 2002:a17:90b:3149:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-36951cc9a37mr22675267a91.26.1779276212534;
        Wed, 20 May 2026 04:23:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:3007:3:7ce4:b643:7525:b52e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369515895d2sm16922217a91.8.2026.05.20.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:23:32 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH bpf] bpf, sockmap: keep sk_msg copy bitmap in sync
Date: Wed, 20 May 2026 19:23:27 +0800
Message-Id: <20260520112327.189660-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289902-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qjx1298677004@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7266958CAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The sk_msg scatterlist ring stores the actual page descriptors in
sg.data[] and stores the copy-required state for each slot in the
parallel sg.copy bitmap.  bpf_msg_pull_data() trusts this bitmap to
know whether the current slot can be exposed for direct packet access or
whether it has to be copied into a private page first.

Several SK_MSG helpers move or split sg.data[] entries without moving
the matching sg.copy bit.  In particular, bpf_msg_push_data() can split
a copy-marked entry and place the tail in a new slot with a stale clear
copy bit.  A later bpf_msg_pull_data() can then skip the private copy
and expose a direct writable pointer to the shared page.

Keep sg.copy synchronized whenever these helpers move, split, replace or
remove scatterlist entries.  Clear the bit for newly allocated private
pages and preserve it for descriptors that still refer to the original
shared backing page.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Reported-by: Junxi Qian <qjx1298677004@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Cc: stable@vger.kernel.org
---
 net/core/filter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5fa9189eb..2fc21b87c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2724,11 +2724,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		poffset += len;
 		sge->length = 0;
 		put_page(sg_page(sge));
+		__clear_bit(i, msg->sg.copy);
 
 		sk_msg_iter_var_next(i);
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	__clear_bit(first_sge, msg->sg.copy);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2754,9 +2756,11 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 			break;
 
 		msg->sg.data[i] = msg->sg.data[move_from];
+		assign_bit(i, msg->sg.copy, test_bit(move_from, msg->sg.copy));
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		__clear_bit(move_from, msg->sg.copy);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
@@ -2784,6 +2788,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
+	bool sge_copy, nsge_copy, nnsge_copy, rsge_copy = false;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
 	u8 *raw, *to, *from;
 	struct page *page;
@@ -2857,6 +2862,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = test_bit(i, msg->sg.copy);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2881,24 +2887,32 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 	/* Shift one or two slots as needed */
 	sge = sk_msg_elem_cpy(msg, new);
+	sge_copy = test_bit(new, msg->sg.copy);
 	sg_unmark_end(&sge);
 
 	nsge = sk_msg_elem_cpy(msg, i);
+	nsge_copy = test_bit(i, msg->sg.copy);
 	if (rsge.length) {
 		sk_msg_iter_var_next(i);
 		nnsge = sk_msg_elem_cpy(msg, i);
+		nnsge_copy = test_bit(i, msg->sg.copy);
 		sk_msg_iter_next(msg, end);
 	}
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		assign_bit(i, msg->sg.copy, sge_copy);
 		sge = nsge;
+		sge_copy = nsge_copy;
 		sk_msg_iter_var_next(i);
 		if (rsge.length) {
 			nsge = nnsge;
+			nsge_copy = nnsge_copy;
 			nnsge = sk_msg_elem_cpy(msg, i);
+			nnsge_copy = test_bit(i, msg->sg.copy);
 		} else {
 			nsge = sk_msg_elem_cpy(msg, i);
+			nsge_copy = test_bit(i, msg->sg.copy);
 		}
 	}
 
@@ -2912,6 +2926,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		assign_bit(new, msg->sg.copy, rsge_copy);
 	}
 
 	sk_msg_reset_curr(msg);
@@ -2939,25 +2954,33 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 		prev = i;
 		sk_msg_iter_var_next(i);
 		msg->sg.data[prev] = msg->sg.data[i];
+		assign_bit(prev, msg->sg.copy, test_bit(i, msg->sg.copy));
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	__clear_bit(msg->sg.end, msg->sg.copy);
 }
 
 static void sk_msg_shift_right(struct sk_msg *msg, int i)
 {
 	struct scatterlist tmp, sge;
+	bool tmp_copy, copy;
 
 	sk_msg_iter_next(msg, end);
 	sge = sk_msg_elem_cpy(msg, i);
+	copy = test_bit(i, msg->sg.copy);
 	sk_msg_iter_var_next(i);
 	tmp = sk_msg_elem_cpy(msg, i);
+	tmp_copy = test_bit(i, msg->sg.copy);
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		assign_bit(i, msg->sg.copy, copy);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = test_bit(i, msg->sg.copy);
 	}
 }
 
@@ -3015,6 +3038,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
+		u32 sge_idx = i;
+		bool copy = test_bit(i, msg->sg.copy);
 		int a = start - offset;
 		int b = sge->length - pop - a;
 
@@ -3029,6 +3054,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				assign_bit(i, msg->sg.copy, copy);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3045,6 +3071,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				__clear_bit(sge_idx, msg->sg.copy);
 				put_page(orig);
 			}
 			pop = 0;
-- 
2.43.0


