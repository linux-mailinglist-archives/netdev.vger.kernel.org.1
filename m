Return-Path: <netdev+bounces-225318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E5B92212
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C6B3B24F0
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F407310631;
	Mon, 22 Sep 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBuq0FFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9672EA75C
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557215; cv=none; b=ij8QUnv/EDUnQtTR9L9UdRrJTUBVnO3Y7qKUwOrrRd56uCsOBkcQ4W4tVefpeXM4vJZ/FbzCOBUOcjQSv6pygTAmJiKzpyqKpbBqqN7xqDk8Z+JzEJqUpie9C7hsA3GlJYQ9Ves0J+IYTtkY1/XNioSrAjcaQd0XHcxShDPIiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557215; c=relaxed/simple;
	bh=3Ubh+Ltrg5bTipTfPS+WcJFx3UuztPB8Qcf+YIECBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXGin417jja7bsrmHuRydsFfIEo4q7xmb/GFJEmDJQ1mlqTWDiU/FCPVYNISmPX1DIBJm637MoxcOx+kr0DN+ensmC0S2W2l9Fap7+fMYga93nArb3/zsYomAV6fHqPCYqKbhW0QpjnEm2xDvnKQ5af/QWoi99bGDKUHv7G2yTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBuq0FFI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4085855b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557213; x=1759162013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xsq/S5eo1/dC1z71IpbYUCzGRErRKR/1pP9hHqx+ZKM=;
        b=TBuq0FFIKgJoPIwEr5IOZTCvSl8ATKbUS85+5qmFCb7odNDahiJMmose8xs/rKP31Z
         1MhYhThroi3F96s8VIBZahscYhsuDSwmY/iRv4NSnqHZq8O0bdIS8V21NMgZyy/uRbFY
         QWtEUNyDxmRycNnw/5Blkpd8RU2NF7gIhK96eLSQlIEkWJDL0JSE1PRiEtaVMpbk7FNt
         4jG3ah8Trl+8m8bc3In25pghftxlWxhChc/7Pik2NjK8GHKxTCK/O1DfaYNWxxZCf9Qb
         Qx3DSgQG7iAXRqJnUqcDf57wxlO7tBjpiyUuL1H7Iojsh/Xzkw/EYFfHux+kIYm/xl/p
         z/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557213; x=1759162013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsq/S5eo1/dC1z71IpbYUCzGRErRKR/1pP9hHqx+ZKM=;
        b=ZkZ/8H1fyJJUj+kut8JNLbXCMblUInr6rHlqxdd0DSTzDosGIjY6fMnN+AqoE3IEOL
         7+o/InkL0N5O100b2SA8FH6st4zrKeCf2wSreo8uzRdEcCogjhYVfKQwZ+j6COCT+au0
         ZYw9ZIds7BZGcbzJZKD0wOQuKWYAVq/DFAW+BfmWeCWFiQLO+t61G3AiBawqXsfd+QLo
         fxoEgzCzaimQSSVM+BDU7giCpT1F4R3qtREMtl+SRVxM/ipOVu1jOtiDcHCcuM0thJm1
         XfxZ14jIkxd6rfJ0XqRsFjuvbA4nFyT5bOpsaT8X3JcljD6I1x/tkwTsfkHgmgMDprKw
         cazQ==
X-Gm-Message-State: AOJu0YxmKLpb76DJ+lS+FCH5dsiHwEtMbbMJ1JWj8TTXmsxJ1UOSCFq+
	kSjrZcyPu6XYz4IiU7x3c5yLu1sKV0Gq2Wm7Cv34I1s0k203hRi/0kU=
X-Gm-Gg: ASbGncuNA1OdIls+78wROzYKx4FPbL1Xs80vZ1z6yyCErAKlCkH6dhFDLnX4qBLkMVX
	pchaOwNIc3UTN0PADLFR29GoFvKkCxAWBgwaCDwybuIEdv1BEUzDwxYN9vwM5K9o3jzRN5eyJrI
	SApj8nKyL2hdu876FaCiFbFRaV9UQn3IUoBKIJgTs8FK3N9S7Lk1XZd6paivS0MabIqa0F9rJe9
	tJu8Hm1rJQmcKs3L2UJ90D416pcMuIj37yy1fA2MfXEbnehEX0WaZPFrcM/wKtJmGvBtCgJvSBJ
	3xd39IPEleaBYO5Y2lUyWZdOXWaR4uBajMiHqcL3GJ9VhilBZ/mzTtiJzFMnkk/YL6LWQLRAqUr
	XBMsgDVuUFbWY925i3chgw4EJ8uWVanTV0xW4zsGJQssr8DRFylqcu8521KD3v0myUDJFBcqCwO
	iLT9fjbE/7r97Bv1cxSLyWcEeEzrZoyRFcwcJeBOR/nJwXS9R8iZ47YbVGuwzI4KkLnAiMuFDS4
	VBN
X-Google-Smtp-Source: AGHT+IFCO135Y8R4+/omcz/1dIBtNBJbJWcxcTpYOFxbAjmZK4OznS1qy6MqgmMYpyy9B1wRIoGbLw==
X-Received: by 2002:a05:6a21:6d85:b0:263:375b:885e with SMTP id adf61e73a8af0-2921c724b6emr17341980637.26.1758557212819;
        Mon, 22 Sep 2025 09:06:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f3a9f6e88sm3376655b3a.10.2025.09.22.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:06:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:06:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 05/20] net, ynl: Implement
 netdev_nl_bind_queue_doit
Message-ID: <aNF0G6UyjYCJIEO5@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-6-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement netdev_nl_bind_queue_doit() that creates a mapped rxq in a
> virtual netdev and then binds it to a real rxq in a physical netdev
> by setting the peer pointer in netdev_rx_queue.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  net/core/netdev-genl.c | 117 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b0aea27bf84e..ed0ce3dbfc6f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1122,6 +1122,123 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> +	u32 src_ifidx, src_qid, dst_ifidx, dst_qid;
> +	struct netdev_rx_queue *src_rxq, *dst_rxq;
> +	struct net_device *src_dev, *dst_dev;
> +	struct netdev_nl_sock *priv;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
> +		return -EINVAL;
> +
> +	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
> +	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
> +	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
> +	if (dst_ifidx == src_ifidx) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination driver cannot be same as source driver");
> +		return -EOPNOTSUPP;
> +	}
> +

[..]

> +	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);

Why do you need genl_sk_priv_get and mutex_lock?

