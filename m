Return-Path: <netdev+bounces-73833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7E85EBDB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1ED1B2263B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C11EA8D;
	Wed, 21 Feb 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdEDmNcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA317553
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554782; cv=none; b=jeBqSBRBS0RpZuTgm/SMsnzjRa9h5LqfjNfwv/R9gUv3bU7ODqVH81MCOmXixipjPjMM2tOQjDtLDPF3yxznHMIf+Slbs2fLLCt87JaNIUFiYxj89e+Frc34h3LMrjanjb+1FPNTMVjehnMWvl8+hIoJuAwZUrGC3A5qV0slxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554782; c=relaxed/simple;
	bh=OpGpBztEQDHK2btdrsRPH8UdVqSA31u/NDebEWrybpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhYZrXgyDjKHR2/ot9ZZtTZ4ecycCJ9/NQFPLabRmgaMF1C1430OxG7zBgPJF7oYAc+C7iSwdGhohtaCulMVdITVAmdc5qQTjX8eSwxJi8EiarLMs49pOFmpC+VgLJhjKM7lowN6uVXtUkvdUTqeLfpyP3ncR/hr562gkoB/CV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdEDmNcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA7C433F1;
	Wed, 21 Feb 2024 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708554781;
	bh=OpGpBztEQDHK2btdrsRPH8UdVqSA31u/NDebEWrybpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdEDmNcpcsrnIRx9Xe0+bfsIbOXrP5dY+UzxT2yzICDOhGJJ7UQj1CJJ7MFS894OL
	 b7rYhWcLqPOtJw5VFf9X7SD+4vaFJZt2gMqN17sAtIDD4dRqiV2XienZ/f3s0w1ChY
	 kqY5N83uiRBGB9HhNXd3QWY67wo4ywxpoceKNNG+L6VbfJMQUAhGJb9wjv21Dh2Nqf
	 EuoMgA3EorZH/fmv7N+49Y2dNC5KS+Fr9Zt8bAGNlu7L4PrFTFivZVRaVfVwDJD+nM
	 rfnxn7Cl1pEAVm3wTCe7nzkmGlkFRQMtRlKOubyUJKcF8hVhCCzAAPkVSrBHyb3Fq7
	 hmVSz7i1qYPog==
Date: Wed, 21 Feb 2024 14:33:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mctp: put sock on tag allocation failure
Message-ID: <20240221143300.0ddec4a4@kernel.org>
In-Reply-To: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
References: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 15:53:08 +0800 Jeremy Kerr wrote:
> We may hold an extra reference on a socket if a tag allocation fails: we
> optimistically allocate the sk_key, and take a ref there, but do not
> drop if we end up not using the allocated key.
> 
> Ensure we're dropping the sock on this failure by doing a proper unref
> rather than directly kfree()ing.
> 
> Fixes: de8a6b15d965 ("net: mctp: add an explicit reference from a mctp_sk_key to sock")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Hi Jeremy!

This patch is good to be applied, right?
It got marked Not Applicable in patchwork, not sure why.

