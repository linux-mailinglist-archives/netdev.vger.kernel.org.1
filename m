Return-Path: <netdev+bounces-231055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D06BF43EE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A372C461EA7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BD221D9E;
	Tue, 21 Oct 2025 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/JrSJo2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9B190664;
	Tue, 21 Oct 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009918; cv=none; b=QueG4OUDKnJMZU0AMSDcnc6jhnhSgPBhVq2WLv26nKz46RQwWwW8yY0MXmHNeaXUjcLp5F9QIMrtxtWU3oXcWl+BkNXiglO5k9lD139Palb81epYNBa+OCQALMJlBesBxN0k4CkgYKxf0GS6koYtUA0iJpVRtlGINvZDtj1bXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009918; c=relaxed/simple;
	bh=uC7kF+4AxkOArh15j0Jwvp3XCsIboqvE/irDePvovX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR534y7NWRMjLt9Xq8OFruwHF4r0t3dNaIvbK27epwOlCBumYEdOeeOu+UL5Yrv5NVNH7esqAcpBui5IvJVuXB6ts4YEJZeuS0/YF1388fGkLLPyXRu50hh3zAgZeSWLKAM3ByC0YBMDtsw5CwQt/b5h7G7hpJlGBavw1a4m/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/JrSJo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFC8C4CEFB;
	Tue, 21 Oct 2025 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009917;
	bh=uC7kF+4AxkOArh15j0Jwvp3XCsIboqvE/irDePvovX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/JrSJo23ntPb3qh47ToXZwvAYlRJwSE91XvPF8v1WqFBHYMBJp6qfDs2La2IAPjW
	 IMa847cd88ag/vndDx7ZGyy5PiD6+VsdkgVVAFJ7rWIdxIAfS1lobX62hlarwauIek
	 YxlhacoPxo5qQU2TVvejmggn0gCMTcMtNDIc5LAVGk2VtFjUHkBSfLLiqIVYkNpJ8n
	 bgf+3geZ+3hb75runxR6g5l93cwIXXyt9gv0tSEbL1SD2UNPtrkIairWTMGWAo2383
	 bWxf80DehdxflPfSTTJaMg1QfHuVKC7+++UBlwUHJZe8I7giqBT8Y2fo7k3835nqyj
	 p+N9IKiJ28idg==
Date: Mon, 20 Oct 2025 18:25:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mohammad Heib
 <mheib@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
Message-ID: <20251020182515.457ad11c@kernel.org>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:
> - The configured value is a theoretical maximum. Hardware limits may
>   still prevent additional MAC addresses from being added, even if the
>   parameter allows it.

Is "administrative policy" better than "theoretical max" ?

Also -- should we be scanning the existing state to check if some VM
hasn't violated the new setting and error or at least return a extack
to the user to warn that the policy is not currently adhered to?

