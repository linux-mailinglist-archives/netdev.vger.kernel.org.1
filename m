Return-Path: <netdev+bounces-202241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65FAECDF7
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DE17328B
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA362288F4;
	Sun, 29 Jun 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CKRcLhzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D149227EA1
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207305; cv=none; b=EgFtB0XvJlY9YFYOZZbXzEmht6kUr1XdTIvPajwlOQhyAB/G0itDDkPIZK0AfytbKcp9l+w9cy/bU93JSQ3puvRsasdoMdk/aZQDotZZ8qdBkss2Y7znvZR1DiM9WEc2QQl6zA1omyH2ZX0YewfTPQHD/BVLNHGHyVr7uQUWIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207305; c=relaxed/simple;
	bh=qbQYRVrIxzoUWISeDfgU1xEUhLxGDJoH4ZZTMLdMAMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/yLlxH1oUP1PsjSIn/ME7l5CbFLk3fKNREELNtry7vGpYKWbCpxk3pE6vkpJAq1AXoxrVS8w6mhsl5H30XNAivz84Loe7KfgJtC8ovNYhcAE9UdNqEIIRGQSmKLPPfj2yRGR00CDWw4f6VFeDJoq/Pb8jHGuWgWBC8lcpYrdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CKRcLhzH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1287564b3a.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751207303; x=1751812103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/riWwctke8lvpJRYpK5IyBurpmCQK6cP6DJdoNEsWI0=;
        b=CKRcLhzHeMd+/g3s/iytSU1ChJznp5q8WSJtmbyscqeC/RnFpUCmUSmXYryz0ysJYN
         lVp4ok68VIHmNPjEBiWSFs/c3ceSomhiIwy2yl4NyMoFOSrqtcuOe5SnPOUp+0WHlOHw
         wF0tE4ymRPEd+muQ51lZtUV5GFNKlhP2mbblmZ6zKl6N76fqrtTIko1yPDO5IpqSvlvG
         le4pn3YfwV1hscyV19wek1PLVZ2QgZnezu128zyBBCVnyofJk8uh123zFXZV/8lyFfeG
         j0qQkOe+KGmMdpRwRa8xe2d0cPYbB0WZAcFg1Hjk06OD5Eb6jDJavLuTbg6fzfbYy4gM
         X9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751207303; x=1751812103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/riWwctke8lvpJRYpK5IyBurpmCQK6cP6DJdoNEsWI0=;
        b=FWoO8kyNjk4As1hUFtVwArT3xRc8+qJlLce2Rxpqs4Hc85tmzF/+Vvk9qy8+EwWPAM
         ct06cyhnMIk6GYej0+XvGS3tW9Ya6HIyDiffuCszjVpeHP4CgaGadlaOfMMQPvKRmh+m
         F5joSw3xLor7OwUu3ZFHsVF+RVREatnbxjEi84s+L6hTNxhh4GsJMzSPKp7UEYT9IGzg
         5Dcvk/At4/ZDnrAmgaCuWnE6aDt2O5jJNed8Ln7ATbBzOT5/ba2EnlnAd5p7jiL9p7G4
         /trUGoR1jj3OgSC18sH3pECVm7T+tPE8DrZDQFk9rmCFLMQtTzcUT59u2aSKhrKLuTmI
         3khA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3FyKuYowoAOEEd2m1yFzUTbrGQLQLZJ9XRQSSc/bhJdtWvoi+xJaAsN4D3GmfspQTdiRCBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRs10E83JlvzMWsPZKtLu6ynkXxmBTmEeqSJBg23axuOu/eX9
	76bYw44dQ0eKJ9iGa6wrUcFSymBdIoXFIgL8bOxvxnxuiQ3PkXfjPIlJaO1Q5zkkZmDGYtDg6mT
	TopkF/A+CMqUsYfBTwNXzxOboOLbvG7t/b8MZ1fUG
X-Gm-Gg: ASbGncsgnvctTyCHHkTaDzUtLnJV+cwGHugVE6RoonC+UTz/UAW8FVVkPS9qLo/68Wv
	eqEy7TCd/mBAxt7H6XScuroahdnFqRy/Qt/fbh0IgwH3oUUnNo8TJ2THxz3uBi9z205CISOpvVU
	Yh+4plJj4HziYhoQajAT2TVNAjcbenqUgAAGPTzcz6Xw==
X-Google-Smtp-Source: AGHT+IEb0tecv4VkQpC3zoMJljqOE1eH0lXewT3ZzbiSpfH5w45Gb93xgGHKMh4wQHcCmNAC4SjOZBItwyP460xkxEQ=
X-Received: by 2002:a05:6a00:b8d:b0:742:3cc1:9485 with SMTP id
 d2e1a72fcca58-74af6fb9c61mr13439996b3a.12.1751207303560; Sun, 29 Jun 2025
 07:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
In-Reply-To: <CAPpSM+SKOj9U8g_QsGp8M45dtEwvX4B_xdd7C0mP9pYu1b4mzA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Jun 2025 10:28:12 -0400
X-Gm-Features: Ac12FXztU8x2O4N_na5VessnCcmhAS2a6AdbvhMSLVspcfS9BP5Mc15mBqQe-ro
Message-ID: <CAM0EoMn+UiSmpH=iBeevpUN5N8TW+2GSEmyk6vA2MWOKgsRjBA@mail.gmail.com>
Subject: Re: sch_qfq: race conditon on qfq_aggregate (net/sched/sch_qfq.c)
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 3:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> Linux Kernel Security Team,
>
> We are writing to bring to your attention a race condition vulnerability =
in net/sched/sch_qfq.c.
>
> In function qfq_delete_class, the line `qfq_destroy_class(sch, cl);` is o=
utside the protection of ` sch_tree_lock`, so any operation on agg could le=
ad to a race condition vulnerability. For example, we can get a UAF by raci=
ng it with qfq_change_agg in qfq_enqueue.
>
> We verified it on v6.6.94 and exploited it in kernelCTF cos-109-17800.519=
.32.
> A temporal fix could be
> ```c
> @@ -558,10 +562,9 @@ static int qfq_delete_class(struct Qdisc *sch, unsig=
ned long arg,
>
>  qdisc_purge_queue(cl->qdisc);
>  qdisc_class_hash_remove(&q->clhash, &cl->common);
> -
> +        qfq_destroy_class(sch, cl);
>  sch_tree_unlock(sch);
>
> -       qfq_destroy_class(sch, cl);
>  return 0;
>  }
> ```
>
> But this only avoids the exploitation. There are other places to exploit =
the vulnerability with a General Protection (usually null-deref). We found =
two places that can crash the kernel:
>
> 1. When modifying an existing class in  qfq_change_class, the reads of cl=
->agg->weight or cl->agg->lmax could lead to GPs.
> 2. Reads of agg content in qfq_dump_class could lead to GPs.
>
> These reads of the agg structure may require `RCU` or `lock` to protect.
>
> Looking forward to hearing from you and discussing the patching.
>


Please partake in the discussion to fix this, your other issue and
others on the netdev list, start with this thread:
https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/

cheers,
jamal


> Thanks,
> Xiang Mei

