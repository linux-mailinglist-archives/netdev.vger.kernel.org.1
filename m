Return-Path: <netdev+bounces-100238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190268D8495
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35817B22D0C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767912DD90;
	Mon,  3 Jun 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="s7TK1NNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA715C3
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423555; cv=none; b=hIvybHzTJBpn4PMaA9L4mQ80oxEUxDSFj5pXk7Yk3wnyEjHYBSaM5WPqJzUCN0tIx0P9P+svuYD9UEyg8wL5Fp7qzrO3U1oKlYOHkIXuHDJKBOmbnbfeIq+Lgcy7MEe49+ECRt5t5uBvLd/4eD7Hwmbb08An3g9AROdpnPY20Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423555; c=relaxed/simple;
	bh=SuoTp5grn+xudc9I1TISjbjsI8e8A5jTM9DRbtVRPj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luMJi99sPLrmLwdTs4a5BLFBME17u/MR/jSQGHRgNOTZlMx+CRd05XCrsALbXHjmxvVQMSHOrDmMJqXbI+whqS2/Xkqd+fQkowVhm2dlbJdqSU+jUKiFD4aHR8U8//BivP8hFol+VpF5IeceUccK0Mz3YMZysqoOyKzaVqiPmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=s7TK1NNh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62c6317d15cso41778367b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1717423552; x=1718028352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JijyB+X1/sfjNCE2MmB4ACkrhrwV4dWmF4HGnWAi+Uk=;
        b=s7TK1NNhhlDb4O6ZazXvZuSa9za6VUGkmfAEJS0A+TVt+bu2k9ZOl5x+9m4zhUAQT4
         TQcV1C+qudt3x4nGX/XwMi13ciZQiZDJz+Jfs0OTt+XMbjPMbjW6a9MV7Pb8yS3l87JF
         VGMzj8ly2t2kUH0mtYETjJuGQDzF0Zr8QPvcq+nV2NTfZeQVnBWrevO/al+DpbZm38g6
         BYq9eqUtX+j3ZftIkVHRSAf+DsHUu0Xd7OCKx6leVmOucQFw3VKvahwyWq/rYThLzNJe
         HAjedUAFlpeq77VhvmuZFROsBRzxZyqq4SOfYAIKny7s2NbQ13h1ulZ/y2wqIeQyVImT
         Cr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423552; x=1718028352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JijyB+X1/sfjNCE2MmB4ACkrhrwV4dWmF4HGnWAi+Uk=;
        b=O89rY0shtGvfhpaw/TTuzykLCMe184bf9RxSYYpo5sCgxprVyAAguQM7r3RJHUHF6R
         NXeCsIOFpJ9r6vg3EpCGB5B+Tms/oCHFbkacXi4OwW7f7idtXoVKTUzQIvfWt/xJ9zdf
         ITWr6GKhh5qzrmpVgGKhwlyOy4Hf5LjVyrQHQCDhfMMGdlynlUThH3sSF8uIEJQmo6xZ
         +tLhO9QlVxKGohQih/d7UnBG8JZ1CaqQMu9iFMPXlihO74MBi453qxRrHD4iT2V3YCqU
         Cj3sTFFekfE80pS9fykYTgpHwX2drzdsWKCk0uEWMH/OkXryp8rihIuoaeVY2fB68ttK
         X79g==
X-Forwarded-Encrypted: i=1; AJvYcCUX5zFSH+tmRz6N/NGR8J2D73zktqJdsDPKFwnPqd2obO2tOyPKH1TPxJuJccFH9YEazzRGGJWLCkQ86Q3ZNODccJV7kWfF
X-Gm-Message-State: AOJu0YxWguXoRKvROl1NmZ3AxDbM1WSGWfOZG2OjfltiFNmXj2xzTpd/
	t0P8nBhHACx9qu7/blrPC/GE21B/6w2UT4+XyWRuuhWaEQDiQWzPZjtmn0Z9PpYUkY7Ke/L7Utp
	hymdqGVBae9BCXsRzPl4m2FZt7xrX+hs8GDIFdrktNZTs/24=
X-Google-Smtp-Source: AGHT+IGFITLyF5QeYLmdgPHntbIUw1QuS3fPtPG+u4/pSHxSpyrzJS1w0R6sB9EZsb8zHQrLzsbBU8OYmtuC1XNdyUg=
X-Received: by 2002:a25:d0cb:0:b0:dfa:4936:e617 with SMTP id
 3f1490d57ef6-dfa73dbae51mr8781653276.48.1717423552274; Mon, 03 Jun 2024
 07:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212517.644844-1-kuba@kernel.org> <20240601161013.10d5e52c@hermes.local>
 <20240601164814.3c34c807@kernel.org> <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
In-Reply-To: <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 3 Jun 2024 10:05:40 -0400
Message-ID: <CAM0EoM=jJwXjz3qJoT21oBsHJRCbwem10GMo1QStPL7MtUwTjg@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 10:23=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 6/1/24 5:48 PM, Jakub Kicinski wrote:
> > On Sat, 1 Jun 2024 16:10:13 -0700 Stephen Hemminger wrote:
> >> Sorry, I disagree.
> >>
> >> You can't just fix the problem areas. The split was an ABI change, and=
 there could
> >> be a problem in any dump. This the ABI version of the old argument
> >>   If a tree falls in a forest and no one is around to hear it, does it=
 make a sound?
> >>
> >> All dumps must behave the same. You are stuck with the legacy behavior=
.
>
> I don't agree with such a hard line stance. Mistakes made 20 years ago
> cannot hold Linux back from moving forward. We have to continue
> searching for ways to allow better or more performant behavior.
>
> >
> > The dump partitioning is up to the family. Multiple families
> > coalesce NLM_DONE from day 1. "All dumps must behave the same"
> > is saying we should convert all families to be poorly behaved.
> >
> > Admittedly changing the most heavily used parts of rtnetlink is very
> > risky. And there's couple more corner cases which I'm afraid someone
> > will hit. I'm adding this helper to clearly annotate "legacy"
> > callbacks, so we don't regress again. At the same time nobody should
> > use this in new code or "just to be safe" (read: because they don't
> > understand netlink).
>
> What about a socket option that says "I am a modern app and can handle
> the new way" - similar to the strict mode option that was added? Then
> the decision of requiring a separate message for NLM_DONE can be based
> on the app. Could even throw a `pr_warn_once("modernize app %s/%d\n")`
> to help old apps understand they need to move forward.
>

Sorry, being a little lazy so asking instead:
NLMSG_DONE is traditionally the "EOT" (end of transaction) signal, if
you get rid of it  - how does the user know there are more msgs coming
or the dump transaction is over? In addition to the user->kernel "I am
modern", perhaps set the nlmsg_flag in the reverse path to either say
"there's more coming" which you dont set on the last message or "we
are doing this the new way". Backward compat is very important - there
are dinosaur apps out there that will break otherwise.

cheers,
jamal

