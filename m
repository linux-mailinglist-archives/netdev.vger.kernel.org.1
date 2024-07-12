Return-Path: <netdev+bounces-111152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA8930167
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A972827B5
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1458224EA;
	Fri, 12 Jul 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b="JjP583oa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7F1094E
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818147; cv=none; b=ADSBtA0iOW9ac9M8PwK1B3c8lozVEXLURHDmYZByYJ8VggycYFHHIpOTqehH2zI2FcN8S2ijKa3gvSEgytGsKfkGOQfCLR9K4a7Ke6+gwy5FboyEZHyzGFQVRWlOHJMi/hPqohbtRxNWWOa8ISVfWhTQHtNC98OoW/OfZiFYozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818147; c=relaxed/simple;
	bh=M6wE5URaeF2ShSliLbooNDbDJHfReL4OqM2OJJCkpJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjJXswZlTSMupbDJzDv0HqgRHsxgy5laVCyW3VqdhSZCtfIIgEEstNUPfSHUWqXVPSibizb0CeR02AVacgnCrnBDYkG46xsI/sjwmU6bCoyy9qbe6yocMSep+aNlRzefyDLDzi2Li9Ma3C29lRujBqSsFqoZ3FxvdIq3jHm/ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com; spf=pass smtp.mailfrom=x.com; dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b=JjP583oa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c349bb81so291621566b.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x.com; s=google; t=1720818144; x=1721422944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qMopZnjubHx0EGq0+EbBnOiUNikdh8fUuWiyj4nhgk=;
        b=JjP583oaaj9PGzigk1bA4x2I+5TksZ+Li92e/PLBkCYqgYKBH0du8vTlNPn56lCy02
         HJA0w9GGAiem6FPBut9Etpw8it7YQ35jZgYuM5s2bFfaaaT0jSezZlCwDXiTdb/lZpkF
         otOo2/DtC+0W2RwTaIH58XyeacnIxhs2CfzaEB1ksmCAo8kruCIjmDXpRLyG9WvLhA9Z
         NrDtZqFQF46SJAmMn1KXlvvg75NbUfFJ1mm6VViERWbKVlos61iVdEUNbvEHwymTLw8b
         AQiV60krcYzylBLDxznhAFZLbCWDKm511PvI2fIhk4JL4s1PQpaTzimAFGVZckrHy1F5
         VjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818144; x=1721422944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qMopZnjubHx0EGq0+EbBnOiUNikdh8fUuWiyj4nhgk=;
        b=kmgP9iPv//nkAQh7vJOk+tqkTdYbNntGoBRA+aew8Iyy5OtHrY/ejysu71PXXSCGQq
         AMwCoZTtt/KY/PaTGp5dL+hj4giA3K8sCuNl3inOpLi4fNifE2CW+/vDWWvmQ7Huum9m
         T1dJNqu0WHR/quh2xibnVH9BfZAuuFYU1fp20n19d2xoFFxMavdSPNpxlH9Io3KZa3x3
         8aLu2fNsumNNmhQw1SYDtx6q88fdIDT2O1iaSMO+iTSvAYZQDX8azaUFiuw1qNu1bQbH
         GuaImOFb/SUf8gcZlY9Fal32NvGj0izV7TEiH29mGFdt6rVosUX1LmUBgnUxGm+KbeKT
         u0uw==
X-Gm-Message-State: AOJu0Yz+kOSvti/rD5GMsz+/3UcHngYsqn0Ci/DPx2Ri5Y/JQiZpWYt5
	uXc31spVDuz9QH0MnR9kiY0b+o5ncu3W0qL99Zt7QkYDB9GmmQWZssZRTjJbQwXja7XFEAvdG32
	yXtKEGjyiXMfMyRsI9bmVXdKDduim+HcQRSnLow==
X-Google-Smtp-Source: AGHT+IGeWxoIl+MWK9L2uIEVi13mW4RM/7Wp4VTVUV7SKVWqSil8MwGQNChlerBAVRrsJ69Wk0eMM6NaKDgyW+YkFJU=
X-Received: by 2002:a17:907:7284:b0:a77:d1ea:ab36 with SMTP id
 a640c23a62f3a-a780b68a2d7mr1047863366b.6.1720818143918; Fri, 12 Jul 2024
 14:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
 <Zo_bsLPrRHHiVMPd@shredder.mtl.com> <CAHXsExy8LKzocBdBzss_vjOpc_TQmyzM87KC192HpmuhMcqasg@mail.gmail.com>
