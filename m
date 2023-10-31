Return-Path: <netdev+bounces-45457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679257DD351
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A261C20BCD
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74451F191;
	Tue, 31 Oct 2023 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xICgJ7CK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iK28zELF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27E1DDD0
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 16:53:06 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718D386F;
	Tue, 31 Oct 2023 09:52:51 -0700 (PDT)
Date: Tue, 31 Oct 2023 17:52:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698771167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAD4PZZPRqR2qqqz8EHQ+Hmek2C4MZMfqNDCeCXy6SU=;
	b=xICgJ7CKCPP612P/GeGfpN7jEdqws8T9RkJ5uBAsvulrBrYFMRnTyjjb0KmmXf/beQw/IT
	zBym7HVItEc55tJ/UFv0ACD3UNdpV/tCxHgpi7LHAUv4l5L+5yI11v2GQctUM0Vhu8sJen
	hmqRnvBzszDs9QME3/Cp/aV9g4S5F9fbOQuO6MANPi2H1rIpNQOzdhuBEdbGJBBbL9e1Ea
	Fz/8eG7oFPAyFkYb4k0hEqlR7+hAmZsyFFbpWWSFnLWEIcruogq2uPRpVgIrgcFOeusJyz
	eOG2+RLIQo2QjDW1onheqOtT76r6FAOXEtv3tPF7BdsIwdN5+7RodzCLEY4kBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698771167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAD4PZZPRqR2qqqz8EHQ+Hmek2C4MZMfqNDCeCXy6SU=;
	b=iK28zELFzCeYTkCb2gCtc0jpeTewvtKn2reWTzzJxY/VQxP9ZdPySwiv/alRNwHNnCXfvu
	nltW1oFCxqmJDrBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
Message-ID: <20231031165245.-pTSiGsg@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
 <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>

On 2023-10-31 17:14:01 [+0100], Oliver Hartkopp wrote:
> Hi Sebastian,
Hi Oliver,

> The content of gwj->mod can be overwritten with new modification rules at
> runtime. But this update (with memcpy) has to take place when there is no
> incoming network traffic.

This is my assumption. But "no incoming network traffic" is not ensured,
right?

> > If not, my suggestion would be replacing the bh-off, memcpy part with:
> > |		old_mod = rcu_replace_pointer(gwj->mod, new_mod, true);
> > |		kfree_rcu_mightsleep(old_mod);
> > 
> > and doing the needed pointer replacement with for struct cgw_job::mod
> > and RCU annotation.
> 
> Replacing a pointer does not copy any data to the cf_mod structure, right?

Yes. The cf_mod data structure is embedded into cgw_job. So it would
have to become a pointer. Then cgw_create_job() would create a new
cf_mod via cgw_parse_attr() but it would be a new allocated structure
instead on stack like it is now. And then in the existing case you would
do the swap. Otherwise (non-existing, brand new) it becomes part of the
new created cgw_job.

The point is to replace/ update cf_mod at runtime while following RCU
rules so always either new or the old object is observed. Never an
intermediate step.

> Best regards,
> Oliver

Sebastian

