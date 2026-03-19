Return-Path: <netdev+bounces-269712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHwTHK2AvGnfzQIAu9opvQ
	(envelope-from <netdev+bounces-269712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:03:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E92D3F40
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B9B301BC1F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6A3AE71C;
	Thu, 19 Mar 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="R5kKmSS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NF02OCTW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A42EC553
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961385; cv=none; b=fs3pu3I5KsrPbYQFzJ49ksKShQriawKo3cCzm8aFkRKBq7O+SIBNZDPB3IFhnWks0CFS2e2dxfLEV3PHX+/0XneiXWApviDvgmLW1NCIlNOoarnJXQKXMtYriBtdHhjphSIyYiXJ+k9qrNly3RZZHYzeea9oW3gKsMTow3ULUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961385; c=relaxed/simple;
	bh=HvUr1tEAKxfsNugwk/axYD9sKmZlnmuG1s6YL9uGnRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lM4cthhMGJRjGfV87a5sKVGCsdmCvRy9Oq3A+r3MjprvyrJ1GOu74rv/X7G7swto1UsxK2kP4KCtXw0EHrb9QNs/G1R0KdvY3by2vZvnjUXpvTVO5xmzCNV7vyy3fyKc1f7WynIl8P3ZyJ1Wx4qBiWjqSHIzPMJkyl8j46KB1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=R5kKmSS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NF02OCTW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2988D1D001E2;
	Thu, 19 Mar 2026 19:03:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 19:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773961380; x=1774047780; bh=+3T1h16DTY
	woHHDcCE//hKSHR/rCTCidswBtlXbsSyw=; b=R5kKmSS6VYSo+3EyglSVNcHPl7
	m26T2kkPCnGsLzivlWq7+F4pfcLLeLaeZkx7BJqVzta7wlReDoiExvt5/R+hvCKU
	6k38aS5Q0MaVl12l0CNLmwgbXBnZckg9550HDj0/0Tkr/kkCEVKlr8r3SHQu6XX9
	vUoTgrDEmx9xuVJ16DIpsXApTyzp+3HQbm3c8p8jtt8/OhucykT063nmFuYJLyla
	Hb34Fxj7XYr6nsozu70Loqgh0WCWJplZWYagM3yDmsXU2g2iH5mheJ+2yL0doijR
	rDmYDFT9zGjH6d0I0IkyE2Fm+wUXD5yQFwqLCgCKJQjlLtTnxb0x5ou6bfew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773961380; x=1774047780; bh=+3T1h16DTYwoHHDcCE//hKSHR/rCTCidswB
	tlXbsSyw=; b=NF02OCTWCmaCuLV/QWvB7+w+W76T3ZpmPkCC7uaB75i2m/gN60x
	tmqaKcj22NaZS0R+jx0xNG5dWiYu9YbZzTsyKCTJIptCNXTvdK5564w87Yb4LE+g
	f57qMCbnzbnT37TAAz1EEN4ypOsb56HqnD0Er3/iF9MDPV3BS9IzPHK+lfs+ecIo
	ujgilVgJlx42ej0MqCM+xSHJhvLcM2WQVxkUfk5TKA+J7CaTWj1kL7xMnwxKCneK
	tjjTKXCzIBnekzJLuFuX4/5mhI4Bp+TNgcOUO0vLohw+Lu9hNd3il6cUG5DcEYZo
	bSDH1eJSLpsN/h3nrWtUZ6kqhlBnGF5f4EA==
X-ME-Sender: <xms:pIC8acSB03FQ684lbGVgSAkx6vsePFR_UcHrJqE7gK6eM_alshovUA>
    <xme:pIC8afz35-68BKdUJDnt5pV8nxozQLv_0wMh5Kbpj1gQbfkvc5XwRvXRV_miO3S6q
    6i_yim2hC7V38nOCk294cI6a93Z4-mau2loBlGaezyV8pkhQpE70Q>
X-ME-Received: <xmr:pIC8aXf0KXqUyf0iT-aYCDi6ZY4NFpJywYdnxOb6pkefNON8qbipcLsPY2Mh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvje
    ehvdduffevfeetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshi
    hsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:pIC8abJJDm0Wi6IQs327exzZQhrAVUvva5RBwpY-17F19XYoTbxFwQ>
    <xmx:pIC8aYHKKXsa0rFujSxLl2gY639c8z7Pcs5B3j1dYYbfb2sJpeSwlA>
    <xmx:pIC8aVoKPyfZyOYdTYz_ljMYQxjzN2YTBpfY4auWAB01CaTdf4Fygg>
    <xmx:pIC8aRT3sMv0kaRB_u4nW-f71gr0Tuj1-dJQKHOtPeFSP--Tc7ILPw>
    <xmx:pIC8afrBgFJkI-FYWNE-3-1z2XXUbCalWXHi7McdLr3O-I5fJCPnFRBr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 19:02:59 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net v2 0/2] rtnetlink: add missing attributes in if_nlmsg_size
Date: Fri, 20 Mar 2026 00:02:51 +0100
Message-ID: <cover.1773919462.git.sd@queasysnail.net>
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
	TAGGED_FROM(0.00)[bounces-269712-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6E92D3F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once again we have some attributes added by rtnl_fill_ifinfo() that
aren't counted in if_nlmsg_size().

v2: add missing nla_total_size in patch 1, spotted by Sergey Ryazanov
    patch 2 unchanged, keep Jiri Pirko's Reviewed-by

Sabrina Dubroca (2):
  rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
  rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

 net/core/rtnetlink.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.51.2


