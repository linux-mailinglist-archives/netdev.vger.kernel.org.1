Return-Path: <netdev+bounces-307020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1PiKEqKVGomnAMAu9opvQ
	(envelope-from <netdev+bounces-307020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E2747A2E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b="Nk/H4GWE";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307020-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BBF830078AB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE03655DD;
	Mon, 13 Jul 2026 06:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A17A300;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925318; cv=none; b=oRl1LnOrfhCvn3mSqeTsL8Gb1X7mvFfoSnKVvXKY+WJG+T367NiizO5bLGVd+VKokZ8r0ukXMnjZLSwCLIunHlVAQV3EvistuSXIgF0RnB678DP3voR82OD6PVCX7MHyn9zl53dnP7FyzOqWASGYFm00xFFGFX0bPgJpO4b58Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925318; c=relaxed/simple;
	bh=aF47iLMPZHY8ikZj0/3fPMH5Q4mRqmYCLQexdlk5/mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM2NaLYTX50U/xxxow8Co3xi7FKy3Jd2dx4qGNtMMxPlnnMvvAeYDNH7rFHY1pXzmELRLrEYfRN+9SwAQyX86uhp27yqKJ8aMVuuEzk6C4Udq+YBzci42Hbdwaa6wXF16JLscvhLCK8Ligtz4anISVrTk6mLcJlN/wm2pzNzBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nk/H4GWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF08C4AF0E;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1783925318; bh=aF47iLMPZHY8ikZj0/3fPMH5Q4mRqmYCLQexdlk5/mo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nk/H4GWEC1G3ljwWjl/RPZn81zppqgdCuFj/5IPYiYXeNvKHJTSZHFIiNZz6JJw+o
	 rXPZmS7XHUcvDY5Hny+iOmhuIaUDVXZshwLwsrOEQXadqbFOZZ76je6jrlE7Cuv5qK
	 eBYuIcTbMfr2qMy4ZYo8ee1ARl+8CSOWcpqzxV2Q=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF8EC44506;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 13 Jul 2026 14:45:23 +0800
Subject: [PATCH v8 02/10] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-fix-fops-owner-v8-2-2495cfa82d47@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783925315; l=3594;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=aF47iLMPZHY8ikZj0/3fPMH5Q4mRqmYCLQexdlk5/mo=;
 b=KD3Zyzbn7jRK/dQ8MUOgMLyaZFAQKRhRfDNkn/mVbczDhNcrZ237isvWV08DsrpsF3AMGxM20
 7WzG/DPMcw0BvnQ8Tpl9jEZ2eFDxId3TevKsipUYKKjPOxnBesfhmpL
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307020-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 398E2747A2E

Since `const_refs_to_static` has been stable as of the MSRV bump, a
`ThisModule` pointer can now be used in const contexts.

Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
can provide their `ThisModule` pointer in const contexts such as static
`file_operations`.

Add a `this_module()` helper to retrieve the `THIS_MODULE` pointer of a
given module type, and update `__init` to use it instead of the
`THIS_MODULE` static generated by the `module!` macro.

The `static THIS_MODULE` generated by the `module!` macro is retained
for backwards compatibility with existing users and removed in a later
patch once all references have been migrated.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/module.rs |  9 +++++++++
 rust/macros/module.rs | 18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
index be242a82e86d2..d713705984477 100644
--- a/rust/kernel/module.rs
+++ b/rust/kernel/module.rs
@@ -42,6 +42,15 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::erro
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
     const NAME: &'static crate::str::CStr;
+
+    /// The module's `THIS_MODULE` pointer.
+    const THIS_MODULE: ThisModule;
+}
+
+/// Returns a reference to the `THIS_MODULE` of the given module type.
+#[inline]
+pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
+    &M::THIS_MODULE
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e2075083..aa9a618d5d19e 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -519,6 +519,22 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
 
         impl ::kernel::ModuleMetadata for #type_ {
             const NAME: &'static ::kernel::str::CStr = #name_cstr;
+
+            #[cfg(MODULE)]
+            const THIS_MODULE: ::kernel::ThisModule = {
+                extern "C" {
+                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+                }
+
+                // SAFETY: `__this_module` is constructed by the kernel at load time
+                // and lives until the module is unloaded.
+                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
+            };
+
+            #[cfg(not(MODULE))]
+            const THIS_MODULE: ::kernel::ThisModule = unsafe {
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
+            };
         }
 
         // Double nested modules, since then nobody can access the public items inside.
@@ -616,7 +632,7 @@ pub extern "C" fn #ident_exit() {
                 /// This function must only be called once.
                 unsafe fn __init() -> ::kernel::ffi::c_int {
                     let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
-                        &super::super::THIS_MODULE
+                        ::kernel::module::this_module::<super::super::LocalModule>()
                     );
                     // SAFETY: No data race, since `__MOD` can only be accessed by this module
                     // and there only `__init` and `__exit` access it. These functions are only

-- 
2.43.0



