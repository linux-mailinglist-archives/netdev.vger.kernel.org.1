Return-Path: <netdev+bounces-127456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7449975767
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC06283C6B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A56E1AB53B;
	Wed, 11 Sep 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxDg7yR/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68521A3033
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069414; cv=none; b=bG00ykdESTxSnxKyi+C4At+Uoupkqa+O4mbakwtLklg5a21hmlXmXHD2k561DCBEU2adhJvD3gGdBMEThhX2aj+UH6sS0U0QQeH6egRdBuBUvJfAbDt/GP65M6gkIlfBXb0DvAwU1n3T87QkdRxPIqa1LbW8q/b2yRP6DhgJdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069414; c=relaxed/simple;
	bh=pQ3E2zffSETC5QWtFHxL36uew1I32DCdmQazRo6YHuM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SSAWRd9OPvU11p0Ul1AiK6fD402ZlA2pAHe3o0ork/LTDR30cGvIngoa44BmFJedpU+2SlYgMhBMRskYvakQdirIlwHLamOmLlOtcdXgR+JezBQCWtX/RvqdeUNJuqTmp+nZIh8C4VMiLY8UlKykDHn0llimYEdHHDOP9QEMHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxDg7yR/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99e4417c3so397933685a.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726069412; x=1726674212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL1d5kVRGKKdEYNFnS5XSmR3aSHXsBlCfgfa6lfgnmQ=;
        b=LxDg7yR/I5p3uQ7N0ZHZZbTCv3SWBFOEyTw346S7axOlCZMg3smMDNChr/3ppUsb/l
         JzgPwHYpwOET7GCdAGce0T/LNSXLMIgVWYa3zRa/t0hdNDQFa2fYkcHAp16rksoxBInN
         BZhzX9Z3AeT/sadGWkST1XOb1zAPAXNDQ7bN+CEMtZ9qfbds7V0AHdvDs92yDh4rR1Ug
         13nxbXR5EnToKjC4QiR5NBh9ekkkxYovyHrZ3u8Wpvokd/F1jpmXezG8L1OiPzz90tjq
         gxpiICw2LFBLE9I6Lcxe7QiLSC538Eki1kwmwhd/SIk4kVdnbm6qX6ZBmUqgx67cse//
         dMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069412; x=1726674212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gL1d5kVRGKKdEYNFnS5XSmR3aSHXsBlCfgfa6lfgnmQ=;
        b=ec8vW7SqAx+xt9UdRkwOx7i+oBMEw22jY2GIGqrG6c/nP/3BBNE4fd4RGHGiksF+GE
         n7AEKiH/8x3ax1uggvDTFcVMNjSXWBQ/soh/oHVc5NSP51jkIpWFzP8ovX8e8YFmYrLe
         t5SEzjYO8srxJW6vxRse9Khu+xsDL0s0D3uTIEMe6GL/e8WTn3KEb2C/L8Vk8hewflD4
         mbriU6U/5cZaqedt29qo780SUA54aWFFfrUvf7fzMEa02tPBbLARO6S9MVIvjiGLlqxC
         8RSTnHaT1Kqu7u1pyhQwHy07b7HE6aXUWO0o9jv8HTazJ7k10rs7uqq+JKggHexTKHk3
         YPBg==
X-Gm-Message-State: AOJu0Yy3wlWIBEPI/ESy9i9hBiAnIegse7RcRIMj7U09DLIS4JX3eX3w
	6Rnp1oa/IGyYUy6D3bZ2wIhX5wDimeQ6cqYoM+tvSTNilmHalVUX
X-Google-Smtp-Source: AGHT+IEfnqljlPkg/5YfsdvPMhrhWTTryra3hWRrHaoWKhNxlF3/nOng0SuiaiM562NZKzGjp41Jwg==
X-Received: by 2002:a05:620a:491:b0:7a9:9a64:cda9 with SMTP id af79cd13be357-7a99a64cefemr1736557485a.47.1726069411536;
        Wed, 11 Sep 2024 08:43:31 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1da04sm434408085a.112.2024.09.11.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:43:31 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:43:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guillaume Nault <gnault@redhat.com>, 
 David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e1baa2d1a63_117c77294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <267328222f0a11519c6de04c640a4f87a38ea9ed.1726046181.git.gnault@redhat.com>
References: <cover.1726046181.git.gnault@redhat.com>
 <267328222f0a11519c6de04c640a4f87a38ea9ed.1726046181.git.gnault@redhat.com>
Subject: Re: [PATCH net v2 2/2] bareudp: Pull inner IP header on xmit.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Guillaume Nault wrote:
> Both bareudp_xmit_skb() and bareudp6_xmit_skb() read their skb's inner
> IP header to get its ECN value (with ip_tunnel_ecn_encap()). Therefore
> we need to ensure that the inner IP header is part of the skb's linear
> data.
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

