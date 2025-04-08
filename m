Return-Path: <netdev+bounces-180023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE46A7F28B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66513ADCD5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D501A9B3E;
	Tue,  8 Apr 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MCJH+/sG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321D1388
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744078211; cv=none; b=g6BAHDGGKm95bQI5i6DOzXF5N86KQJ7KKrmTUprKoeMOYnP2KQZA8sOBa0cpXVSVa7h1ekN4lIlGJBer1CKRwrWnArPbc/k+CvAnpSfvp+Uv+aC6RtGvIv2WjvzCP6qFfiIAW+Jk+dETOU1QyxGxN7SdDKvkLwjTgeq5UJUkD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744078211; c=relaxed/simple;
	bh=eHqdzlCtA2T7bv1J4nuHDRtUKpWIWd/H/uwx8kGgs30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX/EhKBW/xjgR5DXdND+Sgupgkkrd20dfQ1WZ4PIZMPz3cmXYttG8Gfj3VnOwZgqn4eeNHGp0+uhipbboR4W64yfQoFgnj+fA6KRO7lXawl+YIAgPn32OP/SbFTTlIZoMO9UjPwAp6uqgH6JzQ/AGeHAnbGh+vIXp1bI94nrhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MCJH+/sG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736ee709c11so4135660b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744078208; x=1744683008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw0bNP2Yg/rWmYhnfnKPujP8+GX7eRGIQfk3QlxH5+4=;
        b=MCJH+/sGO/4ICs1kclrcOJCO3YfTR2Rh0mynVAdXcF3SN+/Zjw6ewHYYC6rDInGmph
         +yQfTiPvCB5bP5AIlakRV57RoQPPLTQ7JUXhBg49lKwPV1wVESpXBj1bS/fS5rYsXDun
         xbniO2sAhBogeQXzhirrmNQ5uaYMxdbVlx5tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744078208; x=1744683008;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw0bNP2Yg/rWmYhnfnKPujP8+GX7eRGIQfk3QlxH5+4=;
        b=SkHEkQKpXlLLRE6fH6kPQi1N/YcMglYLGcPWvkRKobaoev3vuHkobPfGomcCkjQjIz
         dsE8fGcKLz50SwkiXW28XqBXXj0PDdQEv4btIXfIiwm/SdPNmQdQonuptUaBYVKcrtUR
         sKmAmgf7pQVgC6+bU/QBKOIA8ie1BHQVT+GlUZr/W7AWoGWq71XPt/nTnmJSRB5PmM0W
         yI3t5bxOd3A7xXPP16ksSpdJ8AoZWojRcQTwFs6ZM0E/PqUyE2GBXN3YizUPKMeo+59c
         cBFWEP8cN5RWx76CL2fJDYfHEbZcP5ZUWjm/LFHPKT6F8e4baN5cemMAJkENtrNB1bUu
         Z3eA==
X-Forwarded-Encrypted: i=1; AJvYcCUGycgkIHVuBFifL4MkpgpWUVFAEpunMOQyBI2Y+/Y1F1XGBHtu7WPCd9lW/57bYM0NMjOO+TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAFiqI4yglLTPN1k9XuxzSboWYdLCUbLBMZ9nZNeQN9eLf0eJ
	KM2DhY/3pUPRjj+UgFG12arb/tN02inyBqyQ2ejsu4oPFmD89ZEA+e2u/8RimNg=
X-Gm-Gg: ASbGncvmRKq81cG9LsmPuLNbEpsXJIYYzLUUtnYYyvF65QiJavXtpALVlGWdwTzJ0IP
	0WkLbkmVcDxbZxsqJUw9yBAwS/vR1plB173BRtdm5aUnIZ2z6g/Gulo+xKa+uC/xYoAni3iezfH
	DAX9se7bAQOMIuZEBFmbbzolOSZgnBjC2HXfv1LLE+kGrMLmIz8dGvxmce9VyqoX2quGGDfPVBv
	aFknBxJ543aaBvssIsuap2V+d41qhr/TfF3GbR534Zm+vDCSG6Jwayvo9nQDv9Ro3jvPf5Xcpbc
	Y0jA3uhB7Y7cc5xjvyh2Zz6EE6rGNLSmuX/pCHm81gF+blHhCmfXjUK8NnTJSq/0f/YN899f/Ia
	l+W5YRjyzaIJeeJaH24fKfw==
X-Google-Smtp-Source: AGHT+IH/5CXHv3h6BfVUIkPGYZMx+j5jBXm5Q5QQb4m5Tix6r+HC8jdY/0+cBSX4V1nUaKqUundp9Q==
X-Received: by 2002:a05:6a20:9c8b:b0:1fd:f8dc:7c0e with SMTP id adf61e73a8af0-20107efe0fdmr21459777637.12.1744078207714;
        Mon, 07 Apr 2025 19:10:07 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b42e1sm9564665b3a.134.2025.04.07.19.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:10:07 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:10:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Drop unused @sk of
 __skb_try_recv_from_queue()
Message-ID: <Z_SFfAGYrvDPl5DM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Michal Luczaj <mhal@rbox.co>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>

On Mon, Apr 07, 2025 at 09:01:02PM +0200, Michal Luczaj wrote:
> __skb_try_recv_from_queue() deals with a queue, @sk is never used.
> Remove sk from function parameters, adapt callers.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  include/linux/skbuff.h | 3 +--
>  net/core/datagram.c    | 5 ++---
>  net/ipv4/udp.c         | 8 ++++----
>  3 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

