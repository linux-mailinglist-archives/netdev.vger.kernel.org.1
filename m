Return-Path: <netdev+bounces-242132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFF8C8CA5A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DD414E1524
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E524EAB1;
	Thu, 27 Nov 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaHC34bZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770E24503F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209704; cv=none; b=MoFQZ3LT58wzSx45z9yjAOA7HEebwvqwAxgL4+qCmAygjoBUGYEE2KwMmRvuCvvcSpxyGPaQnMfs1x+v33o+rvzINYYRMvXVEn0OzihJXsd/ohLMe6VNsZ67yqVDBIyVg2j76CvxjRNdUvzufkbDkP7mvLXQwkHYFMqJaAQrGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209704; c=relaxed/simple;
	bh=HVrPNch6ikTpkbwcWA+Tos+qAcBu0frEnSEPkijFoH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkSRph+j+7PYxkcmt7CKoKSECThOz3cbvVZA9IjvZLPRAuKUnNoTAq2njW4ksADbN8EtfB2PEKMFhf5JKC4NfbnI8jyio/x3Kbn5zWdjBCQidcc72fWjtGI1QjIGxUf1NojNJxPZ/VntX7EuOpOm1SM4fV3Vo4QUyoNWdcTVYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaHC34bZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29812589890so4637645ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764209702; x=1764814502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/28MY5aWAjcWw3A9TYhmcYLbzyACyYL7ufqOSdgOIw=;
        b=LaHC34bZsqgOV0yxDpu2EdcynOWUqhy6YUaV+wTNLuFeVEU2jAWDb/Sh6F8Q9bY8BX
         1ceT0nrOmDKn9YOrg/nId1Mw5WWpWABv+jYiyYtilKNxkQdkqY5BX1Qo4U1de56f2UpX
         5oSrMjvsc0h2+2kVxGCKK5eJlCtgD0oMuWKmH/ou0zf5O/kVkL7tAhQCxPmcTL3N/fOy
         RldN9+fqf+xbHRWP16MMa5stNkllYR4KDT6Us5t9GOxUkTO0M25u2+1nYVuIbkVzo3sY
         JwsYj1FSA1NJa3ROiVmTrj2+7fWg5wIF3zZSthCOUKq9niHkDiQlqrRwbw/Z+YOZP56L
         LHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764209702; x=1764814502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/28MY5aWAjcWw3A9TYhmcYLbzyACyYL7ufqOSdgOIw=;
        b=xImLf9zAmWKOC5oKqIIwM9oH2j6xEVIBMDgmmJ6y2kuc+nl96nucHKA5WWlLD277AG
         rt9AAhKUx2OjucSGhj/GNNTt8Z9U1iXs7x9z9Ciua1WAFfXg37jEsLBegCtxMv2dHtIa
         tVZ7S9mMfgBlRrG6j69TmfF9Yw8OenJAGLJUYGN353PIg6PCwXRTvtln47ULTqF12rCW
         sivrvHpgKBM0pqU7Y2ncLh8egnHrGlmvu54xQLs/pYXU6oVoPDB3OR+vDZnfJUSfsnNo
         OV9jyGKA/XM+7lcCRf6i2nYkMbw2jWfjKhs/cA8w0FEnaF+ZmkqQEXE8kYCeZ1sqshqc
         1o9Q==
X-Gm-Message-State: AOJu0YyyDekHoKXdqk8SzUbzJlrie30A+owkCyGKhUQnQ4lfMsYF11Wc
	62M+CzoVcgFVIIzJMXDCEa1s9v1MOY5Yy0Z7lYGciBn/EXW+G1LFOhkq
