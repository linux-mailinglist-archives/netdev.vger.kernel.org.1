Return-Path: <netdev+bounces-36381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F07AF717
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 21467281555
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156F620;
	Wed, 27 Sep 2023 00:13:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EBE197
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:21 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB249F3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf4752c3cso70901225ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773599; x=1696378399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DK40Eck5zECxgvS8DjW8+iFtC8FWzowBZoTv3Y4ADJA=;
        b=HKJDJ1gA+RdyVUFetHrt69atnqcTpeqM7ayhthe8jQToSPpLW4OF0Ab1A3P0aF1F/H
         7OHRW7j6vE/nsOquFMfRW9OzhX/+U9cyD1YpYRf71G+qUt8emvMSNn0x/dPoTGTux0VN
         CXl+vJftfuCMi2LQROXhHsgSfZWud+Qm2PYc8i2aTbocYKNLwELyX8HOwqDAFIwDvFZk
         L65Su1yq1m9UJLUhuh0CD1Uv5ITDJcdKlgbROctSZcVGuKcB7bX0+erYd6c8kDOO8+gC
         SKWTJ/qmBs9Gy7+KfqqCzTkvvsHXFReNQgSVnHrVgjWGc8tT563QD+QsufoaUGJZgwCX
         3yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773599; x=1696378399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK40Eck5zECxgvS8DjW8+iFtC8FWzowBZoTv3Y4ADJA=;
        b=nhiIOyftBdD9plz1kjHvEBoanfjxoF23DLi1BileZ+N/vI9VO3u+fks4oj7YLrKXvl
         B2f+t1/Ncvw5WDQ2wrNUna51X1rjqpQeWWawXjV+J6ge8quHiMiJxT1s566EOexxr8fu
         o++PCzTPffTqV+clS7vY2IfCMLz1irePj+QrB3jKFOtlP98WL4Q9IBWbm5dGsTQ/PuIA
         3R4cU6COMz0Zid+17mwvrGGCDm8x0ep5nktAb+FovNwhgbIXJitTb/rFwuftBvN1fEAY
         /pbWs84CNGjySmyoRFV9+Tz0aMt8t2grLDv8o6jyIznBtEdjhdpXGI4p870D4bJLiR1c
         thjA==
X-Gm-Message-State: AOJu0YxD2YXU4mOOJCv8P07AdFwEYiRYfBAQvEuaFGKbKrsKOAuGpekH
	1IfeUuxOW3jbi9Of0hRDK0iNc2oPQXc=
X-Google-Smtp-Source: AGHT+IFzINaxPpzPDAExrpxTJ7+14CTacDcxW7xgUUDRsPCPqTnMVXrnAwqjLMt/L8DJ/ffap1rsrw==
X-Received: by 2002:a17:902:744b:b0:1c4:48c4:969b with SMTP id e11-20020a170902744b00b001c448c4969bmr254977plt.52.1695773599251;
        Tue, 26 Sep 2023 17:13:19 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
Date: Wed, 27 Sep 2023 10:13:01 +1000
Message-Id: <20230927001308.749910-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

We've got a report of a stack overflow on ppc64le with a 16kB kernel
stack. Openvswitch is just one of many things in the stack, but it
does cause recursion and contributes to some usage.

Here are a few patches for reducing stack overhead. I don't know the
code well so consider them just ideas. GFP_ATOMIC allocations
introduced in a couple of places might be controversial, but there
is still some savings to be had if you skip those.

Here is one place detected where the stack reaches >14kB before
overflowing a little later. I massaged the output so it just shows
the stack frame address on the left.

