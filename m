Return-Path: <netdev+bounces-231275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8201BF6D66
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6271319A5B52
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1133892E;
	Tue, 21 Oct 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="g0KgIDaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD529338904
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053968; cv=none; b=DS+FpwWWeeER+E2IcEQ+tAODmq9osDCrraM8QZT9ze2yVtBISSoQCriG+qx0M8yW7K2B7oLGL6zWN9tC6l1VFvjaS8hm+tCQIr78fKgkcDfyKPpVyrexT6czYFsUMe2zHiIs0RTUxeuzKCx3zy/Q12JmjVByVShCtujRKF3gerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053968; c=relaxed/simple;
	bh=cNGh5J0AR2A/GqGO4tHahYfT476/GJWxYY4uqwgT6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+sTZRf2s+/nmU/7ooBW12SuUnT09dGIaNFm9lQG3ZKGxj+fYDOGAAPW/4DNtCxhvMawvK6pVNAWYRktETYEW2d05JjTDk6G6XfMuI3t0JCJhhQlU36VV7j/bWAsZkuRXrNZlXwq/iKFgmPv9g8BxqLc/mf/a1Td7/iJ8hG67OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=g0KgIDaT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e9d633b78so394997766b.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761053964; x=1761658764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7KCmcriZ6DcJoUuMS1DaMt8k8S5NC6HcwGo5EQqVbM=;
        b=g0KgIDaTNstTo88xF3rnFuFvG+P2fDg40+8+zktay4K6fC2x0V1zav6wCg1yLTM3ql
         TXT12acl2KLjXYxW2OZ/dlburrUhDfoPlxhFNX4pSsqWVjFmHgyqWFAf25EiCwOfZbPv
         upyUsku2Tv9YfLI4rxMpU4H/krjzvgJr5xTMDkB8M5qTs5jBgjvst/ENBmIWrziYZJyP
         xpjqTTtRE3SNQ9iYb2GaTWDv1UuCvPhOS7t0QDp0t+dzK+upSQ3pjzRviodFsFfXIKi1
         ECIrlgKFfPnTjqlUogerLK9Yx0oMUBe5LSsmBBcQsybDfCrOiMht3CIWubuAH5udABdB
         wORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053964; x=1761658764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7KCmcriZ6DcJoUuMS1DaMt8k8S5NC6HcwGo5EQqVbM=;
        b=CxeRz2VCZdzqeO9CLDKepUkF9bppvW4QnajdDWdNz07X6Jzuf4QeXKS3y+HwIbwrCf
         3QkwuN/75skP/nDZn4vyGDJFqbSrTWh83ZztyxOcWqd8uX3Hz5O1SFlppwQ5aytNcLMJ
         BKsUTBDIoLgU73kgMoMSd3YLCkOR9MhtB3MO9fLVwkWUaSvXkhNvxpWPVdwU31zr3zd4
         2dzPlv1B4WA6QXv4OIr18fsHapozIUu44bmeijYK9T4T3lrJRH7g5arh6AQG7xBrbOD3
         aRVnn0G/fimWwxD7woVKtPLuRdCMo6vTH+fClRUzSkn0q8fcHP3iC4tz7uQ9B5YvIhtC
         9WRw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7OPJioFI78RWCke57ugA8k+p0KC7fvpv6upKSYrwqNpa7qUicvtyd/FPG+poniPZTGKpVRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUsKlKvp9zjf61v6lI0gmpF2i3l2YgyamMBPCbqxC7gcWDjv/o
	BzbHslW+p4VlcThBtOKrR831/qiyqlweAemE88xkfD0v65umpFwnOJWDHlXxG6lFE3A=
