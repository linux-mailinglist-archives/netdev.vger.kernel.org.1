Return-Path: <netdev+bounces-70205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90184E012
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB328BD65
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEF66F52A;
	Thu,  8 Feb 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTd7S+KM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD36F50E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393361; cv=none; b=Zm2AUgXx1v/4bdwThys+5jpCANCZPdCsubcSKuqNHKvKVA1oHTBsivOoc8tO+7BqgKN6mFbs5mLc7slvQKUSHlKws8x6l7rdBQlXGNWyEhBIsIgGxI81PJ8mqmz4fCfWGeA8LhTbXHx1yuXfPrVeWKoBZOzLHGZBqlxOJsxwzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393361; c=relaxed/simple;
	bh=PhxqlGCQVahpYaTS8jsvTTbn1IvHZg9K6+iprbOR+dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5Q4kX062Voe5BPhdM8VvmVtywHlo5+ggi1fZZveqRXFLliKznSdHYOH5TEwtlbXX3K5uHZ8ZVz3c7JuTY6mjdxJw3FhD+DWaaq9S2itKyjaRCvEdu+4xnKEtkfpzGqEmkoWOGVbr4N6nG4hQCFpk8Lq8rvYAkQlXJ1mJxExVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTd7S+KM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707393359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jg/0fTFNggfpZwmCnuYpwAYvhdiQPUN70zcGdH2CZV0=;
	b=OTd7S+KMUF1BNvgGZufE/IHuVByivy8+GPwlGWnIkMMkp/0hC8Uvh/MuogNtTdfUrE14ph
	UB4JX9kZxaS4NYrCOjuhq6dOQXQA+IJYG5iiLR2DFOLcTkZbQRNev//EnO7d91unsC1xod
	JPp+IItxiq0ci+3wnfLfalVZhZy6GV0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-4WWvMoSQMZ-ieluxYUCDgQ-1; Thu, 08 Feb 2024 06:55:57 -0500
X-MC-Unique: 4WWvMoSQMZ-ieluxYUCDgQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4103bb38a68so1044345e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707393356; x=1707998156;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg/0fTFNggfpZwmCnuYpwAYvhdiQPUN70zcGdH2CZV0=;
        b=XSRPzCcZFELIlatT465W+Ld7j2iiBJgH8avyHI96KaprEfUl4RD77GNG4BA6ohWrVL
         ubzzINTiYlxtzTy2yHLG2NwM8wLjWJ0cqMXxOGDz00ERiDroOS2B1o3EMx4WNjV75mG0
         POwl4h4bjUuFoC/1ie6GoKIoox0eswZooy4weuMzdHqqNWe3Pnt4WMvqKYIE/3CpueAv
         aijMvKdkSvpExSXyxPr9HH2hKfndF++HWUHEBOtkj3h3r9ZPZrN/Kus255kX03RDx+2N
         uZNmk110HFTa6NeMka0/DEXZG2VUQ5g4p7sBq0EnhYnc4gkxRS/bppswETIVh8AigGXC
         YUrw==
X-Forwarded-Encrypted: i=1; AJvYcCWW3vUnFMCDaFydBEstYwpY9hplSBofrxAQ3a09+SLtwi1u9N8FsQgebSOkKp2N834YzmZ0W5ujbdmfp41XL3S0R6laUI62
X-Gm-Message-State: AOJu0YwDf4LxenL+vKKKmnPbH4YIJUfnkMq4vjIfQkcnIyixd58o/qMS
	66LYl30YYY4GXPXg93HdyT2/cPaSCe6fXwVs82rlYAFI4kPQeVWRESBidFsHBD1JX8iofJyIEs+
	YgZM7UzfOZPsmpZ4zA2pc+wJ9gerv5x2nRnFYgPpQfUQkUVRYErBeFw==
X-Received: by 2002:a05:600c:4f54:b0:40f:cb55:37db with SMTP id m20-20020a05600c4f5400b0040fcb5537dbmr6604482wmq.3.1707393356412;
        Thu, 08 Feb 2024 03:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQdqqvXZCvN4Hmb4UMvdhmjiE/P6SFfG4MZ0zV9GiP++3X8pEY6u1EzyqOb/FR9EqPRKBoA==
X-Received: by 2002:a05:600c:4f54:b0:40f:cb55:37db with SMTP id m20-20020a05600c4f5400b0040fcb5537dbmr6604463wmq.3.1707393356028;
        Thu, 08 Feb 2024 03:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm+xrBDBLwMjfxNm9wJnoK8hEtnLk42xQfnhYkZGLwk63byu5alj9iCSKqwDzGtKawzxzZKyrL8rM80tbTK1A8Hnci9xIELyGreEkq50EZTfT9fIusBpa0mGj+kX5ibEHOh4kupWkq1uotcXSSkc95off3qVX7/5JITucSzqpci7ld1iPLWrkN8wXVJeZUCkfUuz/FXlUG124Sf3d9/BrZ65TsihPFqZdBeZPLfL5KpQdd7lsj+VRh1sD46ZX4O+XWamJpExL3sHfChpEj8f4auo9T5dnt/uf9NvYJCZ7D2M4gwHdxQn5zHvWrJ5Iu2g8Epf8/hAYjaJc=
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b0040f035bebfcsm1414697wmr.12.2024.02.08.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:55:55 -0800 (PST)
Message-ID: <f8f40c760f274a7780c5ab491e7eb75e9ca0098b.camel@redhat.com>
Subject: Re: [PATCH net-next v5 0/5] Remove expired routes with a separated
 list of routes.
