Return-Path: <netdev+bounces-232808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE5C09072
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE22188B7B1
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49292FBE03;
	Sat, 25 Oct 2025 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mnSgGn3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aivx50Lu"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAF2E8894;
	Sat, 25 Oct 2025 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396197; cv=none; b=RNB/cYFI0AD+sgx32pFx2q6ATJ6RbGLvYjNa1Y973rHKfaq1X80e4uh1T7YO8ndZWOR7lsfc9rpgzPbVmagA+jTxf4vcF2mtzX6hLZZSEcQcZsKpb3hw2Ewz4vYf5k1aM8KWmdhiHH+8Jq+cQco0rIXujeIhKDyyk25Msd5Br0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396197; c=relaxed/simple;
	bh=3TvDjbq4mKxAYjolp70z7LwGV2DiC4QHoYxb659SfR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2N9ZD6c74v7nedX3oPDwiyYDm0IiSWGBaN5hrEKkC7Uz54OtgMoFMMU4FRGxziSnCZtxJQHIbwuYEoY7kd1jJBbv8PWXlEe3vh0w9S7JTRrbF48no2JweynfxBa1S5Nh22ajVtSCDTEl4LYMQ4SHdppMTWtTckhIbvALExa6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mnSgGn3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aivx50Lu; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 28A3B13000F7;
	Sat, 25 Oct 2025 08:43:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 25 Oct 2025 08:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1761396194; x=1761399794; bh=zAFQucylvBENicdiTBkdA
	9Z5rlZ3eaoQYdr+2ewyF+8=; b=mnSgGn3ASF+MeFqjqtTJoYkF0yx3fvXo520AS
	4fpf/8fONPrgqtf8m4zgzagFnJYlwH95gD5BV8dNTA8e5U/3gVEVF+EimZ5puX7i
	8+yw4mad/yuMsBTOVqwu0+ymcOedfh6p9NbjkHrPveRY/oUftLLAZPe3Sv5BisDJ
	geghPZh8aBtPJtFcBNTOgQMMUwVu5dXkuZ2vOzD5HT89++PZOMHx4NDq/ibwqUuR
	Iyor8jMSwjlcdGdtfhJ55tklqHjGfJsuNGB9ymaab7iSl+bEK5CDa/tssHG9g4Yf
	k0F19QPMJdFx663vn92aOkQDkbmImbSzHfGHlN0N3jsmA9ezA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761396194; x=1761399794; bh=zAFQucylvBENicdiTBkdA9Z5rlZ3eaoQYdr
	+2ewyF+8=; b=Aivx50LuPTohrcelggQRiRRrh+5TFhURGovTc/M4yGQszi7MMtw
	5JENZkCD3i1mty7JElPAe2fNgn3H1non6AstqgDupiCyTP7WrXeCrBBCIHY26qQM
	v2d4WL+yoFp/hylZA875nagiScONnaDOGFupGhmNGCUekFlixDJSHJsgQk3ansbB
	0G0oqAEZFdFRpkVLUbbWZuodhiQo6yAYhYGjCxOZQuSXsIhfQcE/EaDwU9IDASf+
	9C/19Cf9mye1mJgK8E9GW7jrpFue6NX2PlM0WPzkbqjEU8BkDIZ2U0xNTSCRuC4S
	a0QgdQ/pb3CjRk21WDND590VRfu5k7y1cMw==
X-ME-Sender: <xms:4cX8aHNHjr2Z-NZ_E8vbQL4Oo44V66HMQwHeVzfFChZTAIfvfuN6Pw>
    <xme:4cX8aBbiMD2eHqfTBkTEfqDMMhrh6aTC6DVG4BRuEiDtZJLiLjFATpR1kqxZlcKMT
    7d_tqGlszvjSu-N9zrLIrgoEdCOhpQbmyPexLDahEXRJmErDvoTs8w>
X-ME-Received: <xmr:4cX8aHUMYw22Rbv83heAH7nn8vr3e6BbpWa1ZnHqZUCUxvxYIq5MXxAAgp7AlFMxfBzmtyMElBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpegjihiihhgvucfuuhhnuceoshhunhihihiihhgvsehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnhepjefhffdvfeeigfegueejuedujeduueeugf
    egveekuddufeetuedtfeffgfdvfedunecuffhomhgrihhnpehgihhthhhusgdrtghomhen
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
X-ME-Proxy: <xmx:4cX8aADf49XoIH9Ttb1IAe-SpzNbxBY460hFqHJpejWNE1BkdFJ1mQ>
    <xmx:4cX8aDJjQ8GICWH1jpQ8KRST2DkorhPOJns2apwbatvuvSpiie9Vow>
    <xmx:4cX8aOv3efnRBo-FcK9xxgfTEngMhmAuyWNDAPcsd0rJNqrEhPpkRA>
    <xmx:4cX8aLW7-j7QkvOADOEy07-Gj5lf9K0F3KlBOQd27Rjfi8b4RgZpPQ>
    <xmx:4cX8aHwyWRxciF3klThowkMB6cK9lpPBgJuecCwTcBqevhnt-D4Yx4YK>
Feedback-ID: i1736481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 08:43:08 -0400 (EDT)
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
Subject: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Date: Sat, 25 Oct 2025 20:42:18 +0800
Message-ID: <20251025124218.33951-1-sunyizhe@fastmail.com>
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

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Yizhe Sun <sunyizhe@fastmail.com>
---
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
 
-- 
2.51.1


