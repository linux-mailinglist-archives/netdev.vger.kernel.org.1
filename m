Return-Path: <netdev+bounces-110862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678592EA4A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E28B226D8
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8614BFA2;
	Thu, 11 Jul 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b="VWv10hri"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE53161936
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706885; cv=none; b=INrXPOWaOPlS9bWqSQoE0jOMPNMKuMEFRAFJZQfoN2fepMRycf3atjGdt4a8x6VY5IMAAzigHd2O/hK1WNiv8FMuRKFx/YUoq5+IG3nqCyNjg/T9rnlofdZIlTMNZ2n+6RaU01A5CmeXqmGf01XEZPmIQbZNZ0HHL1rHzktfAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706885; c=relaxed/simple;
	bh=EfCLDbx4uruTRcqdPOaczTVTd9Bmpydat8nE66me17U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqMVHKs+fJAdpykgd5y/GRMECpfiSIhhPz3Y/sQcbArksN/QsY4+tPdhQvOF7hnE02wsBvKfDx8JGDqvrcAlQeMtx2f1rGDiHV6NdyDwQX1BHkgtyQ9rhlcglyXXUIGRGGCTf8zATBzyKqEPv/GWEEdauV5hUrjMPS5cc0QHcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com; spf=pass smtp.mailfrom=x.com; dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b=VWv10hri; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so121403966b.3
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x.com; s=google; t=1720706881; x=1721311681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqI/PkK/IO+tkrGGRiQCrsqqf5J9Nfd22r0Qhcr+fgk=;
        b=VWv10hriatUjnloMUymDp6U67R68yprbEfgD7IhjwlyK3FV+39So+amm5ZtRG/Uu1X
         rUAFeI0VXYtZHFjEgdlZaq1WrwICeCbOp1GjHwc0RHu7ouWTVCTp8FFNSd2wmcrYgoQp
         tiK1NXO1f22xmWscdwewwUq8BRjNNPFZoS8jiEzq1B0JhIpoTh/I1TTYef1Is1Qr4Tt5
         v5e1F7z08jbQo8EXyQYnQ3D9+sNRRQFwth02gRwVYZgt6Rt5Gh6pytOwT5GukUrW8RWl
         APvsFuOWqJ8QnY82h8JALUplyuDL7T8olHJdEz0gM/3oHL6vE13Y0tdrtzt6JdlIE95n
         ExKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706881; x=1721311681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqI/PkK/IO+tkrGGRiQCrsqqf5J9Nfd22r0Qhcr+fgk=;
        b=FUYvqgZKlnMyfyhrNrKwHS9hWjPGmUlnTubgynHWhTm6mx5XUGYiemoAHJh5wqIdf7
         rVHPOOHtGpsmRwyYOKRy2zhZ6i5hmnOBJVP+rqAdo26IFNL7Yh4QNoUtLbkPwAvOFWpf
         Ftnutw8eWiVdLFvUN+SOV8Alu3nNl6TH9NbHiJgDlF+A5rxQrVmngbuzNy0IpE8B5XUN
         eg8GCHseFOOWdZ0HDRnpz9n4kDYh6DxuvLkjUX1auODa3PCN4OwHLAd8QKv2Sk0Vl7KL
         QnPgssAJk8psyJp4Tj7VRoiTeeVZY0iQ7k6ZLG8eICY+pXS8fqDfzEJsSAXF/LSfBpWF
         a3aA==
X-Gm-Message-State: AOJu0Yz1FOvtIf/RCh2hiyp/7NsBKawZaj4GfYao/zSUBhLHwZHeOuGu
	TWjnEMKE3Mxh1trIx9eBkmFORR4ZGX00EFU43SB1qJ+6JNyKUVL6r3ZtLtPSUFPtUvE1dCXl5ML
	fdRx7kCayhRBC4EbCbHyLFoOsDWVdMEEaS7MDhw==
