Return-Path: <netdev+bounces-123348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E03096497F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B307A1C2194B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253651B14E1;
	Thu, 29 Aug 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPryKAdA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A01B1432
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944221; cv=none; b=TmtldgiRpwuP91oUIMW09d2YSmg+rljZAswWkyS2GUzNO6Vlts43b+VWW/zENPDZRZdJ6Fq/5thVz1nW+zR/4SSZm5f4yzIWgszFi/V9G0agGiG7XXbvGUeblHKLVsp8Q5EJHkjT4VzImMmHs/UqTkclYLexDRqks6DjRcfo2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944221; c=relaxed/simple;
	bh=n6dwzWYVTL3iDL6YSAs6u/7LDAM66hgfqVG7DKNtsoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5PfQALI7xIx8Xm0EMvonmFVBL/87j7kkau0vCMDSSHJsBTyhVekDe0fR3MVP54ebWkjqZIs6vu/p2j0SRi/vqa6dGaPYEZH1K9ELY78lQVlOYRF5YV3OP1ZQTk2VQXQZdTjf4xq6TqZBzt03sfiZx6K2ckyy9CcrFOs0X/54IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPryKAdA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao+a8Xxh4C4YfbR/QvB4MFXxEO7ry5mYZebysEnEllQ=;
	b=CPryKAdALgUi3PfNiCHg0/brpyVQvPlLL4zDuFqL0L+0KKDrWjy6ioIzt7VLDBKAnxogHk
	xqoadxjpJXXQPpEHOPWfCQukMKZQ359BhbVFleInP0I70Wtz4i1S79SB27GNFhrU5f9tw7
	G4fTwPrhp34kbU5IFNw2Vnd0Swvesg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-bRprznybMayhTH5XU0qXeQ-1; Thu, 29 Aug 2024 11:10:17 -0400
X-MC-Unique: bRprznybMayhTH5XU0qXeQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42b8a5b7fd9so8154485e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944215; x=1725549015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao+a8Xxh4C4YfbR/QvB4MFXxEO7ry5mYZebysEnEllQ=;
        b=Aj3R4kAkbzXXoUGNhGxT1irWEnZ0YaXHD+Od2xK1xAavwFVJNFv0Knr3LrK4fdlEIG
         tHLR0Tw/HZZQlnPdJO7QpZmQHsqMFOZD4blSHd/o+yCVO1qM1oU2yy7YMyUkogKyeC1Y
         m7Ph5Knrm6UIHJVUH3+vNdPPF9kdc1QPs41WG0ZY+EnBjEsN2Ewp3KtDDfAj/ZFbFEzl
         S+pgZUm22HYHtu9bltJoa7WiuAi5oXY+CXrpLucIawuJgTKXJ1z54m8DSymaWNB14aoq
         9QWGPf+k1r3133UbxFecYwuDU8UBjwxVHqkzgc3wKHCizJ6voSGzSjjpaAYLmgzLazgd
         DB6Q==
X-Gm-Message-State: AOJu0YxN6XQC8AIikA/l+b/79hTaYNOSNhIP+zYY3d9r/z9vumJP2gCL
	eBI6JnZMi0VNgd+cDP9wJ7TQhlrJUgiKHfmN5PboIPsFCBo3rMDFKWllHNF8UZa6BAbt7EtR5Vn
	2gfRTXFXcWvK5X6bsK/ySXgFeUqPwM2zsY45RatJ8m6D+2Jz8cCx96vMuFuR6oA==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr23527565e9.37.1724944215455;
        Thu, 29 Aug 2024 08:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQK15mXlYCsrEnxCrHV0cVlBaBr7pufMo9a8oWHKcRLt/GBpWhVQ8lsJsMKcWU2QqSUcdYZw==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr23526675e9.37.1724944214555;
        Thu, 29 Aug 2024 08:10:14 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df92f1sm20178375e9.25.2024.08.29.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:10:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:10:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtCPVKTnkvTZVTBQ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>
 <ZtBhhhBeKj82CkYR@debian>
 <ZtCLFYdbw6rPinwS@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCLFYdbw6rPinwS@shredder.mtl.com>

On Thu, Aug 29, 2024 at 05:52:05PM +0300, Ido Schimmel wrote:
> On Thu, Aug 29, 2024 at 01:54:46PM +0200, Guillaume Nault wrote:
> > On Wed, Aug 28, 2024 at 03:09:19PM +0300, Ido Schimmel wrote:
> > > On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > > > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > > > 
> > > > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > > > 
> > > > > > It is currently impossible for user space to configure FIB rules that
> > > > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > > > various call sites that initialize the IPv4 flow key or along the path
> > > > > > to the FIB core.
> > > > > > 
> > > > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > > > 
> > > > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > > > as it has never been defined nor used in IPv6.
> > > > 
> > > > Yes. I want to add the DSCP selector for both families so that user
> > > > space would not need to use different selectors for different families.
> > > 
> > > Another approach could be to add a mask to the existing tos/dsfield. For
> > > example:
> > > 
> > > # ip -4 rule add dsfield 0x04/0xfc table 100
> > > # ip -6 rule add dsfield 0xf8/0xfc table 100
> > > 
> > > The default IPv4 mask (when user doesn't specify one) would be 0x1c and
> > > the default IPv6 mask would be 0xfc.
> > > 
> > > WDYT?
> > 
> > For internal implementation, I find the mask option elegant (to avoid
> > conditionals). But I don't really like the idea of letting user space
> > provide its own mask. This would let the user create non-standard
> > behaviours, likely by mistake (as nobody seem to ever have requested
> > that flexibility).
> > 
> > I think my favourite approach would be to have the new FRA_DSCP
> > attribute work identically on both IPv4 and IPv6 FIB rules and keep
> > the behaviour of the old "tos" field of struct fib_rule_hdr unchanged.
> > 
> > This "tos" field would still work differently for IPv4 and IPv6, as it
> > always did, but people wanting consistent behaviour could just use
> > FRA_DSCP instead. Also, FRA_DSCP accepts real DSCP values as defined in
> > RFCs, while "tos" requires the 2 bits shift. For all these reasons, I'm
> > tempted to just consider "tos" as a legacy option used only for
> > backward compatibility, while FRA_DSCP would be the "clean" interface.
> > 
> > Is that approach acceptable for you?
> 
> Yes. The patches I shared implement this approach :)

Thanks for confirming. And sorry for the misunderstanding in v1.


