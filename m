Return-Path: <netdev+bounces-93958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB48BDBDE
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B091C20DAC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DC78C74;
	Tue,  7 May 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eHoP0KQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F46EB7D
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064454; cv=none; b=NkBctp3WxJ0CFDha/MycR9yPOvVLS7YT50K3Dx6Md6c8yFzAZXhqXVVD5qEU2KQxoGqAX8nNe+S0KhIjoSXVxvvxRsLeS1sgFnPbhxYfgn3RFyqFiWgC/wRT9Yn0n5+i1SVvXk9WYviXtP4MHeFRW3V+B7RCIjf6MWoSkoCyQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064454; c=relaxed/simple;
	bh=0Um96f60wUfsVmEE3WMDGYPjOXvPbnW9BS7DeenTf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA+3Ijs+yhiAuD2/bBY17aFjqXZzgQ9eQ/2EN8NeDs6ocUFvRpqbRrVQ07W8yY3Ej2yyU8RjMWccZHlQlh6bfmpN4V3J1C3NQKiuKVai4+Koy/5DMe9d3tKZrUyk7xdzpZoV/6xI7e51QnI/3Ip1ry1txxnSNbJ4fBoWfpE/1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eHoP0KQd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349545c3eb8so1810499f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715064449; x=1715669249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Um96f60wUfsVmEE3WMDGYPjOXvPbnW9BS7DeenTf+A=;
        b=eHoP0KQd6iwB+pTxYUw4ud6ng7YYwpNIJBUWZDE6+xhtCVNx7f0UnWFYFTn6D1m+NQ
         8UVBrbTi0frFeoE70CZ4lBsC9gt080D639kMmNAYrWIQLdqbX34xbtcpW0JFfIAhQyB8
         LMRKut9u/eT2Lx0zjnzlIAH6nfcVfuyHdv9L1cVGx9bu/CsTMrDYYayQruYoq2Qks3MT
         Bo0Oor1cOpcD9tIkgW7E+MQE1s6mq3TREoDzjmVqYfQOmxcBUITRFXslmCzuHyjy1DJk
         eK/4vqbOrAjutLXWUrq/3EgQaMSiZuCew8+eoV7VUQ1tk9gTa7mL3Xs91mDfpaVdZBUG
         bKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064449; x=1715669249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Um96f60wUfsVmEE3WMDGYPjOXvPbnW9BS7DeenTf+A=;
        b=VaqLqgdKFbLCrQznQB66yZx7xEyz66CvNzeuJ6P1oUBDbWPI+0kvNafgp8ot2QbDKY
         memdYWATP4hwccs2MrvLwu+bCqyeNKNgzTxuv7bsggfKI+NxASy1trPJrE04r8t9Z08C
         WK73PtHpO0UOVsBWjmFDHXaeYm6hsLlIVRS7SzV0dWwZHSZEgEl1Ax0t5RshOo+EV9Ls
         Iqys9EoQS4qVdu747D4zwEP9VgPYRYb5lYRvYY6QTBTWf5Do9d37b1HrT3Rui2vFqTd2
         Qy8T7KElQZySLZcrVqbwPtvgnFU/Vn7q7NRt0r+c4zElox/K1j/d3J+CSvOxedR20h0u
         sxDg==
X-Forwarded-Encrypted: i=1; AJvYcCU1gl0UtCrS649CSTqK6A7YShyaUUIvBURowKotMdpqHpw0i7pZ/VU7JVUy5i+ErBVW9os41GNbyX4aNoFY6j11pJpTdL7k
X-Gm-Message-State: AOJu0YzyoXvLGW2PhR/tKDtarVuBE7sJPlzY6twO+m/tOUYiywlXmQE4
	yqv8kYIhhsvxAkCk9V8rqrreltsAO/SLTEb/fNGKflR8J0XAyqFTWI66/DiwR78=
X-Google-Smtp-Source: AGHT+IFQj4hesYJbnGFOAtxoVsmbJcjdyrMDFWncbLlCFWh45HmX65WDQjl0rbi3aJfE1v6WIT9iDw==
X-Received: by 2002:a5d:6686:0:b0:34d:b03c:9a99 with SMTP id l6-20020a5d6686000000b0034db03c9a99mr8854531wru.2.1715064449304;
        Mon, 06 May 2024 23:47:29 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe70e000000b0034de40673easm12269816wrm.74.2024.05.06.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:47:28 -0700 (PDT)
Date: Tue, 7 May 2024 08:47:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <ZjnOfQuM2sqv377N@nanopsycho.orion>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>

Mon, May 06, 2024 at 09:59:31PM CEST, dsahern@kernel.org wrote:
>Alex Duyck and I are co-chairing the "Driver and H/W APIs Workshop" at
>netdevconf in July.
>
>The workshop is a forum for discussing issues related to driver
>development and APIs (user and kernel) for configuring, monitoring and
>debugging hardware. Discussion will be open to anyone to present, though
>speakers will need to submit topics ahead of time.
>
>Suggested topics based on recent netdev threads include
>- devlink - extensions, shortcomings, ...
>- extension to memory pools
>- new APIs for managing queues
>- challenges of netdev / IB co-existence (e.g., driven by AI workloads)
>- fwctl - a proposal for direct firmware access
>
>
>Please let us know if you have a topic that you would like to discuss
>along with a time estimate.

I think that it would be great to discuss multi PF device with shared
resources and possilibity to represent somehow the multi-PF ASIC itself
with struct device entity of some sort.


>
>Thanks,
>

