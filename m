Return-Path: <netdev+bounces-99649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12338D5A7F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AC3285B3A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194E7F48C;
	Fri, 31 May 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BHHOwzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF47F47F
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136649; cv=none; b=grUvgvb3GPUShOB6ZpKGexVQwAVQxB44YiU3AG//+2IUtznhIA3sapg3JGa0mj0Z+I3pW7XOxpmgeSLXfYEFurBoOF9gWGL+2qSVAoTV2Ngc5A3VIQWxxrZ6nWQYvX8VbP9trgTKdbFEJqdEXwvt5I1jx2uVA7/qw8dNXhHGvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136649; c=relaxed/simple;
	bh=AU8OP+j3zx8s5L6slB7WGLzdCE3cIdWS/zNOw7ix9hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3zLWAeAVBsYM6i+kgugAMbI9rL8sGs6R0QMCq2PASIOUWhmAK1+ZsURiFviujRk9phQyKkmtdRFqCBcdt10GXTsRk+QbugwV6siJX0NOrtnU1BoJCBwGa1kk86z7KCK5EblqrOvV2G/UFvMaHhdg8PhS2ODqsaYEwzQZH7gjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3BHHOwzO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso6069a12.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717136647; x=1717741447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEEkzxzw2l9dsGceL+M9m7VWZ6HOQUiTt3ium264cY4=;
        b=3BHHOwzO/fL5+pxlFPIRGC+DUNvkFot30LvldqT3Xucn3G0PLiy+Qyrgs68RNTEo9w
         3lxJmhGs0O6fl6W7L9AcmsFr/vfUFeyyWmuzh6Yl7c17uWyDI4Y6P8s9Jg5sblqU0rzK
         KKrhK6zNVFgg8rB16eainKoIFN3+ncn3/JvR/aQ/J+oIBiSkdcd3i4UWaKBbca4MnCcS
         UGtSSnJn36N7Y8TREpZ/ZRh250bq1g9/gzYBYKO1/KDZOJfPEyTWLW3RYGIL4hVVJzH3
         zOsTysywRWslHmdXZKlG3DXMM0L95kpy1kmine/JSp5dhVaVxc792qCxD371qTaqYP69
         TSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717136647; x=1717741447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEEkzxzw2l9dsGceL+M9m7VWZ6HOQUiTt3ium264cY4=;
        b=F7hgBOwQftoo3p3nTX0SmV4vRo9YAZnLnT9ecPtucUetP17XlCYDOCTj1q8nMeOH8H
         GtPHe7O8OQASMaf8fkWqUz1o64ARSjJL/GLPX0MG2+A7oRhtBLhU+RZKm0NnHEHJJjrb
         341t2xW3li50vYJHvzBHBiEw6smqLdPEzhuLgOsgo7enUZqS2e+YRBd3sn6mNFHyLxaO
         1WwmXL5a/+ydVBYUG2Ew3Uus2OdfYYIIAWtVdv76g8+PV8R5GRRS25ZNnrA/koz2nOj1
         JmHKVDaDWM77g6yke/WK+7dgBBfrqIMtIlJMDR7JLdMJKaAkRN08lNplYLXfLMYb1H1T
         9zjg==
X-Forwarded-Encrypted: i=1; AJvYcCVCAyM2iWlOtNr2A9o6EU3iIezDVs0uMiDkqwFl4LfNC9FHIROY/knu9N57xnXEZX+3Be0uez2VFFc68pVsBmNwtSHmq1Nb
X-Gm-Message-State: AOJu0YxPgGImBiCyaYw29mBLh6aW0j3mE3YngYQvDlgPHnT82mTkZqNT
	HPisAq+5SZU5b+YtZAgV3+Z4HAKJP6kD6XbkwutldT2onwu8+dN3X7mzlQ+FMaCjf3qJtZ9/dXS
	XUTBgyrRuvmrqnZYqZ6O4vRp1sz54C1ZBCHP8
X-Google-Smtp-Source: AGHT+IFuhZwScZ5INqv8GHb32wDNKMq8rDNGgetkBMalXnj9RK+/6EjJKHZP2HhZdxzjRMg+3RcoQrSxTOe9LsQD/q4=
X-Received: by 2002:aa7:d6cf:0:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a33693e06mr117681a12.0.1717136646388; Thu, 30 May 2024
 23:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com> <20240530131308.59737-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240530131308.59737-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:23:52 +0200
Message-ID: <CANn89iJh5S=Rmq23SZGCsECUdvmuD22O18rNA=-Z1782BoyMNQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> According to RFC 1213, we should also take CLOSE-WAIT sockets into
> consideration:
>
>   "tcpCurrEstab OBJECT-TYPE
>    ...
>    The number of TCP connections for which the current state
>    is either ESTABLISHED or CLOSE- WAIT."
>
> After this, CurrEstab counter will display the total number of
> ESTABLISHED and CLOSE-WAIT sockets.
>
> The logic of counting
> When we increment the counter?
> a) if we change the state to ESTABLISHED.
> b) if we change the state from SYN-RECEIVED to CLOSE-WAIT.
>
> When we decrement the counter?
> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> from CLOSE-WAIT to LAST-ACK.
>
> Please note: there are two chances that old state of socket can be change=
d
> to CLOSE-WAIT in tcp_fin(). One is SYN-RECV, the other is ESTABLISHED.
> So we have to take care of the former case.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

