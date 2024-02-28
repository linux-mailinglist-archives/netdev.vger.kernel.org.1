Return-Path: <netdev+bounces-75840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE61F86B51E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7842428C311
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520D1E4A8;
	Wed, 28 Feb 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LdkB87zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1006EF1E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138285; cv=none; b=Fcg9nDjuZ2O916utuurUack/NPnTC5QnExVXP2js/gB1h+NllyxnxozsyenhabgFVFptt2pLbxVk2hRglgDSMM1/CxgqPOgj3ItHs6hHYVe5vH3YzakBzW3auF/MBkcC0bK/81Gi4ILLGL+ZkQrN/aKSaaTLiaUj/CQvDRX8ogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138285; c=relaxed/simple;
	bh=9PTeAYYKh6BghzUQ5SY1FEoCFtAzge8LlEvtJa+/mwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+cYPMuC1yg6yBg/phcdbGOTR/2zXzwfdfmSa/NZiJzh0rTBLBVi+g64MjJ8nR7x+GtDNxxvxadiyAyUz0uxkTqbWPawwDrQnSTju3ngWMMzT18LO7mSzikxEN849XCI2UPS3NRKvyiI4LSKrMsdqU2vlVJq8g+tym7HCZxPKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LdkB87zd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so797923866b.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709138282; x=1709743082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAQpAUpfQCDhx0rGjR9Oel5LgwsLKY+ggnWMU654+8=;
        b=LdkB87zd/3Ey/TszPdJTjeBQW0CD8ooalvGxGuuwIAZDzqDmWaj0B/AU3vvPUzguME
         efMh/O1i1e4AdYTsJ3LCDduY7WErH+GOcYL3Ekt+sK6CmLuLTCFWegQfToCkq+bDYAjC
         ExlXDdy4kn7Lo124FUzyhxciy7Avg9lImGOpWtlvlk2DK1rWKQR+3x8FfYJHE1mWw477
         IjVO27AnTPrNXoYNbzQ0lKRhYwuSxcxok561LJwnPBBkVcNrAYGKF7vy11qiqQ56HaBN
         WD60dlG3pOb5Q0iKZKsxGKSXPkiwcJeiOVS1+KjFR/wXicr3DWprGwOJwMT5FsaH4iBW
         wFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138282; x=1709743082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWAQpAUpfQCDhx0rGjR9Oel5LgwsLKY+ggnWMU654+8=;
        b=SVvFDtGx/EWwqhFMVTxGwuoMKjmdRhwauFa2A0bZD6Mrery6LThpF37ZFPPdMuPc5V
         S1y5iml3i0DxV/AvBX7oAn8Eu6/m2DRQ71bgAM9jZEvJ2zimINyrQvxL5MqgScXTNrRF
         e0U2k5xMrRdts4ZOYFJN/xsfvdFQI3+yOBnoLR5JZGXfwWRPkGjDptqmSTdtquHe1DfL
         2j/3ejvrA2TnKI/jv3MlZ7b71ZnFzUhYuIgAru+fdIQc0Q06Z2NftIEku+dfJIL8ke0s
         gn7w8bWqw3xXNBZL0tsUklPdwFkyvRMOA/rBz/bqJjdIa/W/tPtlTsUZmA+XINGX/guG
         G0rg==
X-Forwarded-Encrypted: i=1; AJvYcCUHNBmP30Btq+t8Mh1RxcQ8yxS6K0Fw0HZeecHUYppjbDHg5V3rn5pukx+TYJNqsZYhAnYpMUCTJ1GP3Fa+MdruHKrmnhn1
X-Gm-Message-State: AOJu0YwxBuslu7Lo/07bHDGAJEXBgpULiL93mUZznUVNAIm060TBXEuj
	1OKHYjQ4kmQslBoOdTr3N6+L/tjEFzy01SX2QgrQC1lH/tC0SBFhdwrpE9hXRHi0eBj9Lc1jT9u
	1NpouMFBf638RwbML5iyH+qjgulWl4ZSvgnJFzw==
X-Google-Smtp-Source: AGHT+IH6HQq8hzqji91OJqqxN2VkP0/oD9hn7fSXzbwfcVbmFDthP3qt0d5uMMo2K+yS0zBkR2z5gsNJJobM1iVOpOM=
X-Received: by 2002:a17:906:e8f:b0:a43:49ca:2473 with SMTP id
 p15-20020a1709060e8f00b00a4349ca2473mr193121ejf.0.1709138282075; Wed, 28 Feb
 2024 08:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
In-Reply-To: <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 10:37:51 -0600
Message-ID: <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
> Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> (for documentation if anything) since the issue is Tasks RCU specific. Al=
so
> code comment above the rcu_softirq_qs() call about cond_resched() not tak=
ing
> care of Tasks RCU would be great!
>
Yes it's quite surprising to me that cond_resched does not help here,
I will include that comment. Raising just the task RCU QS seems
sufficient to the problem we encountered. But according to commit
d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt
when safe"), there might be additional threat factor in __do_softirq
that also applies to threaded poll.

Yan


> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> thanks,
>
>  - Joel
> [1]
> @@ -381,8 +553,10 @@ asmlinkage __visible void __softirq_entry __do_softi=
rq(void)
>                 pending >>=3D softirq_bit;
>         }
>
> -       if (__this_cpu_read(ksoftirqd) =3D=3D current)
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +           __this_cpu_read(ksoftirqd) =3D=3D current)
>                 rcu_softirq_qs();
> +
>         local_irq_disable();

