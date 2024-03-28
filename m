Return-Path: <netdev+bounces-83126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAF890EC6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38751F229F1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B33139594;
	Thu, 28 Mar 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLcwJp+S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836121CAA4
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670299; cv=none; b=tVJOsXCOT1htE6tAnNqNNSI1t72vlDPqtBGsd01JCXy27HG3LvkwKqk6H+a+6JBPS8kSi2M/dv9ze/lklKkq68hj/+OFYTME1GWnDn080udMHCVSV3kO2lQ34t/hrmn6gAq20n/hPPU+HcXue1sn3PUZxUHwX8NRsbY1D3InbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670299; c=relaxed/simple;
	bh=E5Buvg7JPOE0mKPcUaX9I57Zm+/sb44sJlK9NaBxZY4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=POxUNl37Nqo3cyqvcW0wkEA6nqESCXtV5d8EpcFnvs+gHSPNTY3B9JzXqpQwvSGzdb+RlclXZc3jRlalsCukuwDbmKOGSE7W5X6PadTIsR3zBPZkNCfcq7qWThRTNGHiqnrXTOqqqFv9KcEpOriGengNmwl3HlE8O7D2mEMY1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLcwJp+S; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6963cf14771so11094376d6.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711670297; x=1712275097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFPYVfdrRNsNDgRDEm0RI8fYHCr5e9m/1aH+Iyzako4=;
        b=KLcwJp+SSg0IW66TGXFdG0Sl2YWz+EC+xIswhdBvOwGS7k2YV0isAQBmvIEUM9nWj3
         Ph2LNuqXIYanb7WAG3bwm5Mx0MREZ7NSYyF2gRy2BEBCfU/ElGnpRy/DGfQT6Qmolw6X
         l2vSKKvX0KpnUNcj+cw3eKEjry6rRLTw6aVHftj32p46DvvUCkbikO93DCUbiRBemuFA
         kQExvoGvVcuSH3z0AKnimLdtEf1rnX+4SNUcnY4QxStFZ7TVxQWpzaHyXwH9uzklfaha
         1c+rVUG0KYqteYI/JZgE39tWJFvNFM+BNOCiZT1yMqpl1Xt2CrTm16xQUKj0XXwmuaiI
         JToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670297; x=1712275097;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFPYVfdrRNsNDgRDEm0RI8fYHCr5e9m/1aH+Iyzako4=;
        b=UEfDZYxwozZltf1Jw71QUHFaHV9AUZoFt0ikdyxaYlx+FEpB7hgskY/zeNXbEdq7pv
         E4j0ysYs9UqQNcpGqb3I/knJMSps+WIrN5py5I9RjDvW/R1KwEp+lHeTmSYgDrxeEmgr
         C2GwCj89yOE8Q/jXtZThqOgSIwg0OVd4xIw3CO/aG+L9kpGnPccgTQampmso70ISLy5a
         oYrGRrXRMWsraTWeefZB7HypmodZmn5KyigBLjxIaA62kL30LeBNMMT9O9Hrhn0wFAxj
         JNVI1ygZ3mA82TD1k+rm5MPcvMPASTtR5YCxqoImgU/4iI5RCw8FIijW1BPUDpFb4Opg
         ZLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTusb1BjnXqXSxuGMPL24iqkPaxCbdZB1PWFs3VJjivzCoddk/IdaAYxR5age3ggBZXIAhspNRprLim9g7WA3GqMXFzoEN
X-Gm-Message-State: AOJu0Yz+2RtyPdyGG4nEK1IJeQZ3nitlYaZxND4wqJ+DeJ56mf0nz16W
	t6Gph0TXygLw4DBP4X45lH8lfHpolMCL5iyg2VXVuYnKgeyvdPC2hTaqWmSC
X-Google-Smtp-Source: AGHT+IHLnrghUAj9QbjbXNfp8o1DhCXaxl9ESnPWs1ZbdauJ++YKjXhXXxdYToRkzInt6Mbn36IXGg==
X-Received: by 2002:a0c:b68a:0:b0:696:32d5:98d3 with SMTP id u10-20020a0cb68a000000b0069632d598d3mr827338qvd.36.1711670297573;
        Thu, 28 Mar 2024 16:58:17 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id of9-20020a056214434900b00698eda08f4bsm262029qvb.31.2024.03.28.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:58:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:58:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66060418e8488_2c310729489@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240328144032.1864988-4-edumazet@google.com>
References: <20240328144032.1864988-1-edumazet@google.com>
 <20240328144032.1864988-4-edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] udp: avoid calling sock_def_readable() if
 possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> sock_def_readable() is quite expensive (particularly
> when ep_poll_callback() is in the picture).
> 
> We must call sk->sk_data_ready() when :
> 
> - receive queue was empty, or
> - SO_PEEK_OFF is enabled on the socket, or
> - sk->sk_data_ready is not sock_def_readable.
> 
> We still need to call sk_wake_async().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

