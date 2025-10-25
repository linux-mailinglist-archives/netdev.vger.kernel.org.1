Return-Path: <netdev+bounces-232817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A1C090F7
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8864E5692
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B022E03FA;
	Sat, 25 Oct 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eXUCbD6z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZjCSH9F"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53001FDA82;
	Sat, 25 Oct 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761399996; cv=none; b=nIQXSTtpe/OaSpZDqJJCPsrp4MY1l5Ex2LHzwdl3bkpwnsJQBHZncD2pFVHdSLrNFRTrUfdYO1FTWsNdlbp9lwJxkq3iGIBhlMhAma4bnC1jjyjBZzBI3JNyZNa0YINDDO2QCgc+zjvCV5Umsuq56Y6+i3VByxNAOsvV4aO4Cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761399996; c=relaxed/simple;
	bh=PLH2h8aR2Zfs+u3J2KCSHSDkqN/53x9ORdlVeaqdWGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3a0ae6wrQwhIyIFOU6HOPUwRGoMc0D0NA3DgYBZV7IN/oQeSKlBDkG9RqqM0dM6zWsEbjDWvnj6guJiLPOGSlNco7QJDRDgeMtOqtBElS5QL7H1fH131EfRRBY0GPzE2LJ2vftjBGD38TuFL8BlwFPHfYkPrE/4A60HqHZW8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eXUCbD6z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZjCSH9F; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 1B51B1300167;
	Sat, 25 Oct 2025 09:46:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 25 Oct 2025 09:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1761399966; x=1761403566; bh=Mb8xNyg4KVc2AAZRCSe0v
	ulnapyIE3FuDLo/Ugvz9h4=; b=eXUCbD6zimg7QawLOnQ0VDd7GWTq4eArw9Pej
	U96PgkkfqsPwgLfHFVLWkMFLGUEhLPM7uEyHt9hTVamdJsF5Oc5hnvi7pBX7kUOZ
	0/rAF8tcOJurNF0J/Enn/ZuqqiEYcFzZSNOXLa1DrFrza6btxE4oEp7dNij/sT9+
	STUPbFMVVrLJP9F70axzlIjubcx65RpMLJaPuV03kP3skMH60HrcfTla73+QZ7kd
	3wBuje3yvNmzJonAA8yitEGqj9htf2kxJHOP3+kArpn5cIBD7co0IZyqyq1KqMC8
	9XK0phit3iyijBHfoJj5BXamDD8etSuUd5NcabTQ4Up5NCGmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761399966; x=1761403566; bh=Mb8xNyg4KVc2AAZRCSe0vulnapyIE3FuDLo
	/Ugvz9h4=; b=bZjCSH9Fo1rNSmidbI9iXIKGn1j9qSsUjxpbPBENKVWd0ntmBWu
	FB31YZkYBj6WYh6y776KePrptvYpogqrqsbevpGurb31gNvA8r/a4I+aQUFgJzV8
	IrL7iTTtdFQoHEd/1yA9s1/b2l62HuS0ONGywsUGqqiiBBiHy2T/HR/tREDGc90I
	WQxGj3igDQriH8VsRw5CvOQaavTNwY8WMS9tICbSU7qaiMo5WS8zUNRcJ1QCL02b
	p27OfwJPnKCTC/0GvsD9JqX6aJDmocLLIp68cmdfDktr+xZWCsxwZ3V/MM61/hrY
	Sq4csRGPZx/u188M33XO3XHh3h2GTmFJI4w==
X-ME-Sender: <xms:ntT8aIzZa3alzTPGXSxM667ZdJs3c0xKDX90mdW34UCa_lowHrPRaQ>
    <xme:ntT8aLNtmtroQA4_Pyzq6YJeUvb0PbV_Bktuc7KDy2FooLmzrEsQ7gQMhG_gzt_Wu
    k6kTSRsXpFwFj2lh2xbywRHVnyTSzzArztKuHwiFaSE2oxR00YBpGM>
X-ME-Received: <xmr:ntT8aGb6_WChhPxPUQJXTO2xWMgo-Ahjc1ehCPKQ-2lqpoQti_CHiBSwI5X6ISbxanNbNQm4fEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpegjihiihhgvucfuuhhnuceoshhunhihihiihhgvsehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnhepudeliefhjeduhfdugfelgeehleejjeejle
    dutdekheetvdefgffhheehteffhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuhhnhi
    hiiihhvgesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmgh
    hrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegs
    jhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhssh
    hinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ntT8aKCxBiYgWJwvcjgUIWty2kOzmSk6kuCNSKiYTfKR5Om0Lm4okw>
    <xmx:ntT8aMEwgQr6GPoXpPi4E01AjT6IKFmnvh2n5-2jNTJ4QrsyC8aOwg>
    <xmx:ntT8aNMyZvWFft61azamWJzV9m4vdAUShWSpuP257-TxvWsLJ51EKw>
    <xmx:ntT8aFiVZNalnbrxpp5aa1044Peu5tgiwLzV0GbKc-ES7KhytW7t7w>
    <xmx:ntT8aBg_qqc98wX6rw8VUBovt54hOytWemao9feyesc2iNrByd8QiUrF>
Feedback-ID: i1736481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 09:46:01 -0400 (EDT)
From: Yizhe Sun <sunyizhe@fastmail.com>
To: fujita.tomonori@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com
Cc: tmgross@umich.edu,
	netdev@vger.kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	dakr@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yizhe Sun <sunyizhe@fastmail.com>
Subject: [PATCH v2] rust: phy: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Date: Sat, 25 Oct 2025 21:44:26 +0800
Message-ID: <20251025134516.40302-1-sunyizhe@fastmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <lossin@kernel.org>

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Yizhe Sun <sunyizhe@fastmail.com>
---
This is a resend. Original: https://lore.kernel.org/rust-for-linux/20250814093046.2071971-5-lossin@kernel.org/

 rust/kernel/net/phy.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bf6272d87a7b..46c693c5768a 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -553,9 +553,7 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
-        // SAFETY: The rest is zeroed out to initialize `struct phy_driver`,
-        // sets `Option<&F>` to be `None`.
-        ..unsafe { core::mem::MaybeUninit::<bindings::phy_driver>::zeroed().assume_init() }
+        ..pin_init::zeroed()
     }))
 }
 

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.1


