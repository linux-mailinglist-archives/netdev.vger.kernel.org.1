Return-Path: <netdev+bounces-158291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D24A1154B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB49F7A03D0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F3520F077;
	Tue, 14 Jan 2025 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tPSakXLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF632139D2
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896908; cv=none; b=fIp+puf6qa/yVInHkVoUPNRfaes8Ukq1IQf/2vVxpMZsk0V36qmP6NC7QBJidv7ckq1SkCo61kcx3kqT4yAG8HIDisK+umBM6QssxJrs7rZes1uFVKlVnKX1d+5+ilXwQNoHMwJAHXX4bLzAS42RsAUsHBi6LCtmJ0OrT37P9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896908; c=relaxed/simple;
	bh=KSMU0048Jato6EYTvFfNLt5H1CxXxde/KVx+PYecF6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQWiN7RvUBripPc2zrox0oYv3xdOQ8Y5beDvwyhyMBeiq5VRG4Jb4dIoFkZczSLIDTKSQHVtiIl51PAdRdhGYV8LPRo+QFUO+qJbFbYEdBgLnqz3vOFFJC0t6eyELosEnoJ/3K2s4kn9mBXwlyIw2Bjvf1Wn5f+wtz9oUM24QCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tPSakXLM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166022c5caso95448565ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736896906; x=1737501706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e36btZ9Xw1SUuHdZwbUJNlbvNzgZNcgY07Om5Uqev34=;
        b=tPSakXLMDyMLlBJQTeE+NlMTIHZnpp9Qz+fbd8QZzZbVrXO5D0bQq5spKk69GhRUau
         ZowzqAFaeZkK+FS+NVXjhegXBrS669biNQjDYOptFtJTehIVhTAe0DS5Hqcnqh15pAol
         lbLD2l7I4N/ZHE9K73HLwRW1qCeiIw2OnK6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896906; x=1737501706;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e36btZ9Xw1SUuHdZwbUJNlbvNzgZNcgY07Om5Uqev34=;
        b=APdwBD3Ya+ZdpUpekwjIGD54NdCGdHMCKxjZ43P8T7VtSVCoKKZ4fyV6rryALeD2CT
         X4HfHUa6SNQ26wcKBIlDR7OFEo1SbJ4P/8DliOf3NpwF9Xt0bFgjApJmykoOGGMYf3ge
         vwenzVb814fNgU660OGZ8tobBNpd+Vv7GsWeF/wk+2F7XT30Omkv2kWGuXiYHViTfBkO
         mH6xTPYxHjr9RtodImr2YZIhsSJ56+mcXRJnA8Q7cCcB5iYFnVg/WCmXqopvafbc5Qkl
         nrTlm1QnYPQzrUVtlqHBgapA/bTIqtDhf+D1r9SIi5wpK0Otsb6v9jW85oi8fzgQqPn6
         fzMg==
X-Forwarded-Encrypted: i=1; AJvYcCW8BecnA2p6MuzZd1g/otfUCWLMYhj/4Tozpa1n0v1aKv2X4A30yIDo61OqoKTt2Ukp/9Iypho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZqsA7CO7oG/3mBzyofFzfa5sl3zDileErQM/3PZ3N3SlVdiz
	qRrN8jcA+3+W1PESglYYWc5aoUB4547RZKuILnI9Y5EXvtkI2owSgplQaBOkCzRcftWNzPJgDeC
	k
X-Gm-Gg: ASbGnct1fOi9B6xpyYyviRVTj48bp0eE8uk7YZQLB0drq8x5f4ml6H7PzKfPA/XPw7s
	QwNkBIcutbGlcWuX2jZ5IK3amjiNlcMI90qt6LhCtPN+7C4YNal15wOsusGgPjUZHKBbLzXCAlS
	NXoogfbqdj6Ivs2pAatLjKhsTspRJVewPw2DWlrWfXxEkmKqv4PmHk14herusLKHFMtgOfTm2S4
	Kots/zt+S/B2IB3AtsOBLP2YYI+dqbavdHZ/YSGiuqOt8myhTl4GFSxcPdA9pUSGOxItIu/4gAp
	5DCoVIywaODNlVcChYcbMNg=
X-Google-Smtp-Source: AGHT+IGF1zmf4pJ248Krdj9SFKcs7iCBtdnp5I3ij6GtBSsw9HW6mn4K9PCq9FtzkqnvDSZ8MIHKgg==
X-Received: by 2002:a17:903:41d2:b0:215:b75f:a1cb with SMTP id d9443c01a7336-21a83f43b1dmr379193555ad.9.1736896905788;
        Tue, 14 Jan 2025 15:21:45 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12ea8dsm72267415ad.63.2025.01.14.15.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:21:45 -0800 (PST)
Date: Tue, 14 Jan 2025 15:21:43 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 11/11] netdev-genl: remove rtnl_lock protection
 from NAPI ops
Message-ID: <Z4bxh-ZPEsw3Cr2l@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-12-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-12-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:17PM -0800, Jakub Kicinski wrote:
> NAPI lifetime, visibility and config are all fully under
> netdev_lock protection now.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 10 ----------
>  1 file changed, 10 deletions(-)

Very cool work. Thanks!

Reviewed-by: Joe Damato <jdamato@fastly.com>

