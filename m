Return-Path: <netdev+bounces-119570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66621956434
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235D52812F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F64156C71;
	Mon, 19 Aug 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcllQhjg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D831150996;
	Mon, 19 Aug 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051683; cv=none; b=D+KpHMehdxHHz1H68vj/7BtB8t0qvSHS3VhO10zfaeSb7M5YPWJxOOqdxbZydg/RfNt7ZzGmbwzyFf8q2DJD3DriI3jkRhBhq+XUe5Muz5IptgD0xT3cHEyaafhyKdVxPF9U+6DokPSr/QzDaDmGt6SZt8Wg9vDfHvPcl4L1OS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051683; c=relaxed/simple;
	bh=/5SWAe76ctyLJGTMsKhPgMIzXNKnDPQ8hhETXknGonY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV3cMhC8dD9u9W0GbJvpX3VIvfUejeEZjQAFEkAgd/D36v5tkEPm3feO1v+LEZT8xNVU19D/Me6F48l55Xaga/21s0mbrx0XWYgCoSU5ukzCrvUJKMtE+8Btl7F2Mgn5KiHTKQ6K9H31hQ/7ryv7Y9POHg9Z7dP6A2TZagPcTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcllQhjg; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84303532b90so1071542241.3;
        Mon, 19 Aug 2024 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724051681; x=1724656481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4sm2NzhCNlcOkfjD+CTTUTOYmrc4iWK7QWosAZNznM=;
        b=kcllQhjgfsYPusx8E93BkKclQRVKtGEYA/CGOCWscC7z+oeKD4dH53zjKXwCCI02Bv
         AsKwWQmipfTWDfN/H/IR6DcFQ8jbrFarm4a55c8uobDartKRlCnxVQ3CCsQGHfsZ386u
         3AzEOwKrBlC6BipaDQPhPGNcAqQd0X8pXTTb3RbRLa5+jevL3rTRrKjouUGdV6wddTDx
         QpnKinBcm9mJxHRVWEQz1jChpebSVRpw8lM0SOmEYnCn1dDxd0SnUtAHvMz1kTON4eR0
         WIrOXRJatqrmlqZgXi3rDMFPrXyW7/J4egh4ewZsAbsGOBDPg/iRidSfuxE4A7NRqQZo
         AT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051681; x=1724656481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4sm2NzhCNlcOkfjD+CTTUTOYmrc4iWK7QWosAZNznM=;
        b=dDUeYzBP5cSx1G8byhC+3ok9+JrAH3ZNWo11dAFrg0OWEdYMLXHr5eM2e4WHgYPeOh
         +pHP81hbvqmBD85c7Qjz1MWsN26i05XPkMhdH3gZP3G+m2E56pLc7yaz3rpNDS5Ar/Ip
         +uBM8EgkLVW22uCjihpwnjnY0N8RN2t86PNC+sWrmDoxHegFtE9vUij09h1hC0yMIiXX
         kj5PbQtCMd2RadgTa9xhefVAnupMTUYsTn8Ls0uV83mA3qe4ig9dhCBXCtMDpBw5D2Cs
         zHcQmmGA29wT6CsKAfeSjHqry8xvDgGiKlkDomKQkTlItWv0Vb+g52NLTkH7GSLDZ1NT
         aGfA==
X-Forwarded-Encrypted: i=1; AJvYcCW7XzxLMELm2LDJTtA5abXhVM6gy96KoBjVI3B3HrXmLWd4yb5Zv+0m44+3o/gGJFbDom3ikCDBuZ8r/CObCmB4LKN6o188nwhNvO7ihERIxfAw91HGD/giMrNnGKdoNUkekWPH
X-Gm-Message-State: AOJu0YyYlXh4L0AvmdKH6o0CqJ3yhP49pPnOYXZdTFMjB3Zb3cQVMQPK
	WSPPv8nXuSgrm7kj17iiO0aCK4MGTgo9dGq1pUgK8nU/gpXuHZAv57jAhrIOxPPCqGN8/T2jj8N
	VJ5QsWece0V6u/lQRJO/QPUJ40vo=
X-Google-Smtp-Source: AGHT+IHib+RG/ZejzSYJ7BtLWgELQo0mAN5A+EwmYXyJsv7x9OZlrBhzI+E/TZx2UxnlXI0P7JwJ38P+h+DTknYZ+Bs=
X-Received: by 2002:a05:6102:5126:b0:48f:db3d:593e with SMTP id
 ada2fe7eead31-4977993e583mr12209590137.14.1724051681216; Mon, 19 Aug 2024
 00:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
 <CANn89iKkeM7s-ZbPR+d7P8PNZn_x3n15-e0Mvto7z-+5CWJSGA@mail.gmail.com>
In-Reply-To: <CANn89iKkeM7s-ZbPR+d7P8PNZn_x3n15-e0Mvto7z-+5CWJSGA@mail.gmail.com>
From: =?UTF-8?B?6rmA66+87ISx?= <ii4gsp@gmail.com>
Date: Mon, 19 Aug 2024 16:14:30 +0900
Message-ID: <CAKrymDRCzCJsNJcVffRvYV+wg8zB_nLhBcDNFsh0eLP73A-mcw@mail.gmail.com>
Subject: Re: general protection fault in qdisc_reset
To: Eric Dumazet <edumazet@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip!

2024=EB=85=84 8=EC=9B=94 19=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:13, E=
ric Dumazet <edumazet@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Aug 19, 2024 at 9:11=E2=80=AFAM =EA=B9=80=EB=AF=BC=EC=84=B1 <ii4g=
sp@gmail.com> wrote:
> >
> > Hi,
> >
> > I have been fuzzing Linux 6.10.0-rc3 with Syzkaller and found.
> >
> > kernel config: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90=
c9cf284390e34fa9b17542c9/config_v6.10.0_rc3
> > C repro: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf28=
4390e34fa9b17542c9/repro.cprog
> > repro syscall steps:
> > https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa=
9b17542c9/repro.prog
>
> Please do not fuzz old rc kernels, this will avoid finding issues that
> were already fixed.
>
> For instance, this problem has been fixed two months ago
>
> commit bab4923132feb3e439ae45962979c5d9d5c7c1f1
> Author: Yunseong Kim <yskelg@gmail.com>
> Date:   Tue Jun 25 02:33:23 2024 +0900
>
>     tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset=
()

