Return-Path: <netdev+bounces-203504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE5AF62CE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC0816EA66
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47272E49B6;
	Wed,  2 Jul 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="YQtzHWoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088462E49B5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485310; cv=none; b=SZQjSryW/IBQ61AiJfM1MpXIiG1Dx++aApy+w53w3EmNPnwTxvn5AHcWAY1rX22X1AyY5sbKQGDWsqqPgAKyGWQMqCR8UOwMvRuDZyJdCP5Ci3tllb1fiHRVC1IUCTM8LLfbghgPqU5R8FTOPaPN9nU7OWXhfwnNkRsIthxuVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485310; c=relaxed/simple;
	bh=pZWrtrY0nG7qhXB3qX6tkXSS8t9NczwEaPha2NGjIQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsR7WO2usbcx7KztOJKHQ/eupDJiCMg5VQpXVkc4cg9Jauj9hW2e4ukBrqwYJwuVAvQkFfnVtY42CtiDuY0KWV7CRz5CG0lfv+y3OQDcivgsJ7ypBQKqNSndeyyNCPzBEwoCCTFu0LGX8rJBVWEccpkJsPoiRk2By3ZBuZDHtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=YQtzHWoS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a752944794so82206591cf.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751485307; x=1752090107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+vyhTq2LEfbBNIgQqmT2inGEjwxm0OvRTOtkRosSwI=;
        b=YQtzHWoStcqDkK7lN0h+p8fDg0jHlKEtIk/HvFqN5jgnWyRiEjsalxWeTa5L29v3am
         wHZLtOdO/CJYP8nhSdP4DvXDWqiE/uHrEhkiBt6KrqiFtADvvzcEMYO0Xzc1THkhXyrB
         YO8t88CNLNKHNsPD1ASKh4Y54S9ZMG3TfqSpZdi/0t4OKJwxAf3pkdxKjfAK/icbslzb
         ZQPBYLZQDWb/LSQqbX87watoJ5cynA8BKT0wVyFWPT8GKAAGntrLxZh6mOd/lbJQ8l7R
         d8r3DSkoI3e1XA1qFldDS4CLWPGDlQ+QqaAonw03VLGqVh9FoyJYobeTDe4fvP+Tu0NF
         jmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751485307; x=1752090107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+vyhTq2LEfbBNIgQqmT2inGEjwxm0OvRTOtkRosSwI=;
        b=UyfvQY6kU6fdMJhDw9luVMMs/iLwC88RlVsukF7VKe9d7Zqdvb6hdyf+L2/3jeIBHL
         0JNzvXH7UPTJzdXk9h51FfjjY+kQfXMVjNxkhvZu4aOlguBqgDL4uKjejD5OrnB9KhsT
         yYGYX/EThm9ph24tyMW9iC1zWxPo1vU6YY6OmWMGSd9EZf/9NmoBSapRFjxtOmLWNYQ9
         0itoR/6JElz9CQPofrG8JsUzIeT5cEjJvevBRGmzbslG+/iT7IEwUf1E6Z3B2PtBgC85
         VuZGxQ2L7cwwUl4rDTC6hJmGsCWZk13L/Jeo2AzNQGzNlQMtA8Ob8vY44u+7NXW6N+y8
         qq7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0Fy7WY3pXGWAz/NSPRkCs2PHc41p3woBd7CCwn/ZREIOG8tKPP4D71IlOYxfowRlHUSCNOms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8a/v7GeDfNXV55k/U5Dl8GJXorDQ6OZ/8PLiuZMfRih19xdZ
	X9TKwQsr4I54jfaWDaK0v7NSuoOfPfrS1424EabxUD8OxFE/vO7WzqNw/IwNFeUGL0Og8UbXtv1
	ssmwiewdkJr6qtpHZRGQXaFpzCBDWuzGIY7CVeflI
X-Gm-Gg: ASbGncv0y/otCie9dUGnXS8ocE+Kfp9zVLCrc9obUKPuHz9UorePPhrFTjCNEUaRZqg
	79VeyL5qlHZl2Lhr/PEIFgiY9i3NbTFgLC7w+fDvqA/W/O20sR1pU/qMzPl9ld4UBJerlw5VAWL
	PXvim5hecKwiTKBH8EiYf1nh2PbkG6vy445uSzNF3EfTMCrw==
X-Google-Smtp-Source: AGHT+IEG6/6QDTTTUX9US++k/ocgeTgnYalPtX/Mcm2rQVy4GchItpue7vIDALQNfC1Rqb/FqvapnH1C9M6Kq1lqHnA=
X-Received: by 2002:a05:622a:5509:b0:4a7:bd8:4951 with SMTP id
 d75a77b69052e-4a97692ac5dmr64663481cf.7.1751485307523; Wed, 02 Jul 2025
 12:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
 <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
 <aGIAbGB1VAX-M8LQ@xps> <CAM0EoMnBoCpc7hnK_tghXNMWy+r7nKPGSsKrJiHoQo=G8F6k=A@mail.gmail.com>
 <CAPpSM+SSyCgM6aaPwceBQk9FukDd7yRVmHwvGYJMKpzd+quUaA@mail.gmail.com> <aGMZL+dIGdutt3Bf@pop-os.localdomain>
In-Reply-To: <aGMZL+dIGdutt3Bf@pop-os.localdomain>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 2 Jul 2025 12:41:36 -0700
X-Gm-Features: Ac12FXyz5Ws9DEsRC2avkDNkVqv-OnJ2EJGdW6gRasuaCh9INyTn0zYQmKH2maI
Message-ID: <CAPpSM+QvO8LYVfSNDGesu4CUP0dBY+bumkxfbbuBQhYgddFaoQ@mail.gmail.com>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, security@kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:09=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> Hi Xiang,
>
> On Mon, Jun 30, 2025 at 11:49:02AM -0700, Xiang Mei wrote:
> > Thank you very much for your time. We've re-tested the PoC and
> > confirmed it works on the latest kernels (6.12.35, 6.6.95, and
> > 6.16-rc4).
> >
> > To help with reproduction, here are a few notes that might be useful:
> > 1. The QFQ scheduler needs to be compiled into the kernel:
> >     $ scripts/config --enable CONFIG_NET_SCHED
> >     $ scripts/config --enable CONFIG_NET_SCH_QFQ
> > 2. Since this is a race condition, the test environment should have at
> > least two cores (e.g., -smp cores=3D2 for QEMU).
> > 3. The PoC was compiled using: `gcc ./poc.c -o ./poc  -w --static`
> > 4. Before running the PoC, please check that the network interface
> > "lo" is in the "up" state.
> >
> > Appreciate your feedback and patience.
>
> Thanks for your detailed report and efforts on reproducing it on the
> latest kernel.
>
> I think we may have a bigger problem here, the sch_tree_lock() is to lock
> the datapath, I doubt we really need to use sch_tree_lock() for
> qfq->agg. _If_ it is only for control path, using RTNL lock + RCU lock
> should be sufficient. We need a deeper review on the locking there.

My experience focused on vulnerability exploitation, and I am very new
to RCU. I have some questions about the possible RCU solution to this
vulnerability:

qfq->agg is used in both data path (qfq_change_agg was called in
qfq_enqueue) and control path, which is not protected by RTNL lock.
Does that mean we should use rcu_dereference_bh instead of
rcu_dereference_rtnl or rcu_dereference?


>
> Regards,
> Cong

