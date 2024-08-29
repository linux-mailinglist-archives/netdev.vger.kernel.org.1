Return-Path: <netdev+bounces-123346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A667696498C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B99B28088
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12DC1AED50;
	Thu, 29 Aug 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKOUq0GM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CB1AE027
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944140; cv=none; b=DTlrgOyA5NtTTuPA/byQ5EKmGYQQTHAnfxr864mw85sYHe4jwZV31VVxxfaYsMkMIY4w2ShRa45wgFbYNJd/Wcmk0HRkjEKqq90qzTDq0EksKlTFhK676yBfmzTznVaHkrk9JFKP2VTvwZbJV05WrZ6FFP3YzFxcpDZag3bAJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944140; c=relaxed/simple;
	bh=G383U2LVa5lh5PKUf2s7ppv7E5JxE0iJFy52CmCC4/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieIRolF4e5sq4x5rWdSSAoPJimFL2VvN7WV/j6cH5VZEi2dYh187O3VrksbJt52KqhElJDS7fGLZPyl7TNY805w3O+cP+eD+c+EHzsOvh5ZDE1va/oqx0yQstQMmAdAHI8tifpQveLI0jtgdc2Ake7S5al2onDOPtEYb/Bdsz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKOUq0GM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f23bWvfS+96XrJZEbRDprBIK9QHcbJVow5jC0ff/BuE=;
	b=aKOUq0GMyyw6DE8Tgk/YhjqUGcxGIMxtjM3ATNzHldGbSSysYh97m8Rtofb3HF1VElEBJH
	hEtUEySfSzVjjWT3ZoMNS5r38XKhtpZegi9MnEIKVe/cFcvKJib6eVbcgVyGtOcgc9ux3j
	WfCo462sJvXgxzdGEqrsiK8IaQ+fSfk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-rVPtelmoNFeA7doRzsv5pA-1; Thu, 29 Aug 2024 11:08:57 -0400
X-MC-Unique: rVPtelmoNFeA7doRzsv5pA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371a1391265so480337f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944136; x=1725548936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f23bWvfS+96XrJZEbRDprBIK9QHcbJVow5jC0ff/BuE=;
        b=CkB8kGnBOWhG+DGRh/9GJ2bRNT2l9WcvhW36w6chNDUs+ghA+tj7Da51GaUxeJ+sv9
         rAFMbP6mJv2J092abe2oDPPzL7Yx7PBNG7MaFHw3se3m1Dsc2guRhQkrMSwNU4OMJBWP
         VM72LgKiC95oN2Ml65roKtOioqh58Nzme8BYz6vJvm/ejFdlhxTdPEMAeAxGGai9afzh
         CBPOeVPBMaIka3aBkPxHuFV9u9opLtb2psCFoSODby4OlhVvegnoyKUACM85TS6bhZ/u
         /6bWjJvc95RS0oPBJ7LZnUymr+n4UzeIjz1QyJN3ItTLTTDj2vU/DPz9KQWr/JMKj/5C
         7kSA==
X-Gm-Message-State: AOJu0Ywe95ddBinWBVn0aD2l+6bP+6pRumnKMN9dwFEyPT+rswQTX+yh
	Yud+TPZgrVS9LYrC4pRhojK+fXtQ9Mz7hjiTaLym+Cxyn07OXCNOMzpbAscMQLqhl17poJJpyMg
	75dgixRbvrdYgBsqIM95Z7od9zFNSalb2swVG36w2+Ufh3HnXVFn9Ww==
X-Received: by 2002:adf:e049:0:b0:371:8451:5a82 with SMTP id ffacd0b85a97d-3749c1cf4femr1525189f8f.15.1724944135493;
        Thu, 29 Aug 2024 08:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAVT+jPEvZPePS2m8PlCOVLmcVvUVKNJjiRJ3WiJnkyhIlgAQwCOlKSYVepUzLT7PxAwgNRQ==
X-Received: by 2002:adf:e049:0:b0:371:8451:5a82 with SMTP id ffacd0b85a97d-3749c1cf4femr1525146f8f.15.1724944134582;
        Thu, 29 Aug 2024 08:08:54 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb0907sm1631513f8f.97.2024.08.29.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:08:53 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:08:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtCPA91T5OwSE9lP@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <ZtBb8sl1JnMHZ5az@debian>
 <ZtCJBR_XIn6H9EBU@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCJBR_XIn6H9EBU@shredder.mtl.com>

On Thu, Aug 29, 2024 at 05:43:17PM +0300, Ido Schimmel wrote:
> On Thu, Aug 29, 2024 at 01:30:58PM +0200, Guillaume Nault wrote:
> > On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > > 
> > > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > > 
> > > > > It is currently impossible for user space to configure FIB rules that
> > > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > > various call sites that initialize the IPv4 flow key or along the path
> > > > > to the FIB core.
> > > > > 
> > > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > > 
> > > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > > as it has never been defined nor used in IPv6.
> > > 
> > > Yes. I want to add the DSCP selector for both families so that user
> > > space would not need to use different selectors for different families.
> > > It's implemented in the patches I previously shared:
> > 
> > Hum, I guess that was a misunderstanding on my side. I read
> > "adding a DSCP selector to [IPv4 and] IPv6 FIB rules" as "adding the
> > possibility to match only the 3-bits TOS in fib6_rules". But your
> > fib6_rule.c patch doesn't modify fib6_rule_match(), so I believe that
> > what you really meant was just to add the new FRA_DSCP netlink
> > attribute to IPv6. Am I getting it right?
> 
> Yes. To be clear, you will be able to use the new 'dscp' keyword exactly
> the same way with both IPv4 and IPv6:
> 
> # ip -4 rule add dscp 63 table 100
> # ip -6 rule add dscp 63 table 100
> 
> Mixing 'dscp' and 'tos' will not work:
> 
> # ip -4 rule add dscp 7 tos 0x1c table 100
> Error: Cannot specify both TOS and DSCP.
> # ip -6 rule add dscp 7 tos 0x1c table 100
> Error: Cannot specify both TOS and DSCP.

Thanks, that's exactly what I had in mind.

> > 
> > > https://github.com/idosch/linux/commit/a3289a6838a0d0e6e0a30a61132bdce3d2f71a3c.patch
> > > https://github.com/idosch/linux/commit/ff5dd634fb278431b58437654d7f65b57fd4ae4b.patch
> > > https://github.com/idosch/linux/commit/3060ecb534475eadabfa1d419dd64804f0bd0148.patch
> > > https://github.com/idosch/linux/commit/12ddbce4f519b42477ea1e130b6d2bab1cca137c.patch
> > 
> > 
> > > > > need to make sure the entire DSCP value is present in the IPv4 flow key.
> > > > > This patchset continues to unmask the upper DSCP bits, but this time in
> > > > > the output route path.
> > > > 
> > > 
> > 
> 


