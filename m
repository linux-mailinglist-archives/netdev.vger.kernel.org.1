Return-Path: <netdev+bounces-169455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA89A44031
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BEB18895A8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2F268FE9;
	Tue, 25 Feb 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6+ANynd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1023268C67
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488907; cv=none; b=ohCMvvXXTYCVtXCwbClPsVjPPuKA7ZgDAi4t595h/7LH4EVxMXppH+mu7P4P/xKJByaX0qubO4Ofkm01pi2DWImonpfIp07/neFkWTShh5oi9ukpO54/lPfRvnSlFmqTxlTF9Ynhl9Ip/E9ip5OPITpDiN+3F3ROLDy+yIzo4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488907; c=relaxed/simple;
	bh=YB1Vi94DwJBnT1kqmD7cGOwF9WF5WEa+EnaB81x43PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msMPFFJz/EFILkTk6xG3zs2MUv2lyy9Nn1r/uDX45M1oiaTEWNoRfjH6YH4/yIZUifbaQQrdJj7qXQbLSVtTHMbEG8iX4Po+DLhhHaUzhS5l5qvzbeG2b6wB4Kj6ceu9mve0W730lewhGiu307VNQgJ1Ja4vaZe2qUz9P05UVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6+ANynd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740488904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYCi8do/r4b+3U8lJEE+th0QSCLaiScWXLVoHM5qNso=;
	b=Z6+ANyndJiR5PYhFe9K+Vw4MU0Zc27mIf/79h+vUyy+3rr9/CHiCUFRcf5BuiNEsPGdUQj
	JQ+7PP9HBJzaz6V89ImqwsqiaUjhx3K1XbxRGs76b5TcWEHqy8JEKpTjlvYgW9ZuoYOAWd
	Xth/QESdZrHb9sBeoAXZl6F84Q/GQLI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-PimtWksAN92qPB7jSnB0Xg-1; Tue, 25 Feb 2025 08:08:23 -0500
X-MC-Unique: PimtWksAN92qPB7jSnB0Xg-1
X-Mimecast-MFC-AGG-ID: PimtWksAN92qPB7jSnB0Xg_1740488902
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso3144871f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 05:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488902; x=1741093702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYCi8do/r4b+3U8lJEE+th0QSCLaiScWXLVoHM5qNso=;
        b=jfBJPqBPf/b2kOLvnPJhkkMF4jZX931zqS1typzseA1HJ2sBLOLLlruG+ZrWDBM/gk
         6jiCyNrXV/vS+fQ6vy3Fv7aKA3TZiJNCI5teYKfivuLoPvaR2aZEdfAiSn/U3n0jduk+
         pDiYD94afbH6RljX4SJxdNIzZ3YyoVMaG6pTvcZ7Kszpzzgq0YcKZ3ji1u14GPLdzK2J
         rmG+G7aOSWxzHd2nshSsgYqp1VdLkUTSXbm3POr8xHBvIRDvnb+8T0Is/WrXmsPHKXLM
         tBstLFPXEelyqZhDSMwTMOZQ5ojDQ2wjymosFMb/JF7k3Omyc2bfWHF0kkYm+ei6XF4B
         Ct4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCk99SsBs8HhIJPnoFhy0fi+WcG+mIAxg2pt52V2aXsLJcseT1ND6ahklVWGQStVO1eowBPdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAzHtxvLyI3NDZDJQ3QrdsDSCGNXdMu2MLrqiGC2cSO4EylPC
	+shzXs1e+LK1bDik3L84TbEuDJK2kYePBZ3OSWPv/fSpakW1pLtbQ5Qjfm3u+qHCpqzJivaBWdu
	HL8vuQ42m2zpM3DLjkCrjX4vbMW2ORgflfXnzP5XwdMfOH+pB0rLTUA==
X-Gm-Gg: ASbGnctKZTLsV/b9wylJ7gNj7oK3hcD+3h8zO4/1qJjx+Op4vw89cvE4fbqryhdekLh
	Zxe20E8fDe96XUFaYUSffhj8eleCwrUYfOq5ndPv+voOZixxPiAp9H/TXwnqKxaXsLM0G+9haoq
	vfoBjMMDtPgGmPTXecK7CCkXy4hRLzxV/s3937yIJkSmvXhEzJ4AZp4hpPxRHY8n9okDne9gMDd
	F39i/0UoVrYk0/DVLBceOLrmMOaIqyRKWuKz9loVrlJf0VwD3mRx6XP3AHj19yZ3ORn3iqI5EEB
	38GM/C5zItt+DGxp7aE0XTBcvLQDhCF7OuGtVGAV0IU=
