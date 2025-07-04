Return-Path: <netdev+bounces-204181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3008AF9611
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9916A851
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCEE199FBA;
	Fri,  4 Jul 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="iLbtF8Ag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn7D6+jJ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990182C60
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640900; cv=none; b=EjSvbl4GNDcP+1tF8OxAmCi+PjaCgJ782C+WOI5I1svqJ1Gdh01rFsmaTUGuIeZiD9iG+oF+dOh67YFF2Tl0oLXGKowJh/bGoR2pXem9wOfOxnfPTujHCPTEuPvUUNCrFdd2Z7W60bapTecoSLJz1HivLbTVcYf39r7xzTdpmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640900; c=relaxed/simple;
	bh=ORdUlCqgIJVwbDECAkWFwQs3ToP6tmbDm89Qyo5MVSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePnSAnr2Q06gqxiUDjNWYqUspV0W/ETkIKfTDxP+FZD0QuS2gWjb+pVAavZrCIKnqzeSMILSQpjxWsH9FVyK7REPI+fmkyWBAxPORzi1wwU/IJobndOeZf6uVV5IHHYOtZBV5sr7gfAasxf8N2A0m40idVIr4rPOeGp7PoSWKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=iLbtF8Ag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn7D6+jJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B81A7A0190;
	Fri,  4 Jul 2025 10:54:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 04 Jul 2025 10:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1751640895; x=1751727295; bh=UBHQ4Cfors
	WOBhLjV8lY6M3l2XSO5mbkA2yhpgcb/SI=; b=iLbtF8AgpybFk1TxDLsDkwOpZC
	jOkO/7+JKwjMADbecNJrghfVZPnQOk7+17tkFIJH/al6NNjnutSwwtEb5qnVi/rA
	vlkfyWSDy9odKEI888uRzHFEpVUotjnIsKgvFLmijSUcoZwiAqXojWvzPWl7BSeI
	bbQW+qU/DDyGpaIKw9GzKJNzODAp4EZG1Afvh9fiWsMqQwMXlRboR6/hKLCa3iXd
	oNpHbHCQIe3S06KbuYaW1aqky04gWi91mz0YVBQZyQYLZ1+umgyTNRHoTpzGrh3P
	vi7BnXmMwh+x5SDO34WXnHSDZK6FpJTjrxqC0Yp2sfmxBNSAmW0aEw29mJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751640895; x=1751727295; bh=UBHQ4CforsWOBhLjV8lY6M3l2XSO5mbkA2y
	hpgcb/SI=; b=Mn7D6+jJqIfj9SxcdDzYnAxWYm6ehpbASZGOHw/IAO++wIbKekl
	XqkaHIgLnvrGb75G0wowsJU0eUu1Xbjbtcf+apRAvBatIbprZdYUFX+J6e4uSG6d
	seS56z0F3/f4Ng63pG7/cmWgZZAHbWBZ151Xw7x/PQ8shng4AUwWA+ttswZ2//vb
	iGh0vKxhZccJzkqfHLKD+dCek8+S2cx/YvpMOGmQvEBxIBSP0L5bwXcSFnyUgUrw
	ckfQ4Ld+2LcAAkvlrmT8gp75nPcPluFrYeNvixBe5+oFhHktTBe6ERLoZZymtMds
	k/KtIGtanROluOxPsx930ehwdEfD6sQDhOA==
X-ME-Sender: <xms:PetnaEaReYwh4q8rhoJgrrFNWRlZ1M2rrVCG8gRZELJEBADR8AfO6Q>
    <xme:PetnaPbaxfDjLJUx4JrAC5JeUxUlmOL38pWYC3cyqsCgW1TVaSL0fwID9GYm_2SdK
    C1TSJmnI9NuaWz7zjk>
X-ME-Received: <xmr:PetnaO-WH23lKVi_6MjhZ-1xfPq1ICdcFM_ApRhOCJDp4SjowfE2SsaqOSXJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgrucff
    uhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeejtdeugfffkeejfeehkeeiiedvjeehvdduffevfeetueffheegteetvdfhffev
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsug
    esqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgt
    ohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrd
    gruhdprhgtphhtthhopegrughosghrihihrghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    gusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:PetnaOppRYOEryVoREmDTiBlQoXtfx4TKkbrHJ0sw4iG8K4sB06Y9g>
    <xmx:PetnaPoYsg1kfSYourDY0dmWKTe_mR1kCqDA-zReh4FujPcQoV2Nlw>
    <xmx:PetnaMTaoyo8aakC7cBDJoR2sNFpDlsiufQZ9dFkqw05sY-wkJydTw>
    <xmx:PetnaPrOnXW5S-QYrOC3766BJ7nUR-S7DEWRzwitVRjmmF_5t5KiEg>
    <xmx:P-tnaBIYABkV0CWb9InomZJFDawa-Hhe_9YBd6G5cTr4Y49hXjIrSS5W>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 10:54:53 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 0/2] ipsec: fix splat due to ipcomp fallback tunnel
Date: Fri,  4 Jul 2025 16:54:32 +0200
Message-ID: <cover.1751640074.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPcomp tunnel states have an associated fallback tunnel, a keep a
reference on the corresponding xfrm_state, to allow deleting that
extra state when it's not needed anymore. These states cause issues
during netns deletion.

Commit f75a2804da39 ("xfrm: destroy xfrm_state synchronously on net
exit path") tried to address these problems but doesn't fully solve
them, and slowed down netns deletion by adding one synchronize_rcu per
deleted state.

The first patch solves the problem by moving the fallback state
deletion earlier (when we delete the user state, rather than at
destruction), then we can revert the previous fix.

Sabrina Dubroca (2):
  xfrm: delete x->tunnel as we delete x
  Revert "xfrm: destroy xfrm_state synchronously on net exit path"

 include/net/xfrm.h      | 13 +++----------
 net/ipv4/ipcomp.c       |  2 ++
 net/ipv6/ipcomp6.c      |  2 ++
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/key/af_key.c        |  2 +-
 net/xfrm/xfrm_ipcomp.c  |  1 -
 net/xfrm/xfrm_state.c   | 40 ++++++++++++++++------------------------
 net/xfrm/xfrm_user.c    |  2 +-
 8 files changed, 26 insertions(+), 38 deletions(-)

-- 
2.50.0


