Return-Path: <netdev+bounces-114819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC80944507
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C40280E9E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD716CD0A;
	Thu,  1 Aug 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW3Yu6Ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597016CD0E
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495513; cv=none; b=r2sbD3zXMgFRPL/WOIsqm1DCB+vzlHyQB6VIOTM6hemH+DeBVUtE6mAa1V9t0fAFy7pup5iTQ0sZAcagb+TgeCs0r4KXX0aYi9Zg4O+MEPVIRpLImZWGLr+MJfc7snJ/S4W8ILgenXdO1vtXV/frZcEsyLALxGjm6q5dRaNDXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495513; c=relaxed/simple;
	bh=Zy24vuG6W29Ph8uuujheRLDuq1FzC5Y5HC4c6+wpkPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eylh2x40cW4I7cjgqIaoez+wTOBLuem5bXoZp4lYgMacWLPPsd0+zzkWnYz0dSihTZtYKfxn4saDWSQFNKymshgjGpYBGVU4YF/y/G273+k3S/QZX99jv0p4q7WipD0Sd0HUJiAvnH6i5e+6uAyD0zOPIjxaN9ulf/BJR/O1plk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW3Yu6Ai; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso29229a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722495510; x=1723100310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGCOB/HqJzuVM/uNjkdUd32BMg9WJsNIingrvoWOVEs=;
        b=LW3Yu6AiMi81opTnnUHGptVQIz+/CKwdWg3DA6XePUi1x2lFjdrXjMFnU+3DkiI3ti
         WOVADuLZsKCwKCdH5dmBnzxVn4JEFH0/A4xd2vh7LxFzhou+rZamfy+hklziANfo742M
         DixKEfb9ORPZc/PhtM5StS9cOX/QeG4v1lj84xQU8H8YDlkbqU2x5or0YYbyybmJ46cc
         M0aC2+PqO3VKNQjpxycr64b1vKg7Yv+XFKHZIayRmtyQdaWDwWT5LxERC0EaBzw2uBQ5
         QoEETMpdUwyJ18N9gaz3p0bJqCXbvOCnlMyyfBHkdA5Da7eoMmZpxzd/ltoqwITqIG17
         l6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495510; x=1723100310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGCOB/HqJzuVM/uNjkdUd32BMg9WJsNIingrvoWOVEs=;
        b=HuXYwqoWVL7v2JuXri96drVAc/7/c9LmLrg6TehMb/4l/8yRaThDAmd81tkEIVfwnN
         bpBREl4FIgbKPQDgJj9b9ISx6A7aAw+w0RUzqpDYwnH/VmdrA8EerB7SJ6diHHQKRCog
         l60EeS2IRSYJCkidSUH/BhOfi+HYdpMVZVfGGm9A7bDAzjswwReaxO7covKMUM//hZTg
         /UYyD0PhDn0l+6LUD4MJaURbfLt9KAUH/phqVUPkrUvlCssCSUuJgZBKuIWyV2yQNBE3
         xpq+IvCdEJW3x6M+RYEnf0ssuXTKfOIzN9/HCZqFm1Vzeq/uW6CP2x3SDBwN1Zh+ZBhA
         jjtw==
X-Forwarded-Encrypted: i=1; AJvYcCU3r2HAXahr9l7jJ4601UETuUlh4ra1FnLT52/6RAoGFIzGWKJHNnF04UJUutL97hntmNJzwaiTFFCZYB/bsVwCCEW6eldm
X-Gm-Message-State: AOJu0YzOPrnKpvTDeHhoBY34/BNaonVcsrm/0GmR8ObfvmP3A8tlITu2
	ASjQFiZna8q+WyVc6iDGms43SK9remFGme7tf6cjwAHdMQV0pVw2fIcDD+ximE0nm4LOaRWZjW7
	zaUvFyt9XRMJyecCIa6pYdEi/zX7/p4+AuoYh
X-Google-Smtp-Source: AGHT+IFO1B9IKuJmld6CI08Ya0tKjIv3lJtczKbSDX0N2JwNY2c61ZihcvIyJjzEdJNJPBAOOLzbHD5rqo38xBooowM=
X-Received: by 2002:a05:6402:35c7:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b740c8fc80mr42319a12.7.1722495510070; Wed, 31 Jul 2024
 23:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com> <20240731120955.23542-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240731120955.23542-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:58:18 +0200
Message-ID: <CANn89iJasXPw-k_xHRAc3uFBtbovCd0QkVBPERCzKDOTk0cM3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_TIMEOUT for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Whether user sets TCP_USER_TIMEOUT option or not, when we find there
> is no left chance to proceed, we will send an RST to the other side.
>

Not sure why you mention TCP_USER_TIMEOUT here.

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/CAL+tcoB-12pUS0adK8M_=3DC97aXewYYmDA6rJ=
KLXvAXEHvEsWjA@mail.gmail.com/
> 1. correct the comment and changelog
> ---
>  include/net/rstreason.h | 8 ++++++++
>  net/ipv4/tcp_timer.c    | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> index bbf20d0bbde7..739ad1db4212 100644
> --- a/include/net/rstreason.h
> +++ b/include/net/rstreason.h
> @@ -21,6 +21,7 @@
>         FN(TCP_ABORT_ON_LINGER)         \
>         FN(TCP_ABORT_ON_MEMORY)         \
>         FN(TCP_STATE)                   \
> +       FN(TCP_TIMEOUT)                 \
>         FN(MPTCP_RST_EUNSPEC)           \
>         FN(MPTCP_RST_EMPTCP)            \
>         FN(MPTCP_RST_ERESOURCE)         \
> @@ -108,6 +109,13 @@ enum sk_rst_reason {
>          * Please see RFC 9293 for all possible reset conditions
>          */
>         SK_RST_REASON_TCP_STATE,
> +       /**
> +        * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
> +        * Whether user sets TCP_USER_TIMEOUT options or not, when we
> +        * have already run out of all the chances, we have to reset the
> +        * connection
> +        */
> +       SK_RST_REASON_TCP_TIMEOUT,
>
>         /* Copy from include/uapi/linux/mptcp.h.
>          * These reset fields will not be changed since they adhere to
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3910f6d8614e..bd403300e4c4 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -807,7 +807,7 @@ static void tcp_keepalive_timer (struct timer_list *t=
)
>                     (user_timeout =3D=3D 0 &&
>                     icsk->icsk_probes_out >=3D keepalive_probes(tp))) {
>                         tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED=
);
> +                                             SK_RST_REASON_TCP_TIMEOUT);
>                         tcp_write_err(sk);
>                         goto out;
>                 }
> --
> 2.37.3
>

This is more about keepalive really. You should use a better name
reflecting that it is a keepalive timeout.

