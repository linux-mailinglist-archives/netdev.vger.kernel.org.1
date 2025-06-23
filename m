Return-Path: <netdev+bounces-200271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE5AE4143
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853743B2C9E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6532494F8;
	Mon, 23 Jun 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ4Y/FAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4023ED56
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683221; cv=none; b=mfJ0Zoc5cV49LhyXpKuM5wiz+ObL/6kga/hD3NmzorZmAl43TxRzywmMcYXDnARjkKL2t3V+YeNrx44gsmTvRuvik1Lh19tpnur8i1E8Yf/k7TtdxxodzwN9BnNgPpXl4jKVfE865+rOcCFeRCrVwEe8itvcaljItQPwPb/7g0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683221; c=relaxed/simple;
	bh=HESYCwxtTCrMkmrbuFYPB++g7gvN/5zo0tw6nMc4pqA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=W/Xq7OXToAt8+sNWbuL3ErGnbdC+BOtVYagZOXO+/c9eF+IKIjsFyUk+YggAwhEHpmDsYPBdqpGf5oSyYI/GwOcFEmLweFVYEUTordvB34mjtOJwOATZRJLAZH3J9yXSbM+PU9jbM7j8dzKdUO6+iC5BenSUteWwSb41VbMbEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ4Y/FAv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so43687655e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683218; x=1751288018; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I28Qoudqg6FqMNnDwRZB2GBcdBQVhMvcpaGUG0Uox00=;
        b=FQ4Y/FAvMrUKqsHXNqemiB3rXDEHW6/fvtYJ9o0uv/NdC0zX5Tg0rjmUwyEjJ51nWu
         Hhhb9Ma+j83TSjW5yAEcwluDT9YD/mXtwKwV5D2SgzqtGf4ePxyC/ZNqGjOgcxbQVcC0
         WTgYtxgco3V8h1G7eytEtLdKgLfctkzXI3P2FQtf8Mu4KCABp4jrlRt1fjdGnJNgo2py
         XAk7IwLhbsK1sue9v6Rml/vuo/LWv3ZTkhrYtFBgbRvmzle8TpN5eTgXgEaf9H5BSfVb
         GFTI1DhG7Flh3rWuWXZebYga64Yre7W8kpQfQjY1ZUbkLDwI35azhZdyoWVL6HhxVfat
         xKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683218; x=1751288018;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I28Qoudqg6FqMNnDwRZB2GBcdBQVhMvcpaGUG0Uox00=;
        b=mv9WsaFawTmCp2jDixdIMMl0WFqsKehzISYS2Pz7QNMGI2eZVDmAsWhJURIXkZLTzT
         aGuXnN19d7j7IrawYXtLE6nuZhpkFXZmXpG2tX5GhpDOrW/x5aAM+9bw6/l/kry5/IDX
         5IvZXonqHQasw/RkLb43c34PZDyd+JPWDpfkCRCXZa92HzVAz7FXM6e7+145F3XSTN38
         k+mRF86tvWCSbZnzu2Pt3nlJ67u0WowKmwG8rU02BDfXB1G+CGyjKHPFpO8d9laR26ZM
         epDatVLo1/r4aZjmBbVXZpFbOD5yd7OQkSAJ4mPDJW4E+/BP/lpQ93ktT+f7cIoTSFzl
         r1ew==
X-Forwarded-Encrypted: i=1; AJvYcCUrgjmbf4StWYHsWbFWP1+T70INhMaEugFmiOvN3slKI3bgUCvPfW70V07NI0cC5Bjlb2qahxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPy7MY4WL27wh2JIr179QEKOdnf9DAnlTx2hHRQ+ke7Cz7QeK
	7dur49btgSbvLDLgUIMr6jKS1EEycey2isVOKFOD9ttJS9xjnN4i4WPf
