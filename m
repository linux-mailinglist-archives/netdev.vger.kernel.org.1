Return-Path: <netdev+bounces-211503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69249B19CBB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8043A1C85
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E09239570;
	Mon,  4 Aug 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkP0Dtco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285CA233149
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293006; cv=none; b=mM+2cgEP1tMb4MwSreFe0bluntV7k6i8IGyqT6d3grDLpIM172U6JA+xT0uqaQwXECvoZsloS575u0dY58QEZDPr2rSDASpO90KEFu9HmuA+IdFep0qONrfjJs4Nl/WbEslLPoSXFxWqHMnPa+oKKV9qUBVb/126zfytxjqyLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293006; c=relaxed/simple;
	bh=3Y/eNwvB5ILZs5E+ocvhqUEyyEQJUHJ6l9mncbf4LIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwehl6TJ4V90K8ORcfnJxxWxT2EuFXa9fY/7fXLodVuQci0S4YSgUhnLT9ZwFO9lASE8wWG6hJJD8hqPVZoEAS2oRKnkSH3Xm2p4c1fxzGCIcmIMhZn+dli2Wod7BRfS2scIIUz9l7NdzYzb6vY5uheNC6V9mXUkb1re1W5Yg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkP0Dtco; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aeea63110eso46250771cf.3
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754293004; x=1754897804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ooJeoXgiNxmCjKQ3/NUiLCRPH/OBbBVxn1XceNIw4=;
        b=ZkP0DtcoYh1P8PbnTMyMX0Q8+0LOlef8AEExV4/dg3Zksf40SjgYRrpzHtxZXLyBpS
         T8IeDlXHzQMvJFFLemPR8uwHeW645zbeRqQ+eij8bc9HwD72X+7husFaCmfXgcrceoXV
         Pld3axTxYphauAejdBDxPY74LBI9To6D62pUbyz7w/vjhm6Sd9b1BxuuhDGqKswcGuaS
         H7Ifny/E1ohqUBQPo1CLKWhY41QvLxENuUfGCaImKn4L/R8Lj1d5bTVa4vPrgGfwdIm0
         X34wH39RM0N82ycBp1R2t2DO6HCGuQSglJWxK/ZFznl8/cij+1WAAqCPXERPG17uLlxU
         4nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293004; x=1754897804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ooJeoXgiNxmCjKQ3/NUiLCRPH/OBbBVxn1XceNIw4=;
        b=J2mMSDRwPOJxsQEzkTAHczj3VkwLd3QpfHRSA484IVpHq4jWXchQc8+2zCOWXoAZsH
         Tma1qsdPZ7pAGIUUHqcblwfm3JJPSofkCiu8DT83xkj3J2wnAo+bH4OsFTnl2YtWrZa8
         jeny3j9/jXy5l4y4+IKJ4Yha8Irbim8/5TXYn/YfuBsfpeYN8ud1RMr5vADLUsFz0JQR
         BrgIg8170ms0T1/kzQ1ePU8XtV9eWD7vI2YBJvXPNzsk7tYzJ5F/ojSq6cgkDE9Psc4v
         Yhac0szPmWUHxUSWQsQ5pfcSYCmbFWfi58DFSaqc2onb08len0H5iVVwJGpvj0P9NkEi
         awHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuVQpNLiOtEPpVNcj1TSya1kTCq4I/29f6hoVzuWDaloStV43vpZdtugis0ZPOCBjbYY5GUDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatzxlKNeEoqbypfkUneb1Uut6mfd6wbVDtxk/idY5MKwdHP4S
	sPAS/xEbM44r8iVXKiJo11QXRzpjLGkZK+7jOx3rIMtHuHN5j+0jfxcB2HF19IJYs4zu/CX6fEy
	yEbVwROh6VOndOESgm2oa+KRBcxYwz2VR9smseeWB
X-Gm-Gg: ASbGncufRjOKhJFzCPJ2Zxe5BxZer9f/UQ57G68oRLnzBKkG2fksK1/ka8yBpZhPJ1p
	5f3P5gMwb7Ay0hUx6Fmtc2+BP4KEKPUbXReYYH7pIodr6ww+xXm48icOWIiISmOacaZYF/82R/B
	6dn6pq+KyFdmZGZ97XAt7dvHwL1VQdLdwWvS+5hd5fYXdnftiWql9FADyNoOhzmG+jdCLVsvql3
	EBkdbeid1mX66I=
X-Google-Smtp-Source: AGHT+IEoCUer5WNytH9wVW03O++C/FNr5V/5RS20GrME6Uk6NXfcgbALruaSrPF23gegV0XuKZHBdOlmBgO2ep9Ykx8=
X-Received: by 2002:a05:622a:15c7:b0:4ab:c00c:250b with SMTP id
 d75a77b69052e-4af10cf33f6mr122336581cf.40.1754293002922; Mon, 04 Aug 2025
 00:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804062004.29617-1-dqfext@gmail.com>
In-Reply-To: <20250804062004.29617-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Aug 2025 00:36:31 -0700
X-Gm-Features: Ac12FXznjO0BdtnALtDt-VPl7bSJs2FnxBEs7TFJ8fwttr2To0hldVsXZK8iBas
Message-ID: <CANn89iJ3Lau_3W5bJdmRWL9BFUf3a40XqNgfjr7nCEu5PQ_otg@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 11:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> In struct channel, the upl lock is implemented using rwlock_t,
> protecting access to pch->ppp and pch->bridge.
>
> As previously discussed on the list, using rwlock in the network fast
> path is not recommended.
> This patch replaces the rwlock with a spinlock for writers, and uses RCU
> for readers.
>
> - pch->ppp and pch->bridge are now declared as __rcu pointers.
> - Readers use rcu_dereference_bh() under rcu_read_lock_bh().
> - Writers use spin_lock_bh() to update, followed by synchronize_rcu()
>   where required.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

....
For all your patch :

Since the spinlock is now only used from the control path in process
context, what is the reason you use _bh() suffix
blocking BH while holding it ?

Also, a mere rcu_read_lock() is enough for ppp_dev_name() and
ppp_unit_number() : No need to disable BH there.

> -       write_lock_bh(&pch->upl);
> -       ppp =3D pch->ppp;
> -       pch->ppp =3D NULL;
> -       write_unlock_bh(&pch->upl);
> +       spin_lock_bh(&pch->upl);
> +       ppp =3D rcu_replace_pointer(pch->ppp, NULL, lockdep_is_held(&pch-=
>upl));
> +       spin_unlock_bh(&pch->upl);
> +       synchronize_rcu();
> +
>         if (ppp) {

You probably could move the synchronize_rcu() here, there is no need
to call it if ppp is NULL

>                 /* remove it from the ppp unit's list */
>                 ppp_lock(ppp);
> --
> 2.43.0
>