X-Google-Smtp-Source: AGHT+IHVDZTSm6gQuwD1mZEoEBdRU0bNeViIbaQedkRj+iIMUMwk3z0V4vACozGaR6OafnxQABy0pTT7OcfbaPq190g=
X-Received: by 2002:a17:907:7759:b0:a77:c364:c4f1 with SMTP id
 a640c23a62f3a-a780b705189mr555594766b.46.1720706880695; Thu, 11 Jul 2024
 07:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
 <Zo_bsLPrRHHiVMPd@shredder.mtl.com>
In-Reply-To: <Zo_bsLPrRHHiVMPd@shredder.mtl.com>
From: Jason Zhou <jasonzhou@x.com>
Date: Thu, 11 Jul 2024 10:07:49 -0400
Message-ID: <CAHXsExy8LKzocBdBzss_vjOpc_TQmyzM87KC192HpmuhMcqasg@mail.gmail.com>
Subject: Re: PROBLEM: Issue with setting veth MAC address being unreliable.
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Benjamin Mahler <bmahler@x.com>, Jun Wang <junwang@x.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the late reply,

> When you say 5.15.161, do you mean true 5.15.161, or is this CentOS
> version of 5.15.161 with 1000s of patches on top? Did you download the
> sources from www.kernel.org and build it yourself?

For Andrew's question, yes, we do use the mainline 5.15 LTS kernel
which we built ourselves from the www.kernel.org sources.

On Thu, Jul 11, 2024 at 9:18=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Wed, Jul 10, 2024 at 04:45:55PM -0400, Jason Zhou wrote:
> > [1.] One line summary of the problem:
> >
> > Issue with setting veth address being unreliable.
> >
> > [2.] Full description of the problem/report:
> >
> > Hello!
> >
> > We have been investigating a strange behavior within Apache Mesos
> > where after setting the MAC address on a veth device to the same
> > address as our eth0 MAC address, the change is sometimes not reflected
> > appropriately despite the ioctl call succeeding (~4% of the time in
> > our testing). Note that we also tried using libnl to set the MAC
> > address but the issue still persists.
> >
> > Included below is the github link to the section where we set the veth
> > address, to clarify what we were trying to do. We first create the
> > veth pair [1] using a libnl function [2], then we set the veth device
> > MAC addresses to that of our host public interface (eth0) [3] using a
> > function called setMAC. Inside the setMAC [4] is where we are
> > observing the aforementioned issue with unreliable setting of veth
> > addresses..
> >
> > This behavior was observed when re-fetching the MAC address on said
> > veth device after we made the function call to set its MAC address. We
> > have observed this issue on CentOS 9 only, but not on CentOS 7. We
> > have tried Linux kernels 5.15.147, 5.15.160 & 5.15.161 for CentOS 9,
> > CentOS 7 was using 5.10, but we also tried upgrading the Centos 7 host
> > to 5.15.160 but could not reproduce the bug.
>
> This suggests that the change in behavior is due to a change in user
> space and an obvious suspect is systemd / udev. AFAICT, CentOS 7 is
> using systemd 219 whereas CentOS 9 is using systemd 252. In version 242
> systemd started setting a persistent MAC address on virtual interfaces.
> See:
>
> https://github.com/Mellanox/mlxsw/wiki/Persistent-Configuration#required-=
changes-to-macaddresspolicy
>
> If that is the issue, then you can either change MACAddressPolicy or
> modify your code to create the veth pair with the correct MAC address
> from the start.
>
> As I understand it, a possible explanation for the race is that your
> program is racing with udev. Udev receives an event about a new device
> and reads "addr_assign_type" from sysfs. If your program changed the MAC
> address before udev read the file, then udev will read 3 (NET_ADDR_SET)
> and will not try to change the MAC address. Otherwise, both your program
> and udev will try to change the MAC address.
>
> If it is not udev that is changing the MAC address, then you can run the
> following bpftrace script in a different terminal and check which
> processes try to change the address:
>
> bpftrace -e 'k:dev_set_mac_address_user { @[comm] =3D count(); }'
>
> It is only a theory. Actual issue might be entirely different.
>

