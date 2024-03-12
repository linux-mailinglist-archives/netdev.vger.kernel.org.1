Return-Path: <netdev+bounces-79350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898B878D28
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE30AB220F8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7779E1;
	Tue, 12 Mar 2024 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCIRPQR8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AE79CC
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211580; cv=none; b=A8I3SwHXhgLL5n7CIUhWWtrjw2hpKRDwCDvEfJpBj37ZVdLvof+34AssbkYz1bw2nxQEH+W1oxeRH8MPCYwr0xKHmuKzZvVg/mk7llI1qOdVrxPOpClJSAbCSGfQOM3Vt+XdOt334RWCBRR5/kgJRWQSUL/VR4711iDuVkoHDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211580; c=relaxed/simple;
	bh=k4YG7aVC+ZRKmztaiXgZRHX2OzQs/BZYMbucpwPB234=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3xnZe+kynAe8YEpV1atD1phXFsnXXc9XnDO5Yq2H2ZYsccs6DECfbQ8N4ityCW0vt+sDvBov1zsapmpWCmxn7+mb5FlOv05NEaoG02mNigwIffWPIVq7Wej/yXDG1EEuRxzs0PFWbJ2Xh3yLNSUroY58ASf6Zz0XNNxiFgmmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCIRPQR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E450C433C7;
	Tue, 12 Mar 2024 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710211580;
	bh=k4YG7aVC+ZRKmztaiXgZRHX2OzQs/BZYMbucpwPB234=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCIRPQR8/DMIYWpL6/mXFpGCW1Y2rbXliC2biDBF9PuhN78nApqjaMhUnWPopqIV4
	 Z7tMXm+BNLCggmo5gLqjXGayciffuNLsUXbztB27cAcGtVIZaYXml5mMqJxRn3C3CT
	 VIZSmr+5C6JOj8UqcJu2HX3xami5oTOh2dsWsQPRha7R7/jHIOK8nKmR4WC8Q7EvLG
	 Cq8m3iehJUPyJZlRNw78TBz8XGn/JyC6kM6JSlNRohpM+PFG/LCfczBV39stjfWPEb
	 Ny8sov6a7v+VfGYOQoQiH+V1Hz5sPZlTKwgIU+4lNyI/EnX1F6XcXRnLzlkUMySKwa
	 UXWcGjYeEhuIg==
Date: Mon, 11 Mar 2024 19:46:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Steffen Klassert
 <steffen.klassert@secunet.com>
Cc: David Miller  <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <20240311194619.05db5bfd@kernel.org>
In-Reply-To: <20240311100510.03126bb9@kernel.org>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
	<20240306100438.3953516-3-steffen.klassert@secunet.com>
	<a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
	<20240311100510.03126bb9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 10:05:10 -0700 Jakub Kicinski wrote:
> > This is causing self-test failures:
> > 
> > https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> > 
> > reverting this change locally resolves the issue.
> > 
> > @Leon, @Steffen: could you please have a look?  
> 
> The failure in rtnetlink.sh seems to also be xfrm related:
> 
> # FAIL: ipsec_offload can't create SA
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/502821/10-rtnetlink-sh/stdout

That failure resolved itself, FWIW, so ignore that.

