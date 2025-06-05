Return-Path: <netdev+bounces-195263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF0ACF1DF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595CB1897E74
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04F2798EA;
	Thu,  5 Jun 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOkSzQAH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDC27780C;
	Thu,  5 Jun 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133476; cv=none; b=PGudkAwS1E7OAmO6ojj+QMjT9zPq4RlOsMrIOFLsTGXOtb/9dYVl1BXOfr2wj/a5SXQOmcU7PSokW7rAeLMd51CCDVdvTM/QMAgUKLsBWXZTMQ3HcqDo5Tju1QzRUceHzBdL6GhnS04Byb7ay4to32mtMHwnpY2sRmvhVVFCeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133476; c=relaxed/simple;
	bh=wqeLCR+kMOGYpL8wqQ6saI2UND5qcu1eTCor5Ts+qoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa10x+RvXjqdkCqZTopf8znX3AKROhFPut74BtLUycUO1fKpcBbVkh9HTDpqnEBzGHZIfLdlxHoqt8ynXwrEjV6R2GwAjG+ulQCnE9YKvmyRkhvfU21S+APwZotVyEz/Gr6mqAEVf1qFaovd7C7m/OkXDQrxGRn+onxq5fmwZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOkSzQAH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso929644276.3;
        Thu, 05 Jun 2025 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133474; x=1749738274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KW1JY7Y7VtpEznLuWv0WBuU55G2LknK2IpQRvG4+iU=;
        b=jOkSzQAHLCKOYWFX1GgTrxwJ+4R3QilllFFU8zePYX6+n2MYM4lle5e01dxuVqdLUW
         FjKK0AUuokwMqbp992z1pNxHDMUeNVgjVkrW3rYjOmeqZD8AgPqmpy6Hq87buzDa1HJj
         VJH22FKkDiUvAfhdlfU3EAK6uTdcYIEtO9Xrd4SeiQY1qKTe+7oWkAvB2dEp/g0bFkE9
         Rtm4IeWBzjN0S5nU+1hn9q2PY8R3D32sVkJkMMYOLYMPmh8AQT+Ls0E4Q73C/wVuMVdy
         jCfgR3TKjEDxCHX8zzYY3NYX+kUJkbwlagw3fsaGlOoAjhhOuKA7c9O3xLpPhx63qyuC
         FfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133474; x=1749738274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KW1JY7Y7VtpEznLuWv0WBuU55G2LknK2IpQRvG4+iU=;
        b=p5oZGKlyXMuI20Ev5ajmmo6mR3Gq2HtQr7xr8t3mMmsHybEP2wlHsvy5W1ePwAgpXg
         4j5NdiGsnKWu+bgFStp5DSc6S2IKEd+rOEDXy7Wv7WQwdM5UP3Jkcen7jnEKxn+F4vFR
         LRfYoWFzZgXeav+j8ZTp9QVyINauDiUNzFfujHu+h9ECWYqaP0Vj1LyaOQzxabiieJPe
         GJRyE7ie7yPoSyLKXJLQjlYSCYYBg2lZb2nMPk+0xxYfSWKZSlM7JNeF2g2zq6t/xfqO
         M7cOWhaeXe5NPe6PasSsyPwOOMLNq0Fpo9n/xGjmrZyIQI4Oyuv8MP0Z5WX/jrdQT790
         +Z1w==
X-Forwarded-Encrypted: i=1; AJvYcCVMqsQl6pVdY3VIb+bg6EZw2DxskEr3L4QAMucElUrlrcUTZi5A21iaEF/uDaZ6HX8xne0XFgo7tJGUG30=@vger.kernel.org, AJvYcCXeFQRHq2UqgXCNzHXgIfYd7a3mfP4Tt8K47flsXP0kWS8+8WfWB4tQc0GauYKJ6fM3Qof2YyR8@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgiaKAEpQyXjEPT+dTgLftrMlqGDuoEgR67HFsbLcdAgy6WZu
	/bsk+R5ZYEdSp0QTQMcHkvksyEySZxj2aEfoght1dJLcE6+DGy7wFRByxg3w1Q==
X-Gm-Gg: ASbGncvKa+yj+SJsKewy9mZRqJjdV30zxAGO4ipALZuJi2HLoLQyQirgwT+YYKCE6ky
	Y7YuQ59h0AsHWHfpXbYQnAOcbPNBIemZ6ShSotqRUIAXC8ofmlXn8CAkoqKLHdPaloXa0aKkoZ/
	GFHlCW9WAf+cKZft877ABWkLOOzrN5v4ilrtgSLMkL3ihMp2EvvttXfo4dDfaNGNHszOftAf1h0
	ydQ3HcqNY88iVag6pR3J0B0UnSc5GWyUnU9dQn3JR2k+pfDGomk7id/znljKB+sVEQd1h6h/keF
	lOafKWdbJ1i8X5BtSU3E5i3dGAxgTZ5AHxtk+jtLp1LilvAxBEhi92a2D0a6gevDiwcd+sgYKwx
	LcEcWtfpuzy0=
X-Google-Smtp-Source: AGHT+IGBlYgBpeRt9dQT+JeRalTDoWgn5PgI4JSFuOaHgqh8y6M/jDBUxrrdm73Fqvze9M5qDbxjCg==
X-Received: by 2002:a05:6902:2511:b0:e81:868c:5b with SMTP id 3f1490d57ef6-e81868c04dcmr6518839276.31.1749133473613;
        Thu, 05 Jun 2025 07:24:33 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e819ef076a8sm94086276.54.2025.06.05.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:24:33 -0700 (PDT)
Date: Thu, 5 Jun 2025 10:24:32 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard/queueing: simplify wg_cpumask_next_online()
Message-ID: <aEGooNws-KihCuWh@yury>
References: <20250604233656.41896-1-yury.norov@gmail.com>
 <aEEbwQzSoVQAPqLq@yury>
 <aEGAfy80UcB_UMYs@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEGAfy80UcB_UMYs@zx2c4.com>

On Thu, Jun 05, 2025 at 01:33:19PM +0200, Jason A. Donenfeld wrote:
> On Thu, Jun 05, 2025 at 12:23:29AM -0400, Yury Norov wrote:
> > On Wed, Jun 04, 2025 at 07:36:55PM -0400, Yury Norov wrote:
> > > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > > function significantly simpler. While there, fix opencoded cpu_online()
> > > too. 
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  drivers/net/wireguard/queueing.h | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > > index 7eb76724b3ed..3bfe16f71af0 100644
> > > --- a/drivers/net/wireguard/queueing.h
> > > +++ b/drivers/net/wireguard/queueing.h
> > > @@ -104,17 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> > >  
> > >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> > >  {
> > > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > > +	if (likely(*stored_cpu < nr_cpu_ids && cpu_online(*stored_cpu)))
> > > +		return cpu;
> > 
> > Oops... This should be 
> >                 return *stored_cpu;
> 
> Maybe it's best to structure the function something like:
> 
> unsigned int cpu = *stored_cpu;
> if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu))) {
> 	cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(),	cpu_online_mask);
> return cpu;

If you prefer. I'll send v2 shortly

