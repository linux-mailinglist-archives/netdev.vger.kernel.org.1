Return-Path: <netdev+bounces-143332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88769C213A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80309B25016
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4B21B447;
	Fri,  8 Nov 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwawSUR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750F21B442;
	Fri,  8 Nov 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081219; cv=none; b=a4SxRjEEGlF5cpHtkSg5o3EJDcXYumlDuE+wi27DeigK6tVc3Xdfe5kHYLr2jj1JeMXsnlhzLQNWcxAG8ZAhBwPlJ1Z6vyGZm4GQC9iKjdTOdxOgM04PuQPXwJcQ0JDKrJvnTOEj+fiJzgeg3eHqyxD03W5Q45f98712i4PLwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081219; c=relaxed/simple;
	bh=yzQFD9LxKQktmG1yOpcFa0J1fmTZUR/FU0n85McMjso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WivWUlV62L5tE28s9rciwlmvzFJi50tnYaL2s4VlnIK22s/WezKuEQaiAtpCi9cX87ISdvh/+pbsQ27LEA6XmNSTXdeB6Bmr/DcDD7EdXrhAArZr4pPaGr+f1yrIOhIExAcIYOOiR59jW7jxDnfI1tVFbFHNZR3aDneWvGh96qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwawSUR5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cdbe608b3so24943645ad.1;
        Fri, 08 Nov 2024 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081217; x=1731686017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04QN0bqnc/hIDNiSoE8wNnlUvenSZdQa91K0jk7Zr64=;
        b=iwawSUR5x6Vf9CbNgwHXcmNzFnnEMEJO9U0nXuqi36PfWEZBzNi/Z3mVLQBrJpdCA2
         fffpZV5DLCImB1kULDOwmo7KXOrQzzQ31YFzleSB0OAqs+YsT9Qq3LUBmXN0L+vZXgvh
         YaaQ3goJx1Un/sGvn+kqy1OxL2ITh/wzQmqn/TNX3o3KrZBZosDwiL7qCDZichyTZTbF
         Dc9TUP3HEvgIBoCczu6RAeaW8C8hOlXGuamGXRzBFtIfs+y/dsDG+1sK0QNlAgmC0zL+
         rwrcjGvhSQ1nFFchjFtd41LmKfRBWgBnZVy0elteCWIVkwhnStbuAdpjB3GdlhUpeviG
         DyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081217; x=1731686017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04QN0bqnc/hIDNiSoE8wNnlUvenSZdQa91K0jk7Zr64=;
        b=pIJZBZI5u4U49MFozrFx52xrRfa6KBCJW2WNjjeXD8/N+fEJ6XV8XxjioVY7v41gxm
         87nA9OCI0aZ/grsoHsEX6Xcqr67uWraQKsrHgha7+i0EYOi8Dx/Ih6xHcQd98k8scnhu
         1+B3peDDMvSqbHMvUQtM0e8CSFb/RHKl59rE4b2ot+ZreMiaccaD8zmT/ISwA/eCv4Wl
         XFD+6LHEQyAKFRisnb9RJFBuYfq8fpFX+geANYbGhrrMW6stk0k0pHDzeejknmhs5NlO
         u1L2e2sfMA2w4tyW9QbnZB8itoAUOVV4+ki7hqsTKwUZ1MkEeFvYW/PXmsccaSeXqTY7
         Q1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVEgOMv5Utuix3fjOxrg0LiimoNGF5E5+FMaNZAYOSEPFQNq0uOFsdFAVO2XAY9F0Hum/xO1yl6R6FUGsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8s6GJDIwH1Yd2nMq5sZ1NRe87gkSrM/9+e+H0XREc/F+UE+kG
	XuDiO7g15C3tvWS+wh6Tpz4hxl+vg1BXxOY/dY2i8aP9LJvtYz8=
X-Google-Smtp-Source: AGHT+IEhC1160Q/9GmZ8EvBRalnxtSThLKL1KS6X1L8kelGP4DOoXCO1Lw5Er81k6RtIWqdXQFm6Zg==
X-Received: by 2002:a17:902:e5d0:b0:20f:c225:f288 with SMTP id d9443c01a7336-2118355d37cmr39778015ad.23.1731081217292;
        Fri, 08 Nov 2024 07:53:37 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e68cb0sm31707145ad.224.2024.11.08.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:53:36 -0800 (PST)
Date: Fri, 8 Nov 2024 07:53:36 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 2/5] net: page_pool: create
 page_pool_alloc_netmem
Message-ID: <Zy40AFcVze4sak0E@mini-arch>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-3-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.
> 
> This enables drivers that want currently use page_pool_alloc to
> transition to netmem by converting the call sites to
> page_pool_alloc_netmem.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

