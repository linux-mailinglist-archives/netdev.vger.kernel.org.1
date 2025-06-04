Return-Path: <netdev+bounces-195134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09199ACE2B8
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3981168B2C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04221F2BBB;
	Wed,  4 Jun 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/stcwcY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C647175A5
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056594; cv=none; b=Qu9hLDm2wpC3qvb9P198Vb1vjM0VENh5J59hfK0kOSPi9VoiUSdV7UQRCtzj69leJJDYYimvrnT74VATNk84GIA7MsOk6O2lzOaSjH6LlR6KYHFmTr72f2koysOtlbrUSBhmoWdWqiB9MwiBC4tL/49Rrk7Bdyu92YMMAEc3shI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056594; c=relaxed/simple;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+HdG0CICJzcWM1gICgsaT07a2eVPI71pQzZJvL1IHN6zP7pEYi9FADJ59xRFEKq/1cLm1+lt/FAOKYRfs86rYmvsnGDr+QYp7vYVdo0a91OmZtMXNZwzbHd/b8vdo8bI5IetQd7VdF+yRPXSSLUZAgYDf31hbyV7tM2AKPXtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/stcwcY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	b=R/stcwcY+WZZ4oU/te1L8MbJTeGtVVoIRH9Mpf5ifHCVKlc3AoM+XNyCAlB30RSodpCxCf
	/TDf6BwYPH8p9/pMXu0gAGghCxSz/U8FOhAAG5QdA/6oEqRUEs56CUPMM1N9Thub9YU/aT
	6kUUW4RG0XXn5bQzWJfQgWzYBgla6NI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-aIGGE3TVMR-2ukyssEE4sA-1; Wed, 04 Jun 2025 13:03:09 -0400
X-MC-Unique: aIGGE3TVMR-2ukyssEE4sA-1
X-Mimecast-MFC-AGG-ID: aIGGE3TVMR-2ukyssEE4sA_1749056588
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad212166df4so3744166b.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 10:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056588; x=1749661388;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
        b=cXOaUBxwEbVa07f656vNzyARUgoVKPdTksphWVfgCNzgRX832zuYvnQoy0Er8kV7vJ
         A3tOKdA3BS0HB/92tlTPYa4/s9r8zQ/OPDPQP4EUUhhsScitHUtMRBwiVHWd9CXBOtvJ
         n8N0uElKyNcXbMnr8PoGKNBAZx4qwHYhBAEiLhxjdIfQEn2geZH66pfVxAJRAt1PEg2Q
         1MruDkR+FeHOiIWpHHiKJwvMLEiJAb25VXHXb9539r00ggoDzjAfDExdV9Ob0pD1pvWS
         qWcvSVSX26IZRyaEcw5IpJRGT7sbrfcqokJT3etEKFbVjtE0xcOufIIcva+t/oJDQPD4
         L7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMbJfyH3Qrh3D+9QOajPjzk/y63weATn5yndxN3GG4yOyFxfL2HtussC5ZIb7iJaMLKLox+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYgZTgc4izBBzDGynoIyMG8gjMn+/01VUw7htwRJYvrJp1CtI
	gXpOFW+L3XwU2at+HbP6Wk9euV0So8fVGtZ/G168vPvwOUCgzQ1kjxVEDoDE9KjFlmPIRBl5ciu
	HazP5L6p6QMm9mIrlvK3Hbisf+OR3FOQkVSVckZSGgoXPRSBK1Ki5+YbE9g==
X-Gm-Gg: ASbGncuIcDVciyw+xzp+V9Z3yJLZRpN2CRX34GSExhcK91tZXuJbm7k7lnPIDAkScDH
	bmcLu1WJvViSNxLjaia+cXmkdL0aUbamMDNc1mvjJGg4l/LvOP4i/YWpkayT7NT09rc99IZFbWS
	nEYYrkxZqOSwLiQOQsa5Qrgcys73C6uiuzPxtiMF9SgiA8qwsJ7fDs9RqnqSRQX4aXvkSEWlI7w
	l+LhZpgg4d+CN6gZ5ndh3iec49Dm9P1mxUEyU7r7cfmCbP8taT92guL59mOEAfPrZum9zKBlUEQ
	h+Wnqggg
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329527266b.4.1749056587569;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEts9xRj/XK3SRKIWyfVZvu6UAgFyS0hpnI7mT5nnKFo1hg8wg/AtXBkeW4IXe7ZmieN8tHNQ==
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329518466b.4.1749056587038;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045edsm1116783966b.119.2025.06.04.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8F371AA9171; Wed, 04 Jun 2025 19:03:05 +0200 (CEST)
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
Subject: Re: [RFC v4 06/18] page_pool: rename page_pool_return_page() to
 page_pool_return_netmem()
In-Reply-To: <20250604025246.61616-7-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-7-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:05 +0200
Message-ID: <878qm7v3qu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


