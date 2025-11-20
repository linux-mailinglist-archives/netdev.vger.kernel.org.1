Return-Path: <netdev+bounces-240570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE399C764E2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA7BE345A49
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D333F38A;
	Thu, 20 Nov 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b="qidKq8Rh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6552FE07F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672371; cv=none; b=a1f0LGXsxbCR0+j9Etc215g1GrkHkzDgUnDWCit0P4W9nfxOaDKNfFitFTqtF/v9+Hg6o0ivu9LE+H1MVbcQuD6XDnL8sjau55fym9hXC2jlDuI1jiX2nCvj898SSGv/ycpJ5tbMpRYMQBL6xHMhwXWbRh9EFIjn31ukobqmuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672371; c=relaxed/simple;
	bh=YkE40NrQmfi63kJXdNVKvBaWnocpyaH15TRbWMGI6AI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WXi6lEkaBX6Un0x8s9C/pflmO3QkPfkTzmTgrhKINkr3245MJYF9lzyaoISjFtMEwSt2EaN5hLHgWGn7ZKyQkXDUj04TVqKkq391xZIEWdrw5CHw8l2bLUP8rUouAsBxgz6vWcla3AIMa8Ceq3EjWscj+9ON63x8yax7xZLbhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com; spf=pass smtp.mailfrom=netstatz.com; dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b=qidKq8Rh; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netstatz.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37b99da107cso11599151fa.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netstatz.com; s=google; t=1763672367; x=1764277167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hq1DcJKchbBZtQFYqlFaOkUYwbHumvFG+4vA65lH/uk=;
        b=qidKq8RhJLoTBakiBi4qDHES8UJXwOvBxyPqOAqNw3dJqKtrfk/6CnC5IS5EMqk2+q
         H75wJ8IEoAcYvyMGg98yVLHGF5Ek38rFtzRRLlqguMcPoU4bLcpVbnSJcE4hBsOKGFMb
         +NjPz6KkjQOIMIDrQO2DKXFxPvrrS3simkjXMgjHS6PjZmugaLVpjdZkEz+fWybPyy8j
         rYzREK1zKHyWD5zEIQpTYzIDkhq0CC2IewFZXz/srH259R2pd8gvrPmPcMM56ubQQLgB
         hMW+sFwRUohiMreqoz8vQEWQ1pQKNnMEnvt4YirECH69v4qxVpumtNiMXLs4xiLykH1e
         /2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672367; x=1764277167;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq1DcJKchbBZtQFYqlFaOkUYwbHumvFG+4vA65lH/uk=;
        b=arGNw+qm6ulWYCtSSnxIoxUfB/G6ys1EpS3tpGVq0nw6E+ztc5Urdk+1PJ6AOh/KYW
         IWQq4qYOCBnBy6PU9BPCXgDOWgz/+gsgbP7/PXzabvHw381yWisN6bAM4PwU9yCvDCGe
         2PmBNi/Fk4izFHEVZ1SPEQQomhHnJoZgAS0olqhVgI6m2bje1mvq2GvfQfry4SYmhd2w
         IgR0ta2J47Dio44ZX/cuYPKlSLT3Yjo3ebeL4pudpU1/Td1uvF2qk9f0LRYbeqcfcjv8
         KVooMo/xNjT7nkbi/WZuzpI5JZeyzDysrAoSi5bInQfRZSwiNEwQHLwxI846UuAGCDkH
         I5pQ==
X-Gm-Message-State: AOJu0YyoZ1vECEPPdfKpYLKlOdhyk2mm6YLWiINt5XIZB4EqlwN8FD3d
	sU7Eg6BiiPnkfjwQ/viySSSFVYgiyAMmIQ2zoqLTvKnU2EjofZvAe9eFZJ4Bg1eL6gBr2//HgA4
	T3gyY/sKLGzLq+28CyGcbCvJdLT2HkBTWAbORDKfSyQ==
