Return-Path: <netdev+bounces-217844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB7B3A1D8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE81A054CB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13504226D18;
	Thu, 28 Aug 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="e/XqTu1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qk/CjE/p"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401A221FD4
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391148; cv=none; b=ElANdrola5o/FNwBI0W7UOaOzG6HNb0ExmcYqSR4qnzOkyaNsz+nJsyNpbOvR1yLdDrBd8zP1ZLW29xbqj9KYsdcbVKzkY9dPjqm8Zd446Jhn/dJPOENBXghATXMY3aVhVjawq8eNRhsmkJuRZdsO8NQY8z+QRDvJUr9pwJseBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391148; c=relaxed/simple;
	bh=F6VqxXcd7gMQAeJsFTpgccTQQlEVIi6dPmpM2+2ms7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdQvnZlBaB5g9IKTAcsU5aeLPsJfAH/UK4ZVkR/0+Enw1AfBP5Dpohq8+6uw5vpGmfbki/198HRtsVjzISasXwomMYNh3l9nemmh4Ev6WDBLkimWkCc/+pJVpF4WARTh2xuLro0Q5hEcaG+M6LnJk7zcWTRGcMlpsvOPXAGE9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=e/XqTu1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qk/CjE/p; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B038F1D0019C;
	Thu, 28 Aug 2025 10:25:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 28 Aug 2025 10:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756391144; x=
	1756477544; bh=Ss9j9JOgRHUg9vUlmS7rRHqeo72mNq9RCiP9R+jD9Z0=; b=e
	/XqTu1DV0I+Zu7qRZZaCu90MbCc5psZo1J8uCFAC1M2oFU1n02vwvSOKqSqkhY6N
	EyMjdl8BeEeffRAEhtlf7xUttfuVyDpzJX+Vk0zRBYKoMQgQxi+t2fGSedvxqtUq
	ahULQTjHdV8QbaIfMkhDylCItS20e6OYH/aJOiX38dLVqzQfWIL/vbgd0gzcGZpH
	0mVPyL6awoXH3xTSCFtGv+KagRMwGHfwrp+TY0c81YaO4W7o/fGpAOd2KnWA+rvS
	ZyBXiSMB0g3tePVOHI/27Z34UZewvz1RAXeysgfgbX10LNrqASHGcTUuZYki+C4f
	HCu2xBnA7a5ZSAJVibf9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756391144; x=1756477544; bh=Ss9j9JOgRHUg9vUlmS7rRHqeo72mNq9RCiP
	9R+jD9Z0=; b=Qk/CjE/p7FcGO7mJFRCz94FPaqgzu1+EoPC98CwkmPUMGZC1JI+
	tH1I+Ljse/yDuwKNQBC+wccAHO8wM3z0bSaz/UB6uHnd1dJf/pTZvLYE/f+AvN9P
	cmTKEpxiFEXteVtROYwgFzkUyRCN8D3YXzgg1o++vjzut3bj1+XoTtNoiSZYF2zD
	QE4lv0+bUnV8qUEbR4Ezm4Gql0ASh+CnJfSZNycl+e6ZnX6GmuE6insZo54XhImy
	Oz4faH8/lW2Qkg6+sYU7sNSzJc0NCsGrHVKKX9Xe+lGecRBkTALTUAbKsv1RF3nV
	l/KqzXc8so45S/Ie9kPkyRYlAezdHx8QaiQ==
X-ME-Sender: <xms:6GawaNrh96mgc7csAexcuxHARTp4Yut-Zy0lBaLIFI98TwYLPGEwlQ>
    <xme:6GawaP37tYgHAGuDhP6IQLDJwtyVfUeICaMsd9oVPiNa3DJ5JUJR7gmRnEdN4RjVG
    lJVsJcNEGIHXjLVAuk>
X-ME-Received: <xmr:6GawaMDh95BABJZ-0P_9_Ibzveyfkb4YG-yiqQsB-XVWhe6Wjno36dcJ4o0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6GawaHccJPUTzvNAz5eXzS1cO3jFWFTKBZHwa6q_LO1LbLDsJbVJfA>
    <xmx:6GawaBj0Pt9-kaTaHhkVgr1EBIj7fj7hEH9FQeUpRPx_QzAJcEcfpQ>
    <xmx:6GawaPow0E4VP-mdoa2d6tppUQdmF9NMj-iXBbkzMVS1BeDHeZarow>
    <xmx:6GawaBFu7z4OomA-mw_Md8zVg4ti8bGFQWaKCJ1X0bPL5H9vFfZbyQ>
    <xmx:6GawaJM4OF8_Dw6vMiAm0k_1oZQEVzejw7r5Mp50O9K6N_hyj_lrdA9->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:25:43 -0400 (EDT)
Date: Thu, 28 Aug 2025 16:25:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/13] macsec: use NLA_UINT for
 MACSEC_SA_ATTR_PN
Message-ID: <aLBm5t5nZtILh8YN@krikkit>
References: <cover.1756202772.git.sd@queasysnail.net>
 <c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
 <20250827185415.68d178c3@kernel.org>
 <20250827185540.3e42dbcc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827185540.3e42dbcc@kernel.org>

2025-08-27, 18:55:40 -0700, Jakub Kicinski wrote:
> On Wed, 27 Aug 2025 18:54:15 -0700 Jakub Kicinski wrote:
> > On Tue, 26 Aug 2025 15:16:24 +0200 Sabrina Dubroca wrote:
> > > MACSEC_SA_ATTR_PN is either a u32 or a u64, we can now use NLA_UINT
> > > for this instead of a custom binary type. We can then use a min check
> > > within the policy.
> > > 
> > > We need to keep the length checks done in macsec_{add,upd}_{rx,tx}sa
> > > based on whether the device is set up for XPN (with 64b PNs instead of
> > > 32b).
> > > 
> > > On the dump side, keep the existing custom code as userspace may
> > > expect a u64 when using XPN, and nla_put_uint may only output a u32
> > > attribute if the value fits.  
> > 
> > I think this is a slight functional change on big endian.
> > I suppose we don't care..
> 
> we don't care == the change is not intentional, so in the unlikely case
> BE users exist aligning with LE is better in the first place.

I don't think this is changing the behavior. The previous check was
copying whatever bytes were in the attribute into a u64 (incorrectly
on BE) and setting the rest to 0, and then checking that this u64 is
!= 0. The new check is reading the value correctly and also checking
that it's != 0.

Converting the nla_get_u64(MACSEC_SA_ATTR_PN) in
macsec_{add,upd}_{rx,tx}sa to get_uint would change the behavior on
BE, but the current code hasn't worked correctly since XPN was
introduced? We use 1<<32 instead of 1 as our PN, which doesn't make
sense when using 32bit PNs. So I think we'll want to change all the
nla_get_u64(MACSEC_SA_ATTR_PN) into
nla_get_uint(MACSEC_SA_ATTR_PN). WDYT?

-- 
Sabrina

