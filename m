Return-Path: <netdev+bounces-55653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2C80BD70
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 22:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2573E1F20ED2
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D51CFA8;
	Sun, 10 Dec 2023 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3gB1fzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DBCCF;
	Sun, 10 Dec 2023 13:54:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so49058671fa.0;
        Sun, 10 Dec 2023 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702245243; x=1702850043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BzhCYsOZapAFD897Nx82YDtzNYYx8urjaCEnmiHd3w=;
        b=H3gB1fzcdlI4zMq5cUKyCFIb6U1woji1MMc5pcC5J+ECT70sNPailhPpluOERtLyxY
         9x4ZMOLyJ7+tHIPffCXihVie3M6nhhZYokPjM7hJu9fSeiDyZUw8vAH2oBXfJHywVnF+
         yR/Mg4jQPynK0ZDWPPKi6vXf3TyVOXmzOaWOOLfUhJoX3HepSPtq9i3HuL/TgyPWgBm9
         /AimqWsMruZ5g6x2PdDql8MIvUNB1g5mru298nUnFIwqis4rHQufIbCXgMd3OH/YGRHx
         yEAFDABMsXtOUxQ0C/Es/NDDeFniffYue8bUb0hLAj1oFsMQ7w6xhXjMBf6L/MMgEntI
         P9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702245243; x=1702850043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BzhCYsOZapAFD897Nx82YDtzNYYx8urjaCEnmiHd3w=;
        b=iR4oAv+i/HR/KxRNQCdKFogxh7efsdBDEhMkGHY3mwuVRfDMEFdaa7GRTOT5N8yZpQ
         phc29rBzeYTAeeTIo6N+5SSfaBuYuH5LpoPuktu02XwW5iwy1l8rEMsNn7pi8wD82mZB
         Mb1ll+LbZ3JVm5spmS6okqTv5dnq91VArQyffcgOLz+A6ze7vm1lmvRC+uDFWHI1FlBM
         8Xc5A8XMgG6VIzAl39mvxQmuZMihIs4RGloO8t6D3McXbB+IszuwQbeyDAfTttRqq/fY
         q9eoFqwbfCaU2NuLVHPATPlps3v3q4NRqwbvdWke6zboX1TKFpfbwx5gQBb8FnuCvQu5
         Oyzg==
X-Gm-Message-State: AOJu0YzPgZZ5+Bm7UGXEcN+mBrs5o6nC2ld82bCDm/AOcq7miVFga4bo
	/fhbD6G46q1jpPjdylKAa0o=
X-Google-Smtp-Source: AGHT+IEfKA7MW9B2gqdrOJvd3Ro3fzvD+AnicTEHeOn2LgYKq2XR4eo43oWQzCKiOAiyI7gQJrc0XQ==
X-Received: by 2002:a05:6512:b88:b0:50d:438e:dbdd with SMTP id b8-20020a0565120b8800b0050d438edbddmr1084532lfv.136.1702245243124;
        Sun, 10 Dec 2023 13:54:03 -0800 (PST)
Received: from fr.lan ([81.200.16.167])
        by smtp.googlemail.com with ESMTPSA id i21-20020a056512341500b0050bf20118e2sm901930lfr.30.2023.12.10.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:54:02 -0800 (PST)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: patrick@stwcx.xyz
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peter@pjd.dev,
	sam@mendozajonas.com
Subject: Re: [PATCH net-next v2 3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC Address command
Date: Mon, 11 Dec 2023 00:53:56 +0300
Message-ID: <20231210215356.4154-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231114160737.3209218-4-patrick@stwcx.xyz>
References: <20231114160737.3209218-4-patrick@stwcx.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick, Peter,

> +static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
> +{
> +	struct ncsi_dev_priv *ndp = nr->ndp;
> +	struct net_device *ndev = ndp->ndev.dev;
> +	struct ncsi_rsp_gmcma_pkt *rsp;
> +	struct sockaddr saddr;
> +	int ret = -1;
> +	int i;
> +
> +	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
> +	saddr.sa_family = ndev->type;
> +	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +
> +	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
> +		    rsp->address_count);
> +	for (i = 0; i < rsp->address_count; i++) {
> +		netdev_info(ndev, "NCSI: MAC address %d: %02x:%02x:%02x:%02x:%02x:%02x\n",
> +			    i, rsp->addresses[i][0], rsp->addresses[i][1],
> +			    rsp->addresses[i][2], rsp->addresses[i][3],
> +			    rsp->addresses[i][4], rsp->addresses[i][5]);
> +	}
> +
> +	for (i = 0; i < rsp->address_count; i++) {
> +		memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
> +		ret = ndev->netdev_ops->ndo_set_mac_address(ndev, &saddr);
> +		if (ret < 0) {
> +			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
> +				    saddr.sa_data);
> +			continue;
> +		}
> +		netdev_warn(ndev, "NCSI: Set MAC address to %pM\n", saddr.sa_data);
> +		break;
> +	}
> +
> +	ndp->gma_flag = ret == 0;
> +	return ret;
> +}

seems very similar to ncsi_rsp_handler_oem_gma except address_count, why it
shouldn't be part of this call with additional param? What's inside it just
code duplicity of ncsi_rsp_handler_oem_gma.

And as we talked in openbmc mailing list, ndo_set_mac_address do not notify
network layer about mac change and this fixed part already in
ncsi_rsp_handler_oem_gma with 790071347a0a1a89e618eedcd51c687ea783aeb3 .

David, any actions should be needed about fixing it in net-next? Need it to
put patch above with fix or do the revert from net-next and make it right?

Thanks.

