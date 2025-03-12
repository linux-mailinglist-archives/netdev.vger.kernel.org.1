Return-Path: <netdev+bounces-174116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF9A5D8BF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509713A44E0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796323644E;
	Wed, 12 Mar 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQn5UuUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537E235C16;
	Wed, 12 Mar 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769997; cv=none; b=hxXXenX4hftSD+2QPXk/p/cOC8kK2LOB5l9AUarlD1wlatOUmQL5GSLQKSl5zK1W0I0EHC37oKv/ocv85lUc5+8m/2r7DdCEP5nT9qDGzrH2+kl3o2zrwJjichMOsdQcU9HWKCaVaHVJ6lVfobGe1Hcwea7IkhN+uRGrkyIzJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769997; c=relaxed/simple;
	bh=C5BIodldeesg1NguClT2B3nnv0J2dFaCy3HVWztM/EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwUUX+iDk4cUKLjtdV1PQLZlQVj97MO1zegKa9xLy+29+XuY0eJ83pvlyOSDXUuVmnHLcELNGAqiSzPPdnVCUrE7h0h+JEsNhWH++T49UrV3KiXf5t39kh3L3Hx8twcjjsmhqx06fjCaOwLM1ezNL80XGLSpAtlPgDdsjlfHrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQn5UuUv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22349bb8605so120068445ad.0;
        Wed, 12 Mar 2025 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741769994; x=1742374794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLjvAC9VadvURn5Ux6ZjZ6iTF/ZbVpdU4qEAD+HtQq0=;
        b=MQn5UuUvErSqPYtNbZAxc6Qy3mOyeLvbRZfLnKmFettiALNyf7SvgXRkHdKoPzbrJr
         089PtMJ/VQ76R2GXuyFcEaXicTcsDIVLej7TZ7yL0NZXVWEvzjHuOKIMkmnyso/YYBxg
         ix8NNZy2etKw7KuA4dEOb3dGo6Viu3uWx5l+/jKEprPk8n/ER4zsULAB31oVhW99wBFN
         lg6sQWWFYKFfbb430MvoKrIx9VEpawFZg9pJfEPDNO2Os6LKiDsjaF8UAs26rO5QJ72B
         caU8bw98APfs0bizTQ0sexwhMsXKMbmPtzAfw/vi5wRrblmsr60YJMYlCiHIZmuPDRXZ
         YNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741769994; x=1742374794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLjvAC9VadvURn5Ux6ZjZ6iTF/ZbVpdU4qEAD+HtQq0=;
        b=QvPRd85Wfowd0DYz3YCY3M43tCiarKES7d/a0gu4Z7HCrPFWS2udjgaBFiKGMUp1FB
         V4Izb1XK7MqEFhQBBp8k4BcUVfcn96TvZdcr0YdpKNEkZsFLd3peaXn6IWlkJH/dbbQZ
         3UsmcFgvbw7nQ1JHJxz8rgini1JJZiNfY9h0dQ3/dNzBk3cbhY7Rud0DxWix7U/2J/ge
         2WyDx1p6rBTAWrxUj/ai8UB4wRcYVURFfDSlTB2LqJJ/9jKYLuao4vFCu78BNjP05DyD
         aE/DaGrGlnAVVm7GmNnG+dZOinFZyZCgdlagY/3E9JbsihNaIutBhI6C9rOonApQkcZg
         4u9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+vFUqX6FuwYP7w1JXIZnmvzCsDQ8CSbLQFbi+Tigj3JRwlM91RM0XoLmsw3wp/kAjmDmyAqaV@vger.kernel.org, AJvYcCV/4UsuaKYRnSiNs9gYZtPJWWU6zSP9WkShZBE7WdsBd7fOAZ8mTksoqsOjOTTiDA5rgA7WNQnQ4drSJD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGldrK681+jJ/j2+p4XQgArZhBxiapsmk33P/lYbybhFnnmSF
	90HsHorizhnL4XAbB9nMTa+0+yhOYA4OSvAvMvJwk5fi4D+Weww=
X-Gm-Gg: ASbGncs7lAYb+VJgtj7GjQPRxjQSv97vzP6LsN8RjvwXs1/2vOpRdxZeAUfAEYERhqD
	cNGTLWNOv/ZiLXh7yIQ4qLu3GqCzkdp0I9fTaW7VmfCNZwMWcDgFNGT115bxKQ4CSrsdnXooaEK
	7AGfDGJygSA4K3eg+igqbgwyJth+fkk3cxAwZucJAF66wHzYl1RlLQAZFqpuF+LOwigA29MHS+t
	t+ZYkUvmG3+rzaqnGLYWNdZcpqJnS/vIVuKcmM1hjWmR97mpzYjAPRjRmULlBcZa+PC8q897K6M
	KoQ2Md9iY4f8lr8hcs5rCj2qRvy4Q6pxStAHjvVlFInN
X-Google-Smtp-Source: AGHT+IFCWnFcsw9a3Z1Y4ByIia/oIl1baOMWJlJ6pclruk4c3FJa4krYzBdeJWhSQ97nq8PSDFwQfQ==
X-Received: by 2002:a17:902:cec7:b0:225:ac99:ae0d with SMTP id d9443c01a7336-225ac99c10cmr19869965ad.10.1741769994450;
        Wed, 12 Mar 2025 01:59:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410ab9b7fsm111010025ad.253.2025.03.12.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:59:53 -0700 (PDT)
Date: Wed, 12 Mar 2025 01:59:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: sdf@fomichev.me, andrew+netdev@lunn.ch, atenart@kernel.org,
	davem@davemloft.net, edumazet@google.com, enjuk@amazon.com,
	horms@kernel.org, jasowang@redhat.com, jdamato@fastly.com,
	kory.maincent@bootlin.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/2] net: reorder dev_addr_sem lock
Message-ID: <Z9FNCH5_skuEBYGl@mini-arch>
References: <20250311084507.3978048-3-sdf@fomichev.me>
 <20250312022757.69200-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312022757.69200-1-kuniyu@amazon.com>

On 03/11, Kuniyuki Iwashima wrote:
> From: Stanislav Fomichev <sdf@fomichev.me>
> Date: Tue, 11 Mar 2025 01:45:07 -0700
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 9355058bf996..c9d44dad203d 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -3080,21 +3080,32 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
> >  		struct sockaddr *sa;
> >  		int len;
> >  
> > +		netdev_unlock_ops(dev);
> > +
> > +		/* dev_addr_sem is an outer lock, enforce proper ordering */
> > +		down_write(&dev_addr_sem);
> > +		netdev_lock_ops(dev);
> > +
> >  		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> >  						  sizeof(*sa));
> >  		sa = kmalloc(len, GFP_KERNEL);
> >  		if (!sa) {
> > +			up_write(&dev_addr_sem);
> >  			err = -ENOMEM;
> >  			goto errout;
> >  		}
> >  		sa->sa_family = dev->type;
> >  		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> >  		       dev->addr_len);
> 
> Can we move down_write() and netdev_lock_ops() here ?

Should be doable, yes, will also remove that up_write from the !sa
error condition. Will do, thanks for the review!

