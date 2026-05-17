Return-Path: <netdev+bounces-288720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG0lHJukCWp8jAQAu9opvQ
	(envelope-from <netdev+bounces-288720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8E560AF4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDD83009153
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F635A3B9;
	Sun, 17 May 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T11L9qFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E5257844
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016851; cv=none; b=qDOtpL9m1Dt0qvoCLaKM7gRlLoi/9CnFdOXKNuzf55DYjQFa41XH6q8+wAxcmAfoBn/TP8x6n4Nq22rXqnIu5TYAg6dfXc8DF4fhma8tShNLosWfvZdZ6fGX0UecdPo7RcvgyAPk3/MfprgYo94TIquDCcyjOxQYdYG8MEqMyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016851; c=relaxed/simple;
	bh=742HpjWfBunlX0gLCx1MU56Y6xvCxdB6ILp/o8mwkMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rgMBga/xFmXmC+JmeSJwpCvyCtGD669jrh4LZafAgi0iHD9BvvweHX0TVJ+iqmY3LqkaSv4tbiRmQSvjgpIpkQxAx8PY23IrgjdbKnbtzzdeWUjM+BIluugAzKv/fHLtm2if457mfnd1ZSn9pAnlYHU45H5iuNW5D8JIgoqKANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T11L9qFX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so1433205f8f.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016849; x=1779621649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBNYR3i72PjHFZuErvRNxZRW1PJhw7Wm714gx7/9InQ=;
        b=T11L9qFX5Pw4Qt5B9ZPZOTXsHCAxdYDk/DOPDPW1IOySXS187NvrLUkM+9foYS/HoO
         6K/qWLIq/mCbq2uLzMpY+5TxRPyF4VKWok8BNvxrdO6YNsLTLWAkLEZL9bZoe9iLrPvO
         DHxN8ReHY580iBCFkZFGgD3tv7ePfKDOw26VCurkevXd93738PgNBcoTSoo0ezhWP7iZ
         R+cnCB+Bdy7RLsJfVqXXGSV9PMSPiTCI2REbZJnF3/ddClVs95gB422asLPQPROABXY/
         1JUozCKrSgBjpDFLhjbBE5PxaSKCHMTMDOBjxN3e1e9h2vaWD1ywP0kqsyfioICh/wI2
         0zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016849; x=1779621649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBNYR3i72PjHFZuErvRNxZRW1PJhw7Wm714gx7/9InQ=;
        b=mP3J0h8GfCa2oIERq2Sz/C5zwDuPOnAV7+dfTkhb1wlEcvaxR2OxYm265ZEz+RkQVK
         p+ZKPT3uwSoZnCsAWe0sikmVF0sBRKwrNzx6+RDh1SuUm5iT+ZRw28N+SZI/jPP+p+t5
         w+mJz8VIAUQOqwj1ulzZxUqVjUTZPznCN06rNzxnzmII0iPfXJJbETJZiAkrJjupDh8+
         8TL0dUbfQjxjDPf47vpLTABvQEzDwCd2fu3bFzadh/jG43W5JnEYULhsZJxqxowuZZMN
         BY3NYz6Wkg1tKfHE0q4StQQK9I5yaHi1DYNOm0k495wE18jT0AoQtxbwbpm9b7akE2SF
         T7JA==
X-Forwarded-Encrypted: i=1; AFNElJ82S3SAyUeMQwDQCEMR332QHK7gwBd9bxrUYTVDVTepiQc+gYKKPYF+mK8TCurHxej08UJhcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkocpYqd7DTQG5A4oUsHka5R6/0xwhanfcKVy9EWKQHknMSlym
	yZM8hW2p3t7BCM5ke45Xw3wE6gjnHQ/Xs7xRDeGT31W+9YgQN/EA732L
X-Gm-Gg: Acq92OFQMUYYAeolyGxw7aL4m9/3Tt7+CgDg5TEWq7m5GNK+rlUANvyyJ2YOf9zr2i4
	3vUoV51/sNw/rsIT4+PyCFtY2dBz+sJHBoRPLn5SNIkxQ5ZPD7uLVqjAAFqZr2Avrkc5EoxoVEV
	ZMuV7K47dzh+PmP65Pka7GVtQWja9yXPZhGt4dmiBxNbWe463dxyZnTRhbBlqxuAneqDtZPRLsy
	idjvBvllxqYiv/UVldr56Qf/W37iKrQ1P8sciRXJKHJSvaL5I/Wv0wtCAxDAT0EkpzVDPb9jVAF
	cjbdVCzUQ7mJqmYsMw8Y0tfBGz2iP9bwB50mBJ253OBHmSaPdVa5G5pBCkaSQcAL+2u8LPEj94U
	JIXrm/X6FFyjxj4BniFy+yti//lp3wZUiOR/9Fn5areBKGL/oe2CE/Z8pKDOMmXoN46YeFd6mT0
	9q/N+atu7dm6CPtW9YVuYLgkuiQFaoIdRjy/HuuufRElw=
X-Received: by 2002:a05:6000:2a02:b0:453:dc4d:9265 with SMTP id ffacd0b85a97d-45d90d76962mr16707359f8f.10.1779016848713;
        Sun, 17 May 2026 04:20:48 -0700 (PDT)
Received: from localhost.localdomain ([41.116.1.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm27878624f8f.20.2026.05.17.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:20:48 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Muller?= <gunther.muller2008@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Muller?= <gunther.muller2008@gmail.com>
Subject: [PATCH] xfrm: fix missing headroom check in xfrm_dev_direct_output
Date: Sun, 17 May 2026 13:19:40 +0200
Message-Id: <20260517111940.8987-1-gunther.muller2008@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2B8E560AF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288720-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gunthermuller2008@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Ensure the skb has enough headroom for the hardware offload device's
hard_header_len. If the headroom is insufficient (e.g., when routing
through certain virtual or tunnel devices), __skb_push() underflows
skb->data below skb->head, causing silent memory corruption.

Fix this by using skb_cow_head() to dynamically expand headroom if
needed, and switch to the checked skb_push() variant.

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


