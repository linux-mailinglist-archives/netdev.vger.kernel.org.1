Return-Path: <netdev+bounces-119831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A029572A7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC281F23EDF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F55188CD6;
	Mon, 19 Aug 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NClCAvsR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD1188CDB
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090721; cv=none; b=IeRxqHsXl896tjbdg2ddpmrFDgeO0sj7xNkrTpjsbXWQ+6LZcbexfwLNG8i/NC0C6KBLdemCYgP7uy2Svi29fW/IWzPZdo+8pskwHcICLC2Q5DlRTu0ZOU1nyz0HWhLf95KuYLHhl3vAA2Qdzwn03Hy+IYPUea7VJ4ots5lzdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090721; c=relaxed/simple;
	bh=o35qCvEZbu4T5kA4SvRlTOdbqIKV9iz8xf1om4OGwIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4WRFaA7eU3mPeAhbvaPMLYgJJLc1kIDX9wa8Q3Z0XhQr6ytMXu+Erj7OQ/JvwF4422vSvPcYf6vSSf4a0M5yJFxvX24BgoSKGiLsAxnN86nZ+/1uUcpgG56cQEkCzR654wxuTb5Prc6Dn1Lg8yPEyM3pBypPCmvmybfYkRdWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NClCAvsR; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WngKk3dMMzxMs;
	Mon, 19 Aug 2024 19:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724090250;
	bh=Mkv7N3eK+fsZD7USRF4qFft68VEC4BZLCWR/hmSXw0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NClCAvsRfZN0erdn5kwTp7MikRRs9KgfMhRrRWHxPHG6afsYPRuJe3pZMUds/pkJw
	 W6WZCKmnvwHsIEHemS2lzqHUixQdgw8HdKs7xrdB8AcebslnEufnL++Q/mYWXvaxCj
	 3ioiU8Otfy+lyH06pHvw2peza0KgU1Gf9Tf0QYto=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WngKj30pnzgrn;
	Mon, 19 Aug 2024 19:57:29 +0200 (CEST)
Date: Mon, 19 Aug 2024 19:57:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
Message-ID: <20240819.eiDie8sienah@digikod.net>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 15, 2024 at 12:29:21PM -0600, Tahera Fahimi wrote:
> This patch adds two new hooks "hook_file_set_fowner" and
> "hook_file_free_security" to set and release a pointer to the
> domain of the file owner. This pointer "fown_domain" in
> "landlock_file_security" will be used in "file_send_sigiotask"
> to check if the process can send a signal.

We need to make sure this file_send_sigiotask hook is useful and can be
triggered by user space code.  Currently, all tests pass without this
patch.

