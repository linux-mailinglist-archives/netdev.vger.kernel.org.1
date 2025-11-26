Return-Path: <netdev+bounces-241897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BBEC89C55
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1635745B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E82E0401;
	Wed, 26 Nov 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjeN7Kvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228B327214
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160236; cv=none; b=k4S9CZnhXdtaVSQVVd9GpxiW+0jZYz2Dr5uC6zwClrAqfHBBErD+80DV5T4xK0JtBg/LHqC/GZ6dlIDPcQD/JbX8I/9A7dpYHllmFMA5LCKewBxxE1qjYhEiocuKqvEN69d4E4l6ndIx/aFOX0DJfLm1XykUHaKjwF2t8d7pHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160236; c=relaxed/simple;
	bh=zuDAeWXxkcATIwWSYfYjainxxEHyxp6MfJIcYrvvFoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hLtmelTfWMLWYhkZw4yxkpnP7Gk29C42w3SA8uKmgvADYgm4tp49eHfL66nWsxNgsD7E7rFejamtZQJaWMafVPou5POmTiQrfgCihM/qlEIvZSElTViSGGzhDaOZsRdZWkpOfUivg2HKXP7eRwKXkKyybh90zItLpPvmX2DZY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjeN7Kvu; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640d43060d2so5760711d50.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160233; x=1764765033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlACRUyTfvoHdS9cGSsq8rSReNgiGVEbr819gPfJSB8=;
        b=GjeN7Kvu4Nl9lY604HjcIYSADd1sDimiL1T5Pi9dKs4GCtAMfpZpQYmQKJ47AYV/Nw
         n4AI92w5pF+apPgEVDay92lAYF/5yI3KafvNrQPyN6ktXjhyaWn/geatuRAh2Th9myie
         1d441qy+FMgLTur1SNouRVensgJEbgkyVMkzmdX2U8W2xh1RqA6oHn0P/vJ0jEGG/f41
         z4h3UXLnxsJzN9mqrvNF9jkkoreyD6pqaWSrB2kFW0xxqyGsOJPtj8VmmZCtOooG75jQ
         8aPvtIEhjDLzWedwmaBEcg6J70UDy7IaF2xNXxgBG8/0o0ny7MjhO9c8zFSRsXh0uxUR
         wJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160233; x=1764765033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlACRUyTfvoHdS9cGSsq8rSReNgiGVEbr819gPfJSB8=;
        b=uJ4p1MdnaYpUyO3jWmtsoFH3aVzNTf5tUABQzNwk+4OttrIz85WJjik48+GnkEQt72
         YRwHs9v8iJqz3T3ujMMkCpR7mlPlY4lfzT9RjblrDwYhnN2SDZujWzXOLu6Qlh4I/JX8
         oj742uA2rJ4F1HtIidmjGpteKHhCA1Rwn1uqA1dAs3ZNVRyHKqEIuz10z67k8VtcbAhb
         Lnk6/Ft5Jn7pLuQoO0M/QZlZVuVY0sQNITk0n/hEfj2k3hjJesU+wXD/ZePqGbKeLO3Y
         0Rr+x8OwJN9+0v0FFpOOduCJGoNB/AsOvtn/oKXIvvOpPeG8r0ePA4c09Cto1hi2lOEv
         jZ4Q==
X-Gm-Message-State: AOJu0YxH4S3uoIYEW6eAshBrwMs9s2nfe4e3PFrTvlj1Lae3oj4dfE6w
	XOh1ZCriNpZZaPSdyMJ95tF1rCpF+qHOXkpJtZFzgd95DsqoQrNv5pvtvlHXfD1KZtpeDQfFUbL
	fyO4GxXce5edRcUw3vSDwu8W6ODfv+b0=
X-Gm-Gg: ASbGncvFOAacW0g5TgV29SkTGh5Cj90BlLKZEIkOHGFAyfcnoVAX43j2Qrvyj9jwFfW
	cowfgfxHuX49KTD6c6OkD+HYtHRLhnyN78MOai+BtAlhKDUNEdOjjt6wjmFStnf0z9wZe4aAWIq
	x8NJC3yjAecLP4iCYUvcuQgOAcZz+rEFVa0e731RyZ5S8p0qbG1JK3G+NYnmZxjAZs0J2orCiWX
	Fep7uDWmaEslmHZH4FT/C02BFmUMwHbvTcJaeY/JBCHZ4UHiypgIUsFz4mLRnnCIj3TB4lL
X-Google-Smtp-Source: AGHT+IEXOQizvqc9+llt4jpKTxdi4Usw+dQaJcuWB7KGpGg1Ub3djwY0vSqecK9u7OfoT57oCq1pvjfTjjA8S8EiRMc=
X-Received: by 2002:a53:cd8c:0:b0:63e:1943:ce49 with SMTP id
 956f58d0204a3-64302abb486mr9848238d50.39.1764160233107; Wed, 26 Nov 2025
 04:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 26 Nov 2025 20:29:57 +0800
