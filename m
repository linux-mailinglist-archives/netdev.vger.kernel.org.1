Return-Path: <netdev+bounces-260254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFV8MYPdnGl/LwQAu9opvQ
	(envelope-from <netdev+bounces-260254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:06:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC217ECE8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0C15309520E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789137E2E0;
	Mon, 23 Feb 2026 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="H4D88yRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPZfSInV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7A37E2E6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887931; cv=none; b=Sc8Q7IvkbOGRvs8XGJwcBLcsLrWrqU/owM7tw5tdPZyHCn9KXqgRc+cBbWrerG86NqVevU4kxcdGebW8GH46LwYFaRD/cr+WtLWWLsEZEHloKij5EEnGJY224pXUkj407uRUCh80h5fPyHlADTUNpUrFW9vmVLcN8AqhZFcz45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887931; c=relaxed/simple;
	bh=AYaE1No9ATufp037qakBQvfQcjAVvH9bJ3AD7OwvmbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjDIEGlqf84tZMjzLoLQu9QRjG24uEu4INAW7iymZye0IsL8J/0Iun+tOpOpz152oLubQ8udxw4y1YCTTzpfmjsHFDr6OCMLug1HqkqDvF3aK4Kjj8ibSI/41arYzWkaNx1wagn0K3OdeFgsEqE/z8KSoKEwl1sO0KoBo8q8RBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=H4D88yRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPZfSInV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B85491D001A9;
	Mon, 23 Feb 2026 18:05:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 18:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771887929; x=
	1771974329; bh=9BleqaMhJ7j6AiFf97Zy4rBXKGhsMglfLM1A/DsNIQU=; b=H
	4D88yRLupQ4DDoHbsFVugI9gjOoraT7WCZ0Z5k1yl6kpfvvZKuGZ4jcuu2ivZLYc
	7RryUZYWDwxHrPdbAXB2RWLZaBbzqyLbbV6o5Ukkc+ipiHGe7V2EIR5XQzwP5w1L
	DQD2NohanvvkyIYn8I4X0wLrtWGGdf2nW0HNwPWF9HEqzo7529DboqDGBvLFpMA/
	7soo6FalsY3rGPAADwqweEDgaa/pAWdGFVjUpEzOWuIZ9H0lw8KgCdIO03P57soW
	3K4s5X2aqCmwzATzRQKAgZ/d5GabUO+JafYVzKdhuAuqLa4+IvrGP0jfeSPLCFiy
	+tjr/W1jm4JdCu4Wo9VPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771887929; x=1771974329; bh=9
	BleqaMhJ7j6AiFf97Zy4rBXKGhsMglfLM1A/DsNIQU=; b=BPZfSInV24rF8AnBe
	b91gjG7bGTs6ZmO81PXZ9RpRht+qSMEeZskTnhUqIYWC1XKkaW82EEEOBQpZwy3f
	Mf1YFlV/j9G/uSCPoKeghyU5etpc1WE8ecqatFssyj1RtP9lZSfN81QJ1KV6rQAT
	hRY2iU/2cwft3mFu15aZxWsXDxUEVN8qG0Cui6U2ISvTnjHws4xBLsSG905mSYit
	xbgiG6XkUiMq22CeEzPYDKqkDDacjt50U5En+hj5QUmcFtfAkYlLHdEm1rJkbPSd
	5TCi6H/jhsoqG3GVtYxc+txRfw6WEcmONsw+ojdqEU+X2aWX6RKPpP+QzNioAy4F
	TrhYw==
X-ME-Sender: <xms:Od2cabHHi8CWC6dGt9nOv2G0em5Ne7RIE6-68wDC16puq9m8XHPqfA>
    <xme:Od2caTxar3ReuQyIeCf4gWf76eN0SdOjigxju5Lq93ZPh_tEeZo1zZwtmAtx94dUi
    rkZ328w6P3y9tI1dsMA7Zp7LcUHqK27NSr13t0Cz-vDEND2GaEIOo8>
X-ME-Received: <xmr:Od2caQpn9vgCQq23QBXFmLnla9cx3zEuRrGTgUtJRNCAIQjbU74WRVuoYr1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:Od2cadjB4SXO02KPAJZY8jJXjs7Xx2wXaVvR7TbBj9In8I25jpXorQ>
    <xmx:Od2cadgrepuvELk9yDg2lwJwbyIWyvZeuRHi9y_ZT8nyXwkB89uWzA>
    <xmx:Od2caTjlKTfhtaWMadJPN6YgIxxjIYLY0mt-U0Rq0AbdkYWFn2f7Eg>
    <xmx:Od2cadKlfDWsIJD-YtTvMi2gR47wAznn7vIJofperevtianh7ez29g>
    <xmx:Od2caf4YRi-CI44oaqBp6qzNqzzj96EaRG7dwxZlmZVXAw54Vc01Lc0w>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:05:29 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 3/4] xfrm: call xdo_dev_state_delete during state update
Date: Tue, 24 Feb 2026 00:05:13 +0100
Message-ID: <370887596f832347c9d7912f3c7b1c48605adc92.1771876412.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260254-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:mid,queasysnail.net:dkim,queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 38CC217ECE8
X-Rspamd-Action: no action

When we update an SA, we construct a new state and call
xdo_dev_state_add, but never insert it. The existing state is updated,
then we immediately destroy the new state. Since we haven't added it,
we don't go through the standard state delete code, and we're skipping
removing it from the device (but xdo_dev_state_free will get called
when we destroy the temporary state).

This is similar to commit c5d4d7d83165 ("xfrm: Fix deletion of
offloaded SAs on failure.").

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 98b362d51836..a00c4fe1ab0c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2264,6 +2264,7 @@ int xfrm_state_update(struct xfrm_state *x)
 
 		err = 0;
 		x->km.state = XFRM_STATE_DEAD;
+		xfrm_dev_state_delete(x);
 		__xfrm_state_put(x);
 	}
 
-- 
2.51.2


