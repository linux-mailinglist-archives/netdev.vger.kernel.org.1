Return-Path: <netdev+bounces-117788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFF94F546
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30D0280EBA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA02187348;
	Mon, 12 Aug 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CPlXJfn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143B2B9B5
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481414; cv=none; b=Of+We6FM+UeYxsejZmlPA3BZxe2zq9Yw0a5QRUOGNHPipMQdkN35HOBSFNvm5JZVoxhl1vODZNqTA/E8TghqzSw6BeAevOeGms01dhfOuwm9hm2L6Sub13ZSA2Dc3jNDzldEI/AgQerXwtzL3cqbGV0OVFOM2Rn7qbKU+n1rkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481414; c=relaxed/simple;
	bh=JStRV2KodetBXluz6l5TxUPL7qVKr4QrOvAXLTSJfI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laOPNmoaVC+XnmSOwsiTY2ouF1pNJqXa7c4ovbTKpwG4ZnKottoikqH0RUp0+aaf0VqGx5PNx8rGpjRJjMArhdmK/H5T5H8+8Wsmnl9WvSIHb8su/bUYclJzQar8A1prSsnVgr3ZhqOVMMqN2Vtxv39xtMjfln4KU0Ri9hRHwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CPlXJfn7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so21588565e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723481410; x=1724086210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp8xX+FXjb3rqeoPjDRkNuEhp9boglIYB3297SKcqNk=;
        b=CPlXJfn7EFlTMc8CHepU/iKgPiF6HwPOwT6gZyzw0WF+yeRYiO4D5R0gKZYemOZr/b
         nLzoy2F1a41jdNt4vjdJPYflcQ8ZvG1HIlTHStiIa/5LV/pJ4UxwHKonw2pIadGDFLEm
         Qoi7GfdwUoAx9qNAbafMVJwX6L+kS/E+mYga6eUhLzmq1mcJnt0lDwA53Idg5JQ9qoNI
         uf/PUCgS6mwmz6qPmknxgUi3rY1A5Ow/R2iMmLNvurXZx3xRVO24EEayu1sQYhplAKjY
         Gc1qXU4yNB/9pUvm8jq2bvQHp19IA2m+9xJtX1TVDIf3IAbTLdJcW45HkhOIxPJ7Afz2
         /dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481410; x=1724086210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp8xX+FXjb3rqeoPjDRkNuEhp9boglIYB3297SKcqNk=;
        b=Re/R1vDiQDcvZfoVUwhctG0ijk1WeXphbwQFVxRPudGpmOltRZMqFDEWbXyCLdpqqY
         oygASaE02PLs168fcKiDd3CxiZ6P1QzorrKY5N+TPOBODB/C1mOVCSIEa8wZJtdVgwhu
         L6DNF5BVJubfp2YCmp6uIWkQYROr5Fci0iA4j/J1MyNeC9ditGflhhlhFMb/fdkF0Pl1
         n+hrH8mlBQFpaAr5plusTuCoC5UWVhaHlBkrLq1XfLWq9d581fPmL+fk1OpIV7G8rHIv
         E/8Wm6Fbe3qEbsR4VDMbq4Qi5vhxphgcrOVllzlWAuTEOG56q0kWcAXb+TvfAtWq0eVA
         uryw==
X-Forwarded-Encrypted: i=1; AJvYcCUyAe3dbhBs4orEfPHvUrryq1ntN+qv2rVTCRj+Mh+tT72FILvE1VG0V8oz6/m8ScozM2MVYw/q46QcJAq7Com4Gbct9aTd
X-Gm-Message-State: AOJu0YzORQMcKXu65dzdfH8dVBEj/xrA5bzWrwHjSl2GP9RN3kaxt7My
	vrh6kimewzupO8qX43ba2pCcU05ZUWs8Mvikiv07RsXMD09gOZ9PTPtXhMOUxj8=
X-Google-Smtp-Source: AGHT+IEI8II0zjNASn27I9fMm0e9cD6S3h+RK97HXuwvblBt8meMa6cF2FdHklxVfp9Z1OGFn9Xvaw==
X-Received: by 2002:adf:eccb:0:b0:369:b5cc:58b1 with SMTP id ffacd0b85a97d-3716ccf5ec6mr570530f8f.18.1723481410299;
        Mon, 12 Aug 2024 09:50:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ec2asm7994854f8f.67.2024.08.12.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:50:09 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:50:06 +0200
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
Message-ID: <Zro9PhW7SmveJ2mv@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
 <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
 <20240812082544.277b594d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812082544.277b594d@kernel.org>

Mon, Aug 12, 2024 at 05:25:44PM CEST, kuba@kernel.org wrote:
>On Mon, 12 Aug 2024 16:58:33 +0200 Paolo Abeni wrote:
>> > It's a tree, so perhaps just stick with tree terminology, everyone is
>> > used to that. Makes sense? One way or another, this needs to be
>> > properly described in docs, all terminology. That would make things more
>> > clear, I believe.  
>> 
>> @Jakub, would you be ok with:
>> 
>> 'inputs' ->  'leaves'
>> 'output' -> 'node'
>> ?
>
>I think the confusion is primarily about the parent / child.
>input and output should be very clear, IMO.

For me, "inputs" and "output" in this context sounds very odd. It should
be children and parent, isn't it. Confused...


>
>> Also while at it, I think renaming the 'group()' operation as 
>> 'node_set()' could be clearer (or at least less unclear), WDYT?
>
>No idea how we arrived at node_set(), and how it can possibly 

subtree_set() ?


>represent a grouping operation.
>The operations is grouping inputs and creating a scheduler node.
>
>> Note: I think it's would be more user-friendly to keep a single 
>> delete/get/dump operation for 'nodes' and leaves.
>
>Are you implying that nodes and leaves are different types of objects?
>Aren't leaves nodes without any inputs?

Agree. Same op would be nice for both.

