Return-Path: <netdev+bounces-265462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKzGJOuhrmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59F23728A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA635302E7F2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFD389449;
	Mon,  9 Mar 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="la3xhSvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vyzANQdV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8B3793DA
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052380; cv=none; b=SooLPhF9O24Y5qWrqxS4RgZXPM9g15caZmzHjcQBJ5D++o4u+Sr9ZQpzUcFr0uR48ZNPo2zz3+lyCI3veDRQH9525jla5B0Zm1L0DRLnTdGxqZ8E4b+4hyfZq5r7/RlRjeWlFJ0ab7zI8Vp5wAAIhhQVhpK+MTfks1NBrnVbfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052380; c=relaxed/simple;
	bh=X6l1OokI6VEvNJkRokHXQY/QHXwpiARv87fl+/Zs5nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHZDpXRfF8Rpv2axOtm2tykYizySJJTvh4ZF7k+HaKsbjZz9PlOroPcPgDz9mfvC9LViJNCbXBIOMw0jhMYT0UR39+Ja6oEk8nXbBWmPhswnAbvxaz2bRqqe8IQp8oYnhsJtyV6Qb2rm0FpHFg7XV6icb3FbI7Aka+KXQGamsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=la3xhSvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vyzANQdV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F4C71D000F5;
	Mon,  9 Mar 2026 06:32:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 06:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1773052374; x=1773138774; bh=SthNO5dZ3A
	bm0i3A1LbT8zk/J7BPjc794X8HTu7LV50=; b=la3xhSvjzuh8liQavQwwHd0+e7
	UWt1ekdqYEeKqLvfjp4AMRVa0AJBuVXB7zlf78Cy0BRWzZlMupPxC8h7x2VITPsS
	a4j+ayA/AeQv6AiMbzko4dbPJkzUbh0EYgymVmO5V/cgthuXgLezD/cZzMdh6hM4
	t8xNmn7OqbBc+3Ldy3JE6aLehHgeRMYjkD01enpgXyJ4fp/0JEiMmivJ54pQKg1G
	6N8HRPxIzNtoyiHEOZuuXE5kZ/9yMK1Rh/VT5WWmR79kGeKBC6cZrhFVkX1cKN7N
	iqX8o5n8E7jWtunljyF5koEPCsi0/hRB2wchX7u1fXQf+F99/ycktDWXnDfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773052374; x=1773138774; bh=SthNO5dZ3Abm0i3A1LbT8zk/J7BPjc794X8
	HTu7LV50=; b=vyzANQdVxY82i55Ajf6L0lI3j/G/0hhsaaVuo15XGi4XGJYnFQu
	dYR5B1iiVe7my+sonRPG4DzLa7ENk7uJxOwgL/CiBurP5ljl3LtdXkVnMh3ZkF5U
	SbDPQ9EqOOSnk2x02mez7/qXR3+HIvZTrnTWzcHel9yUrvmvuG5Fwc6Tasvsfjda
	adYGODCrG9vDLCsNe9YX1KsaPUsq3h0ewaP7/VJ7UMpYrbof0vsptc+ARn6Fc04p
	Rg6L8f/Fp3lKrRz1VaxuE+3TlQo9js5CSwmSLeHZ6YWbM6ycGRkw0l70vwtclu55
	ifb19BRYUi2MAwPEk5hF1+NtXLYDdbVfTiA==
X-ME-Sender: <xms:1KGuaXgFhQ-rjrRAa5d8x1gIag09MbpCo2xrlwR24zvQSGiAxeePoA>
    <xme:1KGuafdxw4eP-41ANc5-Ww1haHWBw7C_SDxxex8LZuw70X9pZ9PdWceYT5B3oB8u5
    0DIuBJyvF68Xb4pwo88C53TDchtJW3YSvK9NkqOIklqQC7zsaWasg>
X-ME-Received: <xmr:1KGuaamDOjAnmJICmznan1kic6OkApozOQSZbVdXh6Y3n_j6Vg3e2TFamhL3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdr
    tghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrgh
    drrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:1KGuaYvLLCR3O2o_Hn_2GNEO2mUXKjKbKbNKpVmv2chW7R-o6fZAxw>
    <xmx:1KGuaQ8fKHdolzFxp5Vzws8vHvwzWGEeMnA0P71C2Plo8a23ujGejA>
    <xmx:1KGuaaPdcfFVctC2hj10RRNIqFZ9p8l5eouhW6GgEQb7ylHiCOrvIg>
    <xmx:1KGuaWGN9ftV-LrWxwAEZVpNMLeASwNYyGsJCCvVhlc9xr3I1dgqUA>
    <xmx:1qGuab1zhmHhWCPx0NBMYKkUg8mTrlFDUDcDPUygf_7gT_EdEMChUpWC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:32:52 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 00/10] xfrm: fix most sparse warnings
Date: Mon,  9 Mar 2026 11:32:33 +0100
Message-ID: <cover.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE59F23728A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265462-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

This series fixes most of the sparse warnings currently reported about
RCU pointers for files under net/xfrm. There's no actual bug in the
current code, we only need to use the correct helpers in each context.

Sabrina Dubroca (10):
  xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
  xfrm: state: fix sparse warnings in xfrm_state_init
  xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
  xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
  xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
  xfrm: state: silence sparse warnings during netns exit
  xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
  xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
  xfrm: add rcu_access_pointer to silence sparse warning for
    xfrm_input_afinfo
  xfrm: avoid RCU warnings around the per-netns netlink socket

 include/net/netns/xfrm.h |   2 +-
 net/xfrm/xfrm_input.c    |   5 +-
 net/xfrm/xfrm_policy.c   |  10 ++--
 net/xfrm/xfrm_state.c    | 115 +++++++++++++++++++++------------------
 net/xfrm/xfrm_user.c     |  25 ++++++---
 5 files changed, 90 insertions(+), 67 deletions(-)

-- 
2.51.2


