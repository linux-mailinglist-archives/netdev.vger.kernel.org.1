Return-Path: <netdev+bounces-75650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE086ACB1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2F1F23D8A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD612F382;
	Wed, 28 Feb 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TtGTeslW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391012EBF2
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118546; cv=none; b=P7P/gEzdwnPdGPnjhtnJtMpv8cvTooLkdgnBKCbA7oqKwnwDOGLUlhdL7RuAht2sVWEFgf0Tb2qfpgmHIXAStbxhuey1jv34x5DgfLydXUJATS2Aywa5F4dhAZzPOBvQ5oh0eRE1S5+Qt5+d3uKbIIOEp8M6hAfK2NZ1WYodWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118546; c=relaxed/simple;
	bh=Zbb1RqUPILYath11iCtVroNA4FvzTOM60NT5IUYypUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZyGlZn4eK5v9yjuOJ0S77fDBNE/1innaqyFbwk2NFsMqQd5+6jxOsY0vNoV+Pm0CZClXt5YrIjWI/cx1VQ1XVcqLp2xo1DWA2M25gm7zZryhBKVT+hLbsMbn8ml/wl61Sve7j1Zuf+o9wHHw9W2UKQqa61XXldzbC61LyWGuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TtGTeslW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412b493ed27so3034825e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709118541; x=1709723341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbb1RqUPILYath11iCtVroNA4FvzTOM60NT5IUYypUc=;
        b=TtGTeslW2Q36Wj2h95vLKGu/tE/WIJArTdkK1OM0mETm4fXlxotWmmUA/QuTkDCTOS
         L7MK1wh3NPA5GgxvrbrngsdTA2HCSb+oymqobTTxq9nfs1qkiWBIJ+p4l2BV0zq1Bxy+
         fF6KzcwHkrSbIVL+mtzkiTi654/2IXox11AX/0OiPZExJsWZ7X4URR1p1VthwGUXa6Q6
         hBJWtefW8EkzNY2xDTdn3ETOYqoZYedzDmyWWDSa8otL+4ei+Dahqd/3LT6vDDK/zBLx
         VrOW8hpqK3e4VMiZ+K3/Tp8v8Q+Qk4+UCv9+GWuaJVTAbX6ktp4zLPYikvXtVg8+JvFt
         ds5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118541; x=1709723341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbb1RqUPILYath11iCtVroNA4FvzTOM60NT5IUYypUc=;
        b=NQhM0tssGrGoi6kZs2vn+72PNn1EGjmqTRzOPbyLBoH9im8sC6NCQ7S+Nvk4jFhIXF
         ZhtdRXOC+j0n+ULennMUTvrIScrMI8nk+47pkrz24YUD6KohDz7yO620HhWxMfiJAbGN
         Tl58aulg/rgY+swRrwP2tMsPruXqTllBoNvLct780POWQU9HTigHY3I/eTLgTo5qR1dO
         pcMLbit8GUp4TB9K/Iijw3zpSRFb117Ae0thX5tHgOBpp4nWmO6JRPk5EfZqD15OWV3H
         VRSX3lUYJgPDE4H8anE9HKZmk/BUPs7QzWNNTtjtd4TUKJ95u9ULnMI7wlPr++P/W1yJ
         ZGhg==
X-Forwarded-Encrypted: i=1; AJvYcCXGmulX2WNkZFnwXi7THiDCbbsg0BTzwD37wXADTdwdtPFk6TN2CBn3DAy5wkNCWK3psThShC9L9bXZo1ypSWndc1epRyB1
X-Gm-Message-State: AOJu0Yy8+nd7yujb2HbmamCn/bcJpqczvEzKf4rwrvKaqp7YFhMU+yw/
	3TaQ8tuDGsAJgf6PfitBcInwmmyc4UU6G+mYJFyv5uF2ugGH1BnSqQsQPCGX0ZM=
X-Google-Smtp-Source: AGHT+IEcnVrJAsv2BFqNW+Lt7WXY/9WLwWT4IYWCsWF9jFJvwkBM1+lAC6jy2bEELPgZYQsz4QeiDA==
X-Received: by 2002:a05:600c:4ece:b0:412:a344:ea95 with SMTP id g14-20020a05600c4ece00b00412a344ea95mr5857675wmq.14.1709118540883;
        Wed, 28 Feb 2024 03:09:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b00412a0ce903dsm1784993wms.46.2024.02.28.03.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:09:00 -0800 (PST)
Date: Wed, 28 Feb 2024 12:08:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next] net: call skb_defer_free_flush() from
 __napi_busy_loop()
Message-ID: <Zd8USSc6Yxea5ft9@nanopsycho>
References: <20240227210105.3815474-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227210105.3815474-1-edumazet@google.com>

Tue, Feb 27, 2024 at 10:01:04PM CET, edumazet@google.com wrote:
>skb_defer_free_flush() is currently called from net_rx_action()
>and napi_threaded_poll().
>
>We should also call it from __napi_busy_loop() otherwise
>there is the risk the percpu queue can grow until an IPI
>is forced from skb_attempt_defer_free() adding a latency spike.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Samiullah Khawaja <skhawaja@google.com>
>Cc: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

