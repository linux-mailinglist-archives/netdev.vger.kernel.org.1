Return-Path: <netdev+bounces-201237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652ACAE8927
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699403A33CE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165C26A1CF;
	Wed, 25 Jun 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNc+rp0a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Son8ZXXJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412621DF256;
	Wed, 25 Jun 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867548; cv=none; b=gT1awBd1F/LesZ/mwaQ1zOU3YaL/22tl0W5F2zys0O4q5EUf2gtnlCx9M2B6xvlF7CMBvWaeV0cos+F7/DBQbH9tBM0KnitZiTD8Hzu8+FMi6L9gybWk0S4bfOIOR5RLhHQvjpR1Vn+j1zNBYkkKxaKMCJReLVbCbdfFnCEZ2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867548; c=relaxed/simple;
	bh=JombFk2+EPbmO/DxMPhdDw0gjCly3lhSkJ2aGwGulYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EknCNiEHT3W9gWUqGtM+iOSdj9eLckA5vEdRql2JOLSNFtqxfbdGjHXrhIGrn8S6npKU0p2yBktnOHO7NWyDjKmxvfGZoYNd2SwKlcgcmEE+VjoGjQnFkqzTSB7gz0fULAuHhtO1uGVnUGMT+KIqwTd6RQTL4/THooZj09GwhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNc+rp0a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Son8ZXXJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750867545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JombFk2+EPbmO/DxMPhdDw0gjCly3lhSkJ2aGwGulYg=;
	b=qNc+rp0a8wDFUH9zgs3JCWy11IeHBAZvfDNmWFNLZdK+mrt0pI3Mtsfa2N7TVUjzCh14Ay
	izTHkVnuRGRk3phMH4vsg4rvSOJqIlKrSwEXLj0oDxEbxyuEmziQUvsukOSfzatJBON8wt
	vj/xHubBHV8p3n2pZaFTOe2pykmih4u6Xtc08N4I81nBYH8TDGStu718ta60tsm0aUbOn4
	qhFfkVkSiGiyIDDVEI758gvZzbLOeTQXgEWMqdjLnX1QNHGPdDXe2CKM4E0nUVS5HBRh7J
	il3SEft6ntKyVVK4O/dKLuRyjvIZPjr7fQUk7gEm3MVttHqZ5e7beNvsk5/fYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750867545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JombFk2+EPbmO/DxMPhdDw0gjCly3lhSkJ2aGwGulYg=;
	b=Son8ZXXJlXXG5NfdHf2AdIhwMBFMZDuGJjYd6sqEfOHlDyB1q/XrgPNX2h011yMWF9qXPW
	wO/I4usJvsBzxJBg==
To: Richard Cochran <richardcochran@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [patch V2 00/13] ptp: Belated spring cleaning of the chardev
 driver
In-Reply-To: <aFwKc5R3uZVc_aoH@hoboy.vegasvil.org>
References: <20250625114404.102196103@linutronix.de>
 <aFwKc5R3uZVc_aoH@hoboy.vegasvil.org>
Date: Wed, 25 Jun 2025 18:05:44 +0200
Message-ID: <87a55vrelj.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 25 2025 at 07:40, Richard Cochran wrote:

> On Wed, Jun 25, 2025 at 01:52:23PM +0200, Thomas Gleixner wrote:
>> The code (~400 lines!) is really hard to follow due to a gazillion of
>> local variables, which are only used in certain case scopes, and a
>> mixture of gotos, breaks and direct error return paths.
>
> But it is 100% organically grown and therefore healthy for you!

You sure there were no forbidden plants involved?

