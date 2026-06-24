Return-Path: <netdev+bounces-301647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rHaHM07UO2ptdwgAu9opvQ
	(envelope-from <netdev+bounces-301647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F16BE525
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:57:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=jkJfBuFe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301647-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301647-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E411B300E317
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78F3B47D7;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34073B0ACD;
	Wed, 24 Jun 2026 12:57:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305855; cv=none; b=D6SBEMI0JeTKHNKDt105nTx53SHgGDL5NPRWOB0CWp2frk3DPXqf6KdSZcamNJdE12Y9L9YViRHgLbahZcnW3hlOnwvBqoEL+0FVlmW+rs2QlfxGuJ2TnVp3UcmgKMdFBlrWD2MqAbU2fxqeXDUXzoIm8kccYzqdQE55Vb6QyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305855; c=relaxed/simple;
	bh=C1FMa0qVq/S97m9Viz8hjYFdAfdHoRPHBepu6SriAjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtJnMzq96iwUS6TtcDXLFa2M8cSLd2MBh59+HQlR73VCohVsZlr0DDi1t3liwN7+EGUAuCVVSK8eBN3Gg6tP1GRhVwTdOZvxDMHN7bFyRekc/SboJlbh4h/FBVva2j9romdV5f0kcNv7l1Px+cQHFNKGMNBUqmorpVwbJbbGr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jkJfBuFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8FC0C2BCFD;
	Wed, 24 Jun 2026 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782305854; bh=C1FMa0qVq/S97m9Viz8hjYFdAfdHoRPHBepu6SriAjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jkJfBuFe/8OMp1vAA005OsCZPleWruMZP8xca8HdCNBYV1Lsp7Z/e0GbMZxXSOCop
	 MrsjaUK2NTYn8H4h1wCiSy0dAATnVOkbyqA7P60JIse1iozDPX02U2JhyA3Oq1Jc7x
	 8xKok985UpOVFsCm87IzCDM8lD/O3X0ByUXfsagY=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F8CDB471;
	Wed, 24 Jun 2026 12:57:34 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 24 Jun 2026 20:57:27 +0800
Subject: [PATCH v5 4/9] rust: macros: auto-insert OwnerModule in #[vtable]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-fix-fops-owner-v5-4-aa1cba242f05@linux.dev>
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782305851; l=4532;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=C1FMa0qVq/S97m9Viz8hjYFdAfdHoRPHBepu6SriAjU=;
 b=9JbBVO62bRF1oZq4pLp3gXZXlduyLuXZnVVNLfIsbS3PJ0IOfJfxmhONrS2sg7HdI4fNh2yHJ
 lZIP9h7jPtFCEFEw2vSnRUxDocgc28PPsE025Efx9rci0QptAo/fREc
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301647-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE2F16BE525

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



