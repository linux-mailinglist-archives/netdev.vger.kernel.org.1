Return-Path: <netdev+bounces-218310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9657B3BE64
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411DC583284
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0F322DAB;
	Fri, 29 Aug 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fPOCBJaM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9841C84DE
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478663; cv=none; b=FLnp70SOnqS6r8XKHqBnvt3UFbLNkirjnqQInucSxq59X85437RD5NHDwhEWW3jdwUSqLYs149YhCVPzklWLtgmfNo2+Cpzofm1WSmD/W8bye+VGDFxRrJOfKUrywugl4tVMFJziZ87yEvbY7AYJnEUT9sH5+eMiGEAvrcD2AD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478663; c=relaxed/simple;
	bh=XXdBiwS1w/UD3DRFrMusqh76Mi9ZkCR0omws2+NUKdg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RK9PrBP7egkCPlQCYflEDnv22gdcp3X8WL59zLQC+r6GV9RkwOraspLRN9KLjLL+2LNQDsUUr3QP+wTwV0v7isy6exCLtHlxKmyrHuCOygfK83HyvGVXtaxdWF3i7b+EtXYPjNyugcJ6Ku/KH9yaUONTlWbiXnrGunFgWKbdUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fPOCBJaM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b297962b24so22536991cf.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756478659; x=1757083459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3FvKFoRx7HI/pYwAnOq73IUezTtrhH1QBQ1FIjT0Ew=;
        b=fPOCBJaMiDS3GTyMRQISAFmBYurt6830QjRnnO8S/rfprM5i9cpZCHtrnao+G6RATH
         bFnsI5pbN/vEhuuovfN9oqK0M0e9bHHuJwQUpWqjvas4UOYH2xGFqfhukWrQcHGjC+iB
         xDJ6VWLZWeSQuNxD/b4lYzEyfHQ4ULW3jCcjjrcQt7w5yR+iWGhmG/uJpebem6l80sYB
         4rVnhCR2AFMzzSlenvQx7Q/rd4+XUkyftZ6OiyFgSN5dck3LDu1ZmcQ4hXB4QOxdBxio
         Q+cTuk78UvQQzRTiCbT6PaTo5PQnGNOKxPcyp1n4KzBzgURtiCFoB6sbcTbOX7OA/vgZ
         gRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478659; x=1757083459;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3FvKFoRx7HI/pYwAnOq73IUezTtrhH1QBQ1FIjT0Ew=;
        b=F22sYGs143/wos2XQEweR+wcUXFtwYg07plLfXHSeqwZPzIBI2nvN4zoqBKFABU/yi
         nG5+uCepYhdHnCrMhgSlokhY1Nfyojdc64DCLkuvirQ2DcjZKvTTMeaIjRTo3+HPZvuX
         ibRC79ov5SwttkyIBFjZtv4SS2Z0fYyvAUfedeqHOnr260EJw/FTBC6gCoqA5p96ipMw
         qijtpRIeqzSBsLqU6gR99/9vRYkgVlKiYtmMAhDozdQPm2s/XcK0h06+yB9Y4yz6EXrR
         ueEkey4NWYW1yDLyA1o6K27chrzIDe1oYKQOAp3acZ+RxDHduhpttO9sHbZOo950qcgm
         /qZg==
X-Gm-Message-State: AOJu0YznoKAoRZBS3TyK072iT76qBhTibYJl3QkL3LkVR/+uuAph6rFf
	20+6N+sUCX5V3gQVXWmf6WQlwnr36z1KVxSqV7YVOZ4gKAdGvMmUlN3HuDD36c+dD69wfdO6Fy3
	mMwMX
X-Gm-Gg: ASbGncvCXUfl+ktpT+69szdj6LY9VijbZtXIeDcGzrK9u3FkRHtZp5oAafmMe4bCDVW
	D8FlVZo8SAAKeVgHXWDZikPzrVKey0w0Tr51gKZomXooADteYNAbt9HFM3KA2iSVYx8QvGb0Ih/
	W7u6J9NL+TB82z+0SY5skvWp2XpbJOGeFJP6E0MgLZY1Rvx5+zE0jCTwKj2NeuWxkZillBl2Sv1
	Qp1xOXQoXPD9zZld1DTD8e7LKHSBqwxA7LCOXTmXDHXrjTNe6NdUwR5P998aOKw4nGIMxZrv+sF
	t6hHxXf9b5pVwEQL3QtTxn/LrInBRwhcPhiWs29FXVk7ipBPY1QzimfVX22VOam+q9+RuF8nv16
	+Aia5is6253dAYrNf0udBv1lwsZGfJTF/mT4k5pM73gGbdMOFQjFmktYAvKqNQ0E1SxTO4nW5cO
	yaNtv2I427xA==
