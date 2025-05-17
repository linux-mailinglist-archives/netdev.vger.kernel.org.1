Return-Path: <netdev+bounces-191300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F974ABAAD2
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B32417D0E1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D01F4C8A;
	Sat, 17 May 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKVM6EMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FD4B1E40
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747494589; cv=none; b=SKTg16P6i/4JDl/0t+ROpgf2bDCP6tTTyV+J6FDpWuQrWkneIJXJ/wwGIBAyI2+BPVbnP/OYS3rHYplAIlyhxx9QDRf6NM/ac8+R2zsHctph88+YoK7MwcnqDfAj6nTjKY+WY3Xt/mfQ5JHHD8JJds2sdqqDI/HE1bNfwv1kOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747494589; c=relaxed/simple;
	bh=U3r+r4TOcnzLD7q/BzvL/e/jIoRxg3+4Rtzd64P02VI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixwCzL87NPUXvII7gynPbjUIiOZQZIXpjfrHpOKEo0eCqlm1OKzZOTecOKwXFr7konx4R/LRL7F8nw4wV0Dyw+xhgDoIvsa7vne064gcVXPUXjQdErDRd6d7L/zzbI7dqPPdEqQTQH1pHunwmeVbX0XXwFHaA5VdZAP7RDRXPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKVM6EMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC1AC4CEE3;
	Sat, 17 May 2025 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747494589;
	bh=U3r+r4TOcnzLD7q/BzvL/e/jIoRxg3+4Rtzd64P02VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKVM6EMTQAXQVjwphQ5g98te/q/4Yxiw9VYNn/IORkellkMxyVSkSKBRrx7xQospv
	 KTmMWdfvh10o1Zq7xPkUV4BmnIaPJUO+BPpDaME/4nuuxLNcz/32Tci7H7s6b0sc1a
	 eLp2kMNfSKjW3CdQs2yTdorwNQuyYaHSLLlGt8cUn6dRgthJdmuO8+rbmMSQFAV1WG
	 0y5TPBfipn+EUtSXdkkipkj6ERLSsk5NMIo35w+cRVLAehmIgDwu5KhO9flZRoJ1MO
	 d7j3WvR2Cs3pp/mBU1G3X7bL9nUekb7GB2z5aYIogLVXBFD4X6+0lqstOv97HcIrOh
	 M5zQAcAlkUVmg==
Date: Sat, 17 May 2025 08:09:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Hillf Danton
 <hdanton@sina.com>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH (EXPERIMENTAL)] team: replace term lock with rtnl lock
Message-ID: <20250517080948.3c20db08@kernel.org>
In-Reply-To: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>
References: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 16:32:20 +0900 Tetsuo Handa wrote:
> -	if (!mutex_trylock(&team->lock)) {
> +	/* Since this function is called from WQ context, RTNL can't be held by the caller. */
> +	if (!rtnl_trylock()) {
> +		/*
> +		 * Since RTNL is shared by many callers, and rtnl_unlock() is a slower operation
> +		 * than plain mutex_unlock(), rtnl_trylock() will be more easier to compate than
> +		 * mutex_trylock(). Therefore, we might want to delay a bit before retrying.
> +		 */

I think this was a trylock because there are places we try to cancel
this work while already holding the lock.

FWIW I'm not opposed to the patch. Could you wait a week and repost,
tho? We have a fix queued up in another tree - 6b1d3c5f675cc7
if we apply your patch to net-next there will be a build failure 
on merge. Not a showstopper but we'll merge the trees on Thu so it
can be easily avoided if we wait until then.

