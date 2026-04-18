Return-Path: <netdev+bounces-279467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMy0L0kP42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13841FFA4
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C2B3013874
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD8633970F;
	Sat, 18 Apr 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV+oVsiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC398330644
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488247; cv=none; b=EEaN8uUoTy1N415bNpTyfLRFrXWhMlXsq/WR1VyKLnEskvbvOheSevzvSl2xwPBmpr6U1RcnWSs6Ctr6ZFsrvbw8cbQnjXxuobNWjK/EP/kCEMIwpZFQEEHZ0Vo79ig+tS5IVp3CU61ZCPPdGEUH1nNqT+tuCrINPN0mf4jjYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488247; c=relaxed/simple;
	bh=noCuVUbIZS87iKo2soZQK++66nTPA97Hb0ZZSl1yh4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLqF0jsDekIOF9f8hAMYGyUjH0lDfdeodimROAivqVD+ZojE56M2CmbCD1JlbeA/XyubJhnjerbvV5P6PDrzVZnDlCB0/pI6Zv0qNFBBaYQebbbUj9X0Vso6STy1ZrIm8zyoip7ZZ7Qq+W9bGUtLX+Onzs9668KITiQ3Ja10g08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV+oVsiS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so990554a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488245; x=1777093045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7fYuN5x2Np/CFxQoQV61Iy8WpLzu2WAC3PFJmjW8IU=;
        b=HV+oVsiSFw0VpyRxOcDe5TSVvWFCqV3+uGtt1fJi0vFJUOuSgiWRl+7jpG/yIA9dtY
         CPkfycJpaaD7Uh3z9X6x9durrJszTxyObZeETNPAt5OMpcynZlHk+w02qbdrVNn93UH+
         yKwHnfuXOpK2cElsTG1s58RJe/I3sAczToB9jEsDY2vUTXcG5g3dCdKiS2HjSdYORpPc
         e9hjpE68MIKKILL7bPSKywwiU6Bz9c/r+CpsifsJlVNu95WJr8LZ9/Cy/D5nnSe2MrkY
         4uHvy422SduGbVJaQzERV5HbhguKa6unCOKuLTPk0qLsEXw/RrRIJaVQ8RwXKwvMzOsZ
         GDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488245; x=1777093045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7fYuN5x2Np/CFxQoQV61Iy8WpLzu2WAC3PFJmjW8IU=;
        b=OXB10cMHwx42XDmwSKZb6LkTUaB++6jLgOy1/yhWfxtLGNl3ehekhdm0l/ZCMEOQ2+
         TejAY6QuF5ylEL/BopBchh3Gxgu1GGQAnKfyeyilrllw2FSihgT8qdPI7clbv1zPpO2n
         LdmOLkQ0XUFdbZ6N75wUrB77WJu539jxP3tLhSe0CHbbuZ3glKlcHROHyra3nPbV3Xde
         38lO3fdyoBF3WFpEnhHuK1AveYaUSTF3/jIyBvQAQQGp4xYmDxrXJR5OpTCEXE6RZzV1
         yVgXTCVv0Cv4AaFLzMns9Gi/l975945ppLMEmx4YRE66Rv4xW7VwQidr3oP4lOgNKEv2
         6Xbw==
X-Forwarded-Encrypted: i=1; AFNElJ9xWIXtB1a+ix7c7Z5Po4ov0HaDDIJqfa505vsqTOAvp0jMygfaA0f5UtSs9lC6G4qCvrC4jcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGH5Vg3lVBvRVQz93rGNnCdf5V9qvSyOm7N5KxvyaPYpUsOYbk
	BwwOueEboenQRDgMwDqHbGSX+mFap421CfmNTehU9anA96fGE4nYIbfQ
X-Gm-Gg: AeBDiesSqfruwbHMLPPbbYBOmEeOoZ1hmrd/o8rkUWOdo78dZ6PKzmbASUDJUDTkNrV
	IJuUM60XkwUW0iqgXMNzXBIxrMROxkO0nXJf5HjupUA/kMyTtiziL2XKAvmoL3O5BCsipXjFpyz
	RkKzX0kOUgSMFQusjuh70yOzs3HXdCaUJoncH2qpahdlzPsbZcHRkYjRGrT0+kG3AEm6mDbfJxI
	nKBVzL+aGOk5UNY7n0Bce1NhbqmvhMt20QN1tVw/zJ5L9BZoDfhW8w2LBK3I9hm5vfnw9igd7RX
	uz/BZ2yey9bfHegW9NpAnENVd+5Gsl8nE7G4mbuIt9fRTO3CtdYnwcXb1jmOklwqrXGI4ODtOKr
	DSHtpgpXJXgpkRAhqiEy5HuSFd/xHk3B78BmQqvBRjpxHn/RcIClt0E7p/lPVnHvms2ZoXuVSTX
	UCDqq+MtC0rjhCn8KlAA1DdGf3fHrgR/y5D6tJ6X4Xy7Y/VMkMr/NlaDjyzjy7KoWg3WRweKrpQ
	1o6qVeHug==
X-Received: by 2002:a17:90b:4c52:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-361403c3412mr6182207a91.5.1776488245131;
        Fri, 17 Apr 2026 21:57:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:24 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 3/4] xsk: handle NULL dereference of the skb without frags issue
Date: Sat, 18 Apr 2026 12:56:43 +0800
Message-Id: <20260418045644.28612-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC13841FFA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In the patch 2/4, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5d3dbb118730..2918b773aa84 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -898,9 +898,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3


