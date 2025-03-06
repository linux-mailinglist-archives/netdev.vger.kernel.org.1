Return-Path: <netdev+bounces-172314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94785A542DF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE07316C037
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2601A23BD;
	Thu,  6 Mar 2025 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PKgtvAwR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97119C554
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243236; cv=none; b=i3/P0Tzm7JJQgyEb/y7w3P8klm91YAN5qeUIdfbk/6A+qTV2oNpk3DuWYyLDUi2dLfStfQan9G2MQGWBPjncPAfEdukmNgoV7NxW4JWJgK1Y/GPk2+bpJnEOFxXq7ojQcZ1nlh/K8gDNxwvLo44qtLiPv9xOfI1rzbx/iB/EI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243236; c=relaxed/simple;
	bh=poRaLZotxeAx7eRpkVRIhLBJuCqX4j4hLMxZKrSeIPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnfYbMlKHGD6lOIQLMA7vlNC1WceCZUdGZQoixnAAEojf5Ls+ushUIcL95VkpyXx3/Q8dPDvVt5qz7jEuBt5pwG/MqGw3ZmX1CaDtjHOWhRS+Rn5RO5wR7w5ppwt2XAKSvk75a104E5LASLJXUOyXLtT7hSdDhs597T36iTh8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PKgtvAwR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fd6f7f8df9so2764087b3.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 22:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741243233; x=1741848033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+wA1WaB3OL2kzFQROojbHnSmI5JAC1EOz5LW1lXrp4=;
        b=PKgtvAwRJzUG+UiOVvK+nvHrWhSciRCDPseS4ADgvp77k35CWBdMer8zyqgYzdaMNp
         boiKMXMtqyLcSdmXHKkwMLBLp4L5LjexsH7huiF+gCOXZnZwu3nPo7gtQKNI2uQDlaO9
         cowCCvcHsqwWFsZXRukk8+VnZDSDNPJzITF1iRIiYNq2kTZwpnihw+Tyx/9uCGzHZvsv
         SBAo+FrrBzSY5jK1rhg3Lbh2uHF57J2+LlJBaj/ioiUbw4kV7gW6i19dqzN9vMa4YDQW
         U2j+NCOSlbZRZuqV4QxIrKZyLZQC4k94zhF0i2gkavmH0UnNBl/SJyrdNxABhAt+TnaM
         mjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243233; x=1741848033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+wA1WaB3OL2kzFQROojbHnSmI5JAC1EOz5LW1lXrp4=;
        b=IngzywfTCgY6Vp8Sc01KYnIp4b8IfXcmxCRP1K9TFJNTckQLuKNbCa9xS2DcDO/YeQ
         3uyDgOLq5zBC1PI8SVk5cXfpwdw+0+G4iJSdByta5KvWLahyS4DaCr6g82rj4JXETYrq
         pIT5dKjRpn6l8P0U594P6sIAlTpLxEbS2APuIcIYpJVjmIH2PyJ3scoPWJEFuY4FNolZ
         AYy3+eFB2MiZzOWrMmf94cLUiej1VgGeTzq3vT1LgRrh3EUcQuer2D+DhH6N/ShJUHNl
         O2OBN8BsH5iSBt3gMzhNrZfe46P3vY7VnXaR1By6kg+AbIcKZP4JzoMKIkO9RhsY430O
         qL6A==
X-Forwarded-Encrypted: i=1; AJvYcCX9MbkMSvtchTGqmIOrwQ57xXYamIOZV74OVn9HHYLuvgEbXRDP65OfzoBpWJInsLuWhDdCarA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykouB4oPa982zkRxPEOvcTvegsj0A/hTq+MH0buRjRiW55BEOw
	Ygg0JVQYhBEu4gP04GsNUxx/v2bVO8ctnYvEBgpgbfufNhxOJxsV3tsozg17mzXZVQdoG0LzGMg
	FDGyxKHfQV6Ng4m56ZudeEABgj8c5zBJ/hP8RLw==
X-Gm-Gg: ASbGncvyyL9Lsjt2kDeRUwqSgsKIkE07bCEV9/Pjy+w9l0i7H18RwOZ68v37IP7WGFo
	pUIZeqicLJwE8C28DtwpQlzIzIa1pfnMaVwl17NB3TXNKGOKNOOqxrcsr6m8eezVUSZ9PXALBcb
	0sG7CyTKcee/fhtLJSAL2tCC2J