Thank you Ido, we will test whether the systemd change is the true
culprit behind this, and will follow up with what we find :)

Appreciate all the help so far!

Best regards,
Jason Zhou
Software Engineering Intern
jasonzhou@x.com


> >
> > We were re-fetching the addresses via the ioctl SIOCGIFHWADDR syscall
> > as well as via getifaddr (which appears to use netlink under the
> > covers), and, in problematic cases, both functions reported
> > discrepancies from the target MAC address we were initially setting
> > to. We also performed a fetch before we set the MAC addresses and
> > found that there are instances where getifaddr and ioctl results do
> > not match for our veth device *even before we perform any setting of
> > the MAC address*. It's also worth noting that after setting the MAC
> > address: there are no cases where ioctl or getifaddr come back with
> > the same MAC address as before we set the address. So, the set
> > operation always seems to have an effect.
> >
> > Observed scenarios with incorrectly assigned MAC addresses:
> >
> > (1) After setting the mac address: ioctl returns the correct MAC
> > address, but the results from getifaddr, returns an incorrect MAC
> > address (different from the original value before setting as well!)
> >
> > (2) After setting the MAC address: both ioctl and getifaddr return the
> > same MAC address, but are both wrong (and different from the original
> > one!)
> >
> > (3) There is a possibility that the MAC address we set ends up
> > overwritten by a garbage value *after* we have already updated the MAC
> > address, and checked that the MAC address was set correctly. Since
> > this error happens after this function has finished, we cannot log nor
> > detect it in the function where we set the MAC address because we have
> > not yet studied at what point this late overwriting of MAC address
> > occurs. It=E2=80=99s worth noting that this is the rarest scenario that=
 we
> > have encountered, and we were only able to reproduce it in our testing
> > cluster machine, not in any of the production cluster machines.
> >
> > [3.] Keywords:
> >
> > networking, veth, kernel, MAC, netlink
> >
> > [X.] Other notes, patches, fixes, workarounds:
> >
> > Notes:
> >
> > More specific kernel and environment information will be available on
> > request for security reasons, please let us know if you are interested
> > and we will be happy to provide you with the necessary information.
> >
> > We have observed this behavior only on CentOS 9 systems at the moment,
> > CentOS 7 systems under various kernels do not seem to have the issue
> > (which is quite strange if this was purely a kernel bug).
> >
> > We have tried kernels 5.15.147, 5.15.160, 5.15.161, all of these have
> > this issue on CentOS 9.
> >
> > We have also tried rewriting our function for setting MAC address to
> > use libnl rather than ioctl to perform the MAC address setting, but it
> > did not eliminate the issue.
> >
> > To work around this bug, we checked that the MAC address is set
> > correctly after the ioctl set call, and retry the address setting if
> > necessary. In our testing, this workaround appears to remedy scenarios
> > (1) and (2) above, but it does not address scenario (3).  You can see
> > it here:
> >
> > https://github.com/apache/mesos/commit/8b202bbebdc89429ad82c6983aa1c514=
eb1b8d95
> >
> > We would greatly appreciate any insights or guidance on this matter.
> > Please let me know if you need further information or if there are any
> > specific tests we should run to assist in diagnosing the issue. Again,
> > specific details for the production machines on which we encountered
> > this error can be provided upon request, so please let us know if
> > there is anything we can provide to help.
> >
> > Thank you for your time and assistance.
> >
> > Best regards,
> > Jason Zhou
> > Software Engineering Intern
> > jasonzhou@x.com
> >
> > embedded links:
> > [1] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b=
3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp=
#L3599
> > [2] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b=
3c0fbc7ff0/src/linux/routing/link/veth.cpp#L45
> > [3] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b=
3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp=
#L3628
> > [4] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b=
3c0fbc7ff0/src/linux/routing/link/link.cpp#L283
> >

