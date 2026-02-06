Return-Path: <netdev+bounces-257484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLceILiVhWk7DwQAu9opvQ
	(envelope-from <netdev+bounces-257484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:18:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6336FAE56
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8E473001F80
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256E2EBB90;
	Fri,  6 Feb 2026 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqsTypsa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663E266B72
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362291; cv=none; b=i7oB0doPe8Qn6jli7qH6MxZb3fog7XfeustahxQ8Qg00bfhag4PQd4UG7Gt/SBe1bwyDHZ7HZgLAllvCCU57kNQ8IULFxO+quYAPEbeu3bKkU9ob5MdCc2oVE4jsVg4oUYZoYBPYD2LvNUBdl5WRyoNKOUpqOCOLWUnmaQAGGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362291; c=relaxed/simple;
	bh=D1NGpPueV5ikgZjAQhEwikv1d6XuL86z97qEh4blo9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7huZRpoLna1EJyfcJMCEYCXdlAX8fJW7nZDDmdC9rEiPYywSRlsh18YeNBvrTCw7KlJIXabmyB0QpwEUs95R2qA/psiesfkk3Bd0tjXDQv/mMgH4zXaTawtaB8K2T4X7Bup6HK5ApYvC1xUxFJPpVRUl2YO0Mfn7wGAMmOFKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqsTypsa; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so2356556eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 23:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770362291; x=1770967091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAcAS6itCCUdJZBNZ7FOwqjOX6f/eCKZuoH9k6MbHEI=;
        b=VqsTypsaSw7d9Dh7VjDOiV1Vp2x4rKUIon5aoaf4Ow3FZ+aaXEHe+mjynhxLFUnDMU
         9y+Dr6sMGrcZQ91NNOIDJIDonLQDSDx17UyOkwNawVwLaLUjAQJ9djre0U2297YqaKCu
         ZYcqXPOEH4ZF2WjZgS4ZMR9924qhDB4uofSqHd4Cma5FHxvPkzQ6oK0eScpxfdR5PCd4
         PEeWyOk+NH1xTaf/MjA2QU6bA8HHp8dmfZ2Kwo96EQ+LhGtIEBsV7h3nZzxZYV7w28us
         fYRVnGzRdU7E+9AW1aJZq7fFtKLFESvY+9oerqs+bX0Xns+F+e3aI07eA2TwSQbRvYhM
         rrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770362291; x=1770967091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAcAS6itCCUdJZBNZ7FOwqjOX6f/eCKZuoH9k6MbHEI=;
        b=HbMg6IF5bS4BSQPDY41jj3joe9zEI7D77LpWChs1wrYMWx4wtXm5wsYtF3Gy7Lqgy4
         +FmJ2JC0GiK4gtiYu2+hkFq3OlBx8/IdsY0jfz6JwqpwMa8d055qK3FuuSFzYCHIbLjK
         2msv0ojcqRt+b+mawzZjI7EDLQi8jD61FI2RwlmTpyqPBIilAJiR0SY3lbi4HNIR50bj
         gWoypbctx0KFVaL4/4u36KLEcWkn+DKHbYbtRukSIETmVPPS0sfU2xQiN9HMx3JQdO5i
         jQWAZ1cRlMkSNgHMVtYHNPZ2Ubn8wrA0cJmY3ygeZsk9wQBGI+TKjUKfRH+KIElwY4ii
         e7GQ==
X-Gm-Message-State: AOJu0YxjgyhwnYSyIYJITvKQo/K14N7AhfI2uSgO7xyjsrx6fE+Tp35c
	e2oNbKI5zVfZ7IL3MxVIX2m6gcdu7bSCIcIIdn6VpcC/GE/xpTDmnAtbsBM9+/b7
X-Gm-Gg: AZuq6aLOBvJmUta+CLzUU9FqCdNdNjBwkDFBnD8FHUv9U048H4MivsIDNsdV58WM39u
	DRTtP+C3BQfOktEin+rbpIOHonJnKfey3Fp6rwqSNZK3bPSxdxa1Wn3Hniw+BLJHTrZ+XALYxnT
	PTc6OiNvjX/0JrT3YuyM4exWc7wmHQAAffrAG5aAo9tZ2nUu9JHfQ8XXUDi75YQUmUfTX/DAsHu
	gP3uZy3ntCb7exRmP5ODt+xt0M2RvVPZ8+zMOkouygDHL3ZRACPRGzQ+Oh1JPiXn4La0CdN78QG
	TpN4T0L341RTKpC9H9TO9iq3F6xWQvaUpbVNO9OJI4D3wWIn9ec1RjE1Qlo4HaHuzYtMSU+as+v
	3BsnPGJqXnzsz6F2BH8ACuUOpOAKMpNxC9QnMI8vkOfU/vSeJzu4osZjNEUla+eV8VPU3ncyd02
	29lXPic1VwzRT3M3hJEFOqpESbn0yxhhLle2GrT4DG+D5SFAb29InHIkwm3Zwffz2OmIZ1Y0UrV
	vdRodrp7QDGifofPGMlwii6by1CRKto6wUxnB+MzC+KsipB+C57eE87JTiS8xf6tB20JClJImil
	4jYJ
X-Received: by 2002:a05:7300:d51a:b0:2b8:31e5:91b with SMTP id 5a478bee46e88-2b856830c4bmr889249eec.32.1770362290531;
        Thu, 05 Feb 2026 23:18:10 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c7f5fcsm1107052eec.29.2026.02.05.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:18:10 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] net: ethernet: marvell: skge: remove incorrect conflicting PCI ID
Date: Thu,  5 Feb 2026 23:17:14 -0800
Message-ID: <20260206071724.15268-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,marvell.com,networkplumber.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257484-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6336FAE56
X-Rspamd-Action: no action

The ID 1186:4302 is matched by both r8169 and skge. The same device ID
should not be in more than one driver, because in that case, which
driver is used is unpredictable. I downloaded the latest drivers for
all hardware revisions of the D-Link DGE-530T from D-Link's website,
and the only drivers which contain this ID are Realtek drivers.
Therefore, remove this device ID from skge.

In the kernel bug report which requested addition of this device ID,
someone created a patch to add the ID to skge. Then, it was pointed
out that this device is an "r8169 in disguise", and a patch was created
to add it to r8169. Somehow, both of these patches got merged. See the
link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=38862
Fixes: c074304c2bcf ("add pci-id for DGE-530T")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/marvell/skge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 05349a0b2db1..cf4e26d337bb 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -78,7 +78,6 @@ static const struct pci_device_id skge_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x4320) }, /* SK-98xx V2.0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },	  /* D-Link DGE-530T (rev.B) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4c00) },	  /* D-Link DGE-530T */
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4302) },	  /* D-Link DGE-530T Rev C1 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },	  /* Marvell Yukon 88E8001/8003/8010 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) },	  /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, 0x434E) }, 	  /* CNet PowerG-2000 */
-- 
2.43.0


