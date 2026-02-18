Return-Path: <netdev+bounces-259200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOstLXo9lWlpNgIAu9opvQ
	(envelope-from <netdev+bounces-259200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:18:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E198A152F4B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B2823007A5A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417692F5A22;
	Wed, 18 Feb 2026 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOYSANwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092632E7BD6
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388277; cv=none; b=JKWHt8X5wr3pMX/y4SbhxMLA8S7wZM75S3fT4Eh9SPav1rhrXaTAzV43kaW0e4MaIcKNW5X6DMZH7M24zecSyblNPU/JQ/DB8u2pViUeMJ+W7ElF15byjllCPir702awgSuVbHbpHpDc5p4OO6apeO9zEjvZn9HJpjPRj6RScGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388277; c=relaxed/simple;
	bh=buDniwPppzJrGVOjBeL8+qFvwMiSlPJFeI/3U5o+Z8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDP3XJX0bLoystYQBD+WitFSAmfcAXu79sWVBiGdLNmU4AXcKIBN7kH0ZamWH1Ph602vnDSHfJgUNveiVitkShfjEAFEtPkAVzeLvB9pBy9sEtPJPYKpi7NK6KzpemHkMBDCRoQ0ySJ5IRKOIHDSPazA/zPwiJTtGi3c6RLojGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOYSANwZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c636487ccaeso1823739a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388275; x=1771993075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQRKTlFA2C03Hko9lNIUE0/dQo3+GelVNiCBLYxEf+8=;
        b=EOYSANwZV6Vy0iHJw+O1iVFumT5Idl07rT6uOcESKB1y1189udF8W1Ke9beTXbzjVb
         5h18lOu5OqtBXG2zEc/V0nD44MOBv7RKPmSw0j/pfKVaStF5ARues+aZxKP4W3f5abx3
         yD+L4iK9DtNI1BVbULU6g7kgfP6xLF9feYzh3BRzOphKI6t9jSQO8fvyFQMlKmpENFol
         f9hMs9Tuo5akZQwvmn3oDsAKltvnWxtbh4hwnsnV1n4D+bj7rYNmX15fhIlkGons9FuN
         aelA+aBkzP+u7ocS15L8iVnMJ3HeaIl7zjVgzZk+HOJ17ALViqPTvRzu3iGJipsPobUm
         KbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388275; x=1771993075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQRKTlFA2C03Hko9lNIUE0/dQo3+GelVNiCBLYxEf+8=;
        b=oh8/Ejm2bYeuIa2oOxfllz9afComNh5ojXLK+zFD9ymkrPt8Bt0zxd8ircfHB4bYhb
         RlbNPvo/BDsO8zzvX4MUmAyHyAXeqmXHCl63jsqQ+hoSGr61CVyBnWMHzPkQi94SIEJZ
         7QOrTwopd2QL5lJLREHfnpP98VGuj7nqEhT2jiMN6q0jtJuTHepxa2vq2pRrbuTyPe1Q
         /D6LoVsNubeiGecK02vsSC5784TcQMI/jVX33epgEab061Fl7G4k+WJddEatUh1cUiS7
         ikkfUvGNT8MiHb7Q7gNyHgkhG9fksYBO/UG8aAfLW2d/7WX73dOE0ZKpafQ9zrSy6feB
         97mg==
X-Forwarded-Encrypted: i=1; AJvYcCWnp4wK8RCKIJWLw3wHQ4TJ64MNQQmCCBiGqfJnw3Ft7tDK9kdX5SrQ4FIwcTlmTMrb5gFsFJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZPCaczaqhZpI1AD9IjO5jEbZmXbBEGDjtAbceBP7k0KfGNHP
	3LWe37z4XBTsVo0xrVxp0fCM9nf1mp9OCnLOEsilcYapaiKFRxjzvOdx
X-Gm-Gg: AZuq6aK9FpPzIr5OzhHMFaOWd5I/XfKJCXOjhYXrEBspvnT5KR3+tLGFR5Mjc0F6XbN
	Fw1EFeiShjhiEy3kRHrhnIg6nrsnvtwYvt5RWh9vfHD7bsyDhVeerxznvf97Nth6Hhzr0dRvl0i
	o+MrAQKVMYXcNgcDFOoV/SDo2wc82cu604TInkqfTyymtcmMmaky9HS5kRkNmPxo/RWNdpquBlb
	wFsw7EB51ezgs1ld/Nu5odiGRrZ1nP47QP7qGzy254xkB2Gr/2jmlTPRRtzI3Pf6qRnsAfaMlTi
	wYhHy+Qt1ae9TTFm5CNBdLkuMNJBGPwW/F7uNFsh7aoNBzpddWEkqa2PMsFzah/XV7/fXdsfcdV
	Gh72VKtxPY0oqwhScLAQxcoIBzvYC/eAZFH7xQgIQpFJehAFLgrzFxUZD5wp+PNt4CuceGWwnIT
	Ho6lZaJH8HTdM5K5OKm7rZf0a99BNR/HKrt8nDAN2+0oDMr9AtnJ1zZsOXq/a3orbuJypkL0/Rt
	umfkHYoubwoWlwavnLHFoXUOiYsjtjFDzlT+EMU
X-Received: by 2002:a17:903:b0b:b0:29e:9c82:a918 with SMTP id d9443c01a7336-2ad50ecd9bemr7677975ad.22.1771388275238;
        Tue, 17 Feb 2026 20:17:55 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaddc46sm118618985ad.73.2026.02.17.20.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:17:54 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH v2] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:47:45 +0530
Message-Id: <20260218041745.36791-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,fomichev.me,iogearbox.net,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-259200-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E198A152F4B
X-Rspamd-Action: no action

cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
falls into the default case which logs a misleading "invalid XDP
action" warning instead of tracing the abort via trace_xdp_exception().

Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).

Also pass xdpf->dev_rx instead of NULL to bpf_warn_invalid_xdp_action()
in the default case, so the warning includes the actual device name.
This aligns with the generic XDP path in net/core/dev.c which already
passes the real device.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
Changes in v2:
- Pass xdpf->dev_rx to bpf_warn_invalid_xdp_action() instead of NULL
  (Jakub Kicinski)
---
 kernel/bpf/cpumap.c | 7 +++++--
 kernel/bpf/devmap.c | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..15c377fe4b0d 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
@@ -221,7 +221,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 			}
 			break;
 		default:
-			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
+			bpf_warn_invalid_xdp_action(xdpf->dev_rx, rcpu->prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame(xdpf);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..aa2e929792c8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -346,6 +346,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		u32 act;
 		int err;
 
+		rxq.queue_index = xdpf->queue_index;
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
-- 
2.39.5 (Apple Git-154)


