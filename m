Return-Path: <netdev+bounces-193190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D358BAC2CEB
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2279A1C07E8A
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99A1DE4C2;
	Sat, 24 May 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni8d8MG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A9193402;
	Sat, 24 May 2025 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748050097; cv=none; b=RBiU5kLQ8h+voFIot13EO9eJgXrl+sNlmuHSJqZsLA6GHATGOMcAkwAPfMSTl6fIHIGCV3MCLqJeWZxx3YatvVCR/VNfdTI85c9A+UB29Whgj6MKhytMSaD38bjIWNBpohAxyX7AeeFlPV2IJbaXnN1Scltyp4yEtksWYajeAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748050097; c=relaxed/simple;
	bh=66pZj+Rvt1kXHNVG62bXhOumlOqnMiXBHpTEF3dytBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCkZUCUvjxgLVVl8FOIRqnsNJX9e7CTI3YG8Yi+k0eroTMn09UMdD05lOLP2+u4PfPfeOLqxmXXQwcc8ZRo8+l56MwXx8GJ6uDCRBh08GeRhUljZHU8lX/VlHnF8jXH+yUVVXKb4a04s7AUPf77SLBxCO3LtjyqobjlnbcHVa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni8d8MG9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3290ae9b011so4022651fa.0;
        Fri, 23 May 2025 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748050093; x=1748654893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXLPYDfaUWs2ZTMA0/bOC3K26Uwaa++Hfjn9AqAoueY=;
        b=Ni8d8MG9IfEbvqDFmLWe7Z4KWMM+NcqbuuLx+Fg657JyYqJAkmug7aGXDsV9ZHXCVW
         fm8KZUsk1+2qAR3HSWt8JGmIn2N26aq3QVuFibKRjphJPavijQcAT6lGjmk15Q/EK5ZP
         P/Jg9H8dsHZZEsDyKMIMvqDnXXMkKupHD0iSYNUP4hCQz9oGhbOQyA3wwinHEMCOmRn1
         aY6usHbXlkk3MkYAwQuPPlVzrmZPKJXuH9uJzg9O9olnt9UkT8O9VGnaYUcYUMrdTod5
         eoT35M06mJB47m15l6uwKGBFV9Es1T1WZ4GkvBXcgwjl+ct11A8xVXPvRO5oAnZD695a
         A/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748050093; x=1748654893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXLPYDfaUWs2ZTMA0/bOC3K26Uwaa++Hfjn9AqAoueY=;
        b=djvgYl+sFUam6i7bfHnAlXjnfQx0I/v5uFQrazA0+Vaadj5Jkp/S4CwEPks3Y3WYaT
         yIULimTQ/WjQy9TaeO40sXeEzVXMPQQUy2/71Llg+YHzJ9n87BNBJ7NIVY6JQP05D6Lf
         xGk36XXsIK+/FRbJb41sGaDk3Q8zGrR77u6PLkTH6kU+zxPICqGAk3lrDE+Q2GbgJuwC
         Z9XLULOY1tcdhW9+5MyauJb4AU8jUJHoHTg/pGl7i7MtFcqNE4lIxEg+/JMJkyeZxcMO
         T7m6BK0gposwSnDJdfvAxuWvoFIEEuZS/jXryz3FH8pkycmM6Xp4xjQbH0xjB6gd7PcL
         0b0g==
X-Forwarded-Encrypted: i=1; AJvYcCUx1pWcBGGh1JjiSM8TB1Q9ZZX6zbnRNRLalyOL4vqCPTjwB5Pk4N2Fd9ggv1cAfqxegtY2aAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GWo42dNLfBe4OiFa/1FdCladofG65/8Yr//65Yr97Vqezy2B
	Apnp0k/X8UN1m4K6V+Ih2RZj78h3ywrhYYHYAHUHFTlhIHZv+ezXzc8+CZsh6oOBmuh/sdljg3Y
	k+ZxxkaMBBXbB81Akm4P7qi2X29m88XC8QSGC
X-Gm-Gg: ASbGncsTsunuKoaiNx6c8TI8cSLfasXl8cVKV6ec98fiPBXWO1HbKtcmOZ5hg8AG6/o
	pQ3jrPsG41rG698wWaDiJhdSp4wf0m2chGQUYuKMklqkarTr05ntpda7Rk8lwHlLYsQWWVkIkR6
	AgJsj3DHV79DNvyn7r0uM1/tjNxFDg9tXs
X-Google-Smtp-Source: AGHT+IERgfiXXHyWscFnPbsgenC6RIFAVgCCZnMlBwoGMB8xLkmGJ1PSWmhV7yxkOIyi7IycH1/0gO54GHSvqyUD5g4=
X-Received: by 2002:a05:651c:3137:b0:30d:626e:d004 with SMTP id
 38308e7fff4ca-3295b9c6dc1mr3471301fa.20.1748050092827; Fri, 23 May 2025
 18:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522171048.3307873-1-luiz.dentz@gmail.com>
