Return-Path: <netdev+bounces-288940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AKULrfPCmoU8gQAu9opvQ
	(envelope-from <netdev+bounces-288940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:37:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4B568F1E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7FAA305A368
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703893E3C49;
	Mon, 18 May 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC/y0LZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D723E3C46
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092772; cv=none; b=PPhlYT4+qMHoGEmfMu3zOsU+IPz+odMPSZNT4BY5gkyjW5A5vCMBXBAB1axndoBY4WXuzSI/nZ7zkJB2fjPSZkAlZ8XPc1EFp2RwbwgXGLujFBBzNtuWff6wNjGd8nB3s39UqvXE1DV+1maW7HhNbvDvD9BL9yhSBgnfPz/fVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092772; c=relaxed/simple;
	bh=ZDLOyJOswmo5RlyF6Yu298Y8xMNBbTt2rTJK+rV5gis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QrA6iTn1v5e9V2/Q6sEzGurhenztb+yQyDfz10KNQYwW366JYWhjjjVYaQPPkquBYg4XWlA+j6kACFXYp3+53HyqgRWbpIaF+JiVp3gmN7quPY7AF+8aOhshJkN3JRZSZ7iGOUiB2ZnJS2BDv7o+spXahMg+vAH5ZqhTwyGXqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC/y0LZl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so23400605e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092769; x=1779697569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=If39ClIckMydOmcpj07jcbSov5r81Hv5FFSYom+H+B0=;
        b=QC/y0LZljriaOuCoOsyw5IhoDRiChN6l6qnvOdAiBljSLh/Mv7m0yMOJsum1Hsb611
         GzM94S2FHK38LnGWrUMv34AB28LVNrg7RPtRIaPecGH/XBWkfCBPV5eGGxkiyiLLC339
         W4NooG0Kx6sz6tmKKqvPWtRVAUOOk85nugbVwSAStxBq5h+Yw97wPODsOGTMkVhPU3k1
         zTN6im/YOhH9Gr1rtp86QwjDWNAgPNYqjQiJE/x6uhArlvYcFllUXG89Wo9JPVOcD+yM
         MQCyAY6V+sdiphyB1DEuE8c+W8Ot7QwzGydX77WRJbhN6Rz75jTDe9ozPm2s/WLfaKuq
         9tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092769; x=1779697569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If39ClIckMydOmcpj07jcbSov5r81Hv5FFSYom+H+B0=;
        b=myxdprK5ZDkr6CTNRld4ZjzqzCvNPc3MZO89N+ns+PedGNGhfWtHWPiKy8qeEwY+ZJ
         LoebNs5mdlkGbK96kwsyw+JopvRcaL3VnkoPaCjfmvQZoXt353mJbXI+nL/d9lTKp1CT
         PmTKg+QMo3tqbWKxTLkaU65RGF0N44ziHN35+46W5Bm8vGZnaXb4UOmtQgF5dXgFuIx9
         XUDsMBY0rcs2FQFWAThrAVj/FiwItRdYo2XaNiLx9vCfJQjye2pcV2LQkZNyYXvzgtcr
         zIDQClvRKFzYbwtIM0H2ab66hfsQ1V3X4q7RcnFkvrnOxQUYOfLZ9O8ckqSkaUsDQDPJ
         bcBg==
X-Forwarded-Encrypted: i=1; AFNElJ8jbGpBfO3VCbE5bZd+7poDR2CrGWzVFL4X8LCvJEmIBRh8z8c8aoOfiWdvIfzhtXE1FVawG1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJr/kDiDFeaNrzMQgOsy/nbGc+/cFXWLaeTCTwFveID97cujsn
	IiJ16I0GmrZFgD2+78VLB1zeeOL+kFlAD7z+Za5TLxhy+ve6+eW/Z7Dq
X-Gm-Gg: Acq92OG477V7xVxRFGQtIbnvasRGlfiEQl89lmL+K8ZXYPyi8DzCotKr01NYxsj4ayf
	ByA62F7kXx2RWAJvxlB1fw1l6UHpg6Y2kybxzTPnmjQGov72vBHZJ/DqdQKUiGRLYQVYkeDAhKu
	4EliI8yTrEzG48MemgfEMvHFc2dQo8vbXIHGcbqVfk3jw8q43qiwBhZFDdOX5SEbHxNrtjdUxRO
	Jn32bp1CHaUSxwW5O4HbEyeoJgAmB1Nh6VXdpPyUaHkU125v1p52dVRuYlpd+8GGWlWy6xoVAem
	4VATXRe2hQ0ze1IcKD1isGoftZ43EpEE1HCdzXGK6algSPoDyJX+nAhZakL3mh2gMoZNJhdaZK2
	H2jZx0wwAQ/xDqPrx61kx4xiMd9y3M6vI4qnEbCbQbsPpPFJ/YuWBNy+FT70H3ks51gZ4xiIVJB
	A9J6l1QsdJr6ocMI6378e//BDyD/As9yAy8y/KS7qcuMw=
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48fe60e7d6emr173167515e9.10.1779092769255;
        Mon, 18 May 2026 01:26:09 -0700 (PDT)
Received: from localhost.localdomain ([41.116.1.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm32834085f8f.0.2026.05.18.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:26:08 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Muller?= <gunther.muller2008@gmail.com>
To: steffen.klassert@secunet.com
Cc: =?UTF-8?q?G=C3=BCnther=20Muller?= <gunther.muller2008@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] xfrm: fix missing headroom check in xfrm_dev_direct_output
Date: Mon, 18 May 2026 10:23:30 +0200
Message-Id: <20260518082330.11483-1-gunther.muller2008@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98D4B568F1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288940-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gunthermuller2008@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Ensure the skb has enough headroom for the hardware offload device's
hard_header_len. If the headroom is insufficient (e.g., when routing
through certain virtual or tunnel devices), __skb_push() underflows
skb->data below skb->head, causing silent memory corruption.

Fix this by using skb_cow_head() to dynamically expand headroom if
needed, and switch to the checked skb_push() variant.

Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")

Signed-off-by: Günther Muller <gunther.muller2008@gmail.com>
---
 net/xfrm/xfrm_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcbb..35f974d209 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -649,7 +649,10 @@ static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
 	 * to netdevice.
 	 */
 	skb->dev = x->xso.dev;
-	__skb_push(skb, skb->dev->hard_header_len);
+	err = skb_cow_head(skb, skb->dev->hard_header_len);
+	if (err)
+		return err;
+	skb_push(skb, skb->dev->hard_header_len);
 	return dev_queue_xmit(skb);
 }
 
-- 
2.39.5


