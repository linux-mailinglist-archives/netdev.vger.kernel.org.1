Return-Path: <netdev+bounces-204757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA2AFBFAC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC367A9EAA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E21CEAC2;
	Tue,  8 Jul 2025 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgVwWaYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4066800
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937104; cv=none; b=hviaFvWRLXCYcFAtFsFliSIXgHrJKSSM/vbZ+ZG+CAgEEq2bJztAo9aNgkqMNNkMjEzKoWDS7utG/KQLCHgY5a9DR3Wa87dfA0c/rsXLLigS0c+Yep+jZ4+laIjCPcCLACb5k9mQrilU2DhjGlh0kWyEqOYFkhVekQTQ8Znl71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937104; c=relaxed/simple;
	bh=+c244d7TG0u6sPBohT6h+GT7q9EpRaqAL+e+qn+a2/E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Fc7A/jRr/srDZgxYtnvjy0eYu0uIVAXLr622L0QoQxoLiIRhBMzoVqAdsT5DZo15rqV+AGG5L/LFQNmbT/MVkWHWqaoJPAnJHQ7RS+9+X1v2Tiv7rjvZRha0JUN06SZccLyEWjLXGjMMZXT2eVWsGD//YkSUVLOG3Kse5BD8Q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgVwWaYD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e819ebc3144so3463397276.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 18:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751937102; x=1752541902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtjVWhXZm4mjianJAtAJPwOUFtgZCgemLXb1XQAtzSE=;
        b=XgVwWaYDaBVoy4G0VsybaUY1wJerAEvMOPJz+FGQD0K2ZW6ZdslePzZ1vqKTGqOcWe
         jULnrOLkUl7Ku3fLbay0zHtqQTzqsXSVQ5NACtQC1OTvgdBR+3j0BrXn4DolitTpCWUh
         hOZcZlg1GtWiOkPFmMhGI8oOg9O+1pspX9bJMHEakskgKx/GR0HQy0RF4ZKZwpGIqGFD
         dB4wZGpfPeCXkS7ZfQqAIpoqHIR8uE+l+iBW/EY5D/ICEIyxlka/O9nDqCwhS5JM5fx6
         4Mo7+PEMQzaVHFXSjkFj6fXzVA0Q9oOffhnoE9afP7U5UxVv0TWqY/0p0sb9UtnjXO4d
         gprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751937102; x=1752541902;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NtjVWhXZm4mjianJAtAJPwOUFtgZCgemLXb1XQAtzSE=;
        b=xMql2wlO5Q6PXt5rLfaw1diUD9hFFlxVz6FbTF+iMtELwvLrNnYn3C4RPY5tGEj9yH
         yRoa52FCZLEU5BC6MW9O3GuhZ7HHimvEPlsp4Tm7mG5LLi5/99GzKvHdcZ4sffGScCpn
         IWohkIg4wTfMsJFKPQS7afC+feMsrOPu3PxhQiXFU2nTsfkGQ05C82J8kbsclKZ4rVgg
         TZOT7M2YQ8N/rS5Zrnl/ZDq+UY983tULiK8OWVVMUm1pmeiCMsrYcYJn5iCMriiiIVPg
         uIud1BN/LZtNDOw7DxWCmWP6KslkKbpzV67UE0d90mpVMe1Ep5mIiHwbVAPOI9fIoypT
         JwDw==
X-Forwarded-Encrypted: i=1; AJvYcCWyBo9o8XQDY3mL/8bsVkSl+AjBQtd+KvB5G+wk61dHp7u11BIAb96NBwdmrQdY6D+1X2naYQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh1bscdmQ+DIRrkNvG3rYCV/KO9nfKn6eCXs+nAWk3BxlQ2QjO
	Y/hEwuopAhhN4r/CIaFbzD51bBeQ1f7rzClil2Iro729I9iFM78SfalC
X-Gm-Gg: ASbGncuhwyF9FLlsYbajipmRhoXI0DS13+O0KkLD222APtWU8CBFXjdHWC1c067qP9m
	R2dfVkMj/ZuMXLOe6GEoK/qs8DPjgYncTy2lVawpt3LEC441BocGJxj0MiCnctbzelYRuq0OSkH
	mRzBzsdaKHYXgXN1XxWf5xJYG9RgPkix/NHvGCI8UT/48fSQsmAlbeEhog2WSomrsSn9TLgNMrY
	u+tl+aFPQG29F68AMZZn5x1vzC5nN9wIdkQ5RHlgJ/MO+4Oy0sRwsDATtiTTCnDCBJTh59scog7
	/5FuY5N+sN+3OoZApiTDDwcxSGdcijYCJyRcGuoqsQcJ7auCA92k/ANNyYEMv4IGW27Jwii4xgr
	pEhPwUQj49uu8tTLeqzLzYV6itcx57jOP3atrjIg=
X-Google-Smtp-Source: AGHT+IG5sLlIELpX4DW+OiAPgJ2VKobhqEU1gnK2kPHjwPxxXd3rBATshfzZEbBg/QB3S5WP6OzWKw==
X-Received: by 2002:a05:6902:1108:b0:e8b:5465:fd73 with SMTP id 3f1490d57ef6-e8b629f1f17mr896432276.4.1751937101463;
        Mon, 07 Jul 2025 18:11:41 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c4b3424sm2990596276.50.2025.07.07.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 18:11:40 -0700 (PDT)
Date: Mon, 07 Jul 2025 21:11:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686c704c732fe_266852947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <9cdbda0a-721e-40ac-8696-4fe4222d8b24@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-5-daniel.zahka@gmail.com>
 <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
 <9cdbda0a-721e-40ac-8696-4fe4222d8b24@gmail.com>
Subject: Re: [PATCH v3 04/19] tcp: add datapath logic for PSP with inline key
 exchange
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> 
> 
> On 7/6/25 12:16 PM, Willem de Bruijn wrote:
> >> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> >> index d0f49e6e3e35..79337028f3a5 100644
> >> --- a/net/ipv4/tcp_minisocks.c
> >> +++ b/net/ipv4/tcp_minisocks.c
> >> @@ -104,9 +104,12 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
> >>   	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
> >>   	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
> >>   	struct tcp_options_received tmp_opt;
> >> +	enum skb_drop_reason psp_drop;
> >>   	bool paws_reject = false;
> >>   	int ts_recent_stamp;
> >>   
> >> +	psp_drop = psp_twsk_rx_policy_check(tw, skb);
> >> +
> > Why not return immediately here if the policy check fails, similar to
> > the non-timewait path?
> 
> The placement is so that we can accept a non psp encapsulated syn in the 
> case where TCP_TW_SYN is returned from tcp_timewait_state_process().

Ah I see. Maybe worth a brief comment.


