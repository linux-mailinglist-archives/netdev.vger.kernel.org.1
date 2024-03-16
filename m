Return-Path: <netdev+bounces-80224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5087DA92
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D2D1F21772
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1A4199B4;
	Sat, 16 Mar 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGhkhn5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E341B949
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602808; cv=none; b=rLUQdulcN8IWJ4muBOuhBpQ1urZ4y2I2LU7ZZ/fEuwqm/lSmRsg9aLxO4aWHNNgL3cxkuaaRBJ580VuI5xpZfu+w0hKdRwPz8mBPRaDW9PUASqLQymtgID0m7VP9U4rf03lzRsk2Pzu+kCo6DuCkIcb4+9ZSSVpWxQBdyo2+NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602808; c=relaxed/simple;
	bh=xdtTxTS3HwoHB5kN1aOatu6Xe7p6wvv0PDdUo8S/P0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7woXH5XjHQB/9Dm8ItniwEStKiHE/gi2aqIrWuNyiAuPXrp+vKTMeVfS7RNjUueSsQNIekHHlg0IQl4un+56AtTwJtM6uwbWMFrrdK0G6BHe3x++LepuozbtCI+QvEd+dUm0bmPoJiyF9Sjb4REa6LkY5GTAEH7X2ler9C9R0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGhkhn5T; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47677647d83so79625137.0
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710602806; x=1711207606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEqTcPJtophzXeUX/++GdsNQ+EAVM5hoD1Dy/s9wsc8=;
        b=CGhkhn5TQhTTbIq/oH0gyj/vnFY1+PYlR2HDI9AAPtIdMI2PwwJTtb7FcK1GOj8hbA
         P7UIS8g33eUV7RQzXKegfu2ryqWcfkmzaPpZ74LQFN97Imh7FJKchxDiE0jCL7OjJjzf
         Ns1/3b7lPLVxraQmnosR5mIpVhePiy7WKfhGCOAd46NnRtJpWwIyQfAjFDDJBTiowJL+
         ye5s63fgX3NrMpVKGa5lg8g0BUwH22uUR3onipDS916G+R4T9QKme0qpyh3mEXiJ57PH
         DICc0EHDiBCVtJjMw6zD6mRjS/dg+HHHhIOGBtT9G7d7ijzN5QmOypjZlo0/otT1AG0U
         kyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602806; x=1711207606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEqTcPJtophzXeUX/++GdsNQ+EAVM5hoD1Dy/s9wsc8=;
        b=I7z6XEgM11R7Gs/omymV//59TWH54J84Q3XUzSFGy6OLPUPSLtyQpBeXtoc1/8tKkA
         UsX5ZXOPNsMHM+Pez4+MXA06zp8T5Qrqwc6BupgyC3IsWcwZCEVV8R1GEaysYw3bzbuG
         sqHqRoFq1q8a4A02yGHYfJ0BV/G4qr/MdqLvw8LMJoL1DchAhmYlPfT5pknymmIsvBtr
         SmhuQKAW5TMJa3kenznnhCjGTHfD+mP1hGBnGC4a2N6fysVnAjVIxYzgb7+p8OYzjBC/
         +xKEFSCpIipsLijkVF0LyYXBKqiCoORLw9RuvwvJZKQbdm8wxGmd5x88gLA6Cz3c42/D
         6Wlw==
X-Gm-Message-State: AOJu0YznOxlahuPmfEuslhbhNM0vRR4GriWVkGVNu9tZrOAPUFtVmfe+
	j0doXpFlLCcSqhZx2k3n3COlm+X/nuDSVqBGh4Jj+gTTsBBaEPe94a4TYpu/Yj4zIlB/HIFiM80
	84DKGpnEoXgsSc9EWB9rj8vbkTEc=
