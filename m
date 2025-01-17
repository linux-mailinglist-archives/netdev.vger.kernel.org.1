Return-Path: <netdev+bounces-159367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F7A15405
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3123A35F8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87419ADBA;
	Fri, 17 Jan 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcVtwo4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7018A6A7;
	Fri, 17 Jan 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130674; cv=none; b=HHydhyGz3nv1ApssDQY4CO7qkJ73dlRvh2rW3/4YVZhB/QPRlugXi5RO80d63Y8pEFJ4trWLMAB49OrmvEhlGVMZWWB4v8wnLEPWlIHUfjCugHHktqLwzEoqznWO33Kq7zfUbd5YRCowFsPKV6n6oYWhuoSvuEXxkWRaB6sdoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130674; c=relaxed/simple;
	bh=oGFgbxw1t5e3yJPS5faOWESjS8q66sYfV8yj/ECT8vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvk0bBiNwd+2x+zXmxVG1ajETPY5JonpWTmHVdZsIrqwo5hV8K4+dleorSl9aAstoCzgVVbE56PEquaL4Vqlh9Td9jfBzwVAP2yD4oPiyOFntm17GkbsqjOvYifOFThGFJfKRkMW3IrB8WI2IFmmAqNlUq/S38t6NSdIvAbX0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcVtwo4J; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3003e203acaso20785751fa.1;
        Fri, 17 Jan 2025 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130670; x=1737735470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMzcp+LRzkSWVc0h0fDFxdInuHd4+JS67Z6+TwySTb4=;
        b=JcVtwo4J2GkyKgXOouclokdYtR+B9ivvNea0R5k5I5fY37Su718n1g7aTnDk8u/VZT
         sHh7ClOpq/4DCXVetFb2meSx0JvqbfNFOxD4kWKA2/yz1ej6PDyq68XDQFql0V444r9f
         fV5RZxvaW+PmSj/xX+z7Z96EGZ3e6HRhFlTlAah/3LooXYtCewe/VXxtJe0x+nNw0nw0
         B912v2yZUpgDl8R1vRbsNnRHq3Og2Jx6+kQuhxZAr+fD5FtGLRNYTt0bWc2cd9mNfEEm
         aQhJsM6ihP2sXFyD8Jyy8Q6r83p7aXXIdYNDeETTYRBg/BIyTnTXa3qBsSHr5GRp8uud
         mhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130670; x=1737735470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMzcp+LRzkSWVc0h0fDFxdInuHd4+JS67Z6+TwySTb4=;
        b=QeGw2Xm4BFTkxkyKKn4rJ0/U97OnW6B2wWLYzorEolY8hStrVa93PBGGJ/141zCNc8
         JXcFVtQuT1+HZKBCyXo4ZGu+7qt2SJlqI5jUXEIe6tbxEDGEAwbuVrvRuyZhrkB6Xagk
         yOCvlYmIDYx95e9RyZSMxiFSKDEpkjfxUs684xL5G7EvcA9DJp5m8Eutgo5UlT9+LEN/
         PE90csNCZuQDZcbStnpsgsFkvsgVw0x6kvRiC2WxCIlVmA5vnx84LXn57gJJ7f2Lrif3
         NVCuxjcpsAemHqYwJ3pjE1+eHkwuMMGlSEsv9v5qEM6EWuhQmD2LLjvs8BdW3ednIt8b
         mFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVMq6OZyUV5Q1qRlLn+Ogg0rS2RRtjzP2MKq8dl0OmxBmjAPN8HQVhw2JypJhFhj36PEoPFT0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypViFN7PTPeFxzfEIHXqIfCV8kWJs0fRAa5wo8YfBJYNITnwTq
	3KMibuMo3yI2SWBn6qXXewhbcfn81SWwkpE0LKlO+iTasLPnvjuIClWSJ7y5kJFpx6RarrgkowU
	izDNtgHhZQko52BDr710TWhJI9K368xgj
X-Gm-Gg: ASbGncusLLuYZzEi4/1GYkGA9O38NzPSnUgkhry/OkB/np4+jhMiCTR7oahbDntu3tJ
	ijwl5b/At/LrmA1ulTJ6e92/aF+pzvzCZ6TtoeYY=
X-Google-Smtp-Source: AGHT+IHKcvreZ7mhfGk5W6nPltlvOT2Ux9v21o7ceL1YPmRxTtEY3VkxuDYFTm2l5c1HkrNEo2hDqF9Y9pSiFlLwY5U=
X-Received: by 2002:a2e:b90d:0:b0:304:4cec:29f9 with SMTP id
 38308e7fff4ca-3072ca60ef9mr8790071fa.3.1737130670021; Fri, 17 Jan 2025
 08:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115210606.3582241-1-luiz.dentz@gmail.com>
