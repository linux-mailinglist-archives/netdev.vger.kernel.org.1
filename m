Return-Path: <netdev+bounces-110663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C6892DA61
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7466C1C20C82
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572B195985;
	Wed, 10 Jul 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b="gsu0VVQT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5751DF71
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644369; cv=none; b=UrS7e1XYqcItvdHBg5zRhTGth7kcT6cz2DJjE7chbVo/Pfb3dlvLEqhI8/bbWZfcrYix6Tgy2ld/6vrtr+/MlOWBAOxroa0Ig076vkMJbMD6w9QXQSozogHAy00Kfg4kCIawHksEI8ex/b+US8ki6lqbIQ6JMkjMRjOYqhjqe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644369; c=relaxed/simple;
	bh=HvSj3L9BuqgtfxTMfDrP2x6ikPbyHR1InoaZLK+cOh8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tsn0NfLom5ZvvP5qF2Rfm0ni7eNmfyCwkDVq9qAKfTRd2FUGh11vYUX/SvZ8HtD2/ptSlF3n3rT7lqMKrmIPWfdGdVLuSAe/2gyWtdG3Cnb04npU/58Ux/K+PSlEy4rZATd0Xn0mbdtNVvF+xZEorJVd4g1oqMYSA8me21C5E7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com; spf=pass smtp.mailfrom=x.com; dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b=gsu0VVQT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e5929033so30748766b.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x.com; s=google; t=1720644366; x=1721249166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2Glwt4bgQawUEA4GPp2NmylHyb3+OLwsKS9Xy4/m64=;
        b=gsu0VVQT7Bs17LsYobK8/s+JqZ3IcyV7iSRvCQde+kuSHzU1N+2rdsFd1zQ83+PQHe
         58cDIL3r4Jt51Vll95FjeP79ZYussFpqpZiXZpDEjOSXHmG8ndQsT9NOzy1N90aO6bCf
         16YCL/nfJqOVrnZfXffQy8hfnVcI4wQnSsw9JJicf3tFl2lvon0alV+f1dQ2lekeW9ft
         OMTnLzTxEveYa2SS4iDebp81jY0RzvhrgfPULEEnqIiNDtY0xR/aUR+4hnEVRTwRUY2V
         snif8w2lEh0Tn+SHvKQ/25kug4Of0UQ1CtG1l08jzW9HNNy+SI4/ZLQxj7RiO7VNl59f
         KLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644366; x=1721249166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2Glwt4bgQawUEA4GPp2NmylHyb3+OLwsKS9Xy4/m64=;
        b=t4qwtSZGlOjXYzlsatkFaCX5xMlnCWvCefg5+ow7YixcX6jnwXQThMx1ZxV+EBS8Fu
         +5yxZk0h414MMbmk49nfnmZ5DWu6WOyNkT8C9tK7l5FwIOAlKtBVxcbyKP3sVK/Y75vE
         TZPU7b5w5Iv4uT4kN1soztdHKCcrpfGdFC6/CfaoZjH8Ds71qZmSJHqdicFYZnbJmV0b
         JHPdud6TXMwDXcMfSubrINqg9k28m6qju1G+ipi/21NXCFMoAxonts7NSvEu72kculxS
         OLiellk+KmArqksDs2a5sNHQzOqzFCCpALG8QiqLLy70Yon2qYAr7+hTphlkNCtPHktg
         q0sQ==
X-Gm-Message-State: AOJu0YwFhH8eewOTktLktwbEN8bUTrnZfkuvXm7wHTf+rmhQWuSD2h9t
	KULEYQ3lis23SxkV6Ra/W+xwcEoxew41pAkXMUzt71kLrIBehH0ZBfoOT8C/ZRg/0vyPA/pQWrh
	Bn9y75/QgnqANhQHmibvGYMo4tlTLWoZncuw/jRgycxsaTl6AWP8=
X-Google-Smtp-Source: AGHT+IF3IpjqYr2SviPdo0E6UGM57I9VATWgRPKwoBotETRmu3Ru9rxPpuCHytGNX8UpCQUCnYZWPXLHx15RAms3klc=
X-Received: by 2002:a17:906:3402:b0:a77:b5c2:399 with SMTP id
 a640c23a62f3a-a780b6b2013mr405847666b.31.1720644365832; Wed, 10 Jul 2024
 13:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Zhou <jasonzhou@x.com>
Date: Wed, 10 Jul 2024 16:45:55 -0400
Message-ID: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
Subject: PROBLEM: Issue with setting veth MAC address being unreliable.
To: netdev@vger.kernel.org
Cc: Benjamin Mahler <bmahler@x.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[1.] One line summary of the problem:

