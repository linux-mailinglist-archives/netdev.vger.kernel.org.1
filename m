Return-Path: <netdev+bounces-161776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D10A23EA6
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E3E1889916
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC161C3BE9;
	Fri, 31 Jan 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i4jMX5VQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E1EAC6
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331385; cv=none; b=aFovDS7zQVFN16qSvbwIpO24N3w7Tm3klhUzYp9gsGQKA71SgaFY6k/YNHNcCuE3LaM3uMBy4ygs70h8o+optK0yah0J3mKRl8UH7j/0k+LVABrwVXTrk3qjiNONxbT50LuD3aB2AmjZQHZKIHhrAsyFPC9kivjDi7xDnWCXmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331385; c=relaxed/simple;
	bh=v97KmB/2DeWvCemPHBBP/AuSc7zKCL54Di9MXbB7Qzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4it1lXZGxSLBFuptSmP+Ke6ArmWeeqTD+AgFKhSOdUyiXXDlFuvjL8NN2LL602qXx1PvFy+eP9Yg4zvEjwQs5E3/g8oPOc8FPJeLj6+FwNlcSBkXFQQAMR1fXuQj9yykx8G+oWbfuEEVPHLyMO9g7ki/u9hJJru88wk0vT24pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i4jMX5VQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21636268e43so44460065ad.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1738331383; x=1738936183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v97KmB/2DeWvCemPHBBP/AuSc7zKCL54Di9MXbB7Qzo=;
        b=i4jMX5VQstVQOeGq1IeurWIRcmoR7HTISlVWaQgUwrQI1t/S8QJKhkaPmpt15c7M6V
         Y7kzsENhoct9hWLU5hL5ZTyQcfTlGxmlSXdpgrgIl63XDjXtPNRhBWhcrKN44STo7Skc
         GN8Ih250cC96+kgq5QXoCUKaic7CPCIDd+nNK7n/8KaPiJjJPtn/u56EHa5nkyW6LPOX
         lNQpTXN5grj0EQzn929aY4XLO1sApd4Frdc3Li+cNtFsPFpmrEU3IlHRZCplpGlMwoci
         JrsGwIJ9YYBTfWY2+p7J8Zi1UzwTNqWnec6G+dY4dW1fmMOZ0L4N7A0ke8Aa08U/s8Qj
         FPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738331383; x=1738936183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v97KmB/2DeWvCemPHBBP/AuSc7zKCL54Di9MXbB7Qzo=;
        b=Gjs9w8swYiEjiq2i0dGMHPr6rr5dl4S0+GyzzUPb5VkP2PaRbDiqgEHZKPU1YeLgBV
         xKrc/q0jotHvyDrxdFjAxmJOKDWyAptYPmqVMbQcwULQ8jemC9FOznG1FRGx+btgePWw
         O8MQ4NwClIBkv5hHGPoRgYmpQUE5Lfq7wPVthZzcRcl8LLkCzOA6gIa3v4n3sRa+8vnq
         oVo0Ibz24JfY8V1Z6sJ7607iLImy7GnyACAPUavUNJIiFmhXDMS0Q3R4g/LphL+aWfIn
         sA96uEnu7HBM2r+T1N4n9yMLOx0rjcJ5Phi3jaD1gcxBAAKTZECvfiz/bnrYL8cfQOLI
         nyRQ==
X-Gm-Message-State: AOJu0Yxx3gdYLNz60rTGFe4bVSMZuK/kjwMWSf0jOa/s30tX4OTukQvp
	i4P0EnnEQ50NknaHRH99toZUZIzUizevNNsfZ0g9YWluSoZ6GD52DS4POrvdPuZZ/W6gNvmLXP6
	QKvYzSeo+Ys0+NT0Ecax/vnojHVYdUk5Hdqz0
X-Gm-Gg: ASbGncvUq/jhJObbwJXIdTZrfX0YrDkiEYlOPNzVnFHDP1raE/pCjwxnOkgBCDvlppj
	WZ1R4Ddl7dHMtQ5jeIopNfHSC3NbSSVY3T1niFEw1G3T2mR6F79K6ZCRAUdoVVI4q4ksRMFAJ
X-Google-Smtp-Source: AGHT+IEr6kOvUGYZt7kf2xNUp9su7NCXPgFBJdbQpzkkrB6pvI5Gn0t3cguxCUeiDmP8x1UdaKcQjGBj4fL3vyg4WHk=
X-Received: by 2002:a05:6a00:140e:b0:725:e444:2505 with SMTP id
 d2e1a72fcca58-72fd0bce3bfmr16337184b3a.4.1738331382693; Fri, 31 Jan 2025
 05:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116195642.2794-1-ouster@cs.stanford.edu> <CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
 <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
In-Reply-To: <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 31 Jan 2025 08:49:31 -0500
X-Gm-Features: AWEUYZknC5cwQP_MNTbftX6my3p-wsF8kGJG5_imEzUGL5xJE0DNivlG4EyKBok
Message-ID: <CAM0EoM=nO52XBrcbMvDbe-OiyK7dBd0aVY=oN=3FsW6wQ9P14g@mail.gmail.com>
Subject: Re: [PATCH netnext] net: tc: improve qdisc error messages
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, Jan 31, 2025 at 1:39=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Thu, Jan 16, 2025 at 12:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > LGTM.
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > cheers,
> > jamal
> >
> > > 2.34.1
>
> Sorry for my newbie ignorance (this will be my first accepted patch,
> assuming it's accepted) but what happens next on this? Is there
> anything else I need to do? I mistyped "net-next" as "netnext" in the
> subject and patchwork complained about that; do I need to resubmit to
> fix this?
>

My bad, I should have caught that subject and patchwork wont notify
you if it didnt like something.

Re-submit when net-next opens with --subject-prefix=3D"PATCH net-next"
--subject=3D"net: sched: improve qdisc error messages"
You can add to the submission:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

