Return-Path: <netdev+bounces-50340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D27F564F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476FA28168F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD45D901;
	Thu, 23 Nov 2023 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtVMFoct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E17112
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:13:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso278719a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700705613; x=1701310413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIWPLZE5T1LZjUbz7Z6/yA+PKxMgw2R9Mou2vwKww88=;
        b=WtVMFoctMeosZdhISI29vA3dmoGtuPEDuIRdPTC43TVMA9xfkPMZdHUSrw+p2Gqttf
         9VHwuIW4oBpLk4YM2M3vK9+ZeNNE6VmxTDC5tot+60D27pR6OlqU+NG/ceJAPWOA9wcJ
         ozRiOeymhcQLan53wf5d/qidsOtoBWgVCQlRX4wXVJQIXx5xMmZ5Ohtvu/uZigEyLdzW
         Y9P4jBZTmBL6EUST0QVnO2BdED1yFTPfbeChSZZllIxHXWESHYU2PiizRJoqlcMM0KIS
         RiWIUM97G+HOhXySOYdrKspPO3dv42iwZAg04Dd5upeyJ4a9+0Z098lFz/pn5i4lAdMo
         vrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700705613; x=1701310413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIWPLZE5T1LZjUbz7Z6/yA+PKxMgw2R9Mou2vwKww88=;
        b=okFD/OaD6SdBFK23NvhHABifnBfvAzqov7Ty/UJx4fPDGJmJQNnXdczXhLTvpYVdS4
         ulwEdY/7YnKIjpMZ6nlZQ6AeZtif55AG5Nd8RQPKl684bmNnhZIzBDB66GYB3AzAzpWC
         FDPyfffITnj4aWoKoHqIAdaLlL9N2RQCDqyjArBSezA6FSaMEJcgzJwigE6pZFJtMKSA
         ME9q1Q5otNck3bY3XVbmCR/O34BC2TNTAfp0h3EGsSGqy60z78Ynq0fQDXqNtOhatlI+
         3j+RKEQG66Iilz+pqM18zTbzCVvL+31oUyAbojsIe9G+ymj35Qi3mNT4nGXgAuTvkDaT
         vRjA==
X-Gm-Message-State: AOJu0YzbSgjY6KLKYJSXN4t2CIk6YP2yQqgl9Hfi6/DftI6nZz0GBkiY
	k26mdw8HxNS6x5E1W8k/7Pw=
X-Google-Smtp-Source: AGHT+IFkJFOZ3WWAtQwhGlg2ltAfCYO4/T8IvU3Jhka2bs0nL+7PjhCn8pbOcLNf87w9oSu1ZjARZw==
X-Received: by 2002:a17:90b:3506:b0:26d:17da:5e9f with SMTP id ls6-20020a17090b350600b0026d17da5e9fmr4233236pjb.1.1700705613273;
        Wed, 22 Nov 2023 18:13:33 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ab30800b00285125abb33sm179211pjr.4.2023.11.22.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 18:13:32 -0800 (PST)
Date: Thu, 23 Nov 2023 10:13:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] bonding: remove print in bond_verify_device_path
Message-ID: <ZV61R5OjWW+lbZ/O@Laptop-X1>
References: <20231123015515.3318350-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123015515.3318350-1-shaozhengchao@huawei.com>

On Thu, Nov 23, 2023 at 09:55:15AM +0800, Zhengchao Shao wrote:
> As suggested by Paolo in link[1], if the memory allocation fails, the mm
> layer will emit a lot warning comprising the backtrace, so remove the
> print.
> 
> [1] https://lore.kernel.org/all/20231118081653.1481260-1-shaozhengchao@huawei.com/
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/bonding/bond_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index d987432cee3b..4e0600c7b050 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2973,11 +2973,8 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
>  
>  	if (start_dev == end_dev) {
>  		tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
> -		if (!tags) {
> -			net_err_ratelimited("%s: %s: Failed to allocate tags\n",
> -					    __func__, start_dev->name);
> +		if (!tags)
>  			return ERR_PTR(-ENOMEM);
> -		}
>  		tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
>  		return tags;
>  	}
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

