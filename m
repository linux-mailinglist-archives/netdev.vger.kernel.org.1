Return-Path: <netdev+bounces-123617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86E965B4D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE311C21103
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E91741CB;
	Fri, 30 Aug 2024 08:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E35171099;
	Fri, 30 Aug 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007567; cv=none; b=Hj7ezdXAHXhrtpgJVkFp7Fs1vXwiG3jcVMruDM7sDRTvI6pNo015qI5MfsWTBrv0TcyUZ9PL1JcpAU4NOgh28mPTWfitcFM2E8N02amzMsbGWvgxYBtNBNllLupzw8bz0Ii8LB8Nf7LlXhXhUnSPBLjXH+ZjM+f6/DkgVCl5mQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007567; c=relaxed/simple;
	bh=DniGDy4U/Dso336xusjC3HpSrYzic7ucyoGhwk2D9Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnhBnVIB0LzwUmBJjQhcGubYqIvnAvJL2YTH+UJlriC64zSnz6uzqshtjlmNUJKGEVDqlZz9BhpwXFpmVYJpQXFPEntGLU0PLLp4XZatnIlX1AaHVbTHJxFWh1HVuihntUC1DrlKsPr1fg0eyQXNuc3z1kq78RmKxAPuyTxTfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53346132365so1982593e87.1;
        Fri, 30 Aug 2024 01:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007564; x=1725612364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPG87WwuLgwZHg2YUzv03ycXxc87BOnrET26Pfq+QdI=;
        b=fi3LDDtKKHcNC99g46x1/M+ClLe79yed+XNpyWeLiv+MH5lTlxdqquwTHTUe5+ng++
         YnCrE2stKWQzwGH0l9l5vecY5/5+2Emz/IprnQeBpcQKVpqfAzPS5yIinAIbn31GhlTk
         TSBgtyJDVAFtOEwywMVCDUm6QhPfxM7S6iw6kcg7FAqC7VXs2nBCDuZusfwRiESrBM/4
         eca+s4bnTRgw9/jKTtcf9VJRzJIY891t1gTBhpkAYvN1ILLbQ5Lk54g9dngYw3O8dwfl
         bwcJerXfiLiqG0ObiXU+5f7A0PMmjg9y0IejkXl3ToPdQZje0qcwfdk8SR5Q+zjEhfj7
         cR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtnHnVugj64DHXxsndilYARJKj7j00Z9AJY+suprZMalCrKHPD742MdrJJN9rQIZDi9sFatfrLK9vTunY=@vger.kernel.org, AJvYcCXTTYi/XzXANunhMCaAp1yNiYPodoq9QssjAYuEJ8FrvbcsKrNp+/ksvvvxnYW7bMGg6Sex8/Wv@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsNb+a5fjHgbbEnKHr+m+/uSeAVkljSFaXe1f5Hw1j7DHwaKD
	hzSblZG1e8jky7E4MeF1G5t5Nq3F1ObZYTANqYiwDvgcpNWb6rG1tLW31w==
X-Google-Smtp-Source: AGHT+IHuHMaLISm46W9eVHKOpN2TIwNWitTf94nFnb1OWs+8+uT8uh7PoF56HGWVkGzr30jgMBYIFQ==
X-Received: by 2002:a05:6512:2211:b0:534:3cdc:dbef with SMTP id 2adb3069b0e04-53546b8d6d5mr866973e87.43.1725007563711;
        Fri, 30 Aug 2024 01:46:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb31fsm190968466b.17.2024.08.30.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:46:03 -0700 (PDT)
Date: Fri, 30 Aug 2024 01:46:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netpoll: Make netpoll_send_udp return status
 instead of void
Message-ID: <ZtGGydVJU816pIPd@gmail.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240828214524.1867954-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828214524.1867954-1-max@kutsevol.com>

On Wed, Aug 28, 2024 at 02:33:48PM -0700, Maksym Kutsevol wrote:
> netpoll_send_udp can return if send was successful.
> It will allow client code to be aware of the send status.
> 
> Possible return values are the result of __netpoll_send_skb (cast to int)
> and -ENOMEM. This doesn't cover the case when TX was not successful
> instantaneously and was scheduled for later, __netpoll__send_skb returns
> success in that case.
> 
> Signed-off-by: Maksym Kutsevol <max@kutsevol.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

