Return-Path: <netdev+bounces-89795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564788AB932
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 05:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6411F21A35
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7B8BEA;
	Sat, 20 Apr 2024 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XonLjuex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB48524A;
	Sat, 20 Apr 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583394; cv=none; b=GfvkHYjWcSqSwYA6nLZnf+QheSyuFOcAYCOUwerUEjU/KJkjaylSUitJO1Fbn9GjqJWX204asEtqpH/ojoF02b1PwLEGtfkR+DgI/48GgtX8QDAVvo9FozHZgGb79Rn92ju4X0c8Gj8iu4zS7PUVvqd36Ksrwew8a2wsVjNsu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583394; c=relaxed/simple;
	bh=efxe3LWT1F4DBpCl6IYwsNI5Ug5mdMiWXefSbL916ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQfXkaX82JEg5MYOwk4zW38aQthTay5jKgLjgiXYf1n9mlmJdB6S+CpdN8RMixLeowBLttCnNctqtba8Ngy4c3ap8+SmMB8n0Gfu0Q3Or3uR9HkBHgk4Y2h1tOqsMF1RQxFbMvqsjkqQ/8bk9XTNRZLsNQPp0wPsgbNiB2wnekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XonLjuex; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so3916084a12.2;
        Fri, 19 Apr 2024 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713583390; x=1714188190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpLu6IVjSlqb5TSshPffMpA3zpsaR9HFuHO2G5ymDPM=;
        b=XonLjuexn8EWSbS5hUO9qqY+TxWiWKf4b043/+pupK49almx28o9lZARahbuqxR+4c
         GjiC15N+DtIKGp5F7P4QVlJnq6NzmSnj8IqrroXggJny+LstHXHelBZId9jqD1+sJlFi
         xJqPY6X688XIc0zxd+6rbV6Ei6AYsc6Q88yDyekmDNqhTFnZlHiYdiX5/Z53RWcw3IgH
         v0iBILfX0vcVuThEASIahUtCM2NdMtxyVFK6GG7yo/UEDHMYSev+XoaM98/Hhb61aqNL
         KxmoOHmsctbwLA20boUzI/ndnmTBz4dVw1kKgNK3aZy6BD0GJoc4hwOKqHEGeBsQ6iJJ
         +kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713583390; x=1714188190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLu6IVjSlqb5TSshPffMpA3zpsaR9HFuHO2G5ymDPM=;
        b=vn0Z5R67dLLu7H8dVVWBsdl+Y7ywZ9P6DJAV3G3wpjjzk/mPave9Qj9OlcJm7fXJfd
         6fqhvALmqIrDs3tzExysntOEGNebdDYkFYXcD0sr1ujMV4WwAmzc2UegqGhkkRNB9N5q
         2eZhbDWsT4hlYnV3ia9LeV2ZFIcoGi1Ts7VLmn+ROG0txN6cc8p56BUE3MX8AAtm1lxI
         ngte43p3ia09fFrXvSpHPuJDV3ueV6DosoUoSrvoUA4RB4GQ50/BEXHZa3VCsb8ctQTz
         HKzCNTaa181e4TB/nFQk53RnmgBm32eHoPman+/lt8KJE1rrzvSXAu0vegTll/kEYSOI
         aNtw==
X-Forwarded-Encrypted: i=1; AJvYcCUM5GmqBuvkpkOJ5nPxj38QE4gzUP7cSgmkI4AbHK6HrD6L1l4kc3rmlQBKz0pH6iOMzieV3UNDbVqgftaOB6t7gU89S1lBNExZmRuko5wZxcwnMp8EPeBNJw1Ewgpq4C7RiniQ/obQKKNK
X-Gm-Message-State: AOJu0YzSnFNw8D8wtIhJ47C8yhILrNqvc5FFQeHlV0Hw5S/MkdC2zy/a
	WsyfrDW3s6hPxi4BsDyzMFjIZRIvyAlZNf2Z0nUC1Ex7B+rJ7qnoZ+zTqrfWE/NF1QnTbHOP3yo
	rE/of0W1wMR8HVrK+oj0cSBH+kjo=
