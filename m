Return-Path: <netdev+bounces-49615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAA7F2BF3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC5E282259
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EAE487A5;
	Tue, 21 Nov 2023 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1P5Mzfc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1810F
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 03:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700566887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZq9k7yCuLBh1RGCYnoDEbpVMTs0DA2DlRMJfxcoyaY=;
	b=L1P5MzfcIFtMph1P2vtiIOrjpKx4zWjEqF6/Ynm0wOzitKda8hxtaroR0BgijZ7jJf6D7N
	C+gYxCU24+3va5wCeZSmVYJtLpERBYTQc57SlU1Lwopzy9M6R4AjjBSdPsFOM/jAR8+e46
	6gNK8SGHUGllGy0ATC1w9v3tZXUYvEc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-T7_QphvXNhi-a1eh2mTa3g-1; Tue, 21 Nov 2023 06:41:26 -0500
X-MC-Unique: T7_QphvXNhi-a1eh2mTa3g-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5b596737797so8084167b3.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 03:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566885; x=1701171685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZq9k7yCuLBh1RGCYnoDEbpVMTs0DA2DlRMJfxcoyaY=;
        b=G2lS0OKq/FcgmftI+4Q/lb9zRSdoS0SDmJSRE70VcAdgZDCMMm2I6qvu0NHVKKmDZJ
         sRIhNf4teimMWm1DnpLP2VufQFSjM9kYk21HIdhxThEsq5DCvRGeaOWZw+GaJBuArM3u
         WQX/1fZqIkmGhpWmXrDq135rbnYdRVpjhI1PryGHHL1OzPnviDst7kIUTbcWwfdRRehI
         GxI55ZzBxklwMWz0HfkkGkrz7XYtU7bhLtI1ueYuBmrkD2G2KCjcTZswIi76FZmwdyd1
         GRyFl+lkLIXHrMmajRaJk3r0uyuTff24ECZ5GImzFgbJiVlb7KhloPur6aOIBO73Ap3r
         6lTQ==
X-Gm-Message-State: AOJu0YzX8t4vDLWfaTZXGfAsty9N/UPTkBqhBtTec/03Et1UDHG3UnEK
	jBLHqO5QDudafme/0d+ebrohUioJ/Z8n9RO/L2uh2R2KuQbLiK/yimaakLLjM0LQKiEBNcAYYw+
	qUTNkRpM8t7Tdhg/P
X-Received: by 2002:a05:690c:3208:b0:5a8:9e9:e661 with SMTP id ff8-20020a05690c320800b005a809e9e661mr5637254ywb.1.1700566885655;
        Tue, 21 Nov 2023 03:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwhc0RwQe5J5Iw97xw38v0Hfk1EfHRdS/CFAeW0SmQ+TnXxXLERR2nODewjkp5Apr9InvKpA==
X-Received: by 2002:a05:690c:3208:b0:5a8:9e9:e661 with SMTP id ff8-20020a05690c320800b005a809e9e661mr5637235ywb.1.1700566885301;
        Tue, 21 Nov 2023 03:41:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id z37-20020a81ac65000000b005c9e401400fsm1655701ywj.48.2023.11.21.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:41:25 -0800 (PST)
Message-ID: <0a1642c47f37cbab531fdfdcac187bf2bd392dbf.camel@redhat.com>
Subject: Re: [PATCH net-next,v4] bonding: return -ENOMEM instead of BUG in
 alb_upper_dev_walk
From: Paolo Abeni <pabeni@redhat.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Date: Tue, 21 Nov 2023 12:41:21 +0100
In-Reply-To: <20231118081653.1481260-1-shaozhengchao@huawei.com>
References: <20231118081653.1481260-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-11-18 at 16:16 +0800, Zhengchao Shao wrote:
> If failed to allocate "tags" or could not find the final upper device fro=
m
> start_dev's upper list in bond_verify_device_path(), only the loopback
> detection of the current upper device should be affected, and the system =
is
> no need to be panic.
> So return -ENOMEM in alb_upper_dev_walk to stop walking, print some warn
> information when failed to allocate memory for vlan tags in
> bond_verify_device_path.
>=20
> I also think that the following function calls
> netdev_walk_all_upper_dev_rcu
> ---->>>alb_upper_dev_walk
> ---------->>>bond_verify_device_path
> > From this way, "end device" can eventually be obtained from "start devi=
ce"
> in bond_verify_device_path, IS_ERR(tags) could be instead of
> IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.
>=20
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v4: print information instead of warn
> v3: return -ENOMEM instead of zero to stop walk
> v2: use WARN_ON_ONCE instead of WARN_ON
> ---
>  drivers/net/bonding/bond_alb.c  | 3 ++-
>  drivers/net/bonding/bond_main.c | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
> index dc2c7b979656..7edf0fd58c34 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *uppe=
r,
>  	if (netif_is_macvlan(upper) && !strict_match) {
>  		tags =3D bond_verify_device_path(bond->dev, upper, 0);
>  		if (IS_ERR_OR_NULL(tags))
> -			BUG();
> +			return -ENOMEM;
> +
>  		alb_send_lp_vid(slave, upper->dev_addr,
>  				tags[0].vlan_proto, tags[0].vlan_id);
>  		kfree(tags);
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 51d47eda1c87..1a40bd08f984 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2967,8 +2967,11 @@ struct bond_vlan_tag *bond_verify_device_path(stru=
ct net_device *start_dev,
> =20
>  	if (start_dev =3D=3D end_dev) {
>  		tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
> -		if (!tags)
> +		if (!tags) {
> +			net_err_ratelimited("%s: %s: Failed to allocate tags\n",
> +					    __func__, start_dev->name);

I'm sorry for the repeated back and forth, but checkpatch points out
that the above warning adds little value: if the memory allocation
fails, the mm layer will emit a lot warning comprising the backtrace.

I suggest to drop it, thanks!

Paolo


