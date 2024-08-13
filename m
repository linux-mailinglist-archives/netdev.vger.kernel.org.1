Return-Path: <netdev+bounces-118389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D9951732
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD16288101
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E214387B;
	Wed, 14 Aug 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMueW8Bn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B4143C6E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625815; cv=none; b=EfTbaG5dKyBaUXZoomYLCUyltTMbB+Ehtr9rVMqaZkb1r/BujG37yKgpEAegGpdKJLet2u+2/mEdCs8Aeyspihejxs3TvgFC+zOM2jX7TTjMcvEPloYKjEhC4f/CKxm6Ys6yT1eJXBtFMhRSxEaGYabwMkmgQ9ixiaNuMmvIQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625815; c=relaxed/simple;
	bh=Q5NNilpNu3/6R95GKpQbDjGnmR03pyw0FH1KvxcLeo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=i8CricwZ/4iE8K8NwvOH1hR20kRX4BX7jqLWNFlUObvrMZ0SLHvjGgmbXgmiqR1CjY3UMuyTwGw8HnjuzKJiecEL6oiuWbkfV39Jrkgf+hQg3DB+nfc/YCxFC5FW5rIxl+C3Mxpd3syg+qPrbm4cLoCORRFyjLGG2SyGq47ixgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMueW8Bn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42812945633so49510575e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723625812; x=1724230612; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x9PmNgOCdYK8ozABh+6LvW6sydPCuVHsQVVMcIdI6Y=;
        b=bMueW8BntnhasD+IA0QXt3Ex9wyF1176X3OaUprqLZrZ1osQWbr5Vy3JE1Dr/qLCtc
         n2QQmxLCAanGyiw3kq/InsmkoOsHzT1iUQ+OEOWk+UwcHf+9TX3m6+M/54Ero8BBGnR4
         sJh5rCCMZ4jlAPtJsjRCyWojf+wf1ho5bfQNiTzOcx7t4Z/x6MMW4sDvRNxPB6s5gl8m
         MUVFrCU9KdcJTeRIznBsRgQs8Gx0j5DOgb07Is32wPQB8v1Evz6p2um2BWIx9Hhz8jAN
         tIr4VK6huTa8Og5yqXMaGWTeu92W2toiP5fqFVwaAfXbTFjFJHReL0UB4t8afVhyMK+r
         brcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625812; x=1724230612;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x9PmNgOCdYK8ozABh+6LvW6sydPCuVHsQVVMcIdI6Y=;
        b=hAPLUYYwRBVxsOjuk0iyTF2HIHnrT8R/gBDtf0ePVRCPuGFjFA2mGGYrXm12pJNjQQ
         4fnJs8rPPG6r2FRGHy0Yt4CR0LIo8PYLay2kXI19/Khs/TEZ1u++WAJHYExoAp6nNZZK
         uOMUt6hFqjxCu8ej8bWc664T8NJvniTQ/NLhaSKs7s1oXKCeumx8xTprEI7Hn9Qp8ZAU
         uChk4lZ//XNbeHpIENhIrSNct7MDPKTkw8tCyYHKdexAZgaMQ9aWtTnByTselZ5Jp96y
         2+CdJPlv1VBzm9eWSQsP0eyVcaE5Qc7vJv6q0R4vBGo7K43dAJf/hRBHirCjywn4FzdT
         yqjg==
X-Forwarded-Encrypted: i=1; AJvYcCXGoeFnU/yXk/8D0whUzZq45S197bG/bKV5I2E9qPLD3tYbIAtVVcwSn1yz84KwjEWvFlVlXIM1myBZA5UoUQwpj8qqGtEA
X-Gm-Message-State: AOJu0YwJtlxOBqzD5b0t3Qv5eaJ8O9WAE5q7jisF5VVKVxeIwRbxxi0Q
	hxJcHoZji9eCaf+QD46LaeVyb/WktwYCnMx4F0AuYZLknVYLP3WK
X-Google-Smtp-Source: AGHT+IFXrV4FHybsxOvB6FxTbI7+KiQOIqTUVdRNV9kRMMdaf/FbNGN2cuqtVhJJp20SCfE2zpdC4g==
X-Received: by 2002:adf:e304:0:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-371777f61e9mr1388186f8f.41.1723625812126;
        Wed, 14 Aug 2024 01:56:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5991:634d:1e:51b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm12435645f8f.1.2024.08.14.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,
  netdev@vger.kernel.org,  Madhu Chittim <madhu.chittim@intel.com>,
  Sridhar Samudrala <sridhar.samudrala@intel.com>,  Simon Horman
 <horms@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,  Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
In-Reply-To: <20240812082544.277b594d@kernel.org> (Jakub Kicinski's message of
	"Mon, 12 Aug 2024 08:25:44 -0700")
Date: Tue, 13 Aug 2024 18:12:52 +0100
Message-ID: <m2ed6sl52j.fsf@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 12 Aug 2024 16:58:33 +0200 Paolo Abeni wrote:
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
> I think the confusion is primarily about the parent / child.
> input and output should be very clear, IMO.

input / output seems the most intuitive of the different terms that have
been suggested.

