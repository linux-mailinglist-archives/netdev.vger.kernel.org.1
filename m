Return-Path: <netdev+bounces-214132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAEEB2854C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA220167E8B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECDA317708;
	Fri, 15 Aug 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="tL0j3fBI"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E53176E1;
	Fri, 15 Aug 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279662; cv=none; b=r/8pomL//UJxAMCkO4pE34uABwHhmJk9mKQ6YF5IDb3U0FH7RI1/vpukU8yVxLfmjv7Ah6A1hl77cObpT0UUAD3vpXCGxPlYhQiMiwwf4xdVX1CNh4e7SuT9Eus/l6QfnQsRC1LomyVE7FOwOdVICmzsrgsLK69d2xmtkXE6Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279662; c=relaxed/simple;
	bh=ie84TTOdUlKeOX8S4BfqgLgSzEehEUdnP3cwLm9rOXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C71zVti2BAwcO7lWHLMc3L0molSlwA/cE4lTHmBSDYrYaWDjSSODno7vfxqHAqt8SusRZJaid7Nk0sqZJiBMB8I1jQG3EEcZs1nVCgUaKVVk0M6+Tshoz30jbnLBAL4fWXDqp9iofyurgjjD9mopsrL75kPjNVz6Vzv6xObgZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=tL0j3fBI; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [IPV6:2a01:599:406:5238:3dab:eda5:17af:4a97] (tmo-102-223.customers.d1-online.com [80.187.102.223])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 57FHerrx000596
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1755279655;
	bh=ie84TTOdUlKeOX8S4BfqgLgSzEehEUdnP3cwLm9rOXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tL0j3fBIBdgJRPjqkOxH2opypMGzcgHjhXqUGkVenK1lSqIVMTfz+6hDe4Rqep655
	 951rZ0brCvT1jTsCiE6V8WS8ohO22pPCRwr0h3f1Dirz0rTOhW5wJLU3UMM7E0lTXy
	 7o6cNYFQ06evM2UYPI963Dq9eidgu0Ex1e7Csbs0=
Message-ID: <1e8a17a3-ee01-48aa-80c6-cc895282de89@tu-dortmund.de>
Date: Fri, 15 Aug 2025 19:40:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>, jasowang@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <20250813080128.5c024489@hermes.local>
 <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
 <689dfc02cf665_18aa6c29427@willemb.c.googlers.com.notmuch>
 <f16b67e6-8279-4e52-82ca-f2ea68753f70@tu-dortmund.de>
 <20250815083555.0bc82c09@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20250815083555.0bc82c09@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 14 Aug 2025 18:23:56 +0200 Simon Schippers wrote:
>> Important note: The information included in this e-mail is confidential. 
> 
> You really need to try to get rid of this footer if you want to talk
> to an open source community.

Hi,
I am sorry for that. I fixed it now by avoiding outlook servers...

