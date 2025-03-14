Return-Path: <netdev+bounces-174856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3BA610AD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139AD3ACC15
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5781FDA76;
	Fri, 14 Mar 2025 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAGTiHsp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1642AA6
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954355; cv=none; b=sCrtR+WDgdcL/AJpxGw4dBo/RK+1CMMV1yr5rVOE16rP/NlK0+3ybe8oEhx7Q2876UzykbE3HTDIkbFloGimsJ+2ixO0YjtMan/wWnGHJ3QWxNqSXgsNfFpH7MZiVA3vRHuc9m4hxblcImbACqGDtpnLByJ3wRlzYWuZ3V8Cel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954355; c=relaxed/simple;
	bh=oyXLZj54LtlQ4MGhnb2WIDH2KSeJ1AZFFTQTKY/k6Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDpJ+hnxEMpodGOXBXMFkig6kGqTLtwqMKKANP3Kfu2u3NgvfvnCgq/CYBFMpKLVtG+S2ZsDIvu+PvFVGd2uOkAWzeqrYktaOS5fmLyXP6aumJdzgRYKUKRWupfGq9S0UhBm5awhOlgHNfPhN/lbyj48c9FLHSP8AcuLZw+874M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAGTiHsp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTDZeaw56VIBY+bEWJ8m5Ut0VG1D9nOF2jWYVpTaHVM=;
	b=FAGTiHspwyFmpeg3kr9Eo3XvijITw3WW8Y0HYeZi+iWpu/qG20qW9WWxsg89kWhbyuKgES
	boRsUK5rFbq+fjTVrsYI5K991JvysTvOEbwoLZTLLXTKFiaXbhMqtjMKQ1iVJGGforwP1f
	kqzCKMTPmBfQ4+AYnyLTHditlwYhcsY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Esr3GM2QP1aJWAda2H9YOQ-1; Fri, 14 Mar 2025 08:12:32 -0400
X-MC-Unique: Esr3GM2QP1aJWAda2H9YOQ-1
X-Mimecast-MFC-AGG-ID: Esr3GM2QP1aJWAda2H9YOQ_1741954351
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so3592904a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 05:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954351; x=1742559151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTDZeaw56VIBY+bEWJ8m5Ut0VG1D9nOF2jWYVpTaHVM=;
        b=JVqeo8YH+XypfqrbUj3KNqEoB+ffbRKwTk75T0yFJFh/dY4OlgLpLXnzowOU+juh97
         AvzoyRv+G+zn7hDUA7fle7dSBosYibcd/IFvhcO/yR2UsERahn2FbeSeqqonuhL8L2OT
         8k2NpWozKFkt4SyLktiklRxi4tygH6dPuOzLg4Sc1tet6RYDTqAF2D30SkrACB8KrfCv
         IBpCMaKBrf4QqYPvyyp0cdrDOveyqkBj3Hq+hOTtHKjDAntKl/SGxSk2hn+ki7bfVraY
         hOCrN8+mR3YH69ez2rJPdL1eEyvmjImwhAKo5dY8P/eh+/JWeT0KPNuNqLU5Q5b7avTK
         /gzg==
X-Forwarded-Encrypted: i=1; AJvYcCW862KEjdB1MtU036ok3INO1ZLCxU5Rivl2eKOKycMDSgDMfBtvhSSrYXxWZXf1vDgIKqG9CN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhR3GjK43hdy66ER63gwXU6oWX42ATtpk8qnlob4tXZNysW2Dw
	Nruqe3TA6rOJloMQlqaKH2UanYuMYf1ys34+8URrwrDRL2/rWy19ZGwGqsyBTHLs3DWnapGuo7u
	9MAWyZWdWjGGDjigka8I1E+1uOhw9hofdJLskF1/n7EWOzne2cJg/ZoeAQK/SQF4to/CsMEQnDd
	2CC3aS1DUIq6kC1czSZLVkWNLKjAUm
X-Gm-Gg: ASbGncsYAcKEqHjc6trAXLmGr+xcKWgMUsY1QjzzKhylL5VnOb+n9+wPxIBH0wEdaCd
	iV1t1/o9RdCcK/93rncklNxrFDNDI21ujr87K99gV7hUB/bJtWlzTIQDc6eOHWjaaFcNnCZ3R
X-Received: by 2002:a17:90b:1f8d:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-30151c7a361mr3127185a91.13.1741954351248;
        Fri, 14 Mar 2025 05:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSnl0DK330+iYxumrpeH9uLx3TdPoT2bdl13R1/PQEAjWq9XZqWeit0LjaMAZw3sh9KdYE58oYwshB2exonS4=
X-Received: by 2002:a17:90b:1f8d:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-30151c7a361mr3127166a91.13.1741954350985; Fri, 14 Mar 2025
 05:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205094818.I-Jl44AK@linutronix.de> <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de> <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de> <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de> <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de> <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
 <20250220113857.ZGo_j1eC@linutronix.de>
In-Reply-To: <20250220113857.ZGo_j1eC@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 14 Mar 2025 09:12:20 -0300
X-Gm-Features: AQ5f1JoYrKjuf-swh1L4bBwmMxYWoNIB57J4PFNL4X9qlWDh80egegT4FKA54Hc
Message-ID: <CAAq0SUkMXDaSvDRELYQn9+Pk-kBjx2BWc7ucme54XPXD97_kkg@mail.gmail.com>
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, 
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:39=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-02-20 08:35:17 [-0300], Wander Lairson Costa wrote:
> > > You confirmed that it works, right?
> > >
> >
> > Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, yes.
>
> I mean just request_threaded_irq() as suggested in
>         https://lore.kernel.org/all/20250206115914.VfzGTwD8@linutronix.de=
/
>

I forgot to answer, sorry. The answer is yes.

> Sebastian
>


