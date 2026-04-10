Return-Path: <netdev+bounces-277445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMRhMj0U2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 196383D9109
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C4493076A30
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574A3D9052;
	Fri, 10 Apr 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="RMVVgfsM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awZVjIEc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69013D891B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833814; cv=none; b=MKEvZwaqQHdpJ7JKJcCPxDW3TkdVDdxN7Cqd4b5e3iyKlYYXNoAyldwMyuiVAxAjV4BNGdYlf9uLiq77u3Ad2Jrwj6jMJotUEs22qZGgvhh+J1Ocx4cGR4qxoACdqbZFORyClI0EKBJAjNGSOFDK7GmGIhxcSHhWe395MX+Mm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833814; c=relaxed/simple;
	bh=fOdAlp1RrPNuluiQs9TT4elPr4pYfdrgQVxGNxz3Kdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX0qEZ+XOD4x2vWQByJnyvcCVMrIp81UjyCdKbrBR0Cdj7La1KbZKzCmwbeIVYcoOAEffMcPkBTtt4MMCJq+z8g4tDTgp/OTrAuGABoQuaj5hoORT8d5ZWC4/vmq/UnIgqTGIGEFzf0RhuYE2xjl3hDGBb/yQ2BUku6Jtpx7QoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=RMVVgfsM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awZVjIEc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10AF4EC044B;
	Fri, 10 Apr 2026 11:10:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 11:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833812; x=
	1775920212; bh=t0+C0D99cR7NFTky4H4vOh2LkXdLwjqSTmuzo46D2a4=; b=R
	MVVgfsM6CdpqsKL1ohYQxBuWm98O/MaCQtbJcrwh5ANvYPH2HElayrdgNHK9qevm
	btO2BCMpGjn1FznAxFT2cxjzQ95Ut52Y/bV1IeeqJ3VqYI9VoyBuQlm1CE4bwNN8
	5uL98XWLRI7cEMWDqSIIflBUYdG7i4DrZod7zAWAjWrGuqVrwqUaLE7Z781Noitr
	jMuXnNIReM4qIrccDPZq0Fn3tszbTV/uyQjDv7XkUuzpCW6hJsV7MiBKSzmaLGt3
	V2gEukFDmZYKQ4WWupumPRmuKa3/1eaZzPVFdxDH23HjKXasf4hLhzTxfnonJ6gt
	BwmuLg0Wc2L9GP2d+7U7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833812; x=1775920212; bh=t
	0+C0D99cR7NFTky4H4vOh2LkXdLwjqSTmuzo46D2a4=; b=awZVjIEcGOFcaTdCv
	TOELa5ba+sWXyMuXx7NF0HChhG6QVnyl7WRVUyIa8bzGM3h1VvY+509x+iFBa8qL
	e80Wd5p6QFfq6vqOAIKD4yqSnrd3sfS2tGrACImKpXPbJ8VL2BN8G7/LOkhcSO+G
	P36eDzDZGcvIHpTI/8fCiurM4u/HuTbRO8MMZV3y+g5zX+21cY9pM5I4449jGzDD
	d+8BR5picqJIPCjsKXQ7a4Hy/fwRwr1q0Y1lq+qnVk+IFulGvu5sJs6zp3X49qKS
	esF+MNkmMCr8OzgbgAjxcK5QLy3RJZu1I93asOtEUM6X76O2tOidButWcOmvhumd
	6jYtA==
X-ME-Sender: <xms:0xLZaWnMedZEuz1HBUxKSPPmJ18XFdFCFsOyvP1IcD6W3g08y8pi0A>
    <xme:0xLZaeTR-HGet7pLwpT1HgJoNw7YUw8GgimeC5-ZDxlb2ZPtq9nLjKGS4yXnkaEj8
    SWr0tIPb4uromuHj_KpMnh1__EaNXa09s_EZV8bO_XUDb76nXVra23F>
X-ME-Received: <xmr:0xLZaUaml6qP6ysiE5XrJSCpic1mPgiDGbk4SZfaGLrYO5QpH4vPTlNH9e_tMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:0xLZaW9_DjXVGqYSkPyo_mH60RrlF09kgJMPv4BScoHLncjv8LXkZw>
    <xmx:0xLZaekGqXQrIAtOTJ3sHbj69Jbk7IDBAhgOlqdugAXZ8_3zxDADMg>
    <xmx:0xLZabamrKjTcjI4Fc3yUuZTGP00-CCsDQUDuwiUUjzYTV4nHbDn5w>
    <xmx:0xLZaWMHZIeV-VLig0CTtvmtLRjiflklCosNnMd7Xf9W-HKeJxYN8A>
    <xmx:1BLZadeS5MHI05MBtSO2d3-veJj6KYMiwLY1LAK-ikf4pA2tUBUGYt26>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:11 -0400 (EDT)
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v3 03/12] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Fri, 10 Apr 2026 18:09:34 +0300
Message-ID: <20260410150943.993350-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 196383D9109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
into a u16. As can be seen in skb_gro_receive, packets bigger or equal
to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
16-bit iph->tot_len field with an overflow.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..84e8d6c69172 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -603,7 +603,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
 	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
-	if (total_len > GRO_LEGACY_MAX_SIZE)
+	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
 	/*
-- 
2.53.0


