Return-Path: <netdev+bounces-165954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87713A33C99
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B427188F73E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184E219A95;
	Thu, 13 Feb 2025 10:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F38219A8B;
	Thu, 13 Feb 2025 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441803; cv=none; b=oY7sHJek6c4maQ1OgjkdO0KDuySq1PLLICo0Ite2L86yibFFnUj1xfn3gDFuEVFgwtnltNrqIpmKU5y3svsMJxK8sl4aSB3ZRIX7QKhUrIXFWE79DJW6Kns/dg4XcYDp+Fu07kgIj5/lns2m/BxItY+Zr2ezKkbtyNNNNgEnt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441803; c=relaxed/simple;
	bh=zA9d9gT4g9Tt3Lvb75vKHFhoyfPzrVq1krr7Du+1xjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URpxWY3sdtnZjUrKSfOnsb/ZtySo4/aAJQ5WL2T1liVOgPtXiszfZMDSlJzjGEwKSAKTuncG/H0s/yOyCdabcqg2ZWNSst2z3auWTKFU5jtPccV4k9Ngv0/lGAETX94BBKofMxjhmz73gHndo1kt/2i5E8Ww5hWa0bM09SjeM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso138943766b.0;
        Thu, 13 Feb 2025 02:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441799; x=1740046599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY3BpgsmGybHCIcIxGp6caLtrhAoBfIK+U+jcsUKwBE=;
        b=Ds/Eec/gmBYgww+T5bMLI8Jh0ruxPiaISHuyW3IyitJtM8JnUUSLxDOcGNuZVOfsm4
         MMq2fQU0TZrjVD2gNTd76UiELlhCXcp6rHLbk6SqyYo9dPq74t/kQCv5hfgdHexYkTZz
         jm6W/A68bqFn8SvLOzuWkp1eHv3UglZq6Zyb7riBxw2VWY1I1TPq69ThlBgr0sC+U4dL
         rNMafbdGXAdpbpcknYC1WsZnL3HxbrSo0h4uCVsTgv3px2s0uS0KZffLbDUt7n8MDpnq
         bPlUqTQPZ5ml4FeG82EB4v6fBA/8lxvRrOlTj5Lb0cq1VZXlJ2o06DVgeaLTrOZcksUD
         jXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTLtROGBFexlWVy5MRZENk5Uih3OuAikP08/k2Lp5wv3bZ0Ia6Rnlh4O7kmDG7Pv2AesmbofxRO24gbcM=@vger.kernel.org, AJvYcCX0jsQJ19XncE9XKfjbU5P5qkTzfAtMWIcog5/ocIQKepXUYKpPF/1j3QLfzKUEH76df18M8XZf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk04IliB5iDvNKna3E1O15iClK4t4pOCq6mfvGH1bS/EcormIx
	fijn3Jxm6r3G4vZ8EYzL28zWEOkGDcI57yeD9n4Ksh0gROkfUHEb
X-Gm-Gg: ASbGncv/TIRFAgXV2tfDGI0LKvPLBXZCoXqbXGL45q0avues8vys580m6Lb0WI8emwJ
	PPisnlc8m0uMtPSbUavcgrZxh/wXYYVFpINIka/Vieo4BY21k8Lnt01lo0W+X+4po97PXD0C3US
	ZdJWq7FH655kTBHb2vI4psMJEBm+oIP+E+Leck7jb91OwQUKoxAYD877l35wBk62uojrvW6cUtd
	D3YR4iOD3bozSvJJEDb9ufXmFU1TO7MsB2QZrl07S9hibWafs7HNNNxrT9nUIGWylUeBh4e8+4v
	x6a8MQ==
X-Google-Smtp-Source: AGHT+IFK5rp9NhV5zaEVsy2IvOjKKd5D5sQXzWwTqZY7R2x3CwoFBJ3GXyVkM7BQHtWFQXtI0eF5fg==
X-Received: by 2002:a17:906:fe02:b0:ab7:c11:a980 with SMTP id a640c23a62f3a-aba510aecf0mr192945766b.17.1739441799171;
        Thu, 13 Feb 2025 02:16:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf55bsm99631566b.184.2025.02.13.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:16:38 -0800 (PST)
Date: Thu, 13 Feb 2025 02:16:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
	kuba@kernel.org, kuniyu@amazon.co.jp, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, ushankar@purestorage.com
Subject: Re: [PATCH net-next v3 1/3] net: document return value of
 dev_getbyhwaddr_rcu()
Message-ID: <20250213-kickass-orchid-wildebeest-3ec3ae@leitao>
References: <20250213073646.14847-1-kuniyu@amazon.com>
 <20250213074748.16001-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213074748.16001-1-kuniyu@amazon.com>

Hello Kuniyuki,

On Thu, Feb 13, 2025 at 04:47:48PM +0900, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Thu, 13 Feb 2025 16:36:46 +0900
> > From: Breno Leitao <leitao@debian.org>
> > Date: Wed, 12 Feb 2025 09:47:24 -0800
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..0b3480a125fcaa6f036ddf219c29fa362ea0cb29 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -1134,8 +1134,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
> > >   *	The returned device has not had its ref count increased
> > >   *	and the caller must therefore be careful about locking
> > >   *
> > > + *	Return: pointer to the net_device, or NULL if not found
> > >   */
> > 
I am a bit confused about what you are saying.
> > I noticed here we still mention RTNL and it should be removed.

I have no mention RTNL in this patch at all:

	# git log -n1 --oneline HEAD~2
	6d34fd4700231 net: document return value of dev_getbyhwaddr_rcu()
	# git show  HEAD~2  | grep -i rtnl

> I missed this part is removed in patch 2, but the Return: part
> is still duplicate.

This part is also unclear to me. What do you mean the "Return:" part is
still duplicated?

This is how the documentation looks like, after the patch applied:

	/**
	*      dev_getbyhwaddr_rcu - find a device by its hardware address
	*      @net: the applicable net namespace
	*      @type: media type of device
	*      @ha: hardware address
	*
	*      Search for an interface by MAC address. Returns NULL if the device
	*      is not found or a pointer to the device.
	*      The caller must hold RCU.
	*      The returned device has not had its ref count increased
	*      and the caller must therefore be careful about locking
	*
	*      Return: pointer to the net_device, or NULL if not found
	*/
	struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
						const char *ha)
	{
		<snip>
	}

	/**
	*      dev_getbyhwaddr - find a device by its hardware address
	*      @net: the applicable net namespace
	*      @type: media type of device
	*      @ha: hardware address
	*
	*      Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
	*      rtnl_lock.
	*
	*      Return: pointer to the net_device, or NULL if not found
	*/
	struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
					const char *ha)
	{
		<snip>
	}

Where is the Return: part duplicated?

Thanks for the review
--breno

