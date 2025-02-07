Return-Path: <netdev+bounces-164159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4FA2CC97
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536783AAE16
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2481A314C;
	Fri,  7 Feb 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Cwtw9/D+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F018DB0E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956551; cv=none; b=nAOE/Xxq4iXsQgSvbs+tKT+1TJQWJciWoCBHNK66d+jthXd1M0ktvInAUCaa0ylYuCuX899R1QXVUM55WSwutl6GiE1mg40Qeug1g3cqlGxk4mrin2ynI6EU9PSiXvyiW3kvk/83ykm+Z+3x66c1+eZuJ1677LzzNGPhKBuyyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956551; c=relaxed/simple;
	bh=jGP5mFG9d1VkQT0Qx6S6OeAgqKqg5Do51TXFE7eo7e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZWpFnALngq6b034+DdCOiSP+kkSpqTa0T4dpkL6D2wiZkox5b26mlrPziXlp9QV6RKHyq+nd2b/GHicqej+WEoRnV/p29T/HIQi/Mj+++pjvZAgUC/Fk+I+eee+BbeupZCldISbTzrz5OR4JbyvvO2BvK5PQANBeNXJddZNkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Cwtw9/D+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f2cfd821eso45547325ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738956549; x=1739561349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1AbH5V70bHGz7mIe4cxxe7yGnWNMvz7BnJGz16vITI=;
        b=Cwtw9/D+w/rnBQal57ecAK9q2aYbRDWLtVvwHNrMbC0VaxL0+/iO4khqIOhbyiYji2
         Nxj57vrTZHGXLfDwxHwusa7aw+cL80soL/sgGqQd9sXqt/8ZFRU/KOs7mvTcheHGtOdf
         CNK+C7sQAhd9BirQFlFdfPQzconAshtH0oxW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956549; x=1739561349;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1AbH5V70bHGz7mIe4cxxe7yGnWNMvz7BnJGz16vITI=;
        b=SKVNlZZShIwHMl8hniao8JnYxVpHKlte+VSFoF9/FaTKS8nDCapITKukoe2pNtOVp9
         HzMdVlgbXzXhSkFxw2moC4QNPCK6BCnCSzhl+f2bRG0KFb270XOXh0XeDhYnU07PxF9G
         dmPLwiNWc8inIV08gX8c6BYQUAz/AgLA/CJt6qb/H6Q7qfcKSQv17/vft2S65Mhwi11w
         o51vsmag0nVxtPc0y8sIpcfUZgTIqxXhmNoLv3qKyKyCLVtHHQIhfgYJEQchrtd4a1s+
         hDH0XH+y+HdAPnGz+D7QQ0HiSYhN70l8l6Wj17fO93yXQytfRkoYE18FoBb0m17+bOfv
         hYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2dZW5O1PMFzzhfgtYo8fQRytdGfL37iNGKyx4pPIYtWL+vplAwLoURtRhrtWBBPjqEdDrNz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//LYRQOodZO2eiaTIaAziH5HbUB/rSqat6wAoJG6qIaiivfKL
	3HJ8/to9b+5JqnvnhdUZoF12CBWyzWonjWTjZASKddQC2nyhMIuYVE+/JlLQDXA=
X-Gm-Gg: ASbGncvdEfjFL0s3cJA4tAJo5SY8zTBSmYIuPf627I1AvzmG2TlvmU1Ez3Y5dVZ2P+r
	vSgXS55iJ7F1iJccmBOrM3EWxWwyJbKs2oh98g7t4kW20cxfIXvDHD4zeljZiiR6b4zGDR800E+
	RAb68PgPKIvIHlnZQnJ+3xFw1/+hAbZNA0dWYoT8nvSap4P76cmjhw5gIE/KnsR3I/eIhXuZAYq
	5lWfZtH5eHeMIJLZ2Dk2bL5RDuetnYIcAK07Wt0dVHkYXhJa6FaJb5hZN/pm+TPoLpGeShTbbqS
	v0biorDihtvBIaI1M8Cd5SoC/I0ssdSFISUjOlq6DpMkSwbieeA61nWfww==
X-Google-Smtp-Source: AGHT+IGZNI13IW2GQmLhADOPb0VmGp1wsNJ3tV7vuohGReKlzYi1jCgh6LE/YHnSXl139yGF0c4pxw==
X-Received: by 2002:a05:6a21:3305:b0:1ed:753a:cfbc with SMTP id adf61e73a8af0-1ee03b4187dmr8541363637.27.1738956549412;
        Fri, 07 Feb 2025 11:29:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16292sm3505288b3a.149.2025.02.07.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:29:09 -0800 (PST)
Date: Fri, 7 Feb 2025 11:29:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] selftests: net-drv: test adding flow rule
 to invalid RSS context
Message-ID: <Z6ZfAr3RIyqGOrrP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206235334.1425329-3-kuba@kernel.org>

On Thu, Feb 06, 2025 at 03:53:29PM -0800, Jakub Kicinski wrote:
> Check that adding Rx flow steering rules pointing to an RSS
> context which does not exist is prevented.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

