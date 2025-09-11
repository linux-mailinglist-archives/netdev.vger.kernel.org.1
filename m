Return-Path: <netdev+bounces-222121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF2B53320
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC40F5A50F2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8C322C60;
	Thu, 11 Sep 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="UTKSjegQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C12322552
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595830; cv=none; b=XRL227Wyyi4uL4wfZ+gFrDDNqX3ZRZZtPjjgGs9H6R7+hkfw6pNy6zFIiIiNsqLB9YouBLzaHNkHTOOx5xmRehCpL30MlC99ChI+D7T1Rx4inqOsEVKNhFewDPkOf1lu5SXDA9MYz0caYBjRUOeRi1vR57WhFVJXXHDC3TNOEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595830; c=relaxed/simple;
	bh=xRAyibW8qzvwnH8Gm9PwnzMIvD+jYZm8L1xYG6/xjSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NN6urVwgeXcPubie5RQ53Ku+OnIEOv/QwD43/xZvQDl7mgGXnnB4iMUC6+8NXHTlcyf7/gW2iBObSvfH75rdjx3bPPP0qR5gDdWMkC4dmLEcmAy6iMpnPI66eVBhMvQEHYAxQOzDsiQTKmxbd7AxnWHkC5XXvknd31XHZ69Eaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=UTKSjegQ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8900fcc0330so1208434241.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757595827; x=1758200627; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJK4ueqAnpuumIv7fELvfq3MBjaCw4SpNKiHVQflEO8=;
        b=UTKSjegQPyUv0CudC7R112VH6HIRHYFSFasRQWPVt3wrZ8uNUO9DpRfHvhI9kb7NT/
         w2irIQe7f5uxC1DxD8hHYPdeZ8GzrT7a/tllJBiTtlc+RMUSYbtvw8beVlE8/EKL2rqZ
         IOuV4fncucuE3c5te0awKmAK3VaCIWAryNd3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595827; x=1758200627;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJK4ueqAnpuumIv7fELvfq3MBjaCw4SpNKiHVQflEO8=;
        b=t6XmT4nrvSLpzQXDa0YxFZ4/UwCEFsjV4j+3ToTIPWOlTLaVMHqGgewLyJbGDmOWsW
         Y/JaGzvwCHSdL7AgKKbK35SbZU8/+yPHownqzeLWkvdO+zjm+yxBeRNgv5j+ueaqaXq4
         uJGAdZIzLj8OH5Nl36td+A+2SK4ByAQptmc6T2khPwlPPTUKtGu7Kh1/yD8OqlzEaVfu
         HfBVmVdcsE/lTUOqx0a2NQXV2Ux6MK2qf+ulEsPeYzT7AQAiNVe3yD/Em7YneNzkAoCn
         PnmbFtTEo/whgZUvPn1EvYZG/hCrhPRs+N5fJuNeQ56gXh/NaM5Y+kjQ7kowUtIi5g6i
         F3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXks/vP/KEKABgdaoN0YZRtLGUDymvQZZLTm7x04im7Pr6djUdsmCny/j1US4Z5vOZvw08a7m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkBnovb2psYErdpcDA+I45FLhNsnN5Z+/JoB9Oe/w7FSuU8Gt
	qzK7Z4ryqoLo2tpBmzhcvWSqOAKCgJo0LVtIS0DioKDo7M2PJBMoEX51qb+VNr6FDmMeIqpfwHw
	bv+1wY+0Mq0T8j+vMzAchR08RN1S4meaB63vy6Oiatg==
X-Gm-Gg: ASbGncuqqoPsXLEAVtTBTfNtNtMoeO4KskF1sLTIjxM90rciCH/VrtjISNCR2x5aSM+
	4XxzsIUkpi+sFpO9QtCz7Fpeknk+KVHVh93fTqtUucfZsDMYlwXdmiSNhPybuxdxnP+BQz/JLLF
	iOIU5oM4dd33O5o2q0ALWidZQsJgmSs0tYQ8f8ZYOEEa9fjC8CXkZL0/Dydo/fCaBmnajNxDFrL
	H7DVnDV
