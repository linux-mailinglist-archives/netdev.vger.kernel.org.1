Return-Path: <netdev+bounces-119529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2F956144
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7452280E81
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CF4594A;
	Mon, 19 Aug 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPewqdIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144A27452
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036111; cv=none; b=ba/LU8Sq843HwmQkGWa9fW4abYW62Rik27mN0EIz3N+WsfnFzFeCTZByoBMI1ii6JonI/XteQaTjPAV1IZokquo1MKhKrPu60l/Od8rbVnIMqtv3a+Uxk86ygEDI9WrurOueNJuQfEhtslcuKIo8a/JMy2U4K6IR9vi6JsSXHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036111; c=relaxed/simple;
	bh=rV2Z2HZ9Sx35HdCWWVt3Dz0WdbNSjao/ufzE82aBb7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccel4TQHW/I3GrXkYF8iLnpC28mccpqUSWbSXAbhbua/KjXCk6xRD49lLMvJDjbBVy4lU60qG2WB3aicL80QEcDq5zxgvwPxmsE5HRZltSnQwl1bac+M51WFb105qyDD4ntTK2oyqmlgSOC1uuhlH2vwn1lqwiVaxuwifcvWu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPewqdIt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d28023accso2758963b3a.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724036109; x=1724640909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOeP3uptZhXjP2X+Nbo7+R8OYNQlZsm54H+FAWgO54s=;
        b=IPewqdItUzG/+IxVnytBNxwfwjFgjVXcEBrqZVNvhLJazGsVKcrp2DNzq0CxVAaYjH
         i7C4X1knmND1V+Uqecg6VjtKys7Rm3qzbVKYMC+mbMa+f39OFbN5ZmfAJjgmgx70KgAK
         3kgXRAelNmxH3/iIdYSeH/WAPXxHIJvqPDVdbeWsd1U0IncN/dhVZmLjqs1K8KXXuEk4
         BgRXUm7W+uTpsEcCiMDnXZCO4+HCjoBVNCS4ERibk4g1iXqwXZ1/0hlu70jbVDtW64e7
         7vP1PfPdbFm8O2xzEVNrXmoW2ugZZTQ6qwCZVmt6ri7fXR8K2WBldjRsLzSv4fIiJjcS
         NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724036109; x=1724640909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOeP3uptZhXjP2X+Nbo7+R8OYNQlZsm54H+FAWgO54s=;
        b=SkmVCjrk7+CxNXq7UT2WAXKrJtjFaiIxTzHDCtXYqxw113Ev3/W0lRWFWl3DUkx18k
         NjOfZAKVVV6ehcw0e0uLtFeLSiZWMLu3CLLqICiHmo1L4mlHx1Wp5HeIibpY9VXGq7dF
         XAJPejeNVQGmFD2pISjvuEv77KwLGGg7cskIQVcmbwzL/O9TlGRX9qpjhQnhQWJPVbOd
         +SudUfnbCY1cTp72lNwDNbqaEgSAOZPjZvIzrg9+xF2bQF9aW6K8iLM+bper0os3M5WV
         1/9HcLjG2FRo6Ucyo+JroBCuVVbAC2mkcJQFIpC5tFP7SJeSYZbdvdGUPPXW/TxAkZpT
         ax1Q==
X-Gm-Message-State: AOJu0YxRNgM7Abe9lj2OEsA4kfRZDa2U4sAMW1Spa2bQyMcezUbuAAMk
	3AiEkT2qLF8+9TYE++Q0izI5/g1WMTrWDOXvdzNFMzwM08dv1k3X
X-Google-Smtp-Source: AGHT+IGf5D/D/qzkUPLJMxRL1kI8v0xZc5MOQF3AyR9Ps4zz9NhFt7XsifH2pIiIX7f/hG5hhSxBQg==
X-Received: by 2002:a05:6a00:9441:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-713c4e837cdmr8517348b3a.14.1724036108766;
        Sun, 18 Aug 2024 19:55:08 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e988sm5810063b3a.85.2024.08.18.19.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:55:08 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:54:56 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 3/4] bonding: fix xfrm real_dev null pointer
 dereference
