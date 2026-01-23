Return-Path: <netdev+bounces-252894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF/IJ8aqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:07:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04878CB2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A31303EAA9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C982F6199;
	Fri, 23 Jan 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KXvPPUmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291C2C0F78
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187934; cv=none; b=BISOb9uPx6cn5ivySczfHzY/3YrHljoYH56UghpBZdMMkh4sSqb8sRTohbteLsfZvzzH4Yu+6kASD1gY5bMXgiNwuoCivVGsdg9DeuKNaeq5o2H2acScFlLdQyrx3wCnGIOwK5GJGR6qmTtP2hRv14E9M3xQYt2L8CVHo/9pDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187934; c=relaxed/simple;
	bh=dYBtLZQZSXmjttUMkUr69cwe/3Al9p+VVefAv8iNiCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JD+ChN5eXzrcyUyqGSXXG48McvLqdJJU5hkw7J2tJyzWf+lHSrYCBUWgwBMlFqJBKRz00Z65gtdczgD6nsPjHH0PJCSwqh861OECet/WKPvPTU/b5mdnZhGBtQs6Mgtg7Ui7kic7G6XWndEDv5b0eu3zoic1/fqRaVycdy1Tuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KXvPPUmU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8876d1a39bso8438766b.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187931; x=1769792731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpBi4zuZaxY+L1YIyml9GR1d7OYtXHDSWry/Nv/uf4c=;
        b=KXvPPUmUGa068dBMkukVQYd4yPgewJMj7bEEI+I4qFk6guahu76vGGhE7aDUv54E+j
         qQMKRwSGnp7xjDanEExGiS7eHtfe9VIL6B0AvEFijvbeigOn/DjcGRca+HJInosuFqkg
         hxtlYTiTFeGmfdDelj7CVRCCA2210bCUSfZP8ROQs2IH/xXQovc7Fx4xGQ36R22Y830L
         hxzOqRi+gkkzq+WduE5t1i3SutgBawhHVYpQHro7S0OEtJcKu7GkmWVno+U5NwyBn9cO
         tKpmkil++H9Y2NsaWD0rsZ+OeOChB7MkAIXDUp/QSG3Qg5tdegP0WNO2S2je9E/DL1yw
         PTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187931; x=1769792731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpBi4zuZaxY+L1YIyml9GR1d7OYtXHDSWry/Nv/uf4c=;
        b=IDU+5tzd0cVU+O5+bAn/5ORJFCE7xyg3rsS0Ovq3J+qL/QYslpnIinJPtbe5MMI1Xw
         rfbzOsz9rNcQsu3yoBbTByT54d/iVrU0q1NQw1GmT8ZcCR7i7jVnJfhHRI+N0KSr6ZEc
         AVdT7KKIoYku4NcO5hA01SIlD9YxEbap2Vpy/mcNTf5lEygmsXWs5YoxRa9o0GMbJpiE
         xshYnSqlpJ8sPMaY0cISVV7yCQFFmmIsbNwhyJ3pbe//3kyYRiK0uFweFTB2epQNm4Xa
         i/6LS9DDdT/DAXLAhksQyxcIMOVOA4EWZyQ5zwyEe6ZgMR425zmR84agND9chnChte6+
         S26w==
X-Forwarded-Encrypted: i=1; AJvYcCV1zCTYNSxTGy6hnz/Qg8SQwCvhMg6vKlYjb6xZlvjMcOKxuNqGd4FbFZKEHx7+WKbHkK350dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyunonxXNCUAyTiLOQ045wRL4nXI2Pv8FX24pzbJkyvbCjPlxIL
	x97XyHH/bD9QKGkrJ8GCxCaMjmSVOs6dMJ6WZBJFEGQzKWhqUliRTHumRPCvtifrz8U=
