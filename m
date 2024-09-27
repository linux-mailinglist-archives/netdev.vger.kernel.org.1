Return-Path: <netdev+bounces-130151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D4988AA9
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA8281B7E
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979681C1AA9;
	Fri, 27 Sep 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hho3ajbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E040158DDF
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463846; cv=none; b=YvZhqE+CQDU5ksiWhZhyXt243B5aGS5dyWTLDTBT0rod9EuGJKmrRcqCCDLl1lqHPkc/iOh2ndN6w6jc3mWV5FvChm81y4+aBKlhagLkvLK5Q07Cm7Ug1Gm50JYNLBln3SiD+JUqzuHwSrLirjZGxf1oAoJhXjzW9kR0+8cuq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463846; c=relaxed/simple;
	bh=CHepwiKVrhYRFqSEuoEN43CO3RQYMQzGqzOq5t5Q4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toOpHh5iMyA1TXG9R9NuGJW290c4ENx/JMsfK/ni1RvpzojEQfpVVZOqCFwpcgQy/yix+GNLkwkJvcn4JAiLBF/9J8lP0huN/0LK1r/LiwQg0H8PG1xFLPI2DhxwA7j/EUpZBJOvPmxwzrPZegJ064SAX5WogAhM1PWzsyT1lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hho3ajbb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718816be6cbso2203999b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727463844; x=1728068644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPfHmPKp/Y5WNN6bjQeKxR8UWNI3sljkWbiIgLHSqiM=;
        b=Hho3ajbbteXrvBQh7szIUYAvFPqhCCuuCWK0hQ3KP/+LP/hkIAYgcQcdDTZVb5u7YN
         NO0mnc8LgVzSHfdKuV18zPoma+gS6kUnT4xgDudGh7obz8lJ4/AfgUkyfAF7au7Jpnis
         MSoEtqwhwHesIogbW9qUmY17eDVKxve4ap57s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463844; x=1728068644;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPfHmPKp/Y5WNN6bjQeKxR8UWNI3sljkWbiIgLHSqiM=;
        b=fb7nE2tXQQRZ/c/ir3ZNK4hofFvAym5NinrUFiQjzAkuKS3w/96qhSmGElqpRP1KPH
         eG8VsD9dR6HDLdWeU5xFGBqdAdIKORNOWZvsk0Kc+1Fxzr9gRLWiiV/vG56FKKg/gSv6
         hOf+MpU+8R8U3hVvkbbCV+lpU1lTyuXy0bCxmd9QcdDWb+PMBqnuf4yfml5eKSChEOi1
         ex9TuEg5A6h45uzUCSxI9dXntjF6OgVITkdo0U+X4z8YzRa9RhiIgQKmt/7idcFFsB3j
         TpeFVgKzwwm5Xbx7jU/kP6uL5VPkRKYQqRh3f+mNPQn7A8jaWaLcy5ZvfzneEvAjh2en
         aDyA==
X-Gm-Message-State: AOJu0YwNCriFKZxX0uPpfLH7Ym+sjXuXlxAwTtBoGUidAKrQVc8Q1+IS
	svnwwhyOofS+4LI2D3E46KUEDMBE/D+tjj/jKWu964Nzm8Squoe+ksJqBM6cS9o=
X-Google-Smtp-Source: AGHT+IG6H/MJggwQq8+Ni9SwF4tf2SUxcM6xi55yVCWrfJ+aMITNHnRkqOJjElHqC9jWV2TVfLT/BA==
X-Received: by 2002:a05:6a00:174c:b0:717:945e:effd with SMTP id d2e1a72fcca58-71b25f29138mr6032343b3a.1.1727463844374;
        Fri, 27 Sep 2024 12:04:04 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb3bbsm1985855a12.72.2024.09.27.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 12:04:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:04:01 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] gve: Map IRQs to NAPI instances
Message-ID: <ZvcBofFP6r4SONYL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240926030025.226221-1-jdamato@fastly.com>
 <20240926030025.226221-2-jdamato@fastly.com>
 <20240927185619.GN4029621@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185619.GN4029621@kernel.org>

On Fri, Sep 27, 2024 at 07:56:19PM +0100, Simon Horman wrote:
> On Thu, Sep 26, 2024 at 03:00:21AM +0000, Joe Damato wrote:
> > Use netdev-genl interface to map IRQs to NAPI instances so that this
> > information is accesible by user apps via netlink.
> 
> nit: accessible
> 
> Flagged by checkpatch.pl --codespell

Thanks, will fix that.

