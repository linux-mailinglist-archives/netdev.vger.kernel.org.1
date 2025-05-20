Return-Path: <netdev+bounces-191904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40518ABDD91
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC47188A38B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07313246771;
	Tue, 20 May 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyOBr1Yq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4D1DA63D
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752110; cv=none; b=CNOFTMwnAYkuV+ShqV8NietF2Wo4SdHfyDiE6WEorYVKP1TPGq/DDNMkFWxjIogsVEdpNhuv1ZHwgmGcbdih56JssLxiFZgUypgG56VmFgvR1iaTwhZat1GV+XIdZYP6d29eWxtT+2cSw29d+peZ9YNdXS48hh0AVICJdD6N6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752110; c=relaxed/simple;
	bh=0rbdrVfqJF1jhSX+20MK7gzIug2TdRm/9Y0dn+wMLDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvknW/Bcxn0K2mbcPp/9H6zeUt26kgTEt90NEh8MfkrMgErLqdK7boITijJsgajYLFsS5KOlpiYHfJlboUtIg0uhaGrfeo4kpdxCSYXtR+pWPlxfGYX6U3nujBA1emb+2ER+sPyYJYdnEP2vs3e5NUW0e3zdsJnv8FCbHZed/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyOBr1Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EFEC4CEF1;
	Tue, 20 May 2025 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752110;
	bh=0rbdrVfqJF1jhSX+20MK7gzIug2TdRm/9Y0dn+wMLDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyOBr1YqSyI2DgJ0CYN3wlY+DmLrGdxFE+X78jje8yx+6/46EQShMbLmmfHQvOd3O
	 7i54mKAsVZFul7t4BeKEZlwRAfa9VOq4ysTnZdqA2qodI7qkTExzVwm+mgukI6Bszt
	 7I/hARAEKiaCwgBsmgcMHHOtziryZgyPnOiTrJGhrQwpJnhuegs7PHPkiQElOzzAp3
	 KRu/FCmddUbcf8hwZ3xOFVkIt0Ds0fqhzNzuBnJH/0uWsXG29P6v4Km94MF65VUhHL
	 wzVVEkVmf0o+62VSyn7NE0rNnkuQQqzB1I/lqADyRGhFr6P1jM1XsbKPh47GQkc/xU
	 pN1NmQ8QqZUcw==
Date: Tue, 20 May 2025 15:41:46 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/3] bnxt_en: Fix netdev locking in ULP IRQ functions
Message-ID: <20250520144146.GV365796@horms.kernel.org>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519204130.3097027-2-michael.chan@broadcom.com>

On Mon, May 19, 2025 at 01:41:28PM -0700, Michael Chan wrote:
> netdev_lock is already held when calling bnxt_ulp_irq_stop() and
> bnxt_ulp_irq_restart().  When converting rtnl_lock to netdev_lock,
> the original code was rtnl_dereference() to indicate that rtnl_lock
> was already held.  rcu_dereference_protected() is the correct
> conversion after replacing rtnl_lock with netdev_lock.
> 
> Add a new helper netdev_lock_dereference() similar to
> rtnl_dereference().
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


