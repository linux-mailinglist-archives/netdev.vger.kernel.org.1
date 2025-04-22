Return-Path: <netdev+bounces-184762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D5A971A0
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C0400E89
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634928FFC0;
	Tue, 22 Apr 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt+6t44+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5528EA7A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337038; cv=none; b=mmpD5dbQsNu6FupKqduKnoiCcnoiZzMekMGh5ilDsJj4VZi6IBZygC69wjxnv9nriNQ9dvXcLUCyn9FNlJnxKNFJqzfL0NxMHIKcEDiadibvXCTPNGWAsA5UQUykzsPaiqlr5SE5ydl6QpiIGgkz7V7wIhYuRBquWyTB5nef0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337038; c=relaxed/simple;
	bh=b9Sc20nAJojQ+ITw9oWzmbvR3TnwSI9r8jbvfUvvH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRVZTTQDhx2PNiNk9NqhJkAix3DM5dejIa9JM6d0ALj/81fMnytZgqaqklAO+rl1ExTs+UbJ16SoWD+svdRh2ktM2liA3RKCta7aOJVSf8yh0oGH1VoBTcKLMK2At5OrCKXFsf4iGx8WKd4JPg/bsArgaCkG+LnvkhPc+8td6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt+6t44+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225477548e1so53656055ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337036; x=1745941836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSDxqEHK7azXbgy5Y04gKH79BoT6pDB8N3BuaMsroj8=;
        b=Rt+6t44+cYE9XiRWTNYSu7gKMZNWwAnFg/dJSXbSJ+gkVpG4sbmgd3+zg6jpGVALnj
         jMJXGq6Jvk/OZjL12UFS8CbE+9i3x0Gpjj2imGU+AMGLLPzOm0rSgC/Ml22Z+U9X1vps
         Tcw0+SsQzBA0vx7F2bcdx0Ul+dG/M9KlBL32suy1vSOHe9/dOtBFVCGPfGujINciYYD/
         Qd6bWbCloISgUmr0YtYAM7iObC5B9saD8yU1bixMIaMwR+rroolL5ogCHXoVKQTOLlXp
         Cnz5QMdmLm2KeqGlONEG9TWdGQC93WI8AEFfyzhfYDlnmuCqOyfCNjzyV/QuAcI1llwu
         sAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337036; x=1745941836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSDxqEHK7azXbgy5Y04gKH79BoT6pDB8N3BuaMsroj8=;
        b=LMUAM/qm1V1EbS/1oxOXbC875xoFjLBlu3wZ8/yVZrGNMbql0HwyyEZAa+XMcG5cHS
         eFz/owyfcNLNz4FK/x8lzqIYjolg+P4qMOv6lhEJCTkjPqhj2FeDh6MhphW75k77UTiA
         t3CRzErCFzlhNG/XCORuyChwyg8y6+AI0qrVaPuPcVXMNNgZl/G1+6G9kEW+XoC38UT3
         X5mG0oWmcmVa4DmLL6SNW0ADpyzXhKzgHAE/c2xKwkMhqVkzuI/psiP+Xa/7y3kDGDsg
         ESLYsGmeXJU8PAuRCDY+wslY6+PlHYWseUAjx5DmhgymByRNFOTnck0jqzGShcM7ZOP2
         8qqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxjZpnLgVldn958V3jOwMcnSt+/hjgtFBXVDeBbRbkuMjCUZYKMiXf6hu1iqB5B5Tlxz+nw0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDFd/kD7VK/r/1V/IoDyNeVVrCPXOIKQ5vcaZEEuPG1/bD+LZ
	REecwZ2fWY4wMFFOPtZfHVDRoHDsm81bGpjResd7bjT+39/2nmolYq3R
X-Gm-Gg: ASbGncvqs0YDpmEXiNDg/RUsMlU9JWFKs9xCSoD/+u4umc8eqdpkWr+UbgBeW3LPzOy
	eOf+pbXsgd7/OwVtioGYJNRBTA3Vfm8xDiOTgPhgNtSC82YCOkbRzJvTY9mzQ+IXGIx0XtVV0lL
	+DnW9FUAhvqvAh1Rb+TPA2FSZIIlCRzzqzVrVWvWU3/RAvLoNOjdhBWEidP1/lwRVA62DTmEo+F
	N7JxDtuYoH/dLX/LtZGknYWUVnFFq084t3DUivd/sKv9diEHl+K2+oxijCWn03BviiUjQUzWCYA
	6JoJB8jneXTbxWPkxlLSkvTwIuog2P7X+6P0OMJ1
X-Google-Smtp-Source: AGHT+IGEga9SQHydp753REPG/BYhbD6U/eyeVM8rDQ9wKgrgFXdYzI05tenjn8fFZlcu0Zi3q5mWPg==
X-Received: by 2002:a17:903:2410:b0:224:3c9:19ae with SMTP id d9443c01a7336-22c53601521mr268031235ad.34.1745337036545;
        Tue, 22 Apr 2025 08:50:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bdda5csm86502305ad.44.2025.04.22.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:50:36 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:50:35 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 14/22] eth: bnxt: always set the queue mgmt ops
Message-ID: <aAe6y6ZSQsdk5eHF@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-15-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-15-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> Core provides a centralized callback for validating per-queue settings
> but the callback is part of the queue management ops. Having the ops
> conditionally set complicates the parts of the driver which could
> otherwise lean on the core to feel it the correct settings.
> 
> Always set the queue ops, but provide no restart-related callbacks if
> queue ops are not supported by the device. This should maintain current
> behavior, the check in netdev_rx_queue_restart() looks both at op struct
> and individual ops.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 627132ce10df..49d66f4a5ad0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16039,6 +16039,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>  	.ndo_queue_stop		= bnxt_queue_stop,
>  };
>  
> +static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
> +};
> +
>  static void bnxt_remove_one(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> @@ -16694,7 +16697,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
>  	if (BNXT_SUPPORTS_QUEUE_API(bp))
>  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> -	dev->request_ops_lock = true;
> +	else
> +		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
>  
>  	rc = register_netdev(dev);
>  	if (rc)
> -- 
> 2.49.0
> 

nit: maybe reflow as follows?

dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
if (BNXT_SUPPORTS_QUEUE_API(bp))
	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;

