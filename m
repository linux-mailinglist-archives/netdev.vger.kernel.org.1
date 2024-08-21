Return-Path: <netdev+bounces-120500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4D9599B5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62E41C20491
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9521B5EDF;
	Wed, 21 Aug 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xWNhkNn6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE42111D6
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235225; cv=none; b=MNHF9uk2nElnEmgvWO7xVNG3YgqYAIRjld372EK+4lsptPj3n29dNQVEKtf5VjlV3mTsOqGyhGI3lYD46XXLevDqWjyn10PNbm8tOpYZ9jwSvZwDOdPHiDbsxpIp3R/HzWRbM95pfqSwyDEq/voJM+rWIYY0Aiw9Ffsdsdj0mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235225; c=relaxed/simple;
	bh=FoTolnMxIcYfhIWfLyGYqLu9gydImlghdFwJAaptLvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2YCK8aHA8ZYGCcgIdVtPwkgjeeklRxpuuj7bdW/dpGtCrs9/6uWy4Dgsfd5hR1aNez2ngGn1W8AwfbQrkORO7fAGRTy24uOLMkFg+bDbNEuq0bEfC9LSfdz5zxI8mi4brjm56/3WVUxa+dPw+TaDyawF48PJiidQSarP2PTgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xWNhkNn6; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WphxV1M4Vz6wt;
	Wed, 21 Aug 2024 12:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724235214;
	bh=PIbYf2E6OPhrBU4LYZ5NlLv0ePo6bVAkYtdfPLo1FhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xWNhkNn6ovuKiW3U8C83BrwS0PTUyzVTuxPglAQOyRsNc7ZSch0dB/BCSAT/HAJ69
	 j/lxa7hNNN1sfDNojR6UiQqNInBpVW2XtqMgc6orV0e7MiZWhABgliT/jEZz9m1zr1
	 Ym98BOHgFnzOMUzI+dztKsYSQiceabnxuF39jEpo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WphxT19jVzrPb;
	Wed, 21 Aug 2024 12:13:33 +0200 (CEST)
Date: Wed, 21 Aug 2024 12:13:28 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
Message-ID: <20240821.oBeepeel9ir1@digikod.net>
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
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  security/landlock/fs.c   | 18 ++++++++++++++++++
>  security/landlock/fs.h   |  6 ++++++
>  security/landlock/task.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)

Please squash this patch with the previous one, both are enforcing the
signal scoping restriction with LANDLOCK_SCOPED_SIGNAL.

You'll also need to update the scoped_test.c file with
LANDLOCK_SCOPED_SIGNAL (in this same squashed patch).

