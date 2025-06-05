Return-Path: <netdev+bounces-195289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085BEACF31C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748403AAF8C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584B139D1B;
	Thu,  5 Jun 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="mPDrUcLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D79D2FB
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137538; cv=none; b=qRVmm4pjlUnY0z7sOmf/I5ByewrVYrs2XvopMmafNiVWlC2jXJeaumMVdlz7vMrntX+FexBtYoZA8AYhFFkweMtURp66shkptWP4xJGbjenD7XOcxmz8vVusld1l3G6iD25eLj7oMyUsWZktMINhv3yXpgLG9GOOCE5plGGyUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137538; c=relaxed/simple;
	bh=Yd3jIdG0FG0l3cG4bR7Td+bvkba1YANFTz10cV900pI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=pGQz2ueo8GVGxSbadkz/WomSWXKRQGXG3ki48T6agB6wolSAn0uqeKQ98S4lU2EEGapLa06wejDvr9SqbEn2jQ0wc+se4WI1QLVLfp3/tk/IuAgDabkGmAa/fUUEGMWLLw7yg2XSQ3tp0c2ay86/YHgbxmnmPdM4lYXmxzguzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=mPDrUcLE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fac8c5b262so23198686d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749137533; x=1749742333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtirVVnCCm+ctI6lPp/yE0xi4vwm5DxVahyNVCus26Q=;
        b=mPDrUcLE/wtZOmE5pJdpDIyGCKSa2eR/OdOIKNKUonZs2NGZ26DiJ1t+hoJP0hHTxO
         T6/cciiOrrO3KWEeQxHxqF0timGgUneon4G90t5Rx75dUHcDM8nbhFlqRErB0s6f2N9z
         gsethIn5ftLv5Tpbp83n6QoLbB7olqKX8rq3tA5fAO9sW5O7eboecO4ieWTzI8Xii448
         Iy2A/Gdaf9RLN40Z8nbfjFeCqdQDH+Exacg6kFu/i9iZGoNMmE2GtRX3jFTxdt4+vqWa
         Zjsatkuhzso91H0OxbKCL6y9MDX3fYc+HcstkEMWwu1nKmNClspPWQ4dQUm68VTAUs1E
         TUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137533; x=1749742333;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtirVVnCCm+ctI6lPp/yE0xi4vwm5DxVahyNVCus26Q=;
        b=piv7YGIXyQzhgzqmuDQruEWSdjEFu7UaqyZfcMH9c2qz0nh5chl0xReSxTfoV2OmcC
         cHzGGO9G51xjVX2L1JUb6m0RKKikmz4Ij91fZ8qoZliXXmxmQbrfw0X413WhnGWI6ucD
         THAk+O3GI+WytorXijgmMxR2Iebk3mhS4XSC1Ih/oG1nNp9LAXp1IkMPthvjD9Fqd/Yj
         dT7E2aEGcqNxS1Y2MWzCQRZFMd8FTvZkvoyebagyvDar3yjYTkN7V7q23wzm0cW2//FV
         dQaJdGDIPBRwrF2SOC/p/EKeWgB4e8bWEP+rZLy68pwst7btTEU0VIcpMZNp+hn/aELs
         FPOg==
X-Gm-Message-State: AOJu0YwkZ8imfqO9cCKbk+ipSN3wSMk5R+Ln3Ov+qvqnDp5pnnTwzEB7
	8dt0kpRXY6ZXTXsTbnkK6NzGYPQReP2Mw1c0OcF0sac55gakeGJAz8PAImgrqIXvgnNY6ZJObFp
	dhiKY
X-Gm-Gg: ASbGncs07Im44FMoaCnFJHHHt2ytYwyF9LebiUxvyrBxrdmJbwlp2zYReUcEWsyl0Dd
	QgXm88Zu/y/zYGCZcRs4b6wIQ0OJHcQ69MurgGMdMHi8Q81zR3zoEy/ELTPdSp5wCuGCJjgJewb
	P9URfWDSLZKU0IjFscmtCHiYFLflaXXmbSTSttVChksSoNhcviZ0RizFqwtb6usHyfk6JYGtfmy
	DA3u8YFnrWIUYQ4olP90vaQNthbj5q9/x1hiegwILzr1jUSWFbLsYZXfmKtkAp4ciifp+7eYJ6h
	2GryduqCYTueCbJQMkjX54jQj/Cjp1/R/CEQ9kleZgKlGmHJjP3iOJCgszAvmQQNe3x91OagM0N
	08Mj2i3UbmXMFQdR++RMvljt9ikOc
