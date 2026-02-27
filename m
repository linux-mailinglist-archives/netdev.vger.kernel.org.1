Return-Path: <netdev+bounces-262008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPGHFrwwomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F51BF4D7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD2D31751B8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222C234994;
	Sat, 28 Feb 2026 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AtbYN707"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03974276058
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236818; cv=none; b=naZ20u12KBkhOy6fKJ3nee6SeVihYCbST6km98fcsksQTaXwQicIuLhsFu1zinnSFFp2JjYPtzJFhMO1DGasvbNUKOodgqkfCnvia/+FbXB2nDo4ffq6/boUeRCP/tS/q2Tp67EheH+Tq8vdt6Kt6rx63vRCdB+KROeEc1F6Qc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236818; c=relaxed/simple;
	bh=rQhY7+1bOmJ74YZGAz74eZLwgNNakdU85i/zbOlXZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR5b7b7JzGzZkPRigtW/i5wvpvS1sDORNWzqpyR3uhMnRdZ/EwRF0JfHTD/CqGj4Q5m9rn9NpVgniFc9QezUjweR6Or016klis5ZlW9YWsWacafc1nutLU+NzvgWoBq+Klq+/7K1HKqqrj92s9/fvv46RZJMWsCubBJhFmxcMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AtbYN707; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so27884065e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236815; x=1772841615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=AtbYN707AbJGwiKYlZsXudZEC/dLaMhyhMXad0Z21B6aLyVgMvIf71jJIzwKctSGEL
         /AZNrEa3bFAPlGAt7UCAzo0UMvpOhIb+1YJ5fydZsx4Ems5CGOc3I72e18HRChlbW1a/
         +kFb3bktCUpyECALtCH0DpK1sPrPWGoAGK/La8KWDxaCmNx8bbTvoxItFGNiEwYlYsF5
         n8GYsHGyQ3yB51g6xfIl1t1GO+OvgNvM1YgJ9Of6hm15fmIgq0M2C9EmTKxjlhJb6z2P
         u6sY2wSKhKBQpmD3FZl4oWh+trmNLor1acT92WUS+nzB7UKqASkQGYsO05qvuDniC0G9
         MkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236815; x=1772841615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUYcr2U2mfCc96RP5P5Op7nrp+GUJw5w4uHDKKcUTYY=;
        b=dqgihLHsXxtqInqqWhL9NEtEcrXjRbqeeByW1XWels0ns7+7Z96JT3Xan+x7tUTva4
         Nzv+7vuTkqLDEOcJMpKBMC3Hyj7CigRfiMzObL14yoV81sxrkOoqY3vMbeY38AbYbwut
         LSbjtWN9S9K+Zav86Vsep+Jc7aUwnODQePR9dEjYxVfQuEOxujzFf88Rjr1Dp4qN+ws6
         lrzi2nbQ8R+toxSDd1hG3ZCK9vlGdVHavOvmlH1otdkwUmPcubFEsn+1I7Wb1tCosSTP
         UyPG+l/fJtXfA3dJOuundgwjDjLlztSAUmKctD7EoYWMFq21YJASMgkq4qjeiZv+cE5V
         iBAw==
X-Gm-Message-State: AOJu0YzEOQo9VLgvaKeP4cRnCAVxL7+gzri11eJwKD67Dt+tE1Im16XF
	fcXpFeTr99UCFmzRWNAPXtGqtIZeNCs+GixdIi00vypskDakuruioXdJe6TAjaNi9Uz5kbCjXY3
	xjeVqEgptQ09P3OUL5tblUHCtBmF+t3evpRAYJEue70+5SQK8FQDE1QBE4c/1yY23
X-Gm-Gg: ATEYQzzbIpJ1NsAqwT7aSmB0obMQX9lYWs9CK+8+kqdEaNjUm5ThFQ9aoaV+z9rgC79
	qhXQF2KpyB6gp4LQQcHj43arc/Yk1chOkotsbHN+sBVjmPKOq65qX5XLnG5A3zO1CxkZBGBw9eD
	M313Cjp/IdQeSJoXTehwteQdmvNH0SoRU8vcRj9PpxKb+6MsbZ+5wHSg3V+C6aIOSreikT+TmZK
	24t80O8DEt+2PRKEVdRUlkzNoYUtbcvggK99teHXaF4lGB97c9KsUEEQvo5tw3BRYTe3eW1fuuo
	SBE4of73cPfHS8mNZwitgua+qXQW6qNePNd7BWls1trAt1hfPUxY+9ewXFso8HVYPTirpli/Ypq
	6sd16aekqcDKsBshyCmz5Oz6b6rZIv75G/4zI+2KJOBLM3q0vDXgYJZsBXZ+IjaQKkk1V+5JTCc
	2YmFQGG3uL6KZIHQk7xeJOA/xFkXoU7vBxzbs7
X-Received: by 2002:a05:600c:6095:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-483c9bb1dfemr69472385e9.9.1772236815016;
        Fri, 27 Feb 2026 16:00:15 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:13 -0800 (PST)
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
Date: Sat, 28 Feb 2026 00:59:49 +0100
Message-ID: <20260227235955.660-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262008-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD9F51BF4D7
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


