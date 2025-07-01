Return-Path: <netdev+bounces-202796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659AAEF052
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD83BCB05
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FF25D1E9;
	Tue,  1 Jul 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBWHwKRA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B51DED77;
	Tue,  1 Jul 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356858; cv=none; b=f22aSLhFEnVIWd+/NIGtm7gL/sp7rzahLdxEzl0LPwXo8zvi1RNhFyJQIvn2PKqizRfux2Wr/amHScDUE/URUXC0QRQ/INWuY22xum3LHLxjKYsCYynya+m8OmHZC2ZEPW/vF6cWUTguidQ3iMa4ZU2mp6s25iH5GuASg5TY3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356858; c=relaxed/simple;
	bh=JDFtbXdWMc54eYwOlHAtd2eR00cz5LMDPxkSGH1EMic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY8o7FX2JZcup0I41ZezfgjNybtpUXQUST/o9pnmmS/Y5xqt71DFsXend+T3kVxpSWjwiwQ3rkfKw5cX88/qWbXR7O2kgOs7GQ1S6CfPw4yp1vj5Hu/rHltLwG9Y6DTnwZHLBA3uURCnh1aCOg6zV6OBWNA8iF0RXjKr3JNdKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWHwKRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA5C4CEEE;
	Tue,  1 Jul 2025 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356858;
	bh=JDFtbXdWMc54eYwOlHAtd2eR00cz5LMDPxkSGH1EMic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBWHwKRA/msx2vNUG1rZSpbX/PR53XofHbbeNwmVnZ2m08D0GpHf1uvLpfUQ8LOEp
	 CnINA4AVjiCA6BINdRvHUCd3A3wDGYGgWaS6maPouov9MbAy9gxFdab27aV50bm2YM
	 d2BQOl0dOB/QI4j8RaFQWd8M53DYMmJspNwDPfleccIc6Q2PTFtY3jAAPATBDUrviS
	 sKHG4FmfnkZ10IQhZkTmsbbbAwCFwA29COaWVuSgBPP352spGwdfhFFiPUM8SQa7EE
	 bT2sK5J9Sf11Ll0cO/N5ZIJSAEtRjv8rekbSmC8AXBCFtImsZodH83Wz1uyaLG5wj+
	 WPMk2nkVTgmuA==
Date: Tue, 1 Jul 2025 10:00:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [RESEND PATCH net-next 1/6] af_unix: rework
 unix_maybe_add_creds() to allow sleep
Message-ID: <20250701-fingiert-perlen-247b58373fa5@brauner>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629214449.14462-2-aleksandr.mikhalitsyn@canonical.com>

On Sun, Jun 29, 2025 at 11:44:38PM +0200, Alexander Mikhalitsyn wrote:
> As a preparation for the next patches we need to allow sleeping
> in unix_maybe_add_creds() and also return err. Currently, we can't do
> that as unix_maybe_add_creds() is being called under unix_state_lock().
> There is no need for this, really. So let's move call sites of
> this helper a bit and do necessary function signature changes.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

This looks good to me.
Please feel free to carry my RvB post the minor fixes requested by
Kuniyuki:

Reviewed-by: Christian Brauner <brauner@kernel.org>