X-Google-Smtp-Source: AGHT+IG14EZCJeInVBBR2rnOo0jEcSJB/5WKKA+749prd7oqtWYic2EGuhMOAtIlbMS4szc5R0Cr6w==
X-Received: by 2002:a05:6214:e8a:b0:6fa:cdc9:8af7 with SMTP id 6a1803df08f44-6faf6fd5c1bmr112549976d6.7.1749137532858;
        Thu, 05 Jun 2025 08:32:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fafec3c10bsm23431696d6.107.2025.06.05.08.32.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:32:12 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:32:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220195] New: [Issue] Linux Not Sending ARP to Cisco C8000v
 Virtual Router (IOS XE 17.09.01a)
Message-ID: <20250605083209.73808675@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Not likely a kernel bug, but someone on list probably has more insight here.

Begin forwarded message:

Date: Thu, 05 Jun 2025 08:18:47 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220195] New: [Issue] Linux Not Sending ARP to Cisco C8000v Vi=
rtual Router (IOS XE 17.09.01a)


https://bugzilla.kernel.org/show_bug.cgi?id=3D220195

            Bug ID: 220195
           Summary: [Issue] Linux Not Sending ARP to Cisco C8000v Virtual
                    Router (IOS XE 17.09.01a)
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: rvhdrywesy48@gmail.com
        Regression: No

We are connecting the linux to a virtual router
c8000be-universalk9.17.09.01a.SPA.bin download from   ,but quite strange no=
 arp
sent=20

Hello everyone,

We=E2=80=99re currently testing the connectivity between a Linux host and a=
 virtual
Cisco router using the image:

 c8000be-universalk9.17.09.01a.SPA.bin
Downloaded
from:https://www.ioshub.net/c8000be-universalk9-17-09-01a-spa-bin-cisco-cat=
alyst-8000v-edge-platform-ios-xe-amsterdam-17-09-01a-software-download-link/

Setup Overview:
        =E2=80=A2       Linux Host: Ubuntu 22.04 (Kernel 5.15.x)
        =E2=80=A2       Virtual Router: Cisco Catalyst 8000v (C8000v) runni=
ng IOS XE
Amsterdam 17.09.01a
        =E2=80=A2       Connection: Linux <=E2=80=93> vNIC <=E2=80=93> Cisc=
o 8000v
        =E2=80=A2       Virtualization: KVM/QEMU

Problem:

Despite the interfaces being up on both the Linux side (ip link shows UP) a=
nd
the C8000v router (GigabitEthernet interface shows up/up), no ARP request is
being sent from the Linux host when trying to ping the virtual router.

We=E2=80=99ve confirmed the following:
        =E2=80=A2       Static IPs configured on both ends
        =E2=80=A2       Interface eth0 is up and has no MAC address conflict
        =E2=80=A2       No firewall (ufw disabled, iptables -F)
        =E2=80=A2       tcpdump on Linux shows no ARP at all =E2=80=94 not =
even when doing a
manual ping
        =E2=80=A2       C8000v side shows no ARP entries either

What we suspect / tried:
        =E2=80=A2       Verified vNIC model is virtio-net-pci, tried switch=
ing to e1000
=E2=80=94 same behavior
        =E2=80=A2       Recompiled kernel with CONFIG_ARP=3Dy, just in case=
 =E2=80=94 no change
        =E2=80=A2       Changed C8000v interface to bridge and virtio modes=
 =E2=80=94 issue
persists
        =E2=80=A2       Added a static ARP entry on Linux =E2=80=94 ping st=
ill doesn=E2=80=99t work

What=E2=80=99s strange:
        =E2=80=A2       On other routers (e.g., open-source or FRRouting), =
Linux sends
ARP normally under identical QEMU network configuration
        =E2=80=A2       On Wireshark, it=E2=80=99s like Linux decides not t=
o even try sending
ARP to the C8000v MAC/IP

=E2=B8=BB

Question:
Is there a known kernel-level quirk where Linux might suppress ARP probing =
to a
VM MAC/interface type it =E2=80=9Cdistrusts=E2=80=9D or doesn=E2=80=99t rec=
ognize as reachable?

Any suggestions on forcing or debugging ARP emission on Linux (e.g.,
netlink-level tracing or ARP stack debug)?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

