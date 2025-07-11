Return-Path: <netdev+bounces-206090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CFB01567
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEBD5A4E48
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE3213E9F;
	Fri, 11 Jul 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4EypiBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E6201261
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221089; cv=none; b=lNJd4bFD8IGsVnh/ah9o2LjWGwkFS94y/RG1SRw5hv4cA41dgPkfKT+qKwawkwHfBkxion4JAkCfG4G3nc+PdgD3GVIaIQo+E3knWybjnHTuBh8Uz7+FM4KbVBRWw6G5GZJlyXNEeLjMElPLDE2Du0r0LfJIF+cwyvJ9wkOG1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221089; c=relaxed/simple;
	bh=t988JggshCl/htP4ob36mi+IVMMG0yo27e+JcGENNPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qCqIVRQtHl2pG6JM6Hiy3SOb9KLBgVpK0zUs2qMDwqhVl/qOoBu85iYfsYVCI9enuodZVd34tKD2U3zdO/KgjxwH02u6wnEGJK2uoWPVMM2vTASbXJWuC9Lzw/UhmLlL3tMVQg5Jc9JWG3WU09MflwgJJLoltPGr6r+0dgvsQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4EypiBA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso10164175e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752221086; x=1752825886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ/bfo6Xgsu6JxDs2/h3oFS+uiOoF0damWh//URaq6A=;
        b=d4EypiBAe8wI8UggsO5oVueCwq4cbLUXfbKk3D8x9fGW/HDurSwqAjbUg1qly0oyyQ
         iNHNyjJDUSJz7+rp+fyvCXm3T2nel1yDoae9nubJx989r7j1/QY63COvy5GQjaVYBbOi
         je6ssrIk/bY4VZvFzBd70yUGEJK5GnFd95rzUa80vNpTEEPtM9BYmJdeQoChsekDajU9
         wMrKp0osBo+iWEAsDBIsXpJSzq5pbiXfPt5m9Phm7F6nNPuI6Jbf+0hOUWLjnwSlcyiO
         FfmQ605AOwcusFcg/S8x3bgH4NxsOWqBglZjkr2ZedaTXVAm3BKymegLTzOFV5Ciaz8x
         6hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752221086; x=1752825886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ/bfo6Xgsu6JxDs2/h3oFS+uiOoF0damWh//URaq6A=;
        b=J8N0G7opqCyw/KxrRNBom7GfKjsvnfjshdE9dMNwfpf0zYV/TlMkoy/5oD0dtHfYE5
         JpFRBB9KAtq8lKZXwG1nrP/LB7v7yQzMBpz/0kyZakRCfPEy4Zqy29IbG12+vb5GViCs
         U5tpsp0EiTvKFpygvYvqq/6VqabfRL06jPRLtPlsyVLFj8KgeVPqJYxd+0S7BIoxOMwM
         Gu2O4hIFPYIpn8F5OCiC7pc3iOkIDCgXmncNizG9QFn8+aS2kvUGAJ+UKN4EIlgwwNWv
         99dv77gWti34RO71fPtAMCLO7C1vnSsKIaKgRFXL+2mpm1okda+EN15RJU7S7eb7Ad4y
         okgw==
X-Forwarded-Encrypted: i=1; AJvYcCXEy4BysceAZKEfXmNFryoFt952fjMnw+yeJ1h36fvVFwtG+cKKOf3jso3jjjhGtix9mJ+LyMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze82UZti4vldNtRsEbXMZK6p+PDfU0whQNbvHDombM0Tel8qp/
	vlL4MYGegqOIRGGvLoEchBuCOdtikQzJDcNXQPYv8uxMXL1OZzRuvJu5j5eDGxk9q0V/zaQZx/o
	UxiCrZCLR1wRaGv3IYA==
X-Google-Smtp-Source: AGHT+IGK14uZ963XhzZQTY0uLN96HzDFpfZQooCEFcPT4rsCekbciiSkhX1zVvqJT+2G/2X6NyN1IcUUMNiYncA=
X-Received: from wmbay9.prod.google.com ([2002:a05:600c:1e09:b0:450:cf3f:2a89])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8207:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454e2addac7mr20698785e9.5.1752221085765;
 Fri, 11 Jul 2025 01:04:45 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:04:38 +0000
