Return-Path: <netdev+bounces-288686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFclCExhCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A487A55F855
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225D6300B120
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BD2DB780;
	Sun, 17 May 2026 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byd35I3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143902D3A69
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999611; cv=none; b=nQ2JzJsX5gL9u05/QJgB3RpW7Xrigg8Pk7c9xF67xgvGcvRCss52+roUEV8OkFT95QQTu+wjik773Kq3dNp4OvPfJ/Q/acGvjctSN/PqYndzPOMvtb1V473sYS0UxPdba7BzhEoPCM+stzE1BninhjhXq7huESrcXyau0RU1DEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999611; c=relaxed/simple;
	bh=b69IeRzK/gkXviBHF52sHbmYpsdUOWt7Bk6X3kz8qps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GazmKX0qsUPqN33NxyAeAApLmfdo9Vpfgmm4zDVr9LPV9vT/V7oLYzimLsd5SaC+q/D7RhtRwl2UyjcDfJu1Ptk5Y5MuHPEl+vIVXliVDoEuhVc8xf4p4bS5NhgiZRG7x2LdB8gwEuFxJ+pXL3VM0P172rGVCCL6WFzBFHHU6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byd35I3l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso417780a12.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999609; x=1779604409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=Byd35I3lRztc2bPhhnyk2hInOEKVRj7eHrRdglfAiS03p/cRc6ldOqbMOyPJQBSQ39
         KyADa4hFMW5PDi4ZdOr0t1egN8/TUSx60c+2g+0xx8Cy3cPICMaNsUZ3my5+MzjRbQNY
         TYbVEkyK4hTvcqfHoPrpMlNT8KkhDjCWd1kpiwWYtrvdzkooY+b2+8xDHiE+u/4/ijxa
         Jqz29Xqt/y4g0RSuEs3Iic1mehVYubjzK3xpJL2nERcHcPEwkT0O2d0Ak7e1e2cJsHzt
         plyrw0gOANkWX9B21edMsZgCM/38DVD/riRDHscuIwIoqe8Cnz6UTkGYWB0F3GzvqDrv
         m66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999609; x=1779604409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=TpP5XO5DKM9Hg0L1i7p9N6er0QQ+SHtTOkQxKxSpvxZ4D+CGffFA264gR4C97KQOvL
         LzQYuVWYpa5P22N8cDaa+3S8ql8DI/X8iVp3rIhia2xL6gZEJFAFC1epS4mkiZf7oA6a
         hSh/W/PjgwGbiA010sX1yeXawSg3Dp25HAbubFB2QLBjjCqiXZ+wFsTM4KUc/AJKhHQY
         hDbjwjVHXjYcoXtf4lZaaZaZHLU4/QlrbDF+0hPIP1BKa1SgFsgd7ojyfKp2uAK3wMNg
         7+rC0Fno5bdlRA34WWO+F6naZdsgwJZ0/cygDDdf/FQN/CPVLqwkXEszjYOg/HlBIaLn
         MFqA==
X-Forwarded-Encrypted: i=1; AFNElJ9UWEZKUlXvSI2V4fndDsLM5GG/7AW6MgK7oVOKogs2uO9UF16qsIJxQQ7rk6J5YbBI33E385o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kF4KxI7TXJCfqtpTH0KKR1Jsq/E1URSOQyOq5/ZaXYpfR8Vc
	CZTh0ETXDt9C5iDunxIjSxnt2LCM+Hk6I2OfAelaq3hGLExVmZ+sjAXN
X-Gm-Gg: Acq92OEqM8nBNB2xt8zm7GiziLPtArDvPqps0VfO28PEyNFhJyOIPcsqzxCfSeEQlN6
	bgyxM6EPDD+tlbjnt8g4k1qlmKmZg3AnWX6IIW/18OHsx0STN7bLT+i/Cp+bTd97SRcL4qt5tjh
	jxRj8uR22hPy9I/YU0pc+I5GGE12VWzmg5qFHPBRU7dJ0yZYr7IbCb3HUx5jToJ1cl1mef5nolS
	mCB6OmVWuLc0uCoIBZiQKSTAwWo/wORZN6CsT+Z486yWKrDobl5KKejIu6g7aD+Y0d2RzJvdlbZ
	aPpUZWcpEVuTEbR60L/wYRB07hZSm5SVfkmm7GQboI8O54QlYk3O3Ni4Z7PMss/qBsSb+HGIU/Q
	lZmohg0opNS4LL4iz5RCouT08sTNXomhOA0McRHDbwf4V6J55NvnvECA7Zj53VYUzZpkby6VxAc
	jp+rCn9fhT8ebcxc8PLRGurcDFZcsgNBgHxd8huCS+DlKwEug0gJox5g9dt4VcS1pNUEt1rCs7M
	lA9DHVmwToLAAGxl0Jien1QYOnUIQ0=
X-Received: by 2002:a17:903:2410:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bd7e88f047mr116704295ad.22.1778999609456;
        Sat, 16 May 2026 23:33:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:28 -0700 (PDT)
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
Subject: [PATCH net v3 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Sun, 17 May 2026 14:33:07 +0800
Message-Id: <20260517063311.28921-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A487A55F855
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288686-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..f8c8a8c9dfba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.43.7


