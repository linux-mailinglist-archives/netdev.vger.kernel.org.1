Return-Path: <netdev+bounces-125177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1742296C2CD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C11C226CA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467D1DEFC0;
	Wed,  4 Sep 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfQeABnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B71DCB1A;
	Wed,  4 Sep 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464863; cv=none; b=BPNAsvD5vsNy6OHmMya77BVCRD7mixuRlfjhHRrCrHhOJ4GNIH1xrpHWeO+R4dDEEOudpucGVMVnwY44eMKVcZopG3ny7/EqKHnH5+rMC8OGjIWcAUtQHC4tHFrDhV+rLAp7N1ovYcVW2DA8VaA+VRskB3JC3V+x6aDbGwWqd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464863; c=relaxed/simple;
	bh=KvCmabY7LcUOGdQP/mJM8EbCz3VbQhnVpMtDBQq4W3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1+F1acbST/VDCnDjlyp7KyU9TsE4enlZm0SyeKnOJcGQRmSTHOtL62HeixWJYqKA9jWjHm6A1vd5wgZeDFRxDUAhSjA+ges6DG6G4wwmko4p/5U+bEd6q7DdxbxlmhDAZsueIZjqYAMaJwZqGA+h7JaFuuTdsIC50vF6UoRkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfQeABnH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so3342219f8f.1;
        Wed, 04 Sep 2024 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464860; x=1726069660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI3ncFFHcdlnELuJGp3NCftA6/xROBK9Lrqnz+qYtJw=;
        b=WfQeABnHEVegBp8+hSgO3U+i3P4qZEGkyIoxhvVLUPnStYNn0Md1Iimzgy4IyZ0wd5
         /WFRes0CQHn2jAKy3GWWBmqw4dbZGh9J8MVnzBy4o6BNH7LzGLFp4FTVRi4VbcFFLl7z
         DMojdIwdHhMqIJInZfCbIySdO2yOxv0ooBrAarasmMqnpsDoItqAZ6m7SKQj/L833BGy
         v0uafSmH8OjTedmDoV2GPcgq6iMg02vQWnI/z7+Fpx+fhAtI2WFsOWmw4dTiX/dXQNXm
         DNwj3AlQpRMZ9EE4wh+1ks+A0jZrVYEwQQafebNDWU3RAhlc9PWHUG/Rs7mr7HvEjwnJ
         LDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464860; x=1726069660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI3ncFFHcdlnELuJGp3NCftA6/xROBK9Lrqnz+qYtJw=;
        b=d1VeOJsQWCHylpNTjKJSrPAYJdv7EmURkvJNr9l9Gs3h+kRJpXDl613K0NyIjt3YQ5
         0Kk0l8HV4cKfczUvmeDuqPfgZvIg7RyUAgARoI+PUT9GyV+sgrIBXnVFdUqLXAmUs1xY
         v+qqvtxpS5V6eSodN3FytHm7ZxiY8jLZVRo1aRjfhzPQzmV1+YlB7XxCWypTeZPnwsFF
         8Uwvnz6PKmTPZBWvEjcyIfBQphIeKgondbDFLoLxN1F4NKouc44SFOAv6fcrkaCmjhQf
         A8JLYB24UvlObni/usw9m4YdAAl+EhWFkbC6NNHU8lkKXr9yH1OxDzvFyzIJdA1Uod9r
         UK5g==
X-Forwarded-Encrypted: i=1; AJvYcCUAlsY78jqBdNpBEUdS/SJ4fDWuuSAeHfA5x9Ah0VcW4ABrP4FiLxdVlWO21EQ1Hhf/6HBPq7hl6LGx68g=@vger.kernel.org, AJvYcCVti3WQmEBY01HjWo7SSwX4Ary+gSWRxI+RwLXyVqp5aP3aTYRd14TfupdklgvhL7AMQIbrfhXB@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlBsGRZ+1K0+qBqBuaHdIfV7HmOTsh64VBqL4O96NlUXhIT8u
	5Xklqj8E4oIKjnHkonDtFYEX7KP7HHLGRvhBK5cV+QNaRiPb2a6fHfOZWJo28GT7/UvEF8qeTeE
	QYAWc2HXtkXLFBDv2bTEfM+ReoPw=
X-Google-Smtp-Source: AGHT+IGmP7hsWCrfK/n6gsjKnTU2NzzTQotXfiQVbbRNqQTQ2XYB5CMxF/h3wMW8waQyayCh7zivtQmWdmrOcZTGzSE=
X-Received: by 2002:adf:b512:0:b0:368:4910:8f49 with SMTP id
 ffacd0b85a97d-3749b531311mr13794461f8f.12.1725464859273; Wed, 04 Sep 2024
 08:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com> <20240902120314.508180-4-linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-4-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Sep 2024 08:47:03 -0700
Message-ID: <CAKgT0UfqH0tyB0tWavkx2cE+1YhW1ZGhqg271=s8_hvSCzQkpw@mail.gmail.com>
Subject: Re: [PATCH net-next v17 03/14] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> We are about to use page_frag_alloc_*() API to not just
> allocate memory for skb->data, but also use them to do
> the memory allocation for skb frag too. Currently the
> implementation of page_frag in mm subsystem is running
> the offset as a countdown rather than count-up value,
> there may have several advantages to that as mentioned
> in [1], but it may have some disadvantages, for example,
> it may disable skb frag coalescing and more correct cache
> prefetching
>
> We have a trade-off to make in order to have a unified
> implementation and API for page_frag, so use a initial zero
> offset in this patch, and the following patch will try to
> make some optimization to avoid the disadvantages as much
> as possible.
>
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.c=
amel@gmail.com/
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/page_frag_cache.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

