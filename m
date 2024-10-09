Return-Path: <netdev+bounces-133903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08069976E6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C087B287E15
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B381714A5;
	Wed,  9 Oct 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1HSWrG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5917BB0C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506989; cv=none; b=i/rsVBZ20CWgYd82QjP68fWttvuD2ll0nLcVe4pFD2roqw7JGDImj/j7iZjFVNzLrPz2VShgRZv0DMwNCZQhVujrTL4Mj2PONapixBfz3mV0K+A3TOBJvhOQEV91Q8vNHiYVUi5J/Nw7KWI7n+c5wMY8c1veH13UNsvlCwXYJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506989; c=relaxed/simple;
	bh=+SVBWlsiC3ODodPCQT2sCAKVJ0SSJC6zb6Go5eSkVdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJQEkQG2O5leIxARknq0SnTGAoDGteXbZngLFIDGkWhwVGsAThWwBMmwyau+a6FUeTO0D9RbNxro9e15tdg6iXnwNblsbIyYcNnI6jHiYPGn1YFTZKuNstD68N/8PCcGh+IAqjSoL8ZLbBR367FQO0rZ+ykt8Kz4CDKl/Qrg/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1HSWrG9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460395fb1acso84811cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728506987; x=1729111787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SVBWlsiC3ODodPCQT2sCAKVJ0SSJC6zb6Go5eSkVdA=;
        b=l1HSWrG9H2zlRn51qJBMRxRhiyxCy3ky56WpXuuSe5kU+fhyeb4A1IJlEeImcu/YWb
         Ad2KYhDXIlkt2dqwNmwGQHoSXCJ6z0hNbxAD4SDfnwExRt6Ia+O9P7GmAmr0IqCB+wDN
         x0HIsjU0x07olyKzHGG2E4kw+WGpEuPN/eBA6rldMWmNNpjFobidjtuht3l/pAEmJLvt
         XVNsG/myiTxOGyQyRvpBcZaE7HhL4hL3zghzuHSSETieRWOsoqJCgNDlwi4sKrqqRjSq
         rAp8ZxmdERnjjbQn4APzJh0GZ7ebPqLCGcE+/IPTNR80ezb+zRXR7FmNHMvHH0VLsan5
         KFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506987; x=1729111787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SVBWlsiC3ODodPCQT2sCAKVJ0SSJC6zb6Go5eSkVdA=;
        b=FNOGtKlgrVeO5zGm2+4w9H5fAv2/Owk0qjqEJYTTIi+LNcGwIizb6RUOy3tGd3Qnfv
         AZ8voGI6ttlxKfKSY64APDVGM4Zq60MVQtIt/FJ6H4ftH07lDaXpbU838cYBwxX7dkKI
         x293IgGseIjmCsoqeh2Rmn7Yvm+c2dytsWeTYwip9s0+VrB9mXaA4fVqwCnX68hHODjz
         d8owrT4Gqur6jn8O9hRvfXETR2xPPQhfzn20lR7qXziJCApo6ghVhTBxPBWKscHY2uKT
         RlvhtuQPHKYbC4skIYPAWFPAAb8SRWvozniVL774m2KGzyp8DHN/HNkFhdWUfgl6lDLQ
         i+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVrDX3Jc46OS+KYBpdD9SQLVr33UiqepB325Z4OhQMXvPUYCaf22DdQ7dUaTDeqoIyZpf7YDjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNXHi+bWpdGwt+i3tLhgQCkqgxS8x0kD9AJn5t7fOPIlPl5H+
	//hL/eUH+964zegvJ04kAeLtu7Cv9vUAObQPPivjThehWQeEcpwztDiXN0BrwRg4SJ3NuV1aEzi
	QqKYdzxzsYlf69ze8v7mzRwNS+qqngc7pknvr
X-Google-Smtp-Source: AGHT+IF98ze8/OAlEOTyuIZZyZ52YdLYLQmWY4kBh8GHmx1f+JntV0iBVlFL9cjDzL7X72vW/CEyj/Y/qvuvWZw/40g=
X-Received: by 2002:a05:622a:7c0a:b0:456:7cc9:be15 with SMTP id
 d75a77b69052e-46041276c4dmr128921cf.29.1728506986656; Wed, 09 Oct 2024
 13:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk> <20241007221603.1703699-5-dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-5-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Oct 2024 13:49:31 -0700
Message-ID: <CAHS8izM0+6c-xymAPYU3MCjq7T+ruUj0ZdxrAK7VE5yoxbGGvQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/15] net: page_pool: create hooks for custom page providers
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> The page providers which try to reuse the same pages will
> need to hold onto the ref, even if page gets released from
> the pool - as in releasing the page from the pp just transfers
> the "ownership" reference from pp to the provider, and provider
> will wait for other references to be gone before feeding this
> page back into the pool.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [Pavel] Rebased, renamed callback, +converted devmem
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Likely needs a Cc: Christoph Hellwig <hch@lst.de>, given previous
feedback to this patch?

But that's going to run into the same feedback again. You don't want
to do this without the ops again?

--=20
Thanks,
Mina

