Return-Path: <netdev+bounces-279686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOzoJrrj5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A342821F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7A153009381
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE8388E4D;
	Mon, 20 Apr 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4CV6+1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593B3845DC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673717; cv=none; b=YJ7+qT+mrzcApT2Lp0MPqPOAIepXa6FrSbKSPrxIrsHDX7KyOiVWybKCvOJDpTysORkO3hZLgzMTNoOsZsa5ZXmqCS1Nr9Cx1RQntAu+pfu1jXPtp799Z3BC0TmDnL6/61J6AX+0zOSThJL70pm3zle6JsvpK7+ZQEg3zx28KaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673717; c=relaxed/simple;
	bh=yPn3zWFs108M5RNr5Rp+kEd1EJ6GP6gcs1NhsUwltNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTWORYwC5CVdfotS0YV0tqqTjear7Wcs7TJmpUwQPDpZxQfNNOIMhreu9uXhlFE0gzduzCxmXWwiKPmNgSZkwnKN6uMBSNHdkoZWEmAeo8TYZhXWkk00IdKUvMbm1ZqbtARgSWLbRauIaYhCCi6tK4N3XqXnlbPiujF5SPfeL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4CV6+1Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so992068a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673716; x=1777278516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOE2AqceayWh7ep8Gr2jA+i1jYVD1CfxeHKydIjAYY=;
        b=G4CV6+1Q32THKkGhFJhlBksIHOw0inSPbLhegtWHakTCisYxra7qTYhgXrlmtzwR1K
         I7G9qMhxrYrQzIXvOJofo49gc2NuLuD+3NiUIf2oFFvPmlW9WZBEfXOo5NQWuhbEOqNA
         EGap4FYSikfzDhSZwSaSzlJH665LgTwvrR0SeV5Klps1ukMfRNgHO23BKX+uymCnHeII
         Jiggd7F7p3uDMrxMAIQzpJ5jmDf/SflTDLNeeWDnpEw8Iy8pJSYCHVA019UQZV0k2kvP
         aCjFH57pdRP7bw7cPVXzeFpl0hZofcIEHrRo3YW9/GKCCcS1vi6oCgUa6AE6o2t43iGE
         quAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673716; x=1777278516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xyOE2AqceayWh7ep8Gr2jA+i1jYVD1CfxeHKydIjAYY=;
        b=YLZOHQZnbk+Z4YKpM3MyrriBV1cLTsAlBSIe//hR7CkOOs54Dp7yqQriqsOpgLbl2J
         BzKLawCRTN+qiQavbrqgvIZeCcWnRCOdc2y3TXm/UiTS4cU6+vPU9IYlvoutOG16xRo3
         8FCOY5cPOAg0D5olpjCs4qxrkIS2O3EVI0Tod9jRXDeASJCyGroCV4MmCaeBJSvpDdq1
         twsH/gYWBEjfyDO6mADwrtfxCnyEmsFQ7E7PmwPN4T16Tp68b/ey9wXLCAEMrs3qOqKT
         H2g1ErO3UuhXZqgpD7djuKPxH6ygeRYF77P5iMaLXnfFHCQgGxzwunXAuiymuJYtI4Ie
         xuhw==
X-Forwarded-Encrypted: i=1; AFNElJ8yPvkgyBzJkRdPM89ziRdhtwVykOwZdLqKX0dlTAqydhx/9LOhEoELIzg9ecFoLJzVHXu6VwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GXWR43fjb/CiAh7LCIrQ9tlll0xAaos8ZKWSUp/eN5P6lKZ/
	KTwO15m+rQu8jvxyiIUPZXwICD58SPKJ4Ze5xAva3LXK7l49AaWQjTdR
X-Gm-Gg: AeBDietVNqV9ltzXAgSMK5w0A4ewLGJLb5Kxcps3PdGLS48r7SEGgS+AV5xYu6Zpm0p
	KozPMns9MfQ9Vea2ZjF5fG3PqVMDofaahBPj+kN4YjkBcLbIQq9cBJkDqrri9Z+vpgPUJ3Rk64Q
	Bz+syvMS8AQO7hMck7FTf3/LL7aAAgWaoIZjbPof/mTeQKpkXtid1mw4N/vv6MW+njUtox2NtOI
	KEgoJMJo8tPAo4a+Fyv8NBl37VrYu3pkopm9/4YSEhVxmRUvnlCCGo/8LQe8jyMNQ9tyO79GnEc
	nCJwgtH3UJQIC2fAjHmsgJ/GCxCUEkA7Hd22gzPayvcmDm6GKiiIOlWpjNVEKt2mbVPMaUjrp7Q
	g/pM1+bIoffRa2pUVPjsX4JRFJZ1k7KAWCpKNYfxd3CCPLUJWQXi1ACVUEiSG+fcRGcZxKp4Eo4
	k9lQq6TwVL1WKGCZrJErq0F/sToPZUlLoeXq8qKd3CiIxjCVArlW8G+JCg+efamOhAy+/v5h9iM
	3abBlqy
X-Received: by 2002:a05:6a20:7285:b0:39b:e321:67ea with SMTP id adf61e73a8af0-3a08d8fba25mr13642856637.45.1776673715599;
        Mon, 20 Apr 2026 01:28:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Mon, 20 Apr 2026 16:28:01 +0800
Message-Id: <20260420082805.14844-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC2A342821F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Introduce a new common helper to fix the issue. That function will be
used by the subsequent patches soon.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4fdd1a45a9bd..614e7bd1252b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static void xsk_drop_untrans_skb(struct sk_buff *skb)
+{
+	skb->destructor = sock_wfree;
+	kfree_skb(skb);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 free_err:
 	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
-		kfree_skb(skb);
+		xsk_drop_untrans_skb(skb);
 
 	if (err == -EOVERFLOW) {
 		if (xs->skb) {
-- 
2.41.3


