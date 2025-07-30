Return-Path: <netdev+bounces-210992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE7B160EC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D731894184
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FE1EA73;
	Wed, 30 Jul 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZ3ySQw0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1BDDC1
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880534; cv=none; b=iyCvrZIFRMC4/Bg3n/ihjeAO3pxk9ae8uzraOCigPYKGTPHNa8is+/d1m1/UGQ4UCQmS6oqLr5bxEJ7PV5ncliu34jB/F3lI1J79YUsJ+3+XCvrwqOWHatg7SaYorALmRrSSzjBabhN/usDqfjYXVCD5yO0E/wB8I9fplYRMzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880534; c=relaxed/simple;
	bh=EKWz7lKH38iBx9G9lKj/dfXFMIuIBrD/JAO24uYQoSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWcr03IMhzI33dpCZnfXfLDjVD5D/xAFEZT49LGzgYvMeVMPtgWt5REzwnxWCMK/7Z70MJMLg6fLJWWYbdP3tWenHp26yZi4TyD5wVjD3VXmi1h2CCWj3hTVkhFIjQuU/2X38awloOPGmWGuPs+5zKM+5Thc+U4H7QxyYQ1bAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZ3ySQw0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab6416496dso78085831cf.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753880532; x=1754485332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rN3UON+H05EcHxgb6M/QeEGZw2l1t4NsQJ9HRYrM4A=;
        b=NZ3ySQw0br4By9LumcPa66dJV3lCKpeLOnzYzxELuua5YI4j5JKNFOxW+JYm9AFeio
         TnX6Z0RQs1K7YPV4nU0HOb05jxVWlZYXX/BPPxLEAo4U7mjbmbc/gPogAZvmC6IFZcAq
         zm4nUjlZuU/S31Y/RWcbrFunLQNooy+ThMW7rLJUj/F0t4lp+lWI0Rv1Roe8ol9CULsD
         mLTHeursJdfyIKaHHGkE4LfuNXCuvxnyd420PFl5oWIxtzcX4QjyZD6Z7fpOsV40P4/R
         Eund7tFEspw8baPigrb2LMkIBAYMzXS4/8FneaMM4Ygx8Pe6wGPxL/ia2S8GFqwIfqUk
         R9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880532; x=1754485332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rN3UON+H05EcHxgb6M/QeEGZw2l1t4NsQJ9HRYrM4A=;
        b=SpIyDZ/4sdY8l2Wt9lEZt1iNfoUknEAKvPnH0FL/TeQQxYLYUyw0qCQPJvgdRHYy3L
         15B42IwL8EgROmZu+mu7RU8EmO9qiofv7Kh/hw3U+nkEQ6s2NUVWhJU4NfomNpVcL0Gu
         fn6SahvtoJ9vccRweC9Q/8hdPzx4ZL7lWGZO9ZIaFCc721y+vdrFml0xmesOrbbKipUC
         dhk2BgCMD/klCl+crNUsVL5Y/gYBClCU6R2JSQJr+mEFnVY9zB9dvg56OewFYDPJJmoM
         n1K0aDcUEkwb1Pne/AWIgt5cQYH+QKUwN8kDWcQWmE1rqfCuxvD8krieBS6pXJJ1l1J0
         3/TA==
X-Forwarded-Encrypted: i=1; AJvYcCVno0qrGuy0J/QKyIUMdeBTtI4Ot13CDtpxFiojfO3qMGxbBP3wpv6QOjJbOQhYC9BbvUTTimA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcG3S/Vz94UO+k2IWWCtTuH79tbSGWuvwX12fl/dPb11jEYRJ
	oXQfBUiWDfKz/hf18CVK9PBplP78W7r/WuiibCsFT93mdFoON0xdCCFPi1VLADjXsftiPqjNQKV
	36ymgyPrCOHfODC1SDXhK0QI6JRPif+B+aCGnQOhl
X-Gm-Gg: ASbGncskRvOZ9A/WaqQhmzrZyEpxv+CgN6izWfG//FckQIy2XuRYtpAXot5gXcy2X/4
	B14VuValhyMicqIWVsU67Vh3OM0Ypt3TyKrKvAX0TQAyTT3mkBt+H8F1V1C2ohGF4pOLyGqpQ5P
	h940Jt2cTyLy+fEIynevnsahqIuNk2pb2XbK1z7YXmbujI9LB97goBKsYhzSdX0DU2wOeYK4X5m
	49sdQrR
X-Google-Smtp-Source: AGHT+IHcGMzzmbnRb9/JQhYZqR97ZkqSV8DnaemzgaM9blXunoSk62/pkhUGvpoKLJ8T0KpdWokwI6uPWkLtY0vavbc=
X-Received: by 2002:a05:622a:1991:b0:4ab:6b39:c80d with SMTP id
 d75a77b69052e-4aedbc739b7mr68001891cf.38.1753880531629; Wed, 30 Jul 2025
 06:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com>
In-Reply-To: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Jul 2025 06:01:59 -0700
X-Gm-Features: Ac12FXzdnPVe3TXyJ7eq4quHNK56GH-YRf-lB4zvytBXGaGZwsaGM7v6B3jR5Mg
Message-ID: <CANn89i+24eme6OE-Q2TVQfyDqHTtMqatwyimxt_nX15OMKincg@mail.gmail.com>
Subject: Re: [PATCH v3] net: Add locking to protect skb->dev access in ip_output
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, quic_kapandey@quicinc.com, 
	quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:51=E2=80=AFAM Sharath Chandra Vurukala
<quic_sharathv@quicinc.com> wrote:
>
> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> this can become invalid when the interface is unregistered and freed,
>
> Introduced new skb_dst_dev_rcu() function to be used instead of
> skb_dst_dev() within rcu_locks in ip_output.This will ensure that
> all the skb's associated with the dev being deregistered will
> be transnmitted out first, before freeing the dev.
>
> Given that ip_output() is called within an rcu_read_lock()
> critical section or from a bottom-half context, it is safe to introduce
> an RCU read-side critical section within it.
>
> Multiple panic call stacks were observed when UL traffic was run
> in concurrency with device deregistration from different functions,
> pasting one sample for reference.
>
> [496733.627565][T13385] Call trace:
> [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0=
x7f0
> [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
> [496733.627595][T13385] ip_finish_output+0xa4/0xf4
> [496733.627605][T13385] ip_output+0x100/0x1a0
> [496733.627613][T13385] ip_send_skb+0x68/0x100
> [496733.627618][T13385] udp_send_skb+0x1c4/0x384
> [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
> [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
> [496733.627639][T13385] __sys_sendto+0x174/0x1e4
> [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
> [496733.627653][T13385] invoke_syscall+0x58/0x11c
> [496733.627662][T13385] el0_svc_common+0x88/0xf4
> [496733.627669][T13385] do_el0_svc+0x2c/0xb0
> [496733.627676][T13385] el0_svc+0x2c/0xa4
> [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
> [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
>
> Changes in v3:
> - Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Brui=
jn.
> - Dropped legacy lines mistakenly pulled in from an outdated branch.
>
> Changes in v2:
> - Addressed review comments from Eric Dumazet
> - Used READ_ONCE() to prevent potential load/store tearing
> - Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_outpu=
t
>
> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

