Return-Path: <netdev+bounces-258905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBKuLpw0k2lx2gEAu9opvQ
	(envelope-from <netdev+bounces-258905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:15:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3AC14549D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAD6F30221E2
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310F314B91;
	Mon, 16 Feb 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeYC6NMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BC30EF71
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254370; cv=none; b=IMk9PPTwLzlOpSa/21ojz6c2MXFZ7IjrtZiUDOtX7KbzSwFHw2Ef6Uf9/6F3UdKb0YanWgEU+uNRJymQWWYwDVc5NiAkVV08EK2KgCCPkihp0n0qn9bVS7/nstA3EmsrHP1IkzpP/jjB6jPkX/9q0tjJmWQXoF4cVhcwgttbwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254370; c=relaxed/simple;
	bh=vR+QAy7ow7IUpEgJolTV+0NwGmXjYUXcNxGeHlD4+bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uajedk34CDY7PijYVo9kWyzpr72vs6dnJo504H8lexyY55vejB/PkA20YtKj6G7nnLeYgcwKw4JYSvRMiDGKxfyD9kXdqcZaoJMQYK8LbJY8wpu6Lp+4GJv7D0ijL8a0i/8EEC50H4G6HfvoGMKJ1oWcVx59SxhbyV9CuWRFSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeYC6NMn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso1415214a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771254369; x=1771859169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6uX9Uhp5KRzO30Ht+YfFjNfPHQX7eMbhvwH7Wme3Gw=;
        b=PeYC6NMng7hwREe+mXzuhL299CBpZLX72afhw2eZrPHMplOi1C1L7uQUKisFeCSqgE
         /fmwCVS8H7to3Au2o7vra4IXxorsm1qIMi8aCIY61AkNR7OK69SIm2JYfkX1hs44oTQp
         i+Ue8trpUPUnjfWvRBQS0KgwJaJuxKiZ2b7SG72MNy1lq7u5lDB1wGMJ2U7/JMVuG0eR
         GiM2yYISNV9vSTwFkx8x4w29w47D8wmLmQCokdEjnJKZiq13EOD71FenO86T2btlxdGV
         yFOJJSd1Saq3nad73Vf1LuYOJZE6drkA7SEz0S6cBDi/PUJaaG72R8XaLjavfLtCOGSh
         s8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254369; x=1771859169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6uX9Uhp5KRzO30Ht+YfFjNfPHQX7eMbhvwH7Wme3Gw=;
        b=ZbiovnMeHka/J/3xf2gj1w6Uqk7g/3LSFwNbgG4aDoD3kmi1CD+IDLULSIunRay2K3
         LrGBbx1SE03Jnkut9OuSGnat+HPCFrBy1WcP1ZQEtNVZf8aSprOzap3qwpq6UrRrjBz/
         zgFg2k0RCRnZQ41a9e5sCzlnCuYDXLaDowFBJEvcxMCsP5JTO+VHmahuaTwaJG/mLvX6
         PZIqo+inOwi32Zcm7sQOKsbg6Vh8yDNxvRa04dhIkBXWPUJvyycEXaCbXQRqfXHg01k0
         J78LCPz/BWBDPqS51kbcJIkMSAqHVgwDm3VwSjG6favAj05JDxLEUlVpmKr6YypZjg1q
         zjyA==
X-Gm-Message-State: AOJu0YzChJ+lkkn8l9xqyNt9fptU2LCq4hhPJoGY/wKe5GosWjekh7a6
	OfvKJNjgGVK+gPhwtpZHl3kTGSiZFuCG3PjSZ2GdY5SbnqTrSIcNRHcJ
X-Gm-Gg: AZuq6aKiPHssbUxIF+UNgzP7tayDzZn2hvMNE577GAd7FWmD6fIyix/rrpOKADj8+wT
	4of5kM73WLRSb3x7D8rETIN+hJSoNLBPgipx+6Qc+Ew35+RcjBp0IH4kHa3gUrAZJfO0sjdIY08
	d3eB/h+O+dTtpJBB49rE6ZbLEQT4bDhwN2ODHSjEjzH9FYI7aALUP5BaWu0zWQOxqdoWhDP2WRX
	pOTMnCZ6ptC8vCW+FY5+EwdTuHtYSbn1yUU7GjSlJXugQcRV0Zi+9c28v6XK4Mdnt8b89VFP8mf
	zjOh/7GNvmF3+DtFDfISxVvrBMvU5E+vaF8J8kEqJ4D2uRGSbP2Rr+7TwZnUMEpm0RBvsT3+Ozq
	VMQmDIRlcTKZXcEN7FGqknsUeizUXrOGC2MYQhhttbdidoKY55GzSuoYhhZ2yVmQVOmcs9cTO7v
	gkA8ptnD4s1pdNU60uDEwTBO+WMLl8gUFzjsNWVOFoZCbxRKT5iPeDi2Oa78Why3QMqTwn7crY1
	T74snhCJ0DdNAR52OY=
X-Received: by 2002:a05:6a21:600b:b0:35e:fce6:46e7 with SMTP id adf61e73a8af0-3946c6f4be8mr10229646637.5.1771254368847;
        Mon, 16 Feb 2026 07:06:08 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a86f7217sm6697952a91.5.2026.02.16.07.06.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Feb 2026 07:06:08 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Mon, 16 Feb 2026 20:36:01 +0530
Message-Id: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258905-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,linux.dev];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE3AC14549D
X-Rspamd-Action: no action

cpu_map_bpf_prog_run_xdp() does not handle XDP_ABORTED, causing it
to fall through to the default case which calls
bpf_warn_invalid_xdp_action(). XDP_ABORTED is a valid action that
signals an exception in the BPF program — it should fire
trace_xdp_exception() and drop the frame without a spurious warning.

The SKB path in the same file (cpu_map_bpf_prog_run_skb) and devmap's
dev_map_bpf_prog_run() both handle XDP_ABORTED correctly. Add the
missing case to match.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc3..b1fe83eeb 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -223,6 +223,9 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 		default:
 			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
 			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
+			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame(xdpf);
 			stats->drop++;
-- 
2.39.5 (Apple Git-154)


