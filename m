Return-Path: <netdev+bounces-194366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97876AC8E25
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4977B6756
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD223BCEE;
	Fri, 30 May 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4+RWxuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879922DA0C;
	Fri, 30 May 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608780; cv=none; b=D3bHUuttK2EKVEk3D2XfUPH4m2rH/uhXb+raOoZjqVhF40HKfqQRsL+2xBPpApmyCUwUhp1EdQjoaMEJSj5nGaJKzHca0j+HoIJ4koXNWlD9xlrd8HkNbCx9ZqWRbg9FgXG0HbzzMnk1ZAVgVosTNYCu765MFGTNiTK5lOm0a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608780; c=relaxed/simple;
	bh=EDj24TckFfIwzZNQqFPFgCJ8JUM32c0qh/cAyJWLfGk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=vGA0kKKC+/Y1qHa495xncFj+cp3j6MrA9jjqBPBCE94HRjINGrzrpwQwEBcWlA7CYSD2fm9ivFtVIem7fg0F2bIQnMtGnDxANKHdNcbalTetdXj/bp4/+IuPNCKMmdzH+2SINXziCJnCbbDyS0uTHdsi6f/x32gxuduu2kkSu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4+RWxuy; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fac8c5b262so26577866d6.3;
        Fri, 30 May 2025 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748608778; x=1749213578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WX/pI2FZ04CxuI9v1Z6vNfe/KkzprDYtlWCM4gpgas=;
        b=T4+RWxuyiugoNXLxUMKVEcZD71SK7THi1B4DNEe+lRsYLKs+H2G0SH68GK+itw4Z3t
         B1p2mYTn1gFbcRdODC7I7lj6J2bC0aM5PCs74BSeyTzKdVO5jP9siE6sYeieQsWjJnwn
         SJXNjhgxra/wFa1cYmcXRgJwM5m0VJZMVQMNbj3z/N9qlKapow/jztxmO323pKhBw7eh
         ngxEHwFKWdaYwVhiTxZGeVIR/kyHbXpxJJM3Hqshk36HlSnQxxKllg3yRw3pr6h43Kqu
         4McLd9jse7Nl7IzS8RyezgpFXM42ONXSmRGkKO85RxBnvN87DpBUGX60s+r4LL82X/4s
         a+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748608778; x=1749213578;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WX/pI2FZ04CxuI9v1Z6vNfe/KkzprDYtlWCM4gpgas=;
        b=g/uEn+b78/MHuP1ZGzXrp0a9FqM120syEH5/kUIJwollSYBPf9ZZq1iHu5Wvj9+/UC
         djtn1h6rH2JIACfZ7MHFAkq1yGLxdzRrrc06n+h1xAKMNNKRa159RS/HswMXhHMaDSac
         huTwtAQAVK1iE4X+fYjJsad4hYgrJZNnHMiyH111/OvnzDDigEZq7QeHvHG+9d6Al0tL
         m9l5fA+zs6Qjmz8/Qc8nCFuZnFug3vGAY6glZiJ2Wbl6qR/nKMYPeiRhmBlccDjj2V5D
         9K4usVi9Ilv4C9011K2yXQiqL/TAsXlPwuZFTbj01x1eX23vuaZfIXrHF5pJDjiemscZ
         9Bdw==
X-Forwarded-Encrypted: i=1; AJvYcCXr02er1uzfDhOP+9XQtKdOYnzipopuAzESY4MjGMHOkbkbOvSaWwItNvrC3aaga9aOUlTsuLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywagx9kFdWPK5E0ErbocKQTUFQsS/JPjXxygZksKx5LW2CP3HJ/
	fnfGKiOVDfMihYa55m8KvCSUlQ5x/FDCjxnEcsOcpCQUk8lZeerWSGCh
