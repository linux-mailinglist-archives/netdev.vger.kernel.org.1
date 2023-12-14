Return-Path: <netdev+bounces-57507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8228133C1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D161F21ED7
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0605B5B0;
	Thu, 14 Dec 2023 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ht1YdQaV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46757115
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702566021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWD8flG08948c+kk5diZhSkaE4l4o5OrXgP93+sWFH8=;
	b=Ht1YdQaVbXHF99NaROTAKw+pyFxElWBPcLYpngdUbPwckJOxmYwlAu7U8w50QAjGLotW3+
	8J1zaoLpgHb7Ay7LzAGismGdfsKJxijQUrFWUYCj7wq0JkiwmMSP8uCkO1zK4GnJICNHHn
	YjaxMZTmjjguNZ6SLUPvsfJHq8vKG5s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-kQxS5o81PxWcUwByp5wUTQ-1; Thu, 14 Dec 2023 10:00:19 -0500
X-MC-Unique: kQxS5o81PxWcUwByp5wUTQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1f72871acdso134183166b.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566018; x=1703170818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWD8flG08948c+kk5diZhSkaE4l4o5OrXgP93+sWFH8=;
        b=pBu4nhh9wQeO/1WqUsb7UR/kYYIL6OLYLGFkilYm9tq7nf2AqY6qEDJy+KvVQUv+/F
         ToARqbL+N6ROtLlfT4aha3M1gYWfxz6aECQj3HbHn6L/mLErHOzWC5PPqtODa7Ild8P4
         f4DnWmPUIXMyCQj3ef55BQkRPaI8fRI2zmYhffdN7Nl92asxsInHjT/8hFyYunEwdGmT
         F+9UWb7305aOwVj7Gi1M3qebxhvFy3S3SsvH/C1dkqHMcMmUgunaqdEzK6tjOQUtlTEr
         P0cXhIhaSIzq07sdBtmqZSooru/HOE5iaSt67WlqAlv/RJHlr6SGCUySo0NJPLaAMESl
         3q7Q==
X-Gm-Message-State: AOJu0YwJKTlydRD4Tb/OKU/qbScOQ0USftEvu706UvqR7mNrMQu7iffT
	Do3SwQPcC1iCkEbgN+RHMcPLUSD5Dmmdo851u0KJKBi8w5zLf3AR1mqOvcdysMK1AhI+d0R4cR+
	9uGCOsROEIFmQ643+
X-Received: by 2002:a50:c349:0:b0:552:8299:65fc with SMTP id q9-20020a50c349000000b00552829965fcmr853879edb.4.1702566018700;
        Thu, 14 Dec 2023 07:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEObJZISOhVTutkg5qzmkvSZBjnemH0WpgDmhPCj1LJegEvnc1zWHUUA1QXUujGyd6isycDyg==
X-Received: by 2002:a50:c349:0:b0:552:8299:65fc with SMTP id q9-20020a50c349000000b00552829965fcmr853840edb.4.1702566018356;
        Thu, 14 Dec 2023 07:00:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id cn10-20020a0564020caa00b0054ca2619c1bsm6867552edb.9.2023.12.14.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:00:17 -0800 (PST)
Message-ID: <fa171d50e1a20019b4b2bf302043278909b9072f.camel@redhat.com>
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
From: Paolo Abeni <pabeni@redhat.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi
 <psodagud@quicinc.com>,  Andrew Halaney <ahalaney@redhat.com>, Rob Herring
 <robh@kernel.org>
Cc: kernel@quicinc.com
Date: Thu, 14 Dec 2023 16:00:15 +0100
In-Reply-To: <20231212115841.3800241-4-quic_jsuraj@quicinc.com>
References: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
	 <20231212115841.3800241-4-quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 17:28 +0530, Suraj Jaiswal wrote:
> @@ -3759,6 +3763,7 @@ static int stmmac_request_irq_single(struct net_dev=
ice *dev)
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	enum request_irq_err irq_err;
>  	int ret;
> +	char *int_name;

I'm sorry to nit-pick, but please respect the reverse x-mas tree above,

Otherwise LGTM!

Cheers,

Paolo



