Return-Path: <netdev+bounces-117918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7F94FD47
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D681F21B4C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC92374C;
	Tue, 13 Aug 2024 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CZWsV7+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A814A82
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527535; cv=none; b=Hbc/g0GdB2y7wjN2zr1c9n0K968Jq0zRfG+iNaC0xRymn9KSaOHY0ftuJ4Qcp5W/TR5yW9Zm+GVkf/RuATnejHrcf0ZRF+oEgK2YmR2YRzXTktFCMX1rGM2Jx/3Dac4y1MGzuMr2ixrvuNmIcUCI1khDSKqJ5vgvfCZ4t6QwalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527535; c=relaxed/simple;
	bh=4S7WM7RybjiTPLle/bWEVEs4rbk05HHoUl3uV2tpW8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0FofFv4HaYLBKE5n6WIP+7dpd6PNP23MLSO3OTONa6GTQhZ8JL7/thjtemrWeIss8EGE8o8F4+gWXWiAaYmQcRpfeKrnWr1Ar6fwo/epnqNR/3yNrkQZhsxo+rJt0+b7D4Fe5NoWhAZMpOTbm/8CdYHin0BxRu1xhD3sbz5g80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CZWsV7+V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so25299315e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723527531; x=1724132331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PnScSw7uJC5Aim3AFPCq508Jec7s6BJ/aiCOYhCdJo=;
        b=CZWsV7+Vpu5L6okX7MIu52qw56AddMmtKBnoh5RkDOEorDN6iPCTnDQC5P0tTTWKDC
         2ANniQDJF83Tv52OlI2vIqjFkRZCkF0pFHS+uHVJtl51npahiVXjHFs0UqHPffBC0SZe
         t7CRMD7Ndtpza1jplMTom+IGrG1vvfRcyeFw9WIkYhIQ4Vua0oXJYo6e4ovLtXZoh0GB
         pcX3jX+qz97MhQ4H+xYixG2v618wrpwTeaNwcrKIdaRphqUIEvYxZdGTlp8yymcb0aNu
         KcjwqcclRFXVbs8+09+d3aRUYO0Thyq3ibrged+to3m9DA/eDRoX4TJOv4hVAw3BH9yf
         8Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723527531; x=1724132331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PnScSw7uJC5Aim3AFPCq508Jec7s6BJ/aiCOYhCdJo=;
        b=VqhMotLMoMlwp+hOdwNBH3EH421AmrCHBqfA5Ip0cHKF48MxJbQnx67xBSHTLBpKtD
         17HoUKI5UL/GhZ1I1H6ga6qOppPdVcKmz7j/pVJwxPhpJAQ4iHmadZuFw0qisfnyMWB+
         qEZ6hhkKzzz72/AEE4a4Wl0IGARPgT8i3PSNX88Nur5DNSx9EIa71n+eTZ8w8lHOEVdQ
         TGelL3vpN3deFnkILOd8jjg3aXTufI16/gN3EmhLu8BY18qoiwCOoA42DXlTBqQNriUU
         hVkektfwFKQNw+Sy/q4S1O/99d1ZJOYZ+Fkhb2eE940/QW8EcCRDs9WNm535wEkvph/p
         qZKw==
X-Forwarded-Encrypted: i=1; AJvYcCWHyr72ChhJ67L+PHFVfGW9qR0c/0Fwu57RHa7EoSMWqfe6rrEfAmxUSHrDj6sbxC+xAfea7GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKg8SD0eN2JaxBySkWtNPtGIrfHPUkF7HZZGWSqyJ/N79Qk6Cf
	eOUIHpUjZat8HCWnEcEIRAna3i2rNK2W5Jjt5WCr+lhcJCYA5+D7sw1lxssFhQc=
X-Google-Smtp-Source: AGHT+IEYKBlRPX9bVKp8cRXDSRgCz2eMMxWkFhQ2MW3khxllq0ePcf6gQsDNpa40p6T/snlsK+dxyg==
X-Received: by 2002:a05:600c:450d:b0:428:640:c1b1 with SMTP id 5b1f17b1804b1-429d481a198mr17583735e9.17.1723527530566;
        Mon, 12 Aug 2024 22:38:50 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd372fsm9117700f8f.108.2024.08.12.22.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 22:38:50 -0700 (PDT)
Date: Tue, 13 Aug 2024 07:38:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <ZrrxZnsTRw2WPEsU@nanopsycho.orion>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
 <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
 <20240812082544.277b594d@kernel.org>
 <Zro9PhW7SmveJ2mv@nanopsycho.orion>
 <20240812104221.22bc0cca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812104221.22bc0cca@kernel.org>

Mon, Aug 12, 2024 at 07:42:21PM CEST, kuba@kernel.org wrote:
>On Mon, 12 Aug 2024 18:50:06 +0200 Jiri Pirko wrote:
>> Mon, Aug 12, 2024 at 05:25:44PM CEST, kuba@kernel.org wrote:
>> >I think the confusion is primarily about the parent / child.
>> >input and output should be very clear, IMO.  
>> 
>> For me, "inputs" and "output" in this context sounds very odd. It should
>> be children and parent, isn't it. Confused...
>
>Parent / child is completely confusing. Let's not.
>
>User will classify traffic based on 'leaf' attributes.
>Therefore in my mind traffic enters the tree at the "leaves", 
>and travels towards the root (whether or not that's how HW 
>evaluates the hierarchy).
>
>This is opposite to how trees as an data structure are normally
>traversed. Hence I find the tree analogy to be imperfect.

Normally? Tree as a datastructure could be traversed freely, why it
can't? In this case, it is traversed from leaf to root. It's still a
tree. Why the tree analogy is imperfect. From what I see, it fits 100%.


>But yes, root and leaf are definitely better than parent / child.

Node has 0-n children and 0-1 parents. In case it has 0 children, it's a
leaf, in case it has 0 parents, it's a root.
This is the common tree terminology, isn't it?


>
>> >> Also while at it, I think renaming the 'group()' operation as 
>> >> 'node_set()' could be clearer (or at least less unclear), WDYT?  
>> >
>> >No idea how we arrived at node_set(), and how it can possibly   
>> 
>> subtree_set() ?
>
>The operation is grouping inputs and creating a scheduler node.

Creating a node inside a tree, isn't it? Therefore subtree.

But it could be unified to node_set() as Paolo suggested. That would
work for any node, including leaf, tree, non-existent internal node.


>
>> >represent a grouping operation.
>> >The operations is grouping inputs and creating a scheduler node.
>> >  
>> >> Note: I think it's would be more user-friendly to keep a single 
>> >> delete/get/dump operation for 'nodes' and leaves.  
>> >
>> >Are you implying that nodes and leaves are different types of objects?
>> >Aren't leaves nodes without any inputs?  
>> 
>> Agree. Same op would be nice for both.

