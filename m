Return-Path: <netdev+bounces-225451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C03B93AD2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB3B442554
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923B3AC1C;
	Tue, 23 Sep 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5JQyqiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B83BB44
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586798; cv=none; b=h1V9qkz7v6Db8dgxyxqH6FEZb+2f7JUy1SfJlmuyRpuPfyXtqrMEl5rapFhqeu0l40zJyJD+2xwlQd8IYZVXmwb7i3Em/MfJo9UnrTmyxZteC4vwmkSNtzZ7fgGDOhKwtxjP9LVuM9yI6XRyVJhkY1gA/sLA3sgq3r7AfIISjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586798; c=relaxed/simple;
	bh=1ira6xP+Z27rEgX3oX8l1sLTEosp2DkSH8FvmwyagIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp9snXoXByxKL9AV924uVU47M61d/AgW/EaW8NkSBTrGx9aX6uOTJSDxl7ezo94DK92XjyxfhYLSvpltVldWOk07mJn+hnxNHfeHDVZKCZHH8Htn37j1tIOkakt99Q+3kOKkYIv2z8p/EjU3lkSWhd3GnZ6QhOs6XSUc9T9qopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5JQyqiB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso2204831a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758586795; x=1759191595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSoc3yJcOZ8hnPrBCbfWctLCQathqA/jVXmcWx6Lsqs=;
        b=v5JQyqiB0Daae+NioHhyHaqPclaCOxrh4AAbdAnlzxzjC2NY+Bz51IUXG3TjqCJJ7k
         Li4L2eO1ZkaqaBCWCzwhJYOFezt5M06LYb3FDdN8jV66rm74nRXk/9RELlUvpg5ub8PI
         UBysF1UrsiLkr/t9AInOWz58hklodTvlwgNbyxtUCuQ88ZjM/+BrBOzTjgmRiiT1cNmh
         YxITJK9ZBOAtnJHFhdq4piKfVmTjXS7/YMA2l7fDaEojkxZPt72WyTp4b6OaPJKTAkcD
         FYOf9k0WaC4z5QSwyCrQfhMqd+WethUvzXkihxUMpw7zqJY4K6efNP1S1iNM2zeY382J
         50yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758586795; x=1759191595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSoc3yJcOZ8hnPrBCbfWctLCQathqA/jVXmcWx6Lsqs=;
        b=cJ4nR4FQIHuYMUw2FqFfhJV2fvEMhN5KPXRS2Zu4c+Enflv/XJc1woroW9z2amGDR3
         0Lg05o5zy8hXIDQaRpWhPMsrwcpIM2okIoy4nzCY05b4tj2lmMwnsv7bSzYUcbbc3CyQ
         ThcrFXHsBse7rMQhmhQvP/c20QdPNjt2uQMXdQBYK5ZLB58JhU+bdEP1tljeXp16Zz68
         Ab1YwPbNRcGSY58UIHSOcR77H2WoeqgDqB15QQR4NIA8BYXpqqLh2vPuIyoseLDCuG9h
         uiSSO+YcKD4vNII2EsDCw+jMLL7h7uOAryBOgqNBudpAy0LPXQ3/BCJ2uQ8k+Vi3+71c
         Ipgw==
X-Forwarded-Encrypted: i=1; AJvYcCVMR3Z9uHuORD+Bye4B/fSwgcoHTViazCHNkBS7XIoQGIRuZ74EXRR4KufPLdKaXBQj9ucyAJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzphin7fdQPgrpAw/SqzQJegS1E0ERDFSdbxpkZzw3piRf9EufS
	91aXor4DqV73dCwSn27OafFWu7hQcTaHttcwlHMmN7v5gsKdwhaPDHpn0PhNANyEW3A6pVZzcbO
	NSNP475tQbpEWqYnRV7ZH8xP1anYg8ol/lJZfRlZl
X-Gm-Gg: ASbGnctmQA10vZXsp5KsPHxIUTtQ9raxR+XHGhLTFI7NFAr61mhtuqRvRLb65pr4FCD
	8QQMSYjwLj27u7x+ndresI2bZL2+HJ6q9ONK0UmRjF0dZtykBMxWENjJtXaZoy/gYJvFDyLL8KF
	IwCbMxtLA0WvCK3+uQAMvTyrvD2vxwExcRxNMirbDc7vDhAt/ARORVgwD1Ra5CmKGwAjMYkybAA
	cCmo29GVSXHbvArF2xQ3DsgqFtyIFSXuV1O/w==
X-Google-Smtp-Source: AGHT+IHF5ZoCBbgBKi1V3pjRiU9Nhu1YAzODcmozi+7yVPpL9Bc7ykOkH0C8pdBRc5GDrpkGpCSn8GRBfcTUXo7OPNY=
X-Received: by 2002:a17:90b:1c0e:b0:330:ba05:a799 with SMTP id
 98e67ed59e1d1-332a9534731mr877036a91.16.1758586795214; Mon, 22 Sep 2025
 17:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev> <20250920105945.538042-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20250920105945.538042-2-xuanqiang.luo@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:19:44 -0700
X-Gm-Features: AS18NWDFN_iH0A3uoHHOYrWNfwaSz5vih1oUuieRnSdPfbc3L9Z759PLwqEH6F4
Message-ID: <CAAVpQUD5LrDvt2ow_uGYvwqu4U+v0dOgTKZWAVfhf4eo7594bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:00=E2=80=AFAM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Add two functions to atomically replace RCU-protected hlist_nulls entries=
.
>
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as mentio=
ned in
> the patch below:
> efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for rculis=
t_nulls")
> 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist=
_nulls")
>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..d86331ce22c4 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -152,6 +152,58 @@ static inline void hlist_nulls_add_fake(struct hlist=
_nulls_node *n)
>         n->next =3D (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>  }
>
> +/**
> + * __hlist_nulls_replace_rcu - replace an old entry by a new one

nit: '__' is not needed as there is not no-'__' version.


> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals.
> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list.  However, it is perfectly legal to run concurrently with the _r=
cu
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *ol=
d,
> +                                            struct hlist_nulls_node *new=
)
> +{
> +       struct hlist_nulls_node *next =3D old->next;
> +
> +       WRITE_ONCE(new->next, next);
> +       WRITE_ONCE(new->pprev, old->pprev);
> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev,=
 new);
> +       if (!is_a_nulls(next))
> +               WRITE_ONCE(new->next->pprev, &new->next);
> +}
> +
> +/**
> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
> + * initialize the old
> + * @old: the element to be replaced
> + * @new: the new element to insert
> + *
> + * Description:
> + * Replace the old entry with the new one in a RCU-protected hlist_nulls=
, while
> + * permitting racing traversals, and reinitialize the old entry.
> + *
> + * Note: @old should be hashed.

nit: s/should/must/

> + *
> + * The caller must take whatever precautions are necessary (such as hold=
ing
> + * appropriate locks) to avoid racing with another list-mutation primiti=
ve, such
> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on th=
is same
> + * list. However, it is perfectly legal to run concurrently with the _rc=
u
> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
> + */
> +static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node =
*old,
> +                                               struct hlist_nulls_node *=
new)
> +{
> +       __hlist_nulls_replace_rcu(old, new);
> +       WRITE_ONCE(old->pprev, NULL);
> +}
> +
>  /**
>   * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>   * @tpos:      the type * to use as a loop cursor.
> --
> 2.25.1
>