X-Received: by 2002:adf:890a:0:b0:38f:232e:dd5e with SMTP id ffacd0b85a97d-38f616331ccmr13074263f8f.22.1740488902293;
        Tue, 25 Feb 2025 05:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCWYJYXZWx2SXKxmO9SJQ8q5BJdPD/+84uCyQ4nFYhqg3XY9FbPHsmFwSlBu4NUyZbkzcpCw==
X-Received: by 2002:adf:890a:0:b0:38f:232e:dd5e with SMTP id ffacd0b85a97d-38f616331ccmr13074218f8f.22.1740488901830;
        Tue, 25 Feb 2025 05:08:21 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e725dsm2304082f8f.63.2025.02.25.05.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:08:21 -0800 (PST)
Message-ID: <3fe0dd96-0aaa-47a4-8b77-be737bde8e44@redhat.com>
Date: Tue, 25 Feb 2025 14:08:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/9] net: devmem: make dmabuf unbinding
 scheduled work
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-5-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250222191517.743530-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 8:15 PM, Mina Almasry wrote:
> The TX path may release the dmabuf in a context where we cannot wait.
> This happens when the user unbinds a TX dmabuf while there are still
> references to its netmems in the TX path. In that case, the netmems will
> be put_netmem'd from a context where we can't unmap the dmabuf,
> resulting in a BUG like seen by Stan:
> 
> [    1.548495] BUG: sleeping function called from invalid context at drivers/dma-buf/dma-buf.c:1255
> [    1.548741] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 149, name: ncdevmem
> [    1.548926] preempt_count: 201, expected: 0
> [    1.549026] RCU nest depth: 0, expected: 0
> [    1.549197]
> [    1.549237] =============================
> [    1.549331] [ BUG: Invalid wait context ]
> [    1.549425] 6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15 Tainted: G        W
> [    1.549609] -----------------------------
> [    1.549704] ncdevmem/149 is trying to lock:
> [    1.549801] ffff8880066701c0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.550051] other info that might help us debug this:
> [    1.550167] context-{5:5}
> [    1.550229] 3 locks held by ncdevmem/149:
> [    1.550322]  #0: ffff888005730208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x40/0xf0
> [    1.550530]  #1: ffff88800b148f98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x19/0x80
> [    1.550731]  #2: ffff88800b148f18 (slock-AF_INET6){+.-.}-{3:3}, at: __tcp_close+0x185/0x4b0
> [    1.550921] stack backtrace:
> [    1.550990] CPU: 0 UID: 0 PID: 149 Comm: ncdevmem Tainted: G        W          6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15
> [    1.551233] Tainted: [W]=WARN
> [    1.551304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [    1.551518] Call Trace:
> [    1.551584]  <TASK>
> [    1.551636]  dump_stack_lvl+0x86/0xc0
> [    1.551723]  __lock_acquire+0xb0f/0xc30
> [    1.551814]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.551941]  lock_acquire+0xf1/0x2a0
> [    1.552026]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552152]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552281]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552408]  __ww_mutex_lock+0x121/0x1060
> [    1.552503]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552648]  ww_mutex_lock+0x3d/0xa0
> [    1.552733]  dma_buf_unmap_attachment_unlocked+0x4b/0x90
> [    1.552857]  __net_devmem_dmabuf_binding_free+0x56/0xb0
> [    1.552979]  skb_release_data+0x120/0x1f0
> [    1.553074]  __kfree_skb+0x29/0xa0
> [    1.553156]  tcp_write_queue_purge+0x41/0x310
> [    1.553259]  tcp_v4_destroy_sock+0x127/0x320
> [    1.553363]  ? __tcp_close+0x169/0x4b0
> [    1.553452]  inet_csk_destroy_sock+0x53/0x130
> [    1.553560]  __tcp_close+0x421/0x4b0
> [    1.553646]  tcp_close+0x24/0x80
> [    1.553724]  inet_release+0x5d/0x90
> [    1.553806]  sock_close+0x4a/0xf0
> [    1.553886]  __fput+0x9c/0x2b0
> [    1.553960]  task_work_run+0x89/0xc0
> [    1.554046]  do_exit+0x27f/0x980
> [    1.554125]  do_group_exit+0xa4/0xb0
> [    1.554211]  __x64_sys_exit_group+0x17/0x20
> [    1.554309]  x64_sys_call+0x21a0/0x21a0
> [    1.554400]  do_syscall_64+0xec/0x1d0
> [    1.554487]  ? exc_page_fault+0x8a/0xf0
> [    1.554585]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    1.554703] RIP: 0033:0x7f2f8a27abcd
> 
> Resolve this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> 
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm sorry, I should have noted this in the previous revisions. I think
this should be squashed in the previous patch: it will not make it
significantly bigger, and could avoid weird problems on bisections.

Thanks!

Paolo