X-Google-Smtp-Source: AGHT+IEExxWsKrXzT25xqvoE6KnOwxpH87/DSINSS76dshV5gQ6Dm9qmcP+51HyCHKeJir9UCECXOg==
X-Received: by 2002:a05:622a:1a1a:b0:4b0:edba:5a47 with SMTP id d75a77b69052e-4b2aab050e7mr327009811cf.53.1756478658520;
        Fri, 29 Aug 2025 07:44:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b679105sm16050611cf.27.2025.08.29.07.44.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:44:18 -0700 (PDT)
Date: Fri, 29 Aug 2025 07:44:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220513] New: [6.12.44 regression] kernel NULL pointer
 dereference on `pppoe` (or `bridge`)
Message-ID: <20250829074415.06723b1d@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Fri, 29 Aug 2025 13:20:21 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220513] New: [6.12.44 regression] kernel NULL pointer dereference on `pppoe` (or `bridge`)


https://bugzilla.kernel.org/show_bug.cgi?id=220513

            Bug ID: 220513
           Summary: [6.12.44 regression] kernel NULL pointer dereference
                    on `pppoe` (or `bridge`)
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: nanericwang@gmail.com
        Regression: No

Having upgraded from 6.12.43 to 6.12.44, my kernel crashed at early boot. The
root cause is most likely related to the commit
94731cc551e29511d85aa8dec61a6c071b1f2430 (Fixes: f6efc675c9dd ("net: ppp:
resolve forwarding path for bridge pppoe devices")). 

```
Aug 29 20:36:16 localhost kernel: NET: Registered PF_PPPOX protocol family
Aug 29 20:36:17 localhost systemd-networkd[266]: Failed to parse hostname,
ignoring: Invalid argument
Aug 29 20:36:17 localhost systemd-networkd[266]: br0: DHCPv4 server: DISCOVER
(0xebeec00c)
Aug 29 20:36:17 localhost kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000058
Aug 29 20:36:17 localhost kernel: #PF: supervisor read access in kernel mode
Aug 29 20:36:17 localhost kernel: #PF: error_code(0x0000) - not-present page
Aug 29 20:36:17 localhost kernel: PGD 0 P4D 0 
Aug 29 20:36:17 localhost kernel: Oops: Oops: 0000 [#1] PREEMPT_RT SMP
Aug 29 20:36:17 localhost kernel: CPU: 1 UID: 981 PID: 266 Comm:
systemd-network Not tainted 6.12.44-xanmod1-1-lts #1
Aug 29 20:36:17 localhost kernel: Hardware name: Default string Default
string/Default string, BIOS 5.19 03/30/2021
Aug 29 20:36:17 localhost kernel: RIP: 0010:0xffffffffb32b2f6c
Aug 29 20:36:17 localhost kernel: Code: 85 8e 01 00 00 48 8b 44 24 08 48 8b 40
30 65 48 03 05 48 26 d6 4c e9 f0 fd ff ff e8 5e 9c c1 ff e9 ca fc ff ff 49 8b
44 24 18 <48> 8b 40 58 48 3d 00 e3 65 b3 0f 84 0f 01 00 00 48 89 c2 48 8d 78
Aug 29 20:36:17 localhost kernel: RSP: 0018:ffff9bd080c778d8 EFLAGS: 00010246
Aug 29 20:36:17 localhost kernel: RAX: 0000000000000000 RBX: ffff9bd080c77a00
RCX: 0000000000000001
Aug 29 20:36:17 localhost kernel: RDX: 0000000000000000 RSI: 000000000002a424
RDI: ffffffffb38b6040
Aug 29 20:36:17 localhost kernel: RBP: ffff999345ad1000 R08: 0000000000000003
R09: 0000000000000000
Aug 29 20:36:17 localhost kernel: R10: ffff999342eb7900 R11: 0000000000000000
R12: ffff9bd080c77948
Aug 29 20:36:17 localhost kernel: R13: 0000000000000008 R14: 0000000000000000
R15: 0000000090000000
Aug 29 20:36:17 localhost kernel: FS:  00007fc0bab148c0(0000)
GS:ffff9994b7d00000(0000) knlGS:0000000000000000
Aug 29 20:36:17 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 29 20:36:17 localhost kernel: CR2: 0000000000000058 CR3: 000000010b438006
CR4: 0000000000b70ef0
Aug 29 20:36:17 localhost kernel: Call Trace:
Aug 29 20:36:17 localhost kernel:  <TASK>
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb321d725
Aug 29 20:36:17 localhost kernel:  0xffffffffb32b4197
Aug 29 20:36:17 localhost kernel:  0xffffffffb32f5d6c
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb32b8c40
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb3212da5
Aug 29 20:36:17 localhost kernel:  0xffffffffb3212da5
Aug 29 20:36:17 localhost kernel:  0xffffffffb32131ea
Aug 29 20:36:17 localhost kernel:  0xffffffffb32152ea
Aug 29 20:36:17 localhost kernel:  0xffffffffb3364479
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb3364485
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb3215617
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb2f2cd31
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb33684f7
Aug 29 20:36:17 localhost kernel:  0xffffffffb34000b0
Aug 29 20:36:17 localhost kernel: RIP: 0033:0x00007fc0bb35e1ce
Aug 29 20:36:17 localhost kernel: Code: 4d 89 d8 e8 64 be 00 00 4c 8b 5d f8 41
8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45
10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
Aug 29 20:36:17 localhost kernel: RSP: 002b:00007ffe7f2ef730 EFLAGS: 00000202
ORIG_RAX: 000000000000002e
Aug 29 20:36:17 localhost kernel: RAX: ffffffffffffffda RBX: 000005b3d81d1b00
RCX: 00007fc0bb35e1ce
Aug 29 20:36:17 localhost kernel: RDX: 0000000000000000 RSI: 00007ffe7f2ef7a0
RDI: 0000000000000017
Aug 29 20:36:17 localhost kernel: RBP: 00007ffe7f2ef740 R08: 0000000000000000
R09: 0000000000000000
Aug 29 20:36:17 localhost kernel: R10: 0000000000000000 R11: 0000000000000202
R12: 000005b3d81d1b00
Aug 29 20:36:17 localhost kernel: R13: 000005b3d81d0480 R14: 000005b3d8034800
R15: 000005b3d803481c
Aug 29 20:36:17 localhost kernel:  </TASK>
Aug 29 20:36:17 localhost kernel: Modules linked in: pppoe pppox af_packet
sch_cake bridge stp llc xt_DSCP xt_set xt_TCPMSS xt_tcpudp iptable_mangle
xt_connlimit nf_conncount xt_conntrack iptable_filter xt_MASQUERADE iptable_nat
nf_nat msr ip_set_hash_net ip_set nls_ascii nls_cp437 vfat fat intel_rapl_msr
hid_generic evdev coretemp intel_tcc_cooling x86_pkg_temp_thermal
intel_powerclamp rapl intel_cstate intel_uncore
processor_thermal_device_pci_legacy intel_soc_dts_iosf processor_thermal_device
processor_thermal_wt_hint processor_thermal_rfim processor_thermal_rapl igb
spi_intel_pci usbhid intel_rapl_common spi_intel ptp iosf_mbi pps_core i2c_i801
hid i2c_smbus i2c_algo_bit processor_thermal_wt_req fan hwmon
processor_thermal_power_floor processor_thermal_mbox i2c_core thermal
int340x_thermal_zone acpi_pad button ppp_generic slhc nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nfnetlink ip_tables x_tables ipv6 xhci_pci
xhci_hcd usbcore usb_common btrfs sha256_ssse3 sha256_generic libsha256
zstd_compress raid6_pq zlib_deflate lzo_decompress
Aug 29 20:36:17 localhost kernel:  lzo_compress zlib_inflate xor libcrc32c
crc32c_generic
Aug 29 20:36:17 localhost kernel: CR2: 0000000000000058
Aug 29 20:36:17 localhost kernel: ---[ end trace 0000000000000000 ]---
Aug 29 20:36:17 localhost kernel: RIP: 0010:0xffffffffb32b2f6c
Aug 29 20:36:17 localhost kernel: Code: 85 8e 01 00 00 48 8b 44 24 08 48 8b 40
30 65 48 03 05 48 26 d6 4c e9 f0 fd ff ff e8 5e 9c c1 ff e9 ca fc ff ff 49 8b
44 24 18 <48> 8b 40 58 48 3d 00 e3 65 b3 0f 84 0f 01 00 00 48 89 c2 48 8d 78
Aug 29 20:36:17 localhost kernel: RSP: 0018:ffff9bd080c778d8 EFLAGS: 00010246
Aug 29 20:36:17 localhost kernel: RAX: 0000000000000000 RBX: ffff9bd080c77a00
RCX: 0000000000000001
Aug 29 20:36:17 localhost kernel: RDX: 0000000000000000 RSI: 000000000002a424
RDI: ffffffffb38b6040
Aug 29 20:36:17 localhost kernel: RBP: ffff999345ad1000 R08: 0000000000000003
R09: 0000000000000000
Aug 29 20:36:17 localhost kernel: R10: ffff999342eb7900 R11: 0000000000000000
R12: ffff9bd080c77948
Aug 29 20:36:17 localhost kernel: R13: 0000000000000008 R14: 0000000000000000
R15: 0000000090000000
Aug 29 20:36:17 localhost kernel: FS:  00007fc0bab148c0(0000)
GS:ffff9994b7d00000(0000) knlGS:0000000000000000
Aug 29 20:36:17 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 29 20:36:17 localhost kernel: CR2: 0000000000000058 CR3: 000000010b438006
CR4: 0000000000b70ef0
Aug 29 20:36:17 localhost kernel: note: systemd-network[266] exited with irqs
disabled
Aug 29 20:36:17 localhost kernel: ------------[ cut here ]------------
Aug 29 20:36:17 localhost kernel: Voluntary context switch within RCU read-side
critical section!
Aug 29 20:36:17 localhost kernel: WARNING: CPU: 1 PID: 266 at
0xffffffffb2ed1cc7
Aug 29 20:36:17 localhost kernel: Modules linked in: pppoe pppox af_packet
sch_cake bridge stp llc xt_DSCP xt_set xt_TCPMSS xt_tcpudp iptable_mangle
xt_connlimit nf_conncount xt_conntrack iptable_filter xt_MASQUERADE iptable_nat
nf_nat msr ip_set_hash_net ip_set nls_ascii nls_cp437 vfat fat intel_rapl_msr
hid_generic evdev coretemp intel_tcc_cooling x86_pkg_temp_thermal
intel_powerclamp rapl intel_cstate intel_uncore
processor_thermal_device_pci_legacy intel_soc_dts_iosf processor_thermal_device
processor_thermal_wt_hint processor_thermal_rfim processor_thermal_rapl igb
spi_intel_pci usbhid intel_rapl_common spi_intel ptp iosf_mbi pps_core i2c_i801
hid i2c_smbus i2c_algo_bit processor_thermal_wt_req fan hwmon
processor_thermal_power_floor processor_thermal_mbox i2c_core thermal
int340x_thermal_zone acpi_pad button ppp_generic slhc nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nfnetlink ip_tables x_tables ipv6 xhci_pci
xhci_hcd usbcore usb_common btrfs sha256_ssse3 sha256_generic libsha256
zstd_compress raid6_pq zlib_deflate lzo_decompress
Aug 29 20:36:17 localhost kernel:  lzo_compress zlib_inflate xor libcrc32c
crc32c_generic
Aug 29 20:36:17 localhost kernel: CPU: 1 UID: 981 PID: 266 Comm:
systemd-network Tainted: G      D            6.12.44-xanmod1-1-lts #1
Aug 29 20:36:17 localhost kernel: Tainted: [D]=DIE
Aug 29 20:36:17 localhost kernel: Hardware name: Default string Default
string/Default string, BIOS 5.19 03/30/2021
Aug 29 20:36:17 localhost kernel: RIP: 0010:0xffffffffb2ed1cc7
Aug 29 20:36:17 localhost kernel: Code: ff ff 45 85 c9 0f 84 17 fd ff ff 48 89
b9 a8 00 00 00 e9 0b fd ff ff 48 c7 c7 28 4d 6a b3 c6 05 7c a5 9e 00 01 e8 b9
5a f8 ff <0f> 0b e9 61 fc ff ff 44 89 4c 24 14 44 89 44 24 10 48 89 4c 24 08
Aug 29 20:36:17 localhost kernel: RSP: 0018:ffff9bd080c77bf8 EFLAGS: 00010046
Aug 29 20:36:17 localhost kernel: RAX: 0000000000000000 RBX: ffff9994b7d258c0
RCX: 0000000000000027
Aug 29 20:36:17 localhost kernel: RDX: ffff9994b7d1c748 RSI: 0000000000000001
RDI: ffff9994b7d1c740
Aug 29 20:36:17 localhost kernel: RBP: ffff99934a2ca900 R08: 0000000000000e28
R09: ffffffffb36a4d66
Aug 29 20:36:17 localhost kernel: R10: ffffffffb36a4d67 R11: 00000000ffffe4b8
R12: ffff9994b7d24b80
Aug 29 20:36:17 localhost kernel: R13: 0000000000000000 R14: ffff99934a2ca900
R15: ffff9bd080c77cf8
Aug 29 20:36:17 localhost kernel: FS:  0000000000000000(0000)
GS:ffff9994b7d00000(0000) knlGS:0000000000000000
Aug 29 20:36:17 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 29 20:36:17 localhost kernel: CR2: 0000000000000058 CR3: 000000023ae18001
CR4: 0000000000b70ef0
Aug 29 20:36:17 localhost kernel: Call Trace:
Aug 29 20:36:17 localhost kernel:  <TASK>
Aug 29 20:36:17 localhost kernel:  0xffffffffb336b943
Aug 29 20:36:17 localhost kernel:  0xffffffffb336c012
Aug 29 20:36:17 localhost kernel:  0xffffffffb337492f
Aug 29 20:36:17 localhost kernel:  0xffffffffb336d874
Aug 29 20:36:17 localhost kernel:  0xffffffffb2ec39d1
Aug 29 20:36:17 localhost kernel:  0xffffffffb2ec787b
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb2ecfe50
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb2ec38a0
Aug 29 20:36:17 localhost kernel:  0xffffffffb2ecb196
Aug 29 20:36:17 localhost kernel:  0xffffffffb2ecbfa7
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb2fd71aa
Aug 29 20:36:17 localhost kernel:  ? 0xffffffffb2fe77f1
Aug 29 20:36:17 localhost kernel:  0xffffffffb2fd77f1
Aug 29 20:36:17 localhost kernel:  0xffffffffb2fddd87
Aug 29 20:36:17 localhost kernel:  0xffffffffb2e7f9b6
Aug 29 20:36:17 localhost kernel:  0xffffffffb2e5bfc6
Aug 29 20:36:17 localhost kernel:  0xffffffffb2e5c7b4
Aug 29 20:36:17 localhost kernel:  0xffffffffb2e01a86
Aug 29 20:36:17 localhost kernel: RIP: 0033:0x00007fc0bb35e1ce
Aug 29 20:36:17 localhost kernel: Code: Unable to access opcode bytes at
0x7fc0bb35e1a4.
Aug 29 20:36:17 localhost kernel: RSP: 002b:00007ffe7f2ef730 EFLAGS: 00000202
ORIG_RAX: 000000000000002e
Aug 29 20:36:17 localhost kernel: RAX: ffffffffffffffda RBX: 000005b3d81d1b00
RCX: 00007fc0bb35e1ce
Aug 29 20:36:17 localhost kernel: RDX: 0000000000000000 RSI: 00007ffe7f2ef7a0
RDI: 0000000000000017
Aug 29 20:36:17 localhost kernel: RBP: 00007ffe7f2ef740 R08: 0000000000000000
R09: 0000000000000000
Aug 29 20:36:17 localhost kernel: R10: 0000000000000000 R11: 0000000000000202
R12: 000005b3d81d1b00
Aug 29 20:36:17 localhost kernel: R13: 000005b3d81d0480 R14: 000005b3d8034800
R15: 000005b3d803481c
Aug 29 20:36:17 localhost kernel:  </TASK>
Aug 29 20:36:17 localhost kernel: ---[ end trace 0000000000000000 ]---
```

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

