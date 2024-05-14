Return-Path: <netdev+bounces-96307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4C8C4E7D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3929DB21091
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEE3A1DB;
	Tue, 14 May 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbTp9rOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD921374F1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678014; cv=none; b=AQZ7L9HDpfHB+E1JJmwIwmN8m6btwwQigP1+vCg7xRmWfPdaJilR6/tyH+kJtpd2dtD0IgcHuPlZcErfm4UF0I8JxG8BKjbYex1XXuu56L/Vok6+CgWgdvkBhLXo3qH3k8hFsC4u4JjmjlsKhe3smL3RgNQWK0h3HkdpatQbyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678014; c=relaxed/simple;
	bh=VYRB+Ouvlqhzn10t7PNBop4dioimn4N1ByX0GFf9LBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0vkZpuOlwNQ6zrj59e3WqSSnhVxNnd9MRwIhizOHLUwkEJv14ifWdQn7TorCqbAWaTyl+JFUp+7G/K02e8PdsjKTTKHFQedKSt0GxugF9wAOBZ3oO4DUKAxCWXRYoxqkm7XJijww4+CM6g+akkGFjdVm/e2qbqGWmJXTUohsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbTp9rOp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso8879a12.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715678011; x=1716282811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dm9e2rB+qysjesAMDhmDRS2RUoSHW6BwW/GWf64bHU=;
        b=HbTp9rOpcQrRL5RgQH/k165fjNDUxgxJecg64kkDq24BloEJBYR9F9jKyJUK8xEubx
         sP+L0yvuNSJxN0ThPCuOOgWsUC0i2dqN9YYU4SUgToHKC9pd68FVqZOLdgGrP+d006vt
         EOgYJFpv+IGwPI8BKVvL6b5bRBBHd7xMR9WYYjvnjBraIGd4WSoCEqjqa2z/dthOOV1/
         1QjX85LKUjdyKRQOEbj7LvJXQIbV2ZK7vcKqqGu2QdKa3mAFeOZq8/9LqBRP9EEqAi75
         dBx4Sa7FP9UtLp4utfQD4fp1DCRbxyHAQP9yNfby7Cwj67Hndq8mAGSe1ivUH7EOuHr0
         J32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715678011; x=1716282811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dm9e2rB+qysjesAMDhmDRS2RUoSHW6BwW/GWf64bHU=;
        b=vzbzBC9ZbDH7f6NPu4rd8DbKLlPhAVT91/nwwWGsM0VtP9zP5oCXnrWcTgFSYZb+Yc
         t1UEAjkMIiKagx4Mso8UiKkhLOBrOEBDRZyhyN5x7IiAqDd7FC5uQZs0xYiu0iwYh0Un
         4muK3g7T4X2/rLhbcgi7tDnky2/uwOBo2ePbd8b8OVFb8Cv0RGcOqOp+0JShSBqYgp4Z
         yhsRlgCLv4z2fFupVFJd+TX/dFXUANOFpOo3t7ZvKcgHLkOsK1DQEpshC2eOKmSMJuky
         OFec01+y5HcNZQW3TwA/Ow/tddZVyE7s+T6MpHHkSaBCtd/Wj+Pny4NXcNzDcpHFvIvb
         PNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKCj8knhxHevxuLpChMSx+oAAihO+A2rFUy4B/buS7694wBHxcxVpEqL9ei0x5nH/ZsG8nwnV4nZBthSRVEGWfvYA8vJEU
X-Gm-Message-State: AOJu0YyLPyGFjoNP+SaKJTs3LdyWic7B3L4O/2KKmDp+4DYNvn6g1+zU
	P9ENQ52vmcDN5t5uaR/LmjFyaRvIN8fdSc9JZYZO42qDlkUscsMcxIoEyRqWjMSxr2nRFgOaCmI
	3vuPchO1c4fMY9FZ2qiWrqzSetGDw2jGdIUBB
