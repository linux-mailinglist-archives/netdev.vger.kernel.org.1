Return-Path: <netdev+bounces-259202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aENaLDhAlWndNgIAu9opvQ
	(envelope-from <netdev+bounces-259202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:29:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BDE152FE9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0D73039F52
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6632FB983;
	Wed, 18 Feb 2026 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Dbwot5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC663EBF22
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388980; cv=none; b=C7r050teb2bE2ed8XJJCFoiUJmuSj+7F7ON4c2FjzJpUc9bmnWZ/HG0+GBLZIl8aLPr//Ibo4/fRpXGNjitu1qJn6l7w9AY+t4aKG4lydyJHFNw3hBOUlk8qNZAaAyha7/cmfmDKUx/KQQ19jb2WF9dN4JOYb3UFWYOT8NWSkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388980; c=relaxed/simple;
	bh=dhvoDsSh7tHUJR13TIhX9yNmWVj8+ijL2aeiCvX8TbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZNc7r59yAW47dFBvN7sz6DI3vegeZIEF+wakKMUcNVNvLDHMxP1lfiz8N54B/2UaA0LRaTa4LIupFV8ZmY3r5ACXWlemxiSqDgW/dR6TXeglhV455lTNs4lYT4YqQoZYLptwfXNhxCGwhA6PrL1RZ3wL6uK1TqBZcvhmjg2K5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Dbwot5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab46931cf1so2939695ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388978; x=1771993778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvzlN98l7/BarHSO/majX6xw5/psg69bWsbBzuUD8gg=;
        b=B1Dbwot5Lr0a9OnjCsmRGbs6P48d771jwb6vrPlSrBXpO8HdEpVzr5IF2FmN9uCNmL
         oqZoGkEEXibQPdc5EZQLxLDgDPJp4VmDHWOhVKo+bdJ30GUVqik1I6VqsiRn4dbJsH+b
         PPpI6Wca2fPzQ2KifDVQHCiTxn8fWvzdDLuvGBiMWCivMaKg/5tODs1vuJepZSCq+8YK
         OipWI5cmcslx3Qz8RyhGeev3nDxwOCBdMCs7+V3Mt+49EXYnNQFFuLjyi+Hpcgg5EVJk
         WtN5bjtXp1WOVclhUm51+REi0d50tY7Xm8NeUTsUoRNtyyYRJrFeqDsUfCmSljDoXtAQ
         Iuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388978; x=1771993778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvzlN98l7/BarHSO/majX6xw5/psg69bWsbBzuUD8gg=;
        b=hd5puW/9tNlSGMTR67NCqveM99Nx8sOzxpPrR1Ud3RTzaYTW2pQY69txZasgJnIgLA
         3ObWsVwcrmBv4djVGJ71AQYn6Fb1iWcg/YhAx1mnHgbpTRqme8Pe23Ox8+X21gDjp7Sc
         uKa3/Mn029vWzEW+fvo9lyoTwK8lZifpjKoNfVPxyznOZsTrEz8HIUbxYvV3ouwHSzm+
         uaLiusNdG1vmfoQgDBHRxnw210zGADVEPc8ZkOqrsmqZAkGojTf8JdAWIexgnsZE9qhO
         EWKmF0UYHzjV21UJG32v7hOT8gWqkB5lUYe6S1CTQKifrbuhjmD4plwhf5OU/vpF916b
         Aqfw==
X-Forwarded-Encrypted: i=1; AJvYcCVYMZ6BXBUYp471JyMTejGm7uu6yPah7wYsliJ+j5tY7YnKeny8/uRsRZEbygxDGFpg4IY5p7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVMqKkFgXUgqxSbawCghtATyuqu7nG2P3DKEkdg18Csz/W4lc
	8yP2hpepUr+vN1n8C1KpUl1m6Xple6Efzm3oNCntMMUFR6kLunsnvAgQ
X-Gm-Gg: AZuq6aKlflgQmsWkFuCh5FmGfmt6mbwIyb4BcPSWLNOrF2rYM+wHTcK3A0ORGMpeADI
	T1o5PAWDlAni0F4K7h1cpMu6g+wHyI+4q920BMZFDM0S5Y4P38m/vAnnbx3amQKoaMy7k0mp9dr
	1f3qYZmmPTcdqQufBfcVe9+XrCjATnVsu77NDV7lGj5FZs2+g9MH/cXShTVCJV0LhWUURDWFwGr
	caX+jcFqVr5x9k0LJcnPHLfz4hZDWV7B24a0tCSQov0Uq1YZj3Bk6Abf2qbCswFT1vTR7hLRIZy
	Qeb/A+dGaBVzYKUd61yiq70UEOzWR1LUR6UfJuZHF1twMHLUGa2TGfbbk/QOidrDvo7jNZqXC6S
	ldYjpg0TMs1hILvw3Exl549JQHZUNt04SBcC4Y7oTK1wu9fHeb1gegwPKjwreLV0yliU6e9pzQC
	iOLJorjMSMMUviSg1+oTxgyj5HQSOE9jCxrlxBgw5AACQVCG/nY7uQUTrXlSjlO49DYvisl/giH
	piU+EYUWPDLwxbX4+sR9zIm+5Cmxw==
X-Received: by 2002:a17:903:2c05:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ad50c3d06dmr5488015ad.23.1771388977806;
        Tue, 17 Feb 2026 20:29:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaeb759sm105165865ad.83.2026.02.17.20.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:29:37 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:59:24 +0530
Message-Id: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-259202-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72BDE152FE9
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
Changes in v3:
- Dropped unrelated queue_index changes that were accidentally
  included in v2

Changes in v2:
- Pass xdpf->dev_rx to bpf_warn_invalid_xdp_action() instead of NULL
  (Jakub Kicinski)
---
 kernel/bpf/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..39959bf542f9 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
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
-- 
2.39.5 (Apple Git-154)


