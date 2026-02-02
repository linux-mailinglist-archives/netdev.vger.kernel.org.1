Return-Path: <netdev+bounces-255779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JpQECtggGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:28:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA9C9AFD
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C193007C92
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DD355807;
	Mon,  2 Feb 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PCE2ugDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0339355808
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020787; cv=none; b=ZXvd/7O9YBtDhEvM8vJtrULxhPLZeyWxS+8BhlR++KfvSL4D7HJiqnBFEcxBre4uOCZg4d/WI6Np0TFZ6k7gJ95IZCq0BnGy2porIo2tjeILfZT+qzHmb3iKAiYozLM/2O4eM/C3jHEP0ImjPeUn8rz3Id5Yr99GgeUd1hmB7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020787; c=relaxed/simple;
	bh=Xfe+LUjYPkIVPnjdezGMhleYeV+zBg+jzR6SxUPHLjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKu3FnzpmkHRU0uNj3dceZy/ahGconCCAbqzEneUm7vIlicM9PPKr1nA7yNkwNHyGgrInYeB3Sx5Vt2Ldt3GN8K+VC37SPx7LNwQSNzXhO1vEKmQL7smH0HSmqLvZ28dzxqJ3473oqtcNVlRbrOeKEBDQ3eUoMgsSd8FPlno0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PCE2ugDQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b87677a8abeso628861066b.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770020781; x=1770625581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/m2nZmu5HncF4943JHZWQhVJ3Ajven2N+nDxeVmCb8E=;
        b=PCE2ugDQAe6AqE19MNIrr48lvChCIE96FaxXokCnPC66Ue6ZnDsSjNx7htftgdjwfw
         ayIhTIy0qdtRXby7eacfFHohtIyOMWWhmBTYHTPt02nq6RB1gDnEqJRzmJhyDe7Wb5XK
         4WY8xmZU1O4lJ7CD2Qd9g7aZ0wQeQzXLARplrs3iakmcpRTRrV80azKz5e93EQVEiIgr
         q52bb0JR4EUfPZZ/5ij1gW+W1ioCDQ7NJ05nLDw6fLNefkde0yTjAf/iSqZeJEmpYJMm
         8j1YItrTDN0gJ5D4vRWLT2jvNnkQdtHxgnGXRVza3LQb54x3WXyf2t6cj66Jc3P+IXvt
         xwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770020781; x=1770625581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m2nZmu5HncF4943JHZWQhVJ3Ajven2N+nDxeVmCb8E=;
        b=pk4wX4no5cheGdYwVIhGjAvJm6X5/tD9HbI9XAN3BJdF1H7brVtibpw2moc82DJ4vF
         samCHtfoqjlT4GK6Dg7n1GcO8dfrR37Pm/qwVjceWHJo+sIS67giJOktvePfKyFCpz14
         X2+VZo6gj7iVdyVKRFiZiuUfc3FC02PedjUpi9ng4bKKDVM6KgzRYmXsjj++BVxAGCmD
         7Uu6ecqAWdZremuY1jktlJKL0N19P4/KeYynL54l51sj1n97+MtDcnUZ+4blzdLcKL8o
         fBCBXzbohyKAt0Jzftz6r7YhisJKo0eI8ydkVtFGp2k8wcwaM0f9GaY24H4N/7e2Ec0h
         pmjg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeuZQF47tfrwyTbGrQL3ohwMYwJLwk9y3yj3FvuvrlFpJPgbBDlsJvbGLqasQu9d7Trt3wkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBq4yDfSeIoT7lAbvwhAKMoYHMAnSMn4UAD++NS9rUAkSteUO
	lRAEjeykSLd0+OT7okv5IpwCQlxKZhMGNQOevnb4eW9RMsWbP9HlaT0akqSH5+EmC7J4/N+bnfS
	pmrf2TS9lGLA+hJYa3TnC11RpPGkQA4+sFlJvg2JWULMS0JbgRsQ=
