Return-Path: <netdev+bounces-56331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01F80E8B9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607C81C20B54
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C359B7B;
	Tue, 12 Dec 2023 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyFfNCUz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5DA6
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702375770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6M/XvsgEA+noH1tcrJHEuC0orIXI1iUMmdFqUMBoqe8=;
	b=UyFfNCUz8tWT+uR46YMHm7dhcGlOQ2WxldBMJV7VUtlriCoVqNulxi51ZGCkDVNyyVl/nW
	n6QNstKcwTz1ZZYdH6zNYYGz5is1rOkigvKlbfWc+JIOoULGtdJNTMgBpnUmdDYdi8M2tu
	9m6/BimFVTaz+gjis6UpXeIdgoxkhls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-jHAmhI_2M463wfBFIQ5YKw-1; Tue, 12 Dec 2023 05:09:29 -0500
X-MC-Unique: jHAmhI_2M463wfBFIQ5YKw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso116501666b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375768; x=1702980568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M/XvsgEA+noH1tcrJHEuC0orIXI1iUMmdFqUMBoqe8=;
        b=rlrhkqe7JjAmc6VZoOhGuyhdztM4WhRLN7CTEbKOAFqQPogKJYxHmu73u9k9L42hXI
         jhPHpkdqiwj/qsSqsdZHUb1bg1wjx9ulRHjZgSJWRbCsWLcRSPmiGIpHYtIzIUqJ2MLP
         HDYbyLexOWwqYDwLrC2leEr/quNADKh5IgHFKQuMcsYIVdoAfFIZK7yGPqJ+kjgKLtBq
         ja7gR0olnWPp0ig3ZF9UY6AEhhsPBg0za5nB7qTONHEKiwCT9x9mgZPVwyk3aWQtGqaS
         QbiSRCK5L6KqLIHTC5+UbesRiFFQiizOYo2HM0DTyIQM3mVYfZXQb1T5P6FxFDTvluuC
         zhMw==
X-Gm-Message-State: AOJu0YxqHkjCpf1arZwuhw6Gjr6zcyj3nNPJWl/3397DlNB/suxrVI+9
	m1RStbLn04VNb6LTjfbSu9JpyBRZjIYvxoTOX2Is42nFM8M/x7qb9FUs92ZjAByHW+hmUtfm/Bn
	VdBJ42k32dnwfbK6q
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6089855ejn.7.1702375768353;
        Tue, 12 Dec 2023 02:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMk1yIC7lV8N6DHVhTHBZBSHd+M1WbawYmyYj2VdjRNDphGCbZUoQdjg2Snt8KS+xKq/RRMg==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6089833ejn.7.1702375767944;
        Tue, 12 Dec 2023 02:09:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm5994983ejc.75.2023.12.12.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:09:27 -0800 (PST)
Message-ID: <955d390c57a93406d40985fbd1856bd1c500d75c.camel@redhat.com>
Subject: Re: [PATCH net-next v14 08/13] rtase: Implement net_device_ops
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
 larry.chiu@realtek.com
Date: Tue, 12 Dec 2023 11:09:26 +0100
In-Reply-To: <20231208094733.1671296-9-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	 <20231208094733.1671296-9-justinlai0215@realtek.com>
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
> +static netdev_features_t rtase_fix_features(struct net_device *dev,
> +					    netdev_features_t features)
> +{
> +	netdev_features_t features_fix =3D features;
> +
> +	if (dev->mtu > MSS_MAX)
> +		features_fix &=3D ~NETIF_F_ALL_TSO;
> +
> +	if (dev->mtu > ETH_DATA_LEN)
> +		features_fix &=3D ~NETIF_F_ALL_TSO;

This latter condition is strictly more restrictive than the previous
one, you can drop the latter. Also could you please drop a note about
the why of it?

Cheers,

Paolo


