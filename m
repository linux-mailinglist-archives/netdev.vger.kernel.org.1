Return-Path: <netdev+bounces-134626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38B99A88B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833CAB20EDC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609E18BC20;
	Fri, 11 Oct 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkOzyHyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343E5381E
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662476; cv=none; b=iG4/SaNHq9u2OYmgK+xh1ReWj/GeGfMQ0oUOhqdqcs1eGcEXMCGf0pDIGlI7C/EakMAxAK2MijFtT2KFKzN0RRveZARM/osYuzSmTfC4VMlmluWSbIm/mBuVvamloAicpmAY4t6fP4J2waiB/0u9gXqqjVETQYDfeEuyHh6slvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662476; c=relaxed/simple;
	bh=S65BGNY1UnF8SDCO6D1ED59fXTQg6uJoort15OboqkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF3qhTOGo84cvGCJOQojDfwOrWzxNTUwjmh9ZbQl/y8+KWHHXac8+j3YHpUQaimNyhVRs6k+Yh1Zl3NpxtRTwhJLgknarNl4iR8O9VLsqeFeotHK1TsLIMDg+jZwUqo6aB7euJzWmsnz0ulHCyhfVOwvumsLWFnxFfB/Xujy/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkOzyHyk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso353275a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728662473; x=1729267273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7353p2O3KPbuHGeV9xHxSQwfR7xL+BSOwlnY182tm/c=;
        b=tkOzyHykNEs9ZHiciLbOgW1tOQSwW/A7lTJaMC0T85gRJ+Zqj3AIAHCc+XP0cBuJMB
         +WIPAedmlmbRogT6vZ6wNhxlrW21thClI729kVmduQU1L1LgGQN9D+tzxWoK8m6Vi9Se
         ZeuKP3plSTUHP4lNWKkLQWJ8Vk8Z8m/Gpl/0beGzc2482aHPYbY46wjYdilrIfRnf8Yy
         C/1q7A+kQ/rvJ40N5/ygh6ak6n10hnBszp9pQk5CiybdKRtWhVGsDgobsL4n8slNo+LE
         TRN3a2S8g0USIUoIMbu+v14XvDOkuAPzkGNFBUgE83g1CV2hCwOWr6kGMAT0w3evM2q8
         smzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662473; x=1729267273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7353p2O3KPbuHGeV9xHxSQwfR7xL+BSOwlnY182tm/c=;
        b=XQfC8z1k58hL7wQfHSIUxKMmr07TLrf5uU+KF8niKfHECuQu5KbSGJ0C66RAkS7IZh
         GvdVrQG251Ty3b5+mvzvL6lt27r0cdWZxr1itL1mpq+NGeQrZpNVD5GvG6Z3ILmZwPmZ
         1KYAZu8iWR6E402rEFlTfImBzrf96tlLzw50ZDDrA5AjlLfjeB0yjcm9Ee71hK9tDlD3
         KmWfGQnZQ+hgAtg+Xd+Qpo28k66rBAglQRODg2WpHZZ5aacQ3qYEPD8sr5f4niXg7Imd
         6kPR1NxjoVHoFEHDTj0Cco0Jsf0sWI4363mKmPVu2qX4zniCW9Ow7BEELII0JMQkR6Nd
         cDNw==
X-Forwarded-Encrypted: i=1; AJvYcCUeiRATiKaiiommQOHgp8U8s6isacyiYCbNqu695mNB10vtJQz1h6gdrqN++YZzu6SGs2YqdQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIevIpNLSZfK1en9ubpmzsAXPcblbfHyGRBhsoqn0qriTXTF6
	LOJsyjyj6kPclNXCtdmxeTHqe265mEvpAg/cyO3oofHcQoQFieMZh/HEB+eowZErG8Zx/avrC1z
	M7aZPDQVdC09CRQFkSpb/rfynGmeAjZFFCNbw
X-Google-Smtp-Source: AGHT+IGirpj2QnVkNTwadx8h3QJ8HI3VAxpf2kcOZc+T97bq8C13tDYZyJQjNeiY4ToTVZTEXcKDrRMMa04qN3Uitew=
X-Received: by 2002:a05:6402:2790:b0:5c9:4b8c:b92e with SMTP id
 4fb4d7f45d1cf-5c94b8cba3amr1943414a12.26.1728662473090; Fri, 11 Oct 2024
 09:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011131843.2931995-1-edumazet@google.com> <20241011085911.601bad62@kernel.org>
In-Reply-To: <20241011085911.601bad62@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 18:01:00 +0200
Message-ID: <CANn89i+i5t7T-eVN4J1od+9W9XRFM-2=U-5GZ9mddP_pdD0KSg@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: use cond_resched() in nsim_dev_trap_report_work()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 5:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 11 Oct 2024 13:18:43 +0000 Eric Dumazet wrote:
> > --- a/drivers/net/netdevsim/dev.c
> > +++ b/drivers/net/netdevsim/dev.c
> > @@ -848,11 +848,12 @@ static void nsim_dev_trap_report_work(struct work=
_struct *work)
> >                       continue;
> >
> >               nsim_dev_trap_report(nsim_dev_port);
> > +             cond_resched();
> >       }
> >       devl_unlock(priv_to_devlink(nsim_dev));
> > -
> > -     schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
> > -                           msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_=
MS));
> > +     queue_delayed_work(system_unbound_wq,
> > +                        &nsim_dev->trap_data->trap_report_dw,
> > +                        msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS)=
);
>
> Makes sense, there's one more place which queues this work, in case we
> couldn't grab the lock. Should it also be converted?

Right of course, I will send a v2.

