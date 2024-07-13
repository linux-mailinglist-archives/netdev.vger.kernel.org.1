Return-Path: <netdev+bounces-111228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA89304B3
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7080C1F221E7
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403B1CA84;
	Sat, 13 Jul 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vzS3EYcO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB04CB4E
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862272; cv=none; b=rjZG6qfYx5eQs6a0MrgJlZTFQW5YDPHYD7vfPjQmP4ePX+miabOm8Cqb/ib9mIBMkGKlvHPW6y4AnGmBv52pCL7xGBLaMj4yYJMa90ABhEwvwMeKlKOmxuiE7ooEqk+ltI54gsUuY3L0KUAJzzMldEA/EmbV94XxfRmC5yu166k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862272; c=relaxed/simple;
	bh=Pqj399Oam0q2rGp/sbUoySnoczG07nWsYgGSfNTbeYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj/ZyH+8bhIDMafFzaHMUsyZDNJfTnOzNnM+mua1hMt/meTPEhSSXVTOb2u+NIp2ySJTkrMFxvskSkMaCYjz5uZQr+AsW4gwvMJkfHVX89AePqsC9+mRWiUZfuGDU/tYqnysq79Hj7ndF2lQjlqOy5q6R2A8IADs03JzDjJLmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vzS3EYcO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BA72A20872;
	Sat, 13 Jul 2024 11:17:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TxzZnSOGpRqk; Sat, 13 Jul 2024 11:17:41 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0EF152076B;
	Sat, 13 Jul 2024 11:17:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0EF152076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720862261;
	bh=eJP2qAJB1G8MC2sgyQpbKgns1IeCyA8+3fyLlBlK/E4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vzS3EYcOZ6HuUXb9gDN4Z1nkTxdzn6oVNJQxkwnjWc8rfLInzbi/0uJSk33CPMzXw
	 wuKQ8TN6PKWbx00n68jZGA2ftzRG+wyP4G9HKqxjnnVIbGCElmwQOyfS8TzI2zJed+
	 TmPgEVT2t14uzFWF9++twEXwqLfSPUtMwahz/xrweoI7SMKSTB1VipT0gavU3VI9KF
	 6bVsHKuGLkDvCZ0hbGAyGygeMVEkuNUOJyGtgdNkPL9sa+Rr+kJXOKo9RU5LdS/V88
	 zhndKjuGKrNNgy+YfoMrMFGP09hw8inG3hC8WYFzdjYMey7X5o6VBJMp8GLuaE63J7
	 qehz3ChnJpblw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id F36FA80004A;
	Sat, 13 Jul 2024 11:17:40 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 11:17:40 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 11:17:40 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C3CFF3181945; Sat, 13 Jul 2024 11:17:39 +0200 (CEST)
Date: Sat, 13 Jul 2024 11:17:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Mike Yu <yumike@google.com>
CC: <netdev@vger.kernel.org>, <stanleyjhu@google.com>, <martinwu@google.com>,
	<chiachangwang@google.com>
Subject: Re: [PATCH ipsec-next v4 0/4] Support IPsec crypto offload for IPv6
 ESP and IPv4 UDP-encapsulated ESP data paths
Message-ID: <ZpJGM8z6mKtDH/Su@gauss3.secunet.de>
References: <20240712025125.1926249-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240712025125.1926249-1-yumike@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Jul 12, 2024 at 10:51:21AM +0800, Mike Yu wrote:
> Currently, IPsec crypto offload is enabled for GRO code path. However, there
> are other code paths where the XFRM stack is involved; for example, IPv6 ESP
> packets handled by xfrm6_esp_rcv() in ESP layer, and IPv4 UDP-encapsulated
> ESP packets handled by udp_rcv() in UDP layer.
> 
> This patchset extends the crypto offload support to cover these two cases.
> This is useful for devices with traffic accounting (e.g., Android), where GRO
> can lead to inaccurate accounting on the underlying network. For example, VPN
> traffic might not be counted on the wifi network interface wlan0 if the packets
> are handled in GRO code path before entering the network stack for accounting.
> 
> Below is the RX data path scenario the crypto offload can be applied to.
> 
>   +-----------+   +-------+
>   | HW Driver |-->| wlan0 |--------+
>   +-----------+   +-------+        |
>                                    v
>                              +---------------+   +------+
>                      +------>| Network Stack |-->| Apps |
>                      |       +---------------+   +------+
>                      |             |
>                      |             v
>                  +--------+   +------------+
>                  | ipsec1 |<--| XFRM Stack |
>                  +--------+   +------------+
> 
> v3 -> v4:
> - Change the target tree to ipsec-next.
> v2 -> v3:
> - Correct ESP seq in esp_xmit().
> v1 -> v2:
> - Fix comment style.
> 
> Mike Yu (4):
>   xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
>     path
>   xfrm: Allow UDP encapsulation in crypto offload control path
>   xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
>     packet
>   xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
>     packet

Series applied, thanks a lot Mike!

