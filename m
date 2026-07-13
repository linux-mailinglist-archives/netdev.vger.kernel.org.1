Return-Path: <netdev+bounces-307030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czy6ArCKVGpdnAMAu9opvQ
	(envelope-from <netdev+bounces-307030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F318747AF1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=Zk0zQkO8;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307030-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307030-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 820AF3031B58
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4D3911C1;
	Mon, 13 Jul 2026 06:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C236EAB1;
	Mon, 13 Jul 2026 06:48:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925319; cv=none; b=KqbYz9KnYd+2eGGNUp+zMR2t9xLVzF68f1FcwnmE5OVhY/a1ikCXU+Kr4JQ4hxNFpJgTDDxb21ITRU+FhZhcxrINVNmvZV9tOVLhFwAjNzu3jOBtUi4I1RLfOcb6pmB5lF5t7OrbPy7+/6/SYmbgcb+K/z+m5jRBc+YpGUu3HKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925319; c=relaxed/simple;
	bh=DgPxSWJm3yP+ocMCPSZPYulAvRJygW/tBHfG7di1GFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFHhkiN44YkgE+gPQLi+Ttdw+4hS+fImss19HUxsQ60fowvE+mjL02AgwaCgkMHTJNPzk0z2VJrxg8hDTjn3w9eIMkHTApGo+w5MSiGT2ETbIoQmNRL4Op9qpgC6CxlCcDvpIR36VjHt+smK0rPJ8oKflT+CaN1NpK4UmCVKcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zk0zQkO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1E39C4AF0C;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1783925319; bh=DgPxSWJm3yP+ocMCPSZPYulAvRJygW/tBHfG7di1GFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zk0zQkO8N3gbKJh5tvrFS9kZDOyVmA77DvUWiEDGtB/y7uMEjXGBdTrvfm5xgIUw9
	 pLe2zPc/shwdxyRVRIsYvnGbGhA1ztRM4tI9Z5RZtwb5bmmA3Nqp9IYmOxVNwNxUQk
	 RjT2o887E3fqiCnZalcPFZn2QjWBCQk3fWaL2+IQ=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD9C44501;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 13 Jul 2026 14:45:30 +0800
Subject: [PATCH v8 09/10] rust: macros: remove `THIS_MODULE` static from
 `module!`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-fix-fops-owner-v8-9-2495cfa82d47@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783925315; l=1808;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=DgPxSWJm3yP+ocMCPSZPYulAvRJygW/tBHfG7di1GFE=;
 b=0bMb7aggACd9FRq5WcroeqBFFGecghQ54SD2IERllW9OS+qB6EeO+kiF962Fq39UNSAHmtmww
 8MfJNW4P3nqD0RWVk6IMZZy7B1O4J5zB0OmnzD/F5/hMmDz8UHag7jY
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@
 googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_SENDER(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[47];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:email,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F318747AF1

All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
`this_module::<LocalModule>()` helper. The `static THIS_MODULE`
generated by the `module!` macro is no longer referenced anywhere,
so remove it to avoid having two sources of the same `ThisModule`
pointer.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/macros/module.rs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index aa9a618d5d19e..23b6a1b456b80 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -497,22 +497,6 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         /// Used by the printing macros, e.g. [`info!`].
         const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
 
-        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-        // freed until the module is unloaded.
-        #[cfg(MODULE)]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            extern "C" {
-                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-            };
-
-            ::kernel::ThisModule::from_ptr(__this_module.get())
-        };
-
-        #[cfg(not(MODULE))]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-        };
-
         /// The `LocalModule` type is the type of the module created by `module!`,
         /// `module_pci_driver!`, `module_platform_driver!`, etc.
         type LocalModule = #type_;

-- 
2.43.0



