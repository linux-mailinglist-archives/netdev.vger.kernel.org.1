Return-Path: <netdev+bounces-217583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF4B391CE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FC37A1D0D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527325BF1B;
	Thu, 28 Aug 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT41DvCK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C723F40C
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349009; cv=none; b=Udmtdm7KrtUCjtfeGVrdMeFpqBWlaqE2ckZiJocCOc+hEuwVLOBE9npc/NCaYfypTipdJ7tYp+ClbZkxUMeZlDWbTELT7Qj8ypFQVqP9yLp7GrG2xt90ZtWj6UgznUzGGv4wlWFztQ8BVVcAdiZrGMwvOAfErf8wXW9qzmrro8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349009; c=relaxed/simple;
	bh=FtEPTa4Dy2lq8qJWWzsiBzS0C8SD7cKdkopMOEifno0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/Zzhf5XdG+Vpi37DGv7GO1DbSjT0OIjVW5yx6XKXtccB+aBkikxAxMI1kqqZBavK2Pqf09bQuHe28DGIwDrI1UQIUQupD8Ufio4fIm0VjCCqQa+87CpzFcjxQyXXwiO6wqNFfiiVZdLToXnq+afEpBP4E/IvmYG9kCrA8nhjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RT41DvCK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756349007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
	b=RT41DvCKVJ+5aj2CbX7npWxG5/ImZulpmQjulIfvC7NCsnYm7Wmrmu/oaKrtWy+tcF0+Rm
	TgpCFlMVgR5ca0XMzk2Qoo4cZEQ0hBtpHhKyES7sU9ZV9lpTGpYkZfZqFAMhlbcRy2l+09
	IWZ32jU8btXzWNTAh7YY4OHo4ZRR33A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-XVXP22SxPX65DMsg6zZTfQ-1; Wed, 27 Aug 2025 22:43:25 -0400
X-MC-Unique: XVXP22SxPX65DMsg6zZTfQ-1
X-Mimecast-MFC-AGG-ID: XVXP22SxPX65DMsg6zZTfQ_1756349004
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61cc801ac1cso305453a12.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349004; x=1756953804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
        b=fA5ppyD1qdtOCsC1445CXpluFcxJNvFlEzfBtWSfeTD+4RKX0Huw4VQU1alV+ca/8D
         70bFkfADojUjdK+Zj3vQafjE0jdyu9QNY+yHNRVYZPfz/P/lhqZZ0CTlsMcaea9ZeRyx
         ifcdqGbKe3NSCdpgoSb/dWb5Wvp61tAbV6H3PWkvsMmViBzwI+JAwM+WalKwrtJnhwos
         bihmpewLZRrkFQ6p+DJOOupgRog2KCBjg/AydvnBB2r8U9t8kKugQQuilh3qEqESBFrK
         ecFbAX4NZKstrWT8I+YAkgjoBF4nzyWeeQwewSYXaUPF79hrkGAzFjnP1gIH7Ak/ot2i
         oCNg==
X-Forwarded-Encrypted: i=1; AJvYcCURbALSWudacrBXjjtlmHXWyBUZtT3VcE1ouPzyNSNLIp4pCEPjC9jqN+Fy0Msg+f6KMr7pmhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lwE7V7Aj0CTwPVZ0XdDroQRg5SANmgG3KYAASw6Z1plR//IQ
	fybgOJsdZFj/WkrfjBH47zX+CxrixWjuWo5QKs/IPrJHzLncMPGAoaYWwLp37u/nw4LIdRl/eXJ
	59T7etbQK03Jm3tUjvrwJ+78a7wpw523ZqXBTqfiL7GbZTd7rmJnwjVHE4H7ciA4u88TFV7z/Va
	TWwtNyGCay7BWM2zedgzbAn0K4TSnPith6
X-Gm-Gg: ASbGnctiuqRrzhZqlIjSvIGVdBj6s2Xz5oxFq3Yc69fs+5SmaQP457pX2dSEXyo7HSr
	G02Atms+RUYWYXzmILF/4akQrEIxQyQDYbBbVcYJdnO274usq5+4eY34cJa/rargyBbBxbZo+ej
	zQn5g7tRdVcfwfV2QHPsZrdw==
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id 4fb4d7f45d1cf-61c1b70a459mr17263470a12.33.1756349004191;
        Wed, 27 Aug 2025 19:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLJP7RVQ7XggHy4wLklb0+/anyb2o4/+NcZbJ0ac7BY7NdvZ8eKkWZUKb7OLDIF0YQ0f0iZv5O0U1kANohzIg=
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id
 4fb4d7f45d1cf-61c1b70a459mr17263447a12.33.1756349003785; Wed, 27 Aug 2025
 19:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:42:47 +0800
X-Gm-Features: Ac12FXxm1PYVDZmD5Ru0N_nQlupVeshkDMt_GvrRtBisXzJaavMi349lmdLEkns
Message-ID: <CAPpAL=weN2kjgz4n8JtAPytHQi+828v2xUTHJ4Tr7GdTchk24w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches's v2 again with vhost-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Aug 28, 2025 at 4:11=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
>
> Sean,
>
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical=E2=80=A6
>
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>          * freeing it below.
>          */
>         wait_for_completion(&vtsk->exited);
> +       put_task_struct(vtsk->task);
>         kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
>                 return ERR_CAST(tsk);
>         }
>
> -       vtsk->task =3D tsk;
> +       vtsk->task =3D get_task_struct(tsk);
>         return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
>
> Sebastian
>


