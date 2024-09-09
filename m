Return-Path: <netdev+bounces-126383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDB970F95
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B581F22E21
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADDF1B011C;
	Mon,  9 Sep 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7/qbCJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE01B010C;
	Mon,  9 Sep 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866609; cv=none; b=UHtytyBqw9TmxGZx/bdHS3aI7qu7/L2Ks9a2EDTwXJScCD2xL15VotZXyBMT5LZRmliA/GOpInK3aBZbygVj3kibdZm9ID5cq7vu1USRrtkHrxFjZG1+Rhj3fBA/ES4u+sVz7SaZ6uupwGbuSsiIcH6Hh4BjIbObOaFZsDQHGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866609; c=relaxed/simple;
	bh=wI2H5N9tXc2PW4TlDXbNOg6wdyN4zCvZ2LYpG0hOK48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGilH5OIXVWYs/mgRou+i/q2lcMfh+SlHdAnver1qJYi7IeNgHD8ZmbYfX1iqGkYF96sxbupJPyskH3ULyDIYFzAxpafO2C58jmajv/hhSCuqHhDbq3PBQeUSVqTWDHiP40+TEjSUlAm7/V82kAF4g9GeS6Svn8SHvOAKulIf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7/qbCJg; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-710f0415ac8so161481a34.1;
        Mon, 09 Sep 2024 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866607; x=1726471407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jvMzetSQgfaUIUzQnNbOMjOFgsmKOdJ2a5KEUYIEP0=;
        b=C7/qbCJgbe7REw4YLkh8UBTk6bnNOHMOOkIA+Gxf/dJb1EkzF0CdCkMMERHX3UlWvD
         0O0iqGrKegsqEe1cmBD5IVUsmfXwo0w0i1x/ShB0+P4Ll+nBhOCGvTu/qyjd5ObjFJp2
         q7liIr//SF2VYFVGBetvmdJ5Im270+W6+0LsJakXo5WZ+wHeLj0elbUXVgHVkFl9UCiG
         AND7ErqUzTPwiMr+mnBLhk0aDEpFRJZbFqbGD0fEH73qwblg1+pMhEeA52PtPa/PGzj5
         6DOqBHP2IQcymQo/t5doDMcEDlYaukqN3j2S8vouXcVVMzspkOvPv16D5Gyx1JaYu0ls
         B+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866607; x=1726471407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jvMzetSQgfaUIUzQnNbOMjOFgsmKOdJ2a5KEUYIEP0=;
        b=jqN9u0T3YZ0GoOY9gp/I5oAsLDnkN0Y4da6aaOfY15uUj2+HsOIyaseexvFIqPSCch
         /HmGp+S/NTfVwZwqqjw0c6C9fquGkPNF98xGtwOZtbI1/5XYUOz6XHqkcB49g3QERiYW
         X4IqLut9ddRcwnOxcFg6yjsYG6Xg7A4yZTaZHZACKzLiOKiKMMuCCQWFoRV+K8icUXO3
         4Xknj8zLkZzjlIZ4iOhXuaA9xEylShkK0Mx8zWrIFxkv0Ef4In2Ahoq6MbkhXyljNpkz
         zo4uoAu1lnrSEryhhkiUmocu+QJqD7b6RnmPs0VXGYj9QtBe+037nl7sfKJDKe7H4M8n
         OsMw==
X-Forwarded-Encrypted: i=1; AJvYcCVanic5SeibeqT5K5a2f1xaIPPiXTQmTsfIahzVHenVjADNyJVRqnmgNaFfCDMc3+q5mDVoRG0N4eNrAkk=@vger.kernel.org, AJvYcCWoTy4TlwJLOnQcwrcnMMyo3/U0wm8Lw9v7tTYVAiw8G4OXA4lioYiReizWo0OdjWux40qYrHYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YweEraIC2RXH9z3/7FJX3S4aX1LVpiWwhKUJSPaiJhxtEOlZC3R
	iinHzMLzJ0aoHd3AP6VGQjqm6asWoG1brf5TM/6sTVwwmVn766Ql
X-Google-Smtp-Source: AGHT+IFnwQ4qKw3YdRdPnWWCvIHpSzE8mmzRk4hhqNwzzFWUwA1yxu41/7qIr4LPvwDhRQPAKssY8w==
X-Received: by 2002:a05:6358:52c9:b0:1b8:44ac:e6be with SMTP id e5c5f4694b2df-1b84beae8e1mr948799555d.20.1725866607110;
        Mon, 09 Sep 2024 00:23:27 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:26 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 05/12] net: vxlan: make vxlan_remcsum() return drop reasons
Date: Mon,  9 Sep 2024 15:16:45 +0800
Message-Id: <20240909071652.3349294-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make vxlan_remcsum() support skb drop reasons by changing the return
value type of it from bool to enum skb_drop_reason.

The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
so we just return it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- add a empty newline before return, as Alexander advised
- adjust the call of vxlan_remcsum()
---
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 04c56f952f29..03c82c945b33 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1551,9 +1551,11 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 }
 
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
+static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
+					  struct sk_buff *skb,
+					  u32 vxflags)
 {
+	enum skb_drop_reason reason;
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
@@ -1562,15 +1564,17 @@ static bool vxlan_remcsum(struct vxlanhdr *unparsed,
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
 
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
+	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
+	if (reason)
+		return reason;
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
 out:
 	unparsed->vx_flags &= ~VXLAN_HF_RCO;
 	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
@@ -1723,9 +1727,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vs->flags & VXLAN_F_REMCSUM_RX)
-		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
+	if (vs->flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
+		if (unlikely(reason))
 			goto drop;
+	}
 
 	if (vxlan_collect_metadata(vs)) {
 		IP_TUNNEL_DECLARE_FLAGS(flags) = { };
-- 
2.39.2


