Return-Path: <netdev+bounces-286230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOdlGq/e/2mG/gAAu9opvQ
	(envelope-from <netdev+bounces-286230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0B5021EB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8627302FB5C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD51F4C8E;
	Sun, 10 May 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+/UGRyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE11E5702
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376228; cv=none; b=fEqshMZDzYEm91BZgC1A+/EcWqgf46pJYwg7uWYMwHuWhXSNg4WFSxt7Nai/bjJh9jWJ+CtIcQxM4nCa8nhjkkpC6jcznu1FYnry8yTbw7Z/3oDxYchc2mzMGKV8JYTYig9O/EPhRZMzc8kgr9Nh/o2j3GeGvMUR1uyEPoTxYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376228; c=relaxed/simple;
	bh=4iX6eJkexz53dxVsq9AYaEzTNy8W+QRRol5UMw9qdiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFLzaQbhHXGGnsE5e46hTvCPtcK2qRZmavkK7s9399SSJb3825xiRiTRMRqw04iFD2SKQ75KozNAkcn6wfpk+Ahx90ne7X0OJMBFaxOS1/3etkLAtGG+L/3Ca6pI40boJQKLcDNaPIrqU72VL76o1A28X0y3KiG/s7poGpM4sBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+/UGRyP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba928852a5so21161045ad.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376226; x=1778981026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k83FvsWSelsobvUl25t3vFW44Bj//lrGN1EzdGDWel4=;
        b=d+/UGRyPLgXnShSLPMfl2NoZdUCnty1AtzGW6ZS0sUYUi3yeamfusnUGi5Jc4DsGNA
         UiRRCA4fq3x+I9Ie9kjfTjYwJb6wnITu3s7W0sxaw46voEtdh+s6z1iGdeEzK+KZsNVy
         aPCdoDqDsk3qh+njwYPya2RcZSU+soLsvE0jGArEVRg3i6hPtkREnJGLWjwFuiF1Xg15
         xQ7FHURxm+nWLRcwOp0+WQg9aG72rAvdqcrn6HZseS1EfPP678/gPVSXrvME/Sy78cOk
         bLbfhwzCRrif48F11Nyjyoc6EHmvIowQ6TaYH+o8w1UXkIu2PsEBDzMoY6OGMPrdg8Jx
         /80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376226; x=1778981026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k83FvsWSelsobvUl25t3vFW44Bj//lrGN1EzdGDWel4=;
        b=O8w6ZoRHtPDPfNDAkdHJr0EHByvjj+/f7lyuNgSpHnMGPDrqP75sQsQdOdNH0DAiNw
         h7pAvpJUEn3AUMW8ZgDFiiapSGYwW0W25592kRlhgHJU7npNr5z4zLxMCsSkPzbfyPhg
         9o9A8iXscou/LFGmj1nDfSIYls1OCxM0JGcpJ6b+i1kn6e55pTLlbo/Cd2DHNh+JyxPe
         w+MbmxLA9TebzwKg0YiWFTbDJzYrko3T1iVuO4eGGRfGI0vlr00FmNSTwjRrEUWXzHGG
         LGCwJGRJzwpy9bTp/6hCEo0cSvnD/vTHJttakoWYa6Ls0mSH2RDeQlMN0jCOKiCia0EQ
         hB2g==
X-Forwarded-Encrypted: i=1; AFNElJ+JlTgl4Tjah0DByniGGgxzkuxMrKTEcFypUubERrTpit4IEul2HzK5fsrU3fQAFQPj2TJiRTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUfCSjMFQyyt5Diyg+MWs+yKdCkceGW1n6f2FQ26RdYzOQH+C
	vpS+FuXQfLLaRkXvna2GpOZDdFiCKLqWuGyF5yy78tfAo+pBxWo6sVh5
X-Gm-Gg: Acq92OFomltgSR9apYrMIy3b1O31wpiHg7zUFz7w50pxTXTIWxzS4AezdGJqC/Rtm9p
	LXvwy6eZzG6ohhyL5gb7UsaqDIQhZyUKJXZZ4gLfnXvQC0FBifvKNma+UIjxDQYetRQY0swqvoc
	lbMDFFXepqC1IHLyzZXyyPKywZzn38ZKW2Q9nYAcuCWgxO7QSuFL6IE4QyivRUO2VKQlJyycDpv
	DgN9zr9VjPN4/tAn3XTvibxt7Jk9Q5QNCO6rZ4Uoc38BDXcKRpUoToPlnxwjpwfFnzHu2uQnAFd
	lmH/uTcKAx6nKqp2gcNkFgRfe9eTNEx5cYlROmDu6IW1msefjA0KiXKirCEQqFTF3FzAgaoMuRf
	/knXuoetvI18KbHOhgLaFl8CCkPalvBFMVmevvRI4ECV+s3BmeW1hgen2bgNWhAjHSsFFwtAPLq
	XHTnf5CcE6VRCQZjFCx2zK6O2iIXyEIc4figcp1OAFca94Bv2v2ppIaAUN6Z6YPY4FQJSc5Crsn
	Uq06l+0MBg2+ljruKx+FsMNRBC9Epo=
X-Received: by 2002:a17:903:1a28:b0:2b9:f8e9:70e2 with SMTP id d9443c01a7336-2bc7a990b6emr41452625ad.8.1778376226401;
        Sat, 09 May 2026 18:23:46 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:45 -0700 (PDT)
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
Subject: [PATCH net 4/4] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Sun, 10 May 2026 09:23:10 +0800
Message-Id: <20260510012310.88570-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCC0B5021EB
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
	TAGGED_FROM(0.00)[bounces-286230-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 232dd7126905..b41ed44e3192 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1045,6 +1045,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(&desc))
+			xs->drain_cont = true;
 	}
 
 out:
-- 
2.41.3


