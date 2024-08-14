Return-Path: <netdev+bounces-118390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C217951733
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A0BB28082
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEA143C6E;
	Wed, 14 Aug 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqzkuyiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130C1442F7
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625817; cv=none; b=UxHSWKiawrWVyKELirE8LgcCrm0yu1S1XfATAAu3KwxLwvpscONLaXBsoJe7pkI3LsmyL6iEc1ulQiCGDDrllbOONM5GeN7tUpik14XurZaQIv7CUT8mh5JcP1NT6RRR3RzJOFISxNMVnJXT9pj0NCDYVfPI9CCWN89YnMhml8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625817; c=relaxed/simple;
	bh=E/SJ1R/e4a6yUAjBZkY2QBigcGkFZO7JvDc77oR48AM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=c5656lwa8wd5l380zACutiYXF6ZPvXzNet4GNVtV5Jua3q5qFMF9mfZwmJxl1s3/Ru3oxmAixi8uV17GYAbbkx6Zsm/0/MPV4nOh82Rrjd3hmt9O5rCKzauAx5zM1zcGCmawCNVzZIILkrReVimUge4EtfNZivNw8XRtphvs9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqzkuyiJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e3129851so46616045e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723625814; x=1724230614; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VmuuD1Mg38RuJK+XXDOfDQ0zQ/m/bh2bzVqjtBHG08=;
        b=KqzkuyiJt+szkaDbBhA3452yecMeHZQxq15Ar4BOtF92RwF9cq/KJVbtb8j9g7WiK4
         hQsVgCnwITrOzv2abZQg0wIheJEg5gRMmviUMHTgc0BJk3zr4iB3KB5GeDbNTibeiEFA
         jb5C/a5KuuoUtyimBE7LIGdG0D6HZUKVX9HfVlqJQfoSITO02llCRW09stYoMc1bd9Pw
         wDElk/FEBXRWdZ323Zic8lun+Upc7iaS1Z10T5Rq8edPOfO2QtE/Tf8EGxC8KAFUr+vY
         9TmY8lKy9jvvT12gW+vwgfQKlpij1w6avP7cF2guKYy7KoOnJ55ltYWUvLLYKn3eQTmT
         Q0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625814; x=1724230614;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VmuuD1Mg38RuJK+XXDOfDQ0zQ/m/bh2bzVqjtBHG08=;
        b=PwnuhsrJ0Jko3Uv7kYtYCg2EyxviJjh4yj8H+RhPKyeJsw5A1E86+YVFohZiPqrDsc
         /fMws2lsUHRgTNSrWrUjIZlzJRgQ40GywgfQssCaKPxUz11oTaQa72jGYatRysKQ6N6u
         mAB3BagrjjxfxSW12d5uTAYsTMpr4J5uX56a3k7bIW61/i9tkd/U0EMjw1YcBNegwzSo
         BlfWE2OFhpqPDP9VU4JbD+uLxPadpcOwCD7XPVyT19lMBgCJQKGgtnPnSJ41tK7ukV6w
         Hn83twD0dhEoqNX4b5YDJQVFVYjZlwhFsybIpENqIng0bvN4CL/oHnDkzRU8iQJlXMf/
         yM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWJJ3hXefbeDrEb2HMSUqnDEOgNcqCv34+zGQimtTweMkv4cF3KDJKxzfwQFiWB2EyG//XyDlBrVqPX0Q6XAL8ktCE3c1w2
X-Gm-Message-State: AOJu0YzCh3K/TCNIVqLPR5MYLTaG/En+XQzS79QLi3vhman9urVGMRUc
	V+O0Ok4HvGMqxvxHoUz6rQt6jw0Qt4/krthRSQeVbi984HcQ7uOs
X-Google-Smtp-Source: AGHT+IEYCfmo678SPjgRyqoDEel50YXZKbaxwj/GIYVyBS5qUFyUi+PpF9lmSQusgp/6BLNVV3FXzQ==
X-Received: by 2002:a05:600c:3556:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-429dd26c0a9mr15673965e9.32.1723625814063;
        Wed, 14 Aug 2024 01:56:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5991:634d:1e:51b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded32538sm13274735e9.16.2024.08.14.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Jiri Pirko <jiri@resnulli.us>,
  netdev@vger.kernel.org,  Madhu Chittim <madhu.chittim@intel.com>,
  Sridhar Samudrala <sridhar.samudrala@intel.com>,  Simon Horman
 <horms@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,  Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
In-Reply-To: <eb027f6b-83aa-4524-8956-266808a1f919@redhat.com> (Paolo Abeni's
	message of "Tue, 13 Aug 2024 16:47:34 +0200")
Date: Wed, 14 Aug 2024 09:56:42 +0100
Message-ID: <m27ccjlbxx.fsf@gmail.com>
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
	<ZrrxZnsTRw2WPEsU@nanopsycho.orion>
	<20240813071214.5724e81b@kernel.org>
	<eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:

> On 8/13/24 16:12, Jakub Kicinski wrote:
>> To me using input / output is more intuitive, as it matches direction
>> of traffic flow. I'm fine with root / leaf tho, as I said.
>
> Can we converge on root / leaf ?
>
>>>>> subtree_set() ?
>>>>
>>>> The operation is grouping inputs and creating a scheduler node.
>>>
>>> Creating a node inside a tree, isn't it? Therefore subtree.
>> All nodes are inside the tree.
>> 
>>> But it could be unified to node_set() as Paolo suggested. That would
>>> work for any node, including leaf, tree, non-existent internal node.
>> A "set" operation which creates a node.
>
> Here the outcome is unclear to me. My understanding is that group() does not fit Jiri nor Donald
> and and node_set() or subtree_set() do not fit Jakub.

I found group() confusing because it does not imply creation. So
create-group() would be fine. But it seems like creating a group is a
step towards creating a scheduler node?

