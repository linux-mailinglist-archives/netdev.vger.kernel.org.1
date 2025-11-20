Return-Path: <netdev+bounces-240223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 806AEC71BA2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 283D734F772
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B181EB9F2;
	Thu, 20 Nov 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjqz7fPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7901A0BD6;
	Thu, 20 Nov 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603512; cv=none; b=RMvZvpfzriSsMECIuxWVBdXoPmEjI9xby05JOMEU4zTxpyX8M4egKYHLxGwVkLRscWik3D+ftHb+fLLHBc9MGf/b56bZa+xp1bTaFtW+ssJ7mlh9iZmHJV93gJymBWSbW1A52cnwtnPpmSThx/sBtk5YlTHYxdieH7agQXmzH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603512; c=relaxed/simple;
	bh=SzX2KHR9gIXn5bOMqReBmE7R+HL7IMhmVAPuYEN8ycY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7HEwzO0uYJZCJMJVWPj/XHv99uzZlAzpPKyC15uJ7rDJFBikcpaXOcFcksrOs7ZGTmHwCvwv5f94cpU0iwmKtAYkZ2RU3Zy59vyiuibnCZdEIVnbvjMBextjiHC8rUFnKLKzfYCT21w34q7nP3c/SwJgCQj7rHfTUgInrr6Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjqz7fPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12E8C4CEF5;
	Thu, 20 Nov 2025 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763603511;
	bh=SzX2KHR9gIXn5bOMqReBmE7R+HL7IMhmVAPuYEN8ycY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kjqz7fPLreOO/Z365070Tl16LMAvfIt9Zv4N3qPNwQ6cuOE9x2j2XWskO+O/Mygaa
	 KHC8qtxozKmJVSqZklTC5VIxMpRIDUsuMWrDuJw/WajFN+ksgnvuCCmfLgVa7gi+Vy
	 bnVc2UMl5aH29ZGyx9CJHlqAkXy0F53tJ6HptXgQVkkeGSl9bNTJu/HQRkgqa8TmcQ
	 KsXKRGjXv/U75jL9IWJStwjf19kE6YRHCDlIJukKm3entN0n+eLHvWvBbNZBARQWH0
	 Of5Yx0WC2jbopmEQf+jUSq7rjwouakB7ufmhw28sl+2bUbz7F9AERsgY1Z3PdRe1NF
	 H0I/QQEO71NbQ==
Date: Wed, 19 Nov 2025 17:51:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <pabeni@redhat.com>, <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow
 filter caps
Message-ID: <20251119175149.6bc8f7b2@kernel.org>
In-Reply-To: <20251119191524.4572-6-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
	<20251119191524.4572-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 13:15:16 -0600 Daniel Jurgens wrote:
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;

pop in a :

	/* private: */

comment here, otherwise kdoc will complain that @reserved is
undocumented.

> +	__u8 reserved[2];
> +};

That said, if you don't mind pls wait for Michael's review with 
the repost. Unless someone else provides review comments first.

