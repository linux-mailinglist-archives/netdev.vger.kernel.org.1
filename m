Return-Path: <netdev+bounces-100160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A98D7FA8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E03B260DC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7F82887;
	Mon,  3 Jun 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="NGwz4KAY"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B137E796
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409109; cv=none; b=RcVfeKUqzvUtIpguVfJNOTXvffw5Ezky/aGmfGo8NEBDHNhRgF3aAadfsH764cRmMeixTw7TrPsCdtWHPdQr3G3+v8G1xUnWqvnC2AwPRIl2UsXXH32mC5Bd52q1jOifGYqVbIfnO/BR+6LZ+nSWEwREyBSyQQO49cTew0UQ9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409109; c=relaxed/simple;
	bh=ZlM9K7YbhnssYFwPW3MJ4UGZUwh5ufAgHkPPcrG0P7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV+4wQRg31Xq8YOujxUQTWw2BsblKubTk5c/lDC644DBaHA+Ujl8SBXP5Aov1W3OsCJzFl1pZPMCno3Y0y802q3ckKMXWQrIGVZA14RDVFzX1P3gMq36QymKiC0IFIV2ZxoXgZTl3grCtq6tzn6Iv2PQDyH2ZypVTZIHwPWNPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=NGwz4KAY; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024060310050598d2ff61765c850c81
        for <netdev@vger.kernel.org>;
        Mon, 03 Jun 2024 12:05:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MxB6k1sco2UHJP14v2p5mkih6Wnxt16euSuPKKxerCQ=;
 b=NGwz4KAYzVkMSPgmmg7rYaR5uYHyGG30+RbiBGeTBHWQ65RYxCtCBkpgPdme6jdBZ6J9Ii
 3gK2iD04MWey5MWGYArFAdS7L6eENSEzxOOmJB0pTXg1JoAUupgo/9ohd7uAxZPqD/PLAKKi
 1RMHnd4SjzYy7trMxrH4RyfImfukU=;
Message-ID: <171516c6-71a8-4dbb-bf6d-d20cfb55686f@siemens.com>
Date: Mon, 3 Jun 2024 11:05:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] net: ti: icssg-prueth: Enable PTP timestamping
 support for SR1.0 devices
To: Simon Horman <horms@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-1-7273c07592d3@siemens.com>
 <20240601120334.GF491852@kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <20240601120334.GF491852@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Hi Simon,

On 6/1/24 1:03 PM, Simon Horman wrote:
> On Wed, May 29, 2024 at 05:05:10PM +0100, Diogo Ivo wrote:
>> +	prueth->iep0 = icss_iep_get_idx(np, 0);
>> +	if (IS_ERR(prueth->iep0)) {
>> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
> 
> Hi Diogo,
> 
> A minor nit from my side.
> No need to address this unless there will be a v2 for some other reason.
> 
> Networking still prefers code to be 80 columns wide or less.
> It looks like that can be trivially achieved here.

Noted :)

Since I already have to address Sunil's comments on patch 2 I'll change
this one too to comply with the 80 character rule.

Thank you for the review!

Best regards,
Diogo

