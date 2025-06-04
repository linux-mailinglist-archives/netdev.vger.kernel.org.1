Return-Path: <netdev+bounces-195121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6430ACE26D
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A72E176712
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263E1E5B7C;
	Wed,  4 Jun 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvgBp8vC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B81DDC00
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055990; cv=none; b=gf00f0h1YO9eSUiGhhtjS+TLDNUmob+srhHDLa+hMZJpJ1G4mhC5efMUNTLBA5w2hGnSgcC2vRcqG0IgprSESlpjiYTucsVhbmviH8Xmj4XaVIyga8e6O4eAKQMlXeZEJrCEpnnG8X2DCFewnSDqdmfzZ3bl++FE7WdQP+lqM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055990; c=relaxed/simple;
	bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bKdzPl/NAqpsI3nJiQIGU6DfuOgIvf3KII9XXnQ4eY8VwXq0ej4H+9igr8SYqt78mZ6DTLpXAG/kr/e8ooqN64Fjce51yzJKCU/Z3xelLSzTYMk5spiJCJvSxAcBFnxvqli1vGbu8QWc8G5lu58f4gnu1b5B8d94+g5AoYtGmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvgBp8vC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749055987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
	b=dvgBp8vC/q8thG/Z5+iTVw4PwPwI6svJq+U/Cc2do8UgvUl57QswQvHC29L8VJnrNlNpSP
	XLAKWHRK+AzJKQXv2zZ5QsBPAuFnblZTFMzbDJ9UbhNOP6pn26Nsl4HKwx2nwg+y0Ctgil
	3RPPY/t+Py+f72Xk88p45eYRJxU6iI4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-A425zGdgMpSYzOtgQIKPpg-1; Wed, 04 Jun 2025 12:53:06 -0400
X-MC-Unique: A425zGdgMpSYzOtgQIKPpg-1
X-Mimecast-MFC-AGG-ID: A425zGdgMpSYzOtgQIKPpg_1749055985
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32a64f93c68so831901fa.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749055985; x=1749660785;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6psz76j6Q54BLu/dla5y9lVeHPkpDqvYnlf52GvYWU=;
        b=rk162LjXVvhOkK60ImiFJJFQBRiMimn5Y5WmV+ZfXcTdMxAnq6WLr0xK5nVK9ss0yc
         TMS97xA68GuvgTIIiGk3m17esMuWboeWGQutRDDMExH+9UE+goghVqqAgh0wa1nXVI2q
         5SoyuVey8NQ9PO5+2WWy33aN9oTbLDHO8+sqM/vy9oDY+tPlikk5NGG/K2L+b3CsKjjM
         Jp8L5kDSEZ6u3csmfW066dP7legAdYDTzsYeYMGdN5ezf+VxJQDGC2HSuTgax0oXy6AB
         EFU2JZzc5Bn1oHsUbyIFLatOhC9DXozJQLj4OfqBNDhYERhfMGqdt4RP/ikfv1GHQvok
         mONw==
X-Forwarded-Encrypted: i=1; AJvYcCWyklh32UNc9iqMgYDBYIQLbO50J76XQYp884XHsiIWjxfU1BnVrYsONiyCWQIWmvWojbuqz5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8y6XW2nTzdILwumhjw5/jl/R8an1dh8teegYp6FLGen6r6du
	hPKImk40BmvQk7r8f1d0mI0riBrMQwyl6MAc1gzuwCnosDMW7RNZKfsTh4O2bs5kb6pqu5mvXN+
	RiPQ5VXoGXrE9V1QbRvP1VmbbhdlqgR7YUXwPDMf6gh4TB3w29i+iJlIOQA==
X-Gm-Gg: ASbGnctpPc9yydRP/C3fS9iwhZMh+TGFcKB6jbze0yvBngaf44iW5B2RJPHwXQQeu0w
	HUnCpPlm+qlBSDFNDuozmh2GyctMIbHzBmsdISG+rmcoGgwG8fA3VwdAxVgnhoG48rqPIDmTzNQ
	U9o6YCmvRGOFlQ9UqnxROxVf1ZaJwx3gl32FgwbIWRZOX+fQVrYhic/CjujZfUsb6WVw0N+itiT
	qO+iolaxOFoGWvNvpel7138j3CIfqWZd6ySLinNSfpVObuomQSJQHFGwpAD+JNRnZW8Cjd0Dnij
	6ZOzlcyIPgaouTiBBpd8P6BdqFwsmqSwengE
X-Received: by 2002:a05:651c:1508:b0:309:20da:6188 with SMTP id 38308e7fff4ca-32ad11be38amr1206491fa.6.1749055984833;
        Wed, 04 Jun 2025 09:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVkK8aXlCZgkjT/0iG8wOa9KpXdYeRE73KlsXw6lWnYujNdB6WOp6huRvzJhw27fbEzbHrw==
X-Received: by 2002:a05:651c:1508:b0:309:20da:6188 with SMTP id 38308e7fff4ca-32ad11be38amr1206111fa.6.1749055984366;
        Wed, 04 Jun 2025 09:53:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b527e1sm22753181fa.47.2025.06.04.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:53:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B3D351AA9156; Wed, 04 Jun 2025 18:53:02 +0200 (CEST)
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
Subject: Re: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
In-Reply-To: <20250604025246.61616-2-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:53:02 +0200
Message-ID: <877c1rwis1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


