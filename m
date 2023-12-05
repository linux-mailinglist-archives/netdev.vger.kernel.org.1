Return-Path: <netdev+bounces-53934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CC80543C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3761F214EA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20745C8EB;
	Tue,  5 Dec 2023 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnuXhGmS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC259135
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701779710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DwGrP4LOcEDhuukK6/wBXzdqZN1dqbWTFoUTAihTAk=;
	b=YnuXhGmSGKGioNJJjgUdCMpl37d4CK8xQQWBcGWCPkrVyUGPiggQEDpJviIYoYuyupFxX6
	rO6dnng5SJGCgqy5oKqrB2ByhzUdV1JjWJg4gPWz0cIPYj1Op0tDSWpW16HJoQGSjwbIGM
	LN6f1XxPzbiuR8m+09K5QHpQhqt3lGM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-SfLgJYSnOjqNX-xzzFV1eQ-1; Tue, 05 Dec 2023 07:35:09 -0500
X-MC-Unique: SfLgJYSnOjqNX-xzzFV1eQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a19a974cccfso66176366b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 04:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779707; x=1702384507;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DwGrP4LOcEDhuukK6/wBXzdqZN1dqbWTFoUTAihTAk=;
        b=W+6yuAj3//5MecCLQDQ8sMq8olMzmEFgA6NjA0DJNy+u5fMP0RwsSptCYDNKQ+bQhU
         tsUFXDiLCBkdi/0XnT5tFS1a86RGp1oxn2AwQ3fLs6VspGIMAK1jWcwJRH+60WWvt2UX
         T6Ci3U9TIcXR+gYJEOaIggESqxBEepoU/f5aUZXq76qOhEr+pdy3LLeCnKvhpsk6FW3E
         oFaT/pviBxFfLo9XkUsZTx5UyV1+1OoMtF0MDaxf+RWR+l4lTQx0SxRPdYnrDraHwOhQ
         uJ8WOauctW3WSEFAUx0+NJevwYTuMGe5QdNOwdAz7pBo1LUXzkifju0PJZQ4KN6k916l
         KXVg==
X-Gm-Message-State: AOJu0YzOGyqLDv5nfo33syqukC3dsySV+6gwjT8TjLzV64eLdL1AeaJ4
	2F1fJmBCCGajjhlkpXnuE07KT23Axvlks65dkfsBhutzv5OkHP/TotoQffeKZLum5Da+8OM+qQS
	Bt2ruxKf8jdLm0vJP
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1557176ejc.7.1701779707589;
        Tue, 05 Dec 2023 04:35:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuSZp9LKqyfpMrOE70M71zmI6cNJo0W3WIDa52qufIoKhA+eMs0comLsDg/dvVVJ/6iOUq/g==
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1557156ejc.7.1701779707285;
        Tue, 05 Dec 2023 04:35:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709061f4800b00a0435148ed7sm6750839ejk.17.2023.12.05.04.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:35:06 -0800 (PST)
Message-ID: <6bb19e86b3f5c83bbc85c09b845e52208ce424d7.camel@redhat.com>
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From: Paolo Abeni <pabeni@redhat.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>,  Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,  Subbaraya Sundeep
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, George
 Cherian <george.cherian@marvell.com>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 05 Dec 2023 13:35:05 +0100
In-Reply-To: <20231202095902.3264863-1-alexious@zju.edu.cn>
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-02 at 17:59 +0800, Zhipeng Lu wrote:
> The rvu_dl will be freed in rvu_npa_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through rvu_npa_health_reporters_create,
> rvu_health_reporters_create, and rvu_register_dl. Finally it goes to the
> err_dl_health label, being freed again in
> rvu_health_reporters_destroy(rvu) by rvu_npa_health_reporters_destroy.
> In the second calls of rvu_npa_health_reporters_destroy, however,
> it uses rvu_dl->rvu_npa_health_reporter, which is already freed at
> the end of rvu_npa_health_reporters_destroy in the first call.
>=20
> So this patch prevents the first destroy by instantly returning -ENONMEN
> when create_workqueue fails. In addition, since the failure of
> create_workqueue is the only entrence of label err, it has been
> integrated into the error-handling path of create_workqueue.
>=20
> Fixes: f1168d1e207c ("octeontx2-af: Add devlink health reporters for NPA"=
)
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/dr=
ivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 41df5ac23f92..058f75dc4c8a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -1285,7 +1285,7 @@ static int rvu_npa_register_reporters(struct rvu_de=
vlink *rvu_dl)
> =20
>  	rvu_dl->devlink_wq =3D create_workqueue("rvu_devlink_wq");
>  	if (!rvu_dl->devlink_wq)
> -		goto err;
> +		return -ENOMEM;
> =20
>  	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
>  	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
> @@ -1293,9 +1293,6 @@ static int rvu_npa_register_reporters(struct rvu_de=
vlink *rvu_dl)
>  	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
> =20
>  	return 0;
> -err:
> -	rvu_npa_health_reporters_destroy(rvu_dl);
> -	return -ENOMEM;
>  }
> =20
>  static int rvu_npa_health_reporters_create(struct rvu_devlink *rvu_dl)

LGTM

Acked-by: Paolo Abeni <pabeni@redhat.com>

but allow some little more time for Marvel's people to have a better
look.

Cheers,

Paolo


