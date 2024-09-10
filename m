Return-Path: <netdev+bounces-127147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C1974554
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F15283CD5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA318DF94;
	Tue, 10 Sep 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu9yfT52"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB111A255E
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005819; cv=none; b=s0KzfKMhobRFfMu/McaHa/i+lUcID7m82Kr/Yw0m2Frgn6uAHDHwQs6hF3jTPMQFIaPPHr8Zy9bbdigF7+a/Q+IiyFe2iOz0yqBMuppzq1eCTkhxNc9qE1fBEkqOBwxt57sbmgufhkuo55JwENjsVaztrg66n9VY8WUxyvD8c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005819; c=relaxed/simple;
	bh=sfENmLrwlWzvAOD+5XYnB6P0qhJUFGqNql3IOwc8uH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HukH6GzckQlATbbPA4WqJ/vXCV0JTEl0dWusxYVYngD6ZP7u6CadBbO9UdVALm6XowoEWU+n7qTG0S4+2WrHK5Z0DdSOuVwar1X0VgwaaHPZhe4GEr6+wV5FF1m0jhG0/jBXKKTfiABBcfaYXc50NJvEnqWiFSgq3ccnc96L3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu9yfT52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF2FC4CEC3;
	Tue, 10 Sep 2024 22:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005819;
	bh=sfENmLrwlWzvAOD+5XYnB6P0qhJUFGqNql3IOwc8uH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nu9yfT52CBf8EpHW3/x8hc+x4TEsNJt3RBAgA5+R5xuXiIwBgBpqFqu730gMGZAsb
	 LEla0lCFWkE3xZX8SuJPAtyyoWQiVAsLwkv4eja95BwOJjqStcx7bqQA9bjSjnLEds
	 JXCjVEtQzktNQaoDB/U/fiLi4914CKHAuXj87HqX3D6yNA0P11Sdcd25jySUqWZMj5
	 eosJ4sEvcdXdRKsJrgXXfBZATKMOcCR7w0BLB+sYY0PNssy3kloTX1TuF+v/enOUtC
	 eYb6mD8Od2ovSgElA9WK5r/4ATJ46eaG6Uo+10pHzdGhTIjAvgHpa6b+lYGdzj7ikH
	 ifHnX6Lk7gp+w==
Date: Tue, 10 Sep 2024 15:03:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v7 net-next 14/15] iavf: Add net_shaper_ops support
Message-ID: <20240910150337.6c397227@kernel.org>
In-Reply-To: <6c6b03fca7cc58658d47e0f3da68bbbcda4ae1ec.1725919039.git.pabeni@redhat.com>
References: <cover.1725919039.git.pabeni@redhat.com>
	<6c6b03fca7cc58658d47e0f3da68bbbcda4ae1ec.1725919039.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 00:10:08 +0200 Paolo Abeni wrote:
> +	if (adapter->netdev->reg_state == NETREG_REGISTERED) {
> +		mutex_lock(&adapter->netdev->lock);
> +		devlock = true;
> +	}

This leads to a false positive in cocci.

Any concerns about moving the mutex_init() / _destroy() into
alloc_netdev_mqs() / free_netdev()?  I guess one could argue
that narrower scope of the lock being valid may help catching 
errors, but I think we'll instead end up with more checks like
the above sprinkled around than bugs caught?

