Return-Path: <netdev+bounces-249598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0AD1B650
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C03B83012A8B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124F32B9A2;
	Tue, 13 Jan 2026 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="dGc6uadj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="quMnz2F6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1206318BBD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339680; cv=none; b=h4WFOGSwLf6MSsA4uq8jCDeWgD9CKTTU3oF0H9xjlk47avJ8sxPZ6A3LGi+cvdWwb1LOkDVzknJJrTpcjpy9CYi8R0qzTWDXhuAksO4ErxMPCCziBacZrO5OmEuNRtUs1Q8BJzjLqI2w2Ic+PnjBou8KLWonI0pS3vpRNdZnkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339680; c=relaxed/simple;
	bh=N5aKORNlj5ujw6KwgwON8Em75AVbFCjukOYcsZT4xDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wst9zEqrRF+ioTfOJm3yD3DqhtHRFeQwIuVkf/4NwUj5VLnjnlZIuCwybhlgPrwbvYSD4ke9UD5iYPhTMddPJu337hlYWC8l9dos8MqqFOLvqedXTuf9VIx3JFjcJLN9HZRz+1YqU4eLFO5LO906xfDNSGR+1Hxlgv4LVpYmLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=dGc6uadj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=quMnz2F6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4202E1400103;
	Tue, 13 Jan 2026 16:27:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 13 Jan 2026 16:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339678; x=
	1768426078; bh=RnjZYUfz7D1Y+lW98SIindux16C2i1ddTXpFJ7KNWtA=; b=d
	Gc6uadjbw/2LogdxE03BDDTtBzwkK88+PBqWMHZvEpwhpkldi0WNQ3YUnaKAhWpe
	K63LR4WAePb4CodFtraikzCTu/L2GiNGItelCae1k1BJtBCrS5trmCHL8B8g3wEO
	oYn+/CJLK1M3/TXZVhWv+uDNlKiL9K3qNVTg+vNBai+0cUPPoNGuMS/EzuH2jZcT
	deKcWA1iCAg4UWiJsw48RFkpwKFM1jB5tbE1SQkB2Dj3JQQ76S4tva+bzwMHXxad
	1aAQVAoF1GQ6YyW9NdmNBzp7OzVCIH3AHUZC33pwk3i2yEJ2MW5aQEjmj5A23VAq
	7+lDbCB3KXv8XP+cHEiYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339678; x=1768426078; bh=R
	njZYUfz7D1Y+lW98SIindux16C2i1ddTXpFJ7KNWtA=; b=quMnz2F6qjyGkEoM0
	7mwOtPJMk9thQ151o+zaQeqrEwwhK/67fctv+gp19nMw4peqOSY5rxmxw8+sQ8T9
	NFyDA1fr1z1DeQScZjEG7uzeNu8YLIiNQoyXVzccEfK23pcvCoFmueiCY+Xz8fMa
	t6tdmdC8AtTDwS4aik0tG82z7dnAweJIR61up89DaG8PaoP1xSO4lyZdc+dMPdXD
	wv//hWnkHA3qaQEWJqCFEdsNojn5qmBiHjr8FoSkP0bzA7TTxHbVQanj3VXiEIew
	keJM6Z3XOv2nD1dZkMBs0qhDb24bLxCoOy9v0s3zyVjs5WU6yJaQGyNI87vnlP8r
	rfuxQ==
X-ME-Sender: <xms:3rhmaXD1EmNW_F8NxIoTRUPFvY_lqaOPFAp5YJIytM16-FM9h2VBGw>
    <xme:3rhmaT6fP-3RyVeWsjgiVOXJDG9xdBeSPaZtXn9CiwBBvSuBuh61awQ6yZB9HH2gp
    RYzv5mOn1oHjWorIagFgcTvdRsRY5dt9pYRMgxop3GqNM00dIlViQ>
X-ME-Received: <xmr:3rhmae2iQDsJhiS660jRhFT0T5U96x-HuCCFLqO4ndueEFmtB8CNRUHA5rDFS24i-QBbRjO3bhElDDo-vT3KGKIV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3rhmaXnsz2pjvu0ZKOtQ_TGxBKUB02ZhFb7M-L_QiKus1e-3x-NDOg>
    <xmx:3rhmaU5wcs_XX511AQzxa_B_PBsbWcmu_q021pJjADYPz_AQACxx4A>
    <xmx:3rhmaSkxMl6TfP6yNP8CTbG9Qcvv-nRDqLKOdTHnfTwVU_A6T3paTw>
    <xmx:3rhmaXWnQ40Aa1vTYjC3XSGRvMrTToCDuPPso-ubdtV3a5o4jHQ6NA>
    <xmx:3rhmaV-5a3lq250J2cAeplPwRK0F9qcMe8wxMC2RmOo38edHIgI3hKiC>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:57 -0500 (EST)
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
Subject: [PATCH net-next v2 09/11] gve: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:53 +0200
Message-ID: <20260113212655.116122-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
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


