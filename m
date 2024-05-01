Return-Path: <netdev+bounces-92746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E08B88AC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BD3B22268
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7753E2B;
	Wed,  1 May 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzRkTH4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9733CD1
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559906; cv=none; b=J4LCt/3oK9QGrm3ciESVSs2fSZ32HaEE3yDl4+0XvbFYUR5CS2Kmxw180Jyx7ueLsZkd+qI2TlHoI5tQyi/U/HDuMzG2WG3iwug36iAlhJ1nfIUK7FJBdrVJMB3e2c/RhWgcbd4P64UJQ/oWZwqjh28hLJ6MPfpeG793ix6DZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559906; c=relaxed/simple;
	bh=Vm0Nh0YwH2dMlOS72W8akU7dlqKus8e0Xtt0wq2E2jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRFvonrP1QPPWflkAFIUOv3/CF6rmoqzw+ZREuJ9uXl+/1NaBSpuMQLjiGbSZCVcH66yJKmcGCjMNnyqIXi391lwXBkNCa3aBdYsNjAXwvPSHySKOf36ETUS/ohzDVJeRJEsPpBKcPKaktOd8oFZ9TfaD8v+yvTMVDlSURj8ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzRkTH4z; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f18331b308so514832241.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714559904; x=1715164704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm0Nh0YwH2dMlOS72W8akU7dlqKus8e0Xtt0wq2E2jc=;
        b=WzRkTH4zMcpHW9Lk79IKi+N6vNE/giKFu7o2tmUWr2g0C8zBo/eJb2cxnl55dDgVMJ
         Z6RafypCQytBQG/uwQ/MS6CNfRUjXlYz+GuZU6dS5sl0vf4XFTgh6t2BpBplQyTQkpuy
         GrSSKehsOyT/YNijQXtubWUR+NE+u0dkp1IRUsDAkyDZrdeQR4gUsoyVwpPBP7qImIKE
         aHegSooKPtrUS/v1epdQz78I/9Cp1lCn/DOSd+zI+iXlwCrymQcsDsOSunWy07QEXBbg
         zZjAXTY1kg+WYBA20lYYSaVCnfFEkbGBIR2BMX9wIzgaLw+6Lwscj7y4Fqo/RwGQsuH6
         H+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559904; x=1715164704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm0Nh0YwH2dMlOS72W8akU7dlqKus8e0Xtt0wq2E2jc=;
        b=o+X0NTZXwtD/dhj9XAUEWBnGX/kowQM9yei4jDu8o5lB5R+1Wearu17pQCOGAnZtw9
         2t89wSJUomhaQStLaxPGlHLHVOxwcO6aI6hTRwmNLa41wXyTIHqCsKNutT/543SGq+TR
         tPY2v7MWTH6ZqGBv3pkOxNMA1C4VDpRYXgYAMTVp6SEEZGQ8PV8gnobrXnx+01IM1LrI
         BRpwIZZtC8KoqIYJnbf3Lq0+DYrzikq9Igv7N/KLykdWM/lCnLKWIIhdnfTDinXlsF3U
         U3AZExlHkp6SMUXXscaQRrNN+8b6imhKp44uxoMk8UEy6gtOQyOADwXAyyf8WhdcJxxp
         kg2A==
X-Forwarded-Encrypted: i=1; AJvYcCXUS3Ajl90vVlSgyfhjeHq/NpSudzy4Y7LG1i44pKqagK1eQYt+490wBzL3N1l9V8wK5sqryF6amwn7F8vle8ui8RUvNi2V
X-Gm-Message-State: AOJu0YyfNI1MoLyn7qTxpxIadoyHr7+Ix0r9M+P0KNspfHfNvCP+9XKk
	Y1q9o7sCw8oTFf356btvDqaNNc/zKcoZFV4FwpVKykIFbuJawwGmO7QEAC3opnakmH5KdQQTZ7I
	QlLDyMbsLElbNy7NhrljtwhZ1uclCF9g3lhsKDg==
X-Google-Smtp-Source: AGHT+IEGNKX8lh7a27bETLjVFTE4scF+aivuBemZA7t4rVdGAWmtak3q31SYiLOpMzcf30IiB9w/UQ4JjVpSVqploDg=
X-Received: by 2002:a05:6122:2501:b0:4c8:8d45:5325 with SMTP id
 cl1-20020a056122250100b004c88d455325mr2337396vkb.7.1714559903797; Wed, 01 May
 2024 03:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
 <ZjIY3hkW8dYRPzSI@shredder>
In-Reply-To: <ZjIY3hkW8dYRPzSI@shredder>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 16:08:12 +0530
Message-ID: <CA+G9fYsZ6ZNxyhkVq=7UV8W3BxOpD7w-_5==ZERN8=my0ij=Tg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
To: Ido Schimmel <idosch@idosch.org>
Cc: Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 15:56, Ido Schimmel <idosch@idosch.org> wrote:
>
> On Tue, Apr 30, 2024 at 07:11:13PM +0200, Davide Caratti wrote:
> > Naresh and Eric report several errors (corrupted elements in the dynamic
> > key hash list), when running tdc.py or syzbot. The error path of
> > qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> > to unregister the lockdep key, thus causing use-after-free like the
> > following one:
>
> [...]
>
> > Fix this ensuring that lockdep_unregister_key() is called before the
> > qdisc struct is freed, also in the error path of qdisc_create() and
> > qdisc_alloc().
> >
> > Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.kamboju@linaro.org/
> > CC: Naresh Kamboju <naresh.kamboju@linaro.org>
> > CC: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I have applied this patch and tested.

>
> We've also hit the issue on two of our machines running debug kernels. I
> started a run with the fix on both and will report tomorrow morning (not
> saying you should wait).

- Naresh

