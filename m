Return-Path: <netdev+bounces-218361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A226B3C2BE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80983BA62F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803F21CC56;
	Fri, 29 Aug 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DwLrZ5k7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSV3jkvo"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8D9443
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493759; cv=none; b=rDMvm6zJiwA9fw2zdrXBQOB//EWmdw/nyEm0wUNE+QZ1HsnErI3yZ+WClf/z/RreM49mAbRwe0YhXOiQ8pTcCkYcMNW+1vwalcnnscvedc9lT7Vdn/yVFYw2p6p3rthcp/r6MVAOfU69H6ByXgQdCj8FORJ7Fao4Mfg5O0YCOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493759; c=relaxed/simple;
	bh=EwlCeAnJ1LQEpfM9Ch9sXGoMQbVVCDM6oF8MJv53RJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNbtQhg6PimP9dLXNhXy7rTyLQ3YuqV9dBCFLbId2yda3NtMtVfgyUM+9KoUsBPro0R2xNfPsMoAO5qhIl42MDHQnKi9vxCem6KJKJ9pV/Xb3C7ptrMJVTKwOw1KaNYDpBaYraXdFw5dVX9qg/0lPhFo0oARlnVTJH1Z5wx3HA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DwLrZ5k7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSV3jkvo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 195A2EC0418;
	Fri, 29 Aug 2025 14:55:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 14:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1756493754; x=1756580154; bh=onjLkHYf12
	q88Uok/mJa6RWQzh9/mmeUeRJJQ6jkffY=; b=DwLrZ5k7S1li7w6QIcG7tQyNm4
	Sak6V2hECUq5FAU0WNfReECLUgNLM1ZkmzoTALiO8qg/DF1+KwtJCXTtu50ULcWP
	PtR5EhrSwnMUYa/1sDEtZVEOL01zw57PzR9PEAmwzne9bxUY8gIK+osRs5lw//Bv
	H+9JvcoUDkS+mwNwwL57WJjO40HQcU6PS+2/TEr5/OmYv3WVNslA1wWrnyHbulEh
	VqOwOwLg8swZ/OX+diTgDXUA9yUvZBiB3zxiViue3cYaEv7P9i1t0TNR2EnV/biH
	bo3Hrs/LlihTjct/Hm/DP5OeoZjgVNx2FmJbs1Vww06FJPLdSXOJalu/C9TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756493754; x=1756580154; bh=onjLkHYf12q88Uok/mJa6RWQzh9/mmeUeRJ
	JQ6jkffY=; b=hSV3jkvo8/ETUKL0LTEDHgm3TYTWUUSO5ui3B1jpptqpWLZ5Xsb
	Q9vdDoY3NYq3uPXB0VqBCS2v8rswyZePkuspv5axnIOGdSpCfwZgKa//JMOql/Jc
	Eiv/KMigT8I4M79nsoe/KZoEQ9V3dCw0EbwnivLe2I45BnvLOq0G7zh4kxu15x7N
	fysJiqfAIXhAtZvoOojjMk7pmDUzBQSL7wHRiZTeA/ydkWlHbgj6lHLFskaEctE9
	6j/cQqOIBxrBPmcfRRAnHUQIh1IhnfC2sI1Kxmd6wWdXRgqqdUH+EBYHZWbt8Z0o
	JnwMjNiaK2yOR/dOc1QP+BcKW3Mu2LTCsWg==
X-ME-Sender: <xms:ufexaAj5dGkUDQQ1cfj-FSC2rMTL6xm94_a0yCJE_DCe2yhJtM5-2g>
    <xme:ufexaDlG1e-FC1EeR9gocCV5jgIZXGL62-YHQpUW_S_IO5gCrpvS5yb3LizK643Wf
    Ac5Vyw1cwGCpoKlU9U>
X-ME-Received: <xmr:ufexaEoqkr7I75Wl79lrEsvnpqYKFCpjci1giFjbCn9Fz5BAnAsE1Estugnv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehmrgihfhhlohifvghrvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ufexaEGzs0vI8E1SPU36Ic00ex7AZa4uSw-lNSgeal1KHGl6WiA1JQ>
    <xmx:ufexaIwGEptqX3runPNggekSSyiqbZFAfaNxkrv-wJgQomCiRHroAg>
    <xmx:ufexaBqliTHeOw4YYUImHFTnbfUDUx036DYpwB5JF-5BN5PrTWPoeA>
    <xmx:ufexaKiOFZ1b8RyBmOKzGv9F1SlSRGHFvwipGBh5A9gYEgtZUFZg-g>
    <xmx:uvexaBcgKYgFsr5kaCG91t_jUkBIcKonVczE4vEOvwRcqe8t7tYb-Myo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 14:55:53 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Era Mayflower <mayflowerera@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] macsec: read MACSEC_SA_ATTR_PN with nla_get_uint
Date: Fri, 29 Aug 2025 20:55:40 +0200
Message-ID: <1c1df1661b89238caf5beefb84a10ebfd56c66ea.1756459839.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code currently reads both U32 attributes and U64 attributes as
U64, so when a U32 attribute is provided by userspace (ie, when not
using XPN), on big endian systems, we'll load that value into the
upper 32bits of the next_pn field instead of the lower 32bits. This
means that the value that userspace provided is ignored (we only care
about the lower 32bits for non-XPN), and we'll start using PNs from 0.

Switch to nla_get_uint, which will read the value correctly on all
arches, whether it's 32b or 64b.

Fixes: 48ef50fa866a ("macsec: Netlink support of XPN cipher suites (IEEE 802.1AEbw)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
I'm submitting it for net since it fixes the behavior on BE, but I'm
ok if this goes to net-next instead. The patch doesn't conflict with
my policy rework.

 drivers/net/macsec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4c75d1fea552..01329fe7451a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1844,7 +1844,7 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 	if (tb_sa[MACSEC_SA_ATTR_PN]) {
 		spin_lock_bh(&rx_sa->lock);
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
@@ -2086,7 +2086,7 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&tx_sa->lock);
-	tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+	tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 	spin_unlock_bh(&tx_sa->lock);
 
 	if (tb_sa[MACSEC_SA_ATTR_ACTIVE])
@@ -2398,7 +2398,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&tx_sa->lock);
 		prev_pn = tx_sa->next_pn_halves;
-		tx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		tx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&tx_sa->lock);
 	}
 
@@ -2496,7 +2496,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&rx_sa->lock);
 		prev_pn = rx_sa->next_pn_halves;
-		rx_sa->next_pn = nla_get_u64(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
-- 
2.51.0


