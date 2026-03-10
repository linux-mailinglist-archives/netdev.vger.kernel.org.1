Return-Path: <netdev+bounces-266199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EKIJS1CsGlLhgIAu9opvQ
	(envelope-from <netdev+bounces-266199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:09:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380225455D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BF0830E9E56
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB6305047;
	Tue, 10 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ap7sNYiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29581302165
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154233; cv=none; b=nFnxpwh3RSwTy7HvTbATFUFe924rnRuAtN2oiMeElTm73NRcUgYYxMwMbPYzR/wEo0mo/QgMCJuR2LjZmsG2SNKXoqbRBrXvZAho83VxvHjk8cF1S1JXEYq1BkRClU8zI5RjC3Qr94ezFEjCgE9AN5Kmn/jWreKm0pv+Srn5fRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154233; c=relaxed/simple;
	bh=rQhY7+1bOmJ74YZGAz74eZLwgNNakdU85i/zbOlXZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+8BdYV+pwDRbmVDoLDn4zW/OwUagrbcHpeucf6jLbnHf4bwLMzvadSP0l5vapqFZk+H+8EWlrtKBj7k+jEAWtEvWchetogm5D8/SB9l28fX78wfWqbUBc5shyxL8EFcF11JtfeGyWl0G0jsfcc7WoQtG1+sh/okXiMBQ1xmybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ap7sNYiy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso6383507f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154230; x=1773759030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=Ap7sNYiyCyj9n1/SDLcn04cp88yhbZoVfIn88US3IZjRwYjKNxwrLnrrTgJEV0kkUi
         0UuJxKo/phlnr8wYhnaBNHEeOILlo98MiiRRAT6ST9CY7asS7s4RSWVW9exUXBqjNM/u
         RXr2iwUHIpVYGguEXP+x/iy1rBFD7WMs7q8eZi5usNHhSC1D4N71JfArV9POwn/AC5Sj
         C/v2MWSl50vIUj7Xf7EV001OBIUSb3tzvvtlWI6p1tNcZInubZA3Ldx5VT1fwfBlFZVq
         WFMXgIjKK/+QX1zDWuSl8+79YTJZ3xUHCHiMW2sYNxazUfKcxRlsXDkeHjOdkxEslGif
         x/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154230; x=1773759030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=oHxZQUSELbv9Y6S+kI3mfJSKsTXMt/nVcF7IjA39pI5I2ZuMKU0Wd1vCK4hhxoW7ws
         LBLHIBGmxg7sMxOKUs6IuRqNtZ+/GGDQPYKOzFFLXDrPjdXOIG2iaqe+Sl0AwCAolxO2
         0ixpdJs/osi5KlY87AUWqCOKHAvePowB1cDfX9T8i/K86wbOpSrvgINuWByT12uNs1yx
         eACG7XVXeu1XOHB90UnYbq1juictyFqv/zOUuxNrm13uDxapTKP8/WnF2AGm251N12H7
         wNVSs7wPMlYDhUquFzR3epXTqgHMbA0kcAbd0vyKsfpLBZo0CMM703zyeNWNpZWHoWZj
         OoDw==
X-Gm-Message-State: AOJu0Yx8rufdtrEJtqgpYDF12WJtnHD+e/++M7ruC06DV2GoXIxvkzJj
	mmvVIZRJECxj3xQY54YNaUbOhZnxmuqsOITaVC5g+B0JVXVMp1oUqbHvc6Fzm5UshnwUSdEIYrS
	1T9zcKHVKTHDX8CZxX8v6TsMTbzdI3kzLWnxD7gkZgfKqvGm+BDA5gazUPdAiJMcv
X-Gm-Gg: ATEYQzz/JhP+fOheLOWhsmQYZBEgaPaHWXebX3PqwC6LaFFkSer6iT/dU/faMvIQiiZ
	clJ1YzfxHyIitF7yLaOhjTEp7KBgAPsFc2/Dq2xPbzzNjA/Yav+SaiiL5q7NmKMpnny4nwHWedM
	rqYSpGWMwbAj/Tmr/zqZRGLyrRklMqCCdKDOuDrsnYnarqXWFCs7+milqIFNb5cXCiS7l5OVCT9
	7FNogHYs34SA59WpwzHA8kSApmajEThwSYMCxwc8/dkTDtCFzeXeALacdKt8fTX/x7lqrXeOKoz
	bjMGMQxjBmX7pv2Pn6+KXsiAQ7AJyIEJdoqW5Oyz+K923L5rDE+AOiu3+SvjLrsQO9gK76wJ3Ta
	T2VvKzCLn7vSHQkCXYwAk68t5uqR2A6HPGQPOJcbwa6IBiu3ez9bxafbi+4U2TKed/oHn4RRADG
	VATLzNXcIq3XyrEeCULsyWtslhxwTZ8ZSzUSvBhKs7LF664a0=
X-Received: by 2002:a05:6000:2207:b0:439:bc31:a05a with SMTP id ffacd0b85a97d-439da8954f0mr26061401f8f.43.1773154230092;
        Tue, 10 Mar 2026 07:50:30 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/9] ovpn: pktid: use bitops.h API
