Return-Path: <netdev+bounces-150576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE29EACA1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A1F188C4D8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CD78F36;
	Tue, 10 Dec 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sQXm1M88"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA378F28
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823520; cv=none; b=VNuE1nppL6dQxseUkkb3mZtyd8fu+MznaGJZqQvGjFibvVw2IlGOvkwsCCLtIzWC7xm2MNNvlZaKqmtUCTMqMcvxFiXph76Cz1GRBJVay8JZCUv99giCafPrRpJUNIDrd1vYrsv163ApAv1BLHB1aj7y+l1fF1BiraW6HgRchDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823520; c=relaxed/simple;
	bh=GGrOILbE8MwT0mL7w+VGrL29pLDrtpmhouwf0CxS/eU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFi3HSdzsp6BEHY6E1c96gDrE9mjhdAnbe08UShf8EVw/wN3UV8wi6bP/Jq0Z78oYnBhcfgPj9Scpfx8mdD7ARNvPZbpr28Qh8PD3AXHLl4OwrZLRX43PfBNT4FS8yzEQZGY4RPVzoV/7XEsk1m8G72gZM2Fmoynr140k/jQ+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sQXm1M88; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B7F3B207D8;
	Tue, 10 Dec 2024 10:38:35 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BePzaIZkLupj; Tue, 10 Dec 2024 10:38:35 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3DC03205DD;
	Tue, 10 Dec 2024 10:38:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3DC03205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1733823515;
	bh=ETB1aWPmHXEi69MVb+dtViIXAd45a6C2ySUiRLN7xSs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=sQXm1M8830IvaAWjcLG0Yq8PTIz2ZA405TCqVO1dS1FXbmC5UwJMFz8XkYiIQ7eJG
	 VmAHSYpIRVOY2Q7C/a3ScGoGtMASuBjKaBBgqhc8+tymYXT69P3XItIwf+iws0fg2k
	 ZD7aG95XkIJH3UUy2KRGzYRvl4uGLRS1wmC5h9l1QE8KBFd9pC1dYx56iwEYJJRGW2
	 XRT613Dka0JVoL57RgEb1xG5EmSLw2vx19SyAYNPWpiCdH9mnxDyuGt/xefQQU8ns6
	 8EtZQEl0/ve9jHYtyksvt99Iai187wQ6id21u36N0hvxpK8g0ZigOsaGWo96snIxeP
	 EcVHugUglFsWQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 10:38:35 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 10:38:34 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 610DB3180BDB; Tue, 10 Dec 2024 10:38:34 +0100 (CET)
Date: Tue, 10 Dec 2024 10:38:34 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: Leon Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
Message-ID: <Z1gMGlYPCywoqJK5@gauss3.secunet.de>
References: <20241209202811.481441-2-wangfe@google.com>
 <20241209215301.GC1245331@unreal>
 <CADsK2K_NnizU+oY02PW9ZAiLzyPH=j=LYyjHnzgcMptxr95Oyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADsK2K_NnizU+oY02PW9ZAiLzyPH=j=LYyjHnzgcMptxr95Oyg@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Feng,

On Mon, Dec 09, 2024 at 03:44:51PM -0800, Feng Wang wrote:
> Hi Steffen,
> 
> This patch was done based on our previous discussion.  I did the
> changes we agreed on.

there is still no real packet offload support for netdev sim.
And as said, this is at most the second best option.

You need to prove that this works. I want a complete API,
but I also want a working one.

The easiest way to prove that this is implemented correctly
is to upstream your driver. Everyting else is controversial
and complicated.


