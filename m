Return-Path: <netdev+bounces-270604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHtlIgFuwWnDTAQAu9opvQ
	(envelope-from <netdev+bounces-270604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:44:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 038252F8BAD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24611324157A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADB3BF66D;
	Mon, 23 Mar 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="eL72NYEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E353BED40
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281698; cv=none; b=A2JymbU12THYPpUh8CKFHO0lnNYc0WBPxqKO1T/s8C4uirS+imnX3jip555Isq3rVwVmx5B/GHnqGVri5et+/GI8bfsqSrJq3TwyO3IeSkB1hDoauclF/kcyPE+aFsE6eWyiqvkqk1sPhCnAMOTayv9ratYmDcJKfUIrsbdS/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281698; c=relaxed/simple;
	bh=nRir5v+6LbzdGv9qh2mWXxT+gSGB0K8Hs1BfKYmoCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+Pd2MG6nSveJ1ZD9scqpdgte/B8vOEK4mXkd8K8Lv8WhQEhKsvdiFDma9l6lR1cC9gzrzGEEUgVJtTgr7UlR81TT8PJ68HUpr/C3vzCkUZh3kJ+jTACylwbpi8AvcdDomHRDj0dNzlrfpaZGFN4i1XP3oWWpi5ouoYBWO1eLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=eL72NYEl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd7c372929so382171985a.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281696; x=1774886496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV4QS+yC5xdWAGmIg+LeuXzS9pCzT00lLs26Yre9ABc=;
        b=eL72NYElWH2iC+/O1dmlJJitOP/i4JgbyCbHwvkJIV9nicRPRbCmh3INfW9Cvc+Fss
         ScNnJgOAjYoj6017h7+Eex+P7DBptEMHyjD3rV0T82bNfAG4FaVJ8M6egqeam5iISaoY
         yx8Vz3luFBC8AfR4Hc/dG6xaMjTS/TFRgAkORnyNadABV2LxcKQgfM8C6AfwXl4e8Mqc
         cZue/EyTQ2fFKC7cHvMrSKnuvY82Jk669RhdPK6yEY7yOBAPDjWXmrjigU7Ng36OYif1
         fBSQwQ0MmidefDnfw1cxSfZ7VGJQ4bp9ok3JQPIqhkjllGoxILlhJ4Y69gEKU+2zAeaB
         Jf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281696; x=1774886496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BV4QS+yC5xdWAGmIg+LeuXzS9pCzT00lLs26Yre9ABc=;
        b=EtCNb7BrBhTvwHwQ20fn+oWB9oeisRt0lyKUeXK10ff1vMQP3caa2en2Do+TTxpHst
         fL4NQaTa6doChb8bBpvCSJK6y0sTZc5jyIJ2jNntKU28Uz7Zjfj1CQYzftNObgbFUZGF
         uBU0uBLHjhfqosjNDLk4PGzXW3otsFKKwNUbq25MFBlkuns2PL+J2aR4fMiDGVmsUuFa
         9CuOYJgjsX3oxQ1sHYa2eQg0ChKYn78bkrSgjPxz3zGYGT9OSHBrAHFV/iW8yjiFL7B0
         SF45SysJ7jNTtBKuNdXk/qxGWmXHoa26xhUars48nIF/ufmNYp/j9fblNgMv5dgToOvF
         MOqw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJFYXpTLnIo+FW4j89cGAIS4zlCwKb5yx2zjzHHGZM3B6sOcBd20ksIvngbVKcCSmSLWnSSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ktqjrOzY7hTmVDsRr/FmnBPj+PheP5r9DxW6bN4vHiTtvuAU
	arZHFVYApWuJYsQ2jv7ytAGCHy92KMoyykuiwzqvvu0f9woOg46WuvUWHUjhE/uF6E8=
X-Gm-Gg: ATEYQzzCuiuNK8GdEv32pFLZg0J0tJDW0qw/Ho8mDMu4LmSOXEBPLU7wdZw0tQMpUht
	5oLQ5DF+5LsIrWtlJ5mOsfpXAH1fCpyeWMKKp9lcJIposd6Jm5TlgkbjhZ1bJH3HFNPLkf7b4/I
	YAOVJR3v7VsEe7mNDbh8QpUrkDCtm7chINtkB5M4QYXG93Y6W4WUNd2Hz5TrWzPPAc7jbdMDEOG
	af41nXaqrC0yL5eCHOgXzGhYftN+DQLeKUtAaefq8i7DAFacNOWL5tekT0SNdWfaNuBgDvhg43K
	fO4iwSX9bGC1lRQMmQEMgtfkG6KTqfngnEwzp0Py/wK5zJkiaUQaUq+q+e7WABUAzuidV+XSb3A
	IoWCAxLORld8f7bpnDzVan5DCLnKBrPhXA5mPRryF2szmb/aO3KaTOJXv+1nPoUx3mzi5b7xpei
	tmOtpbUJQHJWi6Fqbs/3IxJAN/dn68qDGD0bDkHGQt9u4xqQmiW3CTWC86iBOjU5SK1Q==
X-Received: by 2002:a05:620a:4707:b0:8cf:e933:d5e8 with SMTP id af79cd13be357-8cfe933ee7dmr479191185a.44.1774281696047;
        Mon, 23 Mar 2026 09:01:36 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:35 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 16/19] net: devlink: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:35 -0400
Message-ID: <20260323160052.17528-17-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270604-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[bitbyteword.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 038252F8BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace trace_devlink_trap_report() with trace_call__devlink_trap_report()
at a site already guarded by tracepoint_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__devlink_trap_report() calls the tracepoint callbacks directly
without utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 net/devlink/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68a..d54276dcd62fb 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1497,7 +1497,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
 						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
+		trace_call__devlink_trap_report(devlink, skb, &metadata);
 	}
 }
 EXPORT_SYMBOL_GPL(devlink_trap_report);
-- 
2.53.0


