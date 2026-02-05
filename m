Return-Path: <netdev+bounces-257178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJI0NneehGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58175F3742
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F753055BE6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238224E016;
	Thu,  5 Feb 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Pd0r6dKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPb1KrEk"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8623BCED
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298805; cv=none; b=Jrd+5GyQmISu9agGg0pgIICeW5xGycA6D0e1pN6AkgQffFMGRkBMX8kdNvG9iABdgGWr5fo+lIq70lVeRA9PuVoZ9BVTMY4Wy5dv5EzJuAnFYBJvwEqXcLOFpSOTM38IQhpmClBLfWX2lCEcFJP0R1rceP6Fwx9FvPjbyEYto20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298805; c=relaxed/simple;
	bh=n4P4bFZLuXeKA6Tgmi4f7AYufDE8EcMpO4bkBxAWTKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn1/ME4GMTfvXotd99WmT3wSZu6sq3YBxUB5sP7oDUw95GPZZWuhBq3EAaOqspjHruAXIM+/6LJZosj/pBtJWKeAcpkWlRoM7RrP9ws8pzJayKo3NyjhQXDyj4FFSkMzzYU6J3SheC0SGeHx3a3h9COrnzbjYBC0CE1/CcI/pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Pd0r6dKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPb1KrEk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 971E71D0014E;
	Thu,  5 Feb 2026 08:40:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 08:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298804; x=
	1770385204; bh=9iarM3llzJge+E0yT60dSHkUvLP0s0WYl1/IGgkwqN4=; b=P
	d0r6dKtVCX56PFbNxkaqnASBZ+frBhalJBhOuWzHeFeNOtHVLs7HZSE/fcvh+XxU
	na5o0QQTwsHwMAXfsUtNHH1W20K/Trg1drYnQsAIwSGH59wZeZSV7BLuZ5MskT2F
	W4EVPfmBuxrJujvzB3jNGkhM17CYwwyq3qEbMSRJ74y9hOAkbAVV9HzjOgoX1J/Z
	VS+lzfE9NE6gGLEISekpUljb622xG9RwE+f7oVvqZlkkQKRZPBUUjzN77G0u7HR/
	30LSwo3WM4UszaNErCb60MMmmrJqpNw3z/NGGAhjkQWgdo7Ggh2eWzR5hL4ddB0V
	AEaKTcjrva247I5ExQxYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298804; x=1770385204; bh=9
	iarM3llzJge+E0yT60dSHkUvLP0s0WYl1/IGgkwqN4=; b=hPb1KrEkkp39fBopD
	9tMe/3zIU96C7sFSpdVPBlqxihOfrRN+N9K6XmB6YCxGyxZhwmo01Q7Xm95D/3C3
	rrIR/KcGallIc/3ZgsVTz7iEY856aUA6XTaXVv33k1+YcApfI5+fnAA3f/r/nf8k
	pZHngi3zrSyx+qrhA7AfE5grOFx4CS7NcJ4SJr81OQdMdG/sON51O3MeytvN2kBy
	rYzSvar7mJIT+zGxRFYosX3reAZOqfm2BqWicq9V85mFttudgQq5JxgzsYu4H0bP
	BCkcUNqmu5luto2hcIf/U3+VZd616K/MnfQoUGh4AxnUs4QYoaYa/QfFGR4dPKBU
	s/q3w==
X-ME-Sender: <xms:tJ2EaSqJeW9gwYrttCJx9ygZ0IJ_i9MW1Q0lRD2cQhKqy5RN4XS9Lg>
    <xme:tJ2EaXChHdmv6dS1A1fe2jKMr5TE6UsZFLmGxx7GCtPiPO4oJEXjz95l8FESNOUn7
    8JVC3K8QKkypqz9lHvFzX8l9oze8aEOf6pfr49aWOzrKW8V2ZezXA>
X-ME-Received: <xmr:tJ2EaTd-2ICNPf12HHhWRz6g_uboHuSubAzmZErHb-en4UYuFpyhKNb5SyYLkJ9oiy_gmw>
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
X-ME-Proxy: <xmx:tJ2EafvGtM95z2nccN1h3rA2MUOuyuvI6zQZ7wRix2gVuk4z57AlHQ>
    <xmx:tJ2EaahFDI3cSDhxDONfIZuaMTF6KSL9c4Bj6TiH--VKvSZi_jrTaQ>
    <xmx:tJ2EaXvkWAmqXp6itPFqv3BEk9pfdGh1cmOIiAqKO-WbRlSARDhqhg>
    <xmx:tJ2EaV-tcZ3PQ9zqtQILXoJA7JHE_Dk4qJOQwgefDFVGh71He1EFzQ>
    <xmx:tJ2EafG5Uz-ScSqhNAPJAdGqheHRhKYDUwUuTK4NNS7hbtky1_CTLNN->
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:40:03 -0500 (EST)
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
Subject: [PATCH net-next v5 09/12] gve: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:22 +0200
Message-ID: <20260205133925.526371-10-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257178-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 58175F3742
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3e5a31..28e85730f785 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -963,9 +963,6 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	int num_buffer_descs;
 	int total_num_descs;
 
-	if (skb_is_gso(skb) && unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto drop;
-
 	if (tx->dqo.qpl) {
 		/* We do not need to verify the number of buffers used per
 		 * packet or per segment in case of TSO as with 2K size buffers
-- 
2.52.0


