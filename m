Return-Path: <netdev+bounces-18020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80B7542F4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2351A28228D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4515AFB;
	Fri, 14 Jul 2023 19:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C141371C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:01:15 +0000 (UTC)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7B30FC
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 12:01:13 -0700 (PDT)
Date: Fri, 14 Jul 2023 19:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1689361268; x=1689620468;
	bh=EnnWh665YM00LwXvaZBTKdAB3XRfLgb6vEzqtIihF/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=haH7zbyV+u+VmpvvhMTawl8T3g+UmqaBo+E5jJWl3a68eNg5IGpr2StCpbuRWnWhT
	 r3rEfLqtW4ZvrRPoY0+Ttm6bat7ok1YZ1oeLuh/kXty+nsnkNnOaofHf96DSipk4g7
	 KpJZWnvAhPGT9eknDC3Iryogu/cWDRVRYu0/ZJ/U7YdG36vR3/29T/QF1gnPHM0EET
	 CBtWXoOvZjPyQsA3pOz0oJJxUjKG/9CfJOWav4ZPtObkUH/zRYqRiZCZmCtlu9zBBm
	 twKzrUaWAObNxn8grFDw+ASvJDJHRWutIo3bYG0RqdTnaueB3NRw0GgVxIAiuWlulv
	 QOPIPk7kVp/Pg==
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch, aliceryhl@google.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 2/5] rust: add support for ethernet operations
Message-ID: <Gl0dPVYCaKQpn_kU3zHm_f6RyN3M2RhJXwhfZDoV76x8IOiMbTi73XVKG2oYEbve-9Au299c7BnDAG6uUHFE2vxrk_pWCeWH5qzyCau_Ayw=@proton.me>
In-Reply-To: <20230710073703.147351-3-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com> <20230710073703.147351-3-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This improves abstractions for network device drivers to implement
> struct ethtool_ops, the majority of ethernet device drivers need to
> do.
>=20
> struct ethtool_ops also needs to access to device private data like
> struct net_device_ops.
>=20
> Currently, only get_ts_info operation is supported. The following
> patch adds the Rust version of the dummy network driver, which uses
> the operation.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/net/dev.rs          | 87 ++++++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 468bf606f174..6446ff764980 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,7 @@
>=20
>  #include <linux/errname.h>
>  #include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
> index fe20616668a9..ff00616e4fef 100644
> --- a/rust/kernel/net/dev.rs
> +++ b/rust/kernel/net/dev.rs
> @@ -142,7 +142,7 @@ pub fn register(&mut self) -> Result {
>          if self.is_registered {
>              return Err(code::EINVAL);
>          }
> -        // SAFETY: The type invariants guarantee that `self.dev.ptr` is =
valid.
> +        // SAFETY: The type invariants of `Device` guarantee that `self.=
dev.ptr` is valid.

Shouldn't this be squashed into patch 1?

>          let ret =3D unsafe {
>              (*self.dev.ptr).netdev_ops =3D &Self::DEVICE_OPS;
>              bindings::register_netdev(self.dev.ptr)
> @@ -155,6 +155,18 @@ pub fn register(&mut self) -> Result {
>          }
>      }
>=20
> +    /// Sets `ethtool_ops` of `net_device`.
> +    pub fn set_ether_operations<E: EtherOperations>(&mut self) -> Result=
 {
> +        if self.is_registered {
> +            return Err(code::EINVAL);
> +        }
> +        // SAFETY: The type invariants of `Device` guarantee that `self.=
dev.ptr` is valid.
> +        unsafe {
> +            (*(self.dev.ptr)).ethtool_ops =3D &EtherOperationsAdapter::<=
E>::ETHER_OPS;
> +        }
> +        Ok(())
> +    }
> +

I think it would make sense to also add

```
pub fn setup_ether_operations(&mut self) -> Result
where
    T: EtherOperations
{
    self.set_ether_operations::<T>();
}
```

Since normally you would implement `EtherOperations` for the same type
that also implement `DeviceOperations`, right?

>      const DEVICE_OPS: bindings::net_device_ops =3D bindings::net_device_=
ops {
>          ndo_init: if <T>::HAS_INIT {
>              Some(Self::init_callback)
> @@ -328,3 +340,76 @@ fn drop(&mut self) {
>          build_error!("skb must be released explicitly");
>      }
>  }
> +
> +/// Builds the kernel's `struct ethtool_ops`.
> +struct EtherOperationsAdapter<E: EtherOperations> {
> +    _p: PhantomData<E>,
> +}
> +
> +impl<E: EtherOperations> EtherOperationsAdapter<E> {
> +    unsafe extern "C" fn get_ts_info_callback(
> +        netdev: *mut bindings::net_device,
> +        info: *mut bindings::ethtool_ts_info,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `netdev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_ptr(netdev) };
> +            // SAFETY: The C API guarantees that `info` is valid while t=
his function is running.
> +            let info =3D unsafe { EthtoolTsInfo::from_ptr(info) };
> +            E::get_ts_info(dev, info)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    const ETHER_OPS: bindings::ethtool_ops =3D bindings::ethtool_ops {
> +        get_ts_info: if <E>::HAS_GET_TS_INFO {
> +            Some(Self::get_ts_info_callback)
> +        } else {
> +            None
> +        },
> +        // SAFETY: The rest is zeroed out to initialize `struct ethtool_=
ops`,
> +        // set `Option<&F>` to be `None`.
> +        ..unsafe { core::mem::MaybeUninit::<bindings::ethtool_ops>::zero=
ed().assume_init() }
> +    };
> +}
> +
> +/// Corresponds to the kernel's `struct ethtool_ops`.
> +#[vtable]
> +pub trait EtherOperations: ForeignOwnable + Send + Sync {
> +    /// Corresponds to `get_ts_info` in `struct ethtool_ops`.
> +    fn get_ts_info(_dev: Device<Self>, _info: EthtoolTsInfo) -> Result {
> +        Err(Error::from_errno(bindings::EOPNOTSUPP as i32))

Note that you have to use `-(EOPNOTSUPP as i32)`. Maybe just add this
in `error.rs` via the `declare_err` macro.

--
Cheers,
Benno

> +    }
> +}
> +
> +/// Corresponds to the kernel's `struct ethtool_ts_info`.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid.
> +pub struct EthtoolTsInfo(*mut bindings::ethtool_ts_info);
> +
> +impl EthtoolTsInfo {
> +    /// Creates a new `EthtoolTsInfo' instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` must be valid.
> +    unsafe fn from_ptr(ptr: *mut bindings::ethtool_ts_info) -> Self {
> +        // INVARIANT: The safety requirements ensure the invariant.
> +        Self(ptr)
> +    }
> +
> +    /// Sets up the info for software timestamping.
> +    pub fn ethtool_op_get_ts_info<D: ForeignOwnable + Send + Sync>(
> +        dev: &Device<D>,
> +        info: &mut EthtoolTsInfo,
> +    ) -> Result {
> +        // SAFETY: The type invariants of `Device` guarantee that `dev.p=
tr` are valid.
> +        // The type invariants guarantee that `info.0` are valid.
> +        unsafe {
> +            bindings::ethtool_op_get_ts_info(dev.ptr, info.0);
> +        }
> +        Ok(())
> +    }
> +}
> --
> 2.34.1
>=20