X-Gm-Gg: ASbGncv+GBQrO1ICkOlwINUt4USDO806ng0DMIDtj+u7MSJWEoUUx/9PN3D38n5EffT
	+h4/rj6z27Ulgtplgx5CZfBnJDQ+8xLmRyZ4s7MxhXjjs2jdwIl/SqZs1U0G9CVfoeX6lHuCMNv
	peKNIo6yJDGJaqvJi3c33B/UCVIV47eaoT1GVGgdOQehUK4Mu0JvwJhELYnhCcBswpkHzT3IJPm
	uQoOD38UftEWSl9DVRqwQ8MzYNv60kpOwThulyftf+6FEmV/EFy0TTyZ4xY4/m3DxH4AqJioVeO
	2APU1xnmswJ3USBOqENy/yNEWQFJ+FDHPcyYn/6V7NLR4jOLzFeZn9e5bAHOhOCZMeWI00S7n5s
	6cQsHieyEeLSyl8KhOouAfDlxuveFxx9FhvS989utHZEJAuEwUp83g3LGus02DIZ/VD6y4G7lR+
	s7wBgLIN/Tdc28NjjRzkWgOrb24bawLlUWuFeDcQ==
X-Google-Smtp-Source: AGHT+IFxp301s7Af0Dmq9fBwxWd+PghLQFCXJTR5rYSaeMIfp0t1XquJV/jQsAIUhD3+84jJzvtYVg==
X-Received: by 2002:a17:907:c389:b0:b3d:a295:5445 with SMTP id a640c23a62f3a-b605249e5ccmr2359488466b.13.1761053963973;
        Tue, 21 Oct 2025 06:39:23 -0700 (PDT)
