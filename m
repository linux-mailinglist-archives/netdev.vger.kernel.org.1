Return-Path: <netdev+bounces-117173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11C94CF6D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FA282A97
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8945192B7F;
	Fri,  9 Aug 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wU0mDI/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB515A848
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203569; cv=none; b=lzn942D+7lWqKQyELYxc3+uucB2MrKBvnwQTmb9vAKINJX7sWEcuFAGl4h/buhD0uNEAxDK5VNxPFczyU+vPdDGgmh95Q+OXjM8mg6D5OCSCZyYmB9JrM8Hzuw87SpqvmKbtDMfMF3q38eQ/cjD/JwTeDeSr1frJ3js6EW/QA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203569; c=relaxed/simple;
	bh=1vtrmlz7LG0i08gGFbJgBtm9QpxyFgIa7+Gft4iulic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7ALMIysJKS5BR9MGr7Xhnh9XSQCFxQb4ET7hOi9xe6dpfceP+hkEe6V1th7ANjemfEIm3qjcTVIglZTszcx5GFK1f7FHSl7z+76hWQLu5nY21b9ag0zObZ2w6g9/PenKwBXwSndnTefbKH69Rr+1J1C+ttUcPSMv6nXBx6sujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wU0mDI/g; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso19858371fa.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723203566; x=1723808366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EsvCDemZ8cFV8PHJ1pM3LhSvUqxAf8r/JBr2zVQBK0=;
        b=wU0mDI/gYCGaaSVB3RNPyua7ZOhbFmRgTnwbdG8kPZgQM+nyTOevCiW+Y9xc/T6IBs
         81gDpN6K+q0ZmM231G9Wu7xEMQ5g/98XDfvfb1meIHfoVeXqEcD4dg80jQMgYgCNQ2Wj
         c1zmhF2mgbVqr7Ae6+Ca3X+PwkRSR9+vvGkXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723203566; x=1723808366;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EsvCDemZ8cFV8PHJ1pM3LhSvUqxAf8r/JBr2zVQBK0=;
        b=jyp1IXSxJUt6u8hfaKjjPTWHQTYSVWtWg5hMMuoD8CL++QSWMljZsf+UOt7jkeZNTp
         kzIMwP/C6lF82hLt95vkqfOXqAtggtbfLTTcjOoTFjV/xKQduOFZdtv0R2MBQ4sCFXOZ
         Mjjg41fP5cph+eaIy3Zr3QpL7U93iUsIVSe3WiPAOv93epat/j57tstssFSAaOD5sTbg
         QOyEMvTV02/7ZRuFwg7qQykeJBv5NaLIW0vlTbh/1aRkvj++Eugnc8XiukbndNYY8d3t
         ENDpBGNu7r+TW2JDqNnZVAE+2KDCUo/bkgPvNkJV3R+YkmbYLxvbp8TTJQxHN9NeCc9u
         L0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXI0ucZtyp+fmlhu0QRBItqFnl+1Yfud5NI8i9tJS6hnDFvxWFH4s7js95gkHFvwkW+f7wxcuvmRkY2eLmg2IC2QK1R2vU3
X-Gm-Message-State: AOJu0Yz3S2i5Nt+4yu96ZsLEo54c7P96qH37uOLVeVPYG4roX6wG2Jol
	owNEVLbqpsHUk4dK+ofbJ+5nZuKr+mIbzXVLhoNghVS+UXEfWBK6GFyVcE7szCk=
X-Google-Smtp-Source: AGHT+IEW0wLi6UoV+99ReHz4077RBGQtVpGyjBFWtPswQbmK1j/63A9F7nfCmhTCBb9CbOXjMkF8dg==
X-Received: by 2002:a2e:a90a:0:b0:2ec:56d1:f28 with SMTP id 38308e7fff4ca-2f1a6c77421mr11871661fa.26.1723203566049;
        Fri, 09 Aug 2024 04:39:26 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:e0fd:455e:7b48:8d39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e250983sm25156661fa.82.2024.08.09.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:39:25 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:39:23 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: add basic rtnl stats
Message-ID: <ZrX_6zSU-SWYTH7o@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	alexanderduyck@fb.com
References: <20240808170915.2114410-1-kuba@kernel.org>
 <20240808170915.2114410-2-kuba@kernel.org>
 <20240808101451.705d2ec0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808101451.705d2ec0@kernel.org>

On Thu, Aug 08, 2024 at 10:14:51AM -0700, Jakub Kicinski wrote:
> On Thu,  8 Aug 2024 10:09:14 -0700 Jakub Kicinski wrote:
> > +struct fbnic_queue_stats {
> > +	u64 packets;
> > +	u64 bytes;
> > +	u64 dropped;
> > +	struct u64_stats_sync syncp;
> > +};
> 
> Ugh, I missed init for the syncp..

And... I apparently missed that in my review of the first version,
as well :(

