Return-Path: <netdev+bounces-165768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD4A3350C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AF2167AA0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFD13CA97;
	Thu, 13 Feb 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un+iAw/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B7132117;
	Thu, 13 Feb 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411943; cv=none; b=LkD5RF9pkUtsUU7f4Kk0BJYBvD2ED/PlC3roOdjSu9Ychi7MAXwQ1zuU/P0ie8IGLBWh5vDpafVvhBuG6K2s3FjojAvns7BqTdRWZMQ0wFWaIdZQnReNcDhiWi9QVQISrnrWbSnBtOOEh9V6EiUu1bEwy9Odz8V2ipUqZs5EIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411943; c=relaxed/simple;
	bh=5e9tQdjyUtvFsdWFPY66rgy1K6uwxdwMbTMFDYcH4wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WX91gIAcWgcpSWRH7sJDD7gkZcgOpiIMmMnC9syKjG9/O+h0Tu9DRAJlB/FZ1Z/lBudurmhZM0QIjWfCdUqYcCY3WYYuD4pwdCfiJBgHvw/NHYj7rv6cGRWKQYqABbs2gcx9xz7zeoNQ2GCki79eH3x2BDgXMdb2+yCyQz2zXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un+iAw/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE85C4CEDF;
	Thu, 13 Feb 2025 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411942;
	bh=5e9tQdjyUtvFsdWFPY66rgy1K6uwxdwMbTMFDYcH4wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Un+iAw/y1U6YD1qlsbtOYvwBpsZG4kOuALtUoheHGABfL+Eu7bruJ5XaiPm094Zx/
	 KEFiM6zyg3J1Ym9fVWNxRCeulk3FdwvAj8e0RC1bo5BI7jvFjeqEv1lJxOJheUfD63
	 TWX0DtHHX/pS1Xa9zHcwItl+LxS9DhXV1gp0Xb7bFLr28g6ZZKaI8+P27Y+OsA9ReS
	 r7SJ9VpXDOlBx3hVZFWXYLhvgzLI8EsGrugVjyTBxwojBPZe90RiGgxVWWueOJZU7z
	 zFwmUUjmKY82LWkOYDt+WJl/2rQR0x3s2aSZdd+4hFIIesZF/Sil6TxjzcV47xafi6
	 tLTCI+eMv3+TQ==
Date: Wed, 12 Feb 2025 17:59:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 "Wojciech Drewek" <wojciech.drewek@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <20250212175901.11199ce1@kernel.org>
In-Reply-To: <f66b15a3-1d83-43f9-8af2-071b76b133c0@intel.com>
References: <14ebc311-6fd6-4b0b-b314-8347c4efd9fc@stanley.mountain>
	<f66b15a3-1d83-43f9-8af2-071b76b133c0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 17:46:54 +0100 Alexander Lobakin wrote:
> > [PATCH next] ice: Fix signedness bug in ice_init_interrupt_scheme()  
> 
> I believe it should be "PATCH net" with
> 
> > If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
> > then it returns -ENOSPC so there is no need to check for that in the
> > caller.  In fact, because pf->msix.min is an unsigned int, it means that
> > any negative error codes are type promoted to high positive values and
> > treated as success.  So here the "return -ENOMEM;" is unreachable code.
> > Check for negatives instead.
> > 
> > Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")  
> 
> a 'Stable:' tag here.

Bug only exists in net-next if it comes from commit under Fixes.
So I think the patch is good as is.