X-Google-Smtp-Source: AGHT+IG5zInUXuSOt6MXVdRQg5WAlS9VTUxuqQoU1MUqWiWYkiE4t5WmeJBfmkmUK0WYQOiYPiHWmqzVtRjZ1HMv9MU=
X-Received: by 2002:a67:c78a:0:b0:476:704b:1c7e with SMTP id
 t10-20020a67c78a000000b00476704b1c7emr1813880vsk.24.1710602805912; Sat, 16
 Mar 2024 08:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKq9yRgO3akVUoz=H_vKgMjoDowq=owq5snPhmKLi4c=taLTnA@mail.gmail.com>
 <ZfUcBnDCepuryS3f@google.com>
In-Reply-To: <ZfUcBnDCepuryS3f@google.com>
From: Daniele Salvatore Albano <d.albano@gmail.com>
Date: Sat, 16 Mar 2024 16:26:19 +0100
Message-ID: <CAKq9yRiy166UpMA1HFiuzs0EMEM_aXbXbaTztbXcJ5CKF4F64w@mail.gmail.com>
Subject: Re: [mlx5_core] kernel NULL pointer dereference when sending packets
 with AF_XDP using the hw checksum
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 05:11, Stanislav Fomichev <sdf@google.com> wrote:
>
> On 03/16, Daniele Salvatore Albano wrote:
> > Hey there,
> >
> > Hope this is the right ml, if not sorry in advance.
> >
> > I have been facing a reproducible kernel panic with 6.8.0 and 6.8.1
> > when sending packets and enabling the HW checksum calculation with
> > AF_XDP on my mellanox connect 5.
> >
> > Running xskgen ( https://github.com/fomichev/xskgen ), which I saw
> > mentioned in some patches related to AF_XDP and the hw checksum
> > support. In addition to the minimum parameters to make it work, adding
> > the -m option is enough to trigger the kernel panic.
>
> Now I wonder if I ever tested only -m (without passing a flag to request
> tx timestamp). Maybe you can try to confirm that `xskgen -mC` works?

No, the kernel panics and, from the look of it, the stack trace and
the RIP are the same.

[  157.108402] RIP: 0010:mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
...
[  157.108827] Call Trace:
[  157.108841]  <TASK>
[  157.108855]  ? show_regs+0x6d/0x80
[  157.108876]  ? __die+0x24/0x80
[  157.108893]  ? page_fault_oops+0x99/0x1b0
[  157.108916]  ? do_user_addr_fault+0x2ee/0x6b0
[  157.108937]  ? exc_page_fault+0x83/0x1b0
[  157.108958]  ? asm_exc_page_fault+0x27/0x30
[  157.108986]  ? mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
[  157.109154]  mlx5e_poll_xdpsq_cq+0x17c/0x4f0 [mlx5_core]
[  157.109324]  mlx5e_napi_poll+0x45e/0x7b0 [mlx5_core]
[  157.109470]  __napi_poll+0x33/0x200
[  157.109488]  net_rx_action+0x181/0x2e0
[  157.109502]  ? sched_clock_cpu+0x12/0x1e0
[  157.109524]  __do_softirq+0xe1/0x363
[  157.109544]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  157.109565]  run_ksoftirqd+0x37/0x60
[  157.109582]  smpboot_thread_fn+0xe3/0x1e0
[  157.109600]  kthread+0xf2/0x120
[  157.109616]  ? __pfx_kthread+0x10/0x10
[  157.109632]  ret_from_fork+0x47/0x70
[  157.109648]  ? __pfx_kthread+0x10/0x10
[  157.109663]  ret_from_fork_asm+0x1b/0x30
[  157.109686]  </TASK>

> If you can test custom patches, I think the following should fix it:
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 3cb4dc9bd70e..3d54de168a6d 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -188,6 +188,8 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
>  {
>         if (!compl)
>                 return;
> +       if (!compl->tx_timestamp)
> +               return;
>
>         *compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
>  }

Just built the same kernel from mainline ubuntu 6.8.1 with the patch
applied and it now works with both xsk and my code.

Thanks!
Daniele

Daniele

