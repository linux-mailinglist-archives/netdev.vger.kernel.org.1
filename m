Return-Path: <netdev+bounces-113122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD993CAE2
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624051C20B7D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2A13CFA1;
	Thu, 25 Jul 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN9RsiSS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADA32C8C
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946769; cv=none; b=nxI04NpABfxEBdmhDzrvS4PPOpBOWv6hR0QODxJeQbw8o2ZzNYeD3bc8YZaP+czCLVdjYbZOgXU5wY6Wzaf0lyI/io87h0HhCBCFGoCL4IMXeF18UEhsNVSrZaYbXdnsrIkGLXCCQtRGBYjOt4MKNp707dh5PzeqI4zV6QwwAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946769; c=relaxed/simple;
	bh=c5MdbVjWmDIbKZDrWcTYs9bdWy1wxCEZ7ZPtRgxKMq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiQh78VGCUKjrGu3b+Q9iXG0pDWrjNsRbnUes78IgKQtEnJ1Nwtd0UuVNXwEUhmTD9Deo2FaKOsmYnht99vSgDjID68b0lhEZDLeU4QHc5M/c+LC3OqfqWmc7x5U5tYjCFGlXw/dWYXfdX4rCwfw4EHQhVvjN4TzI9RoiS3Q6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN9RsiSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9F9C116B1;
	Thu, 25 Jul 2024 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946769;
	bh=c5MdbVjWmDIbKZDrWcTYs9bdWy1wxCEZ7ZPtRgxKMq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nN9RsiSSvf4yR60eWHaPJkeu/kALQjTu5IIT2Z5aEmM2DfBpbzrWMMMz7Tpabnmyk
	 dcf1aLJd5QdB0CFsP20xoDLX1tMPK23ZtMTTZu2C8gYpHQKHCkJ50snuhkTFY0Qj32
	 zdhof6VKGUAlv47zlCWXf9WpfiBP+jMBLBpPhtvgMHVBh2xltAULaTYkErv1aUdYL9
	 36wY3b+fPr7qT2J9yxnT8EgWiQ0IMkFLUl0ciphyl+zshlo0mmtNQGX9xNAP1uuejG
	 34pDaIOyGauPCrQMiY87MfzPdxvQO0gScsFj5U7nd5ScMPsBwkGn8TbV5akjegLZ97
	 nKIEpqK0rX7Wg==
Date: Thu, 25 Jul 2024 15:32:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com
Subject: Re: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
Message-ID: <20240725153247.0d7716cd@kernel.org>
In-Reply-To: <ZqLEfyNLtCy25g6w@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240724222106.147744-1-michael.chan@broadcom.com>
	<20240724172536.318fb6f8@kernel.org>
	<20240725111912.7bc17cf6@kernel.org>
	<ZqLEfyNLtCy25g6w@C02YVCJELVCG.dhcp.broadcom.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 17:33:10 -0400 Andy Gospodarek wrote:
> > The Check failure tells us the traffic was sprayed.
> > The Defer Exception, well, self-explanatory: 
> >   "Cannot delete RX class rule: No such file or directory"  
> 
> We can take a look at that, but we currently do this on purpose.

Hm, I thought the rules may get lost if someone ifconfig down's
the entire device. Losing rules on a config change is much more
of a no-no, especially as long as the queue API remains all but 
a mirage.

