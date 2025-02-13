Return-Path: <netdev+bounces-166019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F4A33F2C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C53188D1B1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F922156D;
	Thu, 13 Feb 2025 12:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA13221571;
	Thu, 13 Feb 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449765; cv=none; b=edZ9qqS4txttSyLoqhXK463BHfAsxzhqFt3gvJS45dkH2m399Vgz2kD/kK6S0WeUcv1PcyRke86odXfMrn0xpIkTrQtefBah+1Qe6GtKvepsbpPauw+ZzfD5nIx3f5lgir4agJlZFgqTrCT+8iYPPjraAF8XJYmmfVN5cq4KQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449765; c=relaxed/simple;
	bh=jk00WPfjJdRWwtvttDxvBjbhGSoB2MNZaLTlNQA5q0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvf5n4n4o4fgWhNsWqEIBFAy71wZzqhyHLd0S88zRj6NX7fWFQaj+PYQJI/gg46kPSLDISlq8LJnZv3gr0IW8gt+0NwKj8ljrW/J3a/Tdlshi7lFB34C1+Ybdb2i47WuRwduYV7XTvjnknTcGjNn8MGWnaEd4vh9wm8hj0w5Voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so1271675a12.3;
        Thu, 13 Feb 2025 04:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449762; x=1740054562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgbbSoqNFmU6PToV+GxUdXGITf/t3e7ENN5LNLiqK/k=;
        b=j34ZLAaHXdX3Igo7NlWvKBIia4dHvfvgnzbAwsgcYFmsqctTD2Myv9KBxYiiu/TAOO
         hdgzuOBlLw46AFfHwmMultch5poUbUVR7TN9GLKNlVzstnuwp3go9gBIKCf33o09VCR5
         KY6FUWz/fgsoSvpWAbIyYF2Q4wQ4fjlJwozJxKKKWXBN53wVIA8oEe+zwizEQTZP8Rbl
         jlrdYvQ/UNlJiVjj2/45mpxtji19H7K2zsYgF7tilBTQao17pJHoeRmSLVgiUo1wJcjH
         KNKVuEzpUbcWUxBYaoRaYb1UDraWNus7UDZNPay4ju8iaGoliW+fVk5dXTScxG2ldGCh
         1VdA==
X-Forwarded-Encrypted: i=1; AJvYcCVBS3IjkSKCRu1tIEbOczoMFsZKCteeFbJSW2LXUfW2zo6EU/zh3+h/QyaQVZ7+fKsfR155wtG3@vger.kernel.org, AJvYcCWOZ3/wiaBWhIBrfIaczvBFjDYCyDvddDl/C5d7YKSrNCizrW3tlOKIH3qCgwPShQYG99zVJeWf8Hax3Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEbgnQ8VfjVHScfHmd2MoLFn3kGjQMXuyd+tBaoI0wQEUYm+r
	cx9WJPpLHtez3a1iDMXV/PDZx9UZ5R39+O356uY8X6BbcuhwsASXAyAaIQ==
X-Gm-Gg: ASbGncuplRtohvhDIXFP4kBwIVC5ObwkjyUL2wTxE/GrdTUV2sMoOdlbV3o4Jbws2Tr
	cyMpo/hWpJvSdBxXSFtV9O3Q9ZujpW9LWB4I1fMtLDHu0V7c8F55nWg0J23WL9RQZBoI9x2jRZt
	1nW5TeDj4CNvfxhURp2F+zvRzHZfebe07vKQK9caOt46EMvsTAWLMZO77pJ9vjNZYwLkkKx1D9L
	1qe2JL402VRmkGpP0/wGY8GOENYUHYj+nys6XXfAzuw41oDo7TgcpQsxn+KeOTFc/wzdD58VTSG
	8ijhng==
X-Google-Smtp-Source: AGHT+IHlD7EZ96Fa7vEuM/9HfDXXGjQewjt4jeNY1VIxvsQQjy2gdZAqHyHU0camMc4QmRQiIy2F9Q==
X-Received: by 2002:a05:6402:5203:b0:5da:d76:7b2e with SMTP id 4fb4d7f45d1cf-5deadcfc25cmr6837787a12.0.1739449761469;
        Thu, 13 Feb 2025 04:29:21 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287e2asm1085490a12.71.2025.02.13.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:29:20 -0800 (PST)
Date: Thu, 13 Feb 2025 04:29:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
	kuba@kernel.org, kuniyu@amazon.co.jp, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, ushankar@purestorage.com
Subject: Re: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250213-accomplished-chamois-of-vigor-b324af@leitao>
References: <20250213-prudent-olivine-bobcat-ffa64f@leitao>
 <20250213105217.37429-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213105217.37429-1-kuniyu@amazon.com>

On Thu, Feb 13, 2025 at 07:52:17PM +0900, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Thu, 13 Feb 2025 02:29:38 -0800
> > Hello Kuniyuki,
> > 
> > On Thu, Feb 13, 2025 at 04:31:29PM +0900, Kuniyuki Iwashima wrote:
> > > > Subject: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
> > > 
> > > s/_rtnl//
> > 
> > Ack!
> > 
> > > looks like Uday's comment was missed due to the lore issue.
> > 
> > hmm, I haven't seen Uday's comment. Didn't it reach lore?
> 
> I saw the reply and my another one on lore but somehow they
> were removed :)
> 
> 
> > 
> > > From: Breno Leitao <leitao@debian.org>
> > > Date: Wed, 12 Feb 2025 09:47:25 -0800
> > > > +/**
> > > > + *	dev_getbyhwaddr - find a device by its hardware address
> > > 
> > > While at it, could you replace '\t' after '*' to a single '\s'
> > > for all kernel-doc comment lines below ?
> > > 
> > > 
> > > > + *	@net: the applicable net namespace
> > > > + *	@type: media type of device
> > > > + *	@ha: hardware address
> > > > + *
> > > > + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> > > > + *	rtnl_lock.
> > > 
> > > Otherwise the text here is mis-aligned.
> > 
> > Sorry, what is misaligned specifically? I generated the documentation,
> > and I can't see it misaligned.
> > 
> > This is what I see when generating the document (full log at
> > https://pastebin.mozilla.org/YkotEoHh#L250,271)
> > 
> > 
> > 	dev_getbyhwaddr_rcu(9)                                                         Kernel Hacker's Manual                                                         dev_getbyhwaddr_rcu(9)
> > 
> > 	NAME
> > 	dev_getbyhwaddr_rcu - find a device by its hardware address
> > 
> > 	SYNOPSIS
> > 	struct net_device * dev_getbyhwaddr_rcu (struct net *net , unsigned short type , const char *ha );
> > 
> > 	ARGUMENTS
> > 	net         the applicable net namespace
> > 
> > 	type        media type of device
> > 
> > 	ha          hardware address
> > 
> > 			Search for an interface by MAC address. Returns NULL if the device is not found or a pointer to the device.  The caller must hold RCU.  The returned  device  has
>                         ^^^^^^
> This scentence starts from a weird position when we use '\t' after '*'.
> You will see it start from the head if '\s' follows '*'.
>

Makes sense. All of these functions on that file is misaligned.

Having it aligned will add the section under "DESCRIPTION" manpage
section.

