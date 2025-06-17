Return-Path: <netdev+bounces-198757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7FADDABE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC103B4B7A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE323AE84;
	Tue, 17 Jun 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKx39ld6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3820C497
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181752; cv=none; b=FmHNAdaL8uGyLtrkgMFRYuvPIXoX+XRq6k8S7vtLkhUMLGUuAb5apBRM62lb4cLXQQD0dURYqTiQBgP7FRNrOHxY3h2rJOccES5N/zw1EOxiKB2qrfN0/A9rH6qoCvV3y8A0980U1lsPEcbWfVVnrPMnhUJvwx+OWo84EgdBAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181752; c=relaxed/simple;
	bh=IxMZiGivgJcFKNyfPm4dRzReUn2WtW5awAEmS9HIx7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhZA/cRjlx2Rmu95gi5NYxybjQH2oKZhiaXiTBl54XFbT4Y52pRUJfXx4ipryEoorno5HhSwkWkM/THxN4wChXtdFlUscjq9cxnVLewwCHyiFA8TgTrrghYPpsJCN6CGR4Y+PtYPO37fdilc4PDClTWFEfwoL/UkVW5ComPHVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKx39ld6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a752944794so24333151cf.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750181750; x=1750786550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxMZiGivgJcFKNyfPm4dRzReUn2WtW5awAEmS9HIx7A=;
        b=BKx39ld6ASbl3/CLc5qng6j8aARxDIzctHcAMWdq+0aoewDVRzc5TeVYN2wUomQ9Bk
         lEiLbDGZmhi7tIBybfKJcXiLP9d6H0zoeSZ+w5xgOUpMcQNksym4dGdGnoKZGBnMDI/q
         K4YDotY4s+0WU19TVYapepBe2YrMICmqkwofuIjYXfLRXapaxzQ56vqW0MU5ISFG8iQw
         gnYOYnr1+vTHyziU54EdcrhnrNpC6a+A8UZ95cltAuwbzqR5HSebf5Qt9U97qzjvln3i
         YbPyFTElqyXcdF7hoek6iNSZDgfR/9D6qUiHNn29/L1TaMRTLPUjk8KQEbZHl7ZGlCtZ
         g+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181750; x=1750786550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxMZiGivgJcFKNyfPm4dRzReUn2WtW5awAEmS9HIx7A=;
        b=fCscici+/vbxjklRl0Dpn1l1Nhxnjw7m0uoYQ73CqO6ZfyBt2P8U00DKWv6ezWECMr
         Lywize1z5DDqGmHO8Oo9s4McdwcYmYiP5Aj2jxuP9wZfq+dBuH70rLvANp7lQW2cDKMp
         1hHeTjxKDhTRTst9CNjhbRiQVNryOE4X0hwJYiTn+JCBVZy+lb6K7pLec1w0eAafsjOr
         /N7x+fu+eq6jr8J6YHxByY3jiycB/enKnNGYDopqECraYHUwOKT6rE7gIyQHbkdScR1k
         /owr3r9gId387i6kTT4TbUXsxS1KfJiBBmP4OfjOYzTmkCC9JJR5BmPigH9y4ni3HqP/
         G71g==
X-Forwarded-Encrypted: i=1; AJvYcCVAT5gMT3qW8Eh5zFNxlo4/rUY9g4xE/S5CfzHMp3bs7K890P5uAakfKIcRrcqQFdprv0Ba4V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcOBHdYzqr090r9PTtGifwvsaxGUpj4ArHiv2kkD7muHWQjSZ
	ze463vxCKlhJNiKAeg0HY8XeT8zb4GDqs8LYjcfOzKhqROYvXRv9cVDZBBF9j20aYDrMNYDkHvF
	7SfeltlW8FCvxr8l80vWwsj7bcLTmULinKAcVgVE4
X-Gm-Gg: ASbGncsK0YSqMCusVq8gnJ9z9DKTq034p0JvpuXhtXj6L8HdVlyjgMAQ8yU6hPCci98
	WKDIuEBdEaYDLrw73rD4N22hJQrFV/rXBTzzCi+RitDqpB7lodKItK09EHJroF2e5mW+2qnQTQX
	13t87H+3O9YYPSce6akD+CJWdWZUSu3PBApjvx1dsRRKlMsCCiry+8R2s=
X-Google-Smtp-Source: AGHT+IEci5c9iAKbnuiaE8WHwP6fIysQji2cASuwElQo+GvwPwiaVd4EnWKsrOW156RvOHggsC4NqSU6M8P9p2gXSjo=
X-Received: by 2002:ac8:5a53:0:b0:477:4224:9607 with SMTP id
 d75a77b69052e-4a73c4bc9bfmr230930881cf.12.1750181749852; Tue, 17 Jun 2025
 10:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Jun 2025 10:35:38 -0700
X-Gm-Features: AX0GCFu2V9OmhB8zB52ChC7zYsM3DIqkBnmIytsLfmy5MNnMVd_vHdbpZpezEzs
Message-ID: <CANn89iLvbOP1Hnt7CtucWE5n6n72HhYBeTjNuTCqiY=AH_8DOA@mail.gmail.com>
Subject: Re: [PATCH v3] net/sched: fix use-after-free in taprio_dev_notifier
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vladimir.oltean@nxp.com, netdev@vger.kernel.org, 
	v4bel@theori.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:55=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> Since taprio=E2=80=99s taprio_dev_notifier() isn=E2=80=99t protected by a=
n
> RCU read-side critical section, a race with advance_sched()
> can lead to a use-after-free.
>
> Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
>
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMax=
SDU based on TC gate durations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

