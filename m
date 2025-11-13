Return-Path: <netdev+bounces-238526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5AC5A734
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BC53ADC98
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35532D438;
	Thu, 13 Nov 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKGVJ7ME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31A32BF46;
	Thu, 13 Nov 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074729; cv=none; b=I7mTqihHFyHpD757blOfvG1T0pwVq1gmnBv7ABb4Swn+m1VuNQLT9M+QY/XMsBYXxILukHgdwUSjTdpf3HScAaGBhElPu111gzy/EFktzcv0Jy5m4M1KQ1gNcusYBlzuZLnQnoLt4uAFYr24TNZ2kWIyZ6bAK+RxvZT3pLAnuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074729; c=relaxed/simple;
	bh=Uz3Trca9ZTpCV9YUoTWtYYxnb6OvGUm9IW08ilnAvp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnjhdtcTmGzYgHP++Pd/iB/42Y0qFsMTNBwoAzO6P4BaQlR8WZ9q8t3jePHkeCE1FcMb5U0vIgsDGgnp2gBilRY8Ad72nu8I8cArgwdD6i1dNpk3kxGDDVreK6nNJntU5IAjjVFGZulLgNT3SQMTrdV+ih1XbilFHs5+/7BJHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKGVJ7ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199DBC19421;
	Thu, 13 Nov 2025 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074728;
	bh=Uz3Trca9ZTpCV9YUoTWtYYxnb6OvGUm9IW08ilnAvp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vKGVJ7MEfPbmtScolT3ClHJrTF29bGBGi0Yc6WaCYa+UIRrcc7IIkbqWnFWoAONc/
	 bkjmA7KeJTe54Wu/kZq8zjhntomogXEDp5/mvCJodCGQ0XulTZVhVisaT+ptOrFc66
	 HhJCr1VqXubnlmeQToNi8mVFEqEiMJSSKrbwZBAIMmcj807M0JtLUCBsq1clH4RwM1
	 tywvKX9696NF1v6lEgPGxVOBOifXBifr1z5NkQww8sU5ZnHLyOA4j1CqFWx6Frj+dN
	 Rf+yXMekdbFR4bq5KJ5x7p5ctlh1adSfZGhEAqDtqbwtOY73MlbKCJ9kvjN3+VqAex
	 uufYLFT369Y6w==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:29 -0500
Subject: [PATCH v3 6/6] rust: macros: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-core-cstr-cstrings-v3-6-411b34002774@gmail.com>
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
In-Reply-To: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 netdev@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074713; l=1049;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=e0vSwjHslwGd0YOhOzP/8wXiu2qmu3qy9oitm6tlziI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCPS1JL72zdZj264+0EKa8BtRwJlDwMayoxsHkoQuv2Cxki3YBHiVYw9lQYDoxi1q8H5XRETBHh
 X70CqYFZzmgk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

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
2.51.2


