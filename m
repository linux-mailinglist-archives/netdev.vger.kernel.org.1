Return-Path: <netdev+bounces-177072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868B2A6DAD7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178CB188B60C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30D1ADC86;
	Mon, 24 Mar 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQXNQEZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A3802;
	Mon, 24 Mar 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821680; cv=none; b=C7IsCNxOF536dmryzXuUn9ixqkzTWukqWmvFm0sGUNGr3QdgCxhCwzIRGNL89I1VhiN+/xbdNjm6TITSCo9c7BfPSUJp1grbGJ99Bn/G3GOs/DzYhnaDIv7SK2RUSSkLsSArKWniQT7A/t2Tz0kR/DBP5yrUeRoiOPUM5TG08r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821680; c=relaxed/simple;
	bh=s+Gxhu0feqLh4H7P1AMMchfqpStJx3F1MnMzt+MUNRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWsHd0hyGzcteL6Vf0FunmLSACPdDVqKwcdyVryWhJgWGMTMHokGIm3L0x26etdv+p6BV0gUl0s4U4XJ8aLI6uA0/JwBtXeJP1kjDqx+NzkKXP8ak+a4kMCJEn4V9NTpZHfqr9dilA534tZ9FVXPdboZqR987BzkYLqwYDgM0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQXNQEZ1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so41480081fa.2;
        Mon, 24 Mar 2025 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742821677; x=1743426477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNSuqIvT2Ng2JeZ8xE0YsDMx2KisrkadgylHR868IY4=;
        b=KQXNQEZ1GKinvegBO9tGJM7rnMgihd7i7Frh6Yu1dFZkO3FrEFjesUbPrKoMzPHFw4
         bCAXWd+96JDoUtuQCuliApwxOmhAKzHndtf44sezShXe10ZqBpgmURepJ+BZJpZHB0cT
         ML3dmTI/1YQn24Lg9hFVxR00+HDkls0cXD6VJRlL0W0c1tULu4YGjZEKLv/LAqSvJVaA
         8R6oChukmcAVUVCh5Dld9/fv6clFyTjJMIdN3y2A5zjWTwHyR2pRwHdwoxgTAQ5vaH8V
         EidXJpX+iWr0cyFdXswVuKNjIkxIkjxpFNyS/B5tqcT55Ltyft7dDI1YQmnWunzArLhT
         E3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821677; x=1743426477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNSuqIvT2Ng2JeZ8xE0YsDMx2KisrkadgylHR868IY4=;
        b=eQUk+DbRmrg61iKtvlp+62rSHZGu0wQNczsaLFdKUTCcaFwox6PmcdGrIlL9sCVSWs
         gOSv0K1EHVSQSuk7ozCUmrIXphgh9zbOjoUat1tMyGlAwilpo1UgcsxzGpo23JND4PRY
         wZHCdqA1xPDcEQpQeKw3mfxxJKjVH1FNOJxZj0NvnrHotb3JbfFCGTG/QEWknkHa/mrL
         kPJXFggMwkL9idtmM7LFyV/l4MqKmchiWfkO2fc7AxBYdYN024doiPtcE6/6b6s/ib0U
         3jq7H/CBC4xKellkMexjEnXLI4wyIUur3ueV+LMU3FaFwn1FQpPQE4tnEFW5pGbO7uyF
         bWaw==
X-Forwarded-Encrypted: i=1; AJvYcCW4EqPr47/XAthyg9ZeLG7c8c0tS/aWF2+u5qKFkkYxytlIhZsf2Dl1dOqG7JM8NPGFh1l3kUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1FXyQsoQdJVwM8OnZk7JFO+6H2P0SDc4zxsSR/OuJ+6YK4SP
	Jv6ANQEP1GRqaE8BvknykEbooFu+i0rcQLpR/e16x4YFk72Svnl84rH5dFkotPFqoyieDgOLfoB
	K5LvhPNwwsYxsni/1jcofYZ0K8xU=
X-Gm-Gg: ASbGncttfqgYdtdkROOFwwvLdpCKn6lwB2uSzS3OrQxuxMk9Cl/xwEFf7wpm9SPkv4x
	ImpVhju0eTJZ6x5HxWH/epQNeeEck1wNv09hODLIfTLEpfexP524fRamw7W/gfbH0KecmG1t5VT
	ul6pH1W6CYeyTutqpgwfMmnv3r
X-Google-Smtp-Source: AGHT+IFYwrfjIuJ65+z+yOC9oj8VtgI5vtpbiLrzAZV3cVO4V6HBz9U+KhZgx42D8gJ9aBmH+/UDc2ExLe6gnPbyODw=
X-Received: by 2002:a2e:900d:0:b0:30b:ed8c:b1e7 with SMTP id
 38308e7fff4ca-30d7e229ffbmr46276281fa.18.1742821676045; Mon, 24 Mar 2025
 06:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320192929.1557825-1-luiz.dentz@gmail.com>
