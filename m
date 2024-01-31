Return-Path: <netdev+bounces-67670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B685844841
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BB228BDBC
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30093AC26;
	Wed, 31 Jan 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAKdr37o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C453B189
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730608; cv=none; b=YJ7P3hYV1myg4W4CV7e/e8L6j5+MGL6WsnSQoM5pI5iPPZlDB2lPTgHQhVoZqXaeE9GOgiyo7sytqmK6/B5DxnB881bzeD8hBvp/krdmbi4jjOsR+ULVPH5EVTw4v9d6gyT9fddRZaORVb5VwuZePyAmoNsyMDjRyzdpa3bgAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730608; c=relaxed/simple;
	bh=5rifOvdyD9y2Exp2LqPVvFpk3zEaq3fNuzC4UFn/QYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/pLfkH+G0MHkavDmpjg8G3MpQ4FFYBERuGr5td2FpnTjQRccfHD4G7BpRQkvpYMU13tdu8BL8hv5OKVzNfBBhDhZ/7PpZ0MnlKd2n0cuhDMm9CEnBoOZNrfbpYOuknzO6v0oytWeKUpnk49aN1Kscpr+kKXCMTSde//RfovpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAKdr37o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so1688845e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706730605; x=1707335405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VASVD0MZ27kuNPKaRL04puCP3S6vgLRDMnfORCUnd00=;
        b=cAKdr37oYpxU/rqaRNgzP9KVpi0uXSGMegneFwj56uRcFtmGAU0zwSBhQGWSSn2RYx
         mXqUQXx5/tpNyZl8DdBMt1xfMq+jsGfZWm8hbeQsGTJw5BqOR0prIfzHqoaDkxsaJAVq
         rJAdUjSEIVGxIk+Zq0XDAKtALjm3ytWbmEs4EQF0H5kYPK0MyZqlbRT6G4xlnNyessh3
         M/zTEOHmNiPld3IFPqMcDp/VWLPLmoY44noM7uQoOMzR8LXFzkVgS2cKXoRliM8odbIa
         yU62/KxXOSPc0YOTeet2d8SsRbg/y5MllcGl5yXm8ZIDzmqigd0Xz74A01/MkpPeTKNi
         Rg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730605; x=1707335405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VASVD0MZ27kuNPKaRL04puCP3S6vgLRDMnfORCUnd00=;
        b=BVHKyM/ioC+89s6JPkid+lvycIuv7hlFnCwnDo2ywV5A/VmKPPlze8ZxJE+3MB86kT
         EAdBXR0SGWwXwCrRykqQHbjKK/mA3TdMlax2rHV2BVe8CS/K7AWPoCPYp5UXydS9y7/s
         zalA8hou3RwEeTgFeci8qP5tdGy3XOGcaGYp1/Chi00E2TH4G2S8a27C54YXVvAx/VFy
         vAnCmvmAIInoOwrgo9UVLgWMs3TWpWSDO58mR+hiHdzCM8mq4qeQ/CfWlGKo7PNALcwt
         UC4DuvbKEYrGkFGJK1SbCK+X62i5SEvoh3cw3wDrukejKIHXsET3auK4Sd9AEX+IyUCI
         rDDg==
X-Gm-Message-State: AOJu0YyB+FmgJ6PTjMBD7e5OKfqm/TwgxQ242/M0rlNtsnn6fQlRd6yz
	tPftoh8yFhs1v2Xyws6Gr40XMotoNi2lZw6IIsxlRfJ64Th8eDwCP6B0Yr3GcPg=
X-Google-Smtp-Source: AGHT+IGuDQusJsWajI7v0AaY5F7neNpQ56WLXzlVKUPN5AJGmXVojRjzMHOc041Zm6QA8h7ulWcRyg==
X-Received: by 2002:a05:600c:54e2:b0:40e:a39e:461f with SMTP id jb2-20020a05600c54e200b0040ea39e461fmr2372349wmb.38.1706730605126;
        Wed, 31 Jan 2024 11:50:05 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b0040e880ac6ecsm2452260wms.35.2024.01.31.11.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:50:04 -0800 (PST)
Date: Wed, 31 Jan 2024 22:50:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <435ce833-c841-46e1-a20f-a067f0e5c8b1@moroto.mountain>
References: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>
 <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
 <Zbqhy8U-o2uL2_us@Antony2201.local>
 <c973a8fc-2baa-49e8-9c8f-fd63ef348f92@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c973a8fc-2baa-49e8-9c8f-fd63ef348f92@moroto.mountain>

On Wed, Jan 31, 2024 at 10:48:02PM +0300, Dan Carpenter wrote:
> On Wed, Jan 31, 2024 at 08:38:51PM +0100, Antony Antony wrote:
> > HI Dan,
> > 
> > Thanks for reporting the warning.
> > 
> > On Tue, Jan 30, 2024 at 01:36:28PM +0300, Dan Carpenter wrote:
> > > 
> > > Hello Antony Antony,
> > > 
> > > The patch 63b21caba17e: "xfrm: introduce forwarding of ICMP Error
> > > messages" from Jan 19, 2024 (linux-next), leads to the following
> > > Smatch static checker warning:
> > > 
> > > 	net/xfrm/xfrm_policy.c:3708 __xfrm_policy_check()
> > > 	error: testing array offset 'dir' after use.
> > 
> > > 
> > > net/xfrm/xfrm_policy.c
> > >   3689  
> > >   3690          pol = NULL;
> > >   3691          sk = sk_to_full_sk(sk);
> > >   3692          if (sk && sk->sk_policy[dir]) {
> > >                             ^^^^^^^^^^^^^^^^
> > > If dir is XFRM_POLICY_FWD (2) then it is one element beyond the end of
> > > the ->sk_policy[] array.
> > 
> > Yes, that's correct. However, for this patch, it's necessary that sk != NULL 
> > at the same time. As far as I know, there isn't any code that would call dir 
> > = XFRM_POLICY_FWD with sk != NULL. What am I missing? Did Smatch give any 
> > hints for such a code path?
> > 
> 
> I wondered if that might be the case.  The truth is that this sort of
> dependency is too compicated for any static analysis tools that
> currently exist.  Smatch tries to track the relationship between
> "dir" and "sk" as they are passed in, but it will look the relationship
> information when we re-assign sk.  "sk = sk_to_full_sk(sk);".

s/look/lose/.  I'm tired.  I should go to bed.

regards,
dan carpenter


