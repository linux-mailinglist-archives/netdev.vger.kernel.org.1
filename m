Return-Path: <netdev+bounces-257179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P1qJkKfhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:46:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC3F37DE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388B5309E921
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37AD25A2A4;
	Thu,  5 Feb 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Dddn3OCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wViFS9RT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCD23BCED
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298808; cv=none; b=qIy2S47Xyrcu/NlDtueBsW/vebPhjw5MrhVY48Tw/Ct1WyDbVPGBWFXaIGqFccBvU3E94GxrKGckX7H2gS6SfGiHkzb7AX6AqcMUgGrul4LVJTtT7QTnCD7eTTm1TL01LgYQsFa7O+FGlifYOi/DY28bJdIiqujsvKrH9Qiwv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298808; c=relaxed/simple;
	bh=+M0uIWmIaOLzsz2a0Z0LCK/CxcqaOdljlzLO2KueOgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx1ovDArNGsHuzpOcke5uuIlFnG9XSOPiJNrpnMuzu2iy5GppwanRTheH52tFTzHbuIP90wQP7UOT1hqqXdwceYExUqRuTs4gI3r1nn8hizLjLneTv099KF8kAjakpX0tt/X9DoR21isdX41QfghdM6yOvtQHovHbZp/1KdPr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Dddn3OCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wViFS9RT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B96137A0168;
	Thu,  5 Feb 2026 08:40:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298807; x=
	1770385207; bh=tIrZ2L4CG+F5eNIl1HIGJqVYMfLHw9SFXQ5JLsM3x9Q=; b=D
	ddn3OCnj9ovZ9rvQKGt3WVsUQoHklpvAUBpRUt2wyHJ666aUc8R+fxG+X3iKbsee
	6HBKu/4bfpnUxmuxkBG1DpVZLhxsPM7updcKemVTkcKAlkUPDOVzSStVQuxUGvWG
	tktod+KVNGb0W2V14xTrcYwSdnslpfijXA5Jf/JrwNhE8ys5iwKNrusVJaZPUA3A
	ROwvHB3Qivynae9RvVXRCy8q1+7L6hmDJ1jU3PdjpfnSkZlmpxhGs1+OBIwIq3T/
	lH/zh4Ln5pxf8dNGCdAbPgyFtloEJvKRAriqw8aqSw9GPr7psmVhjZODNZ3iLQWf
	Y72UYxJ+liOFUo+yFeZmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298807; x=1770385207; bh=t
	IrZ2L4CG+F5eNIl1HIGJqVYMfLHw9SFXQ5JLsM3x9Q=; b=wViFS9RTqx4ipRvP/
	7I8XxM16/d9WchMoILDDNAJFe8Z1ZVJKwzvZwv0sVGjVnVlCv5eXeT3ARiu/kS5P
	Pki8gbZHijasgt6a+vHW2tuADq00Kt0JgR4QLz+cnjOH0nvWCX4EsWN0mkhx+kOI
	fWNimRULswOU3YTJR801Zjg+T22jdzRUu/PO1Fk8MnJY28lKeh75MRdc4kINTqYH
	8GJRWpo8j18MVvgFZk6ukPMY6ckCN2AtvQUnk9QcoB1UnLrxYRq6wivu1Jj3buQU
	Zmpaffne0Wk5vqOSzRnyS6z75jmtR+iMfXjrN9UYmpCpfAvNku9BcB/WX8FzSm5P
	z/9bA==
X-ME-Sender: <xms:t52EaYmuUeq3GCIrz-XCsggt9fYogJRmr1E9udaumtryanFub5865g>
    <xme:t52EaePkTC6zNTnYLOOZeiNzNB1P24EqmVdfMLjG3hasZ2thwttF88KHGBjfgob6b
    w9mIXX1k0FuMJPUFxy1Ba5Nby3jKC9b1BNzUqgSsgpuVru4zazcfZ0>
X-ME-Received: <xmr:t52EaS6IlSRQ4S-OpoQwj_5SzfFT0gqPVP86RVuDOyBipMl27gLaZaHt0G2TUVNPfQVohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:t52EaSbv2b8ZbdrTqobzRkGHf2jfxquQFzlzbiDPx8FTtxN6SH8fww>
    <xmx:t52EafcBmYBPmz7F4xHs3GeXduJEgeO4vTuVOCuY5IaawwU02vM7_w>
    <xmx:t52EaR4MSEhpuR4QPPii2S1_B8VqVbetWWU5N9JhT2Vuanfwm7wWKw>
    <xmx:t52Eacb_JStAuX-i7SyeZnzNdaeHhv0vG65vUm69NM2Hr662lT0RiA>
    <xmx:t52EaXRG2_fBe1xLL0oO4B-VX9Yr36l7r6IMpXTn9xWsD1YDLjtOZja5>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:40:06 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 10/12] net: mana: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:23 +0200
Message-ID: <20260205133925.526371-11-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,isovalent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CEC3F37DE
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 91c418097284..9b5a72ada5c4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -355,9 +355,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_drop_count;
-
 	txq = &apc->tx_qp[txq_idx].txq;
 	gdma_sq = txq->gdma_sq;
 	cq = &apc->tx_qp[txq_idx].tx_cq;
-- 
2.52.0