X-Google-Smtp-Source: AGHT+IHm6TLPyMOSwdEoC9V0exD7xk4BMyzVQibe34RQ9iTRtWhAMR0gBzYRqvGQO6LZ3RXZOarUqAzqMmrV2scGBV8=
X-Received: by 2002:a05:6122:e011:20b0:539:237c:f95d with SMTP id
 71dfb90a1353d-54a095db50amr1114271e0c.0.1757595827133; Thu, 11 Sep 2025
 06:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034337.43331-2-anderson@allelesecurity.com>
In-Reply-To: <20250911034337.43331-2-anderson@allelesecurity.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 11 Sep 2025 10:03:36 -0300
X-Gm-Features: Ac12FXwZbSZg4XfFCKv3GJg_gljTpIGYjvY2rFtZ_69LfmMTj943Y75OS0hPEdE
Message-ID: <CAPhRvkxWPC1F6XOJMNJeDufz0mELLLCSKhw0vqjrAT5bHQxWAA@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR.
To: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:48=E2=80=AFAM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a
> connect() system call on a socket with a TCP-AO key added and TCP_REPAIR
> enabled.
>
> The function is called with skb being NULL and attempts to dereference it
> on tcp_hdr(skb)->seq without a prior skb validation.
>
> Fix this by checking if skb is NULL before dereferencing it. If skb is
> not NULL, the ao->risn is set to tcp_hdr(skb)->seq. If skb is NULL,
> ao->risn is set to 0 to keep compatibility with calls made from
> tcp_rcv_synsent_state_process().

The description here should be:

If skb is not NULL, the ao->risn is set to tcp_hdr(skb)->seq to keep
compatibility with the call made from tcp_rcv_synsent_state_process().
If skb is NULL, ao->risn is set to 0.