X-Gm-Gg: ASbGncvkbYnylEBZZH5CtM35ZCmXG5qr0f8uktEbCW7RCbBBDccFUfUA/HWUvRmFw5g
	Q4JSR0ehbYJgIA5yp5DH3mfS7IiXP+bb+7nPbb3wMW1LaiumbgGphTalkieeVALm1K0ldb2zL+l
	6l01V4P7GW8j3xfDW6Z9LOuLVCRShzFv3y91mOl6R1ev/xx0SzSK6xpkCWz34n/P6pkidSZCS1I
	OQ9prE7wMTX91bUyIv2z6AFdGiOHTbaZ+AYBHsqFRyfp5cKMu2xcdATtwo1gt9kysfaf4iSFw==
X-Google-Smtp-Source: AGHT+IGNTlT8GDqO74PAWRTP2dgCzNXPkGP9m5Kt+gXbl5z4XRQU9ws0C5K29ccAiDZc+7Q+R9O67CD3BO5hC0p/5zw=
X-Received: by 2002:a05:651c:31cb:b0:373:a93d:5b42 with SMTP id
 38308e7fff4ca-37cc679738bmr14192701fa.27.1763672367103; Thu, 20 Nov 2025
 12:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian MacDonald <ian@netstatz.com>
Date: Thu, 20 Nov 2025 15:59:15 -0500
X-Gm-Features: AWmQ_blxoprMob1y6pjCwbA7YyWG1SJd3AAeSFjXF_kSv3lK86ZnzRg81aiOcfc
Message-ID: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
Subject: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad bonding
To: Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	1121032@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Using two Thunderbolt network interfaces as slaves in a bonding device
in mode 802.3ad (LACP) fails because the bonding driver cannot set the
MAC address on the thunderbolt_net interfaces. The same setup works in
mode active-backup.

Hardware: AMD Strix Halo (Framework connect to Sixunited AXB35 USB4 ports)
Kernel:  6.12.57 (also reproduced on 6.16.12 and 6.18~rc6)

Steps to reproduce:
1. Create a bond with mode 802.3ad and add thunderbolt0 and thunderbolt1
   as slaves.
2. Bring up the bond and slaves.
3. Observe that bonding fails to set the slave MAC addresses and logs:

   [   25.922317] bond0: (slave thunderbolt0): The slave device
   specified does not support setting the MAC address
   [   25.922328] bond0: (slave thunderbolt0): Error -95 calling
   set_mac_address
   [   25.980235] bond0: (slave thunderbolt1): The slave device specified
   does not support setting the MAC address
   [   25.980242] bond0: (slave thunderbolt1): Error -95 calling
   set_mac_address

Expected result:
- bond0 and both Thunderbolt interfaces share bond0's MAC address.
- 802.3ad operates normally and the link comes up.

Actual result:
- dev_set_mac_address(thunderboltX, bond0_mac) fails with -EOPNOTSUPP.
- bonding reports that the slave does not support setting the MAC address
  and cannot use the interfaces in 802.3ad mode.

From reading drivers/net/thunderbolt/main.c:

- thunderbolt_net generates a locally administered MAC from the
  Thunderbolt UUID and sets it with eth_hw_addr_set().
- The net_device_ops for thunderbolt_net currently define:
    .ndo_open
    .ndo_stop
    .ndo_start_xmit
    .ndo_get_stats64
  but do not implement .ndo_set_mac_address.

As a result, dev_set_mac_address() returns -EOPNOTSUPP and bonding treats
the device as not supporting MAC address changes.

A bit of research suggests it should be possible to implement
ndo_set_mac_address using
eth_mac_addr(), and, if appropriate, mark the device with
IFF_LIVE_ADDR_CHANGE so MAC changes while the interface is up are
allowed.   I have a feeling there is a lot more to it;

There is a corresponding downstream Debian bug with additional
hardware details https://bugs.debian.org/1121032

Thanks,
Ian

