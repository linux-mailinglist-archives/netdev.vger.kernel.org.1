Return-Path: <netdev+bounces-294321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3pWoHWQaH2qPfwAAu9opvQ
	(envelope-from <netdev+bounces-294321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:01:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B0630E7F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:01:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XIJoULXf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294321-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FB653035244
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2E3FE356;
	Tue,  2 Jun 2026 17:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2D3F1AA0
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:52:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422729; cv=none; b=CpHbc7ipkoxPJ9jpWHlHEapZxMYKdRAtPsMFxiODEGtvNoRlBcwyS5aDfaAgQWxs/gU81+N4v653GLtFgoJ9s9GOC+k0vQO52DLNDqE75r58AU+GlQsVqVbFpkhvdOrngQ+lu/5CyM7QmHgnffL87S4qFd1GZTk3h1a3J+qYMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422729; c=relaxed/simple;
	bh=6UxLPoosSjjK0FHZRJwwD8HQ+9fJ2wKBoHOJ2mgOd+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhEd81z3G3gMbVopzaPbt/sbDadyEJ3ZsJLzqyialpTP7OWH+ADYj2D1kYwm97tQQSLn6JkaLzhA7OuvlcT9umbx7qyIPMo/QAJ4QNPr0zbV6m1HQCi3n9D1fLSnGp+sbIzxh5bkqkFFQaOBwaZuBPzSID3AXpvEWYmBJzrUcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIJoULXf; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422f395a4aso1951586b3a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780422727; x=1781027527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylImfVggkiWj0J+iskvbahdquQCR6qXaQDQ1DoXHEas=;
        b=XIJoULXfVnDAAn+kjmNMLdJOKCW0VXRh8nbXOqPcBWvsQZ09xhJ6liCofy0ZW4iFJI
         cM6EOVUFJk+18eULkPpkb2sNdSbGJ9ns2L2SlJ7xzPras1jwNLd4FvTWd0T1Ox7+QMBG
         0UY5gNkdIDqLgRfJq/HuW83XIjZrzjLsc7CJD6exFC7GiVyknhUnLLRoboV1Z60Xgq3Q
         i88kifYBul5UI5+ONMSr1iQkcF5zIKgc3t/ptpr73dAJ/+iBdDiIxhDcC1J4ondMDfm8
         GKL3BuZETSwrhoqdgP2OZtAZcbLV0jxWzGY+ZXXSUNHcoJ/7HbufNS+4Cn6jRTltEgW4
         Lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422727; x=1781027527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylImfVggkiWj0J+iskvbahdquQCR6qXaQDQ1DoXHEas=;
        b=bP8PbcDdJLlePJ4aqBTdbvGv84il9M0GIaWsKjwwZt68U740V/xcqDOvtSWQ+HlM/S
         IODHXUjwgdf9Aucrh2OUb7Okw1yw4PbMr8QVUHhQK9WLPRRQ48/MHiKESMHpkixDjhCp
         l4vdvKrwgiMCBDnDFw5MaOgd/jOadx7+w3dVrFRJd1kB8G+K3ur4MjKeMLY9nengb2iI
         cuSbToRP/F9In3hU2U8DGLN1GMwfUbtAIQGyKZJtDq9wjEVkmWtAponjw9Pr6SHQu9tq
         RV42PpNJDkjxqwNQ4J1zV4CNCtYdY+5RQ7RZeydU9ZEr8qShs0qBwcNNIc/iBiciWyNx
         cDcQ==
X-Gm-Message-State: AOJu0YzLWl0MlHeqEy9vnUde8aezOyqDynzWMctZVchR5QZlZDKylzqH
	FbLTXSXHDXc8aCY6wA1kGQNhRzaURImGhCIJ0wlcOXSdwjJYturaChB7
X-Gm-Gg: Acq92OGrfgHiZ2NGbk/JGt6CNyzwB0AuNyG7hi86GdyWuQ9JOEybEoeNxbHndtPbnsf
	z0NM8mzkZa7F7cvrK010pJxOPlnR/2ljGBqKBOmnP4kJAAnJOpoeJxGbXJ7glGZ64nttOi0xDv1
	Y2kpnTSFV0jJ6/zyKInzzCrjzUVOfn8pNszilPb4k75BHd3dUiorTkGbDHV6rf8X/jZyHEo3Y/y
	aLmVQn4XSS38bUJlbUjXuLGuEvgXmZJheKoMPYwgKrSyzmCvK1Ci0IINsHrdV5awMkNXxHqbGgw
	TphjwuqwFM0nXphOz9A/3dqLLd93Oy2f+EamF/ySq1+6s1tCzEKv0nWwXiVDAT8k94kaWu3vVo5
	PTQWoSs7hyCjliUwaFj6bSJEwzQOH+9TxdKYuKAwyCJw4lThAHxvEWduaWWxSp3q3RDq5AkIwrY
	B9/IxoBtLjwV5kUSVfXfjyHao=
X-Received: by 2002:a05:6a00:420a:b0:842:4f2d:c4e6 with SMTP id d2e1a72fcca58-84283d5b776mr259847b3a.9.1780422726588;
        Tue, 02 Jun 2026 10:52:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e02f9sm426339b3a.48.2026.06.02.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:52:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/1] bpf: Silence unused-but-set-variable warning in bpf_for_each_reg_in_vstate_mask
Date: Tue,  2 Jun 2026 10:52:04 -0700
Message-ID: <20260602175204.624401-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294321-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C65B0630E7F

The macro requires callers to pass a stack variable, but not all
callbacks use it. Add (void)__stack to suppress the clang W=1 warning.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3dd2d21230af..c248ff41f42a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -582,6 +582,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 				(void)(__expr);                          \
 			}						 \
 		}                                                        \
+		(void)__stack;                                           \
 	})
 
 /* Invoke __expr over regsiters in __vst, setting __state and __reg */
-- 
2.53.0-Meta


