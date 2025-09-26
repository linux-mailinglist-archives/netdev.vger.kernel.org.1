Return-Path: <netdev+bounces-226777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3476BA521A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D11188CE9D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FA27F003;
	Fri, 26 Sep 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmpDTnPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B335971;
	Fri, 26 Sep 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919707; cv=none; b=Wk3yFluddeqIKhwl8e7mcSr+JZATYyevWVpakEu637XJU1DkGrt5IFAnXQKmiyKjVyAEyhUc3VMP2tVNZ6nVJjKC3iN4ILBd14UXikZqhN/jP37QGIVl6Ox2bASRWTjbirDWWjagqS3buL+gEJhcKKn63wrkzcnKizNprW+hmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919707; c=relaxed/simple;
	bh=BUVGQoH2N0WsNEAKZIM1gsCNHToYThnB7HqMBH0JPpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW6PbebLSf5wV5e3Z06o34p3XWrhI4WwU2wmldnyMAoLzuXQGdPlIAu/IXqBcYjyFTOqxgr+p4J54QFcKGAS+6yIeR1Vl3ISjzlZGNMjtTJYW+jCmnAtImkSFcRMREsA3qnpCrmtbJnxxGPWo5+bPDQsa1QvZakmputIcyrmJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmpDTnPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C006DC4CEF4;
	Fri, 26 Sep 2025 20:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919706;
	bh=BUVGQoH2N0WsNEAKZIM1gsCNHToYThnB7HqMBH0JPpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmpDTnPpmKVuZJLlrszCArpdBHew6QYLaJPiQQXNAFS3yVFrb6IaCd5oevs1iTU9b
	 QlSdShemBcQYuJJjgCNOT/4wNMnngOWGvHZ9Tltd5oOk2sXRQsi3JNKOpd019mzSZF
	 C8UBlKdeCt3YccteHv71iXBDiM1Aaq0sXX8ZKbqal4hQEDWkYyklETcGYP6P1rZ0xG
	 6N/q+LqI9r4CBVIquarzGxNClc50ty6JVO7puTJP8kbqLos7BTBDNnovZLXDCWQwl7
	 8dJFYA3V+Sb64WJ9NH3TTa455mXU51QIwW0EVhtWiWQayQGq4PCS8UEyiN/4Hmhsbr
	 fXz2LqMCHLqTQ==
Date: Fri, 26 Sep 2025 13:48:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <alex.williamson@redhat.com>, <pabeni@redhat.com>,
 <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>, <kevin.tian@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>
Subject: Re: [PATCH net-next v3 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20250926134824.6d0dc043@kernel.org>
In-Reply-To: <20250923141920.283862-7-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
	<20250923141920.283862-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:19:15 -0500 Daniel Jurgens wrote:
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
> 
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capabality. If partial matching is supported, the classifier mask for a
> particular field can be a subset of the mask for that field in the
> capability.
> 
> The rule consists of a priority, an action and a key. The key is a byte
> array containing headers corresponding to the selectors in the
> classifier.
> 
> This patch implements ethtool rules for ethernet headers.

What does the spec say about ordering of the rules?
If the rules are not evaluated in an equivalent way to a linear
walk / match please support location == RX_CLS_LOC_ANY only

