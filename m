Return-Path: <netdev+bounces-276766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHWxAGj/1mlKKggAu9opvQ
	(envelope-from <netdev+bounces-276766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBDD3C535A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2CE30166EB
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D672D839C;
	Thu,  9 Apr 2026 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEf/1zGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08672D5C68
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697759; cv=none; b=XBp91Ns8pH6oQnm1M2o9zpgWipevOUR16Q662lcOQjoT+MpDZQ+x3YT1yjIBEfyRo+YGbLJZwdgIaU1tMvXSBO9bBDt87sEvCEYOEWboy4MO6rLYPNd59qifC0Byci15ChkRl/ojY7FudzS5Acy/fGsFwEZ/dBvxl7pMaPOhD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697759; c=relaxed/simple;
	bh=erkjuSamtwykdXGKyc4eVKBd28tB47XXwgb0llv6irs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jglXaR7s9oT0Axchj0+8ZCc9gVcM822y4Oii9ZFFLaGfNdXEN6IX+liWZTeD4rHxJtzkBWEsthOkTroHcYHbYIfrkQjzQiM4TM8qIiGX+W/EwfELSAlUBM/IXHKWhLWsihaqRdTqptXdCl+V7PY35KGCSyXCSDbGn3UcZImDlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEf/1zGH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a48deebe95so3338636d6.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775697757; x=1776302557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kHgW6gODzr0y0JslZ3By3mLh3bKpybyqv0sVIih/4g=;
        b=dEf/1zGHFawTUHhITNcPHLGKqf3YRUB76RItNXMOIPJroXuU0x3z0Q2C160WKo75qe
         nReiIwoZDSERoda5PP7ZdK646z87Y6WR56vDaPcctgZPOhBFL/HqL+JQd+vMoPkDAgLW
         oLfetyLRD1okD0nWO79FifEfKQViBO85t0pqqQ3pFbi0G5qo1jIT4WC2Fkij6rZTPcfF
         /FXxTH/SZ34YQgdvnFVaS2xG0suYwtHDvUSLgKAfuVrCXZ8ZPPxwA4gNKYrDkyN5ghHG
         8H6zj9EDrBt4LxKW7xECZLk5IU4M0F3nZUbFqAifF/4Pi2waEhWQsFbG7voxhHMPW2XH
         yBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775697757; x=1776302557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kHgW6gODzr0y0JslZ3By3mLh3bKpybyqv0sVIih/4g=;
        b=pRFJfrZ+0B7Eu1uSWs9WtT76Kv0VCR1SDhE+LZ8xQkhSsI+0OeATkMhpnZhYBlVfEr
         YxG8L+oTzSCqNeQSMQDVSrmZqMORr9pkRCntAYvKFk2yX6+kj7wei/hBwTP+X3B0j77s
         DdRobIc7omb9fzD+6M5I2A+qnaFkvtaVGAQ2z7z6XJED6vm6ltYIhPD7WjvHnc/4/NPZ
         BgUYmB3yXfu56rl4a7SEh+Hg9l9Nt5a7+uRisWcFFA3+pIgdXf3LZ2Gmnx8IAMIvzio9
         zsFtsXMb6VfCpXbAgj0gssnFAh/F4f3KwKjNRJ2nAFSpRIrmniOldj5dqrBHF1FEfQGn
         ybgA==
X-Gm-Message-State: AOJu0YxwRoMdZ8+yY31cCkDSqtES2vE62jOaeZWSi3d0EksaAU+74o0M
	PgvO8sQfDH/+5/npzQevR7Z5IAmdxAhLKrBFhHickLM6abo6DIF27GQSvIuUCY6O1Q2Ubw==
X-Gm-Gg: AeBDievkThIb/ppkcas2oZqi3MLa+IbeZ5AaHNEi802rG5EXQ+08dCHV/0tgcfEX7s9
	8ydDTcV5j5odbJDt1JJoUyQ8cCSNh3vnn5O0D0hpyMDoDOXltte8QfyHAXZo6SnIIsfr2UJXaQf
	wwTIaPQm9ZpsO/ymMkaP+x7Ttza38xd11M9XH4GR40LrJfoFIbY7XoXkdezHwht2ao9VSXepe5V
	n/NYR3wMmplm2+MqtasozhmCMblc2Djoy+dI8RRqhLaZ+ZjfiLIhFrqFce9VSOm0eN6hgHQvtPa
	8GQbkccOW259SXYfftILq22tGx5AeotiBPqxZNsXsKX47rXDLHnYDdeJI5mJVrFbC/Lw8IcmXs2
	3vQeCRt42NP2fjQ+BrgMFNGeS6mBwYixLu8LzwE/PHWmY3ToyTX8+mCRyl3r9xvEirAG2p6Aum5
	Hwygur6fLFJU1rlmr3VmmQE7KbDSe2Y1/TGwWVDk1j5ONcZMCqh+AbStklgunxiUlxnyy2MMMqD
	Kl+6qSflBbwXV/dzoNTrD4Uv8nnMZ8wOYRBIcA=
X-Received: by 2002:a0c:e017:0:b0:89c:d886:c022 with SMTP id 6a1803df08f44-8ac740aba14mr28587616d6.1.1775697756769;
        Wed, 08 Apr 2026 18:22:36 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03ce5sm217106476d6.35.2026.04.08.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:22:36 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] ax25: fix OOB read after address header strip in ax25_rcv().
Date: Thu,  9 Apr 2026 01:22:35 +0000
Message-Id: <20260409012235.2049389-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yaina.de,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-276766-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BBDD3C535A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ax25_rcv() calls skb_pull(skb, ax25_addr_size(&dp)) to strip the
address header, then immediately reads skb->data[0] and skb->data[1]
without verifying the buffer still contains at least 2 bytes.

A crafted 15-byte KISS frame (1 KISS byte + 14 address bytes with
EBIT set in the source address, no control/PID bytes) passes
ax25_addr_parse() which only requires len >= 14, and passes the KISS
byte check (low nibble == 0). After skb_pull(1) in ax25_kiss_rcv()
and skb_pull(14) in ax25_rcv(), skb->len is 0 and the subsequent
reads of skb->data[0] (control byte) and skb->data[1] (PID byte)
are out of bounds.

Add a check that at least 2 bytes remain after stripping the address
header, freeing the skb and returning on malformed input.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/ax25/ax25_in.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed..92baac77f 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -217,6 +217,11 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 2) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
-- 
2.34.1


