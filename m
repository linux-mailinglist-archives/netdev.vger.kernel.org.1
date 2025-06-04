Return-Path: <netdev+bounces-195135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA7ACE2BC
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58104169819
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630B1F4CA0;
	Wed,  4 Jun 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpmMt7ik"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336481F2BBB
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056623; cv=none; b=mzbWA6xxuOQE6Ulod8u1ZDl3h8xmyx42T0pnTJnCaje3r6cZCO7GQ1sVWq4yd86ehhTlJn914nwK0vJUp3Adg/pfmoMl9Tjs5eSQAD+zdFnICNg3IR6LR1rwF0tbHRKkuYRrM9Ql9v4EYFlKxBHKF8Qc4U7wZOVK7O+y7azn0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056623; c=relaxed/simple;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCrNV4zgqWj+HndXdM0zvdAdFKdO4RrFf0S+ytJOpcsFxwVQOPdIIVHLG7GjNVzoE3peem2GjQ2n36LXYNxG5yKHuPN/ii2ZWg6fzhjMmfFMShSIqHjo7sYU5aLGZbEns34SvzVahPChTEaT1ncJQSuVSE9wWHpoIilLcSzrLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpmMt7ik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	b=bpmMt7ik+S8LlV0RjRynQNWU/bEj9cAUes9smFKlQWKQxWICUEyqLO0OEBcNrAUahtxWaC
	fGCx5n2G5tmyI/lDMIlo216shPvRpTfb/aCgfQxcVLE47v0WyFLn9+gb4vb7qzyHi2OCks
	bnhiN6MgJ9tf/4WZltIkKaL+oNMOPhE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-evCvs3QUNSmOJKIUbfSqsA-1; Wed, 04 Jun 2025 13:03:38 -0400
X-MC-Unique: evCvs3QUNSmOJKIUbfSqsA-1
X-Mimecast-MFC-AGG-ID: evCvs3QUNSmOJKIUbfSqsA_1749056616
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32a6c630b70so234891fa.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 10:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056615; x=1749661415;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
        b=OTRxC9FZVPaum5jdmeGe6tWS5I0OIJ6UbIvFPQj9hNlueRmw12UMwpcf6aczOcRXHR
         rz4f58rSgaybm/hdxYanLuTmzlgl0N9+0D1lfWGmi2Ul5qlQm7Hys3tDULASwu/RdsY4
         rNdGnJWv1r6/lyH+v/LX+ZYrDd7wtFkLz+M6zVU0ugfSJpfYb11sRh17l52PRFr5i4lx
         CtpxyEG9IczkL6bP4Oi94v8lyc0hVl+9U7K4YeD8+99UTqSTqTT3GtUKm38jYwNaSjNq
         zT7dsephS/CaN3EqLP61pA8fwKxALD+90CX2GacYp8ApXzPjI02jw2iPXO6zuMnmHROg
         rYDg==
X-Forwarded-Encrypted: i=1; AJvYcCXMHMkWe8hViDpRG0voA6HHkGbAUjSKEX9H3KXVNynHSArOgq0ZdFrS6SskkwqLaQKEn5Ite3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfA1qhwwBJh+tY56YIxyR3jnLSNcSWJg8a6GZXIIKsmF1nig6x
	kjjILGllm+Nu4E3juXUw3nnkZDaJXfdZ6IeSzKIO3L1Q6EUTj/K7wjsB8nmzzuMdVnBU89vM3Jx
	KTdvEzixCHDRTmL1upsGXjIUahMHNneuAXay4gE04nNWQW+f58ego5etl1w==
X-Gm-Gg: ASbGncu1hBBj6TglmfZMw5D0b+zJkzqFOWHBpyr4rK6v/antUBYLgcqpisH94HailcP
	7W1gQHPpjuzdjHJMwkQXjOL49UFHAtuR1kGLgi6pEBmP64hPrHCankuSby7/IBZLDODQjG7eYyb
	AKyk4uFHAMdetoLjOU2VeX7AdWN2uCMiU21YvyMBO5dPOQU8qe8xdmIBSzcgz5fYwBAgAqNFnyA
	TkRYcr0roAJgUpU7f3GJib20KXfZSqXTlkoSkVx8BHR6W7WZVvq0wr/dG4hkIxhl36wuEcULcnE
	6Ga37IxGR5ImlO/1wyFmEmcXFP7u4go/r1PECLzZelHEL9c=
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11790121fa.19.1749056615304;
        Wed, 04 Jun 2025 10:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvowgSTP9uwRV+BqJt6GC7sN1OE+Dwxjsqttfw8aGqFJyzPj9td+LDCaCRBwp+P5agViq4g==
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11789411fa.19.1749056614743;
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85bd26d7sm22115981fa.106.2025.06.04.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 74C7C1AA9173; Wed, 04 Jun 2025 19:03:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 10/18] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
In-Reply-To: <20250604025246.61616-11-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-11-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:33 +0200
Message-ID: <875xhbv3q2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


