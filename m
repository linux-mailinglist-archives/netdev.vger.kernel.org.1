Return-Path: <netdev+bounces-56316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A880E826
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68F0280E21
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6F58AD3;
	Tue, 12 Dec 2023 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsDcJVY5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709CA6
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702374600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nx5UmyccL5qoqkD5GIYjmeEI1AoOZRNTYVJbctvoM4U=;
	b=dsDcJVY51rRXDEJG2BWmmszFsI4lUo/Yts/O7gjNNRHAJwZST1qN0UcPI611JYjt6JcXjQ
	MY6KXqdkEe1tGH7+8imsxuvV/E4AmTtzyX3MjfGgAomBk0zMC4kyOxbWEAeFkJirAVmafy
	RIK4pp/EdQxMQfl7OMwRjtJq2qOPOxY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-iayF3945PySqAr5QtwLGTQ-1; Tue, 12 Dec 2023 04:49:59 -0500
X-MC-Unique: iayF3945PySqAr5QtwLGTQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so89273866b.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374598; x=1702979398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nx5UmyccL5qoqkD5GIYjmeEI1AoOZRNTYVJbctvoM4U=;
        b=hFE5a9WEizHE7rGSGvNF27ZCY/HTYRb0wjEr7pT/aIRw+U5eH48ONnTvPMs6VVftdO
         DR2q0aDhmO1ELEKvVfUYux1b5NxDo+DpjntgIEgPi6BKtepxTxKXKLq2FvjZ/N+Vel7i
         7ccisulBbOD45IvDvt/P7NAIGdB/nwf0CGP9enBdoNGo71xMblZ+TEQU3/voDpGuEiQZ
         EYihmNK9cFl33ipz/xl3WOQAyDKl6pjBs4ozzjO1mYu/VTauE1Ir/8pVrP0fXSSsntUP
         V6vGGGS0oJRg3zHAxtZHhyawP9BNKBXXyAHhKfX6/07MUauIkGa/Y95aqeyrj1JNHr5Y
         pPtg==
X-Gm-Message-State: AOJu0YxR19cGTcgvyKElm1uRevVw0LA6Jo2gzmTXIEP+Ndi1tHl6278F
	eoZV6lOsjB3LrCSrpclFW48G83eYvy0M1/Qe1oFeEfppKOXebtVvusjoGNMv9d5UJ8EcGLJsUdg
	iczrWJ0WltqbhoXx0
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr5808096ejc.2.1702374597871;
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+a2VtUqRmkY0FPQwR91HDhj4RPpZbLrBVrcXemjcNy252HiB1DzY8bcZvAqz+J1OPolDA+g==
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr5808073ejc.2.1702374597524;
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm6059310ejc.130.2023.12.12.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:49:57 -0800 (PST)
Message-ID: <a18c5b93b9732575048c551268a92935db4dbf48.camel@redhat.com>
Subject: Re: [PATCH net-next v14 02/13] rtase: Implement the .ndo_open
 function
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
 larry.chiu@realtek.com
Date: Tue, 12 Dec 2023 10:49:55 +0100
In-Reply-To: <20231208094733.1671296-3-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	 <20231208094733.1671296-3-justinlai0215@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 17:47 +0800, Justin Lai wrote:
> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	struct rtase_int_vector *ivec =3D &tp->int_vector[0];
> +	const struct pci_dev *pdev =3D tp->pdev;
> +	int ret;
> +	u16 i;
> +
> +	rtase_set_rxbufsize(tp);
> +
> +	ret =3D rtase_alloc_desc(tp);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	ret =3D rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & SWF_MSIX_ENABLED) {
> +		ret =3D request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i =3D 1; i < tp->int_nums; i++) {
> +			if (ret)
> +				continue;
> +
> +			ivec =3D &tp->int_vector[i];
> +			if (ivec->status !=3D 1)
> +				continue;
> +
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i", tp->dev->name, i=
);
> +			ret =3D request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);

It looks like that if the above request_irq fails you will never free=20
tp->int_vector[0].irq (and all tp->int_vector[j].irq, for j < i)


Cheers,

Paolo