X-Gm-Gg: ASbGncucM3D2TN5jQjpDvpQfU4vIGKlaE2TXkmC+I7giNyCc6Kyc3gsfu6bhzleSNpe
	xkWE6QwU7aSb9pdNlgbfdjuNgKOvtYdPAEzfuvdUdS5TME0zi3kg0Ep5rqFDmuI48fzNG83MVoR
	WBaJZrMVKtpXeaCwp70yFMCTK3Ui/LaI9bfgtE58mAxEJtmQemeLMqzISIfqh2p8P55ItPvXi3V
	CSnJy+PqX7MYVBpyyohGMk+Yuai4633GXchdUZF3r3fruibTx3GtR/zeepD+lIlPabw3ptI4XNM
	kNlf3haZ2t/RbGJy68P5cutpr/MAlXMTPbI2/IJkso0/9/9TU4FkwNIDYIQkE8c3WFvDRLFy6H8
	=
X-Google-Smtp-Source: AGHT+IH7ph15XgCuNVw6LvKEAMtEYhmrlgALDiEcC1R14CZYfkZ2QMw1kheSsrT64fEimUH1kDjMHQ==
X-Received: by 2002:a05:6000:4284:b0:3a5:783f:5289 with SMTP id ffacd0b85a97d-3a6d1310426mr9440612f8f.49.1750683217895;
        Mon, 23 Jun 2025 05:53:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ed85:62cb:5684:a2ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1187df7sm9412999f8f.66.2025.06.23.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 05:53:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  maxime.chevallier@bootlin.com,  sdf@fomichev.me,  jdamato@fastly.com,
  ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 2/9] net: ethtool: dynamically allocate full
 req size req
In-Reply-To: <20250621171944.2619249-3-kuba@kernel.org>
Date: Mon, 23 Jun 2025 13:01:10 +0100
Message-ID: <m2a55yekft.fsf@gmail.com>
References: <20250621171944.2619249-1-kuba@kernel.org>
	<20250621171944.2619249-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> In preparation for using req_info to carry parameters between
> SET and NTF allocate a full request into struct. Since the size

typo: into -> info

> depends on the subcommand we need to allocate it on the heap.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/netlink.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 9de828df46cd..a9467b96f00c 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -863,8 +863,8 @@ static int ethnl_default_done(struct netlink_callback *cb)
>  static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	const struct ethnl_request_ops *ops;
> -	struct ethnl_req_info req_info = {};
>  	const u8 cmd = info->genlhdr->cmd;
> +	struct ethnl_req_info *req_info;
>  	struct net_device *dev;
>  	int ret;
>  
> @@ -874,20 +874,24 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (GENL_REQ_ATTR_CHECK(info, ops->hdr_attr))
>  		return -EINVAL;
>  
> -	ret = ethnl_parse_header_dev_get(&req_info, info->attrs[ops->hdr_attr],
> +	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
> +	if (!req_info)
> +		return -ENOMEM;
> +
> +	ret = ethnl_parse_header_dev_get(req_info, info->attrs[ops->hdr_attr],
>  					 genl_info_net(info), info->extack,
>  					 true);
>  	if (ret < 0)
> -		return ret;
> +		goto out_free_req;
>  
>  	if (ops->set_validate) {
> -		ret = ops->set_validate(&req_info, info);
> +		ret = ops->set_validate(req_info, info);
>  		/* 0 means nothing to do */
>  		if (ret <= 0)
>  			goto out_dev;
>  	}
>  
> -	dev = req_info.dev;
> +	dev = req_info->dev;
>  
>  	rtnl_lock();
>  	netdev_lock_ops(dev);
> @@ -902,7 +906,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (ret < 0)
>  		goto out_free_cfg;
>  
> -	ret = ops->set(&req_info, info);
> +	ret = ops->set(req_info, info);
>  	if (ret < 0)
>  		goto out_ops;
>  
> @@ -921,7 +925,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	netdev_unlock_ops(dev);
>  	rtnl_unlock();
>  out_dev:
> -	ethnl_parse_header_dev_put(&req_info);
> +	ethnl_parse_header_dev_put(req_info);
> +out_free_req:
> +	kfree(req_info);
>  	return ret;
>  }

