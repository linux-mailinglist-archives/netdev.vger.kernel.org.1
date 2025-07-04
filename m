Return-Path: <netdev+bounces-204001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54DAF872F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66412486DD7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86141F8728;
	Fri,  4 Jul 2025 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q87PzcII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588851F4C8E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606573; cv=none; b=U9jf8upxbSRnwUyVVSEMhe0At4SqkgMD/RsCPUk/R1wyX5JF09gP1xtwA7FptaYN4fj0879KXp9QriywXG5EuJQU9M3RaLhKV132/Q0b/cZo0t2kITDKItYAdyCYR7BsRRwYp2J5xUQDJzgXnwcZfPwqCKg41amIuL31dzbIgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606573; c=relaxed/simple;
	bh=+boJThdlKqfmBwvZYrrLLbALloBXGFMiCi1pxJTUDuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igpuzOXXhmdctF7siNyabkdWjKRPmD19ujVlMK2Ce0IMFfofwYD6NQ6N5YP/63ZQ5cr/QiV5Bzg+KBiPtouSiSsmRocLOSJalFTF2VGfJXwED9z4A7rBE9mBzvTJ/g3SFTeIna1DBalGn2F6xIMJjsbG7NtgjP9QW1yyjjGIoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q87PzcII; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a585dc5f4aso7307631cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 22:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751606571; x=1752211371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtn7MCRvr7mqmOBEdvHKnoAnHvjzH2ABPSrAJ9kWfz4=;
        b=Q87PzcIIJq/gke9eGm36RjknSc4VI7gMIPLveXDP4ifuoQyhaN1S/YXa/DOE5b1Hwi
         fRkGGHEm885dSoOaLRd3qLwT6wMrtDnbggprFTfQrwKeVDKM9nS8Exnq7bFmxsHRkc6l
         pcHmik8i9BlrIe98/ez8r80xtgk4vN5y6wofiwUvPKHEw/rFmE/7mwQji3KcgjWeAeXg
         N/HbjiwDNtbifbqIxD7Tze+J83TxCKUwAMiTikJNxRSq05qwgeYbZ5SqvTn5NzOHljjn
         4WmHdQRKanr9CfI8VDxGsAdE9R8NakGwkCupu27jxQchBH1ZoPpsaaC4aKvGQ9pnwnE5
         MO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751606571; x=1752211371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtn7MCRvr7mqmOBEdvHKnoAnHvjzH2ABPSrAJ9kWfz4=;
        b=jfac5R9XCRdj+u6UFsEy9pkobikZcLp7e0N9jhQvKjIyGI2HUg2E5lwhVqQvhupFv6
         gEfq/PM8L0t/ADf8UahlikkztG3OL0SKPMfNJr8jOUVu0wTKVBE5crV8cgchO7AHMvZg
         2IsltMnywwWMUcbKgiGjFe2GZP70O5znDiKhJbzt3EghhcXf1v+kHN7AtNdP5xbZIEHO
         aNlMdDV/hW768v+/gpZhyV/Lwx1nlJm9m+yx4V+Pw49FLVz6f8Pq9ypnP534C/DmxcsW
         uFCWE8GDl4kGQv+HobEw5Ir5vQSrD91Cjrfjxpbm15VbOMPwJBUjXeBQzfPRot0bxuvt
         7rNw==
X-Forwarded-Encrypted: i=1; AJvYcCWqSMu78qAQ27Q5QKfI/8otsj1URR6+jH8cIonEKCMmAns6jUZBmuoJTInrMMvYlXHxpr8IAnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqY7uGaj+1AzJYMY0rW+9ku8E4u8rxxL6UiTxo9J8XQ8Mh8Hw
	KQ/Mkz/9xQLJJVG/gOC2tKdhdSC+Dj0SAOYhfvsEpQXvWABJJ4QxvTTgjKcNKKM57VYAphqcRyu
	mZjopQe5KZpFm3BPTRxBM8bC883UuM2e4tmX9Wq4EBHkwIWVieBOV6NT85Wo=
X-Gm-Gg: ASbGncvGvMlalNhgnc3T0/JnHq7z9QmDfgDij+NtlOMctaL/RmwUl8BmURtyVjP3RP1
	4Gpy+IjVoGuJr4W/l0S10UUyGVe9bvUbR6mjF02Bi/KwBlVB7thWIoYxUv4UmktZST6uEw9Px6j
	TETIQGo6R+JHeUVqPR2A0Ip53dhTTTibK6Fk7CWh8gPVU39cb3zdLROCQEBePHoVbZhj1PQbyxy
	LfSgQ==
X-Google-Smtp-Source: AGHT+IGHtApTLA1ZaaThYHX7g2bKOX+Vh9u6B7P2Xq7//vcIZtv+7HVCyoZ99whqFjsqvU74dbndyqaBWJPNbaUz6yw=
X-Received: by 2002:ac8:5e07:0:b0:4a7:ba7:1a2d with SMTP id
 d75a77b69052e-4a996404a7fmr23356041cf.4.1751606570989; Thu, 03 Jul 2025
 22:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5CB8EAEE13F1E94F2203F0C7@qq.com>
In-Reply-To: <tencent_5CB8EAEE13F1E94F2203F0C7@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Jul 2025 22:22:39 -0700
X-Gm-Features: Ac12FXz8pyNISWhkmxKk8VHE4NRewQ2YjBUGeo2x92wPPJSmOxZos9HtErFZIRk
Message-ID: <CANn89iL2jGPyPhha3J8y_FV_31tGHJ4mQSSvyewcPh4dzbOVKg@mail.gmail.com>
Subject: Re: [BUG] Possible Null-Pointer-Dereference Vulnerability in
 udp_gro_receive_segment Function
To: =?UTF-8?B?6YK55oe/?= <21302010073@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, dsahern <dsahern@kernel.org>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:20=E2=80=AFPM =E9=82=B9=E6=87=BF <21302010073@m.fu=
dan.edu.cn> wrote:
>
> Our team recently developed a null-pointer-dereference vulnerability dete=
ction tool, and we have employed it to scan the Linux Kernel (version 6.9.6=
). After manual review, we found some potentially vulnerable code snippets =
which may have null-pointer-dereference bugs. Therefore, we would appreciat=
e your expert insight to confirm whether these vulnerabilities could indeed=
 pose a risk to the system.
>
> Vulnerability Description:
>
> File: /net/ipv4/udp_offload.c
>
> In the function udp_gro_receive_segment, the variable uh is assigned via:=
 struct udphdr *uh =3D udp_gro_udphdr(skb); However, udp_gro_udphdr() inter=
nally calls skb_gro_header(), which may fall back to skb_gro_header_slow() =
and potentially return NULL. If that happens, uh will be NULL, and the subs=
equent dereference: if (!uh->check) { may lead to a null pointer dereferenc=
e (NPD).
>
> Proposed Fix:
>
> To prevent the potential null-pointer dereference, we suggest adding a NU=
LL check before attempting to dereference.
>
> Request for Review:
>
> We would appreciate your expert insight to confirm whether this vulnerabi=
lity indeed poses a risk to the system, and if the proposed fix is appropri=
ate.
>
> Thank you for your time and consideration.


Callers of  udp_gro_receive_segment() (via udp_gro_receive()) are
udp4_gro_receive() and udp6_gro_receive()

They both bail out if udp_gro_udphdr() return NULL.

If the first call to udp_gro_udphdr() does not return NULL, another
call to udp_gro_udphdr() will return the same value.

I might miss something, but I think your tool has a false positive.

Can you double check ?

Thank you.

