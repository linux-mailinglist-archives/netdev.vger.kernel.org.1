Return-Path: <netdev+bounces-193370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D8AC3A36
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A2C3A742E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA101C3C18;
	Mon, 26 May 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7fB3/Ve"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F219066B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242367; cv=none; b=HSarzR0ws62zonajISFL4FzEYB+q4vKhaCj68e6nOP0UDuxvBOFrlCdeyWdMbE770/DJK5BX2EiYHOnmJ1OnqNJncdFVuwBzoBHtB6XDlzbWqfiaMPTuQtAG9Ub/orGCVhAGOG5/rKnh/AXgBTv0bYkXPaZZQEFuquD/nWUQXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242367; c=relaxed/simple;
	bh=Z52OzOSTUSrobuO8k+luxsb3Mrrx5lrqfi4q11PaIr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpUvGHg1WUsxybpvxk4FatTa7rDfCsNEb52uewN5+uowC1E7rwkd3o8MF3FGb34vryLTBc9mnE7BKfiqwDgjRXkEeHSD21R1Phgn79t2zULYSszvX1FaKcjTlMRsUFtv7mMmnoTEejeefNjK8JvO1G1iu1Y4FBCnUKMxvREily4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7fB3/Ve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748242364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOw5aT8rZ894OuzRSqfx6nxu1JDQtm13QlR/qfnuRh8=;
	b=Y7fB3/VeQqgQeRBOP2RQ7n4Iflk6VgBYiEUL7S5Jgv7FKd34Flwabofw/iFiU97uBsYUsf
	V1JjFmlfYskwuuIl8Y1abeN3wc7gcQAGhxFPrMVCT0ru8Ue5sxGDg/J2ARsHq0huwX3FhB
	1pwongAq4HioTdBiJtdnsLAbIZ3ufOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-GAq9mMXYMdixxIfiQyI0QA-1; Mon, 26 May 2025 02:52:43 -0400
X-MC-Unique: GAq9mMXYMdixxIfiQyI0QA-1
X-Mimecast-MFC-AGG-ID: GAq9mMXYMdixxIfiQyI0QA_1748242362
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a35ec8845cso589870f8f.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 23:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242362; x=1748847162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOw5aT8rZ894OuzRSqfx6nxu1JDQtm13QlR/qfnuRh8=;
        b=Vj11xR2P0cWfuUdVMjKQjPAVUosU01py4wyOARiSLU5fdNPk8tJjgcEJ4KTarHRo2R
         zAtfpEOkDu781OXXqEfvwoxtjA2dKkordpAaedxt5XWacuU8h7DpDbamm/xUQpHez3Pb
         Ub6RB1Ik0lJNlH961hmKnUojgxxpHmbU0cIj/Qnsvc+NYK3+xcvuWVm8GaEFgFJAWzo3
         fRbkVbAMOK58QJ8gUyFurwcrcP3khaf5yhRgXlkxpbKOxyomg3ZI3oU0i6sTPBEEaLAC
         qYo3dvs9ho40tikK5RCmTt9Xju56CxhgZyw5AwO2MnIwSavJHO3A6E/YKxGceAdpQC9P
         XXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUu9e+d0M1bvbmYWa+aEdAZxtQneOJDDhl/Yv6hHWuDZ4W96gniL6w5SuPLF4Y0+QhpsZhwVgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgMHB3VlwovYarxy5Nm/TVTH+INuvW+oXyYFSYpeRRcyjHHUw
	R8zZvXARMBM7soWAe0U2rGQvykMe89zZISSpN0SSOpLNLDmOK+/qimmDG4WSZRRP7nv1HiwySvk
	iq0Jj3KcWj3mOCyPRcytzUbmJDzwtQEi1fQO7uZd0oTSvULUsOaCnVctWKA==
X-Gm-Gg: ASbGncvDxJbjbLeksXv7uzWoMxwEIzbll18Ry9hMavlt7ULOiTP6Lvsv0jjc9NEvySy
	kPEpGNfIdtMG55yUEESumouASq+I65mR0lq9YBAj/ZI+6lvQyATmBa9lU0Os0MbGeBJnGEgO9zO
	Rv+gSGot8Fj8ui3UKtN9PVxFnFa6Yq6rkoBvUiluSgBXkt2oXnXSz0WP07+4majXuCcv/KJCeZb
	OY10DrEkRpr6bbPt59+sRW4hfaWgbxbJ5LXnl8yaczylYBtq/MLG37lWlnN+Ius9NJMRUsG9o3f
	+YYBNDgETchBiFN2dg8=
X-Received: by 2002:a05:6000:178d:b0:3a3:671e:3b7c with SMTP id ffacd0b85a97d-3a4cb4996c6mr5768498f8f.48.1748242361778;
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOfSDAisSVZqhciUw0uFkv3j9cqxJbxN6jdBydc+6Olhc5v5HrwWkXxdBJcJyK9vnJXa8Eg==
X-Received: by 2002:a05:6000:178d:b0:3a3:671e:3b7c with SMTP id ffacd0b85a97d-3a4cb4996c6mr5768480f8f.48.1748242361420;
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d652e8b9sm3222690f8f.34.2025.05.25.23.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
Message-ID: <1562810b-9217-4da1-ba9e-bc1574047aaa@redhat.com>
Date: Mon, 26 May 2025 08:52:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bluetooth-next 2025-05-22
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250522171048.3307873-1-luiz.dentz@gmail.com>
 <CABBYNZLK00mJ+80XkkS+k9_MC2h2d6wDPqwJqHmR9k_PJYV75Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZLK00mJ+80XkkS+k9_MC2h2d6wDPqwJqHmR9k_PJYV75Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/25 3:28 AM, Luiz Augusto von Dentz wrote:
