Return-Path: <netdev+bounces-142067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2619BD403
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA0D1C22193
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CD1E7669;
	Tue,  5 Nov 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lMeL0CqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436F1E5005
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829561; cv=none; b=d7+seF0nA5iK1v5mjF7gkiI2Sj2cxr6L9jVIjCNlDyPG3mlkHVz38lhc6ON2JgHs3+M+co/TtoHJAQzsS5Vwt4A/toa1D71IbVBkZ3xz6UPxoVmK7VtHwhWj19FqzM7rF/CKbQ3QdJcCGZvHGHDz5ttaktCrF+sP7znH4LOsQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829561; c=relaxed/simple;
	bh=S+8numXsXQGnPcPq6ASVi4gKIxwC00bW0jij7cTupQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l51LpsMurTVFhFaNTv8TKjG4ohXisiiqdziecVmwnaF7pOIwVmfF1G2xSArwsBoI0xOohcMxj+yC7wlZnTwGwIlg/C4aHLAstcS08rdy4Xc13yOziL4ll3t6EliBqWtle8QzB3Ep0crW3A37vWpRbjeKD7/hZHyK4MazNJotdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lMeL0CqJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e576dbc42so60537235ad.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829559; x=1731434359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pBfSYPuYzu1tAoSHC7ju6lyFC/Q3dp/PX6klCDQLow=;
        b=lMeL0CqJQiv06kdMohEEF5oi3Y2icHwONjvztKiPbC0lNk/0YnxP469QLuss/eM4om
         QJw4elmMYNgI1dv6bW9noO1KFQKLZ+FPxXI3zeyQy744RDunrpfwqnDwH++eQ9TkJTwv
         HEi+ccb++qg9Au4rHifFRJZzD5yCveu8RYu1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829559; x=1731434359;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pBfSYPuYzu1tAoSHC7ju6lyFC/Q3dp/PX6klCDQLow=;
        b=owg0fAcIGoM6kZ7gVM7RUxz+syr/G4ml+IOCh1E3wfLBGKKvmTI0M9GhehL9PwmUA4
         BL1fF5s+j1o8AhmWaNjGCA3OYdoidODdj0qlAhOOZJtG8mo+UB+WnVpvFYdxOeTsc/uI
         LGqw+S85GkfLIVEr8YxtIpHeMSV4JgPZBhiFpc9GfhOWhdf+9Eusxe7hCQE5RV+FrAx4
         uq/c/tAALQ+zlipbWM42QlE2Uk8UMR8OD3fiZWFtwyg0tx3QO+ycMV26rwGYQAf6bswy
         DaFYHfGpIRXntqxd5A8ZNZPiTV8bGyZF74Uj9egjAegqbCojXHMVH9rrK85Ma1bGud4i
         hbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjckcpPI6sSIUNgYiv0UEuKnaHbgtJRzY0QnbPTkUk7LM5+LNM3rLmlaC9wOsxO7s1Or7cQY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3L8M2PAgg96hHSvibfXNS+CI4ElxY9IztLO14BWb0l/WSPe28
	wSiQYVE2mb4+uHv3a3l7JGyEHnQXHoqQWjunPAl76lTvbEo/S0nb/lyvBwJsM9Q=
X-Google-Smtp-Source: AGHT+IF55QOBMBPoa8ymjcf6AgGd5oGamSktWrrKsps7tKsZ2PWKXucLEjj6h69bnJN/SUCcLPQleg==
X-Received: by 2002:a17:902:d4c8:b0:20c:d469:ba95 with SMTP id d9443c01a7336-21103ace2c4mr285604085ad.16.1730829559411;
        Tue, 05 Nov 2024 09:59:19 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe07a3sm12261036a91.39.2024.11.05.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:59:19 -0800 (PST)
Date: Tue, 5 Nov 2024 09:59:16 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 7/7] net: add debug check in
 skb_reset_mac_header()
Message-ID: <Zypc9KJCanZqZqqr@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-8-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:44:03PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->mac_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

