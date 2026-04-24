Return-Path: <netdev+bounces-280943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF9yEF0C62laHQAAu9opvQ
	(envelope-from <netdev+bounces-280943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0984459F82
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DBB30182AB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0151344D85;
	Fri, 24 Apr 2026 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnO0dddw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750E3446C4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009131; cv=none; b=o1FhNIh6Uj0cJk22YibzZ90nJSu3irrvWwkcPDOftN6uR8S4OqOZW3wh0MzVHKJY/etxwCAgoiQXyUh2tLHHJXWSbPvc/E8L0jbD5Q7Otoz5F+9VL12nlwu1S/qOtCZwIx77CIjXdJ9Cjr2oUmke+9yJ7IDNHe2sUw1nteoQuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009131; c=relaxed/simple;
	bh=QlHxLHs/zNiflxHYOMrRfrLThP7TESwwU6fsCt73Bgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiK7D2QBJJiQ2ulNPl1GD+75S/oK/Sej8o74iHDUlSruh+y6xcTa02GACI16ibK98a9aDfrggBjod/4kXa6kCEpqoic4g1mToQQkblwNAXpqL9+S4G2EaGEk47bXVFvc1nRlULkH2Eo9vziqL4XuDDEKthw+cps8SD1nnLB+2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnO0dddw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0afa0210bso34397365ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009130; x=1777613930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OkuSZ9c9nRJYsSC9E9BSwtAFpuJY8D3j+20Y6r3eWo=;
        b=BnO0dddwL1gi+UAVGHFtzc1J6WML/ZEw4FtP7yVIEC7sWmVnG50844oDF7iKV5nfaE
         29wkSJIWy3W7T7MTOnjsMt0AjAdlJxmElqoxKJ9IXkGtf/w2nuGRxrzoUL3/IJApMNgX
         pw6wsSuubymL0SPKBHxtjkdcafMm1kYMO1lSG51KjUh7RcLnvt6XpsTNz3Zx8OiFzA9N
         ohnMoTr+rXyyL2AOKWJ2BTFfZFRTsE5MxFS4Zn1Dt20zc9zqjCxBcNtDXXJQfO5KfooO
         H0D+bmpvDJPhsFIgjh2PSJDOKP2y6tzOzSS5PQLnpzeHJ7AQ2RimAdodfLNCvxmORy8v
         9mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009130; x=1777613930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OkuSZ9c9nRJYsSC9E9BSwtAFpuJY8D3j+20Y6r3eWo=;
        b=KbMkt2zDISa/rB+j3cldJBaPSAQ7P7xfojsS/r1+dEWXswCfEme86Df69Yw5RDaQ9A
         eeWNrOZE4gTgo5XEZq+iEbywaKMOUpM8TSUgOwQSCUr8rNSARFkSb8Npb1cuYo3UB/22
         6jwM5nmVg0BMJX/W58x1TjYSM4UsQgVIqAhfToqqqsu8OUjb8E9QXDGIlqhESwoY7n3e
         6YblN2vF5t5y92QIJugGar71XhSF3xP1ohKdEFqYJRzMI+VBfXcdyemy8EOunGhEoiTp
         7OMqtMZN4SByv6DSdqF/KgInT1FnMgxLM6uibVOyepn2gJbENDPiPZxTwUgk7PNv4Hj2
         HP3g==
X-Forwarded-Encrypted: i=1; AFNElJ/DcawUC3KOSjjEcVW6rAUCLav9RHaAD7Gr50KYTDmpDTLTrzwtFcNN672x9RX7w47d3RTmtXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+vI51Doi5CPE8YLCS/ukvOJBXjWympG41MGJjO1eGEaZvAxx
	BKItaEmu6WJoBg4iWXJThC68soRrFAgHrb6uSxm8gbQbf5GSY7stqFNt
X-Gm-Gg: AeBDies0NWyyt7bY8kLf+QSMyFbsri0BBDWmsWCmSxtWGKJOEjab+OIllz87xcnx4cS
	/hsGXlt6xcAOgO6SQa1ktyZidtjm7AC6XztZuoQoc2R3l/6IugTK7N0AI50n4DvtvUytYEiwNl0
	3RdJ8LbSisBWgtAOHS9QdlqclZn4rEYwMzxWCz7RGGEdWMCZLZ/nK0mN8fuWFLq8DayeUfoLUE3
	QggDArVix4Lyt767cKzl7GAHadpWBZlDV88c53Q1aeQ3LgePLK62PFYDKM7FdYotadNY5rSgVmR
	u6mhLmfvEidSYetMvnRYssle2I2Vr1xB3lQieuazRzY7vHRU5h6mOvXwf/bZW59sHtnHgcMhltt
	SNVsqZLEMfXy4yfv/K7P7a6/FEIpKgTxpyhAT7L+iRJg1+zTLJnWNyoKhCJ0Jf2Borfibuvnhqv
	Agv2NzRP7DWYkX9KEIiHhbtGZ5+NJKvMVflbQUO2sMaoZmhpdc79l6ZgXjG79MtwDbvHF4GmRXO
	ay/E7NqXwhzW9xn0voN/Fy9W2QcaZj3bMLrakPq
X-Received: by 2002:a17:903:2acc:b0:2b2:497e:3f6d with SMTP id d9443c01a7336-2b5f9e8cdb3mr295127255ad.8.1777009129888;
        Thu, 23 Apr 2026 22:38:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:49 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Fri, 24 Apr 2026 13:38:13 +0800
Message-Id: <20260424053816.27965-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0984459F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


