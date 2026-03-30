Return-Path: <netdev+bounces-273081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD5UODwfymmu5QUAu9opvQ
	(envelope-from <netdev+bounces-273081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F620356255
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802D93039ED1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76F39A7F4;
	Mon, 30 Mar 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLGBj4te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575339A80E
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853638; cv=none; b=EpeM8NBlcvauXwQhmkI0LA+PFyAI6zgtVbzW6Wf8yXY1gBPTnDAyAyMAQzsBpjS1iBiQh5KEuw4JeeXswLNrcnH/JjjpERXytEaDabHbwblqRTBBMdENYdFx6fLBtCwGTqPIzWAwhcsRNCvi5iWKwmK9Is8Vfkam5zHw68teEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853638; c=relaxed/simple;
	bh=1ZMQRFTsE9RGEd8MISqxE82qOuGiFFOcLA43cHDuWsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzcalZCu1mdBZaIoXGmAp2TMhZiTS70JdtcayL/LA0/+YmoKoRH47S3nXN1d+fLGqIGStVq0HamCX9ExDwQDaNPKKSwGYesS7Smz2FlkRDa4neZ5ABZ7R5RlDkGnpobJyccw2aS+ccGfXDntaeyk2Fr/jtsLoBSbl8HMaOmmx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLGBj4te; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824c9da9928so2644241b3a.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774853636; x=1775458436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Sfp0Ek0ayKazM5uQym569fBFMivhcwWZXFfdYQ8Y8=;
        b=TLGBj4teOMRDIwTEWJ8OAm94rPixaY0l6q332vqr9JcKxF/M0kgTFD8x4gYm7FHK85
         hLEF9sYUD84Et9LScnn/WciRvZJYfvW0SdseIUC+NFxzYsCZzwotrV6Xjx6TgEwfA7Dt
         zE0Uuwg8JbBHXbpRdy+0Igb9HAlVQ7Z+ngWru+5AeD9fEt+RUW/0z9xftENH2Y/L0HXf
         UEr0yWxci+D3XEjYGRvtZlGcJgSz0N3Vm78Ak8xZgNQixQxhjm9arWKWdB5RQJ2BIzW2
         UqcbHFYBK4H0Kk9kzLvBFhmdolch1KWKRDO9UYwCeyDzF+k+ZUtebI9BzPkXs4tOUgaj
         ArDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853636; x=1775458436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3Sfp0Ek0ayKazM5uQym569fBFMivhcwWZXFfdYQ8Y8=;
        b=KnL6meVebWRWHZTjLOi4fxCOlKMWUA7XygSbKqaaMpRaHyysbNzJkJ0NpLu+Bzy1SG
         IbNvMIWNjXlvj35S9I/t3lLReLfIr1LTpSo66tbmaLokhOWng2ng3an2x1PZp8zDyOIE
         pg0viBCAIn0768ITVlRRQM2WI0KGcTha/pKkqspj7U+UgQcmqp8qIov5i46jrMtXuVWj
         bcvNUuYaS8uQmleC4zoQK9xs/Cf7CDZ83Bg52tUNBuHMlFXNuUen3HmLo6cAv5XfySA7
         w2W4sWxWHx0Mx9l8AdfRnUsKwbyWAmc7FJ870YiIK4kfECm/ex5PkVhuvhKj+JBjisTL
         lsZg==
X-Gm-Message-State: AOJu0Yy4ZZWr0FyTdBjyKcGVqMAI548JnIpGACHs504aMbEa5z7xeFSH
	zS8/q6K+oEDsLCe3Z1m7x72U7Y8uqWmPVaKYdSqg/2wkDQdSA59mFlrW
X-Gm-Gg: ATEYQzwq6bLMoab4WXmDczheK1MMe6ydtH5ht6gjPmO9j1NzqlDBUtOMtApnouoKRDa
	62oUjneoXUwuE3aGg9wLVL/axEllaf+DkmprgwLaBXxnw8usm0jSrDFmxhA8unVTZfJ5eMLcQtC
	vT7z6fJweHXp0bNRG7pyhmgL3bN9leHnR28KWgWaxMQUmdg4Q+P7Ek/TPYmDw3DervBhiLs+F3t
	XCaAj6/mzxKRxmvbGdTVbmoLZlI0eQUmZiduWG5RaVEt4DnlVlNYHHNupX9IgNiYw1ejcMH6xc1
	iQRbGR5/oilJKzhB5rGuJsR7V5iWZyV4p1qvJiz5CGjY6E1Wy9rv/PFa3G0v9YL0jKfK6F++INo
	XgELjlcyMNw1cNkIYbil2tEsVp66uzW9csgpOxlC0LXk0ZWjYrGQ8ib764mP34nbfH7m2BvnkZY
	+iD7IqBhTM7mbf6VnjvpztT/2nf3bU
X-Received: by 2002:a05:6a00:4511:b0:82a:110b:e212 with SMTP id d2e1a72fcca58-82c95706cc7mr10873894b3a.0.1774853636040;
        Sun, 29 Mar 2026 23:53:56 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466e01sm6287090b3a.20.2026.03.29.23.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:53:55 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	arnd@arndb.de,
	sjur.brandeland@stericsson.com,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Date: Mon, 30 Mar 2026 06:53:42 +0000
Message-ID: <20260330065342.145549-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329190350.19065-1-xiaoguai0992@gmail.com>
References: <20260329190350.19065-1-xiaoguai0992@gmail.com>
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-273081-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.dev,arndb.de,stericsson.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F620356255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfctrl_link_setup() copies the RFM volume name from a received control
packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
packet can omit the terminator and make the copy run past the 20-byte
stack buffer.

Stop copying once the buffer is full and mark the frame as failed by
setting CFCTRL_ERR_BIT so the link setup is rejected.

Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 v4:
 - remove the Reported-by.
 - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.
 - using %zu to adapt the compilation of 32-bit kernel.

 net/caif/cfctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..373ab1dc67a7 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		cp = (u8 *) linkparam.u.rfm.volume;
 		for (tmp = cfpkt_extr_head_u8(pkt);
 		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		     tmp = cfpkt_extr_head_u8(pkt)) {
+			if (cp >= (u8 *)linkparam.u.rfm.volume +
+			    sizeof(linkparam.u.rfm.volume) - 1) {
+				pr_warn("Request reject, volume name length exceeds %zu\n",
+					sizeof(linkparam.u.rfm.volume));
+				cmdrsp |= CFCTRL_ERR_BIT;
+				break;
+			}
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)
-- 
2.50.1


