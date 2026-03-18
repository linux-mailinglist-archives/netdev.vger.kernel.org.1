Return-Path: <netdev+bounces-268967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBTgH7WCumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F522BA28B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3023C307C4AC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECA36165A;
	Wed, 18 Mar 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rYZjYFeo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3T2jf/oD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D541C860C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830763; cv=none; b=Jsr0SRV8zEIz9SSXkJoLverDAQAuFTW2kZKsTv+3cNS7r7sxZwYEBubSodQM4D5WFkv7+519Rpcp/XfdI0s+bmGAMuTyO16GBkpuQ0xk3bFAN1hSDQ0p4ToF5MDpoSrFaCKRp9QJISVtAviZ281TuJLmgQKWNHmu4qr/B0UO2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830763; c=relaxed/simple;
	bh=cq3qJhlxgdcaTkx7yK71hFegDnlsMEWoM7YMWxSUu9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0Iq0hVmYBmThlOGEuAarznDRjs2TCbZdJFmTSmTS/E/ekQmEQilp+0A05nwW1D6M+RrdCvU5j4nGmXbt39UwEwQXQHDWP0ax2EkRVLz9rume9Nq4QOj+fYWy+6gCGU/rc1jdBrqumEUrnPoto9Cywz6484CZQ/IOybjVj5q6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rYZjYFeo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3T2jf/oD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41852140017B;
	Wed, 18 Mar 2026 06:45:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 06:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773830759; x=1773917159; bh=hiRwusemtB
	WtUljHjLtveV1pisvlge4S7Ybay1FoPOA=; b=rYZjYFeobUWGgFu6oxf46DNzxK
	M0fl+Tb/wHVwvDqc/ySQJKbgqkBqTJkgHrQr6lcxfQm5kPjRgzqYDHAfDku1mBxo
	eFgLOMY1PTT+ktYl1SSOpstkgrPCEx6G0n3T7kE1XhweWKSieHTv9DMLSx3GxYz6
	PDAF+SIA2T4Z2xUN6TtPOXSm6TjEyJqbvnsG1W1yWnbKBnDHzpnT7i0W/ioU+uZV
	x7QtikEqGOTMRVYTiA70LLC10uyJJIylJyNZYXWvUSQwsrhguuzVkSsgAWSxyEvj
	idKB9DgWFKZ7BS3fBCXnze0EuFteQzmFbocnkHgBmVUAK8rYmp7nVc6IdH5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773830759; x=1773917159; bh=hiRwusemtBWtUljHjLtveV1pisvlge4S7Yb
	ay1FoPOA=; b=3T2jf/oDLem4Pi+UFs11YMg+VnPiMaZVWSEP87Crvxn4Z+V2Wn8
	UbujM/Ct0M1aqW5GKynil51/KGL0+LLD9ugPWBqfNb0usNG/2ezUv7ykKmJ85219
	vx4k38cyk2adX/pABmGfcNjbgarSUPTJh+9oi07U4x65Uw6msi7R2MHQh8CQsSUF
	cwShOvIJdx5RoZEdiQh23tJuMTCoh7Y0x14sWpq6lRMJx3rSTVTF0gNtTB/QOPZg
	0Ys/Sa3DH+VP7nVCS+JmNMnBwN88eEvZ61UliJGqoYndZvo+95BNr/3jm30fxfuU
	0bEto/D6TCxvItKoQPIOH7CYicF3/jlHEGw==
X-ME-Sender: <xms:ZYK6aVAt9qrM8kAiAX-AdrJrLySX0WurmZTHTAG8nmE3YTxj9-TUnA>
    <xme:ZYK6aZjK2vWItK9sr-Wyf003xWrTIh2-gIOkSjKJlLFnYeS-PQDBDIS1ws4Ya8_Ot
    GuKVk8BVTAXK6GAQjeKcRr7U6evY1SWK1FcfuBPvbH5fl9ttaE-oj0>
X-ME-Received: <xmr:ZYK6aePIlQhRyvivxJBRc6kOlAwqGiajtDlcEGun2suZZQs_WUkuxYniwK19>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvje
    ehvdduffevfeetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshi
    hsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:ZYK6aa7DYG0cA9ZOpHSD9qXSASierbLgGDPzHjpyKc1Fw7e5k7Hw0w>
    <xmx:ZYK6ac0iMLS1li2Xvf333Vkoi5tVaPy52KIeZO0rXKNzEOHUwI0cwQ>
    <xmx:ZYK6abbqVnCkF6iD15cQngdLv6LlyVyrCZhOwb6x28gRTVyFT3Cz1A>
    <xmx:ZYK6aUAmPvvX7juRcuc_l2iF6LJrf4QTnHtICGJifZe3NeW-rdH11w>
    <xmx:Z4K6aXHbUIIyb5hOIAGpl2xDkBrc1CB53M0yWAv7bYSzn_STZyt3E_hc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 06:45:57 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 0/2] rtnetlink: add missing attributes in if_nlmsg_size
Date: Wed, 18 Mar 2026 11:45:51 +0100
Message-ID: <cover.1773829376.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268967-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B3F522BA28B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once again we have some attributes added by rtnl_fill_ifinfo() that
aren't counted in if_nlmsg_size().

Sabrina Dubroca (2):
  rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
  rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

 net/core/rtnetlink.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.51.2


