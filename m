Return-Path: <netdev+bounces-288908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOPYDvvICmqf8AQAu9opvQ
	(envelope-from <netdev+bounces-288908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8815686B7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D2FF300B19F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AE3E1689;
	Mon, 18 May 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVeTIGs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F763E120B
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091686; cv=none; b=CGFDTaYZWZs1k06hxvtXgiMIXAbl9XT79jkeZpMsTJoN1HNvo23m7yg6jfq2E/uEGCYhX8ytEL7AhBOhY0d4DaDLwFSYl6NRGGvbmIPokmTvBkHPMaKMOLxm2gpsVCOa8NHZj4TCJerLd95iHmcP2tcJsN1bVxkxizrMMY4zlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091686; c=relaxed/simple;
	bh=ZDLOyJOswmo5RlyF6Yu298Y8xMNBbTt2rTJK+rV5gis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhmrGifuOjsW7G5XNVnU6Lex6T8p4RJmtQe6ac4y0ibsX8ioxu7cPH3yJRcUP8cTXcYC78zu6pKvPNefLL+9Myn/pOBgtX0boh1aHBxGX7+QCWGeHptmL0oTUy2Y1lkz99spRp6jt4ygnfc5ab4LdGXcG33ox9Ak7AuZv5YTSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVeTIGs3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso22577575e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779091682; x=1779696482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If39ClIckMydOmcpj07jcbSov5r81Hv5FFSYom+H+B0=;
        b=lVeTIGs3GPH6wdo+VtNg3SaTmO8VG5fEVZK5+E6mreOy6wMLXQ80SICdmEy/RVPfzZ
         6gX4fgnBJCaQo0BM7A9v5pWxBQcthe9nRU1uMA6CKCwBRSMQDSNJ7DxhNDweKxTJRDRn
         wf94shF0rAoaV0fUiJ1auQiTl1Ievsfikr1V90wcxmPfYtOWB0YxyId8aKFOsm7QEty1
         c8g3b3/vK3IxDWGTRrkVWPJR+wx8gVwdVuVf+b/KQKeU6odNy98n97ArGRACEVvdCb1T
         T49h/P0W6WPCLoGdiJ2+7pLQMb5KGtuN2OMSht7JCZI6RR1azJdc8Mp10cEIrm/ttFEZ
         kGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091682; x=1779696482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=If39ClIckMydOmcpj07jcbSov5r81Hv5FFSYom+H+B0=;
        b=ZQdIqhYH0Zx+jitwJkbtZCpJEIJcRGbitsrQ4GSu+4tO1YyXNubfO6iGp5XKrg7TCr
         S94wM6I3+yEHLFycdz3qTNdpDcAUNrY7PwkU5j+GrTJ0TIPYH2TrQPnZ9uncQ3BovvPx
         l63b+afhZ1pFvWRIuyB5BkI8cXMyUcMUpJYu3wx/sDOBdsB2H59pTUb+eeI/HJC+KoN6
         G9QsbRGrJ8lvwcV7Z9V95YXiCs9TtzDv9xqEm88utR4lqQ1fLmLZLAnwu9IWulK4d1eA
         2PmZ5JPQT6MtmAIYVNxp8qpFNeMNPxFbM+JC4723JtguRHxAnYZRZZ0N2NMV/qU/oj4w
         I/iA==
X-Forwarded-Encrypted: i=1; AFNElJ/19O49zDl7Rj1zQ8b3JlCRNFQ7+IWVx+4XzUwKUMlFQMfy57FRxWsCEH+1sbGQrga7k8DRz9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY/+rihFc18gD1e5hjbpkFvZLz8PjcwcCs8D4RzT0rDnVJ9oB
	2nPk/WAuakuC+rIP7dpKPbAVNEur/K6w1z0lFQ7xtUpjdIPo6mFIXWff
X-Gm-Gg: Acq92OFVFGz4iSvpgy1jPruHrC5bhLy6266aP5c5eFlVL6h+FyMala998aeg6leUQ6f
	AStBofvoE/R2aaSK8bkUeumDo2VqBgPY3irZeFPKlVVnhSvo05x7UpBaqE0DQzcqA8kvusz38zg
	TuKbxWt3e9K4LMXJgLEg0AJbPfr3v78pDdVyOJk9bwlKHGE41s1FXMGBOsXOQ64geAdcjegmaTh
	JZ+CusDOsAK1rd53fz/KcD3irDuKB5wk4Y4xNZLQ/pcT+FYdyI7BerGmkfjR5CeQfIbvO3kzZ6G
	n+9lopcN4W7QJ3fxjgY8MHigOR+pzzjUcawPJLKNivBC1Bx5+i46R/f5EZzk7n+pQ/wP0O3UQTy
	SGV8P9ziBR4uOJbqQDig2Tdvox8GU/BsVXoK9o5zqG5CY4je33qWXtUTIKlufbPS30OSWo/YPWH
	BwWpzmnmZgao07R4OdQx27iUGLORFaN6kMFHCBlZunDps=
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe539198fmr199248955e9.13.1779091681684;
        Mon, 18 May 2026 01:08:01 -0700 (PDT)
Received: from localhost.localdomain ([41.116.1.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm226637635e9.12.2026.05.18.01.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:08:01 -0700 (PDT)
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
Date: Mon, 18 May 2026 10:04:09 +0200
Message-Id: <20260518080410.11119-1-gunther.muller2008@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260517111940.8987-1-gunther.muller2008@gmail.com>
References: <20260517111940.8987-1-gunther.muller2008@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C8815686B7
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
	TAGGED_FROM(0.00)[bounces-288908-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gunthermuller2008@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
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


