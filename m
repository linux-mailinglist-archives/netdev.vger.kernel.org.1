Return-Path: <netdev+bounces-129657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EA985335
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39617286306
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314A15667B;
	Wed, 25 Sep 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWFjb0Ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E1156875;
	Wed, 25 Sep 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246849; cv=none; b=e8rh3v7Lc7Mu1FvViiIQjpYTej1s9aIol+K+y6j2G7JBtbKJf8n+RN3nqeMc/nZY/3qnNezr9Erau6YNk1TKIQc5h/qO7zANw1U4+IQUZKrleWp/1D98SyZw9KoIbsw4Jo/GfP8aGFxp+enEjkXEKQm9fZvxLYFyWd+/ISSpYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246849; c=relaxed/simple;
	bh=mlLpvpU5h3KChIjhV43WoLH/do6/n4v6lSdzaC/4lso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAnaFxE3f5RZbswsMqrBcPgF5KlQ2xq3NGxQJj4sDNk3U7TriSZhaDRxgwgTCvoLrDCIlxXWMqh0Jyqh5ZdZxDmQmIo/fqrZGuKLUfc3BCnhA8xZ4KyYV/lCPoJxtG3YXdLq7MNrN5yDfqBaRKPEj0tBpE8M7FlHd9XLUMBYMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWFjb0Ih; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-710e1a48130so1976253a34.1;
        Tue, 24 Sep 2024 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727246847; x=1727851647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCvWjbZiRcFE7BpPuL1CRrnqJmD47+cwm4wsjCPkMsg=;
        b=LWFjb0Ih3/p1JVK+uQ5EZqyEcRrfQ8huffAJ1Bw0ghSyXixfMUsJ0iEGXOC4jWsZOS
         A/+JxGqlK+1MZT+1GInYzcDFIID3KKBAuoncOqvc3ky9knojV0a8Nh/uJjneOt8HeeN/
         l+ErTLAXobOJrHwWGKHEk8P6SP/jolweMoByV4NZQhsAeqf4NImy6S/inB+bJKjJtHcb
         bjKGqOHlvlqGZhPc7YXgCoxmrI6+I/uxAT/kdmjVfSnmLAewdHm9V4T75dgwItLa8+0H
         QobpnthWFYAuqsLr+8XxbXlvQSN5+SIZV4WhPyWjTQ65emafDOCisTEcUzsFav95suhA
         6X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727246847; x=1727851647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCvWjbZiRcFE7BpPuL1CRrnqJmD47+cwm4wsjCPkMsg=;
        b=hBr5XDArl6Kmx6GOXldDevesaDF7Ry+3AFn4HI7xe1E7XksmU92oL4zKKVzSRSM3Zg
         Md50Vwe9BIpcAbhZyXoP0TIW/Wi1HMz0OepcCkjsUQKL8pqD54MNsEdJ5us0N87NYWsJ
         ENLSUN2DZclG3d9/K5ssZYsBnAYDKIVHNEa9xVOA7aArP/81mEHvNa0B55D3TuxgNMtJ
         gPoRNidmSQlu9CZzWdpSBtLyxGcMo+Am5shM/draOQI47w+JfSZZlPAJkjKjxQOY4SUG
         SqCnYAv3SG3Cdj38K3tPXoHSkVISsTbBWRgr6Sn/ynnA8wpdlZhkBG9/M7rp4p8v+qT+
         sqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwsMvmCmw7AcahYCevFrBxXUUVVD5EEOg+tulk8vLAlXE3UEqkRiibRIUgykF3dmkZULmIP51uwg/fCeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49FG0KDra8smJ6ktkuT8PUaHWEKNphlnl2YdCh+eedREMH0Rf
	9wGd+1CyARV0cI0OaKBxjWoCWyxDVN0gENi3Uv3LDl9I5DXsbumY
X-Google-Smtp-Source: AGHT+IGGCHgPFYaz/jOqIrSzxFOksYsAEteh8NXeHjhHP620RTIPIg+t8iMXK80EB71cmuYVzWr5gA==
X-Received: by 2002:a05:6830:6d12:b0:713:722c:835f with SMTP id 46e09a7af769-713c7dc411emr1431074a34.18.1727246847368;
        Tue, 24 Sep 2024 23:47:27 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e31a006sm733263a91.55.2024.09.24.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:47:26 -0700 (PDT)
Date: Wed, 25 Sep 2024 06:47:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jarod Wilson <jarod@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Bonding: update bond device XFRM features based on
 current active slave
Message-ID: <ZvOx95zrrKonjTPn@fedora>
References: <20240918083533.21093-1-liuhangbin@gmail.com>
 <1b507e18-24a4-4705-a987-53119009ce3f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b507e18-24a4-4705-a987-53119009ce3f@redhat.com>

On Tue, Sep 24, 2024 at 03:17:25PM +0200, Paolo Abeni wrote:
> 
> 
> On 9/18/24 10:35, Hangbin Liu wrote:
> > XFRM offload is supported in active-backup mode. However, if the current
> > active slave does not support it, we should disable it on bond device.
> > Otherwise, ESP traffic may fail due to the downlink not supporting the
> > feature.
> 
> Why would the excessive features exposed by the bond device will be a
> problem? later dev_queue_xmit() on the lower device should take care of
> needed xfrm offload in validate_xmit_xfrm(), no?

I'm not very sure. In validate_xmit_xfrm() it looks the lower dev won't
check again if the upper dev has validated.

        /* This skb was already validated on the upper/virtual dev */
        if ((x->xso.dev != dev) && (x->xso.real_dev == dev))
                return skb;

Hi Sabrina, Steffen, if the upper dev validate failed, what would happen?
Just drop the skb or go via software path?

> 
> Let segmentation happening as late as possible is usually a win.

Yes, indeed.

Thanks
Hangbin

