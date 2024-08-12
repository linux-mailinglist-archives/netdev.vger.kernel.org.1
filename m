Return-Path: <netdev+bounces-117677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C494EC09
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BA11C21823
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640A176AD0;
	Mon, 12 Aug 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw7SNRS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64B165EFF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463161; cv=none; b=r5rO0tnpH0V7kDBH6LiMKUyBAtJvYCjKhICTDyPWdHXqiUFvW5Qh9+iAt2uP1F3vHuJlAvn6ffqmhGo69lU1XLa9IAk33E/PWDNIZ9wsQNVAZBcrXJVEIbVQVHvwuDtQRK0l8nS7kW1UYsGsJdjIU2NOctGIRj8LGJJVBtJCM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463161; c=relaxed/simple;
	bh=uc7PAsc9UM9DKZgDdWt244nDHGCd0fKJHeAm95BwYeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j29a8hdBYX0aAa0Yq+XyT73ZmNL9tcbpw6j0Z91ZXaTdBOj/1JinXVPTh5AgW61CrJAUgID7/zNJHxIauxmWpkuNi3Yk2O3bdt5j+Cju+fLNcRr6Pkz2mNaw9UxKVWO5XTMKREgWPG3LFdIfnJW4AwhNww0ImbRGxsVmfvuE7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw7SNRS+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso45892021fa.2
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463158; x=1724067958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYhOt6aW1NC8yPWf0Bo2cBkO1Pkyny+olPMdd+XlFGg=;
        b=Xw7SNRS+EH4ftqoPe05ZLYVI2uGAly128DS3iKamAQep71pzSG0SKMe/EpbZdlUK5T
         nzNAb81doP+TT/HMQGUAtXTOuIVXLkJ4I4UKgGV9AJv9mh/xDVlCKzpDZUYe175BH0oz
         s6Ym3xNy6lROQ689C1dBsoJoJysYlQC0K7B+bZAIqHUeKNJvxWVsie7GiemQvlvRKAAC
         4OnGyyrzQlCindRGksGcu9LlPwSgSk5X48Mwvn4jKbi3BkBfgvK7ne9J9w9UmIYdsvXt
         5ESz1zYnxdzhgX5Yu6askCrTdoNf545CHjMiWpQOpvRJkKCtUsd7JY9pD21NKC/f04f3
         IVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463158; x=1724067958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYhOt6aW1NC8yPWf0Bo2cBkO1Pkyny+olPMdd+XlFGg=;
        b=g6/dIFhpz2CFa2Vqeg7pyrEX9cOjH9EWADwMdhHlVa5lDkFFF9We0J1cSJ0l7sJIvI
         Rf4K34YJ+X+fZM+Qi0ufrCfpo+6cANMPT6oCe778VyOio4tfPDJMeDYV//zwrhgEHsgF
         ad2dVNYcPYTvFuW8sZMptQTEK+ywEHdlBsKOk/Ag5PUiiNrKOfEdHjgrl3x6TngzEKPF
         25qXWPSobl6DQkGpXGJMaMhINEnc9jMUaqI5wI/4p+OHhrdBBbzqcC400X0jEpcycaL5
         he12aUJ7P0j8V7HJgF2AEZRLSE6h+R0cEh8ugt1eSBUJq0NQwPd12SdmuIIZSa7Qypxk
         yKxA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPEIXIiwwYajbaj5g1bKgWtXyWYfIMthn/CdFT9l2eOcYr6dLeHgx5WPTa6FtLtrCdrCNNvcnv4QKNMg/YF4nRcNz1jYc
X-Gm-Message-State: AOJu0YzZVoxWDBIm3GXkACmAVMaIfl+Ktwk6fhwrpOZFOULMbjUMGPQl
	QxuvaOREhKxV8n95sOlaGR1O77u5yGe65WHjbAjM7bXX+1x4Roq43aXtLYeXDwFjYdUKzfZVNgx
	VC9tmGK2X8WS/q04+pmMt0BQc7zo=
X-Google-Smtp-Source: AGHT+IEwZ0ZlGix/6VKAVvJod8ry4uyJULzyxlBg9/23UhQ+LVZhbKwastHct1rWb684NeMlh5JUIfhwItytQr7btOE=
X-Received: by 2002:a05:651c:1986:b0:2ef:24f3:fb9b with SMTP id
 38308e7fff4ca-2f1a6d00361mr67104811fa.7.1723463157588; Mon, 12 Aug 2024
 04:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812-mvneta-be16-v1-1-e1ea12234230@kernel.org>
In-Reply-To: <20240812-mvneta-be16-v1-1-e1ea12234230@kernel.org>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Mon, 12 Aug 2024 13:45:45 +0200
Message-ID: <CAHzn2R1gX+6xfSbFE0gqraBJ0hYAZ+ExFn+i82G07KFQETWurw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mvneta: Use __be16 for l3_proto parameter
 of mvneta_txq_desc_csum()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 12 sie 2024 o 13:24 Simon Horman <horms@kernel.org> napisa=C5=82(a):
>
> The value passed as the l3_proto argument of mvneta_txq_desc_csum()
> is __be16. And mvneta_txq_desc_csum uses this parameter as a __be16
> value. So use __be16 as the type for the parameter, rather than
> type with host byte order.
>
> Flagged by Sparse as:
>
>  .../mvneta.c:1796:25: warning: restricted __be16 degrades to integer
>  .../mvneta.c:1979:45: warning: incorrect type in argument 2 (different b=
ase types)
>  .../mvneta.c:1979:45:    expected int l3_proto
>  .../mvneta.c:1979:45:    got restricted __be16 [usertype] l3_proto
>
> No functional change intended.
> Flagged by Sparse.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Thanks,
Marcin

> ---
>  drivers/net/ethernet/marvell/mvneta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index 41894834fb53..d72b2d5f96db 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1781,7 +1781,7 @@ static int mvneta_txq_sent_desc_proc(struct mvneta_=
port *pp,
>  }
>
>  /* Set TXQ descriptors fields relevant for CSUM calculation */
> -static u32 mvneta_txq_desc_csum(int l3_offs, int l3_proto,
> +static u32 mvneta_txq_desc_csum(int l3_offs, __be16 l3_proto,
>                                 int ip_hdr_len, int l4_proto)
>  {
>         u32 command;
>

