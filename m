Return-Path: <netdev+bounces-215440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA291B2EAF0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AA727C72
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34060253954;
	Thu, 21 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1A6KqyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053F1A9F84
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740716; cv=none; b=jdl5AODa+0JDULAmLDfsjfdPG5vA7372kOvsRJzy2LdXtwNEl57/T+6As6mGHJa6zMRVcZa+As1oZN7s4bJ+cCbtLR50kSByx8X6zOl2NL9rR5DjGTxAJpojqyOvHyw7OQ2lK1H9z1GM4PHKTgJ4fLan0RiErcpf0gPafXF+hCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740716; c=relaxed/simple;
	bh=IvtQuPhY6mGZLQxl/B6sb8xg07akbyBEwdx+i1tv1ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEzpNnV8dfsaPp3QA0p4vJa1TBzXKEovtzcEgsh+uEXy8bSo3EifK5a+So6QP/SSWbAWB2gBpkJH/oTzlao/7V8YZGstqHrieRnO+JFIZDxIjYX5hFGpYHHzE0qkARiwgxnnC8TdctKJWbNPuOoJ3CS/IctOMEtO3b/1j0w7zVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1A6KqyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A69C4CEE7;
	Thu, 21 Aug 2025 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755740715;
	bh=IvtQuPhY6mGZLQxl/B6sb8xg07akbyBEwdx+i1tv1ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1A6KqyQTxc5zG8lkpxGHm2qZQAECUiUot8D35shYcG5PDQ3zT9mVOZ7pa98dSJ6w
	 kM4Om5U+/Qh0BCqqyyEs6kAtKMmeU85ngueRRQGDzx88TFfR/o/Pej39dP+3OgATNA
	 fCi4sCEE/02SR/cU7dXWyDIX5d396E15xZ0ex7fO1ZzfjJakr9AqI6qdktHNjjWSna
	 FfF/tWCCyhFyHXz7IjF13nwZD9KRXGGfPsW+/N0ymfcZ8nuj9pHp/at9HaVpkqZ9ka
	 4CNSkkOu/J8YTmawOwKJKurS6KY5c4VRRQgB2fLni/Ohq+EhBzjmLOoRvERO5A1vA7
	 xVK9Gl6+DszJA==
Date: Wed, 20 Aug 2025 18:45:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Emil Tantilov
 <emil.s.tantilov@intel.com>, david.m.ertman@intel.com,
 tatyana.e.nikolova@intel.com, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net v2 2/5] ice: fix possible leak in ice_plug_aux_dev()
 error path
Message-ID: <20250820184514.0cf9cbb5@kernel.org>
In-Reply-To: <20250819222000.3504873-3-anthony.l.nguyen@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
	<20250819222000.3504873-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 15:19:56 -0700 Tony Nguyen wrote:
>  	ret = auxiliary_device_init(adev);
> -	if (ret) {
> -		kfree(iadev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_iadev;
>  
>  	ret = auxiliary_device_add(adev);
> -	if (ret) {
> -		auxiliary_device_uninit(adev);
> -		return ret;

I think the code is correct as is. Once auxiliary_device_init()
returns the device is refcounted, auxiliary_device_uninit()
will call release, which is ice_adev_release(), which in turn
frees iadev.

> -	}
> +	if (ret)
> +		goto aux_dev_uninit;
>  
>  	mutex_lock(&pf->adev_mutex);
>  	cdev->adev = adev;
> @@ -339,6 +335,13 @@ int ice_plug_aux_dev(struct ice_pf *pf)
>  	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
>  
>  	return 0;
> +
> +aux_dev_uninit:
> +	auxiliary_device_uninit(adev);
> +free_iadev:
> +	kfree(iadev);
> +
> +	return ret;

