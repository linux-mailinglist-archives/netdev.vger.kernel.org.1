Return-Path: <netdev+bounces-280302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H3uJvFC6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBFE441D52
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79194302978B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56123A451E;
	Wed, 22 Apr 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1bngkr5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F3A453B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829042; cv=none; b=hUIJ2iku/G+aG0i1IDVEJfyMpcaoZAcz+ztV2ErnFvpS2IYkiH2/tATf2xSYGT7wzQ8quhd38WB/ZBteJ/m44tPHqkySJluJkdCCfGgpSH2pbUJ+YO6Ir4CDKDWX4WyW5DcYitmCBXuOLM4iQUpwEhHCp/msfaV9Dj9q40zekdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829042; c=relaxed/simple;
	bh=G7AWuS0ukX1iLsuT9JRXb50DmeYwXhl5ye+VH4MAchk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMiQZH5of3f8dE+yMHGX4yagCzlKvE/CblSx8Q6RkbxpydCXpPhjdFJnYvNULdr8DmEiugi6Z1eNvc7+hUWtqPnJN1EvZKQP9B/Skp1aYa/gqnw6oA7ink+92BZ7ws4IYLlYtcgrsZrrmhm4Hh+iUgf0E0xLU00S2fcFI2Gcr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1bngkr5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2103849b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829041; x=1777433841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWN2JZ+naXQZkXRKjOmRteQ2UzIkItmXJUEjeeSbwOE=;
        b=B1bngkr5pCaCurkfF5WO6KnP8WgfLibqPTALjOkhkTLPVQjJ16VILPNJPMG1qbDYvc
         09vsw87uFsQVjd9sR5TzPe1+25ucArCCL18QB1GC0+FuFXAorDeZQB2T7D+HaywLxJN2
         mJo+/cow9UrDQjfhjqq0AEBzkYlK8r0sjoR+2Er6C4pWlYxgl3CSApMJFRaWFuwtWvuw
         W5ztJS9gxZK6DbWDLqBGKx8tuu81s//6wiqZaWxnOmb33Xohraxczj+uxep3S5caYoZr
         9le36gZu6ho9hD2/kgQ/JRdKvgNrZsxY8q9XJ9ZFKyOas1A6yRjD6N4csCI4Z2bL4csy
         jJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829041; x=1777433841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWN2JZ+naXQZkXRKjOmRteQ2UzIkItmXJUEjeeSbwOE=;
        b=A3KlcFdW93LZoBNWBgqap6a3mkrzgsXtkY03U6QRBsXcBg7uHChqKgHMtamiIcGzYt
         Tu4h8R4X8oaBknywZbJEkOfQiUhWoQcpLxZQVTJEvM0QkRFy8t0Cgha6JCg36VyPoNIo
         i6yqzMcTQbCG0e+ew2EEBv1JpitlR9b5d1z6n7X731tgsoXr66OZSeeyNYdL6/Vt0ITA
         jUeHFXp0J09hcKnR6FqYDTxoH1cuEXVzR5AJYplE5rask8CjZRbKS8dXXuQ/Att0e8bf
         XXgNzF/iwS/xzLqhd2PcQq1xpzn3pgy5xEPx3BwWssuot4YPUU8TTco4CP7jVny+K7y8
         ABRg==
X-Forwarded-Encrypted: i=1; AFNElJ9biKZLFITf75rXYOReM5BLZmLQDw5IJ8XD08KRw4Fp2e7eaohIkovC6tsNrklmjN3uHt3IrdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJLNoXogkQhxSWHHy4UeDaDP0Ab50ewiGCgXYcpmjW/K1pPi+
	s7/bbVGAG28+aUDuhM+EkOYUHUcimgjRTOkkV4MqHdxjjujCJHHqElLy
X-Gm-Gg: AeBDiet8ei2Ne9Ts6EKFc+7FcxnYETVlgcAAJb3Pv4Lh4ghiZv3IMmVyJDF3mDXxteC
	tI8hFJQAjriJGUC0ELeeG1FJ9KcDxLisxbc/+WYIFHHoYf2UMwHim8aO58kHIyfpb59EzPRXft2
	9w/OIQ9MEackIjtqzdwh1jDFDnI3NKN2I1ZYaIEVI4aondgWQ/daWNN3SBn6iHzfA2RLBaEQlqt
	HeHD+oc0Jw34KKrObf4C9laAqmx98PjFIU1h9oTy6mhAqJaD3KqrioyrBRJeq3K7QXCPLTUfduU
	EH3Hi2kWpUgS0L4eHlaClLU25ezA8OBVuoXg5+iB4DvrZKZ5UE2wYBIeuqDFAi0r2HVjrAuB52t
	VmjO6/w8aOEXPJGWbmxHTL6vI3i+EeuQsvbckie71FiQ49OF+Mb0678+kUqKxKJubDn5jByzPTv
	9XcGnNL66iTFLgjX3lzVEX2x61VqjIcYE+dNpIHYVRh7HAVBeXMv48+6MjSFUqr1mRabkXzhesF
	oCygS7r
X-Received: by 2002:a05:6a00:4512:b0:82c:e1a0:3453 with SMTP id d2e1a72fcca58-82f8c8fc39amr20671254b3a.26.1776829041112;
        Tue, 21 Apr 2026 20:37:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:20 -0700 (PDT)
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
Subject: [PATCH net v3 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Wed, 22 Apr 2026 11:36:47 +0800
Message-Id: <20260422033650.68457-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2DBFE441D52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 88ec6d2cbbcf..c49b58199d2f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		skb_reserve(skb, hr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3


