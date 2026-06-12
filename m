Return-Path: <netdev+bounces-298450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8IchCHSDK2qD+wMAu9opvQ
	(envelope-from <netdev+bounces-298450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:56:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7266767ED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:56:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="fPdvX/c1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298450-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298450-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8FD310D810
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA07396560;
	Fri, 12 Jun 2026 03:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98102395AC2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:56:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236583; cv=none; b=VK/1G3BMZzPVXZ3oyuGXdDVM41tq+3K5yfvqex6/Um5NgBFMJvygXoj2rdroidCImoIv17V6v7x87PDzWG4JMdYlROLKJeyI8s/Q0rqIBwXlTBUpBc/ijpycRLXTzODrsSkZo+K2x3Fy8jxBbZvfpUID1q9t21rwmYjA03K1NXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236583; c=relaxed/simple;
	bh=3GyzoHo0WB29BSZEgQI1eyoC+VySgrtW2IWzibz0i2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVNCfmLFUzvO3VhOli9iuYoXzHHj635mHthkP0qu0faVtwxALgKlNzqqR5fQwAT0yzjHSytkBPr+BJKyZW40jP0HnafW5upS49EPnjdxbcDECYjE0pKRLRmruEnY4juFkZL7fQGevDn4IF1cA4kZWtEEddHJvwfBPjZ6E/BldPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPdvX/c1; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36da151a152so446232a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781236581; x=1781841381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhbUrUHCyQ15/MAgNisjiBa2liW2TF1wT+ZMH8opQMU=;
        b=fPdvX/c1dbfuoiJracxdHU7GBRef0H/iAJGdLVjVYvNN7qTsEVh9PlsUCt3FkTle49
         DEb3isx/ZO/AgCR6eA/VZ6ME4x9zpJuXQHGuZBJbfczFnNUi2/tpYfIes5qxUk8GXwwy
         GkNBa0IA5AtGcWFw63CDMIbVuWfHUZbcRv2ZP3DQrOu++VObtFND5N+aP3xehahrrouB
         OUuxSd08DWL/mCYBI72nO8O8UOncu+XNyVo/dtR+ugWIkywaYu4gpTXtdSVbrLqFwd6A
         DDkjWdY5p5mcKr0jIrUBlwA3RAw/75hEnaTspZoY/qMJJNQrcL8Az5/TL0R9CoTY+bkU
         tfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236581; x=1781841381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhbUrUHCyQ15/MAgNisjiBa2liW2TF1wT+ZMH8opQMU=;
        b=hYOUnfRg2n0MwMV652S3lyLgmJCg3+bScS0iimiLS1frgHox5Chz3wDiPfoMOgPuXp
         a4O3Rzgl7FRnDkwmL3BpfRmHbsto7Fu4dxEYL5+wz1+oaUgow+fRT4ZwWgqm6DM22MPZ
         GhyCFTcG8EKOSmsywxIZt6mgV4c6HZnImTYcZgFY50F62ZLCX6y9SN9yHc69WNlsTBTg
         lVK84EKx7nc03xFPAWQ9kfpwtVmNWEYHaxc8B/cTkS1zz3w17uTzdR+KuBHxYM6+eoMS
         ecPePAtA9XFySLQ68uXCUatL301r219Q08Z84BPMQko8aDr4gU3XfCxPvaLGBeWZCJ38
         PTcA==
X-Forwarded-Encrypted: i=1; AFNElJ9jaYBVxTiByEGDiD2w1tLPIu0le4/vKgdRpnPnHffdK61daUrkCmTJZrBFRyiVvCBEm2BBLQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhoHqkwoR9zFjrO9BMkyCVvU66useMOlTH3H41fmTgACMXKYB
	E+Me0mIu5BpTeQ2YpszivJ24B5dDcTRGVp4CEcOQEOODz0aIRaisLINl
X-Gm-Gg: Acq92OEUbyDItXzIlgpsj/lUGQ3ofzd6jmVyvEL3iHSY/OhQlOk1dp4ascVJufCqP8r
	1/UJcJ8Hjjj6TGKCpt60mNmbOqY92Sbalty6q2MJv0D9sV9UychWYIkZ2JIhnyGoftHE9Ayk5W4
	AZqEI2SpqzVBn0GJ3UId+4//J0BesPAwESFehwIeOD/nTVIKb/UDMaI7jZK6UdOwT0aHHpRvU/a
	HB6OHGiQ9ICYYsYqlH9waiRIrUZigaq18lRhedt1jKM0UCbkrWujS0mZtlfzpaS6E8NcI7OQY7Q
	qBpMRbxeHfsbr3Xr+P7/qt1EuCaFYYivTXOJaEpJrZ7Fz1Z+xovHL3118Z7qdyTotDKZyNomvT2
	5yKbYj4wsDvTxKpwk8mnvmdCDNXtaLT7i+bMmQcVM/hvkFLEkwPWHGGtLN4chE2XNxBoAtNLp9d
	fcKsTG8VSw4mK3FsKppVtqGFlFfOxcnC756T8uzsIo8kA=
X-Received: by 2002:a17:90b:5292:b0:373:c536:6fc2 with SMTP id 98e67ed59e1d1-37a0458db03mr1357644a91.22.1781236580831;
        Thu, 11 Jun 2026 20:56:20 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:ce1c:cb5d:c08f:25a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8ea7sm510697a91.1.2026.06.11.20.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:56:20 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net v3] net: wwan: t7xx: check skb_clone in control TX
Date: Fri, 12 Jun 2026 11:56:13 +0800
Message-ID: <20260612035613.1192486-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298450-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B7266767ED

t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
port transmit path. The clone is used immediately to set cloned->len, so
an skb_clone() failure results in a NULL pointer dereference.

Check the clone before using it. If previous fragments were already
queued, preserve the driver's existing partial-write behavior by
returning the number of bytes submitted so far.

Fixes: 36bd28c1cb0d ("wwan: core: Support slicing in port TX flow of WWAN subsystem")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v3:
- Preserve the partial-write return value when skb_clone() fails after
  earlier fragments were submitted.

Changes in v2:
- Add Fixes tag.
- Return -ENOMEM consistently on skb_clone() failure.

 drivers/net/wwan/t7xx/t7xx_port_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 7fc569565..d2529df75 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
+		if (!cloned)
+			return cnt ? cnt : -ENOMEM;
 		cloned->len = skb_headlen(cur);
 		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
-- 
2.51.0


