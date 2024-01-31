Return-Path: <netdev+bounces-67668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C25A84481D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E211C21791
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7F37143;
	Wed, 31 Jan 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="LyHeaz26"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B837E
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730007; cv=none; b=kCadJgjZuGR6Sp2fUrqbKc8K/S1P6nn0o62EhgWbM7Ogra1GhEvPcrueeyfpvhSjhO+drM3NsTiDfJRLCykl/N8oZRxcrz3qjg7gKqyq5FRqCo0HLYJ57S1XSypue+QASIne90vkH2+zgaJeKcN7rqhDJvCoC4oGMWnDr6XgiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730007; c=relaxed/simple;
	bh=2jiGhqjMicI/2hfeerUwaA53ru7yakczaYZ0V3l7ycc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKdMDxtyVzxCntAdQQt4A0V9A47iOnJQ/ae57H5n2U5hyWif6mzpCLmlkj3IW7AC+4E47tvOCF+GufylSoZRHU1sm/k/t5F3tL5zOWeQ9ZGBTDq354G7v7QsVpOMnJoQu6Amc8FciQ7EUynQW+f8M20WVgv1tJCgdX+irnoL6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=LyHeaz26; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 5c03f0e0-c070-11ee-a148-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c03f0e0-c070-11ee-a148-005056abad63;
	Wed, 31 Jan 2024 20:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=S0KcTyQYAn+/G7AjbYvmiFHxTEzIIRFKSsv3KhUTSIg=;
	b=LyHeaz26xQEYvHzPWtAZMrRIaPOXVVIXVdyUdsYtqDmDxfl8FrduOedBPqrtJ4WI4Za8zVnE/nGxf
	 myMEgBjEGMMWzEIp+4lZfl8PERX0VVPfoG+OiDKDHnbhP3V84ReB3JI9ztfd+HvnSZeR47Zkbftbbl
	 8o8iA4mKmgb19lU8=
X-KPN-MID: 33|pLQ+lya+Hk9oRWdJUtWmQt05DXsTEuswZV3MWkvJvdK0C4OHK2tODaMJP/CY5Xa
 t9aqbXzsQGVFoNaxP8j/uTdqCo6pEssdOYVMwE8OTPxA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ZGvg3cEY6VldV5lT9RjHPIrE0qdCLB9i8k9l/AqQ8XG+nu7lazU/XVKdWSTQCfT
 ccXaPY7FqqQ6JBiXux8xO2A==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5cb5162a-c070-11ee-a7ca-005056ab7447;
	Wed, 31 Jan 2024 20:38:53 +0100 (CET)
Date: Wed, 31 Jan 2024 20:38:51 +0100
From: Antony Antony <antony@phenome.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <Zbqhy8U-o2uL2_us@Antony2201.local>
References: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>
 <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
X-Mutt-References: <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
X-Mutt-Fcc: ~/sent

HI Dan,

Thanks for reporting the warning.

On Tue, Jan 30, 2024 at 01:36:28PM +0300, Dan Carpenter wrote:
> 
> Hello Antony Antony,
> 
> The patch 63b21caba17e: "xfrm: introduce forwarding of ICMP Error
> messages" from Jan 19, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	net/xfrm/xfrm_policy.c:3708 __xfrm_policy_check()
> 	error: testing array offset 'dir' after use.

> 
> net/xfrm/xfrm_policy.c
>   3689  
>   3690          pol = NULL;
>   3691          sk = sk_to_full_sk(sk);
>   3692          if (sk && sk->sk_policy[dir]) {
>                             ^^^^^^^^^^^^^^^^
> If dir is XFRM_POLICY_FWD (2) then it is one element beyond the end of
> the ->sk_policy[] array.

Yes, that's correct. However, for this patch, it's necessary that sk != NULL 
at the same time. As far as I know, there isn't any code that would call dir 
= XFRM_POLICY_FWD with sk != NULL. What am I missing? Did Smatch give any 
hints for such a code path?

> 
>   3693                  pol = xfrm_sk_policy_lookup(sk, dir, &fl, family, if_id);
>   3694                  if (IS_ERR(pol)) {
>   3695                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
>   3696                          return 0;
>   3697                  }
>   3698          }
>   3699  
>   3700          if (!pol)
>   3701                  pol = xfrm_policy_lookup(net, &fl, family, dir, if_id);
>   3702  
>   3703          if (IS_ERR(pol)) {
>   3704                  XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
>   3705                  return 0;
>   3706          }
>   3707  
>   3708          if (!pol && dir == XFRM_POLICY_FWD)
>                             ^^^^^^^^^^^^^^^^^^^^^^
> This assumes that dir can be 2

Yes that is correct. However, this patch does not need sk != NULL at the 
same time.

>   3709                  pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
>   3710  
>   3711          if (!pol) {
>   3712                  if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
>   3713                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
>   3714                          return 0;
>   3715                  }
>   3716  
>   3717                  if (sp && secpath_has_nontransport(sp, 0, &xerr_idx)) {
>   3718                          xfrm_secpath_reject(xerr_idx, skb, &fl);
>   3719                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
>   3720                          return 0;
>   3721                  }
>   3722                  return 1;
> 
> regards,
> dan carpenter
> 

