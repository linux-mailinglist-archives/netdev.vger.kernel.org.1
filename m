Return-Path: <netdev+bounces-266169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CiaJY0zsGl2hAIAu9opvQ
	(envelope-from <netdev+bounces-266169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF7252DC9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A30713299AAF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925C391E46;
	Tue, 10 Mar 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+7j/zvj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6338D6B9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151326; cv=none; b=gp9WpmNZt/AELlzaIlJzA1gWiBrgG7Eat3EAe79MObjpyCtXUNUljFkObGZVV0G7M/OXBBLtp4FXwODwufp/i8A9xjEzRhOjKrpTgd+9cqd51fMT/FFYwfELrwmxCZcwoEHQO4EtdaR1HhX1LwMrsIdbDO4QHCaqSuQJivsMNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151326; c=relaxed/simple;
	bh=0hNNZYnPE67nF1mHX8U8sOx0nA6XVig9tZv/Hddtnw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t8/jj23HECPpUeN7pM1LqTHT7uIYL3rMWMrwvKKOi8WmNle+Osne4mKLLY+112NnTXrym90QjLQ3uSMZVBptzu/zGSvYdVQArzneOgVHKU5GRsh6wFQTr3EJttg4s/5HaFu9sOjynv/3ve48ZI8RSV3OzroG8GAjyiLV3fsl7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+7j/zvj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439f5abc829so364160f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151323; x=1773756123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohidppn0DDN3kquQ+UkqZeq+6ADdLoEMttZZlZ8FD5Y=;
        b=M+7j/zvjumKtUZpS4BLAjINjDMiUwYIwXyCKQbfIp14hPu8vuZF/zJkzxJzAerjkO8
         p47igbUa4QBAx2R15MmOwyzgtZg0r4CM7C75aVcdHcsoVWQPaDWby3yaxJCe2NY60HsR
         RcXAF49WPFdKGT9nHVR0HWlZiFeJaVgRiKxWmcMcPC4y4jCivbRvA3+z1pgStPMtYZqu
         agCvHmtodV2ui+9J5vUDoAQwK9lp/t4Vg/wJyQsSs4tfLtYgbZt8ceJpv023lVGVSD/E
         1tGOk5N+PxcmHKn3kCI4syOMGWby8kInpuIEFdSBid+GdsO9mhnu0Oy2FeYmYuAAajKG
         4aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151323; x=1773756123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohidppn0DDN3kquQ+UkqZeq+6ADdLoEMttZZlZ8FD5Y=;
        b=dFeibSkRN8oPcy2hvI0WirvUbIOixnVddLvGhLdkOk89EfNdco9wxJzwAmoJZ12iO7
         +fdt0ZwWQuexPmqf30NyMOr7UyNwPeNhDA864+PxkqTLCY5lGM982YeLuNPAsZxoj8Ie
         E/MNsX+7ylBR2Fze7SMzKv1coAlsCL8WfXD4MThnDV7oTsR6yidMd3BMphwNAFcfqsPp
         0+CEsJzohkKR44wfTeuDJp2j/1C6YRQxQ8zAgiabiXESk1OBIw3PabFGEORBvtlhGp60
         psVbUgIAx0RfKLf20AUPFoN1USSNDWaI5wu4PfdrJCgavkKe1bFc2PWMe7FcZqGjzMIF
         h7+A==
X-Forwarded-Encrypted: i=1; AJvYcCWNQ8A41TaaZ2sUuPQjZ0451gw26lMdnjgn4S3an196lgSu4+kHitov2Kdcef//5RMBzIept7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlhCcXlFS+8G71M9Mv0ZeaT6B+0Fm3h+8qVDuxQ2tn7fnEf2D
	xxK1tk+zY6f0BV8/ikVnxLjU0TZsCYY6c1or0O4AhBH3oVxBz2oZOfJK
X-Gm-Gg: ATEYQzwSAfO8nW55dtwV2NxyDDVK8kM98FJ+Cy3f20ZI9FZD/2AzkEmGDFnrJ8+nTso
	vyc8MlNG16qI4sySxYqvQaWXIOwPFpG4Qgg2ajIqCYPp0qY0Hciff5unyE5/EQiqLrQeAdii1MP
	CKsh+xblb8Uw7AccBmtGA+du0VJty8jeju4ZwUcnXz/JWct14twALrO+oo213lx5c5SkJATsrV4
	o4guDAfuvsaI3lyIbbblvMzkbwFY4Q4lECy+mSxfM4WRdoaT87YrYrU6QW7ECbV7ocudZbncbzB
	c1HPVf9ge/wWuFFTKe739tYI56rxtnw3IM82Zwh46NSgxPwM1dghHMXzzpJ2XsNP+nDaBy8iAWf
	sEcNo3R/qmacE5JPnuvgnPIAETLCK400IqI1UUwAd3UaWbxN+JZM6DvuMu8OWSGRCxxfuR8VKBv
	7qs/0ODq+e+dCgCmhypgtQBc2TkuxlgpDof15uPW9NN8T8KTLJcDYZBn9t1NW0UkUPiUx+ymyLb
	HYicovk9TiB
X-Received: by 2002:a05:6000:144c:b0:439:b7c9:2ef0 with SMTP id ffacd0b85a97d-439da88cebcmr24963018f8f.33.1773151323051;
        Tue, 10 Mar 2026 07:02:03 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3f267sm34409645f8f.31.2026.03.10.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:02:02 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Johannes Zink <j.zink@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH resend net-next 1/1] net: stmmac: actually error requests to change the auxiliary snapshot capture channel
Date: Tue, 10 Mar 2026 14:01:55 +0000
Message-Id: <20260310140155.3359-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 22FF7252DC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266169-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,foss.st.com,bootlin.com,lunn.ch,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

Commit 2ddd05d1d5ed ("net: stmmac: do not silently change auxiliary snapshot capture channel")
added code that attempted to return -EBUSY to a PTP_CLK_REQ_EXTTS
request whan a snapshot was already enabled.
However it tested bits in 'acr_value' after they had been masked off
so the check would never return an error.

Change the code so that the test actually works.
Note that when the commit message says:
    Previously in case of a PTP_CLK_REQ_EXTTS request, previously active
    auxiliary snapshot capture channels were silently dropped and the new
    channel was activated.
this only refers to two commits earlier (a few minutes earlier).
Prior to that only a single fixed snapshot channel could be enabled.

Note that the check will reject requests to re-enable the currently
enabled channel.
Plausibly the best fix is just to delete the check completely.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Resend with corrected subject and To: Richard Cochran.

Found by a test for FIELD_GET() returning 'constant zero' from a
non-constant 'reg' value.

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3e30172fa129..aa17335a2031 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -222,19 +222,16 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
 	}
-	case PTP_CLK_REQ_EXTTS: {
-		u8 channel;
-
+	case PTP_CLK_REQ_EXTTS:
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
-		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
-		acr_value &= ~PTP_ACR_MASK;
 
 		if (on) {
-			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
+			u32 enabled_snapshots = FIELD_GET(PTP_ACR_MASK, acr_value);
+			if (enabled_snapshots) {
 				netdev_err(priv->dev,
 					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
-					rq->extts.index, channel);
+					rq->extts.index, ilog2(enabled_snapshots));
 				mutex_unlock(&priv->aux_ts_lock);
 				return -EBUSY;
 			}
@@ -245,6 +242,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
 		} else {
+			acr_value &= ~PTP_ACR_MASK;
 			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
@@ -256,7 +254,6 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
 		break;
-	}
 
 	default:
 		break;
-- 
2.39.5


