Return-Path: <netdev+bounces-150284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC69E9CA2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9514281646
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF911547E9;
	Mon,  9 Dec 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJgEiu3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43E1531E2
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764101; cv=none; b=hTNyoDoyS2eScQ8JjbBxc2ezN08Diqn5RnaWiy3lnf4dLAJThTBeyiDMZ4C1OOV63AibeyxIN7cDK4A76IiOdOWQ1X29q6B8A+/oXpSGdBhw1Qz8yIBXrMWGYd/0D98OxWrZNh11BgRykbS3l6F1EhyQjBCK2UIFnD9p81BZ8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764101; c=relaxed/simple;
	bh=XftrnEfg+GuY0cyTaFtHNYuyzky3F02KxQKZel1SWtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnblZVi6usd3jgF1FOLyc6qYEpNqJib33VNT6HlldcjuIk0LQAOrBjy3iJqmNcUuv6RnOrdI1cDpVUJBNmgccxmGKx0g5IEbQo8EDQKDiROxF/u2NLPt+HeQqmlb9tfDr5PTutMUcTovpgjalVd7ahlD3o4AajoyPlWDHOpGHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJgEiu3f; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4675936f333so306961cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764099; x=1734368899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XftrnEfg+GuY0cyTaFtHNYuyzky3F02KxQKZel1SWtE=;
        b=PJgEiu3fs69cvhsqrnjBcGv7VjTFqpkrQvh+sbS2H/8vbfUW/gQ9uy7JHEaqUPrc6a
         RX9lHKiKFEq1QrVkxtjuafsJExci4v+hm6BzVqASGZCQuFQlQ17SJvwKfdTbOgcVhzbi
         4StiAPsF8B23IvsAA6zoDRkUV1/XFL8xIkvzhyXUXUfhwGzso8ZkC3XZWJ5C/2S6cMpn
         sZ2GXd0nB9F53oRo/Y7va3n6/nBC6iuflxPSHNGliVN8gOMnjGeUeN6fs+pAgJmNclvg
         1Zn2Xip6pSvLo2zpGRsQrJEe/xpXzInfEnotFTsRZ2Nw8NoBjUhYzRCFqaye53qSWNgz
         FYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764099; x=1734368899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XftrnEfg+GuY0cyTaFtHNYuyzky3F02KxQKZel1SWtE=;
        b=a7wcq5/Z9mq3RaNj3NQe9OAb3feWIyWACVgVoLkePR0TxEf0ZyXTnnSPpNWIVF40t4
         WB92UrVC8JC/WxlLSi8kXahytOiCErRwQpipA5BIgci3qgGj1WOfCQN0ZtAKZEF3CrEq
         KJBMeaWNzfeJgmiMr+8h7CGDXlU4iSQO4aFkCtS1PmSg5FNxVILX494/WHgFXR+ZxX4h
         eK2OroEI671w3BJyLZRC/fViJrEWdySi29SjVXNpZtNWPs5ie+mfSL6AmvlcTxO+9kHJ
         VND8N2v+XUD+XyTzELRB0nQfdONPh37/L3ed0VHqeN1cbAOVIF21fJxlP++/YxsEpJaI
         36WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkddZlRqIOHV4IazvUv49M24/WOwwT/wIo/CcoLqNOrmS5FbVw2C/Tqj3u/RqTOXYuNsMAtjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHatZpIQYd4sCKhwYD7idXhaWuLMZuuAs0BY0TKdZxc9GkwAu
	WjujpNshqD35p1sWKAfYDI7kI5CLyNDiRuRimjWFhdjYife1M59PfzGqvi8B9Ox4dny6SIAE1GS
	OJnkSDxGMcNOaG4po5hnbJ3Y1s9wVLfw42i5y
X-Gm-Gg: ASbGncv5hJ+ywJgrCD4G2QMZOnFGtCKVkTofjAbDGET20g5pi8v+vRnkJ4Bpck16jP7
	vHw6TqZcbJRpou6k5uJeIwxmcnOxG+tH6fyUU+fP9EnCdtPKWigC4T2GwCqqObg==
X-Google-Smtp-Source: AGHT+IGeV6Sg1dvO6Ay82bghSQYKpO0qY0K+S5ujSVGXWSjhRfpqCgtwGSRFgftx2kyBpPDMxRyasb5mx4JgD0XGf4Y=
X-Received: by 2002:a05:622a:58cf:b0:467:462e:a51b with SMTP id
 d75a77b69052e-46746f67fdbmr9222931cf.14.1733764098474; Mon, 09 Dec 2024
 09:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204172204.4180482-1-dw@davidwei.uk> <20241204172204.4180482-6-dw@davidwei.uk>
In-Reply-To: <20241204172204.4180482-6-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Dec 2024 09:08:06 -0800
Message-ID: <CAHS8izPQQwpHTwJqTL+6cvo04sC1WEhcY7WuA_Umquk4oRCGag@mail.gmail.com>
Subject: Re: [PATCH net-next v8 05/17] net: page_pool: add ->scrub mem
 provider callback
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
> Some page pool memory providers like io_uring need to catch the point
> when the page pool is asked to be destroyed. ->destroy is not enough
> because it relies on the page pool to wait for its buffers first, but
> for that to happen a provider might need to react, e.g. to collect all
> buffers that are currently given to the user space.
>
> Add a new provider's scrub callback serving the purpose and called off
> the pp's generic (cold) scrubbing path, i.e. page_pool_scrub().
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

I think after numerous previous discussions on this op, I guess I
finally see the point.

AFAIU on destruction tho io_uring instance will destroy the page_pool,
but we need to drop the user reference in the memory region. So the
io_uring instance will destroy the pool, then the scrub callback tells
io_uring that the pool is being destroyed, which drops the user
references.

I would have preferred if io_uring drops the user references before
destroying the pool, which I think would have accomplished the same
thing without adding a memory provider callback that is a bit specific
to this use case, but I guess it's all the same.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

