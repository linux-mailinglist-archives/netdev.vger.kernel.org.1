Return-Path: <netdev+bounces-72124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6053C856A01
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B3284CB7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439913666F;
	Thu, 15 Feb 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbqIAF96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552213665E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015952; cv=none; b=cZvpO6016Az4fZtBmn5kmslU/oom1IrLvGP5T5QU1yqJptM/Se/ufQzwx56R2oBoqMVbTFYrSYNJZ5i15NhA6k0xbc+EBnclHGEwhML1jtdP14zm55XfokZz9qlCy6TAAwKAsGUa43E2v2CYF6ksXKIwuZrSE3PiM0N0ufkUrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015952; c=relaxed/simple;
	bh=NLK7NjArN3ZvCJtdaYIKgWL+29pKUXW2zpoNvi9AN9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYHvvz/HyVK+tPVXGFUdXqupUqSoDSEAEUPIjvBW7FZlNeF7ablW2q4evoc2mEKuEhFRhco38UvtyocrBEs0fKlNT+RvFywJN4bxYcRGjZARI0g/FLhQAFqj2zKoFuLRS4D1WPBBoqMzOqjnJrFPQ0bAQY1yVhxRfOIzKVSFUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VbqIAF96; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3db0b8b313so57798066b.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708015949; x=1708620749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDZ8qB5BWwBXJ6yx7sr6Txj2nZN3+5M0e1F2LI9Ho4g=;
        b=VbqIAF96lqCB1wFKwTiNUjPpQfEqG0yburQBQFdf2tdzYp93AuRcZrCY3GAt/Hywpi
         Wzo+sqoaIxIwSFRpJks2+232pFCVXJJt5ygAXc8sTLNDlGD7IjcwPOaB7gtULAJ8GRtG
         1Oa9op0qaAE+kSibZrtFnF3D/Tl+xQLtIBToAzhubIdT5hbpqAMQTXcYrT4kxg2b6JDY
         B8Wi5MUzRtLKuom0r5C/jCvxF3zZemSDCrK2aXA9JxGMWLQ36ml2OC09wTEZFew7cx7Z
         GUq7DK7ixg72xYW2NmeflLMZ1w5kEj9ygDlrrYEeQk33nO/75YaUQ+Rnfsv6APepL0/I
         fMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015949; x=1708620749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDZ8qB5BWwBXJ6yx7sr6Txj2nZN3+5M0e1F2LI9Ho4g=;
        b=xBKTCnKizNjKkD6lWEtUrXBKtqBtdq+VDRG5kexl1JVDbNjlSxq2zcjnz3rlAJc0JN
         5RVi6lnUeT2nxkz9R5htOECMFgPlkYkYajMFlKFD0TkJLtLs6eOCR30r+beZRLjUrRga
         Hhdhv4VydxntwE8O7PekmMNvu4B1RcyzfqymGl0JDZlKBB0s9OMYooyr6XiLul860nQT
         Hx3mFWQm9YasvjkMnTWCw/o3WwHo3IdKBb58p719o/4n/1nVqqfCT2uCGsELuKtW5Pqk
         qaB5cA/14HRs9htg1dtvH8ZmQQkXREVFtOxbqQtspqItV71qdeFz8r2yTflrC/iW4Jd6
         lK7g==
X-Forwarded-Encrypted: i=1; AJvYcCWaHvcPt0dzxG+WEm0wkKfEIyna6FOaJuWmpXkZoJqjQ7oCn5i7kjio8zMGu6zbJLgTzGN09ynnYBmkk4Fa6Icp6FN52Qzu
X-Gm-Message-State: AOJu0YwsTBZy0f+qyQvIOMm3fvb24BaE/qnZRjR4ts4xkl+gJuD1VLcl
	SeFjeYHXNh1+dEkyJYl5dRsOAckEMPAwSTAsZ1yJ/uelnMcMyHRtFcZdUswnrzA=
X-Google-Smtp-Source: AGHT+IFyoufoz8RHceaQKL1qsabL9C7M3ugX6XL4wgs0M8mtd5lnbnhRwgAqOIwaMgYvJrydVEbNEg==
X-Received: by 2002:a17:906:455a:b0:a3d:180d:a9fc with SMTP id s26-20020a170906455a00b00a3d180da9fcmr1852959ejq.1.1708015949004;
        Thu, 15 Feb 2024 08:52:29 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ti1-20020a170907c20100b00a3d90d6fca8sm710807ejc.8.2024.02.15.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:52:28 -0800 (PST)
Date: Thu, 15 Feb 2024 19:52:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@lunn.ch, jan.kiszka@siemens.com, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Remove duplicate
 cleanup calls in emac_ndo_stop()
Message-ID: <f9bd0e83-f3bd-4804-81ff-89923b42693b@moroto.mountain>
References: <20240215152203.431268-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215152203.431268-1-diogo.ivo@siemens.com>

On Thu, Feb 15, 2024 at 03:22:01PM +0000, Diogo Ivo wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes in v2:
>  - Removed Fixes: tags
>  - Added Reviewed-by's

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


