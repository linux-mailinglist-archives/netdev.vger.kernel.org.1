Return-Path: <netdev+bounces-48266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C667EDDC5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141F1B209EC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF91119D;
	Thu, 16 Nov 2023 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOc8Yoi3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E0101
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Hf8LAx7bki1E0+UUAWwLzQvW31NE2EWhiu1SC5q3wA=;
	b=AOc8Yoi3HESqB7RCFhrzAPhorJm2sQl82BAXr1T4Bqk0cts1bG5ErUepmrz6iujra4bXfL
	gQ/hcyhhQjIaNhsWcpnfuMUc0orNxSD6kPI2XUCw5Mw3t61Iu1EfHFHg/FdOnQIu2upPnD
	eaGlPZs7t0U9zqT5C1v3B0NU8l26qIg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-pXHomuL-OPSquMfsqxkpCw-1; Thu, 16 Nov 2023 04:37:59 -0500
X-MC-Unique: pXHomuL-OPSquMfsqxkpCw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c37ff224b9so8918566b.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 01:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127478; x=1700732278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Hf8LAx7bki1E0+UUAWwLzQvW31NE2EWhiu1SC5q3wA=;
        b=YmNJx1UPX8jUXp3aX1juEnGymAfskT4yQywksmQyR/nMZEJEI1y34I3oCVbfDrMHuK
         kG6+qEKQ0NAayYOCNt2R5DrOXDBmFLLgpQabIxJE7Bpy8eQbglS3Wv3muOkP69HBsI/2
         mGV2A9y8c0lQssU+sNngsQD5jbVV/y4pTcfb/sVMEaZA+P0A87MeToWrWlhnXTqroMem
         8FU8IeI751DHjwzu1jBRWWSChLmOOIZ+xWK5NHNVrR9X9PzpW8EUL4pPo12+YlU6XNnu
         jr0G0FC6k/vQS0L1JayfaArqn5DI19UOg/AlW+LKkK0KVJ+Zby+6e74kahe6/L8bg35V
         e6Dw==
X-Gm-Message-State: AOJu0YzXlYfAwzCKTk7OoNWhVY5+p8dcvdMjMu3FQzrMFIjFqy3ePcso
	TPogEDL8PCMWqzpbMJwJgsKsN8aQiWmRiIBUh+J9V9zSAUELkfnRqO20EAQdWJh6CBRX8Oc8VhH
	1GwQqynkc0Fm1Wpmh
X-Received: by 2002:a17:906:1de:b0:9bf:b83c:5efd with SMTP id 30-20020a17090601de00b009bfb83c5efdmr5493542ejj.3.1700127477907;
        Thu, 16 Nov 2023 01:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtvSRCoxqvqt1KeFT05sRiQfB46lYfJJBCPO6bAY48AI0riSceQ/hxVl5Z0X7BgzQkZOEe5g==
X-Received: by 2002:a17:906:1de:b0:9bf:b83c:5efd with SMTP id 30-20020a17090601de00b009bfb83c5efdmr5493519ejj.3.1700127477428;
        Thu, 16 Nov 2023 01:37:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906714900b0099d804da2e9sm8153342ejj.225.2023.11.16.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:37:56 -0800 (PST)
Message-ID: <d17b696c81a57fb857b54a8c05e121be1cfc47fa.camel@redhat.com>
Subject: Re: [PATCH 1/2] net: usb: ax88179_178a: fix failed operations
 during ax88179_reset
From: Paolo Abeni <pabeni@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, davem@davemloft.net,
  edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: weihao.bj@ieisystem.com
Date: Thu, 16 Nov 2023 10:37:55 +0100
In-Reply-To: <20231114125111.313229-2-jtornosm@redhat.com>
References: <20231114125111.313229-1-jtornosm@redhat.com>
	 <20231114125111.313229-2-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 13:50 +0100, Jose Ignacio Tornos Martinez wrote:
> Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
> the following test cycle has been implemented:
>     - power on
>     - check logs
>     - shutdown
>     - after detecting the system shutdown, disconnect power
>     - after approximately 60 seconds of sleep, power is restored
> Running some cycles, sometimes error logs like this appear:
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Fa=
iled to write reg index 0x0001: -19
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Fa=
iled to read reg index 0x0001: -19
>     ...
> These failed operation are happening during ax88179_reset execution, so
> the initialization could not be correct.
>=20
> In order to avoid this, we need to increase the delay after reset and
> clock initial operations. By using these larger values, many cycles
> have been run and no failed operations appear.
>=20
> Reported-by: Herb Wei <weihao.bj@ieisystem.com>
> Tested-by: Herb Wei <weihao.bj@ieisystem.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

We need at least a suitable Fixes tag

> ---
>  drivers/net/usb/ax88179_178a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index aff39bf3161d..4ea0e155bb0d 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1583,11 +1583,11 @@ static int ax88179_reset(struct usbnet *dev)
> =20
>  	*tmp16 =3D AX_PHYPWR_RSTCTL_IPRL;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
> -	msleep(200);
> +	msleep(500);

Do you know if there is some status register you can query for 'reset
completed'? or some official documentation you can quote for the above
delay?

Thanks!

Paolo