In-Reply-To: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8793; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=t988JggshCl/htP4ob36mi+IVMMG0yo27e+JcGENNPM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBocMWa1bN3ivtpQ42zwCcYrtyT+6XzfA+T/vZ4r
 JjpRjv7Q8aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHDFmgAKCRAEWL7uWMY5
 RkRDD/4+syUqXHnMUJ62gdTHn/L5qK+pIKPUcTOSTRL2HV8TII2owxBmhgAM0tUsVA7P4O6jIRI
 R5Vs0arcahHmjYcoCs4nNWzKmZ83JoSpEjAU1P5j+TvsjJBarENs7ocxR1aKmfcV/A9AOzjX3kR
 DfI7+3nCs/I9eoxnt3kQBAQG7PN8Qd1gnwuGYoWmujMQqz4gplYZly6YxZ9FHSNpdcmcc1WPB5J
 2bu+SKoicYixfY0mYLu2rITpSgl8V8WzXNywOGl9zPkMdnUaxUlCRAZY52GdJ5DBUY37Yk8W9qj
 NvRy4Sd4dW9tIh0Ih5iM50Zl5dT6idLtd64VcE2HHtB0WrtTBe4JDIRKkQdbCAhZ62T8Py+VrSC
 qgDHZPsKhrgm93lpaQDGIA2vVj0ChooeFit/7Bcgv/coxuykfvB/KeeRtNAWRtyJHtD0XbRdfqG
 E5A5n63B3C6erO5A25Xj5sEYJKZjSnHmBXPxx0OHjKzmoj60uFihNwvKeq57AxCxwjSfjku4AZ1
 FNnvLhHmfxW5cN3kJ3ujW61KaNkp0dHSskufNSrVYeDEP0qTXzWO0ufxIthbyMIUclgyLfxLV0P
 j8lzesAtWNcTjrTgtSO0W98YIMhXTpSKRsVafSAi+D7DMfjDrlXttBq8UlGNsb2Z8iywr+EiWF+ 3ey5Tnv7z17LMXA==
X-Mailer: b4 0.14.2
Message-ID: <20250711-device-as-ref-v2-2-1b16ab6402d7@google.com>
Subject: [PATCH v2 2/2] drm: rust: rename as_ref() to from_raw() for drm constructors
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The prefix as_* should not be used for a constructor. Constructors
usually use the prefix from_* instead.

Some prior art in the stdlib: Box::from_raw, CString::from_raw,
Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.

There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.