In-Reply-To: <CAHXsExy8LKzocBdBzss_vjOpc_TQmyzM87KC192HpmuhMcqasg@mail.gmail.com>
From: Jason Zhou <jasonzhou@x.com>
Date: Fri, 12 Jul 2024 17:02:13 -0400
Message-ID: <CAHXsExwuSyn7eVMqiOcatU5C3WHsdHEnLJcVh-jf2LjmzW2Edg@mail.gmail.com>
Subject: Re: PROBLEM: Issue with setting veth MAC address being unreliable.
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Benjamin Mahler <bmahler@x.com>, Jun Wang <junwang@x.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

We have performed our own testing with the MacAddressPolicy set to
none rather than persistent on CentOS 9, and it fixed the problem we
were seeing with the MAC address mismatches before and after us trying
to manually set it.
So we're pretty confident that the cause is what Ido stated, and that
we were racing against udev as we did not set a MAC address when
creating our veth device pair, making udev think it should give out a
new MAC address.
We will release a patch on Apache Mesos to mitigate this potential
race condition on systems with systemd version > 242.
Thank you so much for the help!

For documenting this issue, I believe that this race condition would
also be present for the peer veth interface?
We create the peer along with veth and move the peer to another
namespace, but udev would be notified of its creation, so it will try
to also overwrite the peer's MAC address.
However this is not an issue for the loopback interface that comes
with every namespace creation, as they will not be affected by
NetworkManager and hence udev will not try to modify them.
Please correct me if I'm wrong!

Once again, thanks for all the help!
Best regards,
Jason Zhou
Software Engineering Intern
jasonzhou@x.com