X-Google-Smtp-Source: AGHT+IHPmY1syujhBD4xStYQPROXKUhZWyW6X0fVqqUaltqcDWT552yWFmDdwt+9n9NNErHbE+ctL8JdG2V4VRpEbdM=
X-Received: by 2002:a17:906:5856:b0:a55:5fb4:824f with SMTP id
 h22-20020a170906585600b00a555fb4824fmr3525634ejs.45.1713583389615; Fri, 19
 Apr 2024 20:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
 <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
 <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com>
 <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com> <20240419223553.49cb0628@rorschach.local.home>
In-Reply-To: <20240419223553.49cb0628@rorschach.local.home>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 20 Apr 2024 11:22:32 +0800
Message-ID: <CAL+tcoBS1pAp-1sKE8V9CHEXqwme2-eRvwJtL150mGqmD+7hpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steven,

On Sat, Apr 20, 2024 at 10:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 19 Apr 2024 16:00:20 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > If other experts see this thread, please help me. I would appreciate
> > it. I have strong interests and feel strong responsibility to
> > implement something like this patch series. It can be very useful!!
>
> I'm not a networking expert, but as I'm Cc'd and this is about tracing,
> I'll jump in to see if I can help. Honestly, reading the thread, it
> appears that you and Eric are talking past each other.
>
> I believe Eric is concerned about losing the value of the enum. Enums
> are types, and if you typecast them to another type, they lose the
> previous type, and all the safety that goes with it.

Ah, I see. Possible lost value in another enum could cause a problem.

>
> Now, I do not really understand the problem trying to be solved here. I
> understand how TCP works but I never looked into the implementation of
> MPTCP.
>
> You added this:
>
> +static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
> +{
> +       return reason +=3D RST_REASON_START;
> +}
>
> And used it for places like this:
>
> @@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason;
> +
> +               reason =3D convert_mptcp_reason(mpext->reset_reason);
> +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>
> As I don't know this code or how MPTCP works, I do not understand the
> above. It use to pass to send_reset() SK_RST_REASON_NOT_SPECIFIED. But
> now it takes a "reset_reason" calls the "convert_mptcp_reason()" to get
> back a enum value.
>
> If you are mapping the reset_reason to enum sk_rst_reason, why not do
> it via a real conversion instead of this fragile arithmetic between the t=
wo
> values?
>
> static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
> {
>         switch(reason) {
>         case 0: return SK_RST_REASON_MPTCP_RST_EUNSPEC;
>         case 1: return SK_RST_REASON_MPTCP_RST_EMPTCP;
>         case 2: return SK_RST_REASON_MPTCP_RST_ERESOURCE;
>         [..]
>         default: return SK_RST_REASON_MAX; // or some other error value
>         ]
> }

This code snippet looks much better than mine.

>
> I'm not sure if this is any better, but it's not doing any casting and
> it's easier to understand. It's a simple mapping between the reason and
> the enum and there's no inherit dependency between the values. Could
> possibly create enums for the reason numbers and replace the hard coded
> values with them.

Right.

I also need to handle many drop reasons cases like what you do. Due to
too many of them, I will try the key-value map instead of switch-case
and then see if it works.

>
> That way that helper function is at least doing a real conversion of
> one type to another.
>
> But like I said from the beginning. I don't understand the details here
> and have not spent the time to dig deeper. I just read the thread and I
> agree with Eric that the arithmetic conversion of reason to an enum
> looks fragile at best and buggy at worst.

Thanks so much for your help, which I didn't even imagine.

Sure, after one night of investigation, I figured it out. I will drop
enum casts without any doubt as Eric and you suggested. But I believe
a new enum is needed, grouping various reasons together which help
ftrace print the valid string to userspace.

Thanks,
Jason

>
> -- Steve

