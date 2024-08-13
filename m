Return-Path: <netdev+bounces-118105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2795085D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88012828BC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A319EED6;
	Tue, 13 Aug 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZnbD1n6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9121DFD1;
	Tue, 13 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561367; cv=none; b=T/W7fIqeqYegfu0Efre900huBrmhMn2tl8NudoRkr8+wsm4ZPgFl3q3rg8h2IthbtQz/zp8/jlCglBOIP0k4e0VR/9RuH5RhaEC/715RVJIbLnGZTbniUclaEpuR48u2lyAuPwKAQXTDvbTiWq2FZGzh8y4j1iZA/hzdBfi4Gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561367; c=relaxed/simple;
	bh=vREXw95kYwA8kvX2/ZrNdGxcYOka4556U6NGc0ogOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRUzaq4jU5uDftF3FFMiUY00U8SmdeqmPEMc1Xf2BnjlQZb/Iil9cHKnrGLcws78odUPRNv3Ex9cbj93lYEKJUUQLGuzP/0kIJV0RrfxL8m2b7ZFnVW4FTbmH43K7Pijbqb/e9cmPnjcyjhJ/dzCPc3axpQg93wjFI09ZKPRM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZnbD1n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F96C4AF09;
	Tue, 13 Aug 2024 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561366;
	bh=vREXw95kYwA8kvX2/ZrNdGxcYOka4556U6NGc0ogOv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZnbD1n6ChEq3x8FTN0TOlAP6p66S+0lVOlM38aTYOcqaKNVeVGjLFtLLtnLTaiG3
	 Bp+u37/fFiCPvPKz2MtFcrfcHHjrvkOo871/a7RYsuWVVX7FrOi6xyHTlLwevXAjMO
	 Xnkp8wxINZTOxhQexh4UHxbQxlIXes2AJM3xNtmp9tzPJ/VpYk80RpIhATIaK7/XNm
	 CKUiHfPbgaAS4V7TyrOzzv7xesdeOZREvYxrKXX9JHa4VmYk2yCRVqMZ+7gdETZps6
	 I6LH/ixzl1kZei6FJYxrU7jhUa2nbNS3FmL1OJCVg16PlqM+KqOjbm/PLGPcuaLn1L
	 ZW+xXVyK+J3Rw==
Date: Tue, 13 Aug 2024 08:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <daiweili@gmail.com>,
 <sasha.neftin@intel.com>, <richardcochran@gmail.com>, <kurt@linutronix.de>,
 <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts
 for 82580
Message-ID: <20240813080245.5e5c6657@kernel.org>
In-Reply-To: <20240813041253.GA3072284@maili.marvell.com>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
	<20240813041253.GA3072284@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 09:42:53 +0530 Ratheesh Kannoth wrote:
> On 2024-08-10 at 05:53:02, Vinicius Costa Gomes (vinicius.gomes@intel.com) wrote:
> > @@ -6960,31 +6960,48 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
> >  static void igb_tsync_interrupt(struct igb_adapter *adapter)
> >  {
> >  	struct e1000_hw *hw = &adapter->hw;
> > -	u32 tsicr = rd32(E1000_TSICR);
> > +	u32 ack = 0, tsicr = rd32(E1000_TSICR);  
> nit: reverse xmas tree.

Please read the last paragraph below and disseminate this information
among your colleagues at Marvell.

  Reviewer guidance
  -----------------
  
  Reviewing other people's patches on the list is highly encouraged,
  regardless of the level of expertise. For general guidance and
  helpful tips please see :ref:`development_advancedtopics_reviews`.
  
  It's safe to assume that netdev maintainers know the community and
  the level of expertise of the reviewers. The reviewers should not be
  concerned about their comments impeding or derailing the patch flow.
  
  Less experienced reviewers are highly encouraged to do more in-depth
  review of submissions and not focus exclusively on trivial or
  subjective matters like code formatting, tags etc.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#reviewer-guidance

