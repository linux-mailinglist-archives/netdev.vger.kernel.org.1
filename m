Return-Path: <netdev+bounces-153483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF559F82E3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD44E7A3605
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA38197A8F;
	Thu, 19 Dec 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqOEAAI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F497A936
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631507; cv=none; b=KlN8mJhuqbarbX5mvXrr1VU+SCUdYT+SczMfnXVPcLaFTjEGae+qdV5v8ywTvMPLI3S/ncradhkM+Dbnj8zjK07Rup3HglHe7CAAmBjKkQSfoDcppV1B5gD6ds7UF9G3xnAR4pLPz+FDRdhvnK5nWBcSRG6yhLshmr8WilOjf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631507; c=relaxed/simple;
	bh=doknQn8Bxq2w2ZmsZ7asrx6BDnHR6uRQQY6TRjvnWyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgziJCK6CFdi40OhnXur0ZyWu/ZzApddxkm3ViK6m7jWhJHEV/jcOa2Tw9yFFp0GJXia+ba2S3zIHBWCh4gM2KsRg52CX3VGslO4JmpVwCBXdOAz2jlpcXjI9x7aHbWwgX5c9coasPKgAstn3xBpcxfP8Ua/Y/92mNdK2fx0Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqOEAAI7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so152227666b.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734631502; x=1735236302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doknQn8Bxq2w2ZmsZ7asrx6BDnHR6uRQQY6TRjvnWyQ=;
        b=pqOEAAI7LJvetEJcngrgNxG9r9arQ35OKYFRyC9SmbehJPDDOjo0h4ew2ffknwK5R8
         owRiyjLzbEETgEOfUzj3uogDDTlFN73RSP383tKt+Aj29KMxZbGsiFBdWKx6uKsm7OdZ
         0sBYXGtKIcMS4jmDjHHhyt74r2FhKKfI+PZwimPBKndg8Jfhq7Ujf71gOflRVcbYc78Y
         vecpDAi/la6N/gtt8V/Z2CTR44u1NfvYtccVbRPf2GGzH6aUBk1CgMel/2+Kg1T9lmVf
         YGYIIDIPTw9p5e/ij3zl9pDCnwYlcG99KX+TJ7MdIOPYzGio5ozGCY3lss3Di2qIZ32r
         U/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734631502; x=1735236302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doknQn8Bxq2w2ZmsZ7asrx6BDnHR6uRQQY6TRjvnWyQ=;
        b=Qhq4cnFzbLkcqYcnqDgaeAKSBUPCZkIlKL0j8odeIMDQfBDcM+RsUFH56gdccqQwY6
         uaOWB/sG5mhjudij7CYjE3XlOJvHybcgiw2riwyo+Nj+P+uebuwLw06CXuwP9plS6iom
         Dnbqb6cFTLn9co3eAP2c17kjdcPpfHgxAqEQJIKSRqIMQkopqw+pKlpPcsdi21nffW/P
         805ZWVf+y3zo/J/HRjSRCjpXMqmIEH+yeOIFwwwzYtUXf6zAw5iXGP0jmes/Lon3H31A
         EgR2BD8RP6YfcYVw4u/d4htHn4IYPfLqQQBx661q20NU9//7dvlZrv8FJwIoB2Bc+tUF
         iIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvKhM1CBpDAe4l0q9WNc6UDAzL7l/adTkGbN/rxSkbCR1NBygoAHBbMKL90xeR/9UDQXQZX/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa21T43vCx76USgQwh/8NYL/6zQINUffA6fqp3smOJJZQnzbPV
	KtJ99zy6Y7rhl2NaCx4gM0wY5xqlr4sE5crszpoigowRJAvubz7InDBVs3AxjInCqVw1i7aJS5W
	AWEb6WvrLThUI3+A2owDhDdUB5jDDczEE+EKU
X-Gm-Gg: ASbGnct7u8RRyeapamWUnaG5MoxGjfiDAUchJskwAymLJnUXj4VG7RZQUXqDFt9d68I
	y6ZamXdQu1Ww8J7Kzi4wNDDLIY/0ynYEAACcNCw==
X-Google-Smtp-Source: AGHT+IGCagC2iGnTXkOHOUQjAbDVz8XpKRA+8R866rnv0zi6C4EkN9fYMd8u8Riejd4D873zxIPX2zFl0DzRhmjKGyk=
X-Received: by 2002:a05:6402:2709:b0:5d2:7270:6128 with SMTP id
 4fb4d7f45d1cf-5d80261de78mr8262762a12.25.1734631502371; Thu, 19 Dec 2024
 10:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219173004.2615655-1-zhuyifei@google.com>
In-Reply-To: <20241219173004.2615655-1-zhuyifei@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 19:04:51 +0100
Message-ID: <CANn89iKRZsuOkQK-b3hr2fp0S1ivDvws4RRLUykkXhsWFLuNhw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
To: YiFei Zhu <zhuyifei@google.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-net-drivers@amd.com, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 6:30=E2=80=AFPM YiFei Zhu <zhuyifei@google.com> wro=
te:
>
> I was debugging some netdev refcount issues in OpenOnload, and one
> of the places I was looking at was in the sfc driver. Only
> struct efx_async_filter_insertion was not using netdev refcount tracker,
> so add it here. GFP_ATOMIC because this code path is called by
> ndo_rx_flow_steer which holds RCU.
>
> This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