Link: https://lore.kernel.org/r/aCd8D5IA0RXZvtcv@pollux
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/device.rs  |  2 +-
 rust/kernel/drm/file.rs    |  8 ++++----
 rust/kernel/drm/gem/mod.rs | 16 ++++++++--------
 rust/kernel/drm/ioctl.rs   |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 11ce1e7f2d52ae4ddfbd4e47dfb17e390653bc45..d4906675c8d59f838a15388d1dad6b2960696ebb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -154,7 +154,7 @@ unsafe fn from_drm_device(ptr: *const bindings::drm_device) -> *mut Self {
     /// Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
     /// embedded in `Self`.
     #[doc(hidden)]
-    pub unsafe fn as_ref<'a>(ptr: *const bindings::drm_device) -> &'a Self {
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_device) -> &'a Self {
         // SAFETY: By the safety requirements of this function `ptr` is a valid pointer to a
         // `struct drm_device` embedded in `Self`.
         let ptr = unsafe { Self::from_drm_device(ptr) };
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index b9527705e5514f00ed5a9c459f3c4161daf5b61d..e8789c9110d654df2561a88a53bc6b1cfa709fdd 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -32,7 +32,7 @@ impl<T: DriverFile> File<T> {
     /// # Safety
     ///
     /// `raw_file` must be a valid pointer to an open `struct drm_file`, opened through `T::open`.
-    pub unsafe fn as_ref<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
         // SAFETY: `raw_file` is valid by the safety requirements of this function.
         unsafe { &*ptr.cast() }
     }
@@ -61,10 +61,10 @@ pub(crate) extern "C" fn open_callback(
         // SAFETY: A callback from `struct drm_driver::open` guarantees that
         // - `raw_dev` is valid pointer to a `struct drm_device`,
         // - the corresponding `struct drm_device` has been registered.
-        let drm = unsafe { drm::Device::as_ref(raw_dev) };
+        let drm = unsafe { drm::Device::from_raw(raw_dev) };
 
         // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
-        let file = unsafe { File::<T>::as_ref(raw_file) };
+        let file = unsafe { File::<T>::from_raw(raw_file) };
 
         let inner = match T::open(drm) {
             Err(e) => {
@@ -89,7 +89,7 @@ pub(crate) extern "C" fn postclose_callback(
         raw_file: *mut bindings::drm_file,
     ) {
         // SAFETY: This reference won't escape this function
-        let file = unsafe { File::<T>::as_ref(raw_file) };
+        let file = unsafe { File::<T>::from_raw(raw_file) };
 
         // SAFETY: `file.driver_priv` has been created in `open_callback` through `KBox::into_raw`.
         let _ = unsafe { KBox::from_raw(file.driver_priv()) };
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 4cd69fa84318c3ff2cec57949e9bab05559a3c2f..a24c9a2fc201b69cc31b76282a68aec188aaac73 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -51,7 +51,7 @@ pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     /// - `self_ptr` must be a valid pointer to `Self`.
     /// - The caller promises that holding the immutable reference returned by this function does
     ///   not violate rust's data aliasing rules and remains valid throughout the lifetime of `'a`.
-    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
+    unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
 }
 
 // SAFETY: All gem objects are refcounted.
@@ -86,12 +86,12 @@ extern "C" fn open_callback<T: BaseDriverObject<U>, U: BaseObject>(
 ) -> core::ffi::c_int {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::as_ref(raw_file)
+        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
     };
     // SAFETY: `open_callback` is specified in the AllocOps structure for `Object<T>`, ensuring that
     // `raw_obj` is indeed contained within a `Object<T>`.
     let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::as_ref(raw_obj)
+        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
     };
 
     match T::open(obj, file) {
@@ -106,12 +106,12 @@ extern "C" fn close_callback<T: BaseDriverObject<U>, U: BaseObject>(
 ) {
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe {
-        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::as_ref(raw_file)
+        drm::File::<<<U as IntoGEMObject>::Driver as drm::Driver>::File>::from_raw(raw_file)
     };
     // SAFETY: `close_callback` is specified in the AllocOps structure for `Object<T>`, ensuring
     // that `raw_obj` is indeed contained within a `Object<T>`.
     let obj = unsafe {
-        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::as_ref(raw_obj)
+        <<<U as IntoGEMObject>::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj)
     };
 
     T::close(obj, file);
@@ -124,7 +124,7 @@ fn as_raw(&self) -> *mut bindings::drm_gem_object {
         self.obj.get()
     }
 
-    unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
+    unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
         let self_ptr: *mut Opaque<bindings::drm_gem_object> = self_ptr.cast();
 
         // SAFETY: `obj` is guaranteed to be in an `Object<T>` via the safety contract of this
@@ -170,9 +170,9 @@ fn lookup_handle(
         // - A `drm::Driver` can only have a single `File` implementation.
         // - `file` uses the same `drm::Driver` as `Self`.
         // - Therefore, we're guaranteed that `ptr` must be a gem object embedded within `Self`.
-        // - And we check if the pointer is null befoe calling as_ref(), ensuring that `ptr` is a
+        // - And we check if the pointer is null befoe calling from_raw(), ensuring that `ptr` is a
         //   valid pointer to an initialized `Self`.
-        let obj = unsafe { Self::as_ref(ptr) };
+        let obj = unsafe { Self::from_raw(ptr) };
 
         // SAFETY:
         // - We take ownership of the reference of `drm_gem_object_lookup()`.
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 445639404fb7fe2cf3276890b1236f611ded9f3f..fdec01c371687c79d660457bd2bd6e09b2400d35 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -134,7 +134,7 @@ macro_rules! declare_drm_ioctls {
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev = $crate::drm::device::Device::as_ref(raw_dev);
+                            let dev = $crate::drm::device::Device::from_raw(raw_dev);
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
@@ -142,7 +142,7 @@ macro_rules! declare_drm_ioctls {
                                 &*(raw_data as *const $crate::types::Opaque<$crate::uapi::$struct>)
                             };
                             // SAFETY: This is just the DRM file structure
-                            let file = unsafe { $crate::drm::File::as_ref(raw_file) };
+                            let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
                             match $func(dev, data, file) {
                                 Err(e) => e.to_errno(),

-- 
2.50.0.727.gbf7dc18ff4-goog