Message-ID: <ZsK0AJXxNtJqr9AR@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-4-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114813.326645-4-razor@blackwall.org>

On Fri, Aug 16, 2024 at 02:48:12PM +0300, Nikolay Aleksandrov wrote:
> We shouldn't set real_dev to NULL because packets can be in transit and
> xfrm might call xdo_dev_offload_ok() in parallel. All callbacks assume
> real_dev is set.
> 
>  Example trace:
>  kernel: BUG: unable to handle page fault for address: 0000000000001030
>  kernel: bond0: (slave eni0np1): making interface the new active one
>  kernel: #PF: supervisor write access in kernel mode
>  kernel: #PF: error_code(0x0002) - not-present page
>  kernel: PGD 0 P4D 0
>  kernel: Oops: 0002 [#1] PREEMPT SMP
>  kernel: CPU: 4 PID: 2237 Comm: ping Not tainted 6.7.7+ #12
>  kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>  kernel: RIP: 0010:nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA

I saw the errors are during bond_ipsec_add_sa_all, which also
set ipsec->xs->xso.real_dev = NULL. Should we fix it there?

Thanks
Hangbin
>  kernel: Code: e0 0f 0b 48 83 7f 38 00 74 de 0f 0b 48 8b 47 08 48 8b 37 48 8b 78 40 e9 b2 e5 9a d7 66 90 0f 1f 44 00 00 48 8b 86 80 02 00 00 <83> 80 30 10 00 00 01 b8 01 00 00 00 c3 0f 1f 80 00 00 00 00 0f 1f
>  kernel: bond0: (slave eni0np1): making interface the new active one
>  kernel: RSP: 0018:ffffabde81553b98 EFLAGS: 00010246
>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>  kernel:
>  kernel: RAX: 0000000000000000 RBX: ffff9eb404e74900 RCX: ffff9eb403d97c60
>  kernel: RDX: ffffffffc090de10 RSI: ffff9eb404e74900 RDI: ffff9eb3c5de9e00
>  kernel: RBP: ffff9eb3c0a42000 R08: 0000000000000010 R09: 0000000000000014
>  kernel: R10: 7974203030303030 R11: 3030303030303030 R12: 0000000000000000
>  kernel: R13: ffff9eb3c5de9e00 R14: ffffabde81553cc8 R15: ffff9eb404c53000
>  kernel: FS:  00007f2a77a3ad00(0000) GS:ffff9eb43bd00000(0000) knlGS:0000000000000000
>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  kernel: CR2: 0000000000001030 CR3: 00000001122ab000 CR4: 0000000000350ef0
>  kernel: bond0: (slave eni0np1): making interface the new active one
>  kernel: Call Trace:
>  kernel:  <TASK>
>  kernel:  ? __die+0x1f/0x60
>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>  kernel:  ? page_fault_oops+0x142/0x4c0
>  kernel:  ? do_user_addr_fault+0x65/0x670
>  kernel:  ? kvm_read_and_reset_apf_flags+0x3b/0x50
>  kernel: bond0: (slave eni0np1): making interface the new active one
>  kernel:  ? exc_page_fault+0x7b/0x180
>  kernel:  ? asm_exc_page_fault+0x22/0x30
>  kernel:  ? nsim_bpf_uninit+0x50/0x50 [netdevsim]
>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>  kernel:  ? nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>  kernel: bond0: (slave eni0np1): making interface the new active one
>  kernel:  bond_ipsec_offload_ok+0x7b/0x90 [bonding]
>  kernel:  xfrm_output+0x61/0x3b0
>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>  kernel:  ip_push_pending_frames+0x56/0x80
> 
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/bonding/bond_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 65ddb71eebcd..f74bacf071fc 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -582,7 +582,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  		} else {
>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
>  		}
> -		ipsec->xs->xso.real_dev = NULL;
>  	}
>  	spin_unlock_bh(&bond->ipsec_lock);
>  	rcu_read_unlock();
> -- 
> 2.44.0
> 

