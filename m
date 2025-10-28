Return-Path: <netdev+bounces-233352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACEC123AA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DC704E7390
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219E1DF246;
	Tue, 28 Oct 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGYnwu5t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCF7405A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612229; cv=none; b=qI71EJvZCqNh3aL/JTQKviR3jH2vKF8Ja5KUUDMWVvam8jh2lD9/+QvE2ddTOfqYqpxcaJ3rL/2LxGhWbHNA3yaTibC9er/TV4SICydsNCtglA3spYCZH464qR9wANXlyg5Noqw0wJzUQOax8527MgmK0NC12ZOWfYxs+ZtdXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612229; c=relaxed/simple;
	bh=E/1lfTHHVn55RNaQETGhP0fLYJLLWtZ4F6csrQehZco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGapV2VeCZGJgLJf0xqJx9LQ/5pJxvaR1WuBF7gvuLIakHfmwEtie/ZxvLZ2sWjB+GSSRU+cgzz6/jwrzJISz3x0EMqzKwAx46FruOgnJYlwrsEbf5BSA9198guP4cnDA4FctCtZeXC2Ua9lJawA/8PJ6+gBAFv1xcq0xO9Gukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGYnwu5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF75C4CEF1;
	Tue, 28 Oct 2025 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761612229;
	bh=E/1lfTHHVn55RNaQETGhP0fLYJLLWtZ4F6csrQehZco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LGYnwu5tM5yuPMSK292SdEATCUwMMULD+mNq++S4Hx08fsZjYUc8xOFlW9vOxRfSo
	 V2TFjtr+ULrCAwoN9HGwov4J7Wg5hfAImO15kan3ZD6dpDpC7HNzda+DvdNqu1NyUq
	 HhwsIyZsLZrxYG8HfRS8Mss5xo6+Gi8M39I0f0EU+uSv+Tv+OC3pyOey4N6YnaKEng
	 BEjjWp7pZH6gvjQwQqtBu5dsvf5XemmS9/iW6vF3tYAoPdf9DMP7/+xyoaNFiO9obr
	 E8tUZl3LUGxQv0ZzpNyQvBSpDuSbgbdOaGUqg8jHDOEbYDLapzqDsk+PwLsgGxKnWe
	 lfuqbbJ4yVrDA==
Date: Mon, 27 Oct 2025 17:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to
 PMA/PMD
Message-ID: <20251027174347.16e28741@kernel.org>
In-Reply-To: <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
	<176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 13:41:21 -0700 Alexander Duyck wrote:
> +	u8 aui;
> +
> +	if (fbd->netdev) {
> +		fbn = netdev_priv(fbd->netdev);
> +		aui = fbn->aui;
> +	}
> +
> +	switch (aui) {

Compiler says:

drivers/net/ethernet/meta/fbnic/fbnic_swmii.c:17:6: warning: variable 'aui' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
   15 |         u8 aui;
      |               ^
      |                = '\0'
-- 
pw-bot: cr

