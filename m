Return-Path: <netdev+bounces-307023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SSnXB3CKVGpNnAMAu9opvQ
	(envelope-from <netdev+bounces-307023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:49:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9312747AB9
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:49:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=BXVjhzeZ;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307023-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307023-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EFC5302BBB3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C036A358;
	Mon, 13 Jul 2026 06:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A632FE07D;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925319; cv=none; b=r5rCK0XTI8iqW0HiroxfRjFV61qfiGWUOFrxuCufpJuyY4JhXXIf6veWQD1wRf5XXHM70JH3QEvQgiDFi2AJ09Rilnp0MDp4/XUS+gBebO66sWSMDtfw1Nh3752c/ycNkoejc2p4BCIXspDQUfn9h3yuYxephB87OkwieXZiQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925319; c=relaxed/simple;
	bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjVha5/Wa7YbgZlo7ui9LUl57vT6v9fGu6J0iTkBlCVkrGqlEhdcjUb5TjT/q0DaEI9Mk4VKajsd8YMc/bkwNJq3p4htx/8sUqjEbMRkF8l5RePwi+GH30zfGx7AnBk1vqmiMHC3clDJ+9JK2/ItfIm1ZXTfRmUhrZB6HUBqBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXVjhzeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E37C2BCFF;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1783925318; bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BXVjhzeZwahs+QSBGxRaEQberUUsAY6ye/bAc8jOFXC3o89DcjSKDgBIkWPfNZ7pp
	 sv5hzhl8mFV6uauuUaYCC2q6P4H3kqRRcJRqFvIBBscD0nXA+uSPuChCb6iuc7emOy
	 7ZqNjfLuQzA1MFpF8upjxidZkyRzz543EnFfeEBg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD2C44508;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 13 Jul 2026 14:45:24 +0800
Subject: [PATCH v8 03/10] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-fix-fops-owner-v8-3-2495cfa82d47@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783925315; l=1329;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
 b=pARwJxVcVRoXymIcGQkDnow+q6ikOGmiQ4rE0dnkq/TcJlojyMxZzqzh1CwphkdeHA11KajRg
 nJIHFGtIelqCc4wXIGt+qScHDx9PAjITpWZcK9AYEYxozWl5BQSqsZV
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307023-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:email,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9312747AB9

Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
in the doctest harness, so that `crate::LocalModule` (auto-inserted
by `#[vtable]`) resolves correctly when there is no `module!` macro.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 scripts/rustdoc_test_gen.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index ee76e96b41eea..198af4e446c8c 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -239,6 +239,22 @@ macro_rules! assert_eq {{
 
 const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
 
+/// Dummy module type for doctest context.
+struct LocalModule;
+
+use kernel::{{
+    str::CStr,
+    ModuleMetadata,
+    ThisModule, //
+}};
+use core::ptr::null_mut;
+
+impl ModuleMetadata for LocalModule {{
+    const NAME: &'static CStr = c"rust_doctests_kernel";
+    // SAFETY: `try_module_get`/`module_put` handle null module pointers gracefully.
+    const THIS_MODULE: ThisModule = unsafe {{ ThisModule::from_ptr(null_mut()) }};
+}}
+
 {rust_tests}
 "#
     )

-- 
2.43.0