X-Gm-Gg: ASbGncu8J8gvhVHeOMHUXtjDQIKRL7gD/eo3X5R4tOxT5QC8BhM1JfuDWIFm6O1IHBc
	RDhYewDXB3TzscyCSVyHx7ASRXTcQp1ui72P1RGPO6F9tCSQGbHZ8lArkcZjK6sWCxx2slzNL/h
	62I7RhnH5T0zWdYSQ5DhoKtTffqweyQzpavZurOnWpvByYMY+UX2BB2tZsfByDiyw/XEzmS3PBe
	Z1p4KpMUbKrtzvzL1tXxNKM2y00csv2hyMilvSuZNmDchOfp8SIH29I+FGvRzj+4sC7DU4NYMvV
	jebn8RmzSWyLQ+1A74YGvwQpLtowLiRkl0l/QB69GOH3FaELmcdbKvd4dhvcL8O//SKKxkd6sV5
	og6x3bnTe9rFYoSLSawmL36U=
X-Google-Smtp-Source: AGHT+IHFT/DYAQo16UED0XkBEZcGPbMpBChu5zz1e9LewGHKTOpAEqO5nDnTnivDufeHSpIpIrA67Q==
X-Received: by 2002:ad4:5aa1:0:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6fad190719cmr24362426d6.1.1748608777736;
        Fri, 30 May 2025 05:39:37 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fac6d4cce8sm21971236d6.37.2025.05.30.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 05:39:36 -0700 (PDT)
Date: Fri, 30 May 2025 08:39:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 lena.wang@mediatek.com
Message-ID: <6839a707f1b14_1003de2943b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250530012622.7888-1-shiming.cheng@mediatek.com>
References: <20250530012622.7888-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net v6] net: fix udp gso skb_segment after pull from
 frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shiming Cheng wrote:
> Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
> pull from frag_list") detected invalid geometry in frag_list skbs and
> redirects them from skb_segment_list to more robust skb_segment. But some
> packets with modified geometry can also hit bugs in that code. We don't
> know how many such cases exist. Addressing each one by one also requires
> touching the complex skb_segment code, which risks introducing bugs for
> other types of skbs. Instead, linearize all these packets that fail the
> basic invariants on gso fraglist skbs. That is more robust.
> 
> If only part of the fraglist payload is pulled into head_skb, it will
> always cause exception when splitting skbs by skb_segment. For detailed
> call stack information, see below.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify fraglist skbs, breaking these invariants.
> 
> In extreme cases they pull one part of data into skb linear. For UDP,
> this  causes three payloads with lengths of (11,11,10) bytes were
> pulled tail to become (12,10,10) bytes.
> 
> The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
> payload was pulled into head_skb, it needs to be linearized before pass
> to regular skb_segment.
> 
>     skb_segment+0xcd0/0xd14
>     __udp_gso_segment+0x334/0x5f4
>     udp4_ufo_fragment+0x118/0x15c
>     inet_gso_segment+0x164/0x338
>     skb_mac_gso_segment+0xc4/0x13c
>     __skb_gso_segment+0xc4/0x124
>     validate_xmit_skb+0x9c/0x2c0
>     validate_xmit_skb_list+0x4c/0x80
>     sch_direct_xmit+0x70/0x404
>     __dev_queue_xmit+0x64c/0xe5c
>     neigh_resolve_output+0x178/0x1c4
>     ip_finish_output2+0x37c/0x47c
>     __ip_finish_output+0x194/0x240
>     ip_finish_output+0x20/0xf4
>     ip_output+0x100/0x1a0
>     NF_HOOK+0xc4/0x16c
>     ip_forward+0x314/0x32c
>     ip_rcv+0x90/0x118
>     __netif_receive_skb+0x74/0x124
>     process_backlog+0xe8/0x1a4
>     __napi_poll+0x5c/0x1f8
>     net_rx_action+0x154/0x314
>     handle_softirqs+0x154/0x4b8
> 
>     [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
>     [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>     [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
>     [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
>     [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
>     [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
>     [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
>     [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770
> 
> Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

Is this effectively a repost of v5?

I think Simon suggested changing the subject line from starting with
"net:" to starting with "gso:", but this revision does not make such
a change.

Btw, for upcoming patches: it is helpful to add a changelog below the
--- marker line, to help reviewers see what changed. See also the
SubmittingPatches doc on that point.

