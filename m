Return-Path: <netdev+bounces-79042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D585287787E
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 21:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6865E281459
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80C26AD7;
	Sun, 10 Mar 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="MXZztNnA"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE9364A8
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102860; cv=none; b=Cw5fPf+/2QYcP8wK4dcjsOvORlaVCliSHTKl1t/NWHeYS7jJnEVJyptPZpnTTVLR7BAFY84t4sYPqQinHc0bgeDgeDnLYFFRUIA+2TWDejylZOXbG7f47i7ZMwT4jmSpAsvppmSSvVavmfHWeU3MA1bfnplCUrF2JkcJMO7a0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102860; c=relaxed/simple;
	bh=+27t3PBzEXSnygMWOxxSBcOEyReXr7/ZQAf3uEHuxcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isvkD/PM5ET1IKRoJX6jTM4FTwO3qT+bPoD8BhG1XVDcD16NEH8cVqq4fHI08Gu/S5X7KhPqQb1MDezxH6EL3Vq6wVz2jvlxwwQ3CY73EbM719LmRkNBbVxp4ndTVXG8MLat9Tg9k7wDS3lOXxyb446HKTXILuhcQwHZVVCkAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=MXZztNnA; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 8067abe3-df1d-11ee-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8067abe3-df1d-11ee-bbc8-005056abad63;
	Sun, 10 Mar 2024 21:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Dkca3Hlu41Lb+0KayeZY6w2Eoww8EeG2ayjXky7TAes=;
	b=MXZztNnANpBlFgAkps0Z9n2le12w37wLX/hSc1h9cupwCJlP0UXYk4cS9byvfaOO6Ox5ytmAIJRsb
	 cWJ+r0fZgbQ4qIW799PNukfCgwL6YEh6cjo1rc2/NRn1AKZNHdMfAgZMSgM8+lwHV6YMl0fxzWHsRd
	 g352v9oQnHubgXXU=
X-KPN-MID: 33|5AHn2JLd7OulXmkOmdeGNeNJrSQ+HKgVxTpvqRsUUDwBfUNu/EJOcui8LVbaYQ0
 Mbsdv7mz4zznaS3S3wdb33uUpRaiNcaxCAtikUMFNPPU=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|WGs4WdFxS8nTV0P0Gj5ycNRIiHr8jf+1c6ldE9qpQ6DQWfYgkq4GTLhbkSU0rD4
 7jOEnVe/iOycO7OxK1c4GJg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8ab5e75d-df1d-11ee-a20a-005056ab1411;
	Sun, 10 Mar 2024 21:34:08 +0100 (CET)
Date: Sun, 10 Mar 2024 21:34:06 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: Antony Antony <antony@phenome.org>, devel@linux-ipsec.org,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Message-ID: <Ze4ZPkyhKiMb6kSP@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVY9Bh5lKEqQCBrc@Antony2201.local>
 <m2edcmz3ok.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2edcmz3ok.fsf@ja.int.chopps.org>

On Thu, Mar 07, 2024 at 06:05:37AM -0500, Christian Hopps wrote:
> 
> Antony Antony <antony@phenome.org> writes:
> 
> > On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps via Devel wrote:
> > > From: Christian Hopps <chopps@labn.net>
> > > 

> > b: In xfrm_state_construct():
> > 
> > if (attrs[XFRMA_TFCPAD])
> >     x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);
> 
> Can you explain this more?

I haven't used it. I just know it from *swan code. And I wondered how it 
would work with IP-TFS. Looking in the kernel code, I noticed, it is not 
allowed in xfrm_user.c

 270                 if (attrs[XFRMA_TFCPAD] &&
 271                     p->mode != XFRM_MODE_TUNNEL) {
 272                         NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel mode");
 273                         goto out;
 274                 }

