Return-Path: <netdev+bounces-196928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA5AD6EE5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923E5172864
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269323D295;
	Thu, 12 Jun 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PZ0P+aa3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592D23D29A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727273; cv=none; b=jqSDiiR37q3BJ6KuqjdBN5KaM5JiHkq7wSF7Mf1kCmMPunRm35JOOr/424hIKWbY+NI1drjmURvv18DC0MgEq+Lc93CtiFBCdr+nokDeiraeLTEjCTyanqgVqYaqVWQ3eVkHjxza0Qgr2BdsHWXaACt5aZtJRcpu39zB5RXz+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727273; c=relaxed/simple;
	bh=g3kFQaxgMZqaZs3yTqAocJ8TzOltj9uv2BWplJ8Q0+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrxkVYGw22bsX5Noi4mRYFEpOKUZOi9Fsl2Hl0bJwwu21QoAyP3GZcvCDnHoOVlbIj6I07syM8aiw1NeQqsTN1tHlJWkle6P/17lFZM9PKIXqL4KxpoJlbz2CrNFaK5vO0Rr5VNjc/K7A6nQUMIE244h5eEM5WtDi6+gfq4PNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PZ0P+aa3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade4679fba7so161941366b.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1749727269; x=1750332069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=izHnPXiYoTBneokvv1hu9m+7dLFok2Jhf1Nqy0rykvY=;
        b=PZ0P+aa3jUGdyMDblBlczmn0K+F/S5C5BJTeFCCAEjLGNwDNufC775iO3ZoZcrE5tQ
         gL3g+btdTnxkTCToBS80lFsUCH8LgVsAFpxcReTDx9PRzYxpjbV0NQZMNp5X6PUfpAIq
         cvH8DYPqne9BCM4bRn9ceijVy3R4ghZsI/bsYVrNIRdV6G3ESRh3YVepvp3CCIVrzrbx
         hbS7nMpusZ68JoaZP/E4jYdT1CyDtLUhdmWA2DsP7js4CWYVnOSH9yQtC1lbOAypgm9t
         lAI+HqsePWHMA/D0nX12NRpdEG3JFH27nxbCLKFiFQ3iaBVHt5FcjXVED+e9KLadwRdk
         gkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749727269; x=1750332069;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izHnPXiYoTBneokvv1hu9m+7dLFok2Jhf1Nqy0rykvY=;
        b=S99yliQt+3cN9nauQA4IpuAalTulDYZ4tXTIY39A7vKBcy4zmAIHZLdzRGmWDdgOWa
         RtyKAQl7cKKPrB21WMoiBU/e5B4qePpnC4U2BStjw7QefOKuxO2XKjqQKYSMSvG6UrMY
         uK0kWG6P/OoYtvYMGNkspBixHL+cViOam84Yi57qlV2erPUjsobnnmi6fUcyX/u6zjG2
         7kXnC2NwwezfnKz00w6VbDTU1diZqzVo6O5tW9avtqEHuqKd0Sg2R+ECg86lX1jja5Dt
         tIxfuScPyU368DtTHaakZmP/va34s27+bYd+3DSEuMAh39TxSjMma5Twp7QNtA1oiUKe
         ea1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlCUZwpboyG2SF2SfA8gOTXQZLEN/z4GvXn2KSSBCOZWC5LUDowIJ/neVYnFqN25IKaIXIxOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93le53HWHK10w3uJykrSoBl5SgcvxBSqETas8zahWzoRvT82r
	CzseMqb98eMFnOjaueHSQcfQrKs+J3Lvp5KZCohR9HYedU6nsq94/jCJZhrSUrDcVu8MoC6mxQL
	4DT94eJzKq00x23w0EsAlhThqqcMiqaY60JtXkv/9qXcIiAaj3f8=
X-Gm-Gg: ASbGncuSj8SxBEo2NKdqB7jOB+wzyuOq3zrQchoz+7EfRAlIiKOakRZol/lDHf2W/EA
	FtATr7PETMjIVfRACrS7XVJvFK0ebspCkktDFoEXgukQo6TQkJXwngp7nV6Ix6qeHg4k36IzGD3
	gk8FFQtz3ChDc5NyOcMwK1jf8xE/F5nYmDrzQQgjUVW04LV2f+55c03ArQTJ3v51ayo4GA8hTZ7
	fE+6jePCIYnUBpyTB21BY5GMw0oibQnjGcbIZ/iZtJbwQuCFGNdqxIkl32n0h4IAkL2FcYw6ExR
	GF/hqZD4w+Lvg8MJMyQRyubcdpNjzz+gGIJSGu7QjB+DoYtVZJ2JFQbIn2reuD0mBsuvN6g/tau
	7NsFcgCF685EzW8ZCrDdhdQ==
X-Google-Smtp-Source: AGHT+IG32Jgp4TMA7lCBexDTcDiVY2kbdEbExXQqe7eQtCA22E2tcCY1TdJFi3Ti5SLLEYiXvj7ozw==
X-Received: by 2002:a17:907:7f03:b0:ad8:9257:573a with SMTP id a640c23a62f3a-ade893dfcf7mr630132366b.5.1749727269216;
        Thu, 12 Jun 2025 04:21:09 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:66f3:a0b:4137:82f3? ([2001:67c:2fbc:1:66f3:a0b:4137:82f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadf204ffsm118284366b.171.2025.06.12.04.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:21:08 -0700 (PDT)
Message-ID: <faa9f6a8-daea-40f7-82dd-fb1133010629@openvpn.net>
Date: Thu, 12 Jun 2025 13:21:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Pablo Neira Ayuso <pablo@netfilter.org>, osmocom-net-gprs@lists.osmocom.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Taehee Yoo <ap420073@gmail.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-sctp@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
 tipc-discussion@lists.sourceforge.net
References: <cover.1749499963.git.petrm@nvidia.com>
 <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2025 22:50, Petr Machata wrote:
> iptunnel_xmit() erases the contents of the SKB control block. In order to
> be able to set particular IPCB flags on the SKB, add a corresponding
> parameter, and propagate it to udp_tunnel_xmit_skb() as well.
> 
> In one of the following patches, VXLAN driver will use this facility to
> mark packets as subject to IP multicast routing.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Pablo Neira Ayuso <pablo@netfilter.org>
> CC: osmocom-net-gprs@lists.osmocom.org
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Taehee Yoo <ap420073@gmail.com>
> CC: Antonio Quartulli <antonio@openvpn.net>
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: wireguard@lists.zx2c4.com
> CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC: linux-sctp@vger.kernel.org
> CC: Jon Maloy <jmaloy@redhat.com>
> CC: tipc-discussion@lists.sourceforge.net

Acked-by: Antonio Quartulli <antonio@openvpn.net>


-- 
Antonio Quartulli
OpenVPN Inc.


