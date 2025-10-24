Return-Path: <netdev+bounces-232616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B73C07475
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E271C06B5E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EE3375CD;
	Fri, 24 Oct 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="fCp5XIP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF332A3C5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322949; cv=none; b=VxCniCA8AlwncCCiQo8tQhA1W4so8BnhBpzWqbO4fyfxT76Vqfw2z0pDCVoPnSSVSpnxH4Mf97T+9MI45E4nMHZYgpNnM6VrTgKHtiVahuh73ZIpR1gc3/NzIPWpg8j/C2HNf/RTHLd08KB4EL/hGUCGcFwAC0OBCGpb8V4iH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322949; c=relaxed/simple;
	bh=zXzQPSO/jrtpTKJBfhqMObnOt5hCedFc2KKAMl14pHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=subBmXFMeDN91W5/H1vgghdYu5JLHvHhzXK24Rix8oAr1h8/o4BNcxDA7NRGzJfe+GffFd9XunPu8nicDchcH3vzolcNFrKfwuujstNeYXFLaiZ8/1SAX2i4f9u2bDwr3U/DxlnHmAGXASCoOLQbv1SR+olxzcdvs9Smi+oA+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=fCp5XIP/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so322814166b.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761322945; x=1761927745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFQZPSDbSDhF1z5vy6Avb/wzo1WXqkCtCWCq2avfq6k=;
        b=fCp5XIP/ulbeqPqE1yjihvkqp46bYmnMqvRvck/ctNAa2OgwlbWipJl5MXFHIp/KwI
         edqVoJhrvliSWXZZ+o2mV5RIdG5b/BDHJWUyaicVPxaLb8lyNPzSuRkuemth8yv04VcJ
         Dyk63V5Vmc6g+g//qHCGRnlNdeamY4P16dvstIojByOho1Xvec3Uw7LXVA2taSwZHXDS
         0oP2CP8HFMXN4dYAAspl8nRvatkLnZvCGw6cASudLFVkE59nS8o6TBWqHy3LeJQisJF9
         XlWqh4QcPF2h4XUhafZUcMZZ/pBuYLcYV0QP9HZINjCqBbOT7IsH25FzOf64wgS5JGS9
         UUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322945; x=1761927745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFQZPSDbSDhF1z5vy6Avb/wzo1WXqkCtCWCq2avfq6k=;
        b=NVq0sPTWCwmukEOLBokhjfFpjuUN0Te6HP2mhb5Azq75LhzjaNiylPCjbnMqDhjaZI
         Bw9ZWxgnFEbgjsB9vv073v1MLqeJBCAU3j3AtCDxEjcr+/7/iNWzzCDdXjDhdq1wo2Mx
         SNALTtc5VtLL7tvJJQ8zy9ewGcFq41qVswJc51lr0YtJVajlar2V/vhXgCCG56r0tE1K
         YB5IoDRwTWg9NZe+XsLa5NSG4Z6VGeWi7rMLT4Q48uztCKBvbERZWTZ2O/H8nVNgRfyI
         Kd+6R6jUJdRZyBWDRsi3WbH9DVrG3/ZOlp0h7TBZPnAK2y4ad1JOgZLiWmlVSEGO2dmz
         yq7w==
X-Forwarded-Encrypted: i=1; AJvYcCVsuUNuaEU2V2OPE0CvmUNw6WVTq/XivzDrDyEybAxjLLT04+41HMThlkHyIn+aZmvVjGzcyBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFRofidrrdunLXXgk33uJfJSFplnBJHr7PUlXir+tzDPRvuYF
	G9/4+ScKED/pDGsYq0osB+dNEZhgCuNzzOa2Se3mHy9M7j0I2EDkj/vrnc16xumGGSA=
X-Gm-Gg: ASbGncvq8aoYEhaXg/jWH8wNiB+vPkH5R54LlGsm3ZPrN4FbuF8KfTuzS1GEi0oRZUY
	Z9xm9WgbKqbcWQyPG6ajoTORpe4OmlEaSNDMDlUhrEdxvsK8w89505gRhUAgte86Nmv5GoiKDiZ
	QTWv6xYeF5VO2QN3mnrOkVKc68DhVKRSN5YivBZ/MWLgrSA2/igZzhiKjWejoqmUMblfmad9bEG
	MUUOSBZkiqp4T9sxFbzyb7zX1q82kMLuEfPzMoyWi2YNaraXeg7Kz/hO2xulzF5TZIOjCHw1wkQ
	1Vj+T/G/+yrV/PQCv0TRb+kNbE4OyVJ4kpPBoNQkKq1NZIdfUUBJwm47CIxApvmCMzkU7QBXV36
	aiRbxFPd0hnY72IA6SfTT83DXODsjsDaCvQXzfXAR0CE0y1lKmxOS4lvoDt6ZQL2nXAz9G2FY2I
	UTafHsCAVdcwFOSavAG0j4JLVcFyOV0IevhkC6IcfKeUEEfwyLPmjjqw==
