Return-Path: <netdev+bounces-173516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699EA59407
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754E516297C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1E21C182;
	Mon, 10 Mar 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="s0ucVb6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA919F13C
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609029; cv=none; b=nY+V9KObqFo2flQHSiUvwVLo3lSLSn5TxrNx6CJisAeSLnzOonJp4a/3ilG2kxjWBW+/TwyKBwkn+kDXplBMF8QOXIzQF/upV8wX/n6a/4Cm5FVxKOqT758oMthneATM2KVjVF2DDwDflG+oZhrLXIWJq2YdsMTYVKxJ0LKcMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609029; c=relaxed/simple;
	bh=S53/LkXLiTZG/8yL8Ld5ik2zpzal7sFh2tSwA9o8tjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6n3bh+DPjRGM/jLpmbzY0NKUNtLtyT8YN8xS5G6xX2aZ6ppj6sivpmZTkZIN6lfn3o0kDVvKtRVO/M8NIAB4QOuuXBw0hAmES5dZZe/GQKYXIlDAGdyugicSDsPBSwCvy/sa6MvXSs6MRkM7h6f3sTUAmMd8aElCw2jS/eu450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=s0ucVb6p; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbb12bea54so767395666b.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741609025; x=1742213825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KvY6XmT5VUfNjdFEyHY9ecmJ6Epe8lQ2utpyogFvq0=;
        b=s0ucVb6pI0EMcUrHVQw0jwLnjuFeM7gqzjKGxfvnuPXBBm/0vAG79nCXPOq9tain8v
         pKOsatkUGvvBqo2xpTFnxb8h9x4p7xccQK6pIeTJdr15zFlXpHveLvgAcqvdEYMH/WTq
         kZ5jRf5qrK7FTlZ/F9dmETrDZ58c5wOC5RFTI3jK/+EnW67HWrBUrbDo7MIz928lA23H
         U1w/QP5WgPZrG1E3hVzi0MedWL+7mopuloh+PjiJABK/wn3dbfOVFcbKS3z+rAeA9BFV
         15g3+fxrEj8UzPLqde+A3c++tZb9qacooEDnnY9yv7KHoh+IYbT0s9OMECNXUPwrLdUv
         KdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609025; x=1742213825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KvY6XmT5VUfNjdFEyHY9ecmJ6Epe8lQ2utpyogFvq0=;
        b=V2lU3nGnUVHaiV2cKNGoavmLAB4TWQTPCDaQi2jD7ZkN5fy9qnyli2fiYg0tMGMcCM
         Ty2s+owvqIuOsB3kT8xgYQNpc/CAPDoTu9aO9xKwhtsop7E80eKGvsCiJTM6fy3JnY6B
         jdA+A3FRPbf2u8N2nwuOS1DFS3YrcNa5IVXlIj9CQYPGqdoPlJ0nKvNdD22P2zL1LJ1Q
         ptFI7AWWQmh093pLqLAOT7/AIw/ZaqmsY2FysMNcV0qKtQlGNf2cyAmF46lnaq78StDB
         r/QiqcIudVBmL2WERFCxsSCbBMtSfDTxamxggxh6EK0sQ8TVu6uGNoxYR+jLDC7W35yy
         Ng6w==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q4DFMk2wGEFGqmh2zCVsstzaZ/JiYRnex0BVAVWIpblkhTZ/9i3x5Kpx9U7iOwiedLr1Gr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuaWEdUgLQ4zrJqip3F239yEgEtA1SlbMzlSsjZRyunC0XAYa7
	7TMIh21yF3Wp8LQk81vWw9dBTutTigLYn/LDVVtlqi5Bn34KGOWkqKyRfcEWQ74=
X-Gm-Gg: ASbGnctxVaUZyjPDsPp8uq8Xu1V5TK0aKSGIOrkjTkX4SWMXYCla+Qs7Zy1A3cXpvw2
	UzSAQKHiYmQfO0Q7wfBE4jm6s6x0a7Z9zeBfhQW+7aSqfaerA4p2R/0Kk/gFNUj6+APBPMU5Qr2
	i3bn9lc0Itw40fyYvUpz/XQQ2KpsJ2tbQabaMvDvPWnbPvWVe1/7ZRr3zBaI3bVwC729w2G5CbP
	P2XQD1fiN/usUJThKxFWa7LsVtaSmbWoAvRmmQccBofWk9+cGnU1I6DBNdGDEAcS1A5jTtcQoU8
	+Oj8Vl+zCpPL8xrhBX8bxhFAMzlzy1KldOESzD4xbdhLGII66osU9zPhCmwS248nEXZ7YeM=
X-Google-Smtp-Source: AGHT+IEOjLXpBFIaE5nADTOJROBRwyDjcAFeUP3G1DEOPq1uB93pgXywjcqgxL++XzBsEk3KlPs4bQ==
X-Received: by 2002:a17:906:5ac8:b0:ac2:7a6d:c918 with SMTP id a640c23a62f3a-ac27a6dd696mr721874966b.57.1741609025489;
        Mon, 10 Mar 2025 05:17:05 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2895e7e6asm310057466b.54.2025.03.10.05.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:17:04 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:16:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch, 
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <6cxx4i4t66q6hm2df46lirt3qkd4v2ryuoytuqmxqe6glgfsu5@3nvtleuvy5qr>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306114355.6f1c6c51@kernel.org>
 <ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>
 <20250307082053.6bd879c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307082053.6bd879c9@kernel.org>

Fri, Mar 07, 2025 at 05:20:53PM +0100, kuba@kernel.org wrote:
>On Fri, 7 Mar 2025 13:35:28 +0100 Jiri Pirko wrote:
>> >nvidia's employees patches should go via your tree, in the first place.  
>> 
>> Why? I've been in Mellanox/Nvidia for almost 10 years and this is
>> actually the first time I hit this. I'm used to send patches directly,
>> I've been doing that for almost 15+ years and this was never issue.
>
>You probably mostly change the driver together with core, like devlink.
>In those cases you can post outside the main stream.

Okay, that is mostly what I do, correct.


>
>> Where this rule is written down? What changed?
>
>It was always like this, since before I became a maintainer.
>I think what happened is Saeed handed the maintainership over
>without "writing down" all the rules that we established over
>the years.
>
>Obviously he will now probably disagree with me. Because y'all
>apparently have no time to review patches, but playing victim
>you have all the time in the world for.
>
>There are only two vendors big enough to warrant a special process
>(Intel and nVidia), and we make reasonable accommodations (like
>the one above) so it's impractical to write all the rules down.
>
>Not to mention the fact that you should perhaps, in an ideal 
>world, just try to be a good community member, instead acting
>as if we're signing a business contract.

I'm always trying to be a good community member. I just can't behave in
cases I have no clue how, that's all. :)


>
>Have a nice weekend.

