Return-Path: <netdev+bounces-127487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34A9758E4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA3C1C22954
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADA1B2EED;
	Wed, 11 Sep 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMGgT4Aa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D51B1D4D;
	Wed, 11 Sep 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073888; cv=none; b=mc9sBLHVXeiS0D5wTBV5MgVeHb5+rP07tYjKOACI+F6mEoB5CHvtRfvFIPBf169gvi8d3x33t5JUYIoGTgY6dKdujnsrz49hxBxMl/bdDM9KuTxG6nKFY/pQTLBQsrVBotgiPI5OhNY/ViEG8lEVhTleThJb+ipGC7AZQwl1VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073888; c=relaxed/simple;
	bh=HDKBnNrLeugSfcUGz5guqCEocPZFuWf7x9MowmoTPQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3hUQTwmPtRdARkJeT+AAkAoE6MdOHvDFxx4+/7YVj+RIIKtX4zg+TtLY6cO8na/wBRsE0aCm7KvavCSDADxNzLCTqOE/3+rwIhvtBxawBEvZMU00ir6iLhGCuA98cMQ1yd/v3LtbVYqj0h6O/ZPrXWFig4uu6TbjcN0GNR4xSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMGgT4Aa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718da0821cbso4664b3a.0;
        Wed, 11 Sep 2024 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726073886; x=1726678686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jem+MWmSZgTwzmfsjmXOeo9Hmc7HT6o2YcnpXNuPRq0=;
        b=XMGgT4Aamofdo1kV9htxkTl8aBVHV9tPOxfRW8J43M590fUPJyG6AlTBO5LkGRvpES
         Dr52nVMScMQyLTvCks7uhrVkuwGZ1dnzmze8bDgWzVNvaM+txDvcqCRHxJX83LIzSgcV
         OfkGY6UAWZ/dvLgF2UcZYBlKtn1NZrBN8cSNaPX2fKNZ2R3JxmSJIu8arpfj09ED8Pq0
         vCinLzp/P6NhHXtpUYnFAoG+A5QkbxnH5K+JMSepTVumGeyQDORV5XXAa6EBEtwfiRRC
         0RzwlbvrAeoFTnTU9i2xb9iVGcpPXsVlFQqVIzyqJ59Mb+DQYLZuqQ0RdyEAP/m33TIJ
         Bglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073886; x=1726678686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jem+MWmSZgTwzmfsjmXOeo9Hmc7HT6o2YcnpXNuPRq0=;
        b=ZveUk8e+2jBK+E7qsqEnYEAEoaJbcf1/+Xjv6mEnWsihOggNRBIUhGnl0kXoFkHhr2
         9kIU85VmMzulhc73n6DMH+eYYWZff3dJM6yhayhRjrzJpATzy8K2pfWnHOWHcjV12Vc+
         QTN+q9J7VqN9qjPE/zP1p2MXu7AOikdsGQiYskobQ8HIikGiuSDu7oHFoBCrc0/EfZiG
         0r3fLEtichP1WysUPhazSWKGjL/jMJ/oNtO4QGyNaTbO/Of1Xpr7QgvZuCWXXbCR99QL
         Kv/k9y2oRekhaZACVDYZho95Id7UX8JM6XU37N0sVzJ+1MseWCK2jWntiLznn78YtO+k
         9u/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMPeIMZA51D3KmsPRyvoMP7dJC+qWyL3O9gkwOfitJy1XMZ6ZZrF7leUx9CJO34/4HtmBcp/ft@vger.kernel.org, AJvYcCVy695llh1n+VbgdRZa5uZJt+yuvVepwkrDJmxIFK/mjL3TeBMLy63TCOu/g7ndvHWuy2TiKwBqcmVgSfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPay36RMrjhEQ1qrrxbtSazXjoo0vTVWISKDXqHN5m40rYzdE
	AgNBrImDIu/fQvRXLrXydXcVV0TwAtPFdoxGMp9iQ/nf6pzqKl3X
X-Google-Smtp-Source: AGHT+IFC79NNEx/8BRMrwdidGrSe1mxUX6EiP1JjXOOqyq91OdLAosFqzjBWjcOKV6zC/ixvChQABw==
X-Received: by 2002:a05:6a00:3e17:b0:718:d5e5:2661 with SMTP id d2e1a72fcca58-71925fa9e96mr91926b3a.0.1726073885706;
        Wed, 11 Sep 2024 09:58:05 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6166:a54d:77fb:b10d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c5349sm3196790b3a.191.2024.09.11.09.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:58:05 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:58:04 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuHMHFovurDNkAIB@pop-os.localdomain>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>

On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> On Wed, Sep 11, 2024 at 10:23 AM Qianqiang Liu <qianqiang.liu@163.com> wrote:
> >
> > > I do not think it matters, because the copy is performed later, with
> > > all the needed checks.
> >
> > No, there is no checks at all.
> >
> 
> Please elaborate ?
> Why should maintainers have to spend time to provide evidence to
> support your claims ?
> Have you thought about the (compat) case ?
> 
> There are plenty of checks. They were there before Stanislav commit.
> 
> Each getsockopt() handler must perform the same actions.


But in line 2379 we have ops->getsockopt==NULL case:

2373         if (!compat)
2374                 copy_from_sockptr(&max_optlen, optlen, sizeof(int));
2375
2376         ops = READ_ONCE(sock->ops);
2377         if (level == SOL_SOCKET) {
2378                 err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
2379         } else if (unlikely(!ops->getsockopt)) {
2380                 err = -EOPNOTSUPP; 	// <--- HERE
2381         } else {
2382                 if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
2383                               "Invalid argument type"))
2384                         return -EOPNOTSUPP;
2385
2386                 err = ops->getsockopt(sock, level, optname, optval.user,
2387                                       optlen.user);
2388         }

where we simply continue with calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
which actually needs the 'max_optlen' we copied via copy_from_sockptr().

Do I miss anything here?

Thanks.

