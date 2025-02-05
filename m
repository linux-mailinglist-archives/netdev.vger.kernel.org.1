Return-Path: <netdev+bounces-163066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F9A294DE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729BD3AAC73
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F41494DF;
	Wed,  5 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExtNQvwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CC1519B4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768976; cv=none; b=j5cUZY7qVomqYR+2gkRHoHUGmJ41Y8xhuJyFIFoCFQBa10LgxjSAWl6gCVnmf+frEEnPjDGQpcuH+01Fyzm/8NuWnafABJk8bM35oWeUsJ1TIVTzVp6G+ZHy5AZoQ23VFkeJlD7sRZV4vZXHR2Z7uacqCVzi2TmIFYDyS4xiFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768976; c=relaxed/simple;
	bh=TFK1hlYmtmCIVQCuf0ceE/1dA27FH7RQ98+e5cbJdEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlheF1LM6QsLLI/UjyAS2bm9h1GngpunA+RWuZcBrUGvfH7MRcpZYDlcv3PC0ZF660E1tjTItfz66Fh9Lwc79cLEuAGJrdwzEYfTk/3RFd1sXkT1pX8caXGmmj7gRva/O13p1IyHo5hkqOiLvlw5xFR29ZOcZmARh0b8iKVl80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExtNQvwq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d04e7f284aso3873745ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738768973; x=1739373773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0GVoc4UWh7T9xSBrj4G2khSiL7SFLMdxl0S46og9VY=;
        b=ExtNQvwqfbXVJv0JDd2Pz/4lGfPRqOgKKRlj2cuultpxOteLKb5gc2/QO3AILK5Dry
         7k/zl4+lmYrTmXvctUBpdqqe1fTuWMrFfmHgwSiPfh9y/kFq/bsOkZVQRCE0SLfteIWu
         tGGyJZkB6JEmDVjad/Ut2GWxRlG03yLBS5quFXEuNvPwDQ9I/+A+s8C8S8ST8XFNqRbT
         U97RX70rNdAxVjRLxySVeaL5mtHjMfsgqo51POKA0yPxzInw5eA8IPOqO/iRxO66SavK
         JPg0/bfxCC1WLCmePHKJ/TIrbdfQjWjVfayYmS9FZE3auhZ+t8v5RqjDzmoV2/2jnQrK
         ha4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768973; x=1739373773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0GVoc4UWh7T9xSBrj4G2khSiL7SFLMdxl0S46og9VY=;
        b=uqX8LfHSsAQ7TR7Mqj+h8ZmHMzu85/8bLa0xrO4+IPzqFmuhQ+5LHYtlO6KyuW4PWf
         E/O3EhWSDCPBn7XBV6p+XjkCyMNRqQNEiindEYTpPhla81RZtx7yUaL/xXZAAxK8WM0M
         ukxvrjaSKQON0HFC/4GYF+BjoXHha3U5q3EUaI4EnIE5Ys3v9P0GNjUIWVm9T79x97QP
         ySqCIAu8BQbcVrXJh/dIlNSt3zPQ0YbXMIpn0xPGdVm38H2mNktoKa0LxkeefTlnpEq3
         BfedUXtngbvZR6N2WaO+YeUWlpHL/OI/HF1zzVgwPOBFP66HqOXaOjkG9BYqulrm+sV/
         tqlg==
X-Forwarded-Encrypted: i=1; AJvYcCXXgPsfvIxfHm6u32SgTPSWiSrxUUb41NdRebIghCDj4vLVjlMIXkzGLYS8FjXwg/8VQCaDWpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCiBsLaUnGSke0qkNiBCpgibkbbCEFirRDkTT4hopQn69U/qi
	fr0tMS9DrPpdRH9rnNyc1XhaKqLEQgGxDq2X2b9U545jT9ZmzGPCCUKaruQJezJA8Hy4/+uvqkN
	RhH/UE1GZ5kkMdl0Y3viZhs0dWyJr44GK4aWxrPFH
