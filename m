Return-Path: <netdev+bounces-77833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5E8732A9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AE1C209DA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F935DF05;
	Wed,  6 Mar 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ePhbZDDN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1845C5E9
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717821; cv=none; b=dYz0ZCXlsV72ZIMuH3gVgGyfCGemqPQ0y1uXDwy6JCmcNsw0w+5pIYE8iFNiK/rd+TahxsBVbFv/dRC3cu2JJIlAehQi4CXRidby34ar5ml/tHuHFJ1Ta0M2mHbJv3ZW/oA+JkbTHAsF7uOKUPEHIQEkOdnjTGNVn38Ll28mtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717821; c=relaxed/simple;
	bh=tCueLeJYiz2l9qMl1448xYobVOt6ryCPnk4FzJiaj6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da7BiXDlauZRogc4mJ98N/iFpMg++S2qoHYvyQ4tqafMD8LnYLTM05lvRO5EMBtBVGWWxqBlqClDdj/bCGg4EZNpn27f4MSYsViWZT5f1EU92N3WbqhMf9C35RPjns9FsxdXaTTDJsLNYJQVkygBBcl4knOeOnPJantQgW3FI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ePhbZDDN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3A25920748;
	Wed,  6 Mar 2024 10:36:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tke5SrWUXCMM; Wed,  6 Mar 2024 10:36:49 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B71DB20539;
	Wed,  6 Mar 2024 10:36:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B71DB20539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709717809;
	bh=IvXiDWZovdxPAm3s5YGREQ8CV6m4BMqnyvDbpPu0hsk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ePhbZDDN/ZXuFUGgyMJG8XPnNBGPlZwq3bkmwCYbPaiB5gEUSy/fquV456zSkSkGO
	 8GA+zj7VzIqF5tqonWhF7aAgcpySpFcHqnlBX68dsZXrJsycrpCZStYDK67+jVoQZY
	 q8FaUKeGljqbt6WzxrPRHTCgU/ZjzZGyoWApH+iDmiGm7migOq+4vkr0bz1lGdtt+D
	 QvsYU1MJZuuFQQ4YF4ePoENyxNu9w5VGozzkb5vB0sxuDN6g36E3oeTatrtlDx8Bwx
	 T6Upa2EV2zk/kSbrYCKlAiAL2cgirbpqIp5hOFPmKfdkhvfimnEn3cZwHTB4rJGw2M
	 dkzkpCfZabIRA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id B2C4180004A;
	Wed,  6 Mar 2024 10:36:49 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 10:36:49 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 10:36:49 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2245D3181583; Wed,  6 Mar 2024 10:36:49 +0100 (CET)
Date: Wed, 6 Mar 2024 10:36:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Mike Yu <yumike@google.com>
CC: <netdev@vger.kernel.org>, <leonro@nvidia.com>, <stanleyjhu@google.com>,
	<martinwu@google.com>, <chiachangwang@google.com>
Subject: Re: [PATCH ipsec 0/2] Improve packet offload for dual stack
Message-ID: <Zeg5MQlmC4Y4nuER@gauss3.secunet.de>
References: <20240304122409.355875-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240304122409.355875-1-yumike@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Mar 04, 2024 at 12:24:07PM +0000, Mike Yu wrote:
> In the XFRM stack, whether a packet is forwarded to the IPv4
> or IPv6 stack depends on the family field of the matched SA.
> This does not completely work for IPsec packet offload in some
> scenario, for example, sending an IPv6 packet that will be
> encrypted and encapsulated as an IPv4 packet in HW.
> 
> Here are the patches to make IPsec packet offload work on the
> mentioned scenario.
> 
> Mike Yu (2):
>   xfrm: fix xfrm child route lookup for packet offload
>   xfrm: set skb control buffer based on packet offload as well

Applied, thanks a lot!

