Return-Path: <netdev+bounces-81098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C5885CA3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F431C22D05
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B471B1292CD;
	Thu, 21 Mar 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnzNOqgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EF86622;
	Thu, 21 Mar 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036385; cv=none; b=hMW5xg283dkv2Qn8uEqcv6w5rOyRHkZhXq+x3BjW96YxC0T/FF2WIpYlNba1yM7FXoy+WbF0p8V8gyQSQsede6nMY7lT2nBUrFX3J0undDMShzhgJ9OJTxzBhFlJj08nKdqYp/B7d6a2y2/N97qJx4W+BROqPBJSQ5m7q3iGwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036385; c=relaxed/simple;
	bh=u1plv30F+lG476X5KY0kDYqxcIkHdlACBUkujzCpDsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsRrmx6SLSAfvAoOmJWZiXbi3NMVLMSQ67x0nm3MoXGkGZakW07uRUPvVuKSsdPOtIYJzHZazoEdVZ+rDet0RHJFPelTkFddTID1n+YF1aCnJtC5GfHH0C3Aa94KRoDWhtgrMqOH9LkPMYNzEZH9tT1lrXv76g/42T1bfSgZbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnzNOqgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DA1C433C7;
	Thu, 21 Mar 2024 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711036385;
	bh=u1plv30F+lG476X5KY0kDYqxcIkHdlACBUkujzCpDsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WnzNOqgkRAeL8SObeU/x5fTVlijinaevTys2p3gfi32uA64d1fElRYy7G5ACQFRiJ
	 +16TTUcYkC1LaYlEEyDWVxYZ8oYVCfWYX0G/7knDgUrW8FhTqeJeFYN8CuGkWQ04ZM
	 gCZINdNYuxXgAf3GcedrGM7tZ1F7zaWKL+xgZv+9QwyntK/zYc0eX2FzmliN9bu6QZ
	 20ZUZVCU3dq/s62TqNs2PIYLDlu7ZPmeWu76quGnLXP7FNrHHLphME8kBeyWX/Ol5Q
	 nu4VzoQM0CaF4vMwT3HFQ5705pYGAm/jikceVDtu460C52AuZUn5mGMOPstBMoUJ3Y
	 wY1+vkiJi556g==
Date: Thu, 21 Mar 2024 08:53:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Elad Nachman <enachman@marvell.com>, <taras.chornyi@plvision.eu>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew@lunn.ch>, <thomas.petazzoni@bootlin.com>,
 <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
 <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix prestera driver fail to probe twice
Message-ID: <20240321085303.489feb4a@kernel.org>
In-Reply-To: <20240321100600.5ccba11d@kmaincent-XPS-13-7390>
References: <20240320172008.2989693-1-enachman@marvell.com>
	<20240321100600.5ccba11d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 10:06:00 +0100 Kory Maincent wrote:
> > Fix issues resulting from insmod, rmmod and insmod of the
> > prestera driver:  
> 
> Please add "net" prefixes to all your patches subject, like that:
> [PATCH net v2 x/5]
> 
> I think the maintainers bots won't works if you don't.

They will default to net-next, which right now is perfectly fine.

