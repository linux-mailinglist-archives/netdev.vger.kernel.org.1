Return-Path: <netdev+bounces-119099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25433954033
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5498286AD4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698428399;
	Fri, 16 Aug 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DobGmZS1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB876EEA
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780925; cv=none; b=cAT0A5NwW5XU0JMXZ5dvotrkdQbZZQRlCMRJSHVcS0+zCooaZlXKDn4CzphKtTplazYrgiIeE7viKTX8BxSI0Yn0hGbRJjAyTUlU9UQRRmi5PxAqm6dQK+AiJAqCDWgJTqRcaU4GT0pkPfoBcGtVNTX0ibFkElBuSAet3T5XjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780925; c=relaxed/simple;
	bh=cVP29wLr8Uv66h1eHeNikTIQqRUAjuXHsuU9fuHNycM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5vSjmdyKwP0jl/Hl9+WpnxuCcX1PJ9DDwbynqvJtlqNn6BgGxp0qsoSYJdDq40KoWMMmQ8eHAXNbSXHcVixY3OMS+EmQK6TKtM1Xr2K/XoCDnquer31/qc//m7t5M6oEN8bbTf+Kim+nFPM5tcj53tiByz01+N+UoVP3E4ZjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DobGmZS1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so1349519b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780921; x=1724385721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqzulmR+XzvKWmSVmom75Dk/AaWxIRRLe1Gubu2I+ns=;
        b=DobGmZS1ga6EbS7nXbzHmvfh6tXcFBqzb6sRZxMS8r72n6MejlWbg1MF8bzHVf+OFZ
         GQCnHyKWsEJUOM2mHUX8dm/+JDe6XKEuGiD527dLB1V8eh3f8zMY5WefDKCn1XHR/Iag
         0YllFksk3ueQqOUMMZY+remetbNYjKZT6x3GtIVHu5FyST1uJlITUhUMkDA6ISAZMll5
         E6xsCQ6UAzmQJgdF9iiBJJqUpCMtOdEWAnoEL5GBwPel6WdAy3EvbqJxhFLl8ASs+fQb
         XKZVm18hUk7GIMFWmDbsvUsXmLTA3g+KE8lqOlWI7DNaPZsiny/tosGKhjvtkwqnPciT
         RONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780921; x=1724385721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqzulmR+XzvKWmSVmom75Dk/AaWxIRRLe1Gubu2I+ns=;
        b=NLeq4eRGvyK7HA0zbCl+tOUeE8CwWZap9SFO+DnC2ZgYDrpQkm+7AHqChkUUyOrDYj
         PlpxMwPL+ci0xuQsPtkxPsLDI+ejvaz+VhPMLyA080uD6dSmntXwB+GJNrrUP7xVWYNH
         jB2dMjeb5Ur+BlylKzePpnjtOG1DjMxD4Ngmh2Mz/DwwA9Jz5f6zsnuQc4Draa+75zXd
         QU+fXrI62sDcVZSSMUoZogZRjRvo6FF8XvbVmW/YQ18fGOxih18C6Ibj9pU09wTtq/op
         2Jp84vJJG/AcntPm/kW6tUtT396h1ObTtBCtmpIbEuivSYhhMnp9WcfMzKNv9n5ms8DK
         ObVA==
X-Gm-Message-State: AOJu0YwhjE4puW5WKsEO1XubEmneJNsD+QnQQJ1sIOx9YXRKQDiFvXvk
	OZjtZx7TdsyBRjtGDIMmVv0frNKlllNj0/fZP9Mx8CwMNeW2K+WAUA/TTqlkCTA=
X-Google-Smtp-Source: AGHT+IHwNb5dPL4kU38iS0Qe2zx+8ypKPF2WSuBvAoMP0UN7dhhhyJg46LG2Kg94CLP67AHJQ2iewA==
X-Received: by 2002:a05:6a21:e8c:b0:1c4:8294:3963 with SMTP id adf61e73a8af0-1c904fb496emr1678999637.24.1723780921059;
        Thu, 15 Aug 2024 21:02:01 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3d7971facsm1383435a91.39.2024.08.15.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 21:02:00 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:01:54 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
Message-ID: <Zr7PMpsV5jmIeLze@Laptop-X1>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816035518.203704-1-liuhangbin@gmail.com>

On Fri, Aug 16, 2024 at 11:55:16AM +0800, Hangbin Liu wrote:
> I planned to add the new XFRM state offload functions after Jianbo's
> patchset [1], but it seems that may take some time. Therefore, I am
> posting these two patches to net-next now, as our users are waiting for
> this functionality. If Jianbo's patch is applied first, I can update these
> patches accordingly.
> 
> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com

Forgot to say, The xdo_dev_state_free will be added by Jianbo's patchset.
I will add the bonding xfrm policy offload in future.

Thanks
Hangbin

