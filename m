Return-Path: <netdev+bounces-122975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3314B963516
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661491C23AB0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913AF1AD9DE;
	Wed, 28 Aug 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THzEC4/H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671951A7AD8;
	Wed, 28 Aug 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885750; cv=none; b=pcsyDJ/mJzcZ/+5Q5sQtYZOzVjCdnENzTdCoYwZnChxJivLX3bVr+LWEI7s2DFcrg0fFIo6mk579HMOvDZwtCYm6QfichM43hgIBNE4CUB3V3h5HGvwdkROWcRfucBJFgiSMiZeBZ08HDylEz1fpxmvwv9Fiix+4XlZ/oauxQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885750; c=relaxed/simple;
	bh=PFsMiL0qiFPa05QdVLeAKku+pcgKvakffAoPLF8oaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6aU0t/p0Nr31VGg8EO8e5a9/3BNxEsiFVGhQIQwVaoI3WkHA721qNRqHzYJ3nuEtCzHSTXbWpB/QRJVMj2WpDDREI/+61bmP64OULqbfJD57Fqsh9kWTN4EE2N7/vQaHlBA50u9RfZeP9SsdLbaTaMKiRyPbDKxJ1pT6SCWVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THzEC4/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80605C4CEC0;
	Wed, 28 Aug 2024 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724885749;
	bh=PFsMiL0qiFPa05QdVLeAKku+pcgKvakffAoPLF8oaXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THzEC4/HYmKYNlj/doKgCXHx7ngGTUQc6v2RlrjOAK3U2E8W8zJK6+NglhmRnc/da
	 EaPsZBp7G1Ov/5U/9v2AwtPnpTQPrPvDkD7nnMzgUw6+h4OnOG/f7n6fl0bhDFa/Ax
	 ofvMQzBOuJxK7NDKkxZABfjpWy2YgsBBGhYFAYQ5MHWV9/mo+/Ju8fjH0OVGxziWVR
	 OI/xDTOIZRdqUWxGayoMW5NCUxMcPGcKJ4GY8TJSOs6rTibuGo2YI6u7CKsySh0uLX
	 zSqyDdrjRD+qXfdMU1OmvWkjv/NHh2TNN2cpwho/ESKCgU3FjI5cDkpExr5xK+cfGK
	 AmStnehYaelzA==
Date: Wed, 28 Aug 2024 15:55:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: Benjamin Poirier <benjamin.poirier@gmail.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Asmaa
 Mnebhi <asmaa@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v1] mlxbf_gige: disable port during stop()
Message-ID: <20240828155548.473b3cd1@kernel.org>
In-Reply-To: <CY5PR12MB6646FAC499454E380A87D829C7952@CY5PR12MB6646.namprd12.prod.outlook.com>
References: <20240816204808.30359-1-davthompson@nvidia.com>
	<ZsOVEMvzAXfaRiEY@f4>
	<20240819174722.7701fa3c@kernel.org>
	<CY5PR12MB6646FAC499454E380A87D829C7952@CY5PR12MB6646.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 21:37:06 +0000 David Thompson wrote:
> Hello Jakub and Benjamin, thanks for your input.
> 
> I will post a v2 adding information about the "mb()" call.

Perhaps this information you're adding will shed more light..

> Given the above information, does my mlxbf_gige driver patch still need to
> invoke "synchronize_irq()" in the stop() method?  The "mlxbf_gige_free_irq()"
> call within the stop() method invokes "free_irq()" for each of the driver's IRQs, so
> sounds like this "synchronize_irq()" is implicitly being invoked?

I was talking about the point in which you add the mb().
IDK what you're trying to protect from but it's after what looks like
disabling IRQ, and there's not free_irq() in that spot.

