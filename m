Return-Path: <netdev+bounces-142061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F09BD3D3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A402128402B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20F1E379F;
	Tue,  5 Nov 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W2/qN7g6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1431E2825
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829405; cv=none; b=YeRkgl1Ko1Nvk3ESfSRH8lmbQmwKUdWw/GZJL9x7IMzl/agKg8H3J0STA4jRm+A3CcfNJiNmSPfwgRCiEraOJlw9dM6WnFXhDHHtdnGmCla0p4tbGsEefrKwFPIOTwJUxMKsZIn9by0i7C2d6B+j9Sw+EZXtA5pxvn9hAY2wFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829405; c=relaxed/simple;
	bh=Oa9tnIYWssyEdwuMlnC5Ke+PlWtJGHt4IbkL8kzjRk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qne5a0FC0kNldS5uYbOYTjAW+z0IJimEYzMf55QppQTeSgHZAGaYdTC4iOXHsVHh9u0nFO7gujm9jylrJ2jWHD4X3w6k6JLBd5nGXLesWTgV5qOoPArHEdO7RcghXdKHCuMA3ZMR2wHRJuUAOKLjBGSqKLhsekX9ZkMi3y49ioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W2/qN7g6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21145812538so23821735ad.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829403; x=1731434203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETUNT2Ev7Ext300aQTHJZgq9AoiQ/RSgD721qKDy8Y=;
        b=W2/qN7g62t6IbKU4no+njAFvMkU11iKoLZggmvs6D2wrwKK4IC7Gt6QwXZtkN/Dh/i
         4qSp0nkz7GFE6/tHp7Xm4h+mTxRfrtDYGOkziwyntwm5UFWP+seMwYYikJh9souNZ9w3
         PVNhne5WkPDpBw5goQ0KWzJnwg456428AUoD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829403; x=1731434203;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OETUNT2Ev7Ext300aQTHJZgq9AoiQ/RSgD721qKDy8Y=;
        b=QSqJdElO3g3T2D0fH425vQn329H4nmvQyMowGcF7edBu+bFU1bz7NMh3Sq8JBdH/8N
         k7e3HbPhofId4+RhOFZIj21Kz2o1Pltb97wCbU9R7Dim343ssLtcRa5YO0P0fV5awItZ
         mJNvrz2uHNcNUXnKO7UzbThtuVtdfVe45Sa/j33Jhlj88lp9hMMftStwV4xrFKlcjNue
         Rpdz1m5wc9vSt326G5GwODYNnRoYsahm6bZBiMBH5EFMw6lASQj/lU+Z5/7t1xM9YIUe
         Q70s23o7YHgyPEVq5eCYBBftI0va+dFp544eJxdAQDihp1DWVsfTUqiMR2iJERvctVmI
         Zi+w==
X-Forwarded-Encrypted: i=1; AJvYcCXNiPrXjA5dqH1HQrDa/tm2klhR+kkUCa7hT6CVfYLga11KmaEiKOhrg6K1CVZTAhpsJZawLvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoytQRM5YGJfWf745/wbW6YJfa1qYrHubs05SE246fC5oAb50H
	4dvW3LCifkWA/PUS22dgC5SP/brmDjhI9PxC6FhumNhX7QHI36uiwfhSqr/ntKQ=
X-Google-Smtp-Source: AGHT+IF3R9+6PWr+yGon2KtO69u2KS8KM4WCVRBGXALCGc1PKzhgfMwF66K98FIkJvTnd+5rmkkW3Q==
X-Received: by 2002:a17:902:da91:b0:20c:82ea:41bd with SMTP id d9443c01a7336-210c68d4349mr492025315ad.18.1730829403202;
        Tue, 05 Nov 2024 09:56:43 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a5fe6sm80770115ad.149.2024.11.05.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:56:42 -0800 (PST)
Date: Tue, 5 Nov 2024 09:56:40 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	En-Wei Wu <en-wei.wu@canonical.com>
Subject: Re: [PATCH net-next 1/7] net: skb_reset_mac_len() must check if
 mac_header was set
Message-ID: <ZypcWB421XqVaiYS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	En-Wei Wu <en-wei.wu@canonical.com>
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-2-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:43:57PM +0000, Eric Dumazet wrote:
> Recent discussions show that skb_reset_mac_len() should be more careful.
> 
> We expect the MAC header being set.
> 
> If not, clear skb->mac_len and fire a warning for CONFIG_DEBUG_NET=y builds.
> 
> If after investigations we find that not having a MAC header was okay,
> we can remove the warning.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iJZGH+yEfJxfPWa3Hm7jxb-aeY2Up4HufmLMnVuQXt38A@mail.gmail.com/T/
> Cc: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  include/linux/skbuff.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