X-Gm-Gg: ASbGncv4seVLLzkt6V922FIMueA5WYzg/RAmnL7o0pEvTxx85YF6Bhy19QP2sRbNgGN
	ZG2LZkXuSobyHF3KFwi599Ws2gyS2Y277cBnCWoqYzfdumAI0KGgw/b/MmdVxS5HiR6KI4iw=
X-Google-Smtp-Source: AGHT+IEQoJcA3yk8DKMwqQ3Yl/AqkdktauszkXJ80mEBEX1Bk9e8P3IoJq4H+K7946WwF3fcBzvk2libHIQYsQyWAaw=
X-Received: by 2002:a05:6e02:1546:b0:3d0:4700:db0b with SMTP id
 e9e14a558f8ab-3d04f4115bamr27139575ab.2.1738768973533; Wed, 05 Feb 2025
 07:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204144825.316785-1-edumazet@google.com>
In-Reply-To: <20250204144825.316785-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:22:17 +0800
X-Gm-Features: AWEUYZkt5c7wxgpaEnyQq6Sy2eh2xVSClp9aQMhBSN8fV5modj9XEhQp71fFTtc
Message-ID: <CAL+tcoDCoSVdV_doreW9mqxxfxfn2oGw3ucNKCDFuLmDzkK=cQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Feb 4, 2025 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add READ_ONCE() around reads of skb->dev->reg_state, because
> this field can be changed from other threads/cpus.
>
> Instead of calling dev_kfree_skb_irq() and kfree_skb()
> while interrupts are masked and locks held,
> use a temporary list and use __skb_queue_purge_reason()
>
> Use SKB_DROP_REASON_DEV_READY drop reason to better
> describe why these skbs are dropped.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/dev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0021cbd28fc11e4c4eb6184d98a2505fa674871..cd31e78a7d8a2229e3dc17d08=
bb638f862148823 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6119,16 +6119,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
>  static void flush_backlog(struct work_struct *work)
>  {
>         struct sk_buff *skb, *tmp;
> +       struct sk_buff_head list;
>         struct softnet_data *sd;
>
> +       __skb_queue_head_init(&list);
>         local_bh_disable();
>         sd =3D this_cpu_ptr(&softnet_data);
>
>         backlog_lock_irq_disable(sd);
>         skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
> -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNREGIST=
ERING) {
>                         __skb_unlink(skb, &sd->input_pkt_queue);
> -                       dev_kfree_skb_irq(skb);
> +                       __skb_queue_tail(&list, skb);

I wonder why we cannot simply replace the above function with
'dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_DEV_READY);'?

>                         rps_input_queue_head_incr(sd);
>                 }
>         }
> @@ -6136,14 +6138,16 @@ static void flush_backlog(struct work_struct *wor=
k)
>
>         local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
>         skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
> -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UNREGIST=
ERING) {
>                         __skb_unlink(skb, &sd->process_queue);
> -                       kfree_skb(skb);
> +                       __skb_queue_tail(&list, skb);

Same here.

>                         rps_input_queue_head_incr(sd);
>                 }
>         }
>         local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
>         local_bh_enable();
> +
> +       __skb_queue_purge_reason(&list, SKB_DROP_REASON_DEV_READY);

I'm also worried that dev_kfree_skb_irq() is not the same as
kfree_skb_reason() because of the following commit:
commit 7df5cb75cfb8acf96c7f2342530eb41e0c11f4c3
Author: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Date:   Thu Jul 23 11:31:48 2020 -0600

    dev: Defer free of skbs in flush_backlog

    IRQs are disabled when freeing skbs in input queue.
    Use the IRQ safe variant to free skbs here.

    Fixes: 145dd5f9c88f ("net: flush the softnet backlog in process context=
")
    Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks,
Jason

>  }
>
>  static bool flush_required(int cpu)
> --
> 2.48.1.362.g079036d154-goog
>
>