X-Gm-Gg: AZuq6aIxf0cLKoiWT8KuOBDCCeVk38EqPNcTxDlRVpdRZhGWKel3ey7qy6QqLHtaFaz
	7K4yYa8ldTsGVQFB8iuaY6Jl+3CznjxuLHLui8XEWdMNYgEnJ06VDwWZ3ArzyCxFHTGjKlQffFb
	QMw8exNvxlaKwRg2w/zlKAkHa3CU76qFLtcN8rAFA4FVWMPBBTDpwXMDAopjMWPbD8wk8WRsZTw
	rrbw6oj0y8jy7KbB1JDK2lW6dT/jQElknkPqjMg2BX+PU2IXsd72+XaM/6hHGvml+ZpLHCVwCUh
	437CusfgjgbKrJhDJbMM70/4L5LXzUnowWb9tciLS9wUpm9KOesSygLzrvLqfNWeIN4jLLHNA/r
	jq53T/PSjbCA2jAB/xGoq3bkxrW/Mau+d/sJj0jgQnpz6XXPO6DYnjqYIM+N3dnldcdddT71oOk
	h3bnuZ/FFbVzMLhzcm0453fty4upocLNArpTVRLXUB8YgnOYOFC/0=
X-Received: by 2002:a17:907:3da5:b0:b87:2471:def3 with SMTP id a640c23a62f3a-b885adf4732mr244050466b.55.1769187931127;
        Fri, 23 Jan 2026 09:05:31 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b4184absm134752866b.27.2026.01.23.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:30 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 0/4] Switch from kfuncs to direct helper calls
 in prologue/epilogue
Date: Fri, 23 Jan 2026 18:05:17 +0100
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2qc2kC/42NQQ6CMBBFr2Jm7Zi2GCyuvIdhUdopNLaUtEAwh
 LuLxAO4fHn5/62QKTnKcD+tkGh22cV+B3E+ge5U3xI6szMIJkrGucD8ajDQqLAZLFJwI2rlPdo
 UAw4p+thOhEboSvLCSnlTsF8NiaxbjswTvsOelhHq3XQujzG9j/7MD/9LVf+lZo4MSTZSmvJaM
 CMf2sfJWK8SXXQMUG/b9gFpgPJA5wAAAA==
X-Change-ID: 20260112-skb-meta-bpf-emit-call-from-prologue-d2c9813f887a
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252894-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: 0E04878CB2
X-Rspamd-Action: no action

This series enables direct helper calls using BPF_EMIT_CALL from prologue
and epilogue code generated by verifier ops. The goal is to simplify the
calling convention and remove kfunc support from prologue/epilogue, as
suggested by Alexei [1].

Patch 1 adds the infrastructure to mark direct helper calls as finalized
(already resolved) so the verifier skips the imm fixup.

Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
for the init prologue and reset/destroy epilogue helpers.

Patch 3 removes the corresponding selftests that exercised kfuncs in
prologue/epilogue.

Patch 4 removes the now-unused kfunc support code from prologue/epilogue
handling in the verifier.

[1] https://lore.kernel.org/bpf/CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Swap patch 3 & 4 to avoid selftests fails on bisect (Eduard)
- Rename is_epilogue flag to finalize_helper_calls (Eduard)
- Untie mark_helper_calls_finalized call from epilogue_idx (Eduard)
- Drop review tags for patch 1 after tweaks in patch_insn_buf (patch 1)
- s/__bpf_base_call/__bpf_call_base/ in doc comment (patch 1)
- Link to v1: https://lore.kernel.org/r/20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com

---
Jakub Sitnicki (4):
      bpf, verifier: Support direct helper calls from prologue/epilogue
      bpf: net_sched: Use direct helper calls instead of kfuncs in pro/epilogue
      selftests/bpf: Remove tests for prologue/epilogue with kfuncs
      bpf: Remove kfunc support in prologue and epilogue

 include/linux/bpf_verifier.h                       |  1 +
 kernel/bpf/verifier.c                              | 52 ++++++------
 net/core/filter.c                                  |  3 +-
 net/sched/bpf_qdisc.c                              | 76 ++++++++----------
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 7 files changed, 63 insertions(+), 251 deletions(-)


