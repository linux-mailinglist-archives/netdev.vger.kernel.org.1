Return-Path: <netdev+bounces-304531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jciAEPmzR2oTdwAAu9opvQ
	(envelope-from <netdev+bounces-304531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E82F702AC1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W01Sqmtj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304531-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304531-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E27E310F7A3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE63D3CEB;
	Fri,  3 Jul 2026 12:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33543D0BE1
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 12:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083328; cv=none; b=Jgk8rg61GoUjtm9NiCblrPDPeYdMakOuaX64c283tXqUXMihj7y8DIOr1dfg+bLJFisIYTKIM9axybW5S8jWvtYSS7Dm1UspPpFnOpZzrfexCS5JMmh654Ep8b0mrx57CprNZJyF+l5YnvK++ErkTkwg1u7IkVi4yGfGWOSkWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083328; c=relaxed/simple;
	bh=gbHF45bAfLovgDxu690VkVZ1Bt91kozMINPDxI7ZBnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdAzot1HAKY7k6/kKYg3GQ4N5PMK6GyMToW7BXNVKuU9VkAwXDvyLCqdvicYax5s/0gGFtT9nuhWQy1+hNLI+2c49+bt/sTCp/KXTzB/ZRAf6uPhqGtVag10sId+H7WST2R+RkipzD3IaIkd8wCAJiVGNSeo9KdFuTzSJ2NMxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W01Sqmtj; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so351873a12.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783083326; x=1783688126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rtkvg+7eDDRCJghynF4cAnUvilYztgxfeU42PhGZCQs=;
        b=W01SqmtjWJn8t3x0kLFGaRlZtGrx7sI7zy9DIIHDZlexa1CE5v+ig6pVmOeBVMZD6m
         G/Y52SKsBpLsu28eFtfhYAw/5P+0nNRc98M1L1DRlALvaH9aUjqY20l5CCs2vEaZwXan
         IieRx7ci/GuRC2WhlB39/7a15BQ0SsUo+13+G1v+Aq/nImXuKThyG0jPNgtQ87aS35kJ
         RtA0i1YrcRBHGLYaX5HkJKeHQyCtGIjLPHu3FGk4XWloWucWiVR8XIcQYUVPqaksUN+/
         jvS/7QC9VEJ/hf+7V1rfTMtaVZLOvgDC2qlGlOMsuiGA6EdNla4HKfrLAInP7sHSt8Dm
         QcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783083326; x=1783688126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtkvg+7eDDRCJghynF4cAnUvilYztgxfeU42PhGZCQs=;
        b=cWm4jlXUHQ686I9DX0VZjobCmlNh0obEtlVl8mM55Dp3mQ+Tvh1G2ZpwbWZUUSrWl5
         jy+HXPsmcX46pHBwBJAiGskNbqNM9Y076GGlVz+XU7wtdYcvOq81Jl1lNj5whilMqoXh
         rzz92jvXDdM1n7cJRLQUEBD2T14AMU1DzTJWpLnVJzmMW0cx2EUx516LfSLFtdl6o9gS
         u194PD2P4PHYN6j3EYGbJ9vBtDjVdgNE4+07+ETIM0HQ2xHsqfWPev7+xebQ5mTgc/24
         r1yBKHH0EIPvAVRl8MIzs2MsyE+eR4hfqp8EjA7nlGHe8iOm4hXkfX2vkC6fN3cqXQsp
         JGWQ==
X-Gm-Message-State: AOJu0YzpUdCHfHtkhLeSeEpgm4zhagIK7CezifyHp4bV5EYSJELnvjgn
	ECHcOpkAveRPGkeBveyFhfdq7JUQJMatEKC0H74QVXGdLFP2z1SX37fLywsJ7V4/
X-Gm-Gg: AfdE7cmB9JywPROBUSQgjImCqiMCKE9Ur3tCzzQ/QYp/Jcf/T1haNF7uoqeC1K5qULp
	hsIInJUvfAL9nABP89r4jGiuMfGdeJzFraAsguD/VoVHjrtq7oH1+BVKqTWpkSjkSigHXWhsmDE
	9+xca+U+qozRvBSS8GKNpiBF14dKD5KOa9xfGYvYd9p7WmtKHxmmP8k02DOn+FhLjgGRaI48v0i
	G9s+uY4ASTv7sLLudZHR0ImsTPHPQQ0CtS8gNM1QNgnk7tZ17n2OuxXvlcJxJeW1lHdJiiTYbbW
	Audg8oy+j1DcawkQ7lfthMJesMVs3C0msvnMEZIW7HQ/BLls1971VJYQNJ3JuCM3fF0W2gAL0bf
	SftKnOKY7e5kjDUdouDlewLjPmTd8Kw6KdkASLaDi9UJQZTfhwbTJSkGSsbWQzcl+xhCh286lXJ
	4nbvvV08lJL9iXQHyto1SvRoYWjss=
X-Received: by 2002:a05:6a21:748b:b0:3bf:d1f9:b1db with SMTP id adf61e73a8af0-3bfed5e1001mr12898834637.52.1783083326089;
        Fri, 03 Jul 2026 05:55:26 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm7260818eec.27.2026.07.03.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:55:25 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jv@jvosburgh.net,
	paritosh.potukuchi@amd.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net : bonding : Remove TODO comment about retrying setting the MAC
Date: Fri,  3 Jul 2026 12:55:12 +0000
Message-ID: <20260703125513.694324-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304531-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jv@jvosburgh.net,m:paritosh.potukuchi@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E82F702AC1

As correctly pointed out by Jay Vosburgh,

"This comment dates to sometime before git, when it was common for
network device drivers to lack the ability to change the MAC while the
interface is up.  To the best of my knowledge, that isn't a issue
today."

Based on the discussion in the RFC linked below, I am removing the
TODO.

Link to the RFC:
https://lore.kernel.org/netdev/2001256.1782860341@famine/T/#t

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/net/bonding/bond_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d2e4dae4e97c..d5c19dc4bc07 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4865,12 +4865,6 @@ static int bond_set_mac_address(struct net_device *bond_dev, void *addr)
 			  __func__, slave);
 		res = dev_set_mac_address(slave->dev, addr, NULL);
 		if (res) {
-			/* TODO: consider downing the slave
-			 * and retry ?
-			 * User should expect communications
-			 * breakage anyway until ARP finish
-			 * updating, so...
-			 */
 			slave_dbg(bond_dev, slave->dev, "%s: err %d\n",
 				  __func__, res);
 			goto unwind;
-- 
2.43.0


