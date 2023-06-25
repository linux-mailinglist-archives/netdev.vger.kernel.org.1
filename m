Return-Path: <netdev+bounces-13831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02573D2A6
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41A81C2091E
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB06FC6;
	Sun, 25 Jun 2023 17:07:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEF6FAB
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 17:07:16 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD04100
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 10:07:11 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1687712827; x=1687972027;
	bh=QExAZN0viDBP6uZhV+EBlZi29OCdmxjxCPTr3yF6zNY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dp/renVTAb5fLw0sRwnrbDWzoNPhOBIBNC00aJtvLkUt25C3YSOg2RHh4VjK5hV/O
	 em0IVoalOH7hUYSuzvGHbV8D0OuZYbOjey78cebH+JQfg+2hNNXZNqVxe5F8E3SFGf
	 fGCyLefQmxOcqWbjM1bgjN5x1DsFzvbjL8PTVNag0bIL2eUKD3k7DX1kNR0grqlPKi
	 aA7nYDH8VZEADG712yCkdPW1Vhn9FP+XbdZ3uzpwmoEgXcunnG0+QoUYPHakuz4JTK
	 kyaZHjPSV0CH4XzenanXnmmlOUTCtYhmWC4bhSDW+4yc0/N5hvZ5xr/zwM5A/WptfZ
	 BtKBl9uSeBICA==
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, aliceryhl@google.com, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/5] rust: core abstractions for network device drivers
Message-ID: <69144cf1-6c07-868c-9577-e41db4c0cc75@proton.me>
In-Reply-To: <20230625.232736.235121744769257487.ubuntu@gmail.com>
References: <_kID50ojyLurmrpIpn_kNxCRqo5MAaqm9pE47mhFcLops8yDhSqmbkhJiUuHlAFSdgqX1dHdZGxUa95ZSHAPHesIKLci1J21cu6nmdQ3ZGg=@proton.me> <20230621.221349.1237576739913195911.ubuntu@gmail.com> <3ff6edec-c083-9294-d2df-01be983cd293@proton.me> <20230625.232736.235121744769257487.ubuntu@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25.06.23 16:27, FUJITA Tomonori wrote:
> Hi,
>
> On Sun, 25 Jun 2023 09:52:53 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>
>>>>> +/// Trait for device driver specific information.
>>>>> +///
>>>>> +/// This data structure is passed to a driver with the operations fo=
r `struct net_device`
>>>>> +/// like `struct net_device_ops`, `struct ethtool_ops`, `struct rtnl=
_link_ops`, etc.
>>>>> +pub trait DriverData {
>>>>> +    /// The object are stored in C object, `struct net_device`.
>>>>> +    type Data: ForeignOwnable + Send + Sync;
>>>>
>>>> Why is this an associated type? Could you not use
>>>> `D: ForeignOwnable + Send + Sync` everywhere instead?
>>>> I think this should be possible, since `DriverData` does not define
>>>> anything else.
>>>
>>> With that approach, is it possible to allow a device driver to define
>>> own data structure and functions taking the structure as aurgument
>>> (like DevOps structutre in the 5th patch)
>>>
>>
>> In the example both structs are empty so I am not really sure why it has
>> to be two types. Can't we do this:
>> ```
>> pub struct MyDriver {
>>       // Just some random fields...
>>       pub access_count: Cell<usize>,
>> }
>>
>>
>> impl DriverData for Box<MyDriver> {}
>>
>> // And then we could make `DeviceOperations: DriverData`.
>> // Users would then do this:
>>
>> #[vtable]
>> impl DeviceOperations for Box<MyDriver> {
>>       fn init(_dev: Device, data: &MyDriver) -> Result {
>>           data.access_count.set(0);
>>           Ok(())
>>       }
>>
>>       fn open(_dev: Device, data: &MyDriver) -> Result {
>>           data.access_count.set(data.access_count.get() + 1);
>>           Ok(())
>>       }
>> }
>> ```
>>
>> I think this would simplify things, because you do not have to carry the
>> extra associated type around (and have to spell out
>> `<D::Data as ForeignOwnable>` everywhere).
>
> I'm still not sure if I correctly understand what you try to do.
>
> If I define DeviceOperations in dev.rs like the following:
>
> #[vtable]
> pub trait DeviceOperations<D: ForeignOwnable + Send + Sync> {
>      /// Corresponds to `ndo_init` in `struct net_device_ops`.
>          fn init(_dev: &mut Device, _data: D::Borrowed<'_>) -> Result {
> =09        Ok(())
>          }
> }
>
> And the driver implmeents DeviceOperations like the folloing:
>
> #[vtable]
> impl<D: ForeignOwnable + Send + Sync> DeviceOperations<D> for Box<DriverD=
ata> {
>      fn init(_dev: &mut Device, _data: &DriverData) -> Result {
>              Ok(())
>      }
> }
>
> I got the following error:
>
> error[E0053]: method `init` has an incompatible type for trait
>    --> samples/rust/rust_net_dummy.rs:24:39
>     |
> 24 |     fn init(_dev: &mut Device, _data: &DriverData) -> Result {
>     |                                       ^^^^^^^^^^^
>     |                                       |
>     |                                       expected associated type, fou=
nd `&DriverData`
>     |                                       help: change the parameter ty=
pe to match the trait: `<D as ForeignOwnable>::Borrowed<'_>`
>     |
>     =3D note: expected signature `fn(&mut Device, <D as ForeignOwnable>::=
Borrowed<'_>) -> core::result::Result<_, _>`
>                found signature `fn(&mut Device, &DriverData) -> core::res=
ult::Result<_, _>`
>

I thought you could do this:
```
#[vtable]
pub trait DeviceOperations: ForeignOwnable + Send + Sync {
     /// Corresponds to `ndo_init` in `struct net_device_ops`.
     fn init(_dev: &mut Device, _data: Self::Borrowed<'_>) -> Result {
         Ok(())
     }
}

#[vtable]
impl DeviceOperations<D> for Box<DriverData> {
     fn init(_dev: &mut Device, _data: &DriverData) -> Result {
         Ok(())
     }
}
```

>>>>> +    const fn build_device_ops() -> &'static bindings::net_device_ops=
 {
>>>>> +        &Self::DEVICE_OPS
>>>>> +    }
>>>>
>>>> Why does this function exist?
>>>
>>> To get const struct net_device_ops *netdev_ops.
>>
>> Can't you just use `&Self::DEVICE_OPS`?
>
> I think that it didn't work in the past but seems that it works
> now. I'll fix.
>
>
>>>>> +/// Corresponds to the kernel's `struct net_device_ops`.
>>>>> +///
>>>>> +/// A device driver must implement this. Only very basic operations =
are supported for now.
>>>>> +#[vtable]
>>>>> +pub trait DeviceOperations<D: DriverData> {
>>>>
>>>> Why is this trait generic over `D`? Why is this not `Self` or an assoc=
iated
>>>> type?
>>>
>>> DriverData also used in EtherOperationsAdapter (the second patch) and
>>> there are other operations that uses DriverData (not in this patchset).
>>
>> Could you point me to those other things that use `DriverData`?
>
> net_device struct has some like tlsdev_ops, rtnl_link_ops.. A device
> driver might need to access to the private data via net_device in
> these operations.

In my mental model you can just implement the `TLSOperations` trait
alongside the `DeviceOperations` trait. But I would have to see the
API that will be used for that to be sure. I do not think that you need
to have different private data for each of those operations traits.

--
Cheers,
Benno

>
>
> thanks,



