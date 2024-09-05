Return-Path: <netdev+bounces-125341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E082E96CC4E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB4528396A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78AB677;
	Thu,  5 Sep 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9Opx7TA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C22564
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500012; cv=none; b=ull9nDqTSOuFyaN99m04aoFXDY9NqIO6tgj7U0co/tooF0BTOuFIR72BG6615EbdCCmETN7mW4BsSc9aCeJRKbuk6k8Pl/Ia9ilze8oTvuWpk4Hih50+yQUKHdBI54qI/aWzSkv7C+JNWtEulpi2bCnetbXzifz5Ycs+AWm2YNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500012; c=relaxed/simple;
	bh=WbmBXR+HYi6wksBXSfS3wWmcqeJUJp59nu5hq8OJKZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWF2yfGqJQxjDp9dI0lcI76RfSSC6ka+LACtGlM2GhMbizadUSeS6dAAGuIsn/Jan221+vjRfXIBwlyq8KPxUn50FOkLO6TjddbGxv8cjxf7eUjM5WrYAxUbJC23qZenP8sUrjaEEv0t4BXKha1J4r5C3G+KFu3oN78Sv7Ftx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9Opx7TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AABC4CEC2;
	Thu,  5 Sep 2024 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725500011;
	bh=WbmBXR+HYi6wksBXSfS3wWmcqeJUJp59nu5hq8OJKZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9Opx7TAsdGGerBIJmyUSOqY4XTpv638qBUPwrwYfAcRouLh8IQnhE9Pwe9FefjAB
	 MHoU5PPlxEyEL6YHD38aCQsB++mXElWf4R9F+ppIRYcv71HcvF5s/+KQTBmZMrThz4
	 xJXjM3CQeOmlHQupstfuEaVNwNjvBDzkWELAWQ7Uv/4qgqHplQ9bzNGsE+ZCxj9UA3
	 jYIoMGGIf0FGqGjGQB4i/eL31gTuqB2GkH2E5NgddjbthhQAieLWh3hBN3ftNRdGSS
	 jsEVGg8ftGHCfYAlQ7NH2lo13YUQ1+j7nM7MLMCdASDMZTR89DzQGKNoPK98+1D1l4
	 O0pE56YBKpmOw==
Date: Wed, 4 Sep 2024 18:33:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
Message-ID: <20240904183329.5c186909@kernel.org>
In-Reply-To: <160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:39 +0200 Paolo Abeni wrote:
> +		net_shaper_set_real_num_tx_queues(dev, txq);
> +
>  		dev_qdisc_change_real_num_tx(dev, txq);
>  
>  		dev->real_num_tx_queues = txq;

The dev->lock has to be taken here, around those three lines,
and then set / group must check QUEUE ids against 
dev->real_num_tx_queues, no? Otherwise the work 
net_shaper_set_real_num_tx_queues() does is prone to races?