Issue with setting veth address being unreliable.

[2.] Full description of the problem/report:

Hello!

We have been investigating a strange behavior within Apache Mesos
where after setting the MAC address on a veth device to the same
address as our eth0 MAC address, the change is sometimes not reflected
appropriately despite the ioctl call succeeding (~4% of the time in
our testing). Note that we also tried using libnl to set the MAC
address but the issue still persists.

Included below is the github link to the section where we set the veth
address, to clarify what we were trying to do. We first create the
veth pair [1] using a libnl function [2], then we set the veth device
MAC addresses to that of our host public interface (eth0) [3] using a
function called setMAC. Inside the setMAC [4] is where we are
observing the aforementioned issue with unreliable setting of veth
addresses..

This behavior was observed when re-fetching the MAC address on said
veth device after we made the function call to set its MAC address. We
have observed this issue on CentOS 9 only, but not on CentOS 7. We
have tried Linux kernels 5.15.147, 5.15.160 & 5.15.161 for CentOS 9,
CentOS 7 was using 5.10, but we also tried upgrading the Centos 7 host
to 5.15.160 but could not reproduce the bug.

We were re-fetching the addresses via the ioctl SIOCGIFHWADDR syscall
as well as via getifaddr (which appears to use netlink under the
covers), and, in problematic cases, both functions reported
discrepancies from the target MAC address we were initially setting
to. We also performed a fetch before we set the MAC addresses and
found that there are instances where getifaddr and ioctl results do
not match for our veth device *even before we perform any setting of
the MAC address*. It's also worth noting that after setting the MAC
address: there are no cases where ioctl or getifaddr come back with
the same MAC address as before we set the address. So, the set
operation always seems to have an effect.

Observed scenarios with incorrectly assigned MAC addresses:

(1) After setting the mac address: ioctl returns the correct MAC
address, but the results from getifaddr, returns an incorrect MAC
address (different from the original value before setting as well!)

(2) After setting the MAC address: both ioctl and getifaddr return the
same MAC address, but are both wrong (and different from the original
one!)

(3) There is a possibility that the MAC address we set ends up
overwritten by a garbage value *after* we have already updated the MAC
address, and checked that the MAC address was set correctly. Since
this error happens after this function has finished, we cannot log nor
detect it in the function where we set the MAC address because we have
not yet studied at what point this late overwriting of MAC address
occurs. It=E2=80=99s worth noting that this is the rarest scenario that we
have encountered, and we were only able to reproduce it in our testing
cluster machine, not in any of the production cluster machines.

[3.] Keywords:

networking, veth, kernel, MAC, netlink

[X.] Other notes, patches, fixes, workarounds:

Notes:

More specific kernel and environment information will be available on
request for security reasons, please let us know if you are interested
and we will be happy to provide you with the necessary information.

We have observed this behavior only on CentOS 9 systems at the moment,
CentOS 7 systems under various kernels do not seem to have the issue
(which is quite strange if this was purely a kernel bug).

We have tried kernels 5.15.147, 5.15.160, 5.15.161, all of these have
this issue on CentOS 9.

We have also tried rewriting our function for setting MAC address to
use libnl rather than ioctl to perform the MAC address setting, but it
did not eliminate the issue.

To work around this bug, we checked that the MAC address is set
correctly after the ioctl set call, and retry the address setting if
necessary. In our testing, this workaround appears to remedy scenarios
(1) and (2) above, but it does not address scenario (3).  You can see
it here:

https://github.com/apache/mesos/commit/8b202bbebdc89429ad82c6983aa1c514eb1b=
8d95

We would greatly appreciate any insights or guidance on this matter.
Please let me know if you need further information or if there are any
specific tests we should run to assist in diagnosing the issue. Again,
specific details for the production machines on which we encountered
this error can be provided upon request, so please let us know if
there is anything we can provide to help.

Thank you for your time and assistance.

Best regards,
Jason Zhou
Software Engineering Intern
jasonzhou@x.com

embedded links:
[1] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0f=
bc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp#L35=
99
[2] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0f=
bc7ff0/src/linux/routing/link/veth.cpp#L45
[3] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0f=
bc7ff0/src/slave/containerizer/mesos/isolators/network/port_mapping.cpp#L36=
28
[4] https://github.com/apache/mesos/blob/8cf287778371c13ee7e88fa428424b3c0f=
bc7ff0/src/linux/routing/link/link.cpp#L283