X-Google-Smtp-Source: AGHT+IG7TRNfUo2/zgblkpGLJvHQwoSPUnV+z7vOEwD6yFL19d4NRaKQAjRxLQvkX3EaIjikQtAprg==
X-Received: by 2002:a17:907:d02:b0:b43:3dcf:b6c3 with SMTP id a640c23a62f3a-b6473f42c00mr3287221766b.49.1761322945275;
        Fri, 24 Oct 2025 09:22:25 -0700 (PDT)
Received: from VyOS.. (213-225-38-123.nat.highway.a1.net. [213.225.38.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm559327566b.56.2025.10.24.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:22:23 -0700 (PDT)
From: Andrii Melnychenko <a.melnychenko@vyos.io>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] nft_ct: Added nfct_seqadj_ext_add() for DNAT'ed conntrack.
Date: Fri, 24 Oct 2025 18:22:16 +0200
Message-ID: <20251024162216.963891-2-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024162216.963891-1-a.melnychenko@vyos.io>
References: <20251024162216.963891-1-a.melnychenko@vyos.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an issue with the missed seqadj extension for NAT'ed
conntrack setup with nft. Sequence adjustment may be required
for FTP traffic with PASV/EPSV modes.

The easiest way to reproduce this issue is with PASV mode.
Topoloy:
```
 +-------------------+     +----------------------------------+
 | FTP: 192.168.13.2 | <-> | NAT: 192.168.13.3, 192.168.100.1 |
 +-------------------+     +----------------------------------+
                                      |
                         +-----------------------+
                         | Client: 192.168.100.2 |
                         +-----------------------+
```

nft ruleset:
```
table inet ftp_nat {
        ct helper ftp_helper {
                type "ftp" protocol tcp
                l3proto inet
        }

        chain prerouting {
                type filter hook prerouting priority filter; policy
accept;
                tcp dport 21 ct state new ct helper set "ftp_helper"
        }
}
table ip nat {
        chain prerouting {
                type nat hook prerouting priority dstnat; policy accept;
                tcp dport 21 dnat ip prefix to ip daddr map {
192.168.100.1 : 192.168.13.2/32 }
        }

        chain postrouting {
                type nat hook postrouting priority srcnat; policy
accept;
                tcp sport 21 snat ip prefix to ip saddr map {
192.168.13.2 : 192.168.100.1/32 }
        }
}

```

Connecting the client:
```
Connected to 192.168.100.1.
220 Welcome to my FTP server.
Name (192.168.100.1:dev): user
331 Username ok, send password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> epsv
EPSV/EPRT on IPv4 off.
EPSV/EPRT on IPv6 off.
ftp> ls
227 Entering passive mode (192,168,100,1,209,129).
421 Service not available, remote server has closed connection.
```

Kernel logs:
```
Oct 16 10:24:44 vyos kernel: Missing nfct_seqadj_ext_add() setup call
Oct 16 10:24:44 vyos kernel: WARNING: CPU: 1 PID: 0 at
net/netfilter/nf_conntrack_seqadj.c:41 nf_ct_seqadj_set+0xbf/0xe0
[nf_conntrack]
Oct 16 10:24:44 vyos kernel: Modules linked in: nf_nat_ftp(E) nft_nat(E)
nf_conntrack_ftp(E) af_packet(E) nft_ct(E) nft_chain_nat(E) nf_nat(E)
nf_tables(E) nfnetlink_cthelper(E) nf_conntrack(E) nf_defrag_ipv6(E)
nf_defrag_ipv4(E) nfnetlink(E) binfmt_misc(E) intel_rapl_common(E)
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E)
sha512_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E)
crypto_simd(E) cryptd(E) rapl(E) iTCO_wdt(E) iTCO_vendor_support(E)
button(E) virtio_console(E) virtio_balloon(E) pcspkr(E) evdev(E)
tcp_bbr(E) sch_fq_codel(E) mpls_iptunnel(E) mpls_router(E) ip_tunnel(E)
br_netfilter(E) bridge(E) stp(E) llc(E) fuse(E) efi_pstore(E)
configfs(E) virtio_rng(E) rng_core(E) ip_tables(E) x_tables(E)
autofs4(E) usb_storage(E) ohci_hcd(E) uhci_hcd(E) ehci_hcd(E) sd_mod(E)
squashfs(E) lz4_decompress(E) loop(E) overlay(E) ext4(E) crc16(E)
mbcache(E) jbd2(E) nls_cp437(E) vfat(E) fat(E) efivarfs(E) nls_ascii(E)
hid_generic(E) usbhid(E) hid(E) virtio_net(E) net_failover(E)
virtio_blk(E) failover(E) ahci(E) libahci(E)
Oct 16 10:24:44 vyos kernel:  crc32c_intel(E) i2c_i801(E) i2c_smbus(E)
libata(E) lpc_ich(E) scsi_mod(E) scsi_common(E) xhci_pci(E) xhci_hcd(E)
virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E)
virtio(E) virtio_ring(E)
Oct 16 10:24:44 vyos kernel: CPU: 1 PID: 0 Comm: swapper/1 Tainted: G
E      6.6.108-vyos #1
Oct 16 10:24:44 vyos kernel: Hardware name: QEMU Standard PC (Q35 +
ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
Oct 16 10:24:44 vyos kernel: RIP: 0010:nf_ct_seqadj_set+0xbf/0xe0
[nf_conntrack]
Oct 16 10:24:44 vyos kernel: Code: ea 44 89 20 89 50 08 eb db 45 85 ed
74 de 80 3d 51 6d 00 00 00 75 d5 48 c7 c7 68 57 ad c0 c6 05 41 6d 00 00
01 e8 71 28 dd dc <0f> 0b eb be be 02 00 00 00 e8 63 fc ff ff 48 89 c3
e9 66 ff ff ff
Oct 16 10:24:44 vyos kernel: RSP: 0018:ffff9a66c00e8910 EFLAGS: 00010286
Oct 16 10:24:44 vyos kernel: RAX: 0000000000000000 RBX: 0000000000000014
RCX: 000000000000083f
Oct 16 10:24:44 vyos kernel: RDX: 0000000000000000 RSI: 00000000000000f6
RDI: 000000000000083f
Oct 16 10:24:44 vyos kernel: RBP: ffff89387978fb00 R08: 0000000000000000
R09: ffff9a66c00e87a8
Oct 16 10:24:44 vyos kernel: R10: 0000000000000003 R11: ffffffff9ecbab08
R12: ffff89387978fb00
Oct 16 10:24:44 vyos kernel: R13: 0000000000000001 R14: ffff893872e18862
R15: ffff893842f8c700
Oct 16 10:24:44 vyos kernel: FS:  0000000000000000(0000)
GS:ffff893bafc80000(0000) knlGS:0000000000000000
Oct 16 10:24:44 vyos kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 16 10:24:44 vyos kernel: CR2: 000055fbc64ec690 CR3: 000000011de22001
CR4: 0000000000370ee0
Oct 16 10:24:44 vyos kernel: Call Trace:
Oct 16 10:24:44 vyos kernel:  <IRQ>
Oct 16 10:24:44 vyos kernel:  __nf_nat_mangle_tcp_packet+0x100/0x160
[nf_nat]
Oct 16 10:24:44 vyos kernel:  nf_nat_ftp+0x142/0x280 [nf_nat_ftp]
Oct 16 10:24:44 vyos kernel:  ? kmem_cache_alloc+0x157/0x290
Oct 16 10:24:44 vyos kernel:  ? help+0x4d1/0x880 [nf_conntrack_ftp]
Oct 16 10:24:44 vyos kernel:  help+0x4d1/0x880 [nf_conntrack_ftp]
Oct 16 10:24:44 vyos kernel:  ? nf_confirm+0x122/0x2e0 [nf_conntrack]
Oct 16 10:24:44 vyos kernel:  nf_confirm+0x122/0x2e0 [nf_conntrack]
Oct 16 10:24:44 vyos kernel:  nf_hook_slow+0x3c/0xb0
Oct 16 10:24:44 vyos kernel:  ip_output+0xb6/0xf0
Oct 16 10:24:44 vyos kernel:  ? __pfx_ip_finish_output+0x10/0x10
Oct 16 10:24:44 vyos kernel:  ip_sublist_rcv_finish+0x90/0xa0
Oct 16 10:24:44 vyos kernel:  ip_sublist_rcv+0x190/0x220
Oct 16 10:24:44 vyos kernel:  ? __pfx_ip_rcv_finish+0x10/0x10
Oct 16 10:24:44 vyos kernel:  ip_list_rcv+0x134/0x160
Oct 16 10:24:44 vyos kernel:  __netif_receive_skb_list_core+0x299/0x2c0
Oct 16 10:24:44 vyos kernel:
netif_receive_skb_list_internal+0x1a7/0x2d0
Oct 16 10:24:44 vyos kernel:  napi_complete_done+0x69/0x1a0
Oct 16 10:24:44 vyos kernel:  virtnet_poll+0x3c0/0x540 [virtio_net]
Oct 16 10:24:44 vyos kernel:  __napi_poll+0x26/0x1a0
Oct 16 10:24:44 vyos kernel:  net_rx_action+0x141/0x2c0
Oct 16 10:24:44 vyos kernel:  ? lock_timer_base+0x5c/0x80
Oct 16 10:24:44 vyos kernel:  handle_softirqs+0xd5/0x280
Oct 16 10:24:44 vyos kernel:  __irq_exit_rcu+0x95/0xb0
Oct 16 10:24:44 vyos kernel:  common_interrupt+0x7a/0xa0
Oct 16 10:24:44 vyos kernel:  </IRQ>
Oct 16 10:24:44 vyos kernel:  <TASK>
Oct 16 10:24:44 vyos kernel:  asm_common_interrupt+0x22/0x40
Oct 16 10:24:44 vyos kernel: RIP: 0010:pv_native_safe_halt+0xb/0x10
Oct 16 10:24:44 vyos kernel: Code: 0b 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d
29 9a 3e 00 fb f4 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 8b
Oct 16 10:24:44 vyos kernel: RSP: 0018:ffff9a66c009bed8 EFLAGS: 00000252
Oct 16 10:24:44 vyos kernel: RAX: ffff893bafcaaca8 RBX: 0000000000000001
RCX: 0000000000000001
Oct 16 10:24:44 vyos kernel: RDX: 0000000000000000 RSI: 0000000000000083
RDI: 0000000000064cec
Oct 16 10:24:44 vyos kernel: RBP: ffff8938401f2200 R08: 0000000000000001
R09: 0000000000000000
Oct 16 10:24:44 vyos kernel: R10: 000000000001ffc0 R11: 0000000000000000
R12: 0000000000000000
Oct 16 10:24:44 vyos kernel: R13: 0000000000000000 R14: ffff8938401f2200
R15: 0000000000000000
Oct 16 10:24:44 vyos kernel:  default_idle+0x5/0x20
Oct 16 10:24:44 vyos kernel:  default_idle_call+0x28/0xb0
Oct 16 10:24:44 vyos kernel:  do_idle+0x1ec/0x230
Oct 16 10:24:44 vyos kernel:  cpu_startup_entry+0x21/0x30
Oct 16 10:24:44 vyos kernel:  start_secondary+0x11a/0x140
Oct 16 10:24:44 vyos kernel:  secondary_startup_64_no_verify+0x178/0x17b
Oct 16 10:24:44 vyos kernel:  </TASK>
```

Fixes: 1a64edf54f55 ("netfilter: nft_ct: add helper set support")
Signed-off-by: Andrii Melnychenko <a.melnychenko@vyos.io>
---
 net/netfilter/nft_ct.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index d526e69a2..f358cdc5e 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -22,6 +22,7 @@
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
+#include <net/netfilter/nf_conntrack_seqadj.h>
 
 struct nft_ct_helper_obj  {
 	struct nf_conntrack_helper *helper4;
@@ -1173,6 +1174,10 @@ static void nft_ct_helper_obj_eval(struct nft_object *obj,
 	if (help) {
 		rcu_assign_pointer(help->helper, to_assign);
 		set_bit(IPS_HELPER_BIT, &ct->status);
+
+		if ((ct->status & IPS_NAT_MASK) && !nfct_seqadj(ct))
+			if (!nfct_seqadj_ext_add(ct))
+				regs->verdict.code = NF_DROP;
 	}
 }
 
-- 
2.43.0


