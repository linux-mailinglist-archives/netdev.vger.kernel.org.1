Return-Path: <netdev+bounces-292802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b2y5DAuPGGq4lAgAu9opvQ
	(envelope-from <netdev+bounces-292802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF25F6BFB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DF7130586C9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939738D014;
	Thu, 28 May 2026 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo81BoRX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED228327C18
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993847; cv=none; b=ulsotvugslPO/n+Ded5bH7vQCjfQMDBjLt6gPUPtv1QPYchp8Ub2Y+PBJLNVwG3ulHl5NR1bwA5WFdDkvEavfKUoEdseNng7EkUa+jKR67ge3e9pTmrfjHWOarWwEWlZOCgNXfYLNqRcLt/7F+e1HRDroovhCBoHPmGObUgRjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993847; c=relaxed/simple;
	bh=xhvCR93Chcb4L6BRbBHuW0ldf/Xj6wuD05JOOlD1+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW49LZdcPlct6bzLOCeaD7bSLCEahfkhPHAMlGKP33Q12CvX3NIc0asX4KBpc4IXo77HZ/X54JgZ5MDt67bBEOcgSaDheiy+d9+GpRhZejf46W1ZON0r8p+rUhaWp98KNqEqQ1rzyspdhiPjXLapMgg+K9T5A9W97Oz4TM17/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo81BoRX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48fde648a71so87116065e9.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779993844; x=1780598644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2VIA2i1G7IQ2yerY2CB0XW0MKLvQf6x+AiTk80ADuE=;
        b=Qo81BoRXsYM4dsg+jaF0p5NTTy0vnLCbKIk3mj0jATLN3yd9kurfQPCLyH0IMfvvE0
         tmfJ7GjcOQZHpzvTv6ph3edrLMueNjCemquqh1sOm1TL7buBvc5cGTEZBRGp7BeCowl/
         YUPf+VqoRp9zFHJ8vyRhjr0k1UQhn2bfPUBvSQenQDOqRQ8cFxhlhBrVI3pT36/ZzMq3
         dRLLzmH2m2PNepcXlAKFSaD7NM0RTtazIJPBZJqM6Aube4dCgZQpDlHwIXT4CqdKeOOs
         2nBuoR2QU+O2pJKrrRXzYUSU/Y+ZpfsAusebdSgIuOSdEyWD6ZN9Wo7X7UikM3r98TgC
         3YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779993844; x=1780598644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2VIA2i1G7IQ2yerY2CB0XW0MKLvQf6x+AiTk80ADuE=;
        b=ncBGp/lI2MHujuKeJbszuQJQx/MmIISqTvLjkboOCx558BNBif4kDtC9+XslHprfoN
         vrDH5WMxYujbv2LbDNfsOFoK7Gg+S7afG9781ZJWaCmnXmHpkUr2DVRCKwm1dMH5s6hi
         nWHxSPmoVCN3VMcknnZ0JqAAwkC6msJF+7d3C170DwMmEFwoRM4r0xPDvQdMneRSuy3f
         mp2UZcc4exij1RQ3Xz4Ro57iW/Nq9VOtNocnay36rDTfI2/4CcmNpUIUYBajC3Hvuono
         4GCJrexocGtV2/1mnnDGK3WF4JKIUuhpGrOHYexNvxttp+ItMNPunZBcP/WSxCp8M9oB
         B6Ew==
X-Forwarded-Encrypted: i=1; AFNElJ+4gkCZrU99j6jB6pyAoApOcb7QaZb66gw0aEkFhZF7k703OzM+6ZKC5UCwPkyWc5/b2lTMlKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEj8b+DW/JWlTsyWdzxxqh6cXcmiG1pZ/bVKhSVvkYfh3+MnoM
	xxHO8emG6ER72u2fasYkjlzuSDxOmkpvQiWSL2SU7HEGp9QwOThZp1iK
X-Gm-Gg: Acq92OEBPg5/5m5vvyXkTKJlLL+7rz7QiRAKx0NzqTpn1rfyVTpz4VQ2ik3Ro7Sswk7
	9rBpBJceZJ/zABWds6474R48BNBVsEtfwBT0W0ZCx6pH+SNt7hhRycUwJsGS4zqVGLvVsthgxJj
	L0y796FBcFNkhIs9KJ9wMk/NhGmvGiJLY0n2Ff0VQLUnSUSmrDjhk+J40rrNQvxEGSRmdC3xPLS
	j2S9NUB6RizpPqBOODiYyPF+tI3f9t+0OeJ9dHDXfdznzUanN7RYdDYJASRDWq//DTaoHB6t8Kt
	DhAQA8OVTGScvm/SmRr+xgegk5aKAkOUFGD8yEVfYkeUg2o1w/qIxAWxyI5fVEVrnTCt1ek/+8Y
	ShHlJ4zHpvZ1Y6T4+kcES4jqjCqvGS96CBBWJI9U95s3QOoXrYdlOJGEhMaCi19di2FasHvz6zT
	DCbEf1B68Wuew5jd4INje1TDKeCJSr3fU8Fc9ETRaZ60EQoWo5qAEOtbWwL0VvIIEzJ5AwBI2Xm
	mxkP7TDRVYHJZzI7ErGXSO+Qhn7sDCMG83sOjZx
X-Received: by 2002:a05:600c:3484:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-49094785aeamr43001725e9.3.1779993844113;
        Thu, 28 May 2026 11:44:04 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909236ad1fsm60113675e9.5.2026.05.28.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:44:03 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	asml.silence@gmail.com
Subject: [PATCH net 1/1] net: skbuff: fix pskb_carve leaking zcopy pages
Date: Thu, 28 May 2026 19:43:53 +0100
Message-ID: <1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292802-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CCF25F6BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When SKBFL_MANAGED_FRAG_REFS is set, frag pages are not refcounted but
their lifetime is controlled by the attached ubuf_info. To make a copy
of the skb_shared_info, we either should clear the flag and reference
the frags, or keep the flag and have frags unreferenced.

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() don't
follow the rule and thus can leak page references. Let's clear
SKBFL_MANAGED_FRAG_REFS from the original skb to fix it. It's the
simplest way to address it, but there are more performant ways to do
that if it ever becomes a problem.

Link: https://lore.kernel.org/all/20260523085809.26331-1-nvminh232@clc.fitus.edu.vn/
Fixes: 753f1ca4e1e50 ("net: introduce managed frags infrastructure")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/skbuff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0d3cc115f2e7..c02f0a507ba8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6823,6 +6823,11 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
 	skb->len -= off;
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info,
@@ -6936,6 +6941,11 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		return -ENOMEM;
 	size = SKB_WITH_OVERHEAD(size);
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
 	if (skb_orphan_frags(skb, gfp_mask)) {
-- 
2.54.0


