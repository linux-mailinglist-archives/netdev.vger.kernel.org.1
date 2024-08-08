Return-Path: <netdev+bounces-116884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0388494BF84
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338361C21F0C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121018CC05;
	Thu,  8 Aug 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkH4tGtr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83D148316
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126860; cv=none; b=Zwoi6u2TDr/LSHN0PGzQxSo6+kB0X1OtVmdUrudIHyMIuvusaf/SGcGby/DbSBPe+la9X1eyu+AASydK34YypAWL1/HpMbuzcc9Frhgf17I9FadWz7fZ0DQBKvSpgloFoy7hJC0zt+T6iybNE5w15WYu9rV88UBPdIIIEGr6Okg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126860; c=relaxed/simple;
	bh=FcGF36TBWHJtKexABNo42UKivkTYDrcajYqTkssd2os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFKMIAuLd//phXqu1thQ3JJxvlo7SHai3QwXLTMuUedIrq91SlxfVFf6smDk2PINJiEqQyQkBRAxC5/E6dwh9E3LTReV5GWZXpGtvqu5gcnlxXo3GOQmh3qV44RLHg+IuDuY6D7pk1c+7N77jCjCzJDLQlWUHpSv/wvUE2pVxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkH4tGtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F8BC32782;
	Thu,  8 Aug 2024 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723126859;
	bh=FcGF36TBWHJtKexABNo42UKivkTYDrcajYqTkssd2os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkH4tGtrgw5RaGeQkptrD91VOVZLp4ENUR1EtR7hoBkk9k6LFn9qI14ytWqc02Plf
	 U1coNePPwvsfjtofN6lzev9kYTnefR5Va1UA2hlP0Absg0Qqdt4LRbgHtJoQRW3IDX
	 BHhAdke8tuV1CGidbV/NEbOFcK94fmufe5VTJNUbibwa3McqMy07eUgDsR88flikst
	 atso+vBkBUtirBiDyyEnmpKCe5p1xFNVG8z3ILP7JVo/NYnxjLAcuUPnib4/CraOjS
	 v8oUb8kUbafIiVPjdNWKWmTswcFM/I5TsvoYtPzQrmEpD8qjZOGqzoQ9q6IZHyz1IG
	 p4mSd/QyVDEPQ==
Date: Thu, 8 Aug 2024 07:20:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next 4/4] ice: combine cross
 timestamp functions for E82x and E830
Message-ID: <20240808072058.09215916@kernel.org>
In-Reply-To: <52af8b88-8814-4861-aba0-4bc726c95740@intel.com>
References: <20240725093932.54856-6-karol.kolacinski@intel.com>
	<20240725093932.54856-10-karol.kolacinski@intel.com>
	<ad94e165-ea7f-4216-b43d-b035c443a914@intel.com>
	<IA0PR11MB838091A67C0AE3598BFCDF8D86BE2@IA0PR11MB8380.namprd11.prod.outlook.com>
	<e54793ef-f81c-447a-8cdd-bed97df65f2e@intel.com>
	<IA0PR11MB8380B6EC30AC39EAAC1F480986B82@IA0PR11MB8380.namprd11.prod.outlook.com>
	<52af8b88-8814-4861-aba0-4bc726c95740@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 15:00:52 +0200 Alexander Lobakin wrote:
> > Technically, neither ART nor TSC are directly related to the PTP cross
> > timestamp. It's just the implementation on Intel NICs, where those
> > NICs use x86 ART to crosstimestamp.
> > 
> > For cross timestamp on ARM, it's also HW specific and depends on which
> > timer the HW uses for timestamping. I'm not really sure what's the HW
> > protocol in this case and if e.g. E830 can latch other timers than
> > x86 ART in its ART_TIME registers.
> > 
> > get_device_system_crosststamp() supports multiple clock sources defined
> > in enum clocksource_ids. Maybe instead of checking ART flag, the driver
> > could get clocksources and if CSID_X86_ART is available, it would assign
> > the pointer to crosststamp function, but I'm not convinced.  
> 
> I mean, I'm fine with the arch-specific definitions in the driver as
> long as the netdev maintainers are fine. Or maybe they could propose
> some generic solution.

I don't like it either, FWIW, but it seems like this is what everyone
is doing. Please do CC tglx / the time maintainers on the next version
and net-next submission. I get the feeling they will wake up in a year
telling us we did it all wrong, but hey, all we can do now is CC them..

