Return-Path: <netdev+bounces-80452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921AE87ED2E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA492810B4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7D53379;
	Mon, 18 Mar 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyFfMZJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9D36B11
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778586; cv=none; b=RZboq4kfXGWI1y0A7amj2EUgt3Ve8SDDc97ddNM6hZWvwomIwBu07jQfEGw4U5CJN7xWuvHkEkFS8i4+XX+mW4cxqekX7b6cz7/6xk6zcJ778qKvODn9mTnATMo1Zrp6c3+Z2Y83WJR1EISzODNbVp4tLT4dKtDpALtgquXECvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778586; c=relaxed/simple;
	bh=kIPT8WsCY+H9L3hVchZq7c5tHwNbTsddEEoaFdQRrVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCuddLmeqduZYEnjFyIiKWKfx8yzkkr+Fh3CBHv6tw3bqY/sW1bYWXeIpBMWxt/nQ4jWWnpfn/6azU28tP29QdE95cWIC9J9xi28T/FP8FvZjuvSWfs5spm7MIduJbvqfrGxO5FFrCJlyWXy58rNPXd7rw1gRrYS3kpLxV7b5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyFfMZJ6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6fd169871so2063722b3a.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710778584; x=1711383384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2V5xK0xL6Yo1KxyVhsRlWIUcVjyTsMrrCtxrEY/+wU=;
        b=qyFfMZJ62h6nE6FXgVvvrGtf2s055CtqRht0YPzI70A9vo4RqLtfFGdVYQqvWDVqtM
         3PBGunY/mmRUV0pT2LdSk7aWwLqLe5J5smC8RTXWccWE1wOeFE21LtKLN8asYQUgXnJO
         YFHY4CG/wmdqjC5muYA3CqIcIWLSyOS9WrviJ6q2VhUp2+6l0nF7XxV6KcLrcEnI4f2s
         tlD9XsplYYiuBTrpgXr1SOjlsNaYpe+4deaVeENC5QCEQhVeO1Yl827NETY2PBrqOnQC
         9JSKw2cFFMU09I93TC0R2OPCneESIF354N+dD4NTiPANOBzdtqfPmmTl6fnIBIJXqKXP
         YEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778584; x=1711383384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2V5xK0xL6Yo1KxyVhsRlWIUcVjyTsMrrCtxrEY/+wU=;
        b=cGk63rgrLVZnh1Fr/An6MlD4/3GRTRPhBkxZGEi1CLqEukNe4h+8TmVk8rMdLWgq+u
         C6BO3hxg0QXAF4FhWSQhuNmpbC6xXgZh64D8j9VXndI428snrsn88S2yY6UX7ABuHlYu
         xH0YnPtYyTtCA9niV42gPzfqEgGlrd+G6DA22vy/r3GL/gahtzXkevEKD5gWHea7Etnq
         5e/sUP0yj8JK5WzHPj6WrJrMqjB5vabwXPW1exCsfPAs26LmUivqLsEglawEhqMz6tr8
         GquvN6Q7S+d2OlfeAspwDb0sNNhOF0dz3b3sLeYb+sLAnNxsKI7cTRT5dqvsTRhcTIB+
         Vg/w==
X-Gm-Message-State: AOJu0YxuZNaAoJ64SI9bu7WdgLPrEYncN8eb3d1belUhf96TCKIAzw+0
	pRs6dvQqEGzrvQRcZmgLTpZV40rM+216KkIt3gHksRf1ZlvLBE2TvPGZI49F6yEBYQ==
X-Google-Smtp-Source: AGHT+IGvW4n3u8pbkk5icE8iBWVpe7ZWHAPf/8Zxz07kQmGMufq4cyVxL5GBZpyyVVGJlIdTVCDArRk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3997:b0:6e6:8730:124d with SMTP id
 fi23-20020a056a00399700b006e68730124dmr320pfb.5.1710778584310; Mon, 18 Mar
 2024 09:16:24 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:16:22 -0700
