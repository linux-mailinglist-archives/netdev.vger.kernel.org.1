Return-Path: <netdev+bounces-226384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53004B9FC15
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422EE4C691E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C602D2491;
	Thu, 25 Sep 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcYXPhQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA72D0C88
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808520; cv=none; b=kypncxJAQoQWaQaLWrgupSm9hT50ZRfgHci1oabZ0RG/kBUHSK6uCCa65uPkoXyF7d67No6e2OfQL8H/dLff9gRGTCn2fHIKIdrWTvYgN6a1D77zN9r+WSL0f8yhFYufZbF8nNmWIbYWubbusDiot0OrwaOgEAbqj9bapsy8y1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808520; c=relaxed/simple;
	bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtYIref3aZUPJQK74Yhi9G6RAGouzzrl/GEbf8HQprztWoZTxjP8oH9qCqH14DNXuM20wjDKQ1+jz3Spd2rffew4geGTXhre5HweSVPGjeCQVnbTAcDAqmuzJZdtwEbDrrtNXDubH6kp372r9qIIqNJvduzFFqAIZQVgUORtU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcYXPhQt; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-796d68804a0so10063916d6.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808517; x=1759413317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=EcYXPhQtkXXRN7OTov2ez9YRzmFF4pdKpT+1C30EZOesc7+986YR52Y2wti6MkR3c7
         E8wqFyf8rFflFZMsomMVUqAqz1qa0lDKweu8x2Hwoi6G/KLwNmWUHtKHWknP0LAKERIB
         qMqkB3kyT1A+QER7Kwr+6/CqyEx6z9jkqLgfoFYHFadzVK7y7OSjSIg98jsY8qrT0iKu
         Jq8vHlWdf7tS/YJ8nkzFo6oKXWOe71Th1wxLuNx9NUXVG9DVNzfkDe4ESx9qcFPB97zB
         lGGXENCy1LWY6NV0oA4kkcAspPFsx5oGFhffY8U2rg5Sdkp6fhIg7Es67gPHi0HRhYVb
         TcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808517; x=1759413317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=UE/5mxze6PNRhta5zJ9OzkLAuCwiKt9SJOvUTcjhuEGeDS3ykFibu+5jOY5aRW8NnY
         GWVz7sYqRmcy+sTJWVF7V63gxfamHdSfMddMQYsvWcxZjR5hFYx1RA2iq1TUhLqg+Zqs
         NbY2FJlh+TPTiSsCBYtKI8Rlak9dEa7k2gbwY7cOZXepy3RgLRL3lz26NcxnwQmV3FhD
         53BU8rCimgdjjTmjx09egtrcow0KGhK0FHgf16wHdKqiDqSKIR0YtwaUWVS75P1Udqbf
         VrWLV+44mUj5fc3VtdbryYqz1ct6l9L6yhwNREfWKMj3/pH7UqpQFZbCsjss+2ymaOCn
         d8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXtnUUUHb/9mMxcN4InFySIlnYgL9XjOUREjuIFCfOCq4q8FkHa/3FWH2sNZxUhtAppCbVDONk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeZ53yEcy6YJT6eCViSRH0nUpPKV9NdnqriPbGA+cCrHKdCAq
	w0JPtpslc/tQNUhO3KNmnWrU4XzeTH3rkiVUJCh8P8RctHllrwljZc/P
X-Gm-Gg: ASbGncuW4wY+qwqCWLrpZY438mbcMGd+EEDZVkijUY4IKmtFsPBmMqFr6/5YHDUJuC7
	WzsLzEdT6qdTxefF+YMaZBiAITNA3QuTUKc55Ec3/SGAwNkclr5EF/VVSe5vJErvTFy4AfQSD+T
	mh4eIxvzrIOAnt+3gmMZ27OofypzA2pp5F9VdjDFeXMNxSPVy+Gz/+l8H853gSkN+u7ewlznM+r
	zd7NHG/JgqgSfIYqGsH9AQmulZwjUIJ5Vh+Ttpi79X9ZM2XkMy6eXr7u3T27+1C8PhLV+IN5Tdb
	BZO5sGnFB7sHCIH3hxdlDm+bBUMWhnKFIBCpD0tixa/sKgK3lyOPc5u8M8pD1gXxUiaFPtQlM3G
	YNapUpTk99dRlplcqFRgnV5u3d0hw7kO1mCQRgVtojS5hE1GTdfS/y3FkW83gvoHvyB8oWHfxxO
	clokORANuWHCKDFqSsQaYZ5SwDa8Ki+268WGcG2LcP8+O4as4C9HVGsIMagAoGlZwua7Rg
X-Google-Smtp-Source: AGHT+IEZqYEZb8mISdLJuHBwRf4k0Tn3piTiphxdju20VgZskXS1fQZSSYTbb7BgZgibnFeCDmQS/g==
X-Received: by 2002:a05:6214:27cd:b0:78a:e10c:1f6a with SMTP id 6a1803df08f44-7fc2864221fmr42029446d6.1.1758808516914;
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:58 -0400
Subject: [PATCH v2 10/19] rust: macros: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-10-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1049;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIVNC06tKtgyxIKxAK3EObC8MiCaZE3yn180AX/LsynQ5F4vys0WrFsiwfjmzPM+0UA7iPHoZU6
 G25wrGtAh8gk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/module.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 5ee54a00c0b6..8cef6cc958b5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,7 +228,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = ::kernel::c_str!(\"{name}\");
+                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.

-- 
2.51.0


