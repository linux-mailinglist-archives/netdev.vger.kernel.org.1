Return-Path: <netdev+bounces-301275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sqf2CJ4oOmoY3AcAu9opvQ
	(envelope-from <netdev+bounces-301275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961F6B48B7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:33:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=neuM+55q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301275-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA3D03028BC4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13A3CC7EA;
	Tue, 23 Jun 2026 06:30:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A063C1994;
	Tue, 23 Jun 2026 06:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196210; cv=none; b=nnJAmOu+xT2zfl7N2iigXhVdu1Jc9C6oYoz7ixgDgWPWkt2nGDxygib69/o5i8zKQY60Zcw1LOYmJT2cjJKXbRIMwY5XAGBF5nwuRf8W4txA26Ibbu1oTjjGlqSbSSSl+kykOZxhaUGlNWV851qpN0BbalQkgStVegHYjTwkNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196210; c=relaxed/simple;
	bh=Ti7w8XNP4fw929XO4M5y+gDX8+sXECmyMVne5zeDayM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imwb8/z73Few8iELeUCvLLRTYM+by8u4K09sxItoFN53EnOy/ZRSiEtyGuLIVYrLIMFba8IThLs7JG507n6T/tGtQjbg1fDIjXyA0d6cUwNcRnnLcKGd06ANn39WgFA+C6p2HTtLySXoQ4Ej7FWGYaa6Tdq6pXTqsM/Xzr5govE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neuM+55q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4217C32782;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782196209; bh=Ti7w8XNP4fw929XO4M5y+gDX8+sXECmyMVne5zeDayM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=neuM+55qeemXxbQFeqDYtjkdRJZPD3T3q8gbmPgxbpSz9fINjheP0AWaRys2qg53e
	 +k9MDFmJ58EIUWFTP0U1xrXth56gLuWqw40aSHEu/j6IXSfYmO9B6WW5EGb3YOd225
	 ba3Yu9EJAyG897Tklu2mLE4lMlFs8F6aRwj9uZ24=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF32CDB47C;
	Tue, 23 Jun 2026 06:30:09 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 23 Jun 2026 14:29:48 +0800
Subject: [PATCH v4 5/9] rust: drm: set fops.owner from driver module
 pointer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-fix-fops-owner-v4-5-0daf5f077d5c@linux.dev>
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782196206; l=1849;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=Ti7w8XNP4fw929XO4M5y+gDX8+sXECmyMVne5zeDayM=;
 b=UAbDEFquJEWH4q8B3WEPnEtU9cy0hucE0oiD/YYklQj/JkOHsvTucnDTvI9FY1BUrnZba72oJ
 r3F3yEFaMX0BvdhtiQyrHGgl5+BeOXKHVoAj/lQcdHAIshJxgzqJfEe
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301275-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.k
 ernel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,garyguo.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fops.open:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1961F6B48B7

Change `create_fops()` to accept an owner module pointer instead of
hardcoding `null_mut()`, ensuring the kernel correctly tracks the
module owning the DRM device's file operations.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/drm/device.rs  | 3 ++-
 rust/kernel/drm/gem/mod.rs | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 403fc35353c74..d92cacb665366 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -111,7 +111,8 @@ impl<T: drm::Driver> Device<T> {
         fops: &Self::GEM_FOPS,
     };
 
-    const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
+    const GEM_FOPS: bindings::file_operations =
+        drm::gem::create_fops(crate::module::this_module::<T::OwnerModule>().as_ptr());
 
     /// Create a new `drm::Device` for a `drm::Driver`.
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 01b5bd47a3332..9a203efc59116 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -357,10 +357,10 @@ impl<T: DriverObject> AllocImpl for Object<T> {
     };
 }
 
-pub(super) const fn create_fops() -> bindings::file_operations {
+pub(super) const fn create_fops(owner: *mut bindings::module) -> bindings::file_operations {
     let mut fops: bindings::file_operations = pin_init::zeroed();
 
-    fops.owner = core::ptr::null_mut();
+    fops.owner = owner;
     fops.open = Some(bindings::drm_open);
     fops.release = Some(bindings::drm_release);
     fops.unlocked_ioctl = Some(bindings::drm_ioctl);

-- 
2.43.0



