Return-Path: <netdev+bounces-56064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894180DB18
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087EFB214FA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B6F537ED;
	Mon, 11 Dec 2023 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e27vGHA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6852D0;
	Mon, 11 Dec 2023 11:49:17 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f48aef0a5so137706085a.2;
        Mon, 11 Dec 2023 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702324157; x=1702928957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xRTxUySr83Aygmkx4VsMsm0mAvQ04JjTvrQzs/EardM=;
        b=e27vGHA6qCP/MV6U0ASaTTeWzaFO/047a5CZ/6TB9VHz0i1TSp67/+eLhlDVbA/F5U
         meyQ7r9/IxXvbHlZPW1f3RxTg3nqxm3JCtcQl6ANhZPr+m4OTy7QPWUUNblWan68PW5t
         Ay4S0df9/5vxa+rF9rC+DDimYXKiJw+/bPW2bggqkojuopkpsVokx+11eEzQ0BPNp65N
         pcNiPLU+0hr65Eiyi1aMSUy38qsFypckHj8N2rJanGD9drhiDBb5Ry01VinrDAkM0Vtw
         M63L1DsHx+f7wlsMWRXNqex8FZxo3e7qPljR0kAkMLOEeoWofsvEnF4Ytg+rwtGDjQdJ
         Vuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324157; x=1702928957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRTxUySr83Aygmkx4VsMsm0mAvQ04JjTvrQzs/EardM=;
        b=cfMjjpQnDCmo3nEMcH0DDAIKeSgnxlT1FEkp5X5OxNfMpXYM8Ro+Q4vZfXzQgzsHb3
         e1oIQA/Vw7eEXocbrvLNN8a1URscEzff21RgjXMcL133cK4uLmnjpi8vpWnpKvFzv47Y
         ipvR+ILLzKFl7k0Ud2kof5W76rYISwEtfW6ZoZyoYyZ4B7qgzyiy474T/Fm9UjyHlF0k
         QsM7T6mRTgzGHusNGm9Ls8taubmnZ/JJcR4SmZ6ro/v97TI63BI6hExSLpzMaA2xFxrX
         TuDL+tahCOwvpIT/1+2peyvDPHwzAB1CajVEySk6wzmDconQ+nker2Uk/sWr+QMPhS14
         7utw==
X-Gm-Message-State: AOJu0YxxPAG4voWlrbF1kZ46GJ6dMNEJZDOaSOgp+ISoY4V6WhSLomfq
	9qIJPJsRD78cdf2mC6orLic=
X-Google-Smtp-Source: AGHT+IGpHNSzaRXsJN+0Au1dVddIitZAoPZ9NXMMkVojugaYlS3QbKhKMRJmUVhA8mcPhDiACqhajw==
X-Received: by 2002:a05:620a:4095:b0:77d:cd78:4c7d with SMTP id f21-20020a05620a409500b0077dcd784c7dmr3580319qko.60.1702324156910;
        Mon, 11 Dec 2023 11:49:16 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id rr17-20020a05620a679100b0077f0ae46fd5sm3178569qkn.16.2023.12.11.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:49:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2700527C005A;
	Mon, 11 Dec 2023 14:49:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 14:49:16 -0500
X-ME-Sender: <xms:u2d3ZblWe6UIt2hRwBiUtddo0LlgsPB2ljFUzFa2UDNdyrDekZ9dZQ>
    <xme:u2d3Ze0-8O1uVzTgxvrZ93JhbrN18DYQFyGELQb_eprSr5fCyYzR4jQ9RQw0tuN2U
    eAeQUpddCoPKipU-g>
X-ME-Received: <xmr:u2d3ZRoRsKf4QbeEasREqnzU00Vi-Zn_otD07cB-ptdfr1t96zobnn2bYSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeiudehvdegtdevvdelveejvd
    ejjedvkeeufeejgfejleefvddvieeuueetgeettdenucffohhmrghinheprhhushhtqdhl
    rghnghdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:u2d3ZTkQMCq37jJgcBjelAOJPc3s4ctpgFqaKWIZQZtEzs27GSs7WQ>
    <xmx:u2d3ZZ3i2cNSS6UJSZ0uOV0xnOW4dtVUcp1nJbcF3YjAiW008FZ5cg>
    <xmx:u2d3ZSsnAbV1pRnBQpAwq6eEGvk9HyGbicVIXdhtW6r0rJDLRTd9fA>
    <xmx:vGd3ZWleS6AcZe8SWHXuh2vmItDuOBnCcmo0rXyD-0wAchnE6z5Awg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 14:49:15 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: [net-next PATCH] rust: net: phy: Correct the safety comment for impl Sync
Date: Mon, 11 Dec 2023 11:49:09 -0800
Message-ID: <20231211194909.588574-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
References: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current safety comment for impl Sync for DriverVTable has two
problem:

* the correctness is unclear, since all types impl Any[1], therefore all
  types have a `&self` method (Any::type_id).

* it doesn't explain why useless of immutable references can ensure the
  safety.

Fix this by rewritting the comment.

[1]: https://doc.rust-lang.org/std/any/trait.Any.html

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
This is a follow-up for my ignored feedback:

	https://lore.kernel.org/rust-for-linux/ZV5FjEM1EWm6iTAm@boqun-archlinux/	

Honestly, I believe that people who are active in the review process all
get it right, but I want to make sure who read the code later can also
understand it and reuse the reasoning in their code. Hence this
improvement.

Tomo, feel free to fold it in your patch if you and others think the
wording is fine.

 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index d9cec139324a..e3377f8f36b7 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -489,8 +489,8 @@ impl<T: Driver> Adapter<T> {
 #[repr(transparent)]
 pub struct DriverVTable(Opaque<bindings::phy_driver>);
 
-// SAFETY: `DriverVTable` has no &self methods, so immutable references to it
-// are useless.
+// SAFETY: `DriverVTable` doesn't expose any &self method to access internal data, so it's safe to
+// share `&DriverVTable` across execution context boundries.
 unsafe impl Sync for DriverVTable {}
 
 /// Creates a [`DriverVTable`] instance from [`Driver`].
-- 
2.43.0