[c00000037d480b40] __kmalloc+0x8c/0x5e0
[c00000037d480bc0] virtqueue_add_outbuf+0x354/0xac0
[c00000037d480cc0] xmit_skb+0x1dc/0x350 [virtio_net]
[c00000037d480d50] start_xmit+0xd4/0x3b0 [virtio_net]
[c00000037d480e00] dev_hard_start_xmit+0x11c/0x280
[c00000037d480e80] sch_direct_xmit+0xec/0x330
[c00000037d480f20] __dev_xmit_skb+0x41c/0xa80
[c00000037d480f90] __dev_queue_xmit+0x414/0x950
[c00000037d481070] ovs_vport_send+0xb4/0x210 [openvswitch]
[c00000037d4810f0] do_output+0x7c/0x200 [openvswitch]
[c00000037d481140] do_execute_actions+0xe48/0xeb0 [openvswitch]
[c00000037d481300] ovs_execute_actions+0x78/0x1f0 [openvswitch]
[c00000037d481380] ovs_dp_process_packet+0xb4/0x2e0 [openvswitch]
[c00000037d481450] ovs_vport_receive+0x8c/0x130 [openvswitch]
[c00000037d481660] internal_dev_xmit+0x40/0xd0 [openvswitch]
[c00000037d481690] dev_hard_start_xmit+0x11c/0x280
[c00000037d481710] __dev_queue_xmit+0x634/0x950
[c00000037d4817f0] neigh_hh_output+0xd0/0x180
[c00000037d481840] ip_finish_output2+0x31c/0x5c0
[c00000037d4818e0] ip_local_out+0x64/0x90
[c00000037d481920] iptunnel_xmit+0x194/0x290
[c00000037d4819c0] udp_tunnel_xmit_skb+0x100/0x140 [udp_tunnel]
[c00000037d481a80] geneve_xmit_skb+0x34c/0x610 [geneve]
[c00000037d481bb0] geneve_xmit+0x94/0x1e8 [geneve]
[c00000037d481c30] dev_hard_start_xmit+0x11c/0x280
[c00000037d481cb0] __dev_queue_xmit+0x634/0x950
[c00000037d481d90] ovs_vport_send+0xb4/0x210 [openvswitch]
[c00000037d481e10] do_output+0x7c/0x200 [openvswitch]
[c00000037d481e60] do_execute_actions+0xe48/0xeb0 [openvswitch]
[c00000037d482020] ovs_execute_actions+0x78/0x1f0 [openvswitch]
[c00000037d4820a0] ovs_dp_process_packet+0xb4/0x2e0 [openvswitch]
[c00000037d482170] clone_execute+0x2c8/0x370 [openvswitch]
[c00000037d482210] do_execute_actions+0x4b8/0xeb0 [openvswitch]
[c00000037d4823d0] ovs_execute_actions+0x78/0x1f0 [openvswitch]
[c00000037d482450] ovs_dp_process_packet+0xb4/0x2e0 [openvswitch]
[c00000037d482520] ovs_vport_receive+0x8c/0x130 [openvswitch]
[c00000037d482730] internal_dev_xmit+0x40/0xd0 [openvswitch]
[c00000037d482760] dev_hard_start_xmit+0x11c/0x280
[c00000037d4827e0] __dev_queue_xmit+0x634/0x950
[c00000037d4828c0] neigh_hh_output+0xd0/0x180
[c00000037d482910] ip_finish_output2+0x31c/0x5c0
[c00000037d4829b0] __ip_queue_xmit+0x1b0/0x4f0
[c00000037d482a40] __tcp_transmit_skb+0x450/0x9a0
[c00000037d482b10] tcp_write_xmit+0x4e0/0xb40
[c00000037d482be0] __tcp_push_pending_frames+0x44/0x130
[c00000037d482c50] __tcp_sock_set_cork.part.0+0x8c/0xb0
[c00000037d482c80] tcp_sock_set_cork+0x78/0xa0
[c00000037d482cb0] xs_tcp_send_request+0x2d4/0x430 [sunrpc]
[c00000037d482e50] xprt_request_transmit.constprop.0+0xa8/0x3c0 [sunrpc]
[c00000037d482eb0] xprt_transmit+0x12c/0x260 [sunrpc]
[c00000037d482f20] call_transmit+0xd0/0x100 [sunrpc]
[c00000037d482f50] __rpc_execute+0xec/0x570 [sunrpc]
[c00000037d482fd0] rpc_execute+0x168/0x1d0 [sunrpc]
[c00000037d483010] rpc_run_task+0x1cc/0x2a0 [sunrpc]
[c00000037d483070] nfs4_call_sync_sequence+0x98/0x100 [nfsv4]
[c00000037d483120] _nfs4_server_capabilities+0xd4/0x3c0 [nfsv4]
[c00000037d483210] nfs4_server_capabilities+0x74/0xd0 [nfsv4]
[c00000037d483270] nfs4_proc_get_root+0x3c/0x150 [nfsv4]
[c00000037d4832f0] nfs_get_root+0xac/0x660 [nfs]
[c00000037d483420] nfs_get_tree_common+0x104/0x5f0 [nfs]
[c00000037d4834b0] nfs_get_tree+0x90/0xc0 [nfs]
[c00000037d4834e0] vfs_get_tree+0x48/0x160
[c00000037d483560] nfs_do_submount+0x170/0x210 [nfs]
[c00000037d483600] nfs4_submount+0x250/0x360 [nfsv4]
[c00000037d4836b0] nfs_d_automount+0x194/0x2d0 [nfs]
[c00000037d483710] __traverse_mounts+0x114/0x330
[c00000037d483770] step_into+0x364/0x4d0
[c00000037d4837f0] walk_component+0x8c/0x300
[c00000037d483870] path_lookupat+0xa8/0x260
[c00000037d4838c0] filename_lookup+0xc8/0x230
[c00000037d483a00] vfs_path_lookup+0x68/0xc0
[c00000037d483a60] mount_subtree+0xd0/0x1e0
[c00000037d483ad0] do_nfs4_mount+0x280/0x520 [nfsv4]
[c00000037d483ba0] nfs4_try_get_tree+0x60/0x140 [nfsv4]
[c00000037d483c20] nfs_get_tree+0x60/0xc0 [nfs]
[c00000037d483c50] vfs_get_tree+0x48/0x160
[c00000037d483cd0] do_new_mount+0x204/0x3c0
[c00000037d483d40] sys_mount+0x168/0x1c0
[c00000037d483db0] system_call_exception+0x164/0x310
[c00000037d483e10] system_call_vectored_common+0xe8/0x278