X-Google-Smtp-Source: AGHT+IH1Rt2OKBKHSXul0bXE76HfTd8yqfW2g+XomaBrEXoE+Td2aWEBQSrokSQABaJ25tH0P5nvOwaJFgHF/nlsuNA=
X-Received: by 2002:a05:6402:5248:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-574e7e13675mr54268a12.7.1715678010798; Tue, 14 May 2024
 02:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org> <20240513-gemini-ethernet-fix-tso-v3-1-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-1-b442540cc140@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 11:13:19 +0200
Message-ID: <CANn89iKX0Gk8J=QVe5JwNi39zNzzfb2mP9tD4E5NLdimfrj5-w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net: ethernet: cortina: Restore TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 3:38=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> An earlier commit deleted the TSO support in the Cortina Gemini
> driver because the driver was confusing gso_size and MTU,
> probably because what the Linux kernel calls "gso_size" was
> called "MTU" in the datasheet.
>
> Restore the functionality properly reading the gso_size from
> the skbuff.
>
> Tested with iperf3, running a server on a different machine
> and client on the device with the cortina gemini ethernet:
>
> Connecting to host 192.168.1.2, port 5201
> 60008000.ethernet-port eth0: segment offloading mss =3D 05ea len=3D1c8a
> 60008000.ethernet-port eth0: segment offloading mss =3D 05ea len=3D1c8a
> 60008000.ethernet-port eth0: segment offloading mss =3D 05ea len=3D27da
> 60008000.ethernet-port eth0: segment offloading mss =3D 05ea len=3D0b92
> 60008000.ethernet-port eth0: segment offloading mss =3D 05ea len=3D2bda
> (...)
>
> (The hardware MSS 0x05ea here includes the ethernet headers.)
>
> If I disable all segment offloading on the receiving host and
> dump packets using tcpdump -xx like this:
>
> ethtool -K enp2s0 gro off gso off tso off
> tcpdump -xx -i enp2s0 host 192.168.1.136
>
> I get segmented packages such as this when running iperf3:
>
> 23:16:54.024139 IP OpenWrt.lan.59168 > Fecusia.targus-getdata1:
> Flags [.], seq 1486:2934, ack 1, win 4198,
> options [nop,nop,TS val 3886192908 ecr 3601341877], length 1448
> 0x0000:  fc34 9701 a0c6 14d6 4da8 3c4f 0800 4500
> 0x0010:  05dc 16a0 4000 4006 9aa1 c0a8 0188 c0a8
> 0x0020:  0102 e720 1451 ff25 9822 4c52 29cf 8010
> 0x0030:  1066 ac8c 0000 0101 080a e7a2 990c d6a8
> (...)
> 0x05c0:  5e49 e109 fe8c 4617 5e18 7a82 7eae d647
> 0x05d0:  e8ee ae64 dc88 c897 3f8a 07a4 3a33 6b1b
> 0x05e0:  3501 a30f 2758 cc44 4b4a
>
> Several such packets often follow after each other verifying
> the segmentation into 0x05a8 (1448) byte packages also on the
> reveiving end. As can be seen, the ethernet frames are
> 0x05ea (1514) in size.
>
> Performance with iperf3 before this patch: ~15.5 Mbit/s
> Performance with iperf3 after this patch: ~175 Mbit/s
>
> This was running a 60 second test (twice) the best measurement
> was 179 Mbit/s.
>
> For comparison if I run iperf3 with UDP I get around 1.05 Mbit/s
> both before and after this patch.
>
> While this is a gigabit ethernet interface, the CPU is a cheap
> D-Link DIR-685 router (based on the ARMv5 Faraday FA526 at
> ~50 MHz), and the software is not supposed to drive traffic,
> as the device has a DSA chip, so this kind of numbers can be
> expected.
>
> Fixes: ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

> +               mss +=3D skb_tcp_all_headers(skb);
> +               netdev_dbg(netdev, "segment offloading mss =3D %04x len=
=3D%04x\n",
> +                          mss, skb->len);
> +               word1 |=3D TSS_MTU_ENABLE_BIT;
> +               word3 |=3D mss;
> +       } else if (skb->len >=3D ETH_FRAME_LEN) {

Note that this code path should be dead, because the upper layers
should drop the packets before reaching this point.
I wonder how you have tested it.

Reviewed-by: Eric Dumazet <edumazet@google.com>

