Return-Path: <netdev+bounces-92647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C988B82F9
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D5628551D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348431BF6F4;
	Tue, 30 Apr 2024 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma6ShNHJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47029A2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519182; cv=none; b=ntbpWwdF2TXqelZsJBorenBVMUwgoO73xYmVF+Tmo/ScTlZO10+IqP+/N69lhBKoWL19s0limo5iBbZyW2d/RkcyMr4MdhD/4urUxG1jlJG7KH74bEps5EK9KJ/rfsA9dPUodeD1T+zH6qd/ppw+Ln+hzcLLBde1NjnQfizJoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519182; c=relaxed/simple;
	bh=Pdf2LaCD3ypdhnzcP6q3xduMr5rZpyIj3l0Pa5ySv1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEBweCam2tHXIN3fZ9ROQfye5HbzPD2crXNF77SalL1rSyF1fYdzcua6hGsotBZekaHS5DJaRRMlTpwiPSbV3ED8BDgwuAcap/JgqyHxyz2cLAeONkpowdUVJFBiwC99iYABHbF9TB42+8MXMjrY/1AQbFcw2VfC1eGNz3wScEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma6ShNHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26133C2BBFC;
	Tue, 30 Apr 2024 23:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714519181;
	bh=Pdf2LaCD3ypdhnzcP6q3xduMr5rZpyIj3l0Pa5ySv1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ma6ShNHJNdro/LHNSMlOR6ZEI/QEZzt2VSPxOSpQXKywb9qt9TbHCwjcgPsKucPKc
	 ibsjVlkYweTK8JbJSVpt860H4FvVUm8wGCA+0IgQPEPhuENFsioQ0zUyu5K9S3DIBk
	 dokqa72tVlieTYpCanJ/aW3ZwO9CjFEORxQ6hGHH2ok+3YaNhZk1QwKBeV1mhbORiL
	 /8vnIsI3w7M3cbVTdQwD9m5Doap4MueOVo1R8kcUQ+ehnYhDJRTNPwggmmwY7BmhyW
	 21P5b+90XV1PgHtSHG2os325oC8iS6dM7pgTSOVvqv6ywIRdu0/kaBk9QCVeZNaxBK
	 5Cs8gIx9aWaqg==
Date: Tue, 30 Apr 2024 16:19:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew.gospodarek@broadcom.com, David Wei
 <dw@davidwei.uk>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 1/7] bnxt_en: Fix and simplify
 bnxt_get_avail_msix() calls
Message-ID: <20240430161940.4cde5075@kernel.org>
In-Reply-To: <20240430224438.91494-2-michael.chan@broadcom.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
	<20240430224438.91494-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 15:44:32 -0700 Michael Chan wrote:
> Reported-by: David Wei <dw@davidwei.uk>
> Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")

He hasn't reported it, he sent you a patch.
And instead of giving him feedback you posted your own fix.
Why?
This sort of behavior is really discouraging to contributors.