That's hard to decipher so here all the stack frames sorted by
size, and number of appearances if > 1:

528 ovs_vport_receive (x2)
448 do_execute_actions (x3)
416 xs_tcp_send_request
320 filename_lookup
304 nfs_get_root
304 geneve_xmit_skb
256 virtqueue_add_outbuf
240 _nfs4_server_capabilities
224 __dev_queue_xmit (x4)
208 tcp_write_xmit
208 __tcp_transmit_skb
208 ovs_dp_process_packet (x3)
208 do_nfs4_mount
192 udp_tunnel_xmit_skb
176 start_xmit
176 nfs4_submount
176 nfs4_call_sync_sequence
160 sch_direct_xmit
160 nfs_do_submount
160 iptunnel_xmit
160 ip_finish_output2 (x2)
160 clone_execute
144 xmit_skb
144 nfs_get_tree_common
144 __ip_queue_xmit
128 walk_component
128 vfs_get_tree (x2)
128 step_into
128 __rpc_execute
128 ovs_vport_send (x2)
128 ovs_execute_actions (x3)
128 nfs4_try_get_tree
128 nfs4_proc_get_root
128 __kmalloc
128 geneve_xmit
128 dev_hard_start_xmit (x4)
112 xprt_transmit
112 __tcp_push_pending_frames
112 sys_mount
112 mount_subtree
112 do_new_mount
112 __dev_xmit_skb
96 xprt_request_transmit.constprop.0
96 vfs_path_lookup
96 __traverse_mounts
96 system_call_exception
96 rpc_run_task
96 nfs_d_automount
96 nfs4_server_capabilities
80 path_lookupat
80 neigh_hh_output (x2)
80 do_output (x2)
64 rpc_execute
64 ip_local_out
48 __tcp_sock_set_cork.part.0
48 tcp_sock_set_cork
48 nfs_get_tree (x2)
48 internal_dev_xmit (x2)
48 call_transmit

Thanks,
Nick

Nicholas Piggin (7):
  net: openvswitch: Move NSH buffer out of do_execute_actions
  net: openvswitch: Reduce execute_push_nsh stack overhead
  net: openvswitch: uninline action execution
  net: openvswitch: ovs_vport_receive reduce stack usage
  net: openvswitch: uninline ovs_fragment to control stack usage
  net: openvswitch: Reduce ovs_fragment stack usage
  net: openvswitch: Reduce stack usage in ovs_dp_process_packet

 net/openvswitch/actions.c  | 139 +++++++++++++++++++++++--------------
 net/openvswitch/datapath.c |  55 ++++++++-------
 net/openvswitch/drop.h     |   1 +
 net/openvswitch/vport.c    |  14 +++-
 4 files changed, 129 insertions(+), 80 deletions(-)

-- 
2.40.1