X-Gm-Gg: AZuq6aLNbUr/Tw6We5LRvzuzFVFPHx7pkFFmhWYiJD/7W6Der+XFPp+/r7X958jNhET
	cSZHKqhWpwfG2xKJsNYdAPoXbtlHixlHBpvEJTbEcxp1RDf0N7Vxka40quMvmvRnJ+F2XgMO81U
	2FEAhqGPyNibvWwgfCzk+g/gGciDD0zUGEAUH8R002YyfqGfUOp7d3QZPvmHCzPW6/MFHoVYG12
	Nl0KY0t+oQHSqlwYGZ8JPS9ZhaOgqiUAztOoQVWwFr2rcfVzr9Kzx9DMj7YYoLSkXb1ZTYT6voH
	Lf+XQPTQQlJ59TjR6W26pMSH6Qkt1p3yQ5T7hXVQX3CVZYlVf1NgYqlZlKZkFVoZPJQPGdjHK1B
	c5djj65grjCEAwRNAWqIbC4Mmx1DQZQkolH6kZH0ugYWCVfcgr09LTKAld96l4TnGArMT0TkBcm
	3HT3yZj1/m3O9tqJcguQ+ztrmZNhRuDjGs891IjxLpPqW2isiWPw==
X-Received: by 2002:a17:907:e113:b0:b8e:14cc:917f with SMTP id a640c23a62f3a-b8e14ccaa2emr304754966b.27.1770020780514;
        Mon, 02 Feb 2026 00:26:20 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:97a0:6795:ea33:334a? ([2001:67c:2fbc:1:97a0:6795:ea33:334a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469e80fsm7015176a12.25.2026.02.02.00.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 00:26:19 -0800 (PST)
Message-ID: <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
Date: Mon, 2 Feb 2026 09:26:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
To: Salvatore Bonaccorso <carnil@debian.org>,
 Jon Penn <jpenn@bentonvillek12.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: 1126499@bugs.debian.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <176996279620.3109699.15382994681575380467@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-255779-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: 92FA9C9AFD
X-Rspamd-Action: no action

On 01/02/2026 17:23, Salvatore Bonaccorso wrote:
> Control: forwarded -1 https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan
> 
> Hi Antonio and all,
> 
> In Debian we got the following report from Jon Penn using ovpn,
> reported at https://bugs.debian.org/1126499

Hi all,

Thanks a lot for the report!
We have a fix for this issue in our pipe already - I'll forward it to 
net ASAP.

Best Regards,

> 
> On Tue, Jan 27, 2026 at 10:37:40AM -0600, Jon Penn wrote:
>> Package: src:linux
>> Version: 6.17.13-1
>> Severity: normal
>>
>> Dear Maintainer,
>>
>> This is an OpenVPN server serving primarially TCP clients (but also some UDP
>> clients). As I write this there are 1161 TCP clients and 74 UDP clients. It
>> is running debian testing in order to have ovpn-dco-offload functionality
>> for TCP connections. We observe that under hevy load (in terms of
>> connections count, not really under much load in terms of bandwidth) this
>> server will become locked up from time to time and the graphical console
>> will become completely non-responsive. When this happens we reset the VM and
>> things continue running normally. I attempted to monitor the system using
>> dmesg and notice that I am getting some interesting messages about "BUG:
>> kernel NULL pointer dereference" that mention the ovpn module, leading me to
>> believe that this is a kernel bug in that module. Unfortunatly this issue
>> only occours when the server has many connections, and that is only
>> happening because most of my users are working from home today due to
>> weather. This gives me a rather small window of reproducability but if there
>> is any additional information I can provide let me know.
>> -- Package-specific info:
>> ** Version:
>> Linux version 6.17.13+deb14-amd64 (debian-kernel@lists.debian.org)
>> (x86_64-linux-gnu-gcc-15 (Debian 15.2.0-12) 15.2.0, GNU ld (GNU Binutils for
>> Debian) 2.45.50.20251209) #1 SMP PREEMPT_DYNAMIC Debian 6.17.13-1
>> (2025-12-20)
>>
>> ** Command line:
>> BOOT_IMAGE=/boot/vmlinuz-6.17.13+deb14-amd64
>> root=UUID=f00f1200-b8d8-4432-bb0b-593a5ab9075a ro quiet
>>
>> ** Tainted: D (128)
>> * kernel died recently, i.e. there was an OOPS or BUG
>>
>> ** Kernel log:
>> [ 709.018150] tun1: deleting peer with id 719, reason 1
>> [ 709.056997] tun1: deleting peer with id 1055, reason 1
>> [ 711.054524] tun1: deleting peer with id 201, reason 2
>> [ 711.055070] BUG: kernel NULL pointer dereference, address:
>> 0000000000000020
>> [ 711.055096] #PF: supervisor write access in kernel mode
>> [ 711.055429] #PF: error_code(0x0002) - not-present page
>> [ 711.055656] PGD 0 P4D 0
>> [ 711.055824] Oops: Oops: 0002 [#1] SMP NOPTI
>> [ 711.055991] CPU: 12 UID: 0 PID: 527 Comm: kworker/12:2 Not tainted
>> 6.17.13+deb14-amd64 #1 PREEMPT(lazy) Debian 6.17.13-1
>> [ 711.056154] Hardware name: Red Hat KVM, BIOS
>> edk2-20221207gitfff6d81270b5-9.el9_2 12/07/2022
>> [ 711.056333] Workqueue: events ovpn_peer_keepalive_work [ovpn]
>> [ 711.056524] RIP: 0010:ovpn_tcp_socket_detach+0x61/0x80 [ovpn]
>> [ 711.056695] Code: 01 00 00 48 8b 83 b8 01 00 00 48 89 85 c0 02 00 00 48 8b
>> 83 c0 01 00 00 48 89 45 28 48 8b 85 20 01 00 00 48 8b 93 c8 01 00 00 <48> 89
>> 50 20 48 c7 85 98 02 00 00 00 00 00 00 5b 5d c3 cc cc cc cc
>> [ 711.056986] RSP: 0018:ffffd3988153fdb8 EFLAGS: 00010246
>> [ 711.057136] RAX: 0000000000000000 RBX: ffff8e65873a5400 RCX:
>> 0000000000000004
>> [ 711.057314] RDX: ffffffff92d6d660 RSI: 0000000000000068 RDI:
>> ffff8e65873a5568
>> [ 711.057475] RBP: ffff8e6590fb4280 R08: 0000000000000000 R09:
>> 0000000000000101
>> [ 711.057644] R10: 0000000000000000 R11: ffffffff93a080e0 R12:
>> 000000006978de32
>> [ 711.057794] R13: 0000000000000001 R14: ffff8e65839c1aa8 R15:
>> 0000000000000000
>> [ 711.057940] FS: 0000000000000000(0000) GS:ffff8e695b708000(0000)
>> knlGS:0000000000000000
>> [ 711.058087] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 711.058246] CR2: 0000000000000020 CR3: 000000010862d001 CR4:
>> 00000000007726f0
>> [ 711.058412] PKRU: 55555554
>> [ 711.058584] Call Trace:
>> [ 711.058739] <TASK>
>> [ 711.058892] ovpn_socket_release+0x165/0x1a0 [ovpn]
>> [ 711.059048] unlock_ovpn+0x48/0x80 [ovpn]
>> [ 711.059199] ovpn_peer_keepalive_work+0xf3/0x1b0 [ovpn]
>> [ 711.059360] ? __schedule+0x464/0xd20
>> [ 711.059557] process_one_work+0x18f/0x350
>> [ 711.059740] worker_thread+0x25a/0x3a0
>> [ 711.059889] ? __pfx_worker_thread+0x10/0x10
>> [ 711.060046] kthread+0xfc/0x240
>> [ 711.060203] ? __pfx_kthread+0x10/0x10
>> [ 711.060358] ? __pfx_kthread+0x10/0x10
>> [ 711.060559] ret_from_fork+0x194/0x1c0
>> [ 711.060801] ? __pfx_kthread+0x10/0x10
>> [ 711.061019] ret_from_fork_asm+0x1a/0x30
>> [ 711.061269] </TASK>
>> [ 711.061494] Modules linked in: intel_rapl_msr intel_rapl_common
>> intel_uncore_frequency_common isst_if_mbox_msr isst_if_common ovpn
>> ip6_udp_tunnel udp_tunnel skx_edac_common nfit libnvdimm kvm_intel kvm
>> binfmt_misc irqbypass ghash_clmulni_intel aesni_intel rapl nls_ascii
>> nls_cp437 vfat fat qxl drm_ttm_helper ttm drm_exec pcspkr drm_client_lib sg
>> drm_kms_helper button evdev joydev drm configfs efi_pstore nfnetlink
>> vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport
>> vsock vmw_vmci efivarfs qemu_fw_cfg autofs4 ext4 crc16 mbcache jbd2
>> crc32c_cryptoapi hid_generic usbhid hid sr_mod sd_mod cdrom ahci libahci
>> xhci_pci libata xhci_hcd iTCO_wdt intel_pmc_bxt iTCO_vendor_support watchdog
>> psmouse usbcore scsi_mod e1000 serio_raw i2c_i801 lpc_ich scsi_common
>> usb_common i2c_smbus
>> [ 711.062827] CR2: 0000000000000020
>> [ 711.063051] ---[ end trace 0000000000000000 ]---
>> [ 711.600092] RIP: 0010:ovpn_tcp_socket_detach+0x61/0x80 [ovpn]
>> [ 711.602044] Code: 01 00 00 48 8b 83 b8 01 00 00 48 89 85 c0 02 00 00 48 8b
>> 83 c0 01 00 00 48 89 45 28 48 8b 85 20 01 00 00 48 8b 93 c8 01 00 00 <48> 89
>> 50 20 48 c7 85 98 02 00 00 00 00 00 00 5b 5d c3 cc cc cc cc
>> [ 711.602680] RSP: 0018:ffffd3988153fdb8 EFLAGS: 00010246
>> [ 711.602951] RAX: 0000000000000000 RBX: ffff8e65873a5400 RCX:
>> 0000000000000004
>> [ 711.603218] RDX: ffffffff92d6d660 RSI: 0000000000000068 RDI:
>> ffff8e65873a5568
>> [ 711.603487] RBP: ffff8e6590fb4280 R08: 0000000000000000 R09:
>> 0000000000000101
>> [ 711.603739] R10: 0000000000000000 R11: ffffffff93a080e0 R12:
>> 000000006978de32
>> [ 711.603990] R13: 0000000000000001 R14: ffff8e65839c1aa8 R15:
>> 0000000000000000
>> [ 711.604231] FS: 0000000000000000(0000) GS:ffff8e695b708000(0000)
>> knlGS:0000000000000000
>> [ 711.604483] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 711.604723] CR2: 0000000000000020 CR3: 000000019ce2c006 CR4:
>> 00000000007726f0
>> [ 711.604958] PKRU: 55555554
>> [ 711.605202] note: kworker/12:2[527] exited with irqs disabled
>> [ 711.967459] tun1: deleting peer with id 201, reason 1
>> [ 718.617453] tun1: deleting peer with id 1057, reason 1
>> [ 719.779198] tun1: deleting peer with id 176, reason 1
>> [ 733.398723] tun1: deleting peer with id 1059, reason 1
>> [ 733.926421] tun1: deleting peer with id 154, reason 1
> 
> Is there anything Jon can do providing more information help
> indentifying the problem?
> 
> FWIW, I have not asked Jon yet to test mainline or 6.18.8-1 (but
> afaics there were no relevant changes since to drivers/net/ovpn/).
> John in Debian you should soon available 6.18.8-1 and please do test
> as well 6.19~rc6-1~exp1 from experimental (or 6.19~rc7-1~exp1 once it
> passes).
> 
> Regards,
> Salvatore

-- 
Antonio Quartulli
OpenVPN Inc.