On Thu, Jul 11, 2024 at 10:07=E2=80=AFAM Jason Zhou <jasonzhou@x.com> wrote=
:
>
> Apologies for the late reply,
>
> > When you say 5.15.161, do you mean true 5.15.161, or is this CentOS
> > version of 5.15.161 with 1000s of patches on top? Did you download the
> > sources from www.kernel.org and build it yourself?
>
> For Andrew's question, yes, we do use the mainline 5.15 LTS kernel
> which we built ourselves from the www.kernel.org sources.
>
> On Thu, Jul 11, 2024 at 9:18=E2=80=AFAM Ido Schimmel <idosch@idosch.org> =
wrote:
> >
> > On Wed, Jul 10, 2024 at 04:45:55PM -0400, Jason Zhou wrote:
> > > [1.] One line summary of the problem:
> > >
> > > Issue with setting veth address being unreliable.
> > >
> > > [2.] Full description of the problem/report:
> > >
> > > Hello!
> > >
> > > We have been investigating a strange behavior within Apache Mesos
> > > where after setting the MAC address on a veth device to the same
> > > address as our eth0 MAC address, the change is sometimes not reflecte=
d
> > > appropriately despite the ioctl call succeeding (~4% of the time in
> > > our testing). Note that we also tried using libnl to set the MAC
> > > address but the issue still persists.
> > >
> > > Included below is the github link to the section where we set the vet=
h
> > > address, to clarify what we were trying to do. We first create the
> > > veth pair [1] using a libnl function [2], then we set the veth device
> > > MAC addresses to that of our host public interface (eth0) [3] using a
> > > function called setMAC. Inside the setMAC [4] is where we are
> > > observing the aforementioned issue with unreliable setting of veth
> > > addresses..
> > >
> > > This behavior was observed when re-fetching the MAC address on said
> > > veth device after we made the function call to set its MAC address. W=
e
> > > have observed this issue on CentOS 9 only, but not on CentOS 7. We
> > > have tried Linux kernels 5.15.147, 5.15.160 & 5.15.161 for CentOS 9,
> > > CentOS 7 was using 5.10, but we also tried upgrading the Centos 7 hos=
t
> > > to 5.15.160 but could not reproduce the bug.
> >
> > This suggests that the change in behavior is due to a change in user
> > space and an obvious suspect is systemd / udev. AFAICT, CentOS 7 is
> > using systemd 219 whereas CentOS 9 is using systemd 252. In version 242
> > systemd started setting a persistent MAC address on virtual interfaces.
> > See:
> >
> > https://github.com/Mellanox/mlxsw/wiki/Persistent-Configuration#require=
d-changes-to-macaddresspolicy
> >
> > If that is the issue, then you can either change MACAddressPolicy or
> > modify your code to create the veth pair with the correct MAC address
> > from the start.
> >
> > As I understand it, a possible explanation for the race is that your
> > program is racing with udev. Udev receives an event about a new device
> > and reads "addr_assign_type" from sysfs. If your program changed the MA=
C
> > address before udev read the file, then udev will read 3 (NET_ADDR_SET)
> > and will not try to change the MAC address. Otherwise, both your progra=
m
> > and udev will try to change the MAC address.
> >
> > If it is not udev that is changing the MAC address, then you can run th=
e
> > following bpftrace script in a different terminal and check which
> > processes try to change the address:
> >
> > bpftrace -e 'k:dev_set_mac_address_user { @[comm] =3D count(); }'
> >
> > It is only a theory. Actual issue might be entirely different.
> >
>
> Thank you Ido, we will test whether the systemd change is the true
> culprit behind this, and will follow up with what we find :)
>
> Appreciate all the help so far!
>
> Best regards,
> Jason Zhou
> Software Engineering Intern
> jasonzhou@x.com
>
>
> > >
> > > We were re-fetching the addresses via the ioctl SIOCGIFHWADDR syscall
> > > as well as via getifaddr (which appears to use netlink under the
> > > covers), and, in problematic cases, both functions reported
> > > discrepancies from the target MAC address we were initially setting
> > > to. We also performed a fetch before we set the MAC addresses and
> > > found that there are instances where getifaddr and ioctl results do
> > > not match for our veth device *even before we perform any setting of
> > > the MAC address*. It's also worth noting that after setting the MAC
> > > address: there are no cases where ioctl or getifaddr come back with
> > > the same MAC address as before we set the address. So, the set
> > > operation always seems to have an effect.
> > >
> > > Observed scenarios with incorrectly assigned MAC addresses:
> > >
> > > (1) After setting the mac address: ioctl returns the correct MAC
> > > address, but the results from getifaddr, returns an incorrect MAC
> > > address (different from the original value before setting as well!)
> > >
> > > (2) After setting the MAC address: both ioctl and getifaddr return th=
e
> > > same MAC address, but are both wrong (and different from the original
> > > one!)
> > >
> > > (3) There is a possibility that the MAC address we set ends up
> > > overwritten by a garbage value *after* we have already updated the MA=
C
> > > address, and checked that the MAC address was set correctly. Since
> > > this error happens after this function has finished, we cannot log no=
r
> > > detect it in the function where we set the MAC address because we hav=
e
> > > not yet studied at what point this late overwriting of MAC address
> > > occurs. It=E2=80=99s worth noting that this is the rarest scenario th=
at we
> > > have encountered, and we were only able to reproduce it in our testin=
g
> > > cluster machine, not in any of the production cluster machines.
> > >
> > > [3.] Keywords:
> > >
> > > networking, veth, kernel, MAC, netlink
> > >
> > > [X.] Other notes, patches, fixes, workarounds:
> > >
> > > Notes:
> > >
> > > More specific kernel and environment information will be available on
> > > request for security reasons, please let us know if you are intereste=
d
> > > and we will be happy to provide you with the necessary information.
> > >
> > > We have observed this behavior only on CentOS 9 systems at the moment=
,
> > > CentOS 7 systems under various kernels do not seem to have the issue
> > > (which is quite strange if this was purely a kernel bug).
> > >
> > > We have tried kernels 5.15.147, 5.15.160, 5.15.161, all of these have
> > > this issue on CentOS 9.
> > >
> > > We have also tried rewriting our function for setting MAC address to
> > > use libnl rather than ioctl to perform the MAC address setting, but i=
t
> > > did not eliminate the issue.
> > >
> > > To work around this bug, we checked that the MAC address is set
> > > correctly after the ioctl set call, and retry the address setting if
> > > necessary. In our testing, this workaround appears to remedy scenario=
s
> > > (1) and (2) above, but it does not address scenario (3).  You can see
> > > it here:
> > >
> > > https://github.com/apache/mesos/commit/8b202bbebdc89429ad82c6983aa1c5=
14eb1b8d95
> > >
> > > We would greatly appreciate any insights or guidance on this matter.
> > > Please let me know if you need further information or if there are an=
y
> > > specific tests we should run to assist in diagnosing the issue. Again=
,
> > > specific details for the production machines on which we encountered
> > > this error can be provided upon request, so please let us know if
> > > there is anything we can provide to help.
> > >
> > > Thank you for your time and assistance.
> > >
> > > Best regards,
> > > Jason Zhou
> > > Software Engineering Intern
> > > jasonzhou@x.com
> > >
> > > embedded links:
> > > [1] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa42842=
4b3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.c=
pp#L3599
> > > [2] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa42842=
4b3c0fbc7ff0/src/linux/routing/link/veth.cpp#L45
> > > [3] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa42842=
4b3c0fbc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.c=
pp#L3628
> > > [4] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa42842=
4b3c0fbc7ff0/src/linux/routing/link/link.cpp#L283
> > >

