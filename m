Return-Path: <netdev+bounces-125178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CF96C2D3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F011C24D6A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E251DEFE2;
	Wed,  4 Sep 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nERb/MS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A01DAC4A;
	Wed,  4 Sep 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464944; cv=none; b=n/xz2uixdWcTrBzpKzo6cNiuLsyzM214qmSyDbsn04WUXdNaQ5eX0UvllUDTNHl7MQ+MW9qb5ZUZfM8lFtnOW4Hu6yt3/YL8ioaBW1uy1KfclC2MV8RHFDb2u/sEPuHY3x5gPGgn53aJly+oB1L5Nc7KLJUavkoI3YKOAcCAB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464944; c=relaxed/simple;
	bh=kyYWi9UMODlueMtnjsQ60aBqJv+FaPcCOqWh6AxpPhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2DuiS+s0WLvNV7K1W/sUISfFZ5Iqvu/EJEzGJWCYR6ojdYBJ7hZKblk5emjhO5G5LHADJpsDAjvT430qcUpCG+DsvwZiOV00EQyqwFyaOH9vUdJqN5DjlaIiUjLrjv6M6wffcRNZBpvVGIFWBizZ8v7y+auwZgM7Y4AtP1iimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nERb/MS6; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82a1741aa31so51182539f.1;
        Wed, 04 Sep 2024 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464942; x=1726069742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqpJXfycU2oWJmbJ2MxlF6buFMqDvVtzcqst1Y4P78s=;
        b=nERb/MS6LbbbBS61Z9qraxjaCTEL98amZDxx6rDIFZTyagV+2M+Hn4W1rNl69whW75
         iic7FlId85n5oWpxm9AJvKra6gM7DEcVUUGT7KoUsxIaH9q7ns1eiJkvIWzxRK+DSctE
         +4fhHoPtfwo2O4Zc2MdixXdMTXDAK+nSMYlUnLb7HuWVbaY0o1dgaMzdT+Wzdzdg+RgT
         JNO02rHQDZ5uxmbgIhDsxyu/iz5/TxVD0VeC0QtIIjPYyoFcsF0KZcdL2Nkt83eFI4dM
         tC7mBDf8FkXn3yM59PTsTM2tm7sms6KVwXJW/HCSdNPRBd+O/purjNOYeFoOI0Pyr8ov
         5NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464942; x=1726069742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqpJXfycU2oWJmbJ2MxlF6buFMqDvVtzcqst1Y4P78s=;
        b=uuYZ2e1TWllQKpPD0MUfNQgPdDB3fwWxUpVzrkMMkrJsujv+H0Hr1Jm0IEFR4vuvcv
         VN3s1/0ia4s3mCpCEtDuv8fIXKsLwchOEb1hsA5Dfq6rnwBeLzY9S96KnUtN7EMUGjqj
         x/+KiqcDXAEb+zI98gzlG7ECaj1jxjT/6QZxV0V6OdLWiyNNIwDs0UvapCplTD7Msu2U
         L1H9m47AFEN6a5YOROhPoOg1GXZTvsQc2kVndKkr6j2Buh+Sc7XZbbgh1QM3biEZ3ygJ
         oi7wrZpudaPE7Z4BEDtglIWZzXm4wxOgRtfY9/u/tptrcsHZ9kahfKa4yDutgahOsGpC
         FLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUhWeptYvqkft+jNURn+GY0PF+7hIBZBqt9sbeV5hQszA2TiuLbeTXVzh1Tfa+zVziClveg63Hk@vger.kernel.org, AJvYcCWl2hV+P/sef2OFTD8NxwjQpBmytYjoEnShdMSY9tbv0ku8eB8sxT0yXblRdtWylTORFeQlwpFB6AaV9ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3afUtZVaL2X7/6xKVF2pA2im0V5FtbqmUowQBcidSF3CWhPOR
	ksQiqIWNG2Ahm41fM4VuiNztWOnPfu8bvdjTgXjyhhIEA6s7hjl2ZJ0BeFA5bpMtMESm4x9kCu7
	/Nm+y/hDe7Q9O/47i/Vr82FC3VAQ=
X-Google-Smtp-Source: AGHT+IHa7FVQ77BbfCKRFplc6GgEIq1ROiAJ4QJCuH2BZRGbMkXtwzns37/dx3xTFwq98al3NgpBtRgVaHGbmlXFiFs=
X-Received: by 2002:a05:6602:3fd4:b0:82a:4163:838 with SMTP id
 ca18e2360f4ac-82a770daademr336611339f.6.1725464942324; Wed, 04 Sep 2024
 08:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com> <20240902120314.508180-6-linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-6-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Sep 2024 08:48:25 -0700
Message-ID: <CAKgT0UfCoaSE-tkB0TnSucOr8AmB69838-UHpwTOFxH+GVTQnA@mail.gmail.com>
Subject: Re: [PATCH net-next v17 05/14] xtensa: remove the get_order() implementation
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> As the get_order() implemented by xtensa supporting 'nsau'
> instruction seems be the same as the generic implementation
> in include/asm-generic/getorder.h when size is not a constant
> value as the generic implementation calling the fls*() is also
> utilizing the 'nsau' instruction for xtensa.
>
> So remove the get_order() implemented by xtensa, as using the
> generic implementation may enable the compiler to do the
> computing when size is a constant value instead of runtime
> computing and enable the using of get_order() in BUILD_BUG_ON()
> macro in next patch.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/include/asm/page.h | 18 ------------------
>  1 file changed, 18 deletions(-)
>

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

