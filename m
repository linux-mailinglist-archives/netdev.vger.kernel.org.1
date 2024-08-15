Return-Path: <netdev+bounces-118879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1742953674
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B8A1C21089
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6E19D891;
	Thu, 15 Aug 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="DpHCwkRd"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF829CE6
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734041; cv=pass; b=pQvWcW1eQp6nMm/SPyqIR+9Mjq2y7i0mSxCiBgRQKPH+/5s5OmUZlPXYVLw1sICKvjBJ3jCxcmNJoIJk71cUq+jjRos5HG6j5bjtOTj03ege3MkvpeTn8r9V4JDYcesK6fSYAzeN+LGEbGRKcQuDER2zaLfDYKpINzwGJDInjLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734041; c=relaxed/simple;
	bh=pkBYJrBDiQV+qst2bgeoenELBiozAL7Gvv38EWT5GUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3u/Wp9JMabCD/S/NBgLkff54FIP95u7xl3afcR/OmDLezhgXyTy+3XU7skx6wPxo4qUJGIwfM62qhVtnN1YFfMoKaG+wmkfLxgKCaK6FSmHt3AbNFf3QFzq6j7jjoJsSd9biwAMGFkrdRZaqFPuUhe4ziYMt4gGibibYBEjXt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=DpHCwkRd; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723734029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d0m1BGL1EfaIgSsR59SmFDwpfmbQD/3D5Du/VYoRIhtwbg87Pfo76Eqttw58+ag8psAq729oRZXIf3dXc105ZnCVEMfMw9tQrUugd04pls8MIcZDll0f6gGdVG2BUTrwM9GazsykC5ag+9U09g9mOU6jqx4TmDxLZ4SWCCGFJCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723734029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MLSlDo06DyGsyFA9aLNd/8Ac8QJyaJZtthBddrPJBLU=; 
	b=ZF7Joh/rjwYNzer7SUTt7addJaGZK6kSs8rNc6qjhYSISeaIVxko3opuetTk6por7DebyM/f7yOf6Ux73A2fyebueMqMQRnJwnwxCh5od6m3CTDSu/ZK+/42dDyQ1JWc/aLmQYhGOtgE9LEUbHH6+3ieSx5SYy+fEWlV0l87ZAY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723734029;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MLSlDo06DyGsyFA9aLNd/8Ac8QJyaJZtthBddrPJBLU=;
	b=DpHCwkRd20lTtrMHZWGz2FrGB2WH+QM+pFRxShLm5Ivtzn5z23Tl3d5U4Mhx46s3
	6G2s5yilp1qzH/9M73/jX4lYSp1wRuF1JFi2HGTHOdadkkr1Xry2G0i+bBKAMnVx8wX
	woa0CchsGWc5v7DJjTQajeTbbbdER6mPWKBzhN7ows4Gpgf08KMjz5w3oJhXo0hoIot
	/0ZLlNA/Ht+OlVtQd17mkYwpvnEHNeBycnfJ3McRoUOyD9Ih0QJiRflTTZ/ZXLYuxLM
	yOy8ASxgM20Ka7Jp1efjUnXtXH+F1E2GTSNIosUaAFiD0ZlfPfLU7ZCsGwGyzzuJ+Fv
	51r2oL7JPg==
Received: by mx.zohomail.com with SMTPS id 1723734027924837.2281162563226;
	Thu, 15 Aug 2024 08:00:27 -0700 (PDT)
Message-ID: <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
Date: Thu, 15 Aug 2024 17:00:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 16:26, Andrew Lunn wrote:
> On Thu, Aug 15, 2024 at 11:40:28AM +0200, Maciek Machnikowski wrote:
>>
>>
>> On 15/08/2024 05:53, Richard Cochran wrote:
>>> On Wed, Aug 14, 2024 at 05:08:24PM +0200, Maciek Machnikowski wrote:
>>>
>>>> The esterror should return the error calculated by the device. There is
>>>> no standard defining this, but the simplest implementation can put the
>>>> offset calculated by the ptp daemon, or the offset to the nearest PPS in
>>>> cases where PPS is used as a source of time
>>>
>>> So user space produces the number, and other user space consumes it?
>>>
>>> Sounds like it should say in user space, shared over some IPC, like
>>> PTP management messages for example.
>>
>> The user spaces may run on completely isolated platforms in isolated
>> network with no direct path to communicate that.
>> I'm well aware of different solutions on the same platform (libpmc, AWS
>> Nitro or Clock Manager) , but this patchset tries to address different
>> use case
> 
> So this in effect is just a communication mechanism between two user
> space processes. The device itself does not know its own error, and
> when told about its error, it does nothing. So why add new driver API
> calls? It seems like the core should be able to handle this. You then
> don't need a details explanation of the API which a PHY driver writer
> can understand...
> 
>        Andrew

No - it is not the main use case. The easiest one to understand would be
the following:

Think about a Time Card
(https://opencomputeproject.github.io/Time-Appliance-Project/docs/time-card/introduction).

It is a device that exposes the precise time to the user space using the
PTP subsystem, but it is an autonomous device and the synchronization is
implemented on the hardware layer.
In this case no user space process is now aware of what is the expected
estimated error, because that is only known to the HW and its control loop.
And this information is needed for the aforementioned userspace
processes to calculate error boundaries (time uncertaninty) of a given
clock.

-Maciek

