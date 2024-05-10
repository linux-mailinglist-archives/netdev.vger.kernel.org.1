Return-Path: <netdev+bounces-95355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C68C1F47
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D4FB21565
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6615EFBF;
	Fri, 10 May 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4ZJBoW2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/8/QdGY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66315E81F;
	Fri, 10 May 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327412; cv=none; b=d3Xmc9MuJRyQJ+DOkyCdq+JRFyohO25Kz3WDtSrOmTXUL8LIWob9grLQstIAcI6IRZt1GRn5/uXSxT5NAt1jtuPjRjAXrNVbzyLwOynGvm8+3TNStU5hodGfWGrFazuIFog25iTS6olkb8eAnzBBhXDz4e9Eo4JF5INnmGmzjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327412; c=relaxed/simple;
	bh=rMAVjwBkRfoO4ApsKQ3uN38cwC6IUcZXgUBhE/UzM1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMpBHErgpaFiLTTpwxCqUsLRr4S+4pjnBifaWxvoCO7TscScaFUBaB9NCCCKgMu5ndyFurtLTUk51Gwm0oM+ZZk3EdbetI2Rs+h8+aVmHME8d6Lt+5J5zeEIrgQdpyT2sfyY9JyYygt5Bj6cYM2AfaT/cDWudMi4scu8M5pCHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4ZJBoW2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/8/QdGY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715327407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83qER11rv8Rpxyug/G55t1Ztws5B0HNQaUJtN1GoKJA=;
	b=F4ZJBoW2xB7zadPyuaqgCohVyB7p2yCd6qMvchefS6c42vvaoaURdGD8K3/qS6P1fs+Dyq
	ahJSc54GoKzSqzKAb3kBu+wP8Pe1+rPpQNtDrPn+/CIG8VKVqAnIb5hLs/3DGbr/b7nx0A
	SJPfoVKkFui8A5kHY5wYj6rlRmlDAI2DsLcXRinUbs5c2LlGSu/uR4zZbXY5Ia+vI5fjaT
	3GVl71fqwyI3nq5mQUIjqfVoR2DlXTSol5Dok7XUXAauejY2EHQeSh7B+DmLIVGg8vIdFB
	4MdimgDwCfGPm7ADpGHDtWcfwQRSafJG+6AxztkO8bXBbMyXOX4cJLmuWLAHrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715327407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83qER11rv8Rpxyug/G55t1Ztws5B0HNQaUJtN1GoKJA=;
	b=N/8/QdGY6IM9FP3JjfL3WpirVQaoRsJDUBXzB18tdl+TYZK85ZAmo4NTUy/jxsUNeqmbmj
	uAYZA2fY7Hud0mBw==
To: Richard Cochran <richardcochran@gmail.com>
Cc: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Sagi
 Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org>
References: <20240502211047.2240237-1-maheshb@google.com>
 <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org> <87cypwpxbh.ffs@tglx>
 <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org>
Date: Fri, 10 May 2024 09:50:07 +0200
Message-ID: <878r0inm1c.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 09 2024 at 21:07, Richard Cochran wrote:

> Thomas,
>
> On Wed, May 08, 2024 at 09:38:58AM +0200, Thomas Gleixner wrote:
>> On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
>> > On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
>> >> + * History:
>> >> + * v1: Initial implementation.
>> >> + *
>> >> + * v2: Use the first word of the reserved-field for @clockid. That's
>> >> + *     backward compatible since v1 expects all three reserved words
>> >> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
>> >> + *     CLOCK_REALTIME is '0'.
>
> ..
>
>> I agree that it wants to be in the commit message, but having the
>> version information in the kernel-doc which describes the UAPI is
>> sensible and useful. That's where I'd look first and asking a user to
>> dig up this information on lore is not really helpful.
>
> But writing "v1, v2" doesn't make sense for this code.  There never
> was a "v1" for this ioctl.  At the very least, the change should be
> identified by kernel version (or git SHA).

Adding the git SHA before committing the change is going to be
challenging :)

