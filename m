Return-Path: <netdev+bounces-123846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D1966A8C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FE81F22E2C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD51BCA1E;
	Fri, 30 Aug 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SpnuLfaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABD166F0D
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049891; cv=none; b=r/lhsqVDSzB4zMdBOAc7uYW+XUQzOm9YRhtAWL0qq4E6zzHZUxhGVfzXdR8CQmrmJs8YfVhd9+ZbeLcQK1VvLUcFRHWHxz1QsuRkFaDvadZLivmOkQenwE/x86Ee3t75oPPi6DvJRwNxwiP10PZQdP0W8IXbz85qwYJIXSmUAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049891; c=relaxed/simple;
	bh=duAltOdsgfQD8thkd3ezFvbCdFABgGybOeptMJvcT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrKQqYrtqJNAc9ET+epfWlSg5F2KImMBxG62Eo76cnVpWnlyn6D5w7PfLVFjzMTc+d0QcufsfNo0O74WDoyP9I1GI6T2Y1m8BBuXdRiLB8jSxnF+ksr4vr1aVgKvt6l6Pxh9bwxZ9SxSLOQ5OacDKfgQm0ngnjuHB6bCgO48JPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SpnuLfaJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so7934585e9.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725049888; x=1725654688; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QfOXme3vatBCFk9y/wc89nKqSgceIx60bJEIHC1dMA=;
        b=SpnuLfaJks5+W/a3oGkzxgYl6nEn3ZyyZqsFM8a2lqQUV+3R524n+MOyIEjzYGq724
         ihK/EtExoL+XlIuoqCN/6WAUnvytxZ4pQT+CnHgn6txkE9BiQN53sB8m74cZsA0DwpTB
         oh9PV5m2OlLszW4vvyNHZ2Y1aUDoOGtXjiomA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049888; x=1725654688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QfOXme3vatBCFk9y/wc89nKqSgceIx60bJEIHC1dMA=;
        b=QUgrPKzrWdodKQl2jSlb/m4KBhKuntMh9tOTlSVpdvLoMjdMyLUV/IvTz+OTpMOp3B
         p15Fq2BOEQNUsrI/VXTIcKUtako2lcVf9b3fdeg4okkBjDligx0auWgCglDQRICWGBcp
         FH4YDBGXRKqXpIql56H+lQnqthZADsZEgVprqYAFYDEKCt9pH8dIooWhYaXFnOB0uX9Q
         63FBpI2rGNUQu0UiNSNpQgAb4hSBKk4PDyN/62c+gT19vwSzQa5Tx3mJ7x0OCkU7rOqp
         xqt9eTxTvlIvkKoYHbX8GXb68k9ZVbBA39klLJPUCfLczVrY0hZYJqza2PqON+cNqHwa
         1/pg==
X-Gm-Message-State: AOJu0YyGzEiMj0HDjPh9Bl1gZR9hw0eBa86jxTmApK6jSrhNy58KeNME
	RQEVS6neOYRmLcQ20+Qn3XjVT0PHcc3GBo7lxJ1ETpCp4Wtw/OeJ7ZVRQjYosyE=
X-Google-Smtp-Source: AGHT+IFS1PDkb/7iWWHj7TVynk4b13F/aajIx1rxFhxFoWni4dJxmJGkE24chBK9X2DQkNeiXJqyZw==
X-Received: by 2002:a05:600c:474c:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42bb01aa1fdmr59120375e9.4.1725049887308;
        Fri, 30 Aug 2024 13:31:27 -0700 (PDT)
Received: from LQ3V64L9R2 ([185.226.39.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639687csm89281335e9.8.2024.08.30.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:31:27 -0700 (PDT)
Date: Fri, 30 Aug 2024 21:31:25 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <ZtIsHQoAEk1wfq0P@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-3-jdamato@fastly.com>
 <20240829150828.2ec79b73@kernel.org>
 <ZtGMl25LaopZk1So@LQ3V64L9R2>
 <20240830132808.33129d22@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830132808.33129d22@kernel.org>

On Fri, Aug 30, 2024 at 01:28:08PM -0700, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 10:10:47 +0100 Joe Damato wrote:
> > > > +        name: defer-hard-irqs
> > > > +        doc: The number of consecutive empty polls before IRQ deferral ends
> > > > +             and hardware IRQs are re-enabled.
> > > > +        type: s32  
> > > 
> > > Why is this a signed value? 🤔️  
> > 
> > In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
> > feature"), napi_defer_hard_irqs was added to struct net_device as an
> > int. I was trying to match that and thus made the field a signed int
> > in the napi struct, as well.
> 
> It's probably because int is the default type in C.
> The choice of types in netlink feels more deliberate.
> 
> > It looks like there was a possibility of overflow introduced in that
> > commit in change_napi_defer_hard_irqs maybe ?
> > 
> > If you'd prefer I could:
> >   - submit a Fixes to change the net_device field to a u32 and then
> >     change the netlink code to also be u32
> >   - add an overflow check (val > U32_MAX) in
> >     change_napi_defer_hard_irqs
> > 
> > Which would mean for the v2 of this series:
> >   - drop the overflow check I added in Patch 1
> >   - Change netlink to use u32 in this patch 
> > 
> > What do you think?
> 
> Whether we want to clean things up internally is up to you, the overflow
> check you're adding in sysfs seems good. We can use u32 in netlink, with
> a check: max: s32-max and lift this requirement later if we ever need
> the 32nd bit?

OK, u32 + check for max: s32-max seems good.

Is the overflow check in sysfs a fixes I send separately or can I
sneak that into this series?

