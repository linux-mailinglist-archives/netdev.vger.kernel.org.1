Return-Path: <netdev+bounces-186495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52633A9F700
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63107AF6D0
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA627991F;
	Mon, 28 Apr 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CwdnQtKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECC13CA97
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860399; cv=none; b=JZqk1ZTGhHP27h0BNZtX2Z+f0ELIw/Ing6mD2j/Ifk+4W61aIQ+mtsaDmCCGBadS/KmL76tK1Kk46nKOER1RihG5dLs6bsLRFDMBYXy5Qa0GDWvJljYlDf3SP0Wz+BH3MuWJ/uo+A57oX59Vob6qTx7Qk3mlgwHQkCoWJY4zgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860399; c=relaxed/simple;
	bh=xMDw6bhDJ0zO0HFzO2zeNsonoYDZlqaKEV9dmxjoN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDI9BntMLBLHA8iJNZ6OoL9GL4ULY77uiTvv/eSyssG/wNzOG4TrPfNAm12C8yWjUYBdo2ZBNm8xLH9sAlIvvYY4OdWYm94tZz9dAzKce//FPFLaWKOgY2RE9qOl+vY9phDfmyObbi2cz5zUuMITxCqlH29wbBg4xu03yHJK/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CwdnQtKM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33e5013aso61278605ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745860397; x=1746465197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0XQmg0+a9XmV8yQwch1S0y8y756xyoarbxwBOLVnXw=;
        b=CwdnQtKMKDv04xn/wF0OkX/3wOdctFelEU18ShvmT+2ftctEILYYn9A/QE3GSoP7Zb
         oc3VxXr0FhyZovAIZpjOe68kXORABI736ZY8HlyYMBY0o8/Nc1mWAq/oNOPdQnVJM78i
         Vy26UK0oya7n5PM1aFZjCp1ihg/K75q2U6P3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860397; x=1746465197;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0XQmg0+a9XmV8yQwch1S0y8y756xyoarbxwBOLVnXw=;
        b=PFonQYS8SC2KJvk2EBHXo/gczHpjLp0aBlzG+uQ1tiQlNumXlZcf58Z2UVdlc3jRJv
         DJyMbUUfYszRc3SXHDX4o+9OYb2D3hEMIM7ShSwYfE5LD2Nk6GRMVLTe/BC/dNZzY/x6
         vnFqaa2LDXAD+kR43Q52oxcWG79TgqmjsXhjC7Ny+JZxEZjBcHCQQykuPjYO8I3NaFSa
         weFB+93ygvyUNdi07QwgS19xZstuEnoNLS8n7TWQj8BqIH4pb8MtjTlULiiJUi+54Ahs
         t/dL77TmIUgwIfZQOGk0799DBoKHqoQwlEBVVBFZ25qNtFpSuMzaW36XKgWDFJ5idMpJ
         Rvqg==
X-Gm-Message-State: AOJu0YwMLgIzGGEbCv5HQjl907TnfqnA0u5/v/5iavMc3tS+0eEhBpSr
	Li4UwGHv0x22lN5XVo0cP3v1EqAuMlGTeiUhlOZjPB/5jrCUM9KsICpSRUIC89w=
X-Gm-Gg: ASbGncudZwXMt1STOjdInGk3Zv0t5Zn5DdN0PtYu92CkYN5gRHaqiqLSFg4nAQF7iU2
	P/r12rG09207J+9uxoyvusKqpE04B8KV6vot8SD11/iX3oCwGdpyDLxwAmcjdbqyyIwNndlyDeg
	7AbCPHqq6ytZaf8dzIC8JIrcNJLi/4QccWW/z/knqV60/EDBahF9Jub+fEowQomY/iLNJ2uRRfM
	enklIlKGy8iOFaoUawNFszFx3WUk3EpGj/6V27vdFF4I0VCgNW15NyVp88ruxWw1p38Zeg9VQVa
	ne+qFimDCaMH8Ok5w1nZYUHfn5p5ATXzHm+CxgdqXlH4sHxJLNARNWQbR7ycE3P6zuD9qMWceRW
	NxYB/miUMA4KQouf+Qw==
X-Google-Smtp-Source: AGHT+IGgM+cytKEGPnZa+of8i56XXnmX88F7CePu+oUPvqLC5x1cww+n+2CDT/JpBK1K7weznbpInA==
X-Received: by 2002:a17:902:f689:b0:224:abb:92c with SMTP id d9443c01a7336-22dc6a8a9ddmr132999105ad.50.1745860396855;
        Mon, 28 Apr 2025 10:13:16 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216527sm85839315ad.223.2025.04.28.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:13:15 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:13:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/2] io_uring/zcrx: selftests: more cleanups
Message-ID: <aA-3Ka3GLm-iXrzV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250426195525.1906774-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426195525.1906774-1-dw@davidwei.uk>

On Sat, Apr 26, 2025 at 12:55:23PM -0700, David Wei wrote:
> Patch 1 use rand_port() instead of hard coding port 9999. Patch 2 parses
> JSON from ethtool -g instead of string.
> 
> David Wei (2):
>   io_uring/zcrx: selftests: use rand_port
>   io_uring/zcrx: selftests: parse json from ethtool -g
> 
>  .../selftests/drivers/net/hw/iou-zcrx.py      | 54 +++++++++++--------
>  1 file changed, 33 insertions(+), 21 deletions(-)

Thanks for doing this. Just wanted to note that I don't have the
hardware to run the tests, but the code looks right to me.

