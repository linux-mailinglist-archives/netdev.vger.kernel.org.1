Return-Path: <netdev+bounces-288386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BiSMJVWB2pVzQIAu9opvQ
	(envelope-from <netdev+bounces-288386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8177554F00
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F29493008CBB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF44DB54B;
	Fri, 15 May 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quaNqs2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA5380FE8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864936; cv=none; b=FUdphNwRmJ9K5+n98uUSSPJ+s84GCmXIBw/bg7Bd+CYtBoTu3rYxN1Pw6fCK6nhZy0rYbGdzNde2nB+uR2xs2LglCcSaWi98wLJDFqvGc1P5GXdXIiL/WGUtvs8ddF208CHjNGPuNge5JKcDn7brfzBAWex+OTui86vkQxubsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864936; c=relaxed/simple;
	bh=eTAu6ZzvjxS+1EPKMnCFyFy8OhsqgGgyJVexQkk0yMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LeoKmUDKftkKsekihN0/QQ9YBPn/Zbp+C8TwIKq0SxR4u6hwWLNKAmOPBDama3wgFzgFQENE+D49GiUJgXzfFK7YrPz6M4MNlj7I6Axa2bsqaa8N8/YC951Q6GBSK+Scz6nm4C8L80Pe9Hh4/8h9WQ5pyGLaTnodvqsx0d5fzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quaNqs2y; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c7a459105so2722016d50.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778864934; x=1779469734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5Dodp1SgGEX8BPNfOmTYAJETBWomYkmsJ9yO/jTFgc=;
        b=quaNqs2ytRrBYam1t5KpyZrzoOiDF8TnPI3wv5Og0A/wvDXj+Ok4iJswmVPkFqSOsS
         i8SY2fWxaZN1CEp4wSzA6e0ZbgKiF+HZS3AqRvc+DAEWTh8p12SLVWfzhzEndcfOwoX2
         HeICh4siaGijAOGS31nQtCtw02fC66+qbGgH/vVFo9KciF8M9S1aZyX65u2JhcF4v2vp
         tGX9rZnh+evawSe3w/xvxAiMg/BbJRoTraKfWVM2axkuCx8/1QWO8ozGfTsfuB+XB7Sh
         wAgUr3cJd8JgLxeY4l2s9WOZI7qFleFYS4PoS9zGoUwbhgs+5Be48o8Wrw666AWbgL0h
         Bq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778864934; x=1779469734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Dodp1SgGEX8BPNfOmTYAJETBWomYkmsJ9yO/jTFgc=;
        b=BPAjwlhER2oY3zvVNCYNAyZTixP/ZkCx1foVmK+uFjYPveqaexXY1sZyLuz3TdbpN7
         xWJLqKuUQ1SqBlS41vFp7sGwOvjtjG6glUsnU6UsFjqazG8ZwaQ776eAic/ZTRVsI60f
         7HNz+dONx9p3kkeERNqQ1eb3ZmDzizunybInO5s/Bjcta6E7Lf0s1PCFKwJBJ6BXdSsH
         PwcUeD/TTSVbyHS1T8gje9wV40w5biwvAq+xkXMrdcIyL/dpPSmcVBTN1yvhWG6JYVvd
         wG9/LtrqVGwpBH10HTfMM+dpLyoVA3HMAz9yO4LNsDzfqJNhfKQgOMv0Y+BpihjbEuG/
         eY7g==
X-Gm-Message-State: AOJu0Yy+LHtdK6761MIQQqtCnKk8ZETQnoOb0ab0VegtJM4OL5tJe1q+
	oernRwunhMN9UPuEkna8RsfIy/dXS8JTYQz+TYsBN7H9p6SZNwhWz6GO
X-Gm-Gg: Acq92OE2urhUVo8hyDKSXrJkOb33p3YihGk4aysJ4jgRCcV29UjS73E89K8VuVrZ0ab
	Fhwj9RRt9UsqkDntIvog3H7hBr6uVUYg8snjVaFWTCoCqsf2GUqWyvzkE1GlxN3liyEL4mmQuqm
	p3QkEv6NZOXfyeZ0C1/VVOh5Y5MSAbjA3Gxs4dmaYjvGbB4glIbQqvUjSBMO1VLUH1GxLgXftTL
	ZY5w53hpvg8wMstzCoVSOA8yseYPJcQYZYnVu4Fc5iVCg8rDx0Tk1lqc572EokawGNwUKZjA8v1
	OD/v3vzQjvv97Z6zdSolF0jGZEtbYKw8zTsmR0BOw63mkUYPqXephsZvOKwiQ+jhSszcIkA/ba6
	j/mzDqQH+x3uwY8znh9Jxen7E0bPOaeGsYkGIakXod4TyH+kJCG+uoVB8UonprZe0OkXb5TCO9l
	Wxna0bqQT6bXgwXWoX73o=
X-Received: by 2002:a05:690e:c4c:b0:650:327f:4ff0 with SMTP id 956f58d0204a3-65e0b04afc2mr7539634d50.12.1778864933773;
        Fri, 15 May 2026 10:08:53 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b134sm2804059d50.13.2026.05.15.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:08:53 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 15 May 2026 10:08:52 -0700
Subject: [PATCH] netdevsim: psp: reset spi on key rotation and check for
 exhaustion on alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-spi-handle-v1-1-debf8cb467cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIACNTB2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3eKCTF2gREpOqq5FUqplapKFiZGZmbkSUENBUWpaZgXYsOjY2lo
 AXSI4OFwAAAA=
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: C8177554F00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The PSP spec states that the lower 31b of the SPI need to be
non-zero. Though not in the spec, I think it is reasonable to reset
the lower 31b of the spi space after a key rotation, and to also
decline to generate session keys when the lower 31b saturate.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
This commit was originally part of the series:
https://lore.kernel.org/netdev/20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com/

But it stands alone, so I am submitting individually first.
---
 drivers/net/netdevsim/psp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6936ecb8173e..c6000ebc6bc8 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -132,14 +132,15 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
 		  struct netlink_ext_ack *extack)
 {
 	struct netdevsim *ns = psd->drv_priv;
-	unsigned int new;
 	int i;
 
-	new = ++ns->psp.spi & PSP_SPI_KEY_ID;
-	if (psd->generation & 1)
-		new |= PSP_SPI_KEY_PHASE;
+	/* Check if incrementing the spi would change the phase bit */
+	if ((ns->psp.spi & PSP_SPI_KEY_ID) == PSP_SPI_KEY_ID) {
+		NL_SET_ERR_MSG(extack, "SPI space exhausted");
+		return -ENOSPC;
+	}
 
-	assoc->spi = cpu_to_be32(new);
+	assoc->spi = cpu_to_be32(++ns->psp.spi);
 	assoc->key[0] = psd->generation;
 	for (i = 1; i < PSP_MAX_KEY; i++)
 		assoc->key[i] = ns->psp.spi + i;
@@ -162,6 +163,16 @@ static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
 
 static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
 {
+	struct netdevsim *ns = psd->drv_priv;
+
+	/* Flip key phase and reset SPI to 0 within that space
+	 * (will be pre-incremented, as 0 is an invalid SPI).
+	 */
+	if (ns->psp.spi & PSP_SPI_KEY_PHASE)
+		ns->psp.spi = 0;
+	else
+		ns->psp.spi = PSP_SPI_KEY_PHASE;
+
 	return 0;
 }
 

---
base-commit: 822d4a8e390a08ccfaf2abb347ae670b230b196f
change-id: 20260515-spi-handle-8be9eb842667

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


