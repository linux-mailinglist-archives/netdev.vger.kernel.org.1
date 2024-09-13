Return-Path: <netdev+bounces-128106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0033F9780C4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A247E1F244A9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A11DB52D;
	Fri, 13 Sep 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X83mcX/0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF1DA620
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232924; cv=none; b=LNn3c35rNTrUQdOATZhmWEhTlbRPuptZxzQPRheCrlfpln/8OMZxQHKEdtbd6f2vMO/zkoG9VDbwm5l9aaQBXZ1fSIIVckWbxaiaWyA9HkKm6kaxtftBTjjMF9LdM1XzNsTVxNXjT21a3N1XSwqb+vRbj/FLsp+E+ldhdIq9jQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232924; c=relaxed/simple;
	bh=YXv7nFgTTz8yqPg6Vm+SvBycH56az2RydggFXoNBobQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrK4Mib1Ucq7B1SVVoNY3UlQyy1g0UJoG4gfssQPB8pGV74QHIU96s+eMd6N0Uv6l3M3PBu2uRBSq+dp//Fsvq3koqxi8XWJj9ukFiJ1328BrT5Tx9eatDmia0n+hGygImnnxfaz76ZF4app/Z3MU6gIOksYPxoqACWu+mB4cls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X83mcX/0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726232921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuxguHVAu9c4JkX/6H05cMYi0VSnogSV0ZT2AbAC5Wo=;
	b=X83mcX/0dqK450JZLjP+y5bP7GJThKyDaUc29uOSGZzS3aGeFCxxKmZJ46o/le3E9vGrNL
	hSSJc3eXGdbDrNJqCtLPJrd7nVgClvP8JUCSSodDKVBDRUK+aAM2bmLoL9Ff3LYPYieN68
	8Tj9hAnLuvXRlGVX/aIbbjS8s2ujkbU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Yty6DAnJMeuqI4P2GfQDEQ-1; Fri, 13 Sep 2024 09:08:40 -0400
X-MC-Unique: Yty6DAnJMeuqI4P2GfQDEQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bacd5cccso1239282f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232919; x=1726837719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuxguHVAu9c4JkX/6H05cMYi0VSnogSV0ZT2AbAC5Wo=;
        b=HRg7AteEDPLDKBJqx8l4XIvSnYBfy3UOXicDYvTa71XYcCF7lbNN6NXFKNDvhh61vX
         jHBAo4O3hHN60aY1CA9Wx/+V/hx9HCuYUSPD0uQvtM7CU7jGZNJgahB1tGIEs4gTyaiv
         xCt1g2msuPzuw6REoGRiZCLnj6CcxOq233sOv23LsdZJKRXS1AFwDJdNoL8KZGPtGWfA
         fUiyqkCD2nSGyZ3NQUegZcQO4sKAno0HHnCZlr8J+BNLDWcVE0VlENV0oflprZ+8GDoc
         UJA5CSikKj+ivDOFiA3pz18hBBx0/AoCtyQsbnMt8g84pbzkHyFk0GZ4XmWPuKqoAr4R
         mPPw==
X-Gm-Message-State: AOJu0YxuRTlGWhXDR4j2QbupgoSzAUTvJO61vuv/Sdh3ymezvQfVXR85
	Or8C4vAfkWkw758g9Mbg0nnY98cs2nk/Y0kLUC1Dwsu5UlEYBDuvwJjcp7i78CMRO9jcQcaoeOv
	uTWb/Dgumvhw0+5UJ0kGF5bYkGUagoriCUnnynWNjJVea426zlrxC1A==
X-Received: by 2002:a05:6000:4581:b0:374:cbc4:53b1 with SMTP id ffacd0b85a97d-378c2d5b269mr4087996f8f.40.1726232919302;
        Fri, 13 Sep 2024 06:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAN6ia8dnMMnoGfc/zuMx2JDgVbE6pv8L/NN+YslG30+yijqk1yMuzM3xWYVoNJPJOdTIa8A==
X-Received: by 2002:a05:6000:4581:b0:374:cbc4:53b1 with SMTP id ffacd0b85a97d-378c2d5b269mr4087969f8f.40.1726232918645;
        Fri, 13 Sep 2024 06:08:38 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b8bsm16941123f8f.54.2024.09.13.06.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:08:38 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:08:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Message-ID: <ZuQ5VNo/VUBWbqNl@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:42PM +0300, Ido Schimmel wrote:
> Currently, the kernel rejects IPv4 FIB rules that try to match on the
> upper three DSCP bits:
> 
>  # ip -4 rule add tos 0x1c table 100
>  # ip -4 rule add tos 0x3c table 100
>  Error: Invalid tos.
> 
> The reason for that is that historically users of the FIB lookup API
> only populated the lower three DSCP bits in the TOS field of the IPv4
> flow key ('flowi4_tos'), which fits the TOS definition from the initial
> IPv4 specification (RFC 791).
> 
> This is not very useful nowadays and instead some users want to be able
> to match on the six bits DSCP field, which replaced the TOS and IP
> precedence fields over 25 years ago (RFC 2474). In addition, the current
> behavior differs between IPv4 and IPv6 which does allow users to match
> on the entire DSCP field using the TOS selector.
> 
> Recent patchsets made sure that callers of the FIB lookup API now
> populate the entire DSCP field in the IPv4 flow key. Therefore, it is
> now possible to extend FIB rules to match on DSCP.
> 
> This is done by adding a new DSCP attribute which is implemented for
> both IPv4 and IPv6 to provide user space programs a consistent behavior
> between both address families.
> 
> The behavior of the old TOS selector is unchanged and IPv4 FIB rules
> using it will only match on the lower three DSCP bits. The kernel will
> reject rules that try to use both selectors.
> 
> Patch #1 adds the new DSCP attribute but rejects its usage.
> 
> Patches #2-#3 implement IPv4 and IPv6 support.
> 
> Patch #4 allows user space to use the new attribute.
> 
> Patches #5-#6 add selftests.
> 
> iproute2 changes can be found here [1].
> 
> [1] https://github.com/idosch/iproute2/tree/submit/dscp_rfc_v1

Any reason for always printing numbers in the json output of this
iproute2 RFC? Why can't json users just use the -N parameter?

I haven't checked all the /etc/iproute2/rt_* aliases, but the general
behaviour seems to print the human readable name for both json and
normal outputs, unles -N is given on the command line.

> Ido Schimmel (6):
>   net: fib_rules: Add DSCP selector attribute
>   ipv4: fib_rules: Add DSCP selector support
>   ipv6: fib_rules: Add DSCP selector support
>   net: fib_rules: Enable DSCP selector usage
>   selftests: fib_rule_tests: Add DSCP selector match tests
>   selftests: fib_rule_tests: Add DSCP selector connect tests
> 
>  include/uapi/linux/fib_rules.h                |  1 +
>  net/core/fib_rules.c                          |  4 +-
>  net/ipv4/fib_rules.c                          | 54 ++++++++++-
>  net/ipv6/fib6_rules.c                         | 43 ++++++++-
>  tools/testing/selftests/net/fib_rule_tests.sh | 90 +++++++++++++++++++
>  5 files changed, 184 insertions(+), 8 deletions(-)
> 
> -- 
> 2.46.0
> 