From: Paolo Abeni <pabeni@redhat.com>
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org, 
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net, 
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 08 Feb 2024 12:55:54 +0100
In-Reply-To: <20240207192933.441744-1-thinker.li@gmail.com>
References: <20240207192933.441744-1-thinker.li@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 11:29 -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>=20
> This patchset is resent due to previous reverting. [1]
>=20
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tr=
ee
> can be expensive if the number of routes in a table is big, even if most =
of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The size of a Linux IPv6 routing table can become a big problem if not
> managed appropriately.  Now, Linux has a garbage collector to remove
> expired routes periodically.  However, this may lead to a situation in
> which the routing path is blocked for a long period due to an
> excessive number of routes.
>=20
> For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp:
> drop silly ICMPv6 packet too big messages").  The root cause is that
> malicious ICMPv6 packets were sent back for every small packet sent to
> them. These packets add routes with an expiration time that prompts
> the GC to periodically check all routes in the tables, including
> permanent ones.
>=20
> Why Route Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Users can add IPv6 routes with an expiration time manually. However,
> the Neighbor Discovery protocol may also generate routes that can
> expire.  For example, Router Advertisement (RA) messages may create a
> default route with an expiration time. [RFC 4861] For IPv4, it is not
> possible to set an expiration time for a route, and there is no RA, so
> there is no need to worry about such issues.
>=20
> Create Routes with Expires
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> You can create routes with expires with the  command.
>=20
> For example,
>=20
>     ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \
>         dev enp0s3 expires 30
>=20
> The route that has been generated will be deleted automatically in 30
> seconds.
>=20
> GC of FIB6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The function called fib6_run_gc() is responsible for performing
> garbage collection (GC) for the Linux IPv6 stack. It checks for the
> expiration of every route by traversing the trees of routing
> tables. The time taken to traverse a routing table increases with its
> size. Holding the routing table lock during traversal is particularly
> undesirable. Therefore, it is preferable to keep the lock for the
> shortest possible duration.
>=20
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The cause of the issue is keeping the routing table locked during the
> traversal of large trees. To solve this problem, we can create a separate
> list of routes that have expiration. This will prevent GC from checking
> permanent routes.
>=20
> Result
> =3D=3D=3D=3D=3D=3D
>=20
> We conducted a test to measure the execution times of fib6_gc_timer_cb()
> and observed that it enhances the GC of FIB6. During the test, we added
> permanent routes with the following numbers: 1000, 3000, 6000, and
> 9000. Additionally, we added a route with an expiration time.
>=20
> Here are the average execution times for the kernel without the patch.
>  - 120020 ns with 1000 permanent routes
>  - 308920 ns with 3000 ...
>  - 581470 ns with 6000 ...
>  - 855310 ns with 9000 ...
>=20
> The kernel with the patch consistently takes around 14000 ns to execute,
> regardless of the number of permanent routes that are installed.
>=20
> Major changes from v4:
>=20
>  - Fix the comment of fib6_add_gc_list().
>=20
> Major changes from v3:
>=20
>  - Move the checks of f6i->fib6_node to fib6_add_gc_list().
>=20
>  - Make spin_lock_bh() and spin_unlock_bh() stands out.
>=20
>  - Explain the reason of the changes in the commit message of the
>    patch 4.
>=20
> Major changes from v2:
>=20
>  - Refactory the boilerplate checks in the test case.
>=20
>    - check_rt_num() and check_rt_num_clean()
>=20
> Major changes from v1:
>=20
>  - Reduce the numbers of routes (5) in the test cases to work with
>    slow environments. Due to the failure on patchwork.
>=20
>  - Remove systemd related commands in the test case.
>=20
> Major changes from the previous patchset [2]:
>=20
>  - Split helpers.
>=20
>    - fib6_set_expires() -> fib6_set_expires() and fib6_add_gc_list().
>=20
>    - fib6_clean_expires() -> fib6_clean_expires() and
>      fib6_remove_gc_list().
>=20
>  - Fix rt6_add_dflt_router() to avoid racing of setting expires.
>=20
>  - Remove unnecessary calling to fib6_clean_expires() in
>    ip6_route_info_create().
>=20
>  - Add test cases of toggling routes between permanent and temporary
>    and handling routes from RA messages.
>=20
>    - Clean up routes by deleting the existing device and adding a new
>      one.
>=20
>  - Fix a potential issue in modify_prefix_route().

Note that we have a selftest failure in the batch including this series
for the fib_tests:

https://netdev-3.bots.linux.dev/vmksft-net/results/456022/6-fib-tests-sh/st=
dout

I haven't digged much, but I fear its related. Please have a look.

For more info on how to reproduce the selftest environment:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-st=
yle

Thanks,

Paolo


