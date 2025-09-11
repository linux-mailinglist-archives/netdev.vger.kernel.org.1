Return-Path: <netdev+bounces-222120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DAB5331A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86840188FB5A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1AA31E0EA;
	Thu, 11 Sep 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEnaqTfT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFcKO+s/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024031E0E5;
	Thu, 11 Sep 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595807; cv=none; b=fACaLUVU4C05wR1CHZ4iKfshVLHMtUbaSiDIRTriXTs01HNJO9BH21fo/TrVSta4iWaabJgiXbghN9HHJdkll8VdsP6KO/0H8yccyONkjegZVKFBoRDqtJufQgyCejZSdHefFqT4t84GKMONVTaiNySqY4Wh3J6Eyw3tT/ZFKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595807; c=relaxed/simple;
	bh=WL1vFbVsuMz5eYh457lOB/SNVOO5O+iPUetR8c8NMm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmFSc18euXgKjAYgSEf+OBJSDOgddMNOdMLcA/B7dK4q1jIQwzrMejeuB4cCjVriVzJHDz4tdoFykm76CXhgU4pPLDctOi91vq6I6L6godAggDGCVRp/azBcQVyh7id8K1VF3ph/t6LgMBJFBvPglq7+t1delkHhwjEOrUMVZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEnaqTfT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFcKO+s/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757595804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WL1vFbVsuMz5eYh457lOB/SNVOO5O+iPUetR8c8NMm8=;
	b=FEnaqTfTF6gSO5qJX3fxyRlVL+yMNSM0hvWX5P4ZqY3EZzC8qB6teIjph65xEjFm6kWyYd
	UnTIkXzDH5SLDVtC2MODOGem7+iHM2JCl3ysMCKwrGKnrve92GZ/sVzXoOlIzd9iBQUHPJ
	5V5SYA7wAymKvLVZSlMkYFOMcv5gEoybGrqYadCrUTmsvPoRjUmgM1ruT7Ovc/qTFSIR+p
	nyLD+oeTKnoRJLcMgu2BifWG1QfFclq5RzjQPNfHYwf/pphGyW8AZN13/abBLALTztuPG/
	jacZyezOgH9xdg+JKIzzI7QfLsLBlwoI6loRHoAPrZlHB1TvTcmSyiIEAwdTdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757595804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WL1vFbVsuMz5eYh457lOB/SNVOO5O+iPUetR8c8NMm8=;
	b=LFcKO+s/a9YjEqEPBpL750yrPjFA2Ej0IAcediZLUcKNgEpQsRvHAbHGSkMC6hW4xpny+5
	1xj95Y5OH2oSFQBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>, Simon
 Horman <horms@kernel.org>, kuba@kernel.org, calvin@wbinvd.org, Pavel
 Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <aMGVa5kGLQBvTRB9@pathway.suse.cz>
References: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de> <aMGVa5kGLQBvTRB9@pathway.suse.cz>
Date: Thu, 11 Sep 2025 15:09:23 +0206
Message-ID: <84h5x9xht0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-10, Petr Mladek <pmladek@suse.com> wrote:
> I would personally try the appraoch with the "unsafe" write_atomic()
> callback first

I will prepare a patch for this.

John