X-Gm-Gg: ASbGncvXucLhIlT85iWsCkLvNbkAD+nSNdruLDBmmxB8k9wkeUWPqI6q/d1ikH8XyFn
	gfKu6zzLqYeR7Hz3n04aqQNytS7BUUyj9236YbVPYLQfuLenOOAxOhjvtfEgdG3nz9TNGmdL6hs
	TO/Gjj3Zb7pSjXnV8nfHFTtLAMQGPkuI5ToCVvjzTcR7Zg+GTHDvyVMahFusv6cv+wkvOx5gJ6Y
	K+MFvGvxc3UmfCUeGzjeyFfhI6CJwDzxQnQeUHFmYzrkZ2bb4RGzmHI1SJk5Ze7AzWrPCDVADsq
	iWMy3Hc/FeobMDi1akWhkYmt+8g8sBuH14kx1r9KEC7KYVM2Fum9lmAxXxSC2w1e3v2AyIuuADB
	Uu3sBneb4NZQJn0Zn7Enttfo248+q1rl03aVV8nDTHKx5RavV6/+z2dXEjLFR72X211cUCnY9wC
	RCYREYhbzMBKUWNb8=
X-Google-Smtp-Source: AGHT+IEgeGe/ya4Bcej6t8UkjV1sFg/EdGs0YFqimkuWXFGwdaxz8NL5GR+pCWStJji8YwLE+c5UhQ==
X-Received: by 2002:a17:903:98d:b0:297:fec4:1557 with SMTP id d9443c01a7336-29b6bfaf6c0mr222303575ad.60.1764209702305;
        Wed, 26 Nov 2025 18:15:02 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fff4sm212990735ad.68.2025.11.26.18.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:15:01 -0800 (PST)
Date: Thu, 27 Nov 2025 02:14:54 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32 IPv4 addresses
Message-ID: <aSe0HgwA1XF8lVIX@fedora>
References: <20251125112048.37631-1-liuhangbin@gmail.com>
 <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net>
 <aSaf1D-N5ONmnys8@fedora>
 <43630b97-4dd4-423a-97e3-ca6aa3b56ad4@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43630b97-4dd4-423a-97e3-ca6aa3b56ad4@fiberby.net>

On Wed, Nov 26, 2025 at 01:32:22PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 11/26/25 6:36 AM, Hangbin Liu wrote:
> > Hi,
> > On Tue, Nov 25, 2025 at 05:03:13PM +0000, Asbjørn Sloth Tønnesen wrote:
> > > I also checked how consistently defined the fields using the ipv6 display helper are,
> > > and it looks like they could use some realignment too. Obviously not for this fix.
> > > 
> > > git grep -C6 'display-hint.*ipv6$' Documentation/netlink/specs/
> > 
> > The ip6gre spec shows
> > -
> >    name: local
> >    display-hint: ipv6
> > -
> >    name: remote
> >    display-hint: ipv6
> > 
> > The dump result looks good.
> 
> Those two are defined in linkinfo-gre6-attrs, which is declared as a subset-of
> linkinfo-gre-attrs.
> 
> In linkinfo-gre-attrs they are declared as:
> 
> -
>   name: local
>   type: binary
>   display-hint: ipv4-or-v6
> -
>   name: remote
>   type: binary
>   display-hint: ipv4-or-v6
> 
> I have tested with deleting one or the other's display-helper, and at least
> in cli.py, this kind of display-hint overloading works.
> 
> > So for others ipv6 field, what alignment should we
> > use? Should we add checks: min-len: 16? Do we need byte-order: big-endian?
> 
> IPv6 is always big-endian, the marking first becomes needed when/if we make
> them an u128 type. Until then it would just be nice if either all or none
> of them had the big-endian marking.
> 
> I prefer exact-len over min-len. The current tally is:
> 
> $ git grep 'len.*: 16' Documentation/netlink/specs/ | cut -d: -f2- | sed -e 's/^ *//' | sort | uniq -c
>       7 exact-len: 16
>       5 len: 16
>       6 min-len: 16
> (assuming that only IPv6 has a length of 16)
> 
> "len: 16" as used in ovs_flow's ipv6-src and ipv6-dst only works because they
> are struct members, not attributes.

Hmm, I just found that I tried to do that 2 years ago[1] but forgot why I give
up... I saw you have fixed the fou part with 9f9581ba74a9
("netlink: specs: fou: change local-v6/peer-v6 check").

Let's alignment others this time.

[1] https://lore.kernel.org/netdev/20231215035009.498049-4-liuhangbin@gmail.com/

Thanks
Hangbin

