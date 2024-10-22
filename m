Return-Path: <netdev+bounces-137964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5799AB427
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75421F23AD0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9D1A264C;
	Tue, 22 Oct 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H12uxWY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811B1BB6B3
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615003; cv=none; b=HmdgvXzmxPYAmZN7nuHTzgX59tEwpV4+nGGUtDvl/DFWDr1NoR3UIAyFdMCIdEnj9CeK5QojnBofaGrSPw+m8pYEknG0CSDsQHp86oy8nHvmI/VqITewZX59bqrcTZ2dc3iNU2AgPp6rHgcJfJArzfE9FoiH07cU/X3BteQxbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615003; c=relaxed/simple;
	bh=AjzKygPdANospaxnArNXoVSevHXvx8KmuGpq9P4F3ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGOyBcirOHXDMFrLwa3FGwRAciYyVlkmEVcgRo4W3xHUsM5tN2Is8zwi3KjdbL+8rtQPDZsz3ogXK91H8uNMwXxSsUlzurv9UZv00Ja+spKlVkd/AUvT4sjbcUDpPJiZWwHVOyKVqchY9KcAwbzIQU561RHu807P1QS0IhNzX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H12uxWY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39192C4CEC3;
	Tue, 22 Oct 2024 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615003;
	bh=AjzKygPdANospaxnArNXoVSevHXvx8KmuGpq9P4F3ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H12uxWY1hKhp7IBy8aC1IC+hDfdgfspcGpAvykmoBAf5ZxPEhL9slnfeGGxqtWkH5
	 Dm8/r8hWek722RC8jo8/U+SuXvzYVyEPlgj7eHYMlLJYqjLwe7y8JoIDlSEXtekDlX
	 iefgrrv+9FjBZHnH8xqAWGedpvHNBvG2ru6SVuiNJlG9hjKS+fwrMYoWOv4dv+OyKO
	 CUdk+uBNCxqE+zSlrx3WZRpwUfNI+YUtBVY8IR1wqdViVm5SjeKD/nlrN8KiZikhoC
	 zA5MuN5FIOIPvQT9289BNF6SdBCIx29tGgtYhpRKsJJxMIBmOrj8NBkez7/4X+T/xC
	 oIKz/5rMMdhDQ==
Date: Tue, 22 Oct 2024 17:36:40 +0100
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [Patch net-next 5/5] enic: Adjust used MSI-X wq/rq/cq/interrupt
 resources in a more robust way
Message-ID: <20241022163640.GH402847@kernel.org>
References: <20241022041707.27402-1-neescoba@cisco.com>
 <20241022041707.27402-6-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041707.27402-6-neescoba@cisco.com>

On Mon, Oct 21, 2024 at 09:17:07PM -0700, Nelson Escobar wrote:
> Instead of erroring out on probe if the resources are not configured
> exactly right in hardware, try to make due with the resources we do have.
> 
> To accomplish this do the following:
> - Make enic_set_intr_mode() only set up interrupt related stuff.
> - Move resource adjustment out of enic_set_intr_mode() into its own
>   function, and basing the resources used on the most constrained
>   resource.
> - Move the kdump resources limitations into the new function too.
> 
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


