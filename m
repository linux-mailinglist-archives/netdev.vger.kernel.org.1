Return-Path: <netdev+bounces-197349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0DAD8341
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA37A721A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23923BD09;
	Fri, 13 Jun 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQ0/TEfD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ej78IIJt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23A19E7D0;
	Fri, 13 Jun 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749796359; cv=none; b=ZGdcDtrv4eGF6kicmwj0XkUJZQMMRUtPvsjRnJBMgCGbqbGX1hl5sb2pCqTgyrEEJsEvlfQO0PXC7hcrhS43uxrGSdaCajyel3kRMP0XcyiOzAXFU86Ai2PYe4W03+Er1AkFnZzhhN7R7eXUtfz5SwOymlnYpx2jHGcKPYHbHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749796359; c=relaxed/simple;
	bh=Tx/RxFsLs83VOkymMWNsDjyCSM3ZCC9BI2ibGIG/Hq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3V/iNXY0F3r8DHvyWuA9BnP+MQGTu2HoFOJ4YBfOcMELx2BB/CfNlrV34Q3NmkvGfEH/l06xYzknq+J0F1WK/tUOFWNNsUAf+Z8qploPi8BcOzkWwp4ZtcfSj/n8qEWUObeHVwsX2KOtZN7wURqRpolcsJQ2YmSQMnaF37BDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQ0/TEfD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ej78IIJt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749796352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEt7mrZB/9zzOpAPhHlZclwQn0SIWdrSyoVPPsz+YuQ=;
	b=uQ0/TEfDJdvGa/UH3fa4qdjWEQDRwIogkwQiNvxIT1YydWCDzS0cnHWYyITeYu5isgSU2L
	QxpJUHb0HzqS8mFL+dAA8E7aVNpc2fdFnkAjXHWWvoVQgNMuy1eVHemDg+dAivJUXf9c/I
	PW0Nmgc2dPZfAiail2pYR+523AY5/591Xw9BVgQgjRJGeBi0TsdWZJ+3yzxycxMzxU60Df
	ZOTVpEc0EWhIzV1gLNNOJ1jhstJAhu9WihTQgzqRcUpfk9Qm1YwU0l1tTJ/98hmdvksG/Q
	l8ueLIXq6YiWQd+RTVkWDW6tFP5tEkFEbZkUTld/2oI3rRiXtHCExByiD3lpDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749796352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEt7mrZB/9zzOpAPhHlZclwQn0SIWdrSyoVPPsz+YuQ=;
	b=Ej78IIJtbOQAfAuKiiZXFEihwrV1zSsZA+R4XLHB0aqx6pKqWVVBCENl3W6Yke8XaF/LA6
	U6IOKVcqR17SPUDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, 
	Stephen Boyd <sboyd@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [patch V2 06/26] ntp: Add support for auxiliary timekeepers
Message-ID: <20250613082938-04b6c1ae-b5b9-4547-bb23-23fd0df81818@linutronix.de>
References: <20250519082042.742926976@linutronix.de>
 <20250519083025.969000914@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519083025.969000914@linutronix.de>

On Mon, May 19, 2025 at 10:33:21AM +0200, Thomas Gleixner wrote:
> If auxiliary clocks are enabled, provide an array of NTP data so that the
> auxiliary timekeepers can be steered independently of the core timekeeper.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/ntp.c |   41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)

<snip>

>  void __init ntp_init(void)
>  {
> -	ntp_clear();
> +	for (int id = 0; id < TIMEKEEPERS_MAX; id++)
> +		__ntp_clear(tk_ntp_data + id);

For consistency with the rest of the code:

__ntp_clear(&tk_ntp_data[id]);

>  	ntp_init_cmos_sync();
>  }
> 

