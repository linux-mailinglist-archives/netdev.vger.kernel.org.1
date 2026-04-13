Return-Path: <netdev+bounces-277994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMJuDxmu3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:49:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B64143E955C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79F573025C52
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63843AE185;
	Mon, 13 Apr 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6T0bZ+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29A3ACA7B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070045; cv=none; b=QHuXn7bO/96XfBfDKUWhqQPJLYGuPhIv5jIPth5w9ltCamYRwTL/R4GTxEIvW2tER7OVQ0f5NEtPH6hjwFwzfLwH7Zv7731uzMZJo57CZa/EG/GTj1l65SMJTNFfrCO7ATxl4hm/clcifXRwOoUkP4HgdcAnRcx8BN4B+0N3tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070045; c=relaxed/simple;
	bh=wSFwkJZA0Rzl0Iycu8YsQPqiXqy9kZ8b9qwRfkeUFBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F0Pp3CpvAUzKAN2zaFiwxKPK+Fhx1WSc8zsXVjSlICCBUgbFHZ3ap0QGdtUku/sIDWnx7DRDfa2RMtz5HXfybe9pgB52PvSnwLuIQL/fgH5jAQjNRDrQG+Ov3QFyNemzZoDeXiNv+9qH8mxJsBn1aimE5WXwaTzegsBDDotbDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6T0bZ+i; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f22ec4501so604471b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070043; x=1776674843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAb+1TXc3i//ZlLL6IbWXfhVaRvoHTM3KeCH0Z0oPm8=;
        b=N6T0bZ+iqk+vrwecD1zlB2LnEHtoWFIpAfIc3Sms/v71QqzMB3Q/OcaGT+PP6IMnaI
         dtcrYxNZOPWzqJCx7Bpbjkk1Hdujh++QXcYLhWU1Ixjo4Xv++Qj2rqsO5tNpRzayADsr
         /r5uaKl3Wpn0tjMSIBDWYE6Oli4px5vAvf/Lu9hDzBNQJ03ytbLB289+esoUH9dIDCxS
         tgvcpy/EfFtLPv0qXEGCq9eke6vcLA2AG43vMXxkm36tQxcb4H4c5AggAxstvql2EKzU
         l191pe4I9UC3exzKogl2Q0l/IIIcdYuq22JtEfNr7N2D1um3azU/LgLraHV/gFt5Aaao
         XziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070043; x=1776674843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAb+1TXc3i//ZlLL6IbWXfhVaRvoHTM3KeCH0Z0oPm8=;
        b=hk7i3u5C2iefKn9QPtMIMy5azk4oiPeKMSgR2g9kkiJBbFGWAoR20x2ttHV1j/mVdd
         qyEvDCgahnIN89f4fFZSxIEY6KQYUbuK27lp9iTEjEI9Zi0JEeWtRLNwycApEXZrlPXi
         /5iOWayHFbNTsb0EnRsFVbtSFZSj3DLp9mhbmijuumXmhdFMCwsZ6D3664QhL3DUPO48
         OzOHdzPEd1YrtTWhH8FzPsjKa+IpJrIsJClT55oIxZ5L850W50dYskZQTFpvFS3RlvvE
         ZXsGNUutJCrm1llHTcZ4055cNWkyr5GUofjcFkuYMyrygIx6WmeEn2H6Bur2632fCGFm
         sLQw==
X-Gm-Message-State: AOJu0Yx8NlPb9XPf0Gol8RZM7E0HGztuTqHOHp7R08TC5BY8fdWGeEVP
	qNFYaGRjjBwmpB/gWfZt+0keu7zcQxiuT4HE0jlW5/Pm6ziKHZzM+bV0mjL+SA==
X-Gm-Gg: AeBDiesIclb30Uhz64c85T7JPASDvf0WKXX5Po3RpyeoN8Ls2nwtSjayTX0WPXirZST
	A7aV3xqKxrVNXfQjkIdCDcJw6uFeqpkjNSB+4L04PHhwp7c8yIMXrzPhnO50+d98Hz/gIANtCfY
	bh/KdgMZLFuNEwOBGny2IIt0PQEGXpLvztl4HOTG5U9zR4QWDgwz2fQmeVahF6wL4tkQyFT6S/1
	B+caddxw9daY90DCGo8GyVmxUGu1XQfnqzjLal24sMbSzByUfdbBLfs+AmVYjuN82rLo/GIZ1vO
	iDjnbwlMUO+1GwGupbXF6TkVR6OTVryQH06P6AD8NA3ZptOmVMDR6HSgskxkigsEzAempU1BNlE
	DIKA639ulCiWh2C8089Vi09lDs48FxELmWrJAwvC57Ow58pdMz5nYlOHohJs8wI/A7GcZHJ12Dt
	c5zpYZMZxOfvyvI5Ybw7w83svJjyOEB4PDzpBWO3wORc7+XTk2vTtl+9PDwB6sMYMz
X-Received: by 2002:a05:6a00:9a3:b0:824:ca0d:bd14 with SMTP id d2e1a72fcca58-82f0c0f1889mr11703736b3a.0.1776070041863;
        Mon, 13 Apr 2026 01:47:21 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50d24bsm13265556b3a.57.2026.04.13.01.47.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:47:21 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: toke@toke.dk,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys
Date: Mon, 13 Apr 2026 16:47:15 +0800
Message-Id: <20260413084715.70169-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277994-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[toke.dk,mojatatu.com,resnulli.us,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B64143E955C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_update_flowkeys() is supposed to update the flow dissector keys
with the NAT-translated addresses and ports from conntrack, so that
CAKE's per-flow fairness correctly identifies post-NAT flows as
belonging to the same connection.

For the source port, this works correctly:
    keys->ports.src = port;  /* writes conntrack port into keys */

But for the destination port, the assignment is reversed:
    port = keys->ports.dst;  /* reads FROM keys into local var — no-op */

This means the NAT destination port is never updated in the flow keys.
As a result, when multiple connections are NATed to the same destination
(same IP + same port), CAKE treats them as separate flows because the
original (pre-NAT) destination ports differ. This completely defeats
CAKE's NAT-aware flow isolation when using the "nat" mode.

The vulnerability was introduced in commit b0c19ed6088a ("sch_cake: Take advantage
of skb->hash where appropriate") which refactored the original direct
assignment into a compare-and-conditionally-update pattern, but wrote
the destination port update backwards.

Fix by reversing the assignment direction to match the source port
pattern.

Fixes: b0c19ed6088a ("sch_cake: Take advantage of skb->hash where appropriate")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/sched/sch_cake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9efe23f8371b..4ac6c36ca6e4 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -619,7 +619,7 @@ static bool cake_update_flowkeys(struct flow_keys *keys,
 		}
 		port = rev ? tuple.src.u.all : tuple.dst.u.all;
 		if (port != keys->ports.dst) {
-			port = keys->ports.dst;
+			keys->ports.dst = port;
 			upd = true;
 		}
 	}
-- 
2.39.3 (Apple Git-145)