>
> int main(void){
>         struct sockaddr_in sockaddr;
>         struct tcp_ao_add tcp_ao;
>         int sk;
>         int one =3D 1;
>
>         memset(&sockaddr,'\0',sizeof(sockaddr));
>         memset(&tcp_ao,'\0',sizeof(tcp_ao));
>
>         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>
>         sockaddr.sin_family =3D AF_INET;
>
>         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
>         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
>         tcp_ao.keylen =3D 16;
>
>         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
>
>         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
>         sizeof(tcp_ao));
>         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
>
>         sockaddr.sin_family =3D AF_INET;
>         sockaddr.sin_port =3D htobe16(123);
>
>         inet_aton("127.0.0.1", &sockaddr.sin_addr);
>
>         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
>
> return 0;
> }
>
> $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> $ unshare -Urn
> # ip addr add 127.0.0.1 dev lo
> # ./tcp-ao-nullptr
>
> BUG: kernel NULL pointer dereference, address: 00000000000000b6
> PGD 1f648d067 P4D 1f648d067 PUD 1982e8067 PMD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
> Reference Platform, BIOS 6.00 11/12/2020
> RIP: 0010:tcp_ao_finish_connect (net/ipv4/tcp_ao.c:1182)
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1=
f
>  44 00 00 41 54 55 53 48 8b af 00 09 00 00 48 85 ed 74 3e <0f> b7 86 b6 0=
0
>  00 00 48 8b 96 c8 00 00 00 49 89 fc 8b 44 02 04 c7
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   90                      nop
>    9:   90                      nop
>    a:   90                      nop
>    b:   90                      nop
>    c:   90                      nop
>    d:   90                      nop
>    e:   90                      nop
>    f:   90                      nop
>   10:   90                      nop
>   11:   66 0f 1f 00             nopw   (%rax)
>   15:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   1a:   41 54                   push   %r12
>   1c:   55                      push   %rbp
>   1d:   53                      push   %rbx
>   1e:   48 8b af 00 09 00 00    mov    0x900(%rdi),%rbp
>   25:   48 85 ed                test   %rbp,%rbp
>   28:   74 3e                   je     0x68
>   2a:*  0f b7 86 b6 00 00 00    movzwl 0xb6(%rsi),%eax
> <-- trapping instruction
>   31:   48 8b 96 c8 00 00 00    mov    0xc8(%rsi),%rdx
>   38:   49 89 fc                mov    %rdi,%r12
>   3b:   8b 44 02 04             mov    0x4(%rdx,%rax,1),%eax
>   3f:   c7                      .byte 0xc7
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f b7 86 b6 00 00 00    movzwl 0xb6(%rsi),%eax
>    7:   48 8b 96 c8 00 00 00    mov    0xc8(%rsi),%rdx
>    e:   49 89 fc                mov    %rdi,%r12
>   11:   8b 44 02 04             mov    0x4(%rdx,%rax,1),%eax
>   15:   c7                      .byte 0xc7
> RSP: 0018:ffffcf7a858f3a50 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8e51e8150000 RCX: 0000000000000002
> RDX: ffffcf7a858f3a1f RSI: 0000000000000000 RDI: ffff8e51e8150000
> RBP: ffff8e51c1509e80 R08: ffff8e51e81506bc R09: 0000000000000001
> R10: 0000000000000000 R11: ffff8e51e8150000 R12: 0000000000000000
> R13: ffff8e51c7019680 R14: ffff8e51d20d1cc0 R15: ffff8e51e8150000
> FS:  00007faa5e4dc740(0000) GS:ffff8e533e55f000(0000) knlGS:0000000000000=
0
> 00
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000b6 CR3: 000000016d3e0003 CR4: 00000000003706f0
> Call Trace:
> <TASK>
> tcp_finish_connect (net/ipv4/tcp_input.c:6267)
> tcp_connect (net/ipv4/tcp_output.c:4141)
> tcp_v4_connect (net/ipv4/tcp_ipv4.c:345 (discriminator 1))
> __inet_stream_connect (net/ipv4/af_inet.c:677)
> ? release_sock (./include/linux/list.h:373 (discriminator 2) ./include/
> linux/wait.h:127 (discriminator 2) net/core/sock.c:3733 (discriminator 2)=
)
>  inet_stream_connect (net/ipv4/af_inet.c:749)
> __sys_connect (./include/linux/file.h:62 (discriminator 1) ./include/linu=
x
> /file.h:83 (discriminator 1) net/socket.c:2095 (discriminator 1))
> __x64_sys_connect (net/socket.c:2111 (discriminator 1) net/socket.c:2108
> (discriminator 1) net/socket.c:2108 (discriminator 1))
> do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/
> entry/syscall_64.c:94 (discriminator 1))
> ? do_read_fault (mm/memory.c:5565)
> ? handle_pte_fault (mm/memory.c:6047)
> ? do_fault (mm/memory.c:5707)
> ? __handle_mm_fault (mm/memory.c:5963 mm/memory.c:6131)
> ? count_memcg_events (mm/memcontrol.c:839 (discriminator 4))
> ? handle_mm_fault (mm/memory.c:6237 mm/memory.c:6390)
> ? do_user_addr_fault (arch/x86/mm/fault.c:1337)
> ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
> ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
> ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7faa5e54d77e
> Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 8=
3
>  f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 3=
9
>  83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   4d 89 d8                mov    %r11,%r8
>    3:   e8 d4 bc 00 00          call   0xbcdc
>    8:   4c 8b 5d f8             mov    -0x8(%rbp),%r11
>    c:   41 8b 93 08 03 00 00    mov    0x308(%r11),%edx
>   13:   59                      pop    %rcx
>   14:   5e                      pop    %rsi
>   15:   48 83 f8 fc             cmp    $0xfffffffffffffffc,%rax
>   19:   74 11                   je     0x2c
>   1b:   c9                      leave
>   1c:   c3                      ret
>   1d:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
>   24:   48 8b 45 10             mov    0x10(%rbp),%rax
>   28:   0f 05                   syscall
>   2a:*  c9                      leave           <-- trapping instruction
>   2b:   c3                      ret
>   2c:   83 e2 39                and    $0x39,%edx
>   2f:   83 fa 08                cmp    $0x8,%edx
>   32:   75 e7                   jne    0x1b
>   34:   e8 13 ff ff ff          call   0xffffffffffffff4c
>   39:   0f 1f 00                nopl   (%rax)
>   3c:   f3 0f 1e fa             endbr64
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c9                      leave
>    1:   c3                      ret
>    2:   83 e2 39                and    $0x39,%edx
>    5:   83 fa 08                cmp    $0x8,%edx
>    8:   75 e7                   jne    0xfffffffffffffff1
>    a:   e8 13 ff ff ff          call   0xffffffffffffff22
>    f:   0f 1f 00                nopl   (%rax)
>   12:   f3 0f 1e fa             endbr64
> RSP: 002b:00007ffc0e35e350 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faa5e54d77e
> RDX: 0000000000000010 RSI: 00007ffc0e35e4e0 RDI: 0000000000000003
> RBP: 00007ffc0e35e360 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc0e35e628
> R13: 0000000000000001 R14: 00007faa5e717000 R15: 0000000000402e00
> </TASK>
> Modules linked in: rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
> qrtr intel_rapl_msr intel_rapl_common intel_uncore_frequency_common
> intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry
> intel_vsec rapl vmw_balloon pktcdvd i2c_piix4 i2c_smbus joydev loop
> nfnetlink vsock_loopback vmw_vsock_virtio_transport_common
> vmw_vsock_vmci_transport vsock zram vmw_vmci lz4hc_compress lz4_compress
> xfs polyval_clmulni ghash_clmulni_intel sha512_ssse3 sha1_ssse3 vmwgfx
> drm_ttm_helper vmxnet3 nvme nvme_tcp ata_generic ttm nvme_fabrics
> pata_acpi nvme_core nvme_keyring nvme_auth serio_raw sunrpc be2iscsi bnx2=
i
>  cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx
> iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse i2c_dev dm_multipath
> CR2: 00000000000000b6
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:tcp_ao_finish_connect (net/ipv4/tcp_ao.c:1182)
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1=
f
>  44 00 00 41 54 55 53 48 8b af 00 09 00 00 48 85 ed 74 3e <0f> b7 86 b6 0=
0
>  00 00 48 8b 96 c8 00 00 00 49 89 fc 8b 44 02 04 c7
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   90                      nop
>    9:   90                      nop
>    a:   90                      nop
>    b:   90                      nop
>    c:   90                      nop
>    d:   90                      nop
>    e:   90                      nop
>    f:   90                      nop
>   10:   90                      nop
>   11:   66 0f 1f 00             nopw   (%rax)
>   15:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   1a:   41 54                   push   %r12
>   1c:   55                      push   %rbp
>   1d:   53                      push   %rbx
>   1e:   48 8b af 00 09 00 00    mov    0x900(%rdi),%rbp
>   25:   48 85 ed                test   %rbp,%rbp
>   28:   74 3e                   je     0x68
>   2a:*  0f b7 86 b6 00 00 00    movzwl 0xb6(%rsi),%eax
> <-- trapping instruction
>   31:   48 8b 96 c8 00 00 00    mov    0xc8(%rsi),%rdx
>   38:   49 89 fc                mov    %rdi,%r12
>   3b:   8b 44 02 04             mov    0x4(%rdx,%rax,1),%eax
>   3f:   c7                      .byte 0xc7
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f b7 86 b6 00 00 00    movzwl 0xb6(%rsi),%eax
>    7:   48 8b 96 c8 00 00 00    mov    0xc8(%rsi),%rdx
>    e:   49 89 fc                mov    %rdi,%r12
>   11:   8b 44 02 04             mov    0x4(%rdx,%rax,1),%eax
>   15:   c7                      .byte 0xc7
> RSP: 0018:ffffcf7a858f3a50 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8e51e8150000 RCX: 0000000000000002
> RDX: ffffcf7a858f3a1f RSI: 0000000000000000 RDI: ffff8e51e8150000
> RBP: ffff8e51c1509e80 R08: ffff8e51e81506bc R09: 0000000000000001
> R10: 0000000000000000 R11: ffff8e51e8150000 R12: 0000000000000000
> R13: ffff8e51c7019680 R14: ffff8e51d20d1cc0 R15: ffff8e51e8150000
> FS:  00007faa5e4dc740(0000) GS:ffff8e533e55f000(0000) knlGS:0000000000000
> 000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000b6 CR3: 000000016d3e0003 CR4: 00000000003706f0
> note: tcp-ao-nullptr[41065] exited with irqs disabled
>
> Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---
> Changes in v2:
> - Wrap the description at 75 columns
> - Add full decoded stack trace
> - Link to v1: https://lore.kernel.org/all/20250911013052.2233-1-anderson@=
allelesecurity.com/
>
>  net/ipv4/tcp_ao.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..abe913de8652 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1178,7 +1178,11 @@ void tcp_ao_finish_connect(struct sock *sk, struct=
 sk_buff *skb)
>         if (!ao)
>                 return;
>
> -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
> +       if (skb)
> +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       else
> +               WRITE_ONCE(ao->risn, 0);
>         ao->rcv_sne =3D 0;
>
>         hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_he=
ld(sk))
> --
> 2.51.0
>


--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