In-Reply-To: <20250115210606.3582241-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jan 2025 11:17:36 -0500
X-Gm-Features: AbW1kvaIo8COXV3SgpgN-eYomgJ5bXgV0_9-LGJbJ7cmFhZ2pes8s75iMhDYtPM
Message-ID: <CABBYNZJ_LfmEzZaZjxwY7uG8Bx1=+-QE5B07emtz5sios9XZ0A@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2025-01-15
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks like Ive only send this to linux-bluetooth by mistake:

On Wed, Jan 15, 2025 at 4:06=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit d90e36f8364d99c737fe73b0c49a51dd5e749d=
86:
>
>   Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/mellanox/linux (2025-01-14 11:13:35 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git tags/for-net-next-2025-01-15
>
> for you to fetch changes up to 26fbd3494a7dd26269cb0817c289267dbcfdec06:
>
>   Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monito=
r_sync (2025-01-15 10:37:38 -0500)
>
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:
>
>  - btusb: Add new VID/PID 13d3/3610 for MT7922
>  - btusb: Add new VID/PID 13d3/3628 for MT7925
>  - btusb: Add MT7921e device 13d3:3576
>  - btusb: Add RTL8851BE device 13d3:3600
>  - btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
>  - btusb: add sysfs attribute to control USB alt setting
>  - qca: Expand firmware-name property
>  - qca: Fix poor RF performance for WCN6855
>  - L2CAP: handle NULL sock pointer in l2cap_sock_alloc
>  - Allow reset via sysfs
>  - ISO: Allow BIG re-sync
>  - dt-bindings: Utilize PMU abstraction for WCN6750
>  - MGMT: Mark LL Privacy as stable
>
> ----------------------------------------------------------------
> Andrew Halaney (1):
>       Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
>
> Charles Han (1):
>       Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
>
> Cheng Jiang (3):
>       dt-bindings: net: bluetooth: qca: Expand firmware-name property
>       Bluetooth: qca: Update firmware-name to support board specific nvm
>       Bluetooth: qca: Expand firmware-name to load specific rampatch
>
> Dr. David Alan Gilbert (1):
>       Bluetooth: hci: Remove deadcode
>
> En-Wei Wu (1):
>       Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925
>
> Fedor Pchelkin (1):
>       Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
>
> Garrett Wilke (2):
>       Bluetooth: btusb: Add MT7921e device 13d3:3576
>       Bluetooth: btusb: Add RTL8851BE device 13d3:3600
>
> Hao Qin (1):
>       Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
>
> Hsin-chen Chuang (3):
>       Bluetooth: Remove the cmd timeout count in btusb
>       Bluetooth: Get rid of cmd_timeout and use the reset callback
>       Bluetooth: Allow reset via sysfs
>
> Iulia Tanasescu (1):
>       Bluetooth: iso: Allow BIG re-sync
>
> Janaki Ramaiah Thota (1):
>       dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750
>
> Krzysztof Kozlowski (1):
>       Bluetooth: Use str_enable_disable-like helpers
>
> Luiz Augusto von Dentz (1):
>       Bluetooth: MGMT: Mark LL Privacy as stable
>
> Mark Dietzer (1):
>       Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
>
> Max Chou (1):
>       Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()
>
> Mazin Al Haddad (1):
>       Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_mo=
nitor_sync
>
> Ying Hsu (1):
>       Bluetooth: btusb: add sysfs attribute to control USB alt setting
>
> Zijun Hu (1):
>       Bluetooth: qca: Fix poor RF performance for WCN6855
>
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  10 +-
>  drivers/bluetooth/btbcm.c                          |   3 +
>  drivers/bluetooth/btintel.c                        |  17 +-
>  drivers/bluetooth/btmrvl_main.c                    |   3 +-
>  drivers/bluetooth/btmtk.c                          |   4 +-
>  drivers/bluetooth/btmtksdio.c                      |   4 +-
>  drivers/bluetooth/btqca.c                          | 200 ++++++++++++++-=
------
>  drivers/bluetooth/btqca.h                          |   5 +-
>  drivers/bluetooth/btrtl.c                          |   4 +-
>  drivers/bluetooth/btusb.c                          |  73 +++++---
>  drivers/bluetooth/hci_qca.c                        |  33 ++--
>  include/net/bluetooth/hci.h                        |   1 -
>  include/net/bluetooth/hci_core.h                   |  14 +-
>  include/net/bluetooth/hci_sync.h                   |   1 -
>  net/bluetooth/hci_core.c                           |  24 +--
>  net/bluetooth/hci_sync.c                           |  76 ++++----
>  net/bluetooth/hci_sysfs.c                          |  19 ++
>  net/bluetooth/iso.c                                |  36 ++++
>  net/bluetooth/l2cap_sock.c                         |   3 +-
>  net/bluetooth/mgmt.c                               | 145 ++-------------
>  20 files changed, 340 insertions(+), 335 deletions(-)



--=20
Luiz Augusto von Dentz

