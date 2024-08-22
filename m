Return-Path: <netdev+bounces-120924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A595B36E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD8E1C229C1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1521B15CD78;
	Thu, 22 Aug 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB2dozTS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1918C31;
	Thu, 22 Aug 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324644; cv=none; b=AmzXEdRtIbJsvFiCsiZC6LgQ2prXH4RroHAvvQyWztBHim4lB7yeaD5yT6KL8Z8uX0kOieOq3C/gI0suhl3cCKHXnC1YKxFU3IuciITBNbwesj/3CHzYf+C31DU+gRNEFVBTKlGIRH2eEpB0LtGS1JUL10SUccGG/bKgknYhv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324644; c=relaxed/simple;
	bh=Jq68yRopL3goFwixvcCgg5IXrCdW/GKaU6uvToifzDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvnI9tb5gFXnMeZOILdIrnHkuGsboeJH+EcHDrPphoUG8Gn/1uyQ5kku/FL55zLe9ijRSy7XtM7Qna9P/JscDtcCBySb8lmN53nqkTSWpkxRhBY6ijaijnj+Av7molbqoHHwPI0Sb7dQS1NB53s8El7n+ZLtoBOe1zdKq/UqpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB2dozTS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so340667f8f.1;
        Thu, 22 Aug 2024 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724324641; x=1724929441; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o+wksQn11LmFYl9wWiDfxlupo8nO3o61ZIF4AIOGqkw=;
        b=aB2dozTSGSrl5BOKLIesgYWRNnOo7Dmd8y6GR4u4h2AZJ+0vjyyQb+wygJf433shs0
         impKgXOB6otb6sM3V3CrlJelT409acx+H5NlKMPbm4FBAg1A5fd1ZFjFuOO7yopH4Urx
         I6oYzhLF+bF2z9TOdxF64SGphH+7e553CoQJNBQZ7RzapBi29MxkdYkHzyzbmN1wdXAU
         XhSXYHJvdxqLZIS61ZOT5eIBkXBV8jpg9R9L1pmLBy9ekXn6X+VELwuo3E4rQKp+YQZb
         8JRWG7d3k9xf9yr62ASJN7GpfJE5TOpEhizd1ox26tfx3q8gqcJolj//Tla7bvIOAa7c
         RSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324641; x=1724929441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+wksQn11LmFYl9wWiDfxlupo8nO3o61ZIF4AIOGqkw=;
        b=ektUcYIyrA2Lr3Incalew+LnwQSnNrodpzo5n0EjsCJzZWNXORtLkIUkTCIGmH0CZt
         WYtJbsBPc0yAZ5uLW4uXop4/Ezna3qtQ/Uu+iahUoklREqysiWsTMJY7VknljlwGTHkp
         cb9v70qq/N1pVWKbaLL6CtFOMhmN2SZEWZraI4F1oUkQ9Y/+chZI7zfzCNCuPdkVl9MZ
         C5RISbeYQr2lKaYUcYEZ2thzpIUrrK8TS5KQuyvKHTRZ7puwauDe9ktiMm5h/ZoUR9Pz
         6et3BbETTymXd0ZSOq4C4aPbykQQU9Lq7AoQukYVs0mUyUac4cehsvkgP+tWFc92qKkE
         mwmg==
X-Forwarded-Encrypted: i=1; AJvYcCU4CUKKQ4KfM2uZEWTIwglAlZZjdjd42dXDyfExVkOVvjoHNZKCqgtciWiEzfVmuQCgdeSU84BchicuoXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuGvIsbvsCMkG8NtAjBEBdcR8nha76WKewbq8DBLJXtIM0E88
	IniCT2wHzxZr3J3/UY6EQX99XmAy73kC/V9CF5fLJVgbmIOLxu7+
X-Google-Smtp-Source: AGHT+IEpn3Gh2ylj9bM07MNiCzGYj4kUVS+IXOfY4NDKMhdO11b5wuStsdg5zyXaB96b8gwr0F/gKg==
X-Received: by 2002:adf:dd89:0:b0:371:8f26:67f1 with SMTP id ffacd0b85a97d-372fd5a9febmr3687494f8f.33.1724324640199;
        Thu, 22 Aug 2024 04:04:00 -0700 (PDT)
Received: from [192.168.1.52] (108.78.187.81.in-addr.arpa. [81.187.78.108])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac21cd620sm39507855e9.37.2024.08.22.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:03:59 -0700 (PDT)
Message-ID: <612c5209c635c3cb1fe3c6472fb2b0561d03c0fe.camel@gmail.com>
Subject: Re: [PATCH v1] driver:net:et131x:Remove NULL check of list_entry()
From: Mark Einon <mark.einon@gmail.com>
To: Yuesong Li <liyuesong@vivo.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Date: Thu, 22 Aug 2024 12:03:59 +0100
In-Reply-To: <20240822030535.1214176-1-liyuesong@vivo.com>
References: <20240822030535.1214176-1-liyuesong@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 11:05 +0800, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.
>=20
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Reviewed-by: Mark Einon <mark.einon@gmail.com>

Thanks,

Mark

> ---
> =C2=A0drivers/net/ethernet/agere/et131x.c | 5 -----
> =C2=A01 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/agere/et131x.c
> b/drivers/net/ethernet/agere/et131x.c
> index b325e0cef120..74fc55b9f0d9 100644
> --- a/drivers/net/ethernet/agere/et131x.c
> +++ b/drivers/net/ethernet/agere/et131x.c
> @@ -2244,11 +2244,6 @@ static struct rfd *nic_rx_pkts(struct
> et131x_adapter *adapter)
> =C2=A0	element =3D rx_local->recv_list.next;
> =C2=A0	rfd =3D list_entry(element, struct rfd, list_node);
> =C2=A0
> -	if (!rfd) {
> -		spin_unlock_irqrestore(&adapter->rcv_lock, flags);
> -		return NULL;
> -	}
> -
> =C2=A0	list_del(&rfd->list_node);
> =C2=A0	rx_local->num_ready_recv--;
> =C2=A0


