Return-Path: <netdev+bounces-92405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081068B6F72
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACE4B20AEB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34939129E66;
	Tue, 30 Apr 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujiw2/sQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629D128828
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472278; cv=none; b=n2zSJHxASu48zZrj/ffUu1OS1F0Y6P5EjP1GKjpleP7Ec+9YqfcGGgutvry/NGef69PpWayJIM2r47RuBbFIhImAN7sj6AZN3aHELmb1mx+X+eg5/YlXreBa8nU272c+ULcVtte0x8F3npnYQ2iI9XIY5JemkKEdRD+R1OBxRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472278; c=relaxed/simple;
	bh=DxCBfW2ZX60itdmD+i2ZLg8FWHGDeeOaWCry5xKcra0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rES6PwPwQiO9g7LNL3bpHnB9Yxx9UHLBTn4rHJV4OAHbZt9J53Kgq0LbqsLel4mVTiAuTjTrIBUlitOVdd9JN7G77okVxRQwk8IxX8KAvbMmQpYL7HoqgfXEl5L5xiym6odiaEBj6faDG+71tlz0cJymbfEEbh0zBKOy40wW9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ujiw2/sQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714472275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgfcDzbL6BdRnbQ/LMHjtoVFL3IiamXBZRn2Dk0E7Y=;
	b=Ujiw2/sQhjh+EbZy4TR39jWD5+NwqeMdhfkKbOa/OrMp4zhhhQh/EddZ3JFxyOkWX4R2YA
	bBkHOTwXnxoqpOxEvzWWBIvNm0BBHZQrYWUSlKJ1Iligbp9udvhNhbTzbkb4XAMoKBkpRl
	MzuBKqxJ3Jv8Vb05vKShetFOdo3ArYU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-KU2E0nyqNu-Mf6JBMH1UCQ-1; Tue, 30 Apr 2024 06:17:53 -0400
X-MC-Unique: KU2E0nyqNu-Mf6JBMH1UCQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso6823490a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 03:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472273; x=1715077073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WgfcDzbL6BdRnbQ/LMHjtoVFL3IiamXBZRn2Dk0E7Y=;
        b=azfXHrS/+iQVx69G7l2YMxw6aw4xz9QvGc4qyTGK3tdRMNkNdRTezeKQffzs/DiRVK
         orcwouKFOqNsnfK2ACJVgkwBUYFAlrHm1BReTcaXt72lXj/KUluuiNuTTHjlNP3HUNaB
         4FMS1vY8DirbNPTixOn3x/gFCLMyO4nzBYCccH6iBdIB7Jl18yKyFInWk/rj0GzRhwUR
         tSXFcycjIWsarRiboqD84OfCbJ5g2m/rDnIEN2YX0tYqSpKqHTZE9kBnQNw7h9uT++W3
         oh56xdf1aJEqc/R/6asoppM0pwdof5Hxph/NZtCsnkoZ4IKWDgp55QY57tUq60yquCCh
         XEHA==
X-Forwarded-Encrypted: i=1; AJvYcCX2bSKcAT7QtrpT/Fg0zSYu16vmeEoy6WRe+Pyo2lyO0VSgkY1ogznbzqte7WMeUbH9CFa6Nu9rYP9duRwbtxgSkgerbZBq
X-Gm-Message-State: AOJu0Yx6eeWSOJpW8yGyCXwx8BEYnKd6iptlT+P6FDSIFYsaSazI/Mza
	0n31N9rQSW+G42jRZCDgdVjqiyJ+am1GgOu/YQsiehF0bzM2bCTx657zLZFIKaIQv8hroiJNjKV
	Rf1eUNRsyJzNs/inzMD+PPGn6TWdedOLtnpurmXDewm3QVw6GjD0ygi1xBsVNLSxL45V1PhrWhg
	jXhujxUijq7zDRq9POVAUopWdxdRYD
X-Received: by 2002:a17:90b:3d86:b0:2af:4f4e:79a7 with SMTP id pq6-20020a17090b3d8600b002af4f4e79a7mr12470174pjb.30.1714472272816;
        Tue, 30 Apr 2024 03:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWSpkNXoLaxHPhUhC5NZ72tcHc7cFhFDuXAR7cTPWqMf81MdK6/Q7OPe/FNtSys3J7tuhnJJXuDUF4sBjb72Q=
X-Received: by 2002:a17:90b:3d86:b0:2af:4f4e:79a7 with SMTP id
 pq6-20020a17090b3d8600b002af4f4e79a7mr12470138pjb.30.1714472272243; Tue, 30
 Apr 2024 03:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
In-Reply-To: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 30 Apr 2024 12:17:41 +0200
Message-ID: <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com>
Subject: Re: selftests: tc-testing: tdc.sh: WARNING: at kernel/locking/lockdep.c:1226
 lockdep_register_key
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: lkft-triage@lists.linaro.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, cpaasch@apple.com, 
	pabeni@redhat.com, xmu@redhat.com, maxim@isovalent.com, edumazet@google.com, 
	anders.roxell@linaro.org, dan.carpenter@linaro.org, arnd@arndb.de, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Tue, Apr 30, 2024 at 12:17=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While running selftests: tc-testing: tdc.sh the following kernel warnings=
,
> kernel Bug, kernel oops and kernel panic noticed with Linux next-20240429
> tag kernel as per the available data.
>
> This build config is from kselftest merge config[1].
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> selftests: tc-testing: tdc.sh log and crash log

the problem is created by [1]. I think that at least we need to guard
against failures to allocate sch->cpu_bstats and sch->cpu_qstats,
otherwise the dynamic key is registered but never unregistered (though
the key is freed  in the error path of of qdisc_alloc() ). But there
might be also something else; however, I can reproduce some similar
splat, will follow-up on the list.

sorry for the noise,
--=20
davide

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3Daf0cb3fa3f9ed258d14abab0152e28a0f9593084


