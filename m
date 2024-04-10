Return-Path: <netdev+bounces-86568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2027F89F335
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42D81F2AD18
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083915DBB7;
	Wed, 10 Apr 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxxlOr66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94E15B546;
	Wed, 10 Apr 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753732; cv=none; b=WlRe6AOR17zUnKZZDyj4SCQMBXA13Rc66rOlk65F3+TfgTZ2BYSkVH9mxnkAoIi97G2owyhsdE5/ySv5NrLx0yOag/DW53Z4UNpH+KKugzxmL9KnXcCR2ekSzUNRjwvQQNzRHGw5w+o1ottpyuMWoLe/QKKBY5vudYd4gn03ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753732; c=relaxed/simple;
	bh=u75iZbm7Pfh67KXT9acAaihcf6va24NSr1ILm59Pdek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAc/S3DZj2fswM0GNVoWOMH9Wzyxu6z6lF1rEsjv69+25a2obCMZr25VOhSPMyTfZngZ8Sd2bNO9njP0nOyJzIvXPVciYc/ANZhS3VEsPIMCmTapkX0UdL37lV1euRmCp9u3bV60notl2Dr5CuzxiA/qqKP6eidi/WQJ6hcTIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxxlOr66; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso7142882a12.3;
        Wed, 10 Apr 2024 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712753729; x=1713358529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1tBPyZzIM9HvWCWytDTb+G73q44vzb5qtNl+V3kOlM=;
        b=MxxlOr66gQkLiUELENaNiZeUcBy0jqwDE3Xu+3qeMphgyEnmO9C+A8emgeJ7PRbO8a
         kTv0Four8ZB49DQdRo8ek5R/qeKM//TwuuxZL06v+VonXEi18+4mgDfCFulkZbZePVaz
         LuoXB9cvElb+1R6Y8mFpJZTOrnR9uK1CJegCcWJA17M5B33yBHJ5cDjGQ9wGjDiTgPui
         admQ0suXdeo2WZUub33WaWsRsOp8Gvwz7BIWp2xTERIZY7b5b/f6Raife4eigeuDhuiT
         O8y5yffUoPCFD+feMw2bjMj0yC9TVmjkV4LIHXCy42NtzN1HFzMWaOnacn3bYSQ2uBi2
         23pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753729; x=1713358529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1tBPyZzIM9HvWCWytDTb+G73q44vzb5qtNl+V3kOlM=;
        b=oEuzy+hF0ReAPm0X3zR3yZ7AtQdPZghX1bd9KL62UscPt358iZ+myLk+FcK+DUOGm5
         aVrqiO79NrIwwljwW1FHtQbzCPIFR6VRpAX1bgSBLYZiJ3WuECRG82YH9V1Q342eDeTg
         jwZszbVCHRBLsgksnYae3aGD9yRNCPJ8R/K2yX0A4g659qaTSDdRAHHkCxDp7O1xW3Qc
         MAcofw7wB4Y+D/j2QxUiaEqxNVXmnfvENwzFzSlTkZi9sabOWZSIVyVz0YfLHLamvJoy
         aYB/m8yJK+HlphencNjTfU9b/ZeoFS2Wmy+TXobRn8J+o2LtOtqFe4AJQbkW2ebKf5JX
         Z2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX4wuGl7Xc0S367N4BPltqV2chjnFuF6mpCnnt4rWPi6R/cMATlHz3kOgOJVxpsWNje2wPk7MK7fr7Iz+vjtQzpufoIk3fP4l5THs7pcMPL2UCntNMxDRKcV8H+N+RFSWb9LoeaqEY9HhoU
X-Gm-Message-State: AOJu0YwSbktOeJZOkua8wtPqdCM3BdP0NbFH1uQPIYb8rbGeDeSjYlox
	Z5JR1EzsJldtWpAwFK2IL2fdp1XZmgynfdbeqO2AsGxQ415Mv2xoZpf46jkuC+AFlg73lSR9yl6
	OqHmYmvq4oMa7Jgj876mLxGjf+Ak=
X-Google-Smtp-Source: AGHT+IEFGpK8dqlN0pLAXdaZjXeCc2d/m+u1J6Gp1y5AFwBfa42NzVG00TVcLeHTO9U1W0RhT00vHwjKoItzUtjvEQk=
X-Received: by 2002:a17:907:60cb:b0:a51:ce36:1534 with SMTP id
 hv11-20020a17090760cb00b00a51ce361534mr2440092ejc.48.1712753728518; Wed, 10
 Apr 2024 05:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
 <20240409100934.37725-3-kerneljasonxing@gmail.com> <171275126085.4303.2994301700079496197@kwain>
In-Reply-To: <171275126085.4303.2994301700079496197@kwain>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 20:54:51 +0800
Message-ID: <CAL+tcoCk_RTp6EBiRQ96nrdN7cuY1z+zxzxepyar4nXEJkAB9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] rstreason: prepare for passive reset
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	geliang@kernel.org, kuba@kernel.org, martineau@kernel.org, 
	mathieu.desnoyers@efficios.com, matttbe@kernel.org, mhiramat@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mptcp@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

On Wed, Apr 10, 2024 at 8:14=E2=80=AFPM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> Quoting Jason Xing (2024-04-09 12:09:30)
> >         void            (*send_reset)(const struct sock *sk,
> > -                                     struct sk_buff *skb);
> > +                                     struct sk_buff *skb,
> > +                                     int reason);
>
> I get that 'int' is used instead of 'enum sk_rst_reason' to allow
> passing drop reasons too without casting, but that makes understanding

Yes!

> what should be 'reason' harder. Eg. when looking at the code or when
> using BTF (to then install debugging probes with BPF) this is not
> obvious.

Only one number if we want to extract the reason with BPF, right? I
haven't tried it.

>
> A similar approach could be done as the one used for drop reasons: enum
> skb_drop_reason is used for parameters (eg. kfree_skb_reason) but other
> valid values (subsystem drop reasons) can be used too if casted (to
> u32). We could use 'enum sk_rst_reason' and cast the other values. WDYT?

I have been haunted by this 'issue' for a long time...

Are you suggesting doing so as below for readability:
1) replace the reason parameter in all the related functions (like
.send_reset(), tcp_v4_send_reset(), etc) by using 'enum sk_rst_reason'
type?
2) in patch [4/6], when it needs to pass the specific reason in those
functions, we can cast it to 'enum sk_rst_reason'?

One modification I just made based on this patchset if I understand correct=
ly:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4889fccbf754..e0419b8496b5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -725,7 +725,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock
*sk, struct sk_buff *skb,
  */

 static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
-                             int reason)
+                             enum sk_rst_reason reason)
 {
        const struct tcphdr *th =3D tcp_hdr(skb);
        struct {
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *sk=
b)
        return 0;

 reset:
-       tcp_v4_send_reset(rsk, skb, reason);
+       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
 discard:
        kfree_skb_reason(skb, reason);
        /* Be careful here. If this function gets more complicated and

It, indeed, looks better (clean and clear) :)

So I also ought to adjust the trace_tcp_send_reset part...

Thanks,
Jason

