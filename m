Return-Path: <netdev+bounces-307025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfDyGJ2LVGqrnAMAu9opvQ
	(envelope-from <netdev+bounces-307025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:54:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A5747B78
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:54:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=wCTgDKeW;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307025-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307025-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EE7305662B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE1390C9A;
	Mon, 13 Jul 2026 06:48:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395F369D6A;
	Mon, 13 Jul 2026 06:48:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925319; cv=none; b=YIdHdP1A8T8x3eRu43L3DaB1q7geJvA8S3seeHsaSt1WXc9kcctacWlvi7Iccgj4CzqBNOF/S6OwdXrASpgMeVPqfozdKWUFyckus8yPbcdVRaBdMUkTTS1hq8z3xkqpnJtZUBT3gTUsJlnF0jfooi9Npk5WadpYu5EMDSmrif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925319; c=relaxed/simple;
	bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntiU4tNpPbIi1MI/E5o1zEuXW4XTXYbAe2NAPR3Jd00mpm1aV2ZTOMiSLNT1HfTpRZTkI3gAbdlNFL2wrznMzYkAviV//Q5MTy/G0fEsWZlyR8EMnUA5H1UzsDq6JoMN2PxWMq81CVIwhW+rZoBrLULidS5s+6FLN+63qW53/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wCTgDKeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EDDAC2BCB8;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1783925318; bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wCTgDKeWarJUCl8AkeL/m3xRdDD9ELnmc8S3O7t0K5GjGAeyOy4DP5lA7FgjRAHFu
	 kBKLIz9q+Hu2LoEbS64ZjvcDxuiVjwYfl+vDVnr+v1Faj6m1d58OHzMSPuSccczsaj
	 Nw9PB2CZyadHRBCnJUHD6jzml0NIiGWP1ALQA0KU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A76C43458;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 13 Jul 2026 14:45:25 +0800
Subject: [PATCH v8 04/10] rust: macros: auto-insert OwnerModule in
 #[vtable]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-fix-fops-owner-v8-4-2495cfa82d47@linux.dev>
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
In-Reply-To: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783925315; l=4578;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=iQHGWPaM+K+cKo+H5JDtUc/37urf23KbdiF6XVV5Cf0=;
 b=7OZIrzLAHxzmcofhzJzheThoFHX9outNCA/o4INLUP1uS7dQdE1ujWjY9Yy5iD4BFZDZiQDVW
 bvN7aol1F1jCoxPO7xyoLlV6U1Ka9Qk1iBE5GqKe6MGeKkNBZpQwP0n
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307025-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@
 googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B50A5747B78

Auto-add `type OwnerModule: ::kernel::ModuleMetadata;` as a required
associated type on the trait side if not already defined, and
auto-insert `type OwnerModule = crate::LocalModule;` on the impl side
if not explicitly provided, eliminating the need to manually declare
and implement `OwnerModule` in every vtable trait and impl.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/all/DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/macros/lib.rs    |  6 ++++++
 rust/macros/vtable.rs | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7c..bc7ded353c5ca 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -176,6 +176,12 @@ pub fn module(input: TokenStream) -> TokenStream {
 ///
 /// This macro should not be used when all functions are required.
 ///
+/// Additionally, this macro automatically handles the `OwnerModule`
+/// associated type: on the trait side, `type OwnerModule: ModuleMetadata;`
+/// is added as a required associated type if not already defined; on the
+/// impl side, `type OwnerModule = LocalModule;` is automatically inserted
+/// if not explicitly defined.
+///
 /// # Examples
 ///
 /// ```
diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index c6510b0c4ea1d..be9a5ed8abe5e 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -30,6 +30,22 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
          const USE_VTABLE_ATTR: ();
     });
 
+    // Add `type OwnerModule: ModuleMetadata` as a required associated type if
+    // the trait does not already define it.
+    if !item
+        .items
+        .iter()
+        .any(|i| matches!(i, TraitItem::Type(t) if t.ident == "OwnerModule"))
+    {
+        gen_items.push(parse_quote! {
+            /// The module implementing this vtable trait.
+            ///
+            /// Automatically set to `crate::LocalModule` by the `#[vtable]`
+            /// impl macro.
+            type OwnerModule: ::kernel::ModuleMetadata;
+        });
+    }
+
     for item in &item.items {
         if let TraitItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;
@@ -57,12 +73,18 @@ fn handle_trait(mut item: ItemTrait) -> Result<ItemTrait> {
 
 fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
     let mut gen_items = Vec::new();
-    let mut defined_consts = HashSet::new();
+    let mut defined_items = HashSet::new();
 
-    // Iterate over all user-defined constants to gather any possible explicit overrides.
+    // Iterate over all user-defined items to gather any possible explicit overrides.
     for item in &item.items {
-        if let ImplItem::Const(const_item) = item {
-            defined_consts.insert(const_item.ident.clone());
+        match item {
+            ImplItem::Const(const_item) => {
+                defined_items.insert(const_item.ident.clone());
+            }
+            ImplItem::Type(type_item) => {
+                defined_items.insert(type_item.ident.clone());
+            }
+            _ => {}
         }
     }
 
@@ -70,6 +92,15 @@ fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
         const USE_VTABLE_ATTR: () = ();
     });
 
+    // Auto-insert `type OwnerModule = crate::LocalModule` if not explicitly defined.
+    // `crate::LocalModule` resolves to the real module type (via `module!`) or a
+    // dummy fallback in non-module contexts (e.g., doctests).
+    if !defined_items.contains(&parse_quote!(OwnerModule)) {
+        gen_items.push(parse_quote! {
+            type OwnerModule = crate::LocalModule;
+        });
+    }
+
     for item in &item.items {
         if let ImplItem::Fn(fn_item) = item {
             let name = &fn_item.sig.ident;
@@ -78,7 +109,7 @@ fn handle_impl(mut item: ItemImpl) -> Result<ItemImpl> {
                 name.span(),
             );
             // Skip if it's declared already -- this allows user override.
-            if defined_consts.contains(&gen_const_name) {
+            if defined_items.contains(&gen_const_name) {
                 continue;
             }
             let cfg_attrs = crate::helpers::gather_cfg_attrs(&fn_item.attrs);

-- 
2.43.0