Date: Tue, 10 Mar 2026 15:50:00 +0100
Message-ID: <20260310145006.30858-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310145006.30858-1-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9380225455D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266199-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Qingfang Deng <dqfext@gmail.com>

Use bitops.h for replay window to simplify code.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
[antonio@openvpn.net: extended commit message]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/pktid.c | 11 ++++-------
 drivers/net/ovpn/pktid.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
index 2f29049897e3..f1c243b84463 100644
--- a/drivers/net/ovpn/pktid.c
+++ b/drivers/net/ovpn/pktid.c
@@ -65,7 +65,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 	if (likely(pkt_id == pr->id + 1)) {
 		/* well-formed ID sequence (incremented by 1) */
 		pr->base = REPLAY_INDEX(pr->base, -1);
-		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		__set_bit(pr->base, pr->history);
 		if (pr->extent < REPLAY_WINDOW_SIZE)
 			++pr->extent;
 		pr->id = pkt_id;
@@ -77,14 +77,14 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			unsigned int i;
 
 			pr->base = REPLAY_INDEX(pr->base, -delta);
-			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			__set_bit(pr->base, pr->history);
 			pr->extent += delta;
 			if (pr->extent > REPLAY_WINDOW_SIZE)
 				pr->extent = REPLAY_WINDOW_SIZE;
 			for (i = 1; i < delta; ++i) {
 				unsigned int newb = REPLAY_INDEX(pr->base, i);
 
-				pr->history[newb / 8] &= ~BIT(newb % 8);
+				__clear_bit(newb, pr->history);
 			}
 		} else {
 			pr->base = 0;
@@ -103,14 +103,11 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			if (pkt_id > pr->id_floor) {
 				const unsigned int ri = REPLAY_INDEX(pr->base,
 								     delta);
-				u8 *p = &pr->history[ri / 8];
-				const u8 mask = (1 << (ri % 8));
 
-				if (*p & mask) {
+				if (__test_and_set_bit(ri, pr->history)) {
 					ret = -EINVAL;
 					goto out;
 				}
-				*p |= mask;
 			} else {
 				ret = -EINVAL;
 				goto out;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 0262d026d15e..21845f353bc8 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -34,7 +34,7 @@ struct ovpn_pktid_xmit {
  */
 struct ovpn_pktid_recv {
 	/* "sliding window" bitmask of recent packet IDs received */
-	u8 history[REPLAY_WINDOW_BYTES];
+	DECLARE_BITMAP(history, REPLAY_WINDOW_SIZE);
 	/* bit position of deque base in history */
 	unsigned int base;
 	/* extent (in bits) of deque in history */
-- 
2.52.0