X-Gm-Features: AWmQ_blT03ccA0A6TDwXKfZCeqXMEMCfqIm_UBBK6puqc4GIDnJiJfBGl4UPp9s
Message-ID: <CALOAHbDOMD9+FUw6aog=AKa-6+a_9tuqaQhq3LKXLzFgzBreSg@mail.gmail.com>
Subject: [BUG] mlx5e: ARP broadcast over offloaded bridge fails when using a
 bonded LACP interface
To: Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com, mbloch@nvidia.com, 
	Nikolay Aleksandrov <razor@blackwall.org>, idosch@nvidia.com, jv@jvosburgh.net, 
	andrew+netdev@lunn.ch, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello mlx5e/bridge/bonding maintainers,

Technical Context
------------------------

In our Kubernetes production environment, we have enabled SR-IOV on
ConnectX-6 DX NICs to allow multiple containers to share a single
Physical Function (PF). In other words, each container is assigned its
own Virtual Function (VF).

We have two CX6-DX NICs on a single host, configured in a bonded
interface. The VFs and the bonding device are connected via a Linux
bridge. Both CX6-DX NICs are operating in switchdev mode, and the
Linux bridge is offloaded. The topology is as follows:

         Container0
                |
         VF reppresentor
                |
       linux bridge (offloaded)
                |
              bond
                |
    +----------------------+
    |                            |
eth0 (PF)               eth1 (PF)


Both eth0 and eth1 are on switchdev mode.

  $ cat /sys/class/net/eth0/compat/devlink/mode
   switchdev
  $ cat /sys/class/net/eth1/compat/devlink/mode
   swithcdev

This setup follows the guidance provided in the official NVIDIA
documentation [0].

The bond is configured in 802.3ad (LACP) mode. We enabled the ARP
broadcast feature on the bonding device, which is functionally similar
to the patchset referenced here:

   https://lore.kernel.org/all/cover.1750642572.git.tonghao@bamaicloud.com/

Issue Description
------------------------

When pinging another host from Container0, we observe that only one
ARP request is sent out, even though both eth0 and eth1 appear to be
generating ARP requests at the PF level, and the doorbell is being
triggered.

tcpdump output:

  $ tcpdump -i any -n arp host 10.247.209.128
  17:50:16.309758 eth1_5 B   ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38
  17:50:16.309777 eth0_5 Out ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38
  17:50:16.309784 bond0 Out ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38
  17:50:16.309786 eth0  Out ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38
  17:50:16.309788 eth1  Out ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38
  17:50:16.309758 bridge0 B   ARP, Request who-has 10.247.209.128 tell
10.247.209.140, length 38

No ARP reply is captured by tcpdump.

However, ARP broadcast appears to be functional, as two ARP requests
are triggering the doorbell, as traced by the following bpftrace
script:

kprobe:mlx5e_sq_xmit_wqe
{
        $skb =3D (struct sk_buff *)arg1;

        if ($skb->protocol !=3D 0x608) { // arp
                return;
        }

        $iph =3D (struct iphdr *)($skb->head + $skb->network_header);
        $arp_data =3D $skb->head + $skb->network_header + sizeof(struct arp=
hdr);
        $arph =3D (struct arphdr *)($skb->head + $skb->network_header);
        $smac =3D $arp_data;

        $sip =3D $arp_data + 6;
        $tip =3D $arp_data + 16;
        // 10.247.209.128
        if (!($tip[0] =3D=3D 10 && $tip[1] =3D=3D 247 && $tip[2] =3D=3D 209=
 &&
$tip[3] =3D=3D 128)) {
                return;
        }

        $dev =3D $skb->dev;
        $dev_name =3D $skb->dev->name;

        printf("Device:%s(%02x:%02x:%02x:%02x:%02x:%02x) [%d] Sender
IP:%d.%d.%d.%d (%02x:%02x:%02x:%02x:%02x:%02x), ",
                $dev_name, $dev->dev_addr[0], $dev->dev_addr[1],
$dev->dev_addr[2], $dev->dev_addr[3],
                $dev->dev_addr[4], $dev->dev_addr[5], $dev->ifindex,
                $sip[0], $sip[1], $sip[2], $sip[3],
                $smac[0], $smac[1], $smac[2], $smac[3], $smac[4], $smac[5])=
;

        printf("Target IP:%d.%d.%d.%d, OP:%d\n",
                $tip[0], $tip[1], $tip[2], $tip[3],
                 (($arph->ar_op & 0xFF00) >> 8) | (($arph->ar_op &
0x00FF) << 8));
}

bpftrace output:

  Device:eth0_5(ba:d2:2d:ff:80:82) [68] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1
  Device:eth0(e0:9d:73:c3:d2:3e) [2] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1
  Device:eth1(e0:9d:73:c3:d2:3e) [3] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1

And the detailed callstack with bpftrace:

