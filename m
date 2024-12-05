Return-Path: <netdev+bounces-149309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD679E5172
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B208188168D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0921D47A2;
	Thu,  5 Dec 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsP/MMTr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359A1A8F84;
	Thu,  5 Dec 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391284; cv=none; b=R5S55ZdrSMNoVOeNmyp8QPVS9p5SXLg5+xQFLgRKjBtiULWNH3M8UeOTXc6l3W3QInZvkqHi5XRNkw3Fxm8oRqB1JmJ1/yksRo+nnPV+uxOFUJzWnZB7sAbdn5BuXMhVqObM9Ga4k/PrvxDBrOE99dHEIngnYvuOlFWKIahvBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391284; c=relaxed/simple;
	bh=SgjiSFVxnlRVKIIJzqHaBXZJFjFXmkquQB53qoebHPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muC+2knvt1ZhnOCIPsskTUG00iE7QZRkgg0BBJ/uL+u4Yu3mZbbAwYnhRRkV5LM/Q69shqU2pi+H9Ydln1OjL76Pn/7preicPZL0Qq8yOJyPTGsRA3xafwHCAWrRzruarCx92j/D+45UGidYzAKefeD+VqAP344pDgX1kj74BEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsP/MMTr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724e1742d0dso632460b3a.0;
        Thu, 05 Dec 2024 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733391282; x=1733996082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svw3hVWhjLUsKCnyMo5bW6Ng4sD85ogIrMfseX9wbyA=;
        b=gsP/MMTrj12JVHLsTZfPYK3umou5w/6L9oGZFjvWjP8g44MrGNRWa9gqhakCtQ/Rdj
         WXLyj4aDGM12cAWXwl967LARkPJGUrFtSZzUjlQb/Nz+/Q8c3x0rhDu2iM2XvSnc5UV+
         GJaKvDFLASYDLsH6HT1R9LQkgywD6CdHkA6b7PqK7Z5HOlkWdyK6vV6mL/5ctM4h0ir+
         xkMDQq6uTEL5PG5dXxMePbgdRO7duDBKa1oWyBUFIbtOzBSVL6U1dzXjmTDSckEITTae
         DLqr64xJI8627lxQUOKsXQiYJT0pQXv779oz8ZO0RldbKBlrsk3FCzGJApZpp7SQwm7O
         Vrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391282; x=1733996082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svw3hVWhjLUsKCnyMo5bW6Ng4sD85ogIrMfseX9wbyA=;
        b=oSEdTdvrdjsM0oZiesZOd3zpWXsyRBbvIj0+/xzYqN6HAQLPHXGdcknlg0LUbavd+a
         nmu8jR+AgPq6t256YQq0qpOm/Ovvk17OvrI6GYQZI45Uxt6jr8vAPUYg+tOOdHSy9193
         3JmJASH3pzYeUsm+U51cWjbkFKk6UpV4Kx3c19iwdKQJ4T9H6+hQzKaf2PimdWlJQqgi
         19+qSxW0yjhj/nO7W3d7ZWmsDCEXbUlYPFlw7qrIWk1HeVAzpYrhvGdAivdeMdAY1hgW
         Tvtl+4JO41QWzO+1biy+I0K82OthByfbjfm1THS521M/srGG/use6OwO2dWnK8Mx2b6S
         vdBg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0qaTZyISTWwOyysCOkY3CQdDPYPGHap9Bg4Ifsnbo684DiEH5ZUXi0L43Ir2Y76PBbeDL3IicEaWVbk=@vger.kernel.org, AJvYcCUqp1P2uPdjXu77BzxfNK9E3rPRoMP4FpmFhhyDLgxHkTLoz2jqd0mithRRrXj5zvKhUbIBrM2peU687LQ=@vger.kernel.org, AJvYcCWfA4//H8e4TnjSNc8+WG5mrqsC3N5jRLJzZoGU/rOY8TVr1aVZtBz3GiRxQkv1OS8bontScTNf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48HObuvc+CoRn0lt69y1CSdK82+kGSJoqOs49gRpEjFMjfSUo
	rW+p5sxQpUZxnURP7/GORQHoI6Gpui8fC2VbGA+Km3cyrJOhMIVYFCowBw==
X-Gm-Gg: ASbGncuZSRENXBAIMMMC/yI/8SvYtxq8aH9QgJmjyTF5P8zV1ahPq7CJ9MavNiqY8oU
	4fl8SvXsJceJGQrmE8+E1dCwxFmgOINtqpK0uVVxUgog7KWRiVNl/TAn7H1tAjmy8z1o2z1WWhk
	KtSG9oiJyWcCxKJvI3YiecEeqHXmDW/1KCUR4JyOsiOULJ1ueKXVEEBsnJiAuWTkRwCbhktGWQM
	Eh8XLx8ZDfNPNm2gJqhP4FN3uLeQxtQHNbx5+PPMq+SdCo=
X-Google-Smtp-Source: AGHT+IGGByayQpZUFnuuK54B4xfgnuxti4ZXFGpFEg18KahQT7dWybOnF+z1/CV1gszt9ZR4jHsBdg==
X-Received: by 2002:a17:902:ec8b:b0:215:19ae:77bf with SMTP id d9443c01a7336-215bd0d8999mr134561575ad.19.1733391281860;
        Thu, 05 Dec 2024 01:34:41 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f172sm8672215ad.69.2024.12.05.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:34:41 -0800 (PST)
Date: Thu, 5 Dec 2024 17:34:31 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Jakub
 Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <20241205173431.0000779e@gmail.com>
In-Reply-To: <Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>
References: <20241128144501.0000619b@gmail.com>
	<20241202163309.05603e96@kernel.org>
	<20241203100331.00007580@gmail.com>
	<20241202183425.4021d14c@kernel.org>
	<20241203111637.000023fe@gmail.com>
	<klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
	<df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
	<2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
	<Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
	<9719982a-d40c-4110-9233-def2e6cb4d74@nvidia.com>
	<Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Russell,

On Wed, 4 Dec 2024 17:45:43 +0000, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> So yes, "des" is being offset, which will upset the unmap operation.
> Please try the following patch, thanks:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b262cdad60b..c81ea8cdfe6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct stmmac_txq_stats *txq_stats;
>  	struct stmmac_tx_queue *tx_q;
>  	u32 pay_len, mss, queue;
> +	dma_addr_t tso_des, des;
>  	u8 proto_hdr_len, hdr;
> -	dma_addr_t des;
>  	bool set_ic;
>  	int i;
>  
> @@ -4289,14 +4289,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		/* If needed take extra descriptors to fill the remaining payload */
>  		tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
> +		tso_des = des;
>  	} else {
>  		stmmac_set_desc_addr(priv, first, des);
>  		tmp_pay_len = pay_len;
> -		des += proto_hdr_len;
> +		tso_des = des + proto_hdr_len;
>  		pay_len = 0;
>  	}
>  
> -	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
> +	stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags == 0), queue);
>  
>  	/* In case two or more DMA transmit descriptors are allocated for this
>  	 * non-paged SKB data, the DMA buffer address should be saved to
> 

Much appreciated for your comments and suggestions, I sent a new patch to fix
this issue. Please let me know if you have any new advice.
https://lore.kernel.org/netdev/20241205091830.3719609-1-0x1207@gmail.com/

Thanks,
Furong