X-Google-Smtp-Source: AGHT+IFJZbniMz+FePYkeNhJIXXQYby5pqDWg4b/uC3jGGrxa5dlAQxacZpYGGozFhW5+ZKU+VfGRs205pMsK4X4/3M=
X-Received: by 2002:a05:690c:64c5:b0:6fa:fd85:a2b6 with SMTP id
 00721157ae682-6feaeeda024mr31272057b3.13.1741243233027; Wed, 05 Mar 2025
 22:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227035459.90602-1-yue.zhao@shopee.com> <61d14c4e-f59f-4e84-851a-917406510aaf@intel.com>
 <CA+Rhe1H3RbLQecaPXujDjbqv7YhjeK46F2M41h4qoCgCjyG4nw@mail.gmail.com>
In-Reply-To: <CA+Rhe1H3RbLQecaPXujDjbqv7YhjeK46F2M41h4qoCgCjyG4nw@mail.gmail.com>
From: Yue Zhao <yue.zhao@shopee.com>
Date: Thu, 6 Mar 2025 14:40:21 +0800
X-Gm-Features: AQ5f1JqzmVCb9zDgON5RYgSb_JnrAH6C5aLMp3K97cIq0o3Pnt6DOyU0gzkbCd8
Message-ID: <CA+Rhe1HuiKiJ-3JcAO0kuZEh1BczJqmai+gQ8V9weKM2fpDvCA@mail.gmail.com>
Subject: Re: [PATCH] i40e: Disable i40e PCIe AER on system reboot
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, chunguang.xu@shopee.com, 
	haifeng.xu@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

I am resending as I realized I sent in Rich Text instead of Plain Text.
I am sorry if any of you got this duplicate email.

Our DELL servers are all out of warranty, so I cannot provide more
useful information from the communication with the vendor side.
Is there any possible fix via upgrading firmware or other components?

Thanks,
Best Regards

Yue