In-Reply-To: <20250320192929.1557825-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Mar 2025 09:07:42 -0400
X-Gm-Features: AQ5f1Jq91YKYKybykBbYDHzL0WeXRuk5doaYghOqvu9RltnDqfXWDi9cBhaap8U
Message-ID: <CABBYNZ+b31WUEB_H=ZWCvjOSGMpoHpxCZZs5OrMw2uaqbCxQqQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-03-20
To: davem@davemloft.net, kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 20, 2025 at 3:29=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit 6855b9be9cf70d3fd4b4b9a00696eae6533532=
0c:
>
>   Merge branch 'mptcp-pm-prep-work-for-new-ops-and-sysctl-knobs' (2025-03=
-20 10:14:53 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git tags/for-net-next-2025-03-20
>
> for you to fetch changes up to 1a6e1539e97303c60d82e3d5e163973e771a9d7f:
>
>   Bluetooth: btnxpuart: Fix kernel panic during FW release (2025-03-20 14=
:59:07 -0400)
>
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:
>
> core:
>
>  - Add support for skb TX SND/COMPLETION timestamping
>  - hci_core: Enable buffer flow control for SCO/eSCO
>  - coredump: Log devcd dumps into the monitor
>
>  drivers:
>
>  - btusb: Add 2 HWIDs for MT7922
>  - btusb: Fix regression in the initialization of fake Bluetooth controll=
ers
>  - btusb: Add 14 USB device IDs for Qualcomm WCN785x
>  - btintel: Add support for Intel Scorpius Peak
>  - btintel: Add support to configure TX power
>  - btintel: Add DSBR support for ScP
>  - btintel_pcie: Add device id of Whale Peak
>  - btintel_pcie: Setup buffers for firmware traces
>  - btintel_pcie: Read hardware exception data
>  - btintel_pcie: Add support for device coredump
>  - btintel_pcie: Trigger device coredump on hardware exception
>  - btnxpuart: Support for controller wakeup gpio config
>  - btnxpuart: Add support to set BD address
>  - btnxpuart: Add correct bootloader error codes
>  - btnxpuart: Handle bootloader error during cmd5 and cmd7
>  - btnxpuart: Fix kernel panic during FW release
>  - qca: add WCN3950 support
>  - hci_qca: use the power sequencer for wcn6750
>  - btmtksdio: Prevent enabling interrupts after IRQ handler removal
>
> ----------------------------------------------------------------
> Arkadiusz Bokowy (1):
>       Bluetooth: hci_event: Fix connection regression between LE and non-=
LE adapters
>
> Arseniy Krasnov (2):
>       Bluetooth: hci_uart: fix race during initialization
>       Bluetooth: hci_uart: Fix another race during initialization
>
> Dan Carpenter (1):
>       Bluetooth: Fix error code in chan_alloc_skb_cb()
>
> Dmitry Baryshkov (3):
>       dt-bindings: net: bluetooth: qualcomm: document WCN3950
>       Bluetooth: qca: simplify WCN399x NVM loading
>       Bluetooth: qca: add WCN3950 support
>
> Dorian Cruveiller (1):
>       Bluetooth: btusb: Add new VID/PID for WCN785x
>
> Douglas Anderson (1):
>       Bluetooth: btusb: mediatek: Add err code to btusb claim iso printou=
t
>
> Dr. David Alan Gilbert (2):
>       Bluetooth: MGMT: Remove unused mgmt_pending_find_data
>       Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete
>
> Easwar Hariharan (4):
>       Bluetooth: hci_vhci: convert timeouts to secs_to_jiffies()
>       Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
>       Bluetooth: SMP: convert timeouts to secs_to_jiffies()
>       Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()
>
> Hao Qin (1):
>       Bluetooth: btmtk: Remove the resetting step before downloading the =
fw
>
> Janaki Ramaiah Thota (1):
>       Bluetooth: hci_qca: use the power sequencer for wcn6750
>
> Jeremy Clifton (1):
>       Bluetooth: Fix code style warning
>
> Jiande Lu (1):
>       Bluetooth: btusb: Add 2 HWIDs for MT7922
>
> Kiran K (8):
>       Bluetooth: btintel: Add support for Intel Scorpius Peak
>       Bluetooth: btintel_pcie: Add device id of Whale Peak
>       Bluetooth: btintel: Add DSBR support for ScP
>       Bluetooth: btintel_pcie: Setup buffers for firmware traces
>       Bluetooth: btintel_pcie: Read hardware exception data
>       Bluetooth: btintel_pcie: Add support for device coredump
>       Bluetooth: btintel_pcie: Trigger device coredump on hardware except=
ion
>       Bluetooth: btintel: Fix leading white space
>
> Loic Poulain (2):
>       bluetooth: btnxpuart: Support for controller wakeup gpio config
>       dt-bindings: net: bluetooth: nxp: Add wakeup pin properties
>
> Luiz Augusto von Dentz (4):
>       Bluetooth: btintel_pci: Fix build warning
>       Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
>       Bluetooth: hci_vhci: Mark Sync Flow Control as supported
>       HCI: coredump: Log devcd dumps into the monitor
>
> Neeraj Sanjay Kale (7):
>       Bluetooth: btnxpuart: Move vendor specific initialization to .post_=
init
>       Bluetooth: btnxpuart: Add support for HCI coredump feature
>       dt-bindings: net: bluetooth: nxp: Add support to set BD address
>       Bluetooth: btnxpuart: Add support to set BD address
>       Bluetooth: btnxpuart: Add correct bootloader error codes
>       Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
>       Bluetooth: btnxpuart: Fix kernel panic during FW release
>
> Pauli Virtanen (5):
>       net-timestamp: COMPLETION timestamp on packet tx completion
>       Bluetooth: add support for skb TX SND/COMPLETION timestamping
>       Bluetooth: ISO: add TX timestamping
>       Bluetooth: L2CAP: add TX timestamping
>       Bluetooth: SCO: add TX timestamping
>
> Pedro Nishiyama (4):
>       Bluetooth: Add quirk for broken READ_VOICE_SETTING
>       Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
>       Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported=
/broken
>       Bluetooth: btusb: Fix regression in the initialization of fake Blue=
tooth controllers
>
> Sean Wang (1):
>       Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler=
 removal
>
> Vijay Satija (1):
>       Bluetooth: btintel: Add support to configure TX power
>
> Wentao Guan (1):
>       Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
>
> Zijun Hu (1):
>       Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
>
>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  18 +-
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   2 +
>  Documentation/networking/timestamping.rst          |   8 +
>  drivers/bluetooth/bfusb.c                          |   3 +-
>  drivers/bluetooth/btintel.c                        | 341 ++++++++++++
>  drivers/bluetooth/btintel.h                        |  24 +
>  drivers/bluetooth/btintel_pcie.c                   | 582 +++++++++++++++=
+++++-
>  drivers/bluetooth/btintel_pcie.h                   |  93 ++++
>  drivers/bluetooth/btmtk.c                          |  10 -
>  drivers/bluetooth/btmtksdio.c                      |   3 +-
>  drivers/bluetooth/btnxpuart.c                      | 407 +++++++++++---
>  drivers/bluetooth/btqca.c                          |  27 +-
>  drivers/bluetooth/btqca.h                          |   4 +
>  drivers/bluetooth/btusb.c                          |  36 +-
>  drivers/bluetooth/hci_ldisc.c                      |  19 +-
>  drivers/bluetooth/hci_qca.c                        |  27 +-
>  drivers/bluetooth/hci_uart.h                       |   1 +
>  drivers/bluetooth/hci_vhci.c                       |   5 +-
>  include/linux/skbuff.h                             |   7 +-
>  include/net/bluetooth/bluetooth.h                  |   1 +
>  include/net/bluetooth/hci.h                        |  36 +-
>  include/net/bluetooth/hci_core.h                   |  27 +-
>  include/net/bluetooth/l2cap.h                      |   7 +-
>  include/uapi/linux/errqueue.h                      |   1 +
>  include/uapi/linux/net_tstamp.h                    |   6 +-
>  net/bluetooth/6lowpan.c                            |   9 +-
>  net/bluetooth/coredump.c                           |  28 +-
>  net/bluetooth/hci_conn.c                           | 122 +++++
>  net/bluetooth/hci_core.c                           |  77 +--
>  net/bluetooth/hci_event.c                          |  15 +-
>  net/bluetooth/hci_sync.c                           |  32 +-
>  net/bluetooth/iso.c                                |  24 +-
>  net/bluetooth/l2cap_core.c                         |  45 +-
>  net/bluetooth/l2cap_sock.c                         |  15 +-
>  net/bluetooth/mgmt.c                               |  46 +-
>  net/bluetooth/mgmt_util.c                          |  17 -
>  net/bluetooth/mgmt_util.h                          |   4 -
>  net/bluetooth/sco.c                                |  19 +-
>  net/bluetooth/smp.c                                |   4 +-
>  net/core/skbuff.c                                  |   2 +
>  net/ethtool/common.c                               |   1 +
>  net/socket.c                                       |   3 +
>  42 files changed, 1890 insertions(+), 268 deletions(-)

Is there a problem that these changes haven't been pulled yet?

--=20
Luiz Augusto von Dentz

