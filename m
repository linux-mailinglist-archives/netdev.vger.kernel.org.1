Return-Path: <netdev+bounces-43220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B37D1CC3
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CC2B2168C
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A8DF54;
	Sat, 21 Oct 2023 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZUD6y7q+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AADB6FB0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:21:24 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95855119
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5zso2iolr5gljitxnwvqu46rgy.protonmail; t=1697887276; x=1698146476;
	bh=e8NSQsM0vMHf0PvMy02SJ4KpeoHMxHk9wBtLbuRgAG4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZUD6y7q+pS19QG58u1W4YCux9wiU9KrrZYZdyuGyp+TK2LGvcpbZCIXd7ulG0fz/Z
	 R4dzQZL0tSDVVjbkGu9UMmqQdoLieZYKl3TkiHIKHoa4KbfCrHZWKE8Mx6jPkuQhdt
	 w6FJjeHKr/BaRES0nXEoqVac/wLQn0i9/0yPFKPoE1uhC9bkEO1bN/GZLXXEF8O5DB
	 2kFUssAWiMANYhxnt2TyDmr//Hw/QPoZYJCsCvQHDoiA/NUnpdgqrZE1OzUDkRt+TE
	 zm47weWbrhp0l68Mzkst2yDyDS10I1qOEoh0e0iRBG1s05oCiGwNeiKd7GvlgiuSzg
	 K0MGAO8WX0mXw==
