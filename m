Return-Path: <netdev+bounces-103327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656A9079E8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4F1F2227F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51CE149C79;
	Thu, 13 Jun 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f36hYXdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08B1474AF
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299919; cv=none; b=kKXDWUg6HbAqRNMnipkBH3P1RoVtonOTAYPHMA2KqpCoXq+B9WTnMkLBej5vTssfXw8U/N/zdKH5EZ2lEBDCqoOmZbi66Qk3QqNcsG5gvjcapCdQ0ha2TWDwzA/GtJVBnCM9XM2ypx8fF+va7Lff6KL1UagUN+4l/5CMPKp2pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299919; c=relaxed/simple;
	bh=xbE+/ETFeEQlT4vgIYucCFchmJYHLBJk8LKXtJ10G6I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7cSuUGND6yoo56RL4ioe+2+Zy5H+SpU6Hglg7IorXiL4eB+oRAh48RaV5oBedCK8FFknK8DB2XY4s2rDaaHwmBxwzc9NLZFq/ObEvEf3B3sTOiR7Otr5lygjYQ494FnbPFBNJsQpSZn7kUI0wKGx0TkRRATJc6AoHEhkoZ2rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f36hYXdC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631d53af5e1so7363917b3.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718299917; x=1718904717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcnrVmBX5qHwP9gdhcfAMKGSVU0cmZnsSa23d9Ql3w0=;
        b=f36hYXdCoURs7v2OpnN7QnGwpF/vmkr62VaKj48QClWCxAxzUxPkL/N/mvAwOAHh4s
         dSp/lNzvoVdQprX6AQWr79LlvCnxPDvgi14V9u1qkgAOZVo3rRBSQe/ftMQlMiITgIac
         K7PyvJ90kAODn1DdwlSl9rpkBQOgDGfP5ccyG8LstDPa9gUmVbL5a350Bc8Ip51Ryta7
         2GSSF+bQMppn5wwgSn6+WwGYQINGqYyj3laqoXEDrhPA/kXawHgyJXAffigBVN1JGsvO
         k6M0QfSM3YXHbAHWEBcG9rU7Mb0nYAtDY8ZTYwLrSj849ohmFQBJkP6F3FlQDLaF4i5o
         acwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299917; x=1718904717;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcnrVmBX5qHwP9gdhcfAMKGSVU0cmZnsSa23d9Ql3w0=;
        b=Q+4XluSA6hyc77QpvBv+Gswp096Xl1PmLTKlOxo0z9yJzHq/hvCTGfS7dPO5xZhFMN
         0OkGJLNM9mspMtWWT3UqLHqPNxRubbsW9LJBGAPa15goBdACAnTLz7PFor9iH5HLi4sf
         kifrN9YmQxtipGRC3K4qw0s2SyMBCb4cs4UXO7IiccesMOy1UngCOCpH6tnH5IOaoknR
         TCFtWyu2X4uERSM6q8wHSDB1UMgilXYKUBkRNn+EIscHW61jCpENnJ6j+rdWwu/L/AWo
         HoG8wQSWS0HHiSkGu0S5DbhwH1e8YIbpIg0/uTWSrHwMhp14e0cWPuKWWmv5vFGyOI4f
         HlFg==
X-Gm-Message-State: AOJu0YznQ6qu37L15nQKMGW/lwkkK4Pd73VrLss28lfY5CKK6RCbMoNv
	ZXGfyCQYl+QhgBT+vOzqAgZMRgz56jjkykRvNN/L1FakmHqbgfomk/WqErJr5AYKYmVgsQ==
X-Google-Smtp-Source: AGHT+IF/EDbDOw9PfT/Z0FCcjwucpuLWvcOdvkfWpSLtmSbYw8wjEr28MzGUsEM1/rBoZK/ZAPLnjeS5
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:31e9:ec1a:5b87:e9f8])
 (user=maze job=sendgmr) by 2002:a05:690c:9d:b0:62d:42d:5f63 with SMTP id
 00721157ae682-63223c4070fmr277607b3.5.1718299917421; Thu, 13 Jun 2024
 10:31:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:31:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613173146.2524647-1-maze@google.com>
Subject: [PATCH bpf v2] bpf: fix UML x86_64 compile failure
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pcpu_hot (defined in arch/x86) is not available on user mode linux (ARCH=3D=
um)

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
2.45.2.627.g7a2c4fd464-goog


