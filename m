Return-Path: <netdev+bounces-73805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3212085E747
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3232814F9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A885C7F;
	Wed, 21 Feb 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jhJBIYu6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CC83A06
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543797; cv=none; b=RgKiMODWUVWbYxe+d+8JJYLDfEeZdmIuZCktWQbIqbhjpRtE/9330TLD0i47a7J3bCaz8ZKINsWNyjXQmVE8utgA1O097zKSKWMlRwc4d/RaI9Rk+Sqx1DoXgJzvfKdRLDeYWt/r9KhpC6r3MdQGBMj5wy5WoQfr+6+MHIFHHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543797; c=relaxed/simple;
	bh=43X4YpzZH4v/vn1Eqx2F+XMhsGxh0Tln/FFKxX/JnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFoSriCYiqn7SW7t+Fys9KxFW6XHyu+pneR4HHssfeVWKJvGg/xPtxh8iF19yZY4kL1rwDpeAktnFUU1anLMdcXhksUycFEgBiqtx7wj5wFUSDQARq2O2mFnihfRpPZORG6Hi/fI0hHxBLNKDTVFINiDb/rJqv7pvitiHoFNL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jhJBIYu6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso2261463b3a.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543795; x=1709148595; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOVn5TYSq7Yd0cVO/zWwQ5H33DS+ESxqa50xaVlE/Kc=;
        b=jhJBIYu67dLcUjbENh3T32qDr4AMWLZZOD9RuhFJ4qJRGFA0FuYWLeXP7eXwu9I1Bm
         /NDEgki7pGmpndIL6ADbd9orjF2wS9YvspRi4qgiLdgvPd/0QxuXmqPW6omSo7G5eaT7
         ify7C0K/AFIZj4Jfyp3SpFK/cRVU03xhnaY84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543795; x=1709148595;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOVn5TYSq7Yd0cVO/zWwQ5H33DS+ESxqa50xaVlE/Kc=;
        b=vEJCG5RCQE+xn6gcGB2YwI5cU+oGt/Qi+lULRn98cmOCfwNdHWWUkNRWMayfmmZgeF
         54a38ogJaQ6EzFXLASG9nMOe/tFwr2I77c+O9qB5+Bt75Hg3yhhuctHMEmIUIN9Ejmto
         RySEa+JIZ3TScXT45Iy4Ri1svaCiaLIKXUKIeK8/drMNUw/D+bCr7do3sAB1Nd9sL1FI
         aQiEkRR+ONKE+FcDwUYDApkDHTgYVSQrjyzzDgj1ANiOzB3ef1Oil377aUxGS5KZikfN
         8NsFghQvNcSobOLnSwvkjrvHK0v/XS1LWP/d+qpxKQ7SkIqvFS0DmRaCMjQYlyjyvjbs
         rp0g==
X-Gm-Message-State: AOJu0Yz6EYNBooPB6/LQifP3DpR4g5bMhN6tPFQOIhuHFt8ei3nRFTDX
	qpNEr5d1GkjXH+rTtGE4vU6RtzKT/JkApKaE1y5wuu8TYlHZ1C+O7PA9Tyhl3Ms=
X-Google-Smtp-Source: AGHT+IHF8ZqCMtE9CiPKgIAurre13OC+r7VUoIWRBVeEkxEam/JrULm+6CdJIthPNg5+CCb8zrUgIA==
X-Received: by 2002:a05:6a00:9a4:b0:6e4:59b3:928c with SMTP id u36-20020a056a0009a400b006e459b3928cmr11375495pfg.10.1708543794969;
        Wed, 21 Feb 2024 11:29:54 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jw40-20020a056a0092a800b006e4c2ee6cb2sm563160pfb.29.2024.02.21.11.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:29:54 -0800 (PST)
Date: Wed, 21 Feb 2024 11:29:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Message-ID: <20240221192951.GA68878@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <20240221110952.43c0ae6e@kernel.org>
 <20240221192122.GB68788@fastly.com>
 <20240221112644.3d8c4c5a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221112644.3d8c4c5a@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:26:44AM -0800, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 11:21:23 -0800 Joe Damato wrote:
> > > For context, the reason why I left the names out is that they can change
> > > at any moment, but primarily because there are also altnames now:
> > > 
> > > 2: eth0:
> > > [...]
> > >     altname enp2s0np0
> > > 
> > > Most of the APIs try to accept altnames as well as the "main" name.
> > > If we propagate the name we'll step back into the rtnetlink naming
> > > mess :(  
> > 
> > OK, I see. I didn't realize this was a thing. I suppose what you are saying
> > is that we wouldn't want to expose names at all and stick with ifindexes
> > only, is that right?
> 
> If you think it's a major usability improvement I can be convinced,
> but yes, leaving the names out initially was indeed intentional.

Well... it is useful to me, but I think I'm only one user and the side
effects of adding this might have painful results in the future so after
your comment I think it might be best left out.

Sorry for the noise.