Date: Sat, 21 Oct 2023 11:21:12 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <fa420b54-b381-4534-8568-91286eb7d28b@proton.me>
In-Reply-To: <20231021.192741.2305009064677924338.fujita.tomonori@gmail.com>
References: <b218e543-d61c-4317-9b19-05ac6ce47d15@proton.me> <20231021.163015.27220410326177568.fujita.tomonori@gmail.com> <4e3e0801-b8b2-457b-aee1-086d20365890@proton.me> <20231021.192741.2305009064677924338.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 12:27, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 08:37:08 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 21.10.23 09:30, FUJITA Tomonori wrote:
>>> On Sat, 21 Oct 2023 07:25:17 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> On 20.10.23 14:54, FUJITA Tomonori wrote:
>>>>> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
>>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>>
>>>>>> On Thu, 19 Oct 2023 15:20:51 +0000
>>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>
>>>>>>> I would like to remove the mutable static variable and simplify
>>>>>>> the macro.
>>>>>>
>>>>>> How about adding DriverVTable array to Registration?
>>>>>>
>>>>>> /// Registration structure for a PHY driver.
>>>>>> ///
>>>>>> /// # Invariants
>>>>>> ///
>>>>>> /// The `drivers` slice are currently registered to the kernel via `=
phy_drivers_register`.
>>>>>> pub struct Registration<const N: usize> {
>>>>>>        drivers: [DriverVTable; N],
>>>>>> }
>>>>>>
>>>>>> impl<const N: usize> Registration<{ N }> {
>>>>>>        /// Registers a PHY driver.
>>>>>>        pub fn register(
>>>>>>            module: &'static crate::ThisModule,
>>>>>>            drivers: [DriverVTable; N],
>>>>>>        ) -> Result<Self> {
>>>>>>            let mut reg =3D Registration { drivers };
>>>>>>            let ptr =3D reg.drivers.as_mut_ptr().cast::<bindings::phy=
_driver>();
>>>>>>            // SAFETY: The type invariants of [`DriverVTable`] ensure=
 that all elements of the `drivers` slice
>>>>>>            // are initialized properly. So an FFI call with a valid =
pointer.
>>>>>>            to_result(unsafe {
>>>>>>                bindings::phy_drivers_register(ptr, reg.drivers.len()=
.try_into()?, module.0)
>>>>>>            })?;
>>>>>>            // INVARIANT: The `drivers` slice is successfully registe=
red to the kernel via `phy_drivers_register`.
>>>>>>            Ok(reg)
>>>>>>        }
>>>>>> }
>>>>>
>>>>> Scratch this.
>>>>>
>>>>> This doesn't work. Also simply putting slice of DriverVTable into
>>>>> Module strcut doesn't work.
>>>>
>>>> Why does it not work? I tried it and it compiled fine for me.
>>>
>>> You can compile but the kernel crashes. The addresses of the callback
>>> functions are invalid.
>>
>> Can you please share your setup and the error? For me it booted
>> fine.
>=20
> You use ASIX PHY hardware?

It seems I have configured something wrong. Can you share your testing
setup? Do you use a virtual PHY device in qemu, or do you boot it from
real hardware with a real ASIX PHY device?

> I use the following macro:
>=20
>      (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f=
:tt)*) =3D> {
>          const N: usize =3D $crate::module_phy_driver!(@count_devices $($=
driver),+);
>          struct Module {
>              _drivers: [::kernel::net::phy::DriverVTable; N],
>          }
>=20
>          $crate::prelude::module! {
>              type: Module,
>              $($f)*
>          }
>=20
>          unsafe impl Sync for Module {}
>=20
>          impl ::kernel::Module for Module {
>              fn init(module: &'static ThisModule) -> Result<Self> {
>                  let mut m =3D Module {
>                      _drivers:[$(::kernel::net::phy::create_phy_driver::<=
$driver>()),+],
>                  };
>                  let ptr =3D m._drivers.as_mut_ptr().cast::<::kernel::bin=
dings::phy_driver>();
>                  ::kernel::error::to_result(unsafe {
>                      kernel::bindings::phy_drivers_register(ptr, m._drive=
rs.len().try_into()?, module.as_ptr())
>                  })?;
>                  Ok(m)
>              }
>          }
>=20
>=20
> [  176.809218] asix 1-7:1.0 (unnamed net_device) (uninitialized): PHY [us=
b-001:003:10] driver [Asix Electronics AX88772A] (irq=3DPOLL)
> [  176.812371] Asix Electronics AX88772A usb-001:003:10: attached PHY dri=
ver (mii_bus:phy_addr=3Dusb-001:003:10, irq=3DPOLL)
> [  176.812840] asix 1-7:1.0 eth0: register 'asix' at usb-0000:00:14.0-7, =
ASIX AX88772 USB 2.0 Ethernet, 08:6d:41:e4:30:66
> [  176.812927] usbcore: registered new interface driver asix
> [  176.816371] asix 1-7:1.0 enx086d41e43066: renamed from eth0
> [  176.872711] asix 1-7:1.0 enx086d41e43066: configuring for phy/internal=
 link mode
> [  179.002965] asix 1-7:1.0 enx086d41e43066: Link is Up - 100Mbps/Full - =
flow control off
> [  319.672300] loop0: detected capacity change from 0 to 8
> [  367.936371] asix 1-7:1.0 enx086d41e43066: Link is Down
> [  370.459947] asix 1-7:1.0 enx086d41e43066: configuring for phy/internal=
 link mode
> [  372.599320] asix 1-7:1.0 enx086d41e43066: Link is Up - 100Mbps/Full - =
flow control off
> [  615.277509] BUG: unable to handle page fault for address: ffffc9000075=
2e98
> [  615.277598] #PF: supervisor read access in kernel mode
> [  615.277653] #PF: error_code(0x0000) - not-present page
> [  615.277706] PGD 100000067 P4D 100000067 PUD 1001f0067 PMD 102dad067 PT=
E 0
> [  615.277761] Oops: 0000 [#1] PREEMPT SMP
> [  615.277793] CPU: 14 PID: 147 Comm: kworker/14:1 Tainted: G           O=
E      6.6.0-rc4+ #2
> [  615.277877] Hardware name: HP HP Slim Desktop S01-pF3xxx/8B3C, BIOS F.=
05 02/08/2023
> [  615.277929] Workqueue: events_power_efficient phy_state_machine
> [  615.277978] RIP: 0010:phy_check_link_status+0x28/0xd0
> [  615.278018] Code: 1f 00 0f 1f 44 00 00 55 48 89 e5 41 56 53 f6 87 dd 0=
3 00 00 01 0f 85 ac 00 00 00 49 89 fe 48 8b 87 40 03 00 00 48 85 c0 74 13 <=
48> 8b 80 10 01 00 00 4c 89 f7 48 85 c0 74 0e ff d0 eb 0f bb fb ff
> [  615.278136] RSP: 0018:ffffc90000823de8 EFLAGS: 00010286
> [  615.278174] RAX: ffffc90000752d88 RBX: ffff8881023524e0 RCX: ffff88810=
2e39980
> [  615.278223] RDX: ffff88846fbb18e8 RSI: 0000000000000000 RDI: ffff88810=
2352000
> [  615.278269] RBP: ffffc90000823df8 R08: 8080808080808080 R09: fefefefef=
efefeff
> [  615.278316] R10: 0000000000000007 R11: 6666655f7265776f R12: ffff88846=
fbb18c0
> [  615.278364] R13: ffff888102b75000 R14: ffff888102352000 R15: ffff88810=
2352000
> [  615.278412] FS:  0000000000000000(0000) GS:ffff88846fb80000(0000) knlG=
S:0000000000000000
> [  615.278491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  615.278532] CR2: ffffc90000752e98 CR3: 0000000005433000 CR4: 000000000=
0750ee0
> [  615.278579] PKRU: 55555554
> [  615.278609] Call Trace:
> [  615.278629]  <TASK>
> [  615.278649]  ? __die_body+0x6b/0xb0
> [  615.278686]  ? __die+0x86/0x90
> [  615.278725]  ? page_fault_oops+0x369/0x3e0
> [  615.278771]  ? usb_control_msg+0xfc/0x140
> [  615.278809]  ? kfree+0x82/0x180
> [  615.278838]  ? usb_control_msg+0xfc/0x140
> [  615.278871]  ? kernelmode_fixup_or_oops+0xd5/0x100
> [  615.278923]  ? __bad_area_nosemaphore+0x69/0x290
> [  615.278972]  ? bad_area_nosemaphore+0x16/0x20
> [  615.279004]  ? do_kern_addr_fault+0x7c/0x90
> [  615.279036]  ? exc_page_fault+0xbc/0x220
> [  615.279081]  ? asm_exc_page_fault+0x27/0x30
> [  615.279120]  ? phy_check_link_status+0x28/0xd0
> [  615.279167]  ? mutex_lock+0x14/0x70
> [  615.279198]  phy_state_machine+0xb1/0x2c0
> [  615.279231]  process_one_work+0x16f/0x3f0
> [  615.279263]  ? wq_worker_running+0x11/0x90
> [  615.279310]  worker_thread+0x360/0x4c0
> [  615.279351]  ? __kthread_parkme+0x4c/0xb0
> [  615.279384]  kthread+0xf6/0x120
> [  615.279412]  ? pr_cont_work_flush+0xf0/0xf0
> [  615.279442]  ? kthread_blkcg+0x30/0x30
> [  615.279485]  ret_from_fork+0x35/0x40
> [  615.279528]  ? kthread_blkcg+0x30/0x30
> [  615.279570]  ret_from_fork_asm+0x11/0x20
> [  615.279619]  </TASK>
> [  615.279644] Modules linked in: asix(E) rust_ax88796b(OE) intel_rapl_ms=
r(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_=
common(E) rtw88_8821ce(E) rtw88_8821c(E) rtw88_pci(E) rtw88_core(E) x86_pkg=
_temp_thermal(E) intel_powerclamp(E) mac80211(E) coretemp(E) rapl(E) libarc=
4(E) nls_iso8859_1(E) mei_me(E) intel_cstate(E) input_leds(E) apple_mfi_fas=
tcharge(E) wmi_bmof(E) ee1004(E) cfg80211(E) mei(E) acpi_pad(E) acpi_tad(E)=
 sch_fq_codel(E) msr(E) ramoops(E) reed_solomon(E) pstore_blk(E) pstore_zon=
e(E) efi_pstore(E) ip_tables(E) x_tables(E) hid_generic(E) usbhid(E) hid(E)=
 usbnet(E) phylink(E) mii(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmu=
lni_intel(E) sha512_ssse3(E) r8169(E) aesni_intel(E) crypto_simd(E) cryptd(=
E) i2c_i801(E) i2c_smbus(E) realtek(E) xhci_pci(E) xhci_pci_renesas(E) vide=
o(E) wmi(E) [last unloaded: ax88796b(E)]
> [  615.280107] CR2: ffffc90000752e98
> [  615.280133] ---[ end trace 0000000000000000 ]---
> [  615.365054] RIP: 0010:phy_check_link_status+0x28/0xd0
> [  615.365065] Code: 1f 00 0f 1f 44 00 00 55 48 89 e5 41 56 53 f6 87 dd 0=
3 00 00 01 0f 85 ac 00 00 00 49 89 fe 48 8b 87 40 03 00 00 48 85 c0 74 13 <=
48> 8b 80 10 01 00 00 4c 89 f7 48 85 c0 74 0e ff d0 eb 0f bb fb ff
> [  615.365104] RSP: 0018:ffffc90000823de8 EFLAGS: 00010286
> [  615.365116] RAX: ffffc90000752d88 RBX: ffff8881023524e0 RCX: ffff88810=
2e39980
> [  615.365130] RDX: ffff88846fbb18e8 RSI: 0000000000000000 RDI: ffff88810=
2352000
> [  615.365144] RBP: ffffc90000823df8 R08: 8080808080808080 R09: fefefefef=
efefeff
> [  615.365157] R10: 0000000000000007 R11: 6666655f7265776f R12: ffff88846=
fbb18c0
> [  615.365171] R13: ffff888102b75000 R14: ffff888102352000 R15: ffff88810=
2352000
> [  615.365185] FS:  0000000000000000(0000) GS:ffff88846fb80000(0000) knlG=
S:0000000000000000
> [  615.365210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  615.365222] CR2: ffffc90000752e98 CR3: 0000000111635000 CR4: 000000000=
0750ee0
> [  615.365237] PKRU: 55555554
> [  615.365247] note: kworker/14:1[147] exited with irqs disabled
> [  619.668322] loop0: detected capacity change from 0 to 8
> [  919.664303] loop0: detected capacity change from 0 to 8
> [ 1219.660223] loop0: detected capacity change from 0 to 8
> [ 1519.656041] loop0: detected capacity change from 0 to 8
> [ 1819.651769] loop0: detected capacity change from 0 to 8
> [ 2119.647826] loop0: detected capacity change from 0 to 8
> [ 2419.643470] loop0: detected capacity change from 0 to 8

I think this is very weird, do you have any idea why this
could happen?

If you don't mind, could you try if the following changes
anything?

     (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:t=
t)*) =3D> {
         const N: usize =3D $crate::module_phy_driver!(@count_devices $($dr=
iver),+);
         struct Module {
             _drivers: [::kernel::net::phy::DriverVTable; N],
         }

         $crate::prelude::module! {
             type: Module,
             $($f)*
         }

         unsafe impl Sync for Module {}

         impl ::kernel::Module for Module {
             fn init(module: &'static ThisModule) -> Result<Self> {
=09=09const DRIVERS: [::kernel::net::phy::DriverVTable; N] =3D [$(::kernel:=
:net::phy::create_phy_driver::<$driver>()),+];
                 let mut m =3D Module {
                     _drivers: unsafe { core::ptr::read(&DRIVERS) },
                 };
                 let ptr =3D m._drivers.as_mut_ptr().cast::<::kernel::bindi=
ngs::phy_driver>();
                 ::kernel::error::to_result(unsafe {
                     kernel::bindings::phy_drivers_register(ptr, m._drivers=
.len().try_into()?, module.as_ptr())
                 })?;
                 Ok(m)
             }
         }

and also the variation where you replace `const DRIVERS` with
`static DRIVERS`.

--=20
Cheers,
Benno



