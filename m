Return-Path: <netdev+bounces-98455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90A8D17E3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4082A1F25D77
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828E169AC9;
	Tue, 28 May 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ztKF169g"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C317E8F4;
	Tue, 28 May 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890227; cv=none; b=kW9gsFD5dn/y4DerzMHJv2W7jcTZ9EqYydlFWrTui+14Y1BkwklbJoJSq9RXNYOGHw0fX+wpTNUa7asEpJiadNkk4bjuyfWnPQ4pEJRsQ8DtsdwHMXAzblV4io16727pf44IZqvev75YJDISPJjZZV9pWFVaEp/3FpskWiXG8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890227; c=relaxed/simple;
	bh=y5z4GbSeQXW8JH0VzKQMyVb21xnQikEGwBxqYIlqccA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W29LIp7Cni7YM0t5LxLLgEnOD8olLzMspxab1H8HOJgkdcOdzG+IWKO4Cj/J2oJeUlrTTkNfU6UUM9Wp3fgidiQvmsTS4VLJnepPbtSVlrrYXYnLeNsvzISUnZ8tt9k1/9JlH0B1D7w0dhcPynwgm9aF5xcMH40aE8KsfCiWMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ztKF169g; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 89FB82058E;
	Tue, 28 May 2024 11:57:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7u6tS9wgAtF5; Tue, 28 May 2024 11:57:02 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0C672201AE;
	Tue, 28 May 2024 11:57:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0C672201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716890222;
	bh=6Ot/GFVOjRUsBu7RKou1Q5f50QI9v1WxPujt2anjQ/I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ztKF169gacjL8tbdNG4r9VM93scUMuK0GfpeXwKqFew3mxX7Vme+x5IjxRjharmRS
	 I9HcW3w0dMSxP0SPhPRtB4zRzOe1Nk/abL65MEIsJor4nveMjmgPxkQY32o7AOqN8M
	 GIWLMhSTvVBTMHXt+aKFcyNZQ6vSRS9v7IPT7lSvLVi6LTZjNvQAMB49sHZfHS+8/G
	 oGIAJ8YcRAoi5YkXXeWvoMBZT+j/Izn8LLgg+LcDg0p7/A7HYK87NWFQQxZT8ob3Cn
	 YyO1vvmeBlDlm2ZCRphICE7S8FTQq4K8gc7uRJ9QwgdhFR7f+CVqJn+v4hcQNmdsRi
	 Dh718nx+6fRkA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0038A80004A;
	Tue, 28 May 2024 11:57:02 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 11:57:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 May
 2024 11:57:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C8C7D3182545; Tue, 28 May 2024 11:57:00 +0200 (CEST)
Date: Tue, 28 May 2024 11:57:00 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hagar Hemdan <hagarhem@amazon.com>
CC: Norbert Manthey <nmanthey@amazon.de>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	"David Ahern" <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sabrina
 Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: esp: cleanup esp_output_tail_tcp() in case of
 unsupported ESPINTCP
Message-ID: <ZlWqbN01WEtPtxW7@gauss3.secunet.de>
References: <20240518130439.20374-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240518130439.20374-1-hagarhem@amazon.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, May 18, 2024 at 01:04:39PM +0000, Hagar Hemdan wrote:
> xmit() functions should consume skb or return error codes in error
> paths.
> When the configuration "CONFIG_INET_ESPINTCP" is not set, the
> implementation of the function "esp_output_tail_tcp" violates this rule.
> The function frees the skb and returns the error code.
> This change removes the kfree_skb from both functions, for both
> esp4 and esp6.
> WARN_ON is added because esp_output_tail_tcp() should never be called if
> CONFIG_INET_ESPINTCP is not set.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>

Patch applied, thanks a lot!

