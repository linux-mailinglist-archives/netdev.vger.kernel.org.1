Return-Path: <netdev+bounces-176370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D531A69E9A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 04:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084B03B0723
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770371922FB;
	Thu, 20 Mar 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNSZ+sLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B444690
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440428; cv=none; b=h6TbctBGZH6tXbW1umyNCKjGFB6iKSd2F/Itgbn2U+qrF9GWKScSsGtjF/Ro1o2bWn3pyW+kD61anuFBR1XEMmsJwFDOG1wpLQLOFFBGvGR2yohErhnCpnETEGXilBkTnYH6o9b2ygRHe2atAfXxEEDEprxAPYwv8FwFjy53Tfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440428; c=relaxed/simple;
	bh=4KysB+ELdJJCmolhi4dAM1Wb/Yix89nUIiKUgDf7/eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McKqqT67aqtiQeUVVe1R63Gj/nUrql/wd9/HD8Cb0/aEmrvrpLXVDCdzmR0NNFRK1ACEh75s+LNBGMj0I0nAASY8ku2dGccuzSzQwyiRBh2C5xfk3F+5noiyi9y9nJnck9n+hhY8569kttw0Z8/Q2IdN7XYo/ybbQeK/NQWxfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNSZ+sLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69682C4CEE4;
	Thu, 20 Mar 2025 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742440427;
	bh=4KysB+ELdJJCmolhi4dAM1Wb/Yix89nUIiKUgDf7/eU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VNSZ+sLHujcJtULn1Z7CDlEKkcOsxiqTYc2K6W6m51FQSBRnkW2H9vpkgml4nNkB9
	 +majgPffdJRS+XV7LYpP362Kej5diIbTHD6PkWHjQjPKiRak6KU8T0wVDuSiLKMR4S
	 IGBxTcVEZOpxGUVtelqGxpYrJ2Iky5VbS5nvQn+lj7/0AcRe/Im25EYR+m20Mya3zB
	 M6AHpCWFc8wMLZgMFVB7/i2k1uu1JH7sljdD/61Bdxro1vZY8fQagVrrCEPuF0aB5K
	 C3GPKrchnjjiC8Od9rUEHdSDV+nko+E7g33mDL8QR+fJFQAvopxv1ckuyjxjRoceV1
	 HpvcFtpfXR1xQ==
Message-ID: <a985543c-d273-4ef7-8218-d65aa4f4ae36@kernel.org>
Date: Wed, 19 Mar 2025 21:13:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/7] nexthop: Move nlmsg_parse() in
 rtm_to_nh_config() to rtm_new_nexthop().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-2-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> We will split rtm_to_nh_config() into non-RTNL and RTNL parts,
> and then the latter also needs tb.
> 
> As a prep, let's move nlmsg_parse() to rtm_new_nexthop().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



