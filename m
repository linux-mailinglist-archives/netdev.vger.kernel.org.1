Return-Path: <netdev+bounces-103182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C76F906AF3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2431F24044
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741DA143753;
	Thu, 13 Jun 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJooeywx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EE81735
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277943; cv=none; b=lfH9DCh65r0ZsJwdZkqTaBkGZvCU5+DGF+LNLL2ZHjngJt/5wRy2WKB5ZrvztkS/9AqU4lNutGIrrZpWdz7Ao4mFNRM08Zw4TP7Qgc2FySPlDCLfeXzHWaE4D5NOBDbCx1t6RDRwMSwzC33RPjnl8q/CdF9XXYuTLeknvst+fLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277943; c=relaxed/simple;
	bh=dIEuACjsltwpJD0V+bskvqcb6UYaTtASIQDE9vOPI5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pRVY5kYQ+SMdY9XXD9THp5BcH5QnRiIEEqzkMK+nVhdYV5wSe1+AiX94OMwILBMOW2bLre+0r0kID/xTHyyf32XGWllmQPwaLLl4dLvPglkq8oPY9ji7VD61IAGfB0ATrTGZ8W/hi/UrpYX5YQYMnKLxkBoj9LAxprXNXLbt3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJooeywx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso1368875276.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718277939; x=1718882739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYU5Qi8biKRQ+V307T1KahsI7+1YeIx8/OH0uEw2Xw0=;
        b=oJooeywxkO0d4Pj61kKsLrSQs1B3a1Tss9sQOUwYGjbxN7OGgVbqr5mA1/xQIyCyz5
         S51ISzftTY8juze5o5YpEJSHgRGyfoPFhLM5EXukrM8F/8LsTGYHuebR32fIIuROY8BU
         Kbe/oH7otdcUh8PxEgBL3mEcZV/xO9qk+dd2/xLXUw5humWzrs5A0T2GFAZrcN5LxgV4
         KIOYZpDUl2d5QqCJ3YzmpzrTtm+1o20q9dMQaUeXFibm57f28s5Eu5o9sWkwlV2/tSMb
         uxaGeU+M2MXdXEVKNXS8EI9SDNDEApRGHG5QluX6j/qYAmadGKs7lqDuWBTDxWpn/1OP
         ANJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718277939; x=1718882739;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYU5Qi8biKRQ+V307T1KahsI7+1YeIx8/OH0uEw2Xw0=;
        b=LTAlTum9b9WhjZAr85TT77QE6IO+yy1UhQ2Gvd4CYdoup5UJi5VJyOQxIVPxh+2u8q
         hZyHtqymmmxAHY0qKAbEOurLYU58//6zQF0246Q0Z2TfRcaY0GCMuk3vKUfoFO5pQpfh
         0AuU1/9mH0SM2gTFUDc0giTms3nKUBkVnwEkjSH8VBZMy/EZeclvmJBOTXuIMM6HbRik
         StssUPMgl5fa5dXC09c8ewZ90vBYnNeAZuQe4o8xxXAIXFMPL6P5t6b2YJMCMec51zC3
         prHTXkO9xfu2wPpApBDZ2ZTd8/AlehotLptEC/tLaomDF1Q7+geOMrKD/WIe5b8e3nvT
         mHVQ==
X-Gm-Message-State: AOJu0YzDthfgC3TIew40s8o53OfK6YC2oFoUPWAQWZn2WhXPUHMCoUFd
	ex2PW8se4MM+S+2xOgTxsTJ3YEEBsd/2t6tidn3aJAjKBvLCrRgjrON5iAplw8L5r72iKA==
X-Google-Smtp-Source: AGHT+IE5cYOWPRlw6S39TBxcIhI0UJc6usmRvvQ+LAF777UZDs8ja6+2n0iUZpH3/qgQ4I32o2LJxR91
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:39d0:ab84:9864:b0c6])
 (user=maze job=sendgmr) by 2002:a05:6902:706:b0:dff:4a3:2def with SMTP id
 3f1490d57ef6-dff04a333edmr496451276.10.1718277939510; Thu, 13 Jun 2024
 04:25:39 -0700 (PDT)
Date: Thu, 13 Jun 2024 04:25:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613112520.1526350-1-maze@google.com>
Subject: [PATCH bpf] bpf: fix UML x86_64 compile failure
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..7a354b1e6197 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20313,7 +20313,7 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 			goto next_insn;
 		}
=20
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
 		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
--=20
2.45.2.505.gda0bf45e8d-goog


