Return-Path: <netdev+bounces-74001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865085F979
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A291C21534
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF8A12FB1B;
	Thu, 22 Feb 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HhufJh1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185C12D765
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608034; cv=none; b=YbHmsmyUqGu5OXpH1kExN4CkODk8kWh5/ykgIeqLMIHMBNdSypD5aUVBoTxANfEdALmvs2IvHCSGGs93h23g444Q+kcc9BEiu8FMsjUGlKjAvgWyBsyJHqL8Ijey17QuP41IevBYqAeUkDqeIYm2muI2+HZ/BPrVPlH9y31sSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608034; c=relaxed/simple;
	bh=y60R+fxbq5IO1xAmXaFuT9eyxV74fu2ONd3S9O6wCnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tufYx8W6Cqw7mDCqvTeBFzikZfdk1TWRATEMm5vy3NkV5BCCOYVH/MCa8gZMtwV7ekYoxGlwAHliRISCJIaiS9BoDk3tPQfPZ+R072ywA/tPQbODIaTEWEq6Ly5GFg/20w7L05LIFCGlNI9ZNIjmMmEsTDGpKz7d3flwzU47zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HhufJh1x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394bec856fso483969f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708608031; x=1709212831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Ll1dU0t6K2RWNPKtSE1M2pQ7/eD0Hp4azUrEgnpNI=;
        b=HhufJh1xOTb1pRyZ5ZyroYchl+XvEzzw5z2m9rn4z3B3KufSHmAhnorXn8izWCJjVt
         vA+l0izNMaRzDm0j7frZEf7oAW1+HpyBG1HSCVe82+8j1DEA/fTnn2wgOYJpnTnf9aam
         iqGGKObbL8e6B2NwWahkprc+886aipR1Ki8SSEi3OBSwkWEPES5NoGrrJZc36TCnzk1g
         mPaEk0ejKi5xrJFRReySNi81pbBigXlmmh3oFrJWLvjV3/4NMpj1zLKnvrXHnSyQUEUm
         sRsh0y5TEUI9o0BrjRsgMWtgsJkXPc0lbufcKswZRD9qR4SgwpZxGAC/j1V/D3ZwSf6a
         34eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608031; x=1709212831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+Ll1dU0t6K2RWNPKtSE1M2pQ7/eD0Hp4azUrEgnpNI=;
        b=QGJVEnbzQqVbeNV0Ll9mQEO9/a8IITF5MGN6H1bIyk4WY1gzq3Qv2B0KXrc9jT0nHJ
         DvVdCp5FkpUoAkiaDTiBa3E13UjiDiNrlLjplYPmRmZEQS7E7s9mbcce3EJi2iVp70ZV
         aSWx4PYWKDWfer5bR4OjQUBEZpB5k/RxbkBgx8PfsojCAS4sysWrp3ecZwkz1N/es6Lb
         6pgOqmKAWC4cIfgGdQRqfmnx5zFyCGsN/HtUw7KtqVZywWPtmS6efhdLtxQyGJTOxVLy
         saEEiuPPIo325tNsCOE+ZzWJ8E6VVm7GIsaNmCZgFc4AwvkjNj0NJ83P0po8M+y4XHtG
         WTlA==
X-Gm-Message-State: AOJu0Yy8w9BueWAKv4oR9bQnGeyoJVb45ojNFoVxXv3utc62uxhPzv29
	x+lT00y1ZHwxz+nIYq3xfMlTAP5QSL9a5SpB8Ow6X2ZRsawLp1VihO7+z6nnE9k=
X-Google-Smtp-Source: AGHT+IElHwo6TPyl8/MgeNmnD6eqI6PkuXATdUmtwNFcwrMauZae4V1Zbi4z3KLfHq3CkZNwHY4g2Q==
X-Received: by 2002:a5d:4578:0:b0:33d:119e:2ca1 with SMTP id a24-20020a5d4578000000b0033d119e2ca1mr2209965wrc.5.1708608031188;
        Thu, 22 Feb 2024 05:20:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004122aba0008sm22341925wmf.11.2024.02.22.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:20:30 -0800 (PST)
Date: Thu, 22 Feb 2024 14:20:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <ZddKHCNy5pEVnQKL@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-7-jiri@resnulli.us>
 <20240219145204.48298295@kernel.org>
 <ZdRVS6mHLBQVwSMN@nanopsycho>
 <20240220181004.639af931@kernel.org>
 <ZdXxDZIAM5iLlO55@nanopsycho>
 <20240221104505.23938b01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104505.23938b01@kernel.org>

Wed, Feb 21, 2024 at 07:45:05PM CET, kuba@kernel.org wrote:
>On Wed, 21 Feb 2024 13:48:13 +0100 Jiri Pirko wrote:
>> >But TC and ip-link are raw netlink, meaning genetlink-legacy remains
>> >fairly straightforward. BTW since we currently have full parity in C
>> >code gen adding this series will break build for tools/net/ynl.
>> >
>> >Plus ip-link is a really high value target. I had been pondering how 
>> >to solve it myself. There's probably a hundred different implementations
>> >out there of container management systems which spawn veths using odd
>> >hacks because "netlink is scary". Once I find the time to finish
>> >rtnetlink codegen we can replace all  the unholy libbpf netlink hacks
>> >with ynl, too.
>> >
>> >So at this stage I'd really like to focus YNL on language coverage
>> >(adding more codegens), packaging and usability polish, not extending
>> >the spec definitions to cover not-so-often used corner cases.
>> >Especially those which will barely benefit because they are in
>> >themselves built to be an abstraction.  
>> 
>> That leaves devlink.yaml incomplete, which I'm not happy about. It is a
>> legacy, it should be covered by genetlink-legacy I believe.
>> 
>> To undestand you correctly, should I wait until codegen for raw netlink
>> is done and then to rebase-repost this? Or do you say this will never be
>> acceptable?
>
>It'd definitely not acceptable before the rtnetlink C codegen is
>complete, and at least two other code gens for genetlink-legacy.
>At that point we can reconsider complicating the schema further.

Okay, will keep it in the cupboard for now. I would definitelly love to
get the devlink.yaml complete. Next step is to generate the uapi header
from it replacing the existing one.

