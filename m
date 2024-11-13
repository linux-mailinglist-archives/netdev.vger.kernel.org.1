Return-Path: <netdev+bounces-144432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58829C736A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65173283078
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51B136352;
	Wed, 13 Nov 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7so6Gm2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD694C62E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507749; cv=none; b=KiLPYisD5piZUkLL2aWw1u7yndfGyR/nmpnfe3sya2sQh2JqVSNMXgsfIjliSvMldpgPQsH6/QGi2MEqJinYlZKpvlgkD2EpMwBnQXQk7R+/wW1+LzyZSCegcjIFshQLuAmSEgDeRppC2geOW7hN+aUSEv3nbbHBNiMzxdnUOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507749; c=relaxed/simple;
	bh=rSz5s+lFR/7j3AoPWRkF/xmDmXvldLwT7bIsTucDcSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCcqS4Qy3sqGHXUw32M7Rp+KiYes3Nhl3CS0vV7biMDCrwFjkRuFT43ZCOkTdecpdseszo4pnQe+/xqL5D+G3c+gl6opsQnUQ4+hDTtimE3fzsPHAdZjETf/tbgJnXH7HMVWveWEq9bETAa5UoKXMENK3OF2Vuxm5vx4cxY5Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7so6Gm2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731507747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mASqSpzIjCfOGjWWtMxMJjAa1f5QNiEn+kAbhz2hm6s=;
	b=W7so6Gm2L8QK1sNl2FXfJq4GcogcpEifeynFxGvqQl3Aehnq59Ei30nm/ICBScBSvEp5g2
	G9+qcr7qTGNpq+b5Zyy+nmR/wtlwR5sAM1RFPxTpbRoUtuh1zqiHj9g7MPyVg48dgl+O55
	ppXAH6ecM3eObSmHaZEfYTVrvsAkDjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-sRYLWHxQMea_wrdzY0MKig-1; Wed, 13 Nov 2024 09:22:25 -0500
X-MC-Unique: sRYLWHxQMea_wrdzY0MKig-1
X-Mimecast-MFC-AGG-ID: sRYLWHxQMea_wrdzY0MKig
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso49542345e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 06:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507744; x=1732112544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mASqSpzIjCfOGjWWtMxMJjAa1f5QNiEn+kAbhz2hm6s=;
        b=wcopqFTYpYrE98dYvVcEPMtU4dU7IVHsRqtoOKPlmRNEgarNM5a/TYXpceJ4+eNyQs
         qvclrqYbQVWvRVEOCLw27OVAUKpgHEjlwxdro4E5K98+efkQ94bC52gQ7XjAs+y4QsbE
         CuKCsfkgENmh0sdGvPxrsVKAZQK5h7AJDVW4KWivVWGRegWAw0W4iCYwHn1fWZ0dl81j
         5RTB9hESd6f2sSa2l8LGphiw6IruMNLvxeJfCxRMYIGevhOjx3XeqNn2oPHjSOfVOtHi
         0iVNMsALB+dd2padNHLQF9FOtP9PDU6PImALgfBUU7raeYqwrOYUZ7eAUzrVEDMiP4fb
         Z2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUTeY8EV9QYtd3866EpHUR1HXFnHOW7LWzj0NeOreDIxDjd67S5cq3D4ipyQnyHLCnsPeGZFmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofZHPBGFKRXnepuWLQ3Lm/RSBAodjCkZHIxQAcr54b2mnCmyx
	ZgqCHrBqalpHfi0TCPv7cO7blp6eitOTKmbA6l8xRBVpEp4/B3/n7EFzbrQjsGPRlE4TrRhWXT4
	FFTTj5uciXgZKGnInfZFC5SEETcXSc26Ep/FKZN+1o0VI4ZhgtSRU8g==
X-Received: by 2002:a05:600c:4f43:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-432d82d6b43mr10997335e9.30.1731507744437;
        Wed, 13 Nov 2024 06:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv0nIvk+mpeEA1hyRh0EsYUYVRpzKaeVOOE/+42qkI1tt/CHPMbYGzWsgSNQ+rY1caaZZZwA==
X-Received: by 2002:a05:600c:4f43:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-432d82d6b43mr10997095e9.30.1731507744082;
        Wed, 13 Nov 2024 06:22:24 -0800 (PST)
Received: from debian (2a01cb058d23d600736cb2b04c893998.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:736c:b2b0:4c89:3998])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99a0efsm18547302f8f.58.2024.11.13.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:22:23 -0800 (PST)
Date: Wed, 13 Nov 2024 15:22:21 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped
 counter.
Message-ID: <ZzS2HcD1hPTc3E/g@debian>
References: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
 <231c2226-9b16-4a10-b2b8-484efe0aae6b@redhat.com>
 <a6bd2ee8-c732-4922-9e7c-ae89a1ad8056@redhat.com>
 <20241112181518.3f55a359@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112181518.3f55a359@kernel.org>

On Tue, Nov 12, 2024 at 06:15:18PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 17:53:36 +0100 Paolo Abeni wrote:
> > > How about switching to NETDEV_PCPU_STAT_DSTATS instead, so there is a
> > > single percpu struct allocated x device (geneve already uses
> > > NETDEV_PCPU_STAT_TSTATS): stats fetching will be faster, and possibly
> > > memory usage lower.  
> > 
> > I was not aware of the previous discussion on this same topic:
> > 
> > https://lore.kernel.org/netdev/20240903113402.41d19129@kernel.org/
> > 
> > and I missed the previous change on bareudp.c
> > 
> > I still think that avoiding the double per-cpu traversal when fetching
> > the stats could be useful, especially on large multi-numa nodes systems.
> > 
> > I guess it's better to be consistent and keep geneve and bareudp
> > aligned. We can eventually consolidate the stats later.
> 
> We merged the bareudp changes... begrudgingly. You're the third
> maintainer in a row to make a similar suggestion, which is pretty
> strong signal that it's a better direction.

No problem, I can work on DSTAT conversion.


