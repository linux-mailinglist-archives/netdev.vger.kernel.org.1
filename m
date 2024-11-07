Return-Path: <netdev+bounces-142879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259A9C092E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C32B214D4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791BD26D;
	Thu,  7 Nov 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XyX0MTpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5E1EE019
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990839; cv=none; b=IMPOwRGdOu3rY3x+OD68jOqb21ofJsCuUE7rBix77yaJ1PuzijvdkHYmFBsQa+dyEsigE88HDs9BlrNq29aeoE7Hjgzzrji3bYPzTko2MVkMOOwfz4gLwaxf89TICtEqYOPZtXQRBeA24AvfqdwwlR5c7A7QRqex3mMsOI4TArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990839; c=relaxed/simple;
	bh=4VvM4spYzV2dLoT/WtGdn2sKInEjdCDtynvV2xzQxWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG//JrE1ftvoHVOkGWnL+bOv+cONNinxACbTX7h2Fp/mbG47eyRpewihOuCjX9fJnmeQ1yz9HDg4I6YOw8T2/WwrgyhqBZZdCSYywFluYaeH8CVzJN/+kh5hr/qIVxAnFLousvifim5Pi+Xl5YDkiJeZzGddZQMbqU8WRSPt+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=XyX0MTpu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso867533b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730990837; x=1731595637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qATM5N7N08urlYsKLzwP/h0nbG8iPKBRikKapjsBaHU=;
        b=XyX0MTpuQMjZmcki8fyOXauiQZqUsdyrzCbAFRfo3YPJaYjz99q1pheKnHNJr2zUsk
         ZRY13IcZk8to3D763HPbrgknuSgwf89+YYai+m3O4nCroKFfSrJLLzomDa+0y+CwiPAS
         5T3wEeXL8oB13I6GvQOmsbZGE5cRdFV+IxktXoy2Qw8E1sJRmeI1a4T7eJYMEF6aytli
         4zIeGCrfQkM3J8Um37bHQ3HPerbPoGzf8/to6f+j6DSAldnOPQEYrVOyQMh3N4rNKnDg
         r+8BO3fwXyXf5HDTQuVpR2nxrbzcuQo4RyGXKR4cNp70EI1Ol4E1pnUvjI/I+j5Q2KHx
         +0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990837; x=1731595637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qATM5N7N08urlYsKLzwP/h0nbG8iPKBRikKapjsBaHU=;
        b=MA+YpY8Orui45o9SQQm0XXwE4rUZyfGmMQYf26Jy49iQfBm0cs+IDYAH9JlXBmq9i6
         JTXM8uu6vl4b+vAHVHW/zRFwUzAM99J5whrZrzBzlQiuFkZNPi8Dgf7QSK2oxgEoVFjM
         NbJ/xPnFcYNQHCyvz08cNhpuqidvYhaPlyQPx/6TvtSrHEuzU9wFosd5QJ8NKK2p902l
         EezE8vQXIE5JXggEMqF9TL7WhxA5MggaAjfFJjSlH8JkUXF1yS0u9b3o/uecboSVpN+s
         TmQaXuqbkqZTY2035wtuHry5gzbLtysxda/L2VWH2sR2emmiioZRquhhIwloqPtwJWe+
         z7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSBzrEiMAkG4+II7yCv/yUd2vbyaKXj8TB6YNv33jKFemDTdp8bW4e2Dnb3JN2pqQR/O6D+KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NAfz0vKJdVbU+IExYri6kN4QJK8eUakeT4nFfUu2HGMBjKSy
	J1sKPWPQTZK6o5tQHt42eEr4tJz+87wCNd/5q1slNxFK7zJOkWurvps668HkhpQu9K0igEfLevH
	E3mFoNwpWaZNyDA2p1MxWhnmskgQGInz0jrjp
X-Google-Smtp-Source: AGHT+IHyKD5JjlTuYFjC3bYNAlK3JQmN7Bxztwx2POpXF6d0r15jyKi+7pZNUWChv+S6+g3QIZnef1lDr/iac//aizw=
X-Received: by 2002:a05:6a00:b55:b0:71e:744a:3fbd with SMTP id
 d2e1a72fcca58-7206306df29mr59068115b3a.20.1730990836704; Thu, 07 Nov 2024
 06:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com> <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
In-Reply-To: <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 7 Nov 2024 09:47:05 -0500
Message-ID: <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> Hi,
>
> On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Alexandre Ferrieux
> <alexandre.ferrieux@gmail.com> wrote:
> >
> > To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> > encodes the returned small integer into a structured 32-bit
> > word. Unfortunately, at disposal time, the needed decoding
> > is not done. As a result, idr_remove() fails, and the IDR
> > fills up. Since its size is 2048, the following script ends up
> > with "Filter already exists":
> >
> >   tc filter add dev myve $FILTER1
> >   tc filter add dev myve $FILTER2
> >   for i in {1..2048}
> >   do
> >     echo $i
> >     tc filter del dev myve $FILTER2
> >     tc filter add dev myve $FILTER2
> >   done
> >
> > This patch adds the missing decoding logic for handles that
> > deserve it.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>
> I'd like to take a closer look at this - just tied up with something
> at the moment. Give me a day or so.
> Did you run tdc tests after your patch?

Also, for hero status points, consider submitting a tdc test case.

cheers,
jamal

