Return-Path: <netdev+bounces-88286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E28A6984
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DC02831D5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2651292C4;
	Tue, 16 Apr 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFJkubt8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D37128828
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266348; cv=none; b=Xj/XUbMrmbmU6SwiBVGPaviJSqx1xNhmDn7KwPCRwJ8/tuBisfMpTT1Bu7gDNyHmA+Ca6Srr5Q/4gD17HYYs+s3qIT/ZsTx4eN0d4ozf/2msnLTHqo3m32K7SF0Z1FZ9LpJXN8l3i1Hzdeat/gUS2VVlrpyTMWU0VaiA94+dfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266348; c=relaxed/simple;
	bh=kLK2wIAtX77sXwN9DyvCdd2C+aZ02ii+GKN/2TD2yjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENDAHRd7M58aGa610mV4spXxprAiuPaonLx0ISpBDE/WZsMCOw9xXE0bnpm48lgMntMItmygnWVgnCwhvY1l9FXF9y2hY+cRTpUWX5BHjwqBxrChb9kKBdA7DX5DyQvAsulipKE5mkU6yVSkTSQW4ijYi/fx2Fd/gO9RR/w18dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFJkubt8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713266344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1h5G1/ZaUBJnBo015ozC4a1X19ycNzirPSoh9exd2vQ=;
	b=fFJkubt8j8VJsE+bDxsJs5xmi5a7Hr7uwvBDJjX9SPI7u262o8Dr/nIR1UO9+t63Uj/8OY
	jh63cFIUi1faKOTYGYrX1c7CIuykFSHsmWG0FiSW7YR2eb2NnJnn93h6pP46A/NW3uWu9J
	haVLEB4WRB+DuMFst+uG/l3FtWTfnmc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-_gT1-hYgOBuO91u1wXDDbg-1; Tue, 16 Apr 2024 07:19:03 -0400
X-MC-Unique: _gT1-hYgOBuO91u1wXDDbg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c1ac93679so3313608a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266342; x=1713871142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h5G1/ZaUBJnBo015ozC4a1X19ycNzirPSoh9exd2vQ=;
        b=S0bnoB0qG/vvHp5Plccv+rntWgEAwlQy/ix84N9MbwQOJ3T8LI+lEFY8NI6tqYQusO
         KvhbIqbxwCNJiNgrUBP8s5gkpzE3ifJdCuOL2hjeAwo8Yf8y90mMjpjqyw+Qgo3Quqdp
         K7iJ9JbYmJ5rjbmhePxmQ92GAZbk0N0rpG3mIAbxYLM6tRUli60A80BbxtHgR2PcxLli
         M/ztURYPskicTG1+Ljlxvq7NT9LpVziRBuQS3CqAxJhdDTMA1fZjunw/hYHyCtDA1d4K
         qhLDL+jNJ3df64eoQARkD5I22oaMGHj6HhlQmXqIsQcvLo73XdFhjWZtWFeLtXHCFpWg
         9z2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHrjH4Kb/O8XnQ+6SIMleRNy/Twby66mK2rwlbLK6oq9+crzniTGcahmhaQeNdGIxy/gl6hyBNNd6vA6ItVm7KLjX8zDnM
X-Gm-Message-State: AOJu0YyuRvhXSr1b02Z2MezfqLytomJ0xsVD0d8xynZIY4dzNzyVtRbQ
	mHssklgDspz8S91nZXWXqB9exhGXv0OSCYm2vRcQdxzY4mc9mHe5owSea9vehyr2XMYA+TPVAmx
	8OgxWL8oE8Jl8+Yqd2LPkOeJTQdKbAb/QYIx5QT+VLNxY6XlH9g7qKA==
X-Received: by 2002:a50:d4d7:0:b0:56e:2d9c:7156 with SMTP id e23-20020a50d4d7000000b0056e2d9c7156mr8218644edj.20.1713266341869;
        Tue, 16 Apr 2024 04:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5vnnhy2o7V/NkFhJUrs0+ou9NQnW+7yNEU190zhRq04GaE086eNgklxNqskca4vQHhB2TMg==
X-Received: by 2002:a50:d4d7:0:b0:56e:2d9c:7156 with SMTP id e23-20020a50d4d7000000b0056e2d9c7156mr8218632edj.20.1713266341539;
        Tue, 16 Apr 2024 04:19:01 -0700 (PDT)
Received: from [10.39.195.10] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7cb86000000b0056e3707323bsm5932264edt.97.2024.04.16.04.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:19:01 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "jun.gu" <jun.gu@easystack.cn>
Cc: dev@openvswitch.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pshelar@ovn.org
Subject: Re: [PATCH v2] net: openvswitch: Check vport net device name
Date: Tue, 16 Apr 2024 13:19:00 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <27644212-924C-4AB2-88F6-D209E2586E82@redhat.com>
In-Reply-To: <20240416092022.35887-1-jun.gu@easystack.cn>
References: <084E7217-6290-46D2-A47A-14ACB60EBBCA@redhat.com>
 <20240416092022.35887-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 16 Apr 2024, at 11:20, jun.gu wrote:

> Check vport net device name to avoid the name that be used to query is
> inconsistent the retured name.
>
> Consider net device supports alias, the alias can be set to interface
> table in ovs userspace. Consider the following process:
> - set a net device alias to interface table.
> - ovs userspace run OVS_VPORT_CMD_NEW cmd to kernel, kernel will use ne=
t
> device alias to query net device by dev_get_by_name, but the net device=

> name that return is inconsistent the name used to query.
> - the returned net device name is saved a hash table.
> - ovs userspace found that the name saved to interface table is
> inconsistent the name saved kernel hash table, it will run
> OVS_VPORT_CMD_DEL cmd to kernel and remove vport.
>
> ovs userspace will run OVS_VPORT_CMD_NEW and OVS_VPORT_CMD_DEL cmd
> repeatedly. So the patch will check vport net device name from
> dev_get_by_name to avoid the above issue.

Maybe the commit message needs a rewrite to be more clear (shorter)? I=E2=
=80=99ll leave this up to the maintainers to judge.

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

I was eluding to a comment here, something like:

        /* Ensure that the device exists and that the provided
         * name is not one of its aliases.
         */

> -	if (!vport->dev) {
> +	if (!vport->dev) || strcmp(name, ovs_vport_name(vport)) {
>  		err =3D -ENODEV;
>  		goto error_free_vport;
>  	}
> -- =

> 2.25.1


