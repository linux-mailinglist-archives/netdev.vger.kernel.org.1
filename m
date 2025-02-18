Return-Path: <netdev+bounces-167488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE53A3A7BE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9021892E74
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044141E51ED;
	Tue, 18 Feb 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMVq5M+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462121B9F6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907421; cv=none; b=EZrffvxLCr7lKfb+cmDdj+EL9i6cROP+0gZhJJZ0ZeT52Q0u7QeJg8R8/dDr2VDQRRTymnDSnwzrYRHL0p1wS+JLaV+TTaVmIjqKMRAZPfUz1cZMTGcugUfLsTkDFipZG4YcWyo53d90QjuyxXhJawCo+rP//OmoMVE9K7U4/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907421; c=relaxed/simple;
	bh=+hqWcriKAA9mO5bQ4FjEZdNPrh+j9atAdoHgsaVxT28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+fLJzeH8HhY1ctU+uaJnEt4nqEtbzo1xJyAapzTaGXx4L6N6jGr/rl6b+gM9SqOAmkBrhgWxKtQe40h6BP5jn4tAlGUkqa+CO43xIbCDVdsxQpuZOaISNJmfnRq5CNM/9JOTU+bz0PrYdRPaaCgDFxHUon50zX0mZBxvT3ihj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMVq5M+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF02EC4CEE9;
	Tue, 18 Feb 2025 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907421;
	bh=+hqWcriKAA9mO5bQ4FjEZdNPrh+j9atAdoHgsaVxT28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMVq5M+/he1PfgVfQ/SIiUS2C9EhX/2oacPuPat3LAwyGgdFfJtiV99US3PxFa/fw
	 QeVYttFeFaKFdgz4isw2rfq+FB6dRx2Ebp9Rc7PICDTyEcmwaJJOo4jFrfgl1xddhc
	 1M2UDdtgQP0IsewSiQte+LtBMppEnY+hFXEAbIapUzTBjP5FnOGKJHEV0vPifb+PXk
	 BuR9Eg1npSn4aNbsmsvIJ+yW9S97AKJFgr/3sqNlIzICUS7Jgx8h0tgYC/XHX9HObv
	 w50j4KlVfz3Jehpl17Zy5kGCgzU7pxES1U534uqN6qygpALx5aMMFBhTpHaBNI835I
	 GRluDThCo3krg==
Date: Tue, 18 Feb 2025 19:36:57 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [iwl-next v3 4/4] ixgbe: turn off MDD while modifying SRRCTL
Message-ID: <20250218193657.GK1615191@kernel.org>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-5-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217090636.25113-5-michal.swiatkowski@linux.intel.com>

On Mon, Feb 17, 2025 at 10:06:36AM +0100, Michal Swiatkowski wrote:
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
> 
> Modifying SRRCTL register can generate MDD event.
> 
> Turn MDD off during SRRCTL register write to prevent generating MDD.
> 
> Fix RCT in ixgbe_set_rx_drop_en().
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