Device:eth0_5(ba:d2:2d:ff:80:82) [68] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1

        mlx5e_sq_xmit_wqe+1
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __dev_xmit_skb+482
        __dev_queue_xmit+637
        br_dev_queue_push_xmit+194
        br_forward_finish+83
        br_nf_hook_thresh+220
        br_nf_forward_finish+381
        br_nf_forward_arp+647
        nf_hook_slow+65
        __br_forward+214
        maybe_deliver+188
        br_flood+118
        br_handle_frame_finish+421
        br_handle_frame+781
        __netif_receive_skb_core.constprop.0+651
        __netif_receive_skb_list_core+291
        netif_receive_skb_list_internal+459
        napi_complete_done+122
        mlx5e_napi_poll+358
        __napi_poll.constprop.0+46
        net_rx_action+680
        __do_softirq+271
        irq_exit_rcu+82
        common_interrupt+142
        asm_common_interrupt+39
        cpuidle_enter_state+237
        cpuidle_enter+52
        cpuidle_idle_call+261
        do_idle+124
        cpu_startup_entry+32
        start_secondary+296
        secondary_startup_64_no_verify+229

Device:eth0(e0:9d:73:c3:d2:3e) [2] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1

        mlx5e_sq_xmit_wqe+1
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __dev_xmit_skb+482
        __dev_queue_xmit+637
        bond_dev_queue_xmit+43
        __bond_start_xmit+590
        bond_start_xmit+70
        dev_hard_start_xmit+142
        __dev_queue_xmit+1260
        br_dev_queue_push_xmit+194
        br_forward_finish+83
        br_nf_hook_thresh+220
        br_nf_forward_finish+381
        br_nf_forward_arp+647
        nf_hook_slow+65
        __br_forward+214
        br_flood+266
        br_handle_frame_finish+421
        br_handle_frame+781
        __netif_receive_skb_core.constprop.0+651
        __netif_receive_skb_list_core+291
        netif_receive_skb_list_internal+459
        napi_complete_done+122
        mlx5e_napi_poll+358
        __napi_poll.constprop.0+46
        net_rx_action+680
        __do_softirq+271
        irq_exit_rcu+82
        common_interrupt+142
        asm_common_interrupt+39
        cpuidle_enter_state+237
        cpuidle_enter+52
        cpuidle_idle_call+261
        do_idle+124
        cpu_startup_entry+32
        start_secondary+296
        secondary_startup_64_no_verify+229

Device:eth1(e0:9d:73:c3:d2:3e) [3] Sender IP:10.247.209.140
(06:99:0f:34:b1:15), Target IP:10.247.209.128, OP:1

        mlx5e_sq_xmit_wqe+1
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __dev_xmit_skb+482
        __dev_queue_xmit+637
        bond_dev_queue_xmit+43
        __bond_start_xmit+590
        bond_start_xmit+70
        dev_hard_start_xmit+142
        __dev_queue_xmit+1260
        br_dev_queue_push_xmit+194
        br_forward_finish+83
        br_nf_hook_thresh+220
        br_nf_forward_finish+381
        br_nf_forward_arp+647
        nf_hook_slow+65
        __br_forward+214
        br_flood+266
        br_handle_frame_finish+421
        br_handle_frame+781
        __netif_receive_skb_core.constprop.0+651
        __netif_receive_skb_list_core+291
        netif_receive_skb_list_internal+459
        napi_complete_done+122
        mlx5e_napi_poll+358
        __napi_poll.constprop.0+46
        net_rx_action+680
        __do_softirq+271
        irq_exit_rcu+82
        common_interrupt+142
        asm_common_interrupt+39
        cpuidle_enter_state+237
        cpuidle_enter+52
        cpuidle_idle_call+261
        do_idle+124
        cpu_startup_entry+32
        start_secondary+296
        secondary_startup_64_no_verify+229

Additionally, traffic captured on the uplink switch confirms that ARP
requests are only being sent via one NIC.

This suggests a potential issue with bridge offloading. However, we
lack the capability to trace hardware-level behavior directly.
Notably, `ethtool -S ethX` shows no packet drops or errors.

Questions
--------------

1. How can we further trace hardware behavior to diagnose this issue?
2. Is this a known limitation of bridge offloading in this configuration?
3. Are there any recommended solutions or workarounds?

This issue is reproducible. We are willing to recompile the mlx
drivers if additional information is needed.

Current driver version:

  $ ethtool -i eth0
  driver: mlx5_core
  version: 24.10-1.1.4
  firmware-version: 22.43.2026 (MT_0000000359)
  expansion-rom-version:
  bus-info: 0000:21:00.0
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: yes

[0].https://docs.nvidia.com/networking/display/public/sol/technology+previe=
w+of+kubernetes+cluster+deployment+with+accelerated+bridge+cni+and+nvidia+e=
thernet+networking#src-119742530_TechnologyPreviewofKubernetesClusterDeploy=
mentwithAcceleratedBridgeCNIandNVIDIAEthernetNetworking-Application

--=20
Regards
Yafang

