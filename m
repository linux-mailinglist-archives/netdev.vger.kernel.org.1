Return-Path: <netdev+bounces-119291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD59955121
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C8B1F217B6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F61C3F10;
	Fri, 16 Aug 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLs4rM3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EB1BE861
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834565; cv=none; b=C57scq+JofylbvvdgY6iIdsV+W5TMOsuWayzrAYskb3Cj/sJSer3a5eWKQ7Vj6LAGJO1pFJkplz9TCuis3hXzu6qxH0kF6upZe/LUmgV6LpES6vPwBSrXRoJmTugqPj/YFv4ZhpA06q7/UhFaVPBMdeSeQc28W3zMwjqi8AAI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834565; c=relaxed/simple;
	bh=kjCEa9x8DhndhQnA4ZmmtAn0XGvc4jK3GOgiUrNx+Y8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JOORzUDtMshSMHaFrlJFvF0La4QRVEl7aIygFNljqFtyhulmhw++NG9XaK8BScmbHRQFbKMcXBvn+nSnn60UZs+u6Wl+MUSBZzKYeIBsSkqByNAGIakE8cqetTUNghNrDT/zMG/P1Gtwt7HYcub+8vHGRHj9mU/OVd53XLOgORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLs4rM3/; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4929f9a28c7so790554137.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723834563; x=1724439363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok257cQ0n4H2VmX3HurCFJYrK335ndnK2WuuSILh9gA=;
        b=dLs4rM3/QQgzbsCXv5TqfYZnpicI+GkNVrAqXJ/5B0YGp5z6FHBZPdCddPlXCpuz0Q
         4IfSBnLYcycBsTPmFTjAziMjLbKR0Qu09xr87Q99dpo5rbSl6yjkO7YNMNubycsobcks
         lN3LWX/4YiFdgA4bOu8hq2RFZZG1WYGCnMlav04vG32Y2UCOEExbmrLVVY1bHLiIJCNx
         rCUeGyepA+IgXKi3JMoBEChKh1IQd8lmppbgaAJwvSahrpkSokqBHdsR/tMe8AT4yol5
         HZmP2Rtl6/4gqERBhf7N1RuNQcZ+4Hobfd6hyJStrOBlOODS+IJhen8/kwkj8hDsOecw
         ikzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834563; x=1724439363;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ok257cQ0n4H2VmX3HurCFJYrK335ndnK2WuuSILh9gA=;
        b=hBdPWTzn3ASsjRuXoaFqVP7cwPELQoiHkuAxpplDhVseArkmXKkugAtnLlMWpFVxcz
         mYKzNf2n1pgj9CNKRTKncIwlFe01wr/fnLdY8/rLb0v/h2/MjyurFmivflIA+KJukU0w
         VHsBd/YehlO8X0fGSlLbNvY0vmOucJR5oBDQa+O1EuE3VQrG0z300z14rU1Rl3QJc/ke
         mxcF6KgwF2snWa3bKPFMZ+YTZiCpVBXUW8wgkoWQCJmhKv+rT8J2wTAejJ6XJzrfrNhe
         EZC8Y0KRjI/Icrlyz8R2exNG/vNCVBXusNtjHsFHcnMc5QW/WHLRU99KBWYU1OQwqzoS
         +anw==
X-Forwarded-Encrypted: i=1; AJvYcCU7319BoPsFnnZYeZ5iZtlGT8WPUvGJSf9+6D/hSUooSf+3TAgyqozC2BHtD3IJLkmmc/N+Z55n+ls8FPr5IZ/vofhrlZck
X-Gm-Message-State: AOJu0Yx+ICi5Qb2dMXlnPGharkZEFLgffdmcT1+uciuzx1R0BCWMcgbQ
	dGH9+h0ABCmb1wiRSmv7mErSUPRZo3eTnSRXHl975H19Cp6LaLGe
X-Google-Smtp-Source: AGHT+IHQj8gCqlBdAt7aRQCCyQJtMiO4jGl+H+MabZ3bWBOCIvqbTpX9JVXtZWoPVmIVcfz671IHgw==
X-Received: by 2002:a05:6102:2928:b0:48f:ebf2:14d6 with SMTP id ada2fe7eead31-4977988fdf3mr5511192137.6.1723834562836;
        Fri, 16 Aug 2024 11:56:02 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5b09sm205241485a.73.2024.08.16.11.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:56:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:56:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa0c1e255a_184d66294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-3-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-3-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 02/12] udp_encaps: Add new UDP_ENCAP constants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Add constants for various UDP encapsulations that are supported
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

If a v3 is needed, maybe add to the comment your response on why we
think this is UAPI to begin with: for BPF.

