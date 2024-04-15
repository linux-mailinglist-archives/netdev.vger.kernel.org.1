Return-Path: <netdev+bounces-88041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9568A56B9
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9AD1C211DC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207C78C7B;
	Mon, 15 Apr 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DReU9OsR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF18745FA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195954; cv=none; b=ZDN2NtzvCumqbsoFMWz2Xg/dqk22oxMrE5PSyJ+lmsEqb/NhKALkS8y7GERHal3NspYeZmweBJKVdKMCUPjL0xXKQQx/V6xLN5HV4RqyYmTKkEnK82vuyBYMY2TNA19cj0aM59wIglkRylFfGztYPA2EHjWqANcaqoy+d5W4lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195954; c=relaxed/simple;
	bh=Xi/Gy+9bVM0pfVpgq3WFEZLPrG7U8wcs68PFsMzPSTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt5/wa/NoH8CPzXjEW8GBwWRYjgI8M7Z63slTuqH5yf4qBSQgW6dqsx0bwIFCxrlt8cKA2Da0CthOn362BFjFLxQ/0ZspueD7LyVfxwHozdF/FMfJvfgnit7sgtp6sp0Q6Bh8nmAu04kl/mlVpanqlWUY/82PUxwb57/ArQ/Z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DReU9OsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713195951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNz570E892KG+FjKobpVEcp1QA8zUcUhXcLAyJMGnQY=;
	b=DReU9OsRyZ4jn4t6m4AM8XX+ingvQd5a8UjvHTMLs6EJYnzJvgL17dASc/omMCMdPuJ33E
	QrFYeu5c26E69J5z+yowY7UQ6sC2eiiBx2iVKoc57/EhScE82qzzZHHI1RBcwfBTMKlWuf
	r1tAapF321iaGjxxOHAW8TcbJbQsdZE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-NHp3FzMiPg-z-7lf89UFMg-1; Mon, 15 Apr 2024 11:45:49 -0400
X-MC-Unique: NHp3FzMiPg-z-7lf89UFMg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57030f8ef16so590101a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195949; x=1713800749;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNz570E892KG+FjKobpVEcp1QA8zUcUhXcLAyJMGnQY=;
        b=MPtbRM+eWWs6ELaxxSCd5ZQLzMFUhH5UPG3W+WSf2GnXDOItGqnqZbdTBnWsdQTXNE
         nQ0VCipENGiuRbYFSniuKLmobAjSbA2GRNvG7FsmVi/zIkvB4+goEN/nxXHNkjV+2hDB
         Z0p5mGzfLhYkZOLIevxF6HPKfTXrp8nycQp2Y1hMCNCJ/6jlTWzvHS2TSit3BoabuIcM
         I6hHW8hZxUiMGtzcFZ6aFqQY/qPmfjP1p305zaRfsIatCgRxA9PGEUS18ErciuGhaU5Y
         xGNTqs9VPBYnTb2CetwsClyeOKd6bjQesBq7uDnNJ9z3fA90qIETKa9T6Py+mA34KPrx
         1KWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2PoRPQkRwLaMXw7SsbGH/lXeEq+HJuyO+pCypztCqjj6K6X2WtyX2txY7Dtbc3n8UoOV41nn4v7zaih+oUiaSG+rMGxaV
X-Gm-Message-State: AOJu0YyyK4JOC74wwvndSZ/+A4gDzuyDd58D9IyXAbquWzPKR3xEgnjT
	e9DSwzSfzrQj4KiW/QyWINeBBuO4HSCEOhOFOy1fvc21U1S41usd/U1NDTi7NVGfJStYovrsyOu
	ITEZhEYfaY7NueBOdec0AOwtopcwovPhdvpc+5nYQsFWR2UvmpNohIw==
X-Received: by 2002:a50:cdde:0:b0:56d:f035:7db2 with SMTP id h30-20020a50cdde000000b0056df0357db2mr6483642edj.24.1713195948831;
        Mon, 15 Apr 2024 08:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSCp8D8TclLoZmoNojRnkU3x1ePv0umpEP/XijucBdAh3k1Lt/RhugHDqdHZyrmpShPu9vzQ==
X-Received: by 2002:a50:cdde:0:b0:56d:f035:7db2 with SMTP id h30-20020a50cdde000000b0056df0357db2mr6483628edj.24.1713195948469;
        Mon, 15 Apr 2024 08:45:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b005701eaa2023sm2188072edb.72.2024.04.15.08.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:45:48 -0700 (PDT)
