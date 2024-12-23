Return-Path: <netdev+bounces-154025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D294A9FAEF0
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A5C1882E81
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC1199924;
	Mon, 23 Dec 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llT0C9+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A357190664;
	Mon, 23 Dec 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961237; cv=none; b=TWEzwhfOudixJjtPksxa2P84oWGsSJputam/LCT7KTfR+nyOXUhhZDUOio9PxsrAFkX7yigby0d0iypLNGX64RjGgigfT2/nuBFGlx4/SQAmEd7n9TaqkJBCikemOJiGICOwYcilgoCiZ4FUO7sQ5ZnFjEYmK8W8BSAc4DZ3tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961237; c=relaxed/simple;
	bh=EgnJ/Tkh1C1LQYcKEaughP+rbf5J1jqLZWDAyyDB7yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNeQdz1g3/NoDdYThVo6IoH3xgdW8WsHKPUAaVa/wBgbkQ5hqC5KjyxR+dJHgVFo3H4U/B7QkekLF2trdg6iBliowsJjHKag2z+CWafHoxBjURVhr5P+INlSmsCMIrqiN/8oX5PdbgyvUGo8tkWbeeUoqypEXBYyAg7ch/zsq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llT0C9+k; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844dae6a0caso123000339f.1;
        Mon, 23 Dec 2024 05:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734961235; x=1735566035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mDKl6tzxVN4OlPSHKO5eWK8XZLJ0ANoR86UwcJiqUw=;
        b=llT0C9+k9wA62sXD27N0j5ds8IXQ+6T77n++1THgyqfBApr9E5vY8KCtftOA9deKwp
         o5Mv73ohbkHgzTkipOVQZhEORoEHjcgKzhClvgKy/ivKXO9RXQwi+CVPxD1NEOg/J9Iz
         EWl+DK5RUSlDyUnMLyM7IuHOsZoGx4xxk+qA86J/xpaVSLI3vpizVa3SnwUpXZsjjbFZ
         KAmiSLyz30fAj/p+XM29/AkvlbauctB0rBybq8EHo47nMpLmJJWBv1JoU3PzQ6sdKxuf
         wtM5rgWPAXaBpZQTuG1J5xUzKaneiglsFP5pZ11qP98u6sY1+DkRG++phUK+C8w/AAUm
         ATxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734961235; x=1735566035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mDKl6tzxVN4OlPSHKO5eWK8XZLJ0ANoR86UwcJiqUw=;
        b=iiVusM1I3LqknT7SklZLhKbQhhIC/svJ7T6hPe/arrwHG/+G5oPZFjHzSUt/BnD+T2
         ymlBGbrYamdj7bvTEy/WE4z7bjE5GY+xz8K2VqkILPkm+eJoWz8W+PBekA3zy5hudSWU
         OC8ERzPEH2pj8JF4Ww0GTn298UOWEKI1+VQ5nJEjP69Jcc3eB+qpIo/meE6YCPEG5FeJ
         NRf5TLn0UGKAQzwgQK90Pw7QS6DDnWvMuA9Pykwvqo5ULmkkacIBkc24eVno66ggqC2w
         1qXeS+4wLtmMQOfnjFLDnvlrgCP2bQCzRN+1puj0bk45o1EQy46/jNGjLNfbAcT3kODy
         Y7og==
X-Forwarded-Encrypted: i=1; AJvYcCXVlU6YDXs/U3g0k6G5dOEW6cPrGACtBqUB0oxtfwwc5atqKG0eVv/v59OIagbWtwiSDV9QZlhD04Tgpgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgYZfcbXqcmrnE+Ka08fa9aVHI4Gpfd7P4nRE/AkepWi1UaxR
	Yr0lXRS2i13+o7EBRXZ24nE9cwwcVfEPcBDNtovYoO/SLQdaBWEeqBeAYozZ
X-Gm-Gg: ASbGnctMwZ/NWm4Jt5wL/wr44LnTp0J7o5ZVYdhEvDtWLupVJHdxGg85XZ77nVaUfuJ
	oGe2E3WWZ1VdIAB9QywsfwUvJDQEivveJGo49xTp8Fw25BpcuThST1/YeLcRgrpqeLM2LRf2ONu
	3srHbL33P4kqHta5Ebx9V/x3Yygm6sNHCPGKwYaWJIKCtdhcAbSAk+BZAwn6EkL5ui7jzRYJFyv
	EBo2dSxkIzrvfZXPp9w8boDgELhCud7Q4NezbfVpq7ihdtXkaSw4SZjgRW+Bro=
X-Google-Smtp-Source: AGHT+IFmEtQrufWl2zv0bdenpCyUPipTz3HkTVVXserEvbD10EJhPMh3JV8wfAufs00Cy/zraLSc1Q==
X-Received: by 2002:a05:6e02:1caf:b0:3a7:c5ff:e60b with SMTP id e9e14a558f8ab-3c2d1f74a78mr111562635ab.6.1734961234950;
        Mon, 23 Dec 2024 05:40:34 -0800 (PST)
Received: from T490s.eknapm ([174.93.21.120])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f349sm2230059173.14.2024.12.23.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:40:34 -0800 (PST)
From: Antonio Pastor <antonio.pastor@gmail.com>
To: netdev@vger.kernel.org
Cc: antonio.pastor@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: llc: explicitly set skb->transport_header
Date: Mon, 23 Dec 2024 08:39:12 -0500
Message-ID: <20241223133915.2333146-1-antonio.pastor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220142020.1131017-1-antonio.pastor@gmail.com>
References: <20241220142020.1131017-1-antonio.pastor@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
have skb->transport_header set two bytes short, or pointing 2 bytes
before network_header & skb->data. As snap_rcv expects transport_header
to point to SNAP header (OID:PID) after LLC processing advances offset
over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
and packet is dropped.

Between napi_complete_done and snap_rcv, transport_header is not used
until __netif_receive_skb_core, where originally it was being reset.
Commit fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
only does so if not set, on the assumption the value was set correctly
by GRO (and also on assumption that "network stacks usually reset the
transport header anyway"). Afterwards it is moved forward by
llc_fixup_skb.

Locally generated traffic shows up at __netif_receive_skb_core with no
transport_header set and is processed without issue. On a setup with
GRO but no DSA, transport_header and network_header are both set to
point to skb->data which is also correct.

As issue is LLC specific, to avoid impacting non-LLC traffic, and to
follow up on original assumption made on previous code change,
llc_fixup_skb to reset and advance the offset. llc_fixup_skb already
assumes the LLC header is at skb->data, and by definition SNAP header
immediately follows.

Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
 net/llc/llc_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..6f33ae9095f8 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, llc_len)))
 		return 0;
 
-	skb->transport_header += llc_len;
+	skb_set_transport_header(skb, llc_len);
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
-- 
2.43.0


