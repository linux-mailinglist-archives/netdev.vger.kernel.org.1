Return-Path: <netdev+bounces-300409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6pRkEgDRM2oSGwYAu9opvQ
	(envelope-from <netdev+bounces-300409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:05:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FF69F9BE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=itb.spb.ru header.s=mail header.b=rgXvSc11;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21063302713A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766B3CF68E;
	Thu, 18 Jun 2026 11:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA503BF67A;
	Thu, 18 Jun 2026 11:05:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780733; cv=none; b=JZXTfSkeivipnbRx4KyUclXuVgjvT2q6u2H2eL4QUBsociAQpn3j3V0bXHHByKH0KIC8Hul2cvyOPIw35RF8qO3tAlblDg5bIe2mOppqxp37wHrJ7ABINV9ZimSCK+DTxUspfC5qzwldC4+iubP+wBvkPNwGaAn5FKQ8wVUZgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780733; c=relaxed/simple;
	bh=H8JD5zNdmd84eqHzEi1DiefDo1WiqC4iQAWvQ+vPKJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbqNeXS8oqSg9SfQkZZhXv2Jz+o+2ivJ/1NdCVF11QjKIGCYa95w1AUqUg2+m60gGy7RQ3qp4EIs6Rq1x2FWBux2IgVP+Ep4kKPzWYbGO0HT7qxomlqa2H6coRsEm8bpbeSJQHEJSm/29LxPukWGm5Jt8CbCaZe+FomaJLN5R44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=rgXvSc11; arc=none smtp.client-ip=178.154.239.212
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id B18F9C02CF;
	Thu, 18 Jun 2026 14:05:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp) with ESMTPSA id 85QNOG9fF8c0-ooFiwW5Y;
	Thu, 18 Jun 2026 14:05:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1781780718; bh=wgXRGqhuO3EuIE1Nr5y7lZfh/kqVf7GwpJ+OBDbS330=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=rgXvSc11O3YjFOCE0LuGpjM76edLtYlZeglRgzg5B2QpRYtd+m/cJLifhoclWqzr7
	 +RtxFdMDceU6Nk4OAsNWx74FvnP6HRqgoJ+deoC3xr16lIO7nBDRzVGzUzuhAvjvOK
	 K42F3Ilo2aVsRpk/QDVtabVgk5p8C2YtC6INt45E=
From: Aleksandrova Alyona <aga@itb.spb.ru>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net v2] net: dsa: sja1105: round up PTP perout pin duration
Date: Thu, 18 Jun 2026 14:05:08 +0300
Message-Id: <20260618110508.53094-1-aga@itb.spb.ru>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[itb.spb.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300409-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew@lunn.ch,m:f.fainelli@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:lvc-project@linuxtesting.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[itb.spb.ru];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linuxtesting.org];
	FORGED_SENDER(0.00)[aga@itb.spb.ru,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aga@itb.spb.ru,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[itb.spb.ru:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,itb.spb.ru:dkim,itb.spb.ru:email,itb.spb.ru:mid,itb.spb.ru:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501FF69F9BE

pin_duration is converted from the user-provided period to SJA1105
clock ticks and is later passed as the cycle_time argument to
future_base_time().

Very small period values may become zero after the conversion,
which can lead to a division by zero in future_base_time().

Round zero pin_duration up to 1 tick so that the smallest unsupported
periods use the minimum non-zero hardware duration instead of passing
zero to future_base_time().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 747e5eb31d59 ("net: dsa: sja1105: configure the PTP_CLK pin as EXT_TS or PER_OUT")
Signed-off-by: Aleksandrova Alyona <aga@itb.spb.ru>
---
v2:
- Round up zero pin_duration to 1 instead of rejecting it, as suggested
  by Andrew Lunn.

 drivers/net/dsa/sja1105/sja1105_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index a7d41e781398..afb11690c217 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -755,7 +755,7 @@ static int sja1105_per_out_enable(struct sja1105_private *priv,
 		 * 2 edges on PTP_CLK. So check for truncation which happens
 		 * at periods larger than around 68.7 seconds.
 		 */
-		pin_duration = ns_to_sja1105_ticks(pin_duration / 2);
+		pin_duration = max_t(u64, ns_to_sja1105_ticks(pin_duration / 2), 1);
 		if (pin_duration > U32_MAX) {
 			rc = -ERANGE;
 			goto out;
-- 
2.26.2