Message-ID: <60a3d668-4653-43b5-b40f-87fb7daaef50@redhat.com>
Date: Mon, 15 Apr 2024 17:45:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, gregkh@linuxfoundation.org
Cc: andrew@lunn.ch, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 Luis Chamberlain <mcgrof@kernel.org>, netdev@vger.kernel.org,
 Russ Weight <russ.weight@linux.dev>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-4-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240415104701.4772-4-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 12:47, FUJITA Tomonori wrote:
> This patch adds support to the following basic Firmware API:
> 
> - request_firmware
> - release_firmware
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Russ Weight <russ.weight@linux.dev>
> ---
>   drivers/net/phy/Kconfig         |  1 +
>   rust/bindings/bindings_helper.h |  1 +
>   rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+)

As Greg already mentioned, this shouldn't be implemented specifically for struct
phy_device, but rather for a generic struct device.

I already got some generic firmware abstractions [1][2] sitting on top of a patch
series adding some basic generic device / driver abstractions [3].

I won't send out an isolated version of the device / driver series, but the full
patch series for the Nova stub driver [4] once I got everything in place. This was
requested by Greg to be able to see the full picture.

The series will then also include the firmware abstractions.

In order to use them from your PHY driver, I think all you need to do is to implement
AsRef<> for your phy::Device:

impl AsRef<device::Device> for Device {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
         unsafe { device::Device::from_raw(&mut (*self.ptr).mdio.dev) }
     }
}

- Danilo

[1] https://gitlab.freedesktop.org/drm/nova/-/commit/e9bb608206f3c30a0f8d71fe472719778a113b28
[2] https://gitlab.freedesktop.org/drm/nova/-/tree/topic/firmware
[3] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
[4] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/#u

> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 7fddc8306d82..3ad04170aa4e 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -64,6 +64,7 @@ config RUST_PHYLIB_ABSTRACTIONS
>           bool "Rust PHYLIB abstractions support"
>           depends on RUST
>           depends on PHYLIB=y
> +        depends on FW_LOADER=y
>           help
>             Adds support needed for PHY drivers written in Rust. It provides
>             a wrapper around the C phylib core.
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 65b98831b975..556f95c55b7b 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>   #include <kunit/test.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
> +#include <linux/firmware.h>
>   #include <linux/jiffies.h>
>   #include <linux/mdio.h>
>   #include <linux/phy.h>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 421a231421f5..095dc3ccc553 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -9,6 +9,51 @@
>   use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
>   
>   use core::marker::PhantomData;
> +use core::ptr::{self, NonNull};
> +
> +/// A pointer to the kernel's `struct firmware`.
> +///
> +/// # Invariants
> +///
> +/// The pointer points at a `struct firmware`, and has ownership over the object.
> +pub struct Firmware(NonNull<bindings::firmware>);
> +
> +impl Firmware {
> +    /// Loads a firmware.
> +    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
> +        let phydev = dev.0.get();
> +        let mut ptr: *mut bindings::firmware = ptr::null_mut();
> +        let p_ptr: *mut *mut bindings::firmware = &mut ptr;
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
> +        // So it's just an FFI call.
> +        let ret = unsafe {
> +            bindings::request_firmware(
> +                p_ptr as *mut *const bindings::firmware,
> +                name.as_char_ptr().cast(),
> +                &mut (*phydev).mdio.dev,
> +            )
> +        };
> +        let fw = NonNull::new(ptr).ok_or_else(|| Error::from_errno(ret))?;
> +        // INVARIANT: We checked that the firmware was successfully loaded.
> +        Ok(Firmware(fw))
> +    }
> +
> +    /// Accesses the firmware contents.
> +    pub fn data(&self) -> &[u8] {
> +        // SAFETY: The type invariants guarantee that `self.0.as_ptr()` is valid.
> +        // They also guarantee that `self.0.as_ptr().data` pointers to
> +        // a valid memory region of size `self.0.as_ptr().size`.
> +        unsafe { core::slice::from_raw_parts((*self.0.as_ptr()).data, (*self.0.as_ptr()).size) }
> +    }
> +}
> +
> +impl Drop for Firmware {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, `self.0.as_ptr()` is valid and
> +        // we have ownership of the object so can free it.
> +        unsafe { bindings::release_firmware(self.0.as_ptr()) }
> +    }
> +}
>   
>   /// PHY state machine states.
>   ///


