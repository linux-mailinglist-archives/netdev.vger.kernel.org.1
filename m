Return-Path: <netdev+bounces-90973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8138B0D15
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919021C24C2D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7915ECCB;
	Wed, 24 Apr 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH2I6RIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219D15ECD1
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970081; cv=none; b=Ydijzzl2JGdq/xtMJDaf76h7CmtQftHF4kSQjlqnpNZ7hKMnNxZ6zBIqsL5nivwH5VxWFS1bnPp4rMyO4InjaAkWMzquT3h7ZhQG10zfk19DuNwnHIxL6/y7yweZPcaIAPLj7LEgAmUS1V60a4swwTY8uvw7Kf5xeyR3pCH9/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970081; c=relaxed/simple;
	bh=+UWWmn0De5aw9sQkCZB5cR+2n/NdQihc7ZWdElNsOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT9IkZekOfaChF3/ach31L2NhIGjrJfQ3+ldzJg6J3Alm3LNoUTB3CKxbVa77bkJ/6Z6/v5oF2LwX70fY92S81cVGPvHeqymjIkQJG88FRmtb7uoovkk2SRUBC9E0IOYSxi3i489jtPWOCjZQIyOJxvmZiLGQIouUu1dZFyoRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH2I6RIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B922C113CD;
	Wed, 24 Apr 2024 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970080;
	bh=+UWWmn0De5aw9sQkCZB5cR+2n/NdQihc7ZWdElNsOUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gH2I6RIxO7W6zymoZbyC0IMt6XGbc2RjhnA1Qf2fZ5WNeZUM2wof9JGdBRh5gqeR7
	 gwenl4EeQiPmjcxcBzXtb9z8kRYUnQnaBoC6erItfK4BO8m6ECnlQKKGaaoWcEhAgC
	 hcKAAlvLpCk/8r/iZUijS6Ft7FENygCgMYRThJbYg1t1UapceuM96w8j+/Qn0o9mXt
	 4AAdqikyNzX8jADI9Pf9L8q7mV1vMdtMqCy+CNEuMALzgBkDUOtN8wDfyIpQx0QwVd
	 M2aW4MdWWHQcXauNjjGgJIY0fZ6ty0JWa1ILY/hvIyl0/Ah/JBd2qVfHOgLGz7JKWs
	 OJpVqVNW7s8Ow==
Date: Wed, 24 Apr 2024 15:47:55 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com, Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCH net 1/9] mlxsw: spectrum_acl_tcam: Fix race in region ID
 allocation
Message-ID: <20240424144755.GC42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <ce494b7940cadfe84f3e18da7785b51ef5f776e3.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce494b7940cadfe84f3e18da7785b51ef5f776e3.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:54PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Region identifiers can be allocated both when user space tries to insert
> a new tc filter and when filters are migrated from one region to another
> as part of the rehash delayed work.
> 
> There is no lock protecting the bitmap from which these identifiers are
> allocated from, which is racy and leads to bad parameter errors from the
> device's firmware.
> 
> Fix by converting the bitmap to IDA which handles its own locking. For
> consistency, do the same for the group identifiers that are part of the
> same structure.
> 
> Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
> Reported-by: Amit Cohen <amcohen@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