On Thu, Mar 6, 2025 at 12:28=E2=80=AFPM Yue Zhao <yue.zhao@shopee.com> wrot=
e:
>
> Hi Tony,
>
> Our DELL servers are all out of warranty, so I cannot provide more
> useful information from the communication with the vendor side.
> Is there any possible fix via upgrading firmware or other components?
>
> Thanks,
> Best Regards
>
> Yue
>
> On Thu, Mar 6, 2025 at 8:47=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@inte=
l.com> wrote:
>>
>> On 12/26/2024 7:54 PM, Yue Zhao wrote:
>> > Disable PCIe AER on the i40e device on system reboot on a limited
>> > list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
>> > on the i40e device during the ACPI _PTS (prepare to sleep) method for
>> > S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_pre=
p()
>> > as part of the kernel's reboot sequence as a result of commit
>> > 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
>>
>> Hi Yue,
>>
>> We've contacted Dell to try to root cause the issue and find the proper
>> fix. It would help if we could provide more information about the
>> problem and circumstances. Have you reported the issue to Dell? If so,
>> could you provide that to me (here or privately) so that we can pass
>> that along to help the investigation?
>>
>> Thank you,
>> Tony
>>
>> > We first noticed this abnormal reboot issue in tg3 device, and there
>> > is a similar patch about disable PCIe AER to fix hardware error during
>> > reboot. The hardware error in tg3 device has gone after we apply this
>> > patch below.
>> >
>> > https://lore.kernel.org/lkml/20241129203640.54492-1-lszubowi@redhat.co=
m/T/
>> >
>> > So we try to disable PCIe AER on the i40e device in the similar way.
>> >
>> > hardware crash dmesg log:
>> >
>> > ACPI: PM: Preparing to enter system sleep state S5
>> > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error S=
ource: 5
>> > {1}[Hardware Error]: event severity: fatal
>> > {1}[Hardware Error]:  Error 0, type: fatal
>> > {1}[Hardware Error]:   section_type: PCIe error
>> > {1}[Hardware Error]:   port_type: 0, PCIe end point
>> > {1}[Hardware Error]:   version: 3.0
>> > {1}[Hardware Error]:   command: 0x0006, status: 0x0010
>> > {1}[Hardware Error]:   device_id: 0000:05:00.1
>> > {1}[Hardware Error]:   slot: 0
>> > {1}[Hardware Error]:   secondary_bus: 0x00
>> > {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x1572
>> > {1}[Hardware Error]:   class_code: 020000
>> > {1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_uncor_mask: 0=
x00018000
>> > {1}[Hardware Error]:   aer_uncor_severity: 0x000ef030
>> > {1}[Hardware Error]:   TLP Header: 40000001 0000000f 90028090 00000000
>> > Kernel panic - not syncing: Fatal hardware error!
>> > Hardware name: Dell Inc. PowerEdge C4140/08Y2GR, BIOS 2.21.1 12/12/202=
3
>> > Call Trace:
>> >   <NMI>
>> >   dump_stack_lvl+0x48/0x70
>> >   dump_stack+0x10/0x20
>> >   panic+0x1b4/0x3a0
>> >   __ghes_panic+0x6c/0x70
>> >   ghes_in_nmi_queue_one_entry.constprop.0+0x1ee/0x2c0
>> >   ghes_notify_nmi+0x5e/0xe0
>> >   nmi_handle+0x62/0x160
>> >   default_do_nmi+0x4c/0x150
>> >   exc_nmi+0x140/0x1f0
>> >   end_repeat_nmi+0x16/0x67
>> > RIP: 0010:intel_idle_irq+0x70/0xf0
>> >   </NMI>
>> >   <TASK>
>> >   cpuidle_enter_state+0x91/0x6f0
>> >   cpuidle_enter+0x2e/0x50
>> >   call_cpuidle+0x23/0x60
>> >   cpuidle_idle_call+0x11d/0x190
>> >   do_idle+0x82/0xf0
>> >   cpu_startup_entry+0x2a/0x30
>> >   rest_init+0xc2/0xf0
>> >   arch_call_rest_init+0xe/0x30
>> >   start_kernel+0x34f/0x440
>> >   x86_64_start_reservations+0x18/0x30
>> >   x86_64_start_kernel+0xbf/0x110
>> >   secondary_startup_64_no_verify+0x18f/0x19b
>> >   </TASK>
>> >
>> > Fixes: 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot")
>> > Signed-off-by: Yue Zhao <yue.zhao@shopee.com>
>> > ---
>> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 64 +++++++++++++++++++=
++
>> >   1 file changed, 64 insertions(+)
>> >
>> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net=
/ethernet/intel/i40e/i40e_main.c
>> > index 0e1d9e2fbf38..80e66e4e90f7 100644
>> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> > @@ -8,6 +8,7 @@
>> >   #include <linux/module.h>
>> >   #include <net/pkt_cls.h>
>> >   #include <net/xdp_sock_drv.h>
>> > +#include <linux/dmi.h>
>> >
>> >   /* Local includes */
>> >   #include "i40e.h"
>> > @@ -16608,6 +16609,56 @@ static void i40e_pci_error_resume(struct pci_=
dev *pdev)
>> >       i40e_io_resume(pf);
>> >   }
>> >
>> > +/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fat=
al
>> > + * PCIe AER event on the i40e device if the i40e device is not, or ca=
nnot
>> > + * be, powered down.
>> > + */
>> > +static const struct dmi_system_id i40e_restart_aer_quirk_table[] =3D =
{
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge C4140"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
>> > +             },
>> > +     },
>> > +     {
>> > +             .matches =3D {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
>> > +             },
>> > +     },
>> > +     {}
>> > +};
>> > +
>> >   /**
>> >    * i40e_shutdown - PCI callback for shutting down
>> >    * @pdev: PCI device information struct
>> > @@ -16654,6 +16705,19 @@ static void i40e_shutdown(struct pci_dev *pde=
v)
>> >       i40e_clear_interrupt_scheme(pf);
>> >       rtnl_unlock();
>> >
>> > +     if (system_state =3D=3D SYSTEM_RESTART &&
>> > +             dmi_first_match(i40e_restart_aer_quirk_table) &&
>> > +             pdev->current_state <=3D PCI_D3hot) {
>> > +             /* Disable PCIe AER on the i40e to avoid a fatal
>> > +              * error during this system restart.
>> > +              */
>> > +             pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
>> > +                                        PCI_EXP_DEVCTL_CERE |
>> > +                                        PCI_EXP_DEVCTL_NFERE |
>> > +                                        PCI_EXP_DEVCTL_FERE |
>> > +                                        PCI_EXP_DEVCTL_URRE);
>> > +     }
>> > +
>> >       if (system_state =3D=3D SYSTEM_POWER_OFF) {
>> >               pci_wake_from_d3(pdev, pf->wol_en);
>> >               pci_set_power_state(pdev, PCI_D3hot);
>>