> On Thu, May 22, 2025 at 1:10 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d312:
>>
>>   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading' (2025-05-20 20:00:55 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-05-22
>>
>> for you to fetch changes up to 3aa1dc3c9060e335e82e9c182bf3d1db29220b1b:
>>
>>   Bluetooth: btintel: Check dsbr size from EFI variable (2025-05-22 13:06:28 -0400)
>>
>> ----------------------------------------------------------------
>> bluetooth-next pull request for net-next:
>>
>> core:
>>
>>  - Add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>>  - Separate CIS_LINK and BIS_LINK link types
>>  - Introduce HCI Driver protocol
>>
>> drivers:
>>
>>  - btintel_pcie: Do not generate coredump for diagnostic events
>>  - btusb: Add HCI Drv commands for configuring altsetting
>>  - btusb: Add RTL8851BE device 0x0bda:0xb850
>>  - btusb: Add new VID/PID 13d3/3584 for MT7922
>>  - btusb: Add new VID/PID 13d3/3630 and 13d3/3613 for MT7925
>>  - btnxpuart: Implement host-wakeup feature
>>
>> ----------------------------------------------------------------
>> Chandrashekar Devegowda (1):
>>       Bluetooth: btintel_pcie: Dump debug registers on error
>>
>> Chen Ni (1):
>>       Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()
>>
>> Dmitry Antipov (1):
>>       Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
>>
>> En-Wei Wu (1):
>>       Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
>>
>> Hsin-chen Chuang (4):
>>       Bluetooth: Introduce HCI Driver protocol
>>       Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
>>       Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
>>       Revert "Bluetooth: btusb: add sysfs attribute to control USB alt setting"
>>
>> Jiande Lu (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
>>
>> Kees Cook (1):
>>       Bluetooth: btintel: Check dsbr size from EFI variable
>>
>> Kiran K (1):
>>       Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events
>>
>> Krzysztof Kozlowski (2):
>>       Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
>>       Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
>>
>> Liwei Sun (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
>>
>> Luiz Augusto von Dentz (3):
>>       Bluetooth: ISO: Fix not using SID from adv report
>>       Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
>>       Bluetooth: L2CAP: Fix not checking l2cap_chan security level
>>
>> Neeraj Sanjay Kale (2):
>>       dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
>>       Bluetooth: btnxpuart: Implement host-wakeup feature
>>
>> Pauli Virtanen (2):
>>       Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>>       Bluetooth: separate CIS_LINK and BIS_LINK link types
>>
>> WangYuli (1):
>>       Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
>>
>> Youn MÉLOIS (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
>>
>>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  17 ++
>>  drivers/bluetooth/Kconfig                          |  12 -
>>  drivers/bluetooth/btintel.c                        |  13 +-
>>  drivers/bluetooth/btintel.h                        |   6 -
>>  drivers/bluetooth/btintel_pcie.c                   | 141 +++++++++-
>>  drivers/bluetooth/btintel_pcie.h                   |  19 ++
>>  drivers/bluetooth/btmrvl_sdio.c                    |   4 +-
>>  drivers/bluetooth/btmtksdio.c                      |   2 +-
>>  drivers/bluetooth/btnxpuart.c                      |  58 +++-
>>  drivers/bluetooth/btusb.c                          | 302 ++++++++++++---------
>>  drivers/bluetooth/hci_aml.c                        |   3 +-
>>  include/net/bluetooth/bluetooth.h                  |   4 +
>>  include/net/bluetooth/hci.h                        |   4 +-
>>  include/net/bluetooth/hci_core.h                   |  51 ++--
>>  include/net/bluetooth/hci_drv.h                    |  76 ++++++
>>  include/net/bluetooth/hci_mon.h                    |   2 +
>>  net/bluetooth/Makefile                             |   3 +-
>>  net/bluetooth/af_bluetooth.c                       |  87 ++++++
>>  net/bluetooth/hci_conn.c                           |  79 ++++--
>>  net/bluetooth/hci_core.c                           |  45 ++-
>>  net/bluetooth/hci_drv.c                            | 105 +++++++
>>  net/bluetooth/hci_event.c                          |  40 ++-
>>  net/bluetooth/hci_sock.c                           |  12 +-
>>  net/bluetooth/hci_sync.c                           |  63 ++++-
>>  net/bluetooth/iso.c                                |  30 +-
>>  net/bluetooth/l2cap_core.c                         |  15 +-
>>  net/bluetooth/mgmt.c                               |   3 +-
>>  net/bluetooth/mgmt_util.c                          |   2 +-
>>  28 files changed, 920 insertions(+), 278 deletions(-)
>>  create mode 100644 include/net/bluetooth/hci_drv.h
>>  create mode 100644 net/bluetooth/hci_drv.c
> 
> Haven't got any update regarding this pull request.

Jakub merged it last week, merge commit
43a1ce8f42cb45d028a8e5f1c2748fb3eff48fb3

The PW bot has been flaky.

/P