Received: from VyOS.. (213-225-7-96.nat.highway.a1.net. [213.225.7.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83958fbsm1089803666b.27.2025.10.21.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:39:23 -0700 (PDT)
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
Subject: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
Date: Tue, 21 Oct 2025 15:39:18 +0200
Message-ID: <20251021133918.500380-2-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021133918.500380-1-a.melnychenko@vyos.io>
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
                type filter hook prerouting priority filter; policy accept;
                tcp dport 21 ct state new ct helper set "ftp_helper"
        }
}
table ip nat {
        chain prerouting {
                type nat hook prerouting priority dstnat; policy accept;
                tcp dport 21 dnat ip prefix to ip daddr map { 192.168.100.1=
 : 192.168.13.2/32 }
        }

        chain postrouting {
                type nat hook postrouting priority srcnat; policy accept;
                tcp sport 21 snat ip prefix to ip saddr map { 192.168.13.2 =
: 192.168.100.1/32 }
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
Oct 16 10:24:44 vyos kernel: WARNING: CPU: 1 PID: 0 at net/netfilter/nf_con=
ntrack_seqadj.c:41 nf_ct_seqadj_set+0xbf/0xe0 [nf_conntrack]
Oct 16 10:24:44 vyos kernel: Modules linked in: nf_nat_ftp(E) nft_nat(E) nf=
_conntrack_ftp(E) af_packet(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_tabl=
es(E) nfnetlink_cthelper(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv=
4(E) nfnetlink(E) binfmt_misc(E) intel_rapl_common(E) crct10dif_pclmul(E) c=
rc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) sha1_=
ssse3(E) aesni_intel(E) crypto_simd(E) cryptd(E) rapl(E) iTCO_wdt(E) iTCO_v=
endor_support(E) button(E) virtio_console(E) virtio_balloon(E) pcspkr(E) ev=
dev(E) tcp_bbr(E) sch_fq_codel(E) mpls_iptunnel(E) mpls_router(E) ip_tunnel=
(E) br_netfilter(E) bridge(E) stp(E) llc(E) fuse(E) efi_pstore(E) configfs(=
E) virtio_rng(E) rng_core(E) ip_tables(E) x_tables(E) autofs4(E) usb_storag=
e(E) ohci_hcd(E) uhci_hcd(E) ehci_hcd(E) sd_mod(E) squashfs(E) lz4_decompre=
ss(E) loop(E) overlay(E) ext4(E) crc16(E) mbcache(E) jbd2(E) nls_cp437(E) v=
fat(E) fat(E) efivarfs(E) nls_ascii(E) hid_generic(E) usbhid(E) hid(E) virt=
io_net(E) net_failover(E) virtio_blk(E) failover(E) ahci(E) libahci(E)
Oct 16 10:24:44 vyos kernel:  crc32c_intel(E) i2c_i801(E) i2c_smbus(E) liba=
ta(E) lpc_ich(E) scsi_mod(E) scsi_common(E) xhci_pci(E) xhci_hcd(E) virtio_=
pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E) virtio(E) virtio_r=
ing(E)
Oct 16 10:24:44 vyos kernel: CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      =
      E      6.6.108-vyos #1
Oct 16 10:24:44 vyos kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2=
009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
Oct 16 10:24:44 vyos kernel: RIP: 0010:nf_ct_seqadj_set+0xbf/0xe0 [nf_connt=
rack]
Oct 16 10:24:44 vyos kernel: Code: ea 44 89 20 89 50 08 eb db 45 85 ed 74 d=
e 80 3d 51 6d 00 00 00 75 d5 48 c7 c7 68 57 ad c0 c6 05 41 6d 00 00 01 e8 7=
1 28 dd dc <0f> 0b eb be be 02 00 00 00 e8 63 fc ff ff 48 89 c3 e9 66 ff ff=
 ff
Oct 16 10:24:44 vyos kernel: RSP: 0018:ffff9a66c00e8910 EFLAGS: 00010286
Oct 16 10:24:44 vyos kernel: RAX: 0000000000000000 RBX: 0000000000000014 RC=
X: 000000000000083f
Oct 16 10:24:44 vyos kernel: RDX: 0000000000000000 RSI: 00000000000000f6 RD=
I: 000000000000083f
Oct 16 10:24:44 vyos kernel: RBP: ffff89387978fb00 R08: 0000000000000000 R0=
9: ffff9a66c00e87a8
Oct 16 10:24:44 vyos kernel: R10: 0000000000000003 R11: ffffffff9ecbab08 R1=
2: ffff89387978fb00
Oct 16 10:24:44 vyos kernel: R13: 0000000000000001 R14: ffff893872e18862 R1=
5: ffff893842f8c700
Oct 16 10:24:44 vyos kernel: FS:  0000000000000000(0000) GS:ffff893bafc8000=
0(0000) knlGS:0000000000000000
Oct 16 10:24:44 vyos kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
Oct 16 10:24:44 vyos kernel: CR2: 000055fbc64ec690 CR3: 000000011de22001 CR=
4: 0000000000370ee0
Oct 16 10:24:44 vyos kernel: Call Trace:
Oct 16 10:24:44 vyos kernel:  <IRQ>
Oct 16 10:24:44 vyos kernel:  __nf_nat_mangle_tcp_packet+0x100/0x160 [nf_na=
t]
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
Oct 16 10:24:44 vyos kernel:  netif_receive_skb_list_internal+0x1a7/0x2d0
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
Oct 16 10:24:44 vyos kernel: Code: 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1=
f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d 29 9a 3=
e 00 fb f4 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 8b
Oct 16 10:24:44 vyos kernel: RSP: 0018:ffff9a66c009bed8 EFLAGS: 00000252
Oct 16 10:24:44 vyos kernel: RAX: ffff893bafcaaca8 RBX: 0000000000000001 RC=
X: 0000000000000001
Oct 16 10:24:44 vyos kernel: RDX: 0000000000000000 RSI: 0000000000000083 RD=
I: 0000000000064cec
Oct 16 10:24:44 vyos kernel: RBP: ffff8938401f2200 R08: 0000000000000001 R0=
9: 0000000000000000
Oct 16 10:24:44 vyos kernel: R10: 000000000001ffc0 R11: 0000000000000000 R1=
2: 0000000000000000
Oct 16 10:24:44 vyos kernel: R13: 0000000000000000 R14: ffff8938401f2200 R1=
5: 0000000000000000
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
 net/netfilter/nft_ct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index d526e69a2..73d0590fb 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -22,6 +22,7 @@
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_expect.h>
+#include <net/netfilter/nf_conntrack_seqadj.h>
=20
 struct nft_ct_helper_obj  {
 	struct nf_conntrack_helper *helper4;
@@ -1173,6 +1174,9 @@ static void nft_ct_helper_obj_eval(struct nft_object =
*obj,
 	if (help) {
 		rcu_assign_pointer(help->helper, to_assign);
 		set_bit(IPS_HELPER_BIT, &ct->status);
+
+		if ((ct->status & IPS_NAT_MASK) && !nfct_seqadj(ct))
+			nfct_seqadj_ext_add(ct);
 	}
 }
=20
--=20
2.43.0


