Return-Path: <netdev+bounces-97388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B148CB384
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762DF1F21195
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81A130A54;
	Tue, 21 May 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="aJ5lZZok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp110.iad3a.emailsrvr.com (smtp110.iad3a.emailsrvr.com [173.203.187.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A92B9A7
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316311; cv=none; b=FM9+Z51clNh3e2aCRblzbZn/+8NP1t17onx7RDwhgBSC5aB9P6SbnVRr+tSaQ5rdqzZ5WH/xy6nsnmfO6sQxpHhVAf9nXVt6YH6TU9ycxXbhh6RxBuBHMG2kG//6MxjRd9hVCTRMHkVT6P3iQPhYo3BkDaKg2OtGpS3XVDv7guM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316311; c=relaxed/simple;
	bh=mXg2m7FaBh7geKTtC/c09GEHC57YZLr2naympotFbfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGRd4MD3ttfOCkIt9FhsZa6GQgLXjQF4bCdbQilbCTRN27skzuM6G48PcApU4erQKn6UEdmFmbp2IIr50piaQP464rFSTvbJvlZvWrH4SmUIxFxlZJkwsOljiqbuXaqbIef1JFItVgUYHAj50f9mESqugtQQUU972rygw6bYu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=aJ5lZZok; arc=none smtp.client-ip=173.203.187.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716314198;
	bh=mXg2m7FaBh7geKTtC/c09GEHC57YZLr2naympotFbfM=;
	h=Date:From:To:Subject:From;
	b=aJ5lZZokxzaR/t4WX1otFlmoJ6tHyM5YEXU9peFa81uzfFJPoUAXVLhoTnmJvRtHN
	 GWaIfQJ0+4P9wEei15Pyakg29cp5eOVkji4oOPB8cXf2XRJC+TE1TzTbNDH8FkqW99
	 65xu9mhfSRMyX2SO0/URPpyVYbSopmtyMCPtc7zY=
X-Auth-ID: lars@oddbit.com
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id C7D9725133;
	Tue, 21 May 2024 13:56:37 -0400 (EDT)
Date: Tue, 21 May 2024 13:56:37 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>
Subject: Re: [PATCH v2] ax25: Fix refcount imbalance on inbound connections
Message-ID: <5hsingm5tdmbdnbvx2yksu2n2edqprpm6mgzodjcq4wgwksxbo@vcnxk3luaqw7>
References: <46ydfjtpinm3py3zt6lltxje4cpdvuugaatbvx4y27m7wxc2hz@4wdtoq7yfrd5>
 <SJ2PR18MB5635B7ADC7339BEDB79B183DA2EA2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR18MB5635B7ADC7339BEDB79B183DA2EA2@SJ2PR18MB5635.namprd18.prod.outlook.com>
X-Classification-ID: 68cc4d66-4adf-4eab-bc9f-58be46a5af1b-1-1

On Tue, May 21, 2024 at 05:21:40PM GMT, Naveen Mamindlapalli wrote:
> > socket *newsock,
> >  	DEFINE_WAIT(wait);
> >  	struct sock *sk;
> >  	int err = 0;
> > +	ax25_cb *ax25;
> > +	ax25_dev *ax25_dev;
> 
> nit: Please follow reverse Christmas tree.

That is a new phrase for me; I had to look it up. Do you mean this:

        DEFINE_WAIT(wait);
        struct sock *sk;
        int err = 0;
+	      ax25_dev *ax25_dev;
+	      ax25_cb *ax25;

Or should I apply this to the entire block of variable declarations,
like this:

        struct sk_buff *skb;
        struct sock *newsk;
+       ax25_dev *ax25_dev;
        DEFINE_WAIT(wait);
        struct sock *sk;
+       ax25_cb *ax25;
        int err = 0;

Thanks,

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

