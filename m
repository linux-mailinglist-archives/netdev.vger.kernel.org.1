Return-Path: <netdev+bounces-53970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA28057A2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C971F216FC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C95FF13;
	Tue,  5 Dec 2023 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyiBygZK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510DCA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701787412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wm0ITqw2DU4e2VWwVFECygR4LDXbZjwyDzaWgvJfF0=;
	b=RyiBygZK9JWzdNe9xcpB/zgVRofPWd99coeMBZFanuqC7HxvKryo6rHoiCahXtZYAz2K9/
	v3zebBobzynEFrW/T6HsFvOc1gm2Ps3x0yKGSQ7xA3RPA6TZnQBQ3c6TpLvEN+SZ/cYEhU
	tSsPQpe1HObF0P2yLKVk8wcz+E+PfsA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-5CZ61qZfO--vdbusBPujAg-1; Tue, 05 Dec 2023 09:43:28 -0500
X-MC-Unique: 5CZ61qZfO--vdbusBPujAg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1cf7d2af71so3650566b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787407; x=1702392207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wm0ITqw2DU4e2VWwVFECygR4LDXbZjwyDzaWgvJfF0=;
        b=EvY+/x0Iw9H0yxieP9SY1rcqYTKu8XK+JLrtB/Ph0jBWh2oMWC+6v2DuoX5gZarAjI
         mtON2XOdIyYJMF3R+XyQQyzbz16m8gYM2j7elAbzgI/KTKmRZS3DJq03+s2uLTZTyEwj
         tQV2qzm2T67lXe+QsParvBeRvyrco+0IM1CN88MnvVgAL8Wel9m9GEBTUnfWAroajq+P
         A/oKidMyBbKELDkDv12BPrc9JSjItqQ2q7Yu6G89HNcg5ZtbROC6Yenn2Ib8hMJmGpte
         sQeoyIg3lh2J4RgpoZNeUx7IPviRPjI16AaAqDvdVW72vKySnsLqdcyK2S3tuBOsNz/5
         h+sg==
X-Gm-Message-State: AOJu0YySAhyfS6hmJwCIGeBiU9BBzQ5F1b8XbUcHg/hyujWOAtdl4Xd8
	42e6OuXExETkKKtxiQKIVjVz244WI3jxMvspat08BReVg8ZnF8p0hv5pfnt2oPgCTxUwHTWKZJi
	iqR2bFnF+246lDXKc
X-Received: by 2002:a17:906:3c4e:b0:a1c:7661:d603 with SMTP id i14-20020a1709063c4e00b00a1c7661d603mr1236190ejg.4.1701787407347;
        Tue, 05 Dec 2023 06:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTVwX4BoJTERHhYpuGgK7LnHRpXrWl+hzwooY5ZTjkhx74NN8Pxxz0TreVROkv5bngH7CHxQ==
X-Received: by 2002:a17:906:3c4e:b0:a1c:7661:d603 with SMTP id i14-20020a1709063c4e00b00a1c7661d603mr1236173ejg.4.1701787406923;
        Tue, 05 Dec 2023 06:43:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b009fdd2c6d042sm6836584ejd.148.2023.12.05.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:43:26 -0800 (PST)
Message-ID: <e9939ee50ffefe518862bf5616252f84c4c22d5b.camel@redhat.com>
Subject: Re: [EXT] Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From: Paolo Abeni <pabeni@redhat.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Jerin Jacob Kollanukkaran <jerinj@marvell.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, Subbaraya Sundeep Bhatta
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, George
 Cherian <gcherian@marvell.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Zhipeng Lu <alexious@zju.edu.cn>
Date: Tue, 05 Dec 2023 15:43:24 +0100
In-Reply-To: <DM6PR18MB2602D6C118100B0AC5F7D35FCD85A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
	 <6bb19e86b3f5c83bbc85c09b845e52208ce424d7.camel@redhat.com>
	 <DM6PR18MB2602D6C118100B0AC5F7D35FCD85A@DM6PR18MB2602.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 13:13 +0000, Geethasowjanya Akula wrote:
> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Tuesday, December 5, 2023 6:05 PM
> > LGTM
> >=20
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> >=20
> > but allow some little more time for Marvel's people to have a better lo=
ok.
> >=20
> > Cheers,
> >=20
> > Paolo
> Ack. Thanks for the patch.=20

Thanks for the review!=20

Next time, please use the formal tag:

Acked-by: <you> <your email address>=20

so that the tools we use will propagate it automatically.

Cheers,

Paolo


