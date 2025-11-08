Return-Path: <netdev+bounces-236909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8FC421B0
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82EE3AF648
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2B7082F;
	Sat,  8 Nov 2025 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PP6hncX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAA3D544;
	Sat,  8 Nov 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560693; cv=none; b=A5iKvUI5Eum07GfYUNBXzAijxxsLVdUDpJljBHAMEbi7JAR/LpoekCZkdCJ0wnPFOQCQTX9dwVmLrsvVzMOkV0Rd729HbGMSPue0Kj8ahX0u0avCZX/kR2FkXAgh6gyigg51zt/mBP/eOOuakbeOqh6VtxFRTwDFDQFZaPqc8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560693; c=relaxed/simple;
	bh=DZ0yHSNUErxx3vmVzbzHcrWIeQE8em6IZAFmJjGfFyY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YruaxGdLupgh8YMGMs6UUWwz0HThMQbY39z1fVwPFMbFVk1ImZgrn9P4UqN8TRNEYuyJpU+nmxELM1EmCRUUjzVOB7GQ75U0AjhZxKbEjJ4HX5K2Ip5URfNOdIuQkVanV5PCdJcvcvI1rzEX6k5MpLIS8rLkGid3aGvxfWNUpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PP6hncX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF9C4CEF8;
	Sat,  8 Nov 2025 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762560691;
	bh=DZ0yHSNUErxx3vmVzbzHcrWIeQE8em6IZAFmJjGfFyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PP6hncX0+liAPqEhxN48ILDiyShnkg/4hTfW4NN1ykje4z+9XgP6HRyTM3My69Tcz
	 paV4LSLAH7L+tbWKgSVucRhViykaArx/Tj4Wydw9Iht+2LWOZ2WQtPAJGAqt/t9nLv
	 +9085Nnm9haEU8oMeYnjL3HcZLr8HgxRdjM6v7N4=
Date: Fri, 7 Nov 2025 16:11:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Junrui Luo <moonafterrain@outlook.com>, linux-kernel@vger.kernel.org,
 pmladek@suse.com, rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
 tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
 mchehab@kernel.org, awalls@md.metrocast.net, linux-media@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-Id: <20251107161130.4418562992d2477c4accc6ef@linux-foundation.org>
In-Reply-To: <20251107091246.4e5900f4@pumpkin>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
	<20251107091246.4e5900f4@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 09:12:46 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> > I wonder if we should instead implement a kasprintf() version of this
> > which reallocs each time and then switch all the callers over to that.
> 
> That adds the cost of a malloc, and I, like kasprintf() probably ends up
> doing all the work of snprintf twice.

There is no need at all to optimize the performance of scruffy once-off
string pasting functions.  For these it's better to optimize for
readability, reliability.  maintainability.