In-Reply-To: <CAKq9yRiy166UpMA1HFiuzs0EMEM_aXbXbaTztbXcJ5CKF4F64w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKq9yRgO3akVUoz=H_vKgMjoDowq=owq5snPhmKLi4c=taLTnA@mail.gmail.com>
 <ZfUcBnDCepuryS3f@google.com> <CAKq9yRiy166UpMA1HFiuzs0EMEM_aXbXbaTztbXcJ5CKF4F64w@mail.gmail.com>
Message-ID: <Zfho1lRIg0cjpWwK@google.com>
Subject: Re: [mlx5_core] kernel NULL pointer dereference when sending packets
 with AF_XDP using the hw checksum
From: Stanislav Fomichev <sdf@google.com>
To: Daniele Salvatore Albano <d.albano@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/16, Daniele Salvatore Albano wrote:
> On Sat, 16 Mar 2024 at 05:11, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 03/16, Daniele Salvatore Albano wrote:
> > > Hey there,
> > >
> > > Hope this is the right ml, if not sorry in advance.
> > >
> > > I have been facing a reproducible kernel panic with 6.8.0 and 6.8.1
> > > when sending packets and enabling the HW checksum calculation with
> > > AF_XDP on my mellanox connect 5.
> > >
> > > Running xskgen ( https://github.com/fomichev/xskgen ), which I saw
> > > mentioned in some patches related to AF_XDP and the hw checksum
> > > support. In addition to the minimum parameters to make it work, adding
> > > the -m option is enough to trigger the kernel panic.
> >
> > Now I wonder if I ever tested only -m (without passing a flag to request
> > tx timestamp). Maybe you can try to confirm that `xskgen -mC` works?
> 
> No, the kernel panics and, from the look of it, the stack trace and
> the RIP are the same.
> 
> [  157.108402] RIP: 0010:mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
> ...
> [  157.108827] Call Trace:
> [  157.108841]  <TASK>
> [  157.108855]  ? show_regs+0x6d/0x80
> [  157.108876]  ? __die+0x24/0x80
> [  157.108893]  ? page_fault_oops+0x99/0x1b0
> [  157.108916]  ? do_user_addr_fault+0x2ee/0x6b0
> [  157.108937]  ? exc_page_fault+0x83/0x1b0
> [  157.108958]  ? asm_exc_page_fault+0x27/0x30
> [  157.108986]  ? mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
> [  157.109154]  mlx5e_poll_xdpsq_cq+0x17c/0x4f0 [mlx5_core]
> [  157.109324]  mlx5e_napi_poll+0x45e/0x7b0 [mlx5_core]
> [  157.109470]  __napi_poll+0x33/0x200
> [  157.109488]  net_rx_action+0x181/0x2e0
> [  157.109502]  ? sched_clock_cpu+0x12/0x1e0
> [  157.109524]  __do_softirq+0xe1/0x363
> [  157.109544]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [  157.109565]  run_ksoftirqd+0x37/0x60
> [  157.109582]  smpboot_thread_fn+0xe3/0x1e0
> [  157.109600]  kthread+0xf2/0x120
> [  157.109616]  ? __pfx_kthread+0x10/0x10
> [  157.109632]  ret_from_fork+0x47/0x70
> [  157.109648]  ? __pfx_kthread+0x10/0x10
> [  157.109663]  ret_from_fork_asm+0x1b/0x30
> [  157.109686]  </TASK>
> 
> > If you can test custom patches, I think the following should fix it:
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 3cb4dc9bd70e..3d54de168a6d 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -188,6 +188,8 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
> >  {
> >         if (!compl)
> >                 return;
> > +       if (!compl->tx_timestamp)
> > +               return;
> >
> >         *compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
> >  }
> 
> Just built the same kernel from mainline ubuntu 6.8.1 with the patch
> applied and it now works with both xsk and my code.

Thanks, will send this fix shortly!

