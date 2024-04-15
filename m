Return-Path: <netdev+bounces-87842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C88A4C1C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52151F21D1D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9AF4CE17;
	Mon, 15 Apr 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wgi5KAIH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF645944
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175483; cv=none; b=rpiT2ko2bfwxgtspGfQ9mabsshQk0wYYoVeXQOteD7l8kRW0O7OHr3+Z5qLsJLrlN/igJcNhjm+o3p3xjU2J75MZbqRw/9djjHHQW/c0jTg+Pcfpcs1EMBADxwkg5W9wgwUcVJHgH47FUNaSOhY1ZgnhQ8DIEghhHtN9PdppLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175483; c=relaxed/simple;
	bh=9+ChtSQJcG+NuLRA7M+jy/eQpoiTNoiGErhgMF+40xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyeXvxhv0DBf5g4pLxb6gy6R/Tkq2r5vctZOviln8+k8+oseAHv4QuzchRMe5pYBdKbWyzKLYFKb4OKnUShyjJ3FekjZG6SMTYgFWFTsv55kSn+GjiGBd3wjFH+o9HIezXpEbtRBKxcWiDx70cX7GA7pJ53LjvmKcnwlPhYWZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wgi5KAIH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713175478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5XKrzatvWUlnnUFqFAlIEjvUzBVNgciNmpijuKDaQ=;
	b=Wgi5KAIH1o0D0Wic9tVGlLpcRETnNsVvGLLpFfHDTHXmqLxF8gTUY4c37JFl8Lv2+dACxI
	PLrRabb9ZPGQLhqKbTRmTHS+TJmzkVDzYTU04UhrCT6qPk27y6zlJxprLG6Cm9tRIHvvNf
	Hsj2cx4KttlYY+J5P2cH9TIcfBWTFCw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-v58DoSJxOXGm5ls0Tx1E2w-1; Mon, 15 Apr 2024 06:04:36 -0400
X-MC-Unique: v58DoSJxOXGm5ls0Tx1E2w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a52511b783dso152904466b.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175474; x=1713780274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC5XKrzatvWUlnnUFqFAlIEjvUzBVNgciNmpijuKDaQ=;
        b=jJAWhRQPyzhQEY1G11jcX8a+T2CX/mw0ITwKJlmZqp/YN3QruHwk9MXxmVDJuS/Toj
         LFDfP+VCg0q9DMs1IPoTSvOUdh709koljRLHx9dyOy6Ih9P9WHtEL5v1+1BHCXMLgmdz
         bcPmQ9s1R7oddz9mOIwkvwCHKtyI7uUAjln46QhPJy+ZuwxCTqoIYnKOX1+1WWPHM68q
         npB86uUOrCbQTKZuYFYlui5EokPW6NYhpE8edr9yeoeolV+h3YGa2RI6JdXLRyVjR8El
         45HVlgdLZePJL5iNhCp3eUS0/0oLvklOSKHB/4U1sDhVuoo9lC4sqpwjXO1SoL6Jqqja
         98tA==
X-Forwarded-Encrypted: i=1; AJvYcCWH/rQOxNLBSn3/mzmJCsY7GxS5b4tVot3ZUdySiJGaph5tZK0DkA1ltdHLFMJnJwK+1lIQoRgE9LBlkwurLHXcbT7naVdJ
X-Gm-Message-State: AOJu0YwBzmi2kWetJPdptW/TIZ+qx8rZWtQci79vXb0UeQnu34PaTX9h
	drLrZ7j6wjGj0be25ROJlwwX1xJCwkZ5pUuFgquQaQqMsIspLpwN6PJexWjDp3dADGdQaqyzFoQ
	TTxhXskQ9eL5UI1b0rsEUTPZfD0Yrh67wybQwn63nxToKCsnb/UAxEbuPVV316Q==
X-Received: by 2002:a17:907:208f:b0:a52:6b12:3078 with SMTP id pv15-20020a170907208f00b00a526b123078mr1289450ejb.55.1713175474616;
        Mon, 15 Apr 2024 03:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoBgcZVSFEERVnpXhY/VFEAhN+5uIEWYJM9NHOkDtt9ewJAGdi8vs+QQdkS6+M090UemheIw==
X-Received: by 2002:a17:907:208f:b0:a52:6b12:3078 with SMTP id pv15-20020a170907208f00b00a526b123078mr1289441ejb.55.1713175474278;
        Mon, 15 Apr 2024 03:04:34 -0700 (PDT)
Received: from [172.16.1.27] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090624ca00b00a46a2779475sm5241559ejb.101.2024.04.15.03.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:04:33 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "jun.gu" <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, dev@openvswitch.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH] net: openvswitch: Check vport name
Date: Mon, 15 Apr 2024 12:04:32 +0200
X-Mailer: MailMate (1.14r6028)
Message-ID: <9D534A61-4CC2-4374-B2D8-761216745EDD@redhat.com>
In-Reply-To: <20240413084826.52417-1-jun.gu@easystack.cn>
References: <20240413084826.52417-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 13 Apr 2024, at 10:48, jun.gu wrote:

> Check vport name from dev_get_by_name, this can avoid to add and remove=

> NIC repeatedly when NIC rename failed at system startup.
>
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> ---
>  net/openvswitch/vport-netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-net=
dev.c
> index 903537a5da22..de8977d7f329 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -78,7 +78,7 @@ struct vport *ovs_netdev_link(struct vport *vport, co=
nst char *name)
>  	int err;
>
>  	vport->dev =3D dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> -	if (!vport->dev) {
> +	if (!vport->dev) || strcmp(name, ovs_vport_name(vport)) {

Hi Jun, not sure if I get the point here, as ovs_vport_name() translates =
into vport->dev->name.

So are we trying to catch the interface rename between the dev_get_by_nam=
e(), and the code below? This rename could happen at any other place, so =
this check does not guarantee anything. Or am I missing something?

>  		err =3D -ENODEV;
>  		goto error_free_vport;
>  	}
> -- =

> 2.25.1
>
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev


