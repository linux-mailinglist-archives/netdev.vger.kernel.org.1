Return-Path: <netdev+bounces-54444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9ED80716B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5FC2810C8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2803C466;
	Wed,  6 Dec 2023 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiO0onbM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C4A4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701871101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vng2/SnRgWTDDru8v8rtd+Rz3Crl3Lo3N7L+CSCh4JI=;
	b=IiO0onbMuQ/bwBFcepy+NS93L/hln9ESmpi3KRUCvghTKzvwF9HOmTji4JhG7L7LTKXRGo
	SUEku1zmEA14JswC3zeZ7OaVKF7V8cXxTWPUJL3qNlc/HI2xDZQY81qQqEwMhXcCMzzcq1
	ugZyXfjvAqrkLGftZf4YvORgJWUUkb0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-nxm0q55kPmuPMJIvlJeC4Q-1; Wed, 06 Dec 2023 08:58:17 -0500
X-MC-Unique: nxm0q55kPmuPMJIvlJeC4Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50beaf48be3so3237580e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 05:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871096; x=1702475896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vng2/SnRgWTDDru8v8rtd+Rz3Crl3Lo3N7L+CSCh4JI=;
        b=gULI5OSAgbhcE9TL2zxDUOAtnklJVcgtXtkWRNUDUtxIUqP66CdkdOuWZcoKZKQQ8Y
         BJ8emQsSTl7Hd4KQr1xKchGTNqGwSwi7xwpohadnQ3ssFGUUek1gzXdmyGOg5kOSZWA6
         o6vpAtS7bV5Z2RON6cUemwFH6Z9URjCVrmTZiuib40OSehwFvtXFFmDbeK0D+Z72BAML
         OBWLP7wjrzD+zR2vqXv4tDF6v7yzU3I/MpYGUjWgwDq4TMy6lS7H8Ys2tjFaoyaSHBGl
         D4euVgGlXhtes2tnuab5pa2Hm2NbxTfhkT9Kem9Qd0bcbvF5OEtLKVFXBP7tMlr0a/h4
         1bZw==
X-Gm-Message-State: AOJu0YwkN237ZRsoPzWbXCS8RM0dUhs9z77R719SbWxl205LDSnpITzm
	5h6dXNKted8uXotV40wKVZamTGvI24AAhKOKlKFlOYxXw9AyB8IMRsspd5ecAG3wWHZ/Ubqew43
	YbkqgmCTdKLqMDaaCMoOC4SrMlwSThk/i
X-Received: by 2002:a05:6512:3e0b:b0:50b:efa8:c518 with SMTP id i11-20020a0565123e0b00b0050befa8c518mr485163lfv.102.1701871095853;
        Wed, 06 Dec 2023 05:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbx/bUgoIEFkWQBTPj3Hmf5awFPNN9VUatDvKn08A1pfbHIt7BwQojoCII4CcgQhO88V7+7sV0bBg1vmXj87g=
X-Received: by 2002:a05:6512:3e0b:b0:50b:efa8:c518 with SMTP id
 i11-20020a0565123e0b00b0050befa8c518mr485149lfv.102.1701871095525; Wed, 06
 Dec 2023 05:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206063549.2590305-1-srasheed@marvell.com>
In-Reply-To: <20231206063549.2590305-1-srasheed@marvell.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 6 Dec 2023 14:58:04 +0100
Message-ID: <CADEbmW32rjDJgr4xEArasguWfsSNTJpw__AgsE9n8mwE3qXwFA@mail.gmail.com>
Subject: Re: [PATCH net v1] octeon_ep: explicitly test for firmware ready value
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Abhijit Ayarekar <aayarekar@marvell.com>, 
	Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 7:36=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
>
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..b8ae269f6f97 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pde=
v)
>
>                 pci_read_config_byte(pdev, (pos + 8), &status);
>                 dev_info(&pdev->dev, "Firmware ready status =3D %u\n", st=
atus);
> -               return status;
> +#define FW_STATUS_READY 1ULL
> +               return (status =3D=3D FW_STATUS_READY) ? true : false;

"status =3D=3D FW_STATUS_READY" is already the bool value you want. You
don't need to use the ternary operator here.

>         }
>         return false;
>  }
> --
> 2.25.1
>


