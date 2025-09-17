Return-Path: <netdev+bounces-224049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A94B7FFEE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568BC54564E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E542D375C;
	Wed, 17 Sep 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/yE0OEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED432C324F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118716; cv=none; b=R/iZj1t99eYGbhW616HE+PgPjl2fMpZlkdSWNip74cEpZE3LwqOgerpoJcQ2fOMfjD4JyvzG1zL56bYoObL4IP+wNaeBC+u0fb1p1grABBgc9ry5LEmtrrardzetJn6zaDl9bQ/liMv9KhHGKHcV8kHNe/OQIv4ljMupOm62WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118716; c=relaxed/simple;
	bh=GSEP0UxkbSq28RxbUKMYWJeiLik+SNWkj2DdmQyr/uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSWlvw9manh0HkiL3My2bm28oHbIN5PlfJd73eKfUKIHtoiaG48BHSmD6vgQMEmyLlANlnS3XwrQ07cRXvb0DwriNIPbQdLM9Y1IISaJtSnvhmJg5CLUsxypD2SY+NFEH4s/nxjt6epfWq16TAbIbX9GBZCyIk4uPd9tobLbOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/yE0OEb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f04816589bso644160385a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118714; x=1758723514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7xWdF+r/5i0xJN6wtkMYq6hTk1GD/nZovhiTCNzQWQ=;
        b=m/yE0OEb9F16I+4OQOU75YtIXhXSU5IBZrktpOlcj1AaUbosCUGl8D1m1gqSm1BxMf
         +7/zojL9A7tgDxo7EEZ+s1+MyVr8lCOZQK5TtW2vksyrWo3P7gRLdVK/ZiXEXmgmHBkV
         yvk7T6uTdNeKej5Ya5lwQiIKmUj0Y6l5qKUDgsZSrMjuTt37Kxug1IU2gReIDH52M5qW
         rsgJ/ZZWJUHGqaZNsF9Rbt1tevJCugnqTXosenJX0viTjPduietEOmtzjRVu5l95hnDU
         DXt1SXbPtTjXo6/oB8k/cRiXSw6/aliMb2NME5AB5tO9MM46AJQbmeyHZH8ZaHz7jW8l
         0Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118714; x=1758723514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7xWdF+r/5i0xJN6wtkMYq6hTk1GD/nZovhiTCNzQWQ=;
        b=m1eb63T1ASYjylOueAzpmCBqmhN9kYB2Wn/u1T4DltgKzb4SMmKj2H03SmYvZb9JLE
         P5bs/FXmJqPsjeg0JvwLLjdTXNH2noa8faIl3+8NwpY3ygm5FtqciW/yaLCudp76VdTt
         iJVbqBS5a4ySHpvfEfHvDbMVnDF5B2GvuQF3kvzlkj0PFKmSNoL0uG4ItSPQ2RRZQ5PO
         Z9zIAfv/Zv/z9bOKwApCmz2OrULyUiR0G3PKrIAxICO7D5Q7WRZYvO08VNOzFtgNVFV3
         54+yzb85abVEOxj+J9kboJKu/8GUczjKlg1xHZ0MLX95qic/x8crejyHHk3ev5REjyvV
         7m+w==
X-Forwarded-Encrypted: i=1; AJvYcCULzj6BLjLoOcXYzV0AzVsRrj8PlfXNqUDOBYUFv0sPN4WOvwZr6TaUo9ILs/vmpAUFg6DIv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IVAwLnTBg0//qROBiTmRJm9Bc7LY1cEyM1pesrHFBN9Icx8t
	CZFAJV0U5siazI6iTuITitaogY7bjvaoT0ajPyfwdMRHSQb1lbbbMeu/Gf33eJ3ExVfWoTT3/NQ
	770nwcFd2Xs3Jym6ZUxndrg4Q3Q3eLHoVUf+Rkfha
X-Gm-Gg: ASbGnctXUNdu7iwX1rYSYHriqJ03o2W4dmKmz40HD+WFQV5PVhSOhED82N9866M5wCO
	O1w5dCs7QS03cIRw7bmFNgCOWn/OSUl20CgANuT06gWg+Y147jgEA0r9QrJMXBxfVZycNkmlH4t
	9cTPZ3KPlUwbItwN/6JuyX/2qg/gR2CM8rWa1PG9WwYUKMY6GoYXjt9WBYcNVJ5+iNaF8EKJ2yO
	2tsGcB8Kgapvvf7LE3AyMg=
X-Google-Smtp-Source: AGHT+IEQhamDW2XkxN1/MlpD9St4v8e4syVJb3R5bSHKt9nK0Skb5V21LC+HQoSSI6B8dq2ZJrIuokcfAvYwze9ZmS0=
X-Received: by 2002:a05:620a:c50:b0:7f3:9036:13ec with SMTP id
 af79cd13be357-8310dfd570emr224356885a.38.1758118712952; Wed, 17 Sep 2025
 07:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-2-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:18:21 -0700
X-Gm-Features: AS18NWB1nBDYMm64aNa9koMVEuL_uPqlLy7zr7xpvbiHZ613L3rc_flltelpbOo
Message-ID: <CANn89iLo-8gw=jEF6ixie0Nn87f+2Zot-GTwRTbbK_4rNznGWw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/7] smc: Fix use-after-free in __pnet_find_base_ndev().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, 
	Hans Wippel <hwippel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported use-after-free of net_device in __pnet_find_base_ndev(),
> which was called during connect(). [0]
>
> smc_pnet_find_ism_resource() fetches sk_dst_get(sk)->dev and passes
> down to pnet_find_base_ndev(), where RTNL is held.  Then, UAF happened
> at __pnet_find_base_ndev() when the dev is first used.
>
> This means dev had already been freed before acquiring RTNL in
> pnet_find_base_ndev().
>
> While dev is going away, dst->dev could be swapped with blackhole_netdev,
> and the dev's refcnt by dst will be released.
>
> We must hold dev's refcnt before calling smc_pnet_find_ism_resource().
>
> Also, smc_pnet_find_roce_resource() has the same problem.
>
> Let's use __sk_dst_get() and dst_dev_rcu() in the two functions.
>

> Fixes: 0afff91c6f5e ("net/smc: add pnetid support")
> Fixes: 1619f770589a ("net/smc: add pnetid support for SMC-D and ISM")
> Reported-by: syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68c237c7.050a0220.3c6139.0036.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

