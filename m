Return-Path: <netdev+bounces-72613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7E858D17
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 04:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504A01F22B21
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFA1B7E5;
	Sat, 17 Feb 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy9xYHHN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562718E02
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708141659; cv=none; b=i2PKMVsgAQ3Tishd+OU+Wl6sgBktqDU+3ipZmNxjgLTX6JK6U7U/u3cTnH/RC3k42gddIk7otV/qqj7TsmJzuQ6NZmqDLC3TRqAIyBnCyscFdd/UVOlRHkiaCpSc7lnut4G+JS9PosEOFRuNLX+MbEhzI464tv9N2auPFvXD2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708141659; c=relaxed/simple;
	bh=i+Xhnu2emPM8c3ZSTUcSQSlVRJkZNYRsb+nGgWaEsf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GaZfXowJc5vrYX/ITOwhRs6c2wlKeUdgqBuB3ZI44iXo39DSRoRyXEmrx1baG+ochZ3fbYCIzhk/jOq4qtpFzuYW++S4vIKia9DlbldeqVctlq5UNPUA+yG/OSI1E7N35Dq9yNnaq6fpKHMAt7GuUQWvNP3HpSO76oAzAGALS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy9xYHHN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6080f44d128so1829977b3.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708141656; x=1708746456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abRQKB3Tjfx1ABWZplXt9I8J14hGcd94gAE4dJYLpFw=;
        b=fy9xYHHN2ThQcAiMeumwhgN+9iAm8aMV0+ERRH5Y8+pFjYFlOkPOUmbZX792v5OzfK
         o2buLvUkxSNrMARAG8F7MAsnLPiLBs8PKlsnf2dz46ryrGZzqT3eS2Cti6hJFTsbYcNr
         78wnxw61RES5FI5iGhdilfFB99dGNRfux4nl1XxxrBUmE7w5W/BdgyQAdWDn83EcjY6E
         IQ7wJCYPng3ZREUuSFtXXC3F3ekB4xkhqFuIsr185XjcgIXGuzaAgtcD4xw/tLeV/ogi
         LEEf/+MRlzB32Z95kIDKpHSAOyNZZZSmlYAFS4wNvX7OZ14KH4tbQStVeh82406RVOz2
         DF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708141656; x=1708746456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abRQKB3Tjfx1ABWZplXt9I8J14hGcd94gAE4dJYLpFw=;
        b=mZOj7cPHUajigWvPg0CDu2UR4OcTVnzUcJQbIC5WHonpd+YtRJT6ffqCuGUWC4Cn+h
         gSJzRlV2NojE3EgXacsODSw9AI0M7h6tKCBRlCwwXtp5zBLMJ3iHavGU9ZVTn93+O9lS
         PP3dJNvQzRv51lII9mbih5KNpFpjFOtoncZMskfCPCrxI+tQQylTpeOdWMozTA390fbc
         OwOGNfv61cc2Bvim3kp1IrLPxtTM8GEWMZmWqac22hEs6CWgsphxnUEFxG6wN6zjZ8NF
         kcH1KqSWJs4/654oPmROTZq6WbDd9Ufm53YxfbI/uNx/7tzVlt/44GJw7ER452sOSbES
         VAwA==
X-Gm-Message-State: AOJu0Yw8NF+vxd7Fj85Vs4yoBGKQBC8Xz0oGbpBta+tuJNykONX2Hmat
	EtnlEowtBencRbFA8CAha1+XdEZXOaNfbKrDe33ihcjP3MXYBPXO8pSBea8u
X-Google-Smtp-Source: AGHT+IEo9XX4B071OBcZrFOTUJ+0glG0vTnhjiKBTdcJm/HW8QbJtg+32hBrI/4xhpHfdLDXgvkjkw==
X-Received: by 2002:a81:b724:0:b0:607:ec79:4db0 with SMTP id v36-20020a81b724000000b00607ec794db0mr5012791ywh.48.1708141656012;
        Fri, 16 Feb 2024 19:47:36 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:14e1:45d8:b0d1:cb6f])
        by smtp.gmail.com with ESMTPSA id s5-20020a817705000000b00607bc220c5esm632678ywc.102.2024.02.16.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 19:47:35 -0800 (PST)
From: Thinker Lee <thinker.li@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH bpf-next v3 1/3] x86/cfi,bpf: Add a stub function for get_info of struct tcp_congestion_ops.
Date: Fri, 16 Feb 2024 19:47:34 -0800
Message-Id: <20240217034734.1869771-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

struct tcp_congestion_ops is missing a stub function for get_info.  This is
required for checking the consistency of cfi_stubs of struct_ops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 7f518ea5f4ac..6ab5d9c36416 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -321,6 +321,12 @@ static u32 bpf_tcp_ca_sndbuf_expand(struct sock *sk)
 	return 0;
 }
 
+static size_t bpf_tcp_ca_get_info(struct sock *sk, u32 ext, int *attr,
+				  union tcp_cc_info *info)
+{
+	return 0;
+}
+
 static void __bpf_tcp_ca_init(struct sock *sk)
 {
 }
@@ -340,6 +346,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
+	.get_info = bpf_tcp_ca_get_info,
 
 	.init = __bpf_tcp_ca_init,
 	.release = __bpf_tcp_ca_release,
-- 
2.34.1