In-Reply-To: <20250522171048.3307873-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 May 2025 21:28:00 -0400
X-Gm-Features: AX0GCFu0MjmjX3_JqObxy4S9VgC4kAPBgMKsC8_HQmOQ5Y6Va4kOws8-ZYPG_gE
Message-ID: <CABBYNZLK00mJ+80XkkS+k9_MC2h2d6wDPqwJqHmR9k_PJYV75Q@mail.gmail.com>
Subject: Re: bluetooth-next 2025-05-22
To: davem@davemloft.net, kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, May 22, 2025 at 1:10=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d3=
12:
>
>   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-off=
loading' (2025-05-20 20:00:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git tags/for-net-next-2025-05-22
>
> for you to fetch changes up to 3aa1dc3c9060e335e82e9c182bf3d1db29220b1b:
>
>   Bluetooth: btintel: Check dsbr size from EFI variable (2025-05-22 13:06=
:28 -0400)
>
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:
>
> core:
>
>  - Add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>  - Separate CIS_LINK and BIS_LINK link types
>  - Introduce HCI Driver protocol
>
> drivers:
>
>  - btintel_pcie: Do not generate coredump for diagnostic events
>  - btusb: Add HCI Drv commands for configuring altsetting
>  - btusb: Add RTL8851BE device 0x0bda:0xb850
>  - btusb: Add new VID/PID 13d3/3584 for MT7922
>  - btusb: Add new VID/PID 13d3/3630 and 13d3/3613 for MT7925
>  - btnxpuart: Implement host-wakeup feature
>
> ----------------------------------------------------------------
> Chandrashekar Devegowda (1):
>       Bluetooth: btintel_pcie: Dump debug registers on error
>
> Chen Ni (1):
>       Bluetooth: hci_uart: Remove unnecessary NULL check before release_f=
irmware()
>
> Dmitry Antipov (1):
>       Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
>
> En-Wei Wu (1):
>       Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump h=
andling
>
> Hsin-chen Chuang (4):
>       Bluetooth: Introduce HCI Driver protocol
>       Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
>       Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL=
"
>       Revert "Bluetooth: btusb: add sysfs attribute to control USB alt se=
tting"
>
> Jiande Lu (1):
>       Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
>
> Kees Cook (1):
>       Bluetooth: btintel: Check dsbr size from EFI variable
>
> Kiran K (1):
>       Bluetooth: btintel_pcie: Do not generate coredump for diagnostic ev=
ents
>
> Krzysztof Kozlowski (2):
>       Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
>       Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
>
> Liwei Sun (1):
>       Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
>
> Luiz Augusto von Dentz (3):
>       Bluetooth: ISO: Fix not using SID from adv report
>       Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc field=
s
>       Bluetooth: L2CAP: Fix not checking l2cap_chan security level
>
> Neeraj Sanjay Kale (2):
>       dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
>       Bluetooth: btnxpuart: Implement host-wakeup feature
>
> Pauli Virtanen (2):
>       Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>       Bluetooth: separate CIS_LINK and BIS_LINK link types
>
> WangYuli (1):
>       Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
>
> Youn M=C3=89LOIS (1):
>       Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
>
>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  17 ++
>  drivers/bluetooth/Kconfig                          |  12 -
>  drivers/bluetooth/btintel.c                        |  13 +-
>  drivers/bluetooth/btintel.h                        |   6 -
>  drivers/bluetooth/btintel_pcie.c                   | 141 +++++++++-
>  drivers/bluetooth/btintel_pcie.h                   |  19 ++
>  drivers/bluetooth/btmrvl_sdio.c                    |   4 +-
>  drivers/bluetooth/btmtksdio.c                      |   2 +-
>  drivers/bluetooth/btnxpuart.c                      |  58 +++-
>  drivers/bluetooth/btusb.c                          | 302 ++++++++++++---=
------
>  drivers/bluetooth/hci_aml.c                        |   3 +-
>  include/net/bluetooth/bluetooth.h                  |   4 +
>  include/net/bluetooth/hci.h                        |   4 +-
>  include/net/bluetooth/hci_core.h                   |  51 ++--
>  include/net/bluetooth/hci_drv.h                    |  76 ++++++
>  include/net/bluetooth/hci_mon.h                    |   2 +
>  net/bluetooth/Makefile                             |   3 +-
>  net/bluetooth/af_bluetooth.c                       |  87 ++++++
>  net/bluetooth/hci_conn.c                           |  79 ++++--
>  net/bluetooth/hci_core.c                           |  45 ++-
>  net/bluetooth/hci_drv.c                            | 105 +++++++
>  net/bluetooth/hci_event.c                          |  40 ++-
>  net/bluetooth/hci_sock.c                           |  12 +-
>  net/bluetooth/hci_sync.c                           |  63 ++++-
>  net/bluetooth/iso.c                                |  30 +-
>  net/bluetooth/l2cap_core.c                         |  15 +-
>  net/bluetooth/mgmt.c                               |   3 +-
>  net/bluetooth/mgmt_util.c                          |   2 +-
>  28 files changed, 920 insertions(+), 278 deletions(-)
>  create mode 100644 include/net/bluetooth/hci_drv.h
>  create mode 100644 net/bluetooth/hci_drv.c

Haven't got any update regarding this pull request.

--=20
Luiz Augusto von Dentz

