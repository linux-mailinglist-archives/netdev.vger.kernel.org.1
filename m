Return-Path: <netdev+bounces-149128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EEB9E471D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E04B27E05
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6018C32C;
	Wed,  4 Dec 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uytQ6QdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90F944F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346015; cv=none; b=kHAwGytnrJoO9gTmhWeoEXkghiAjcpQfOSE9G2vlRbgu2xUMukY24Kcn8U33avS9W+rOUjA6K/AY844ordeEIqWgj2W8WC5D37Oie0E7Q/QUKqrFhFnzSlOfy6MOAJIsPw7k/7hh+HsYzFf0pA19rL/LsUh6FDcLNeNAfeukzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346015; c=relaxed/simple;
	bh=Mu4+Hq09Af81qAStelPfifM2BedqrrH7oH/SDXWGEMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzx8slDR9Hv93vkM4Bsk9KTkJnvO/6G5UuCa7hmNloC503OwtDiBEQi7sjOvCYjgPpEc/mbRltr3Dn7Ii69N0q7ZYUp5o4L3XPsvX4aEPb9n1TE9VY+ORABHaugItILrcS/8G5CsA2z2aeQAhMBsXj4cS0NVcTB4CiBRBCce1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uytQ6QdQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4668caacfb2so8361cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733346012; x=1733950812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu4+Hq09Af81qAStelPfifM2BedqrrH7oH/SDXWGEMg=;
        b=uytQ6QdQZvUeCqb+LWcDt3jLwV9xYmmp+fOy2YVGj2DJ8FUhR0k2PxgGb1JUlttvEV
         C55y98yvJY0l8GhtX3kwsk5muNeT33MH7wxykfjG1w8ri2kUuDdhUe4wJlNxjCmnjg6n
         aeBfP1ImbmbyHUOgFgWm0/e8il3JWKNpR3JLLJs4gQvqYDQvDlOi/N46FKxDsrGASWjl
         9opFyDj4J4XoauKrF41H9/weJ0juzBUqWQinkpThPtsDvEfNGzS9GLHzKrP8Jvscfr6o
         QCzrQB3GpvR5Z7SHl4rpNIsIg0DM9rTLQnDotmqe70joDFMJkLVJ+s1wR9uWtx1NX5vM
         1faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346012; x=1733950812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu4+Hq09Af81qAStelPfifM2BedqrrH7oH/SDXWGEMg=;
        b=ZSDYMV7j1FeJT+wTtO1g2bn2T4djq2MtntCrVCJ9kfJrJf54ifw67h9IsgXhEh9lT3
         DqH0v668ehB97YmMKB9ZWn41V98Vq+SVg+Ir6VM8RdRQd69u112ytN/nE9pfc41WkT2X
         ztsnuNS1IZHm18UnOX25JgT+zyktnKKnBfW0E8L9n4dztDVJHqx2dwHN7DjdmxRDokni
         yYfvPP+D8JE6HWRxUW+nzCR76EfibUz6mie52D9ZeMUbhIpwdTVce6s5W6IOerAyvCfe
         kweE6KESIjkbvu0YO2uTVtfH5ssxNcZvgNxewprPAWJdkKh/i8hp2CJgGG31lKV0uO/R
         7Glg==
X-Forwarded-Encrypted: i=1; AJvYcCUtHpna+CLPurPfYp7wRct8PnfFaGne0QPSVqGHdvs3bTKmxeRKr27h0DfYG1ZE9f5f6zaSUXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgb5njVL0MaJZpgclWg85VBvMpUG9915IIRZgywG8TKL9ApFn7
	3uAbH/i23Z5rtiCapc/5h3TXgxAr719w82WRdmEy8cRWt6GO0DA1Sn6nn+q68L6f4m5yoNi//Gu
	gdsszMbUaWN9sJ5Gy54eBdDS3J0f9jwIvDZnq
X-Gm-Gg: ASbGncsqf1KjjcUhVSK8LkZlLtyEiG2NycAe0v7zU1ihnQCB1rSuzh+aQR9cyuQaveI
	qIV0eM8nBUxDTxytCn74m/Fhk32WbGJo=
X-Google-Smtp-Source: AGHT+IEVcm+wR8hfrZA2nBPT1KRyOSe+vy06Rc4HRfcjCgHqa/2qsnfB/00ICUGl/r6x2oXce7DxYcFOlHa5ofl5Jpg=
X-Received: by 2002:a05:622a:5807:b0:461:3311:8986 with SMTP id
 d75a77b69052e-467284fa59fmr658351cf.18.1733346012210; Wed, 04 Dec 2024
 13:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204172204.4180482-1-dw@davidwei.uk> <20241204172204.4180482-2-dw@davidwei.uk>
In-Reply-To: <20241204172204.4180482-2-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 4 Dec 2024 13:00:00 -0800
Message-ID: <CAHS8izO=8C9nv2e0HKWA4Ksv-Hq7yoYH6c+rbZcUXvbVwevwwg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 01/17] net: prefix devmem specific helpers
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:22=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Add prefixes to all helpers that are specific to devmem TCP, i.e.
> net_iov_binding[_id].
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

It may be good to retain Reviewed-by's from previous iterations.

Either way, this still looks good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

