Return-Path: <netdev+bounces-92987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB38B9872
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00075280EEC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044456B65;
	Thu,  2 May 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6F0Ach3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86842AAB
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644326; cv=none; b=CbZ06VdUHXFk7yhVXSOS7pqYwXaOoAmvkhow9EJ4IX7Lav2qybCfbNBTApKdlbEYRoGPmrozpRABA/w4JnxwQiQ7iTPYIUTRNV0i1+WD1QvjCNdBBWp89I7QGVY1lq46YLBDeATuS3pyn7/+iXoUOfKxb+2cZlPJBrvT6015Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644326; c=relaxed/simple;
	bh=0zITPawGhbAkeNgYxKSJcYnsGe04x0I+j2ABPijISGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPUsTBEZkMXGZXz2V3O0t48fJBp41QkFJaYtmNWud9DunpN50QENSW5vCs2K0IU+v2cSlL7mLUVjMZT5Z1ZfGsqcacygBg3c8h+A/TBWBFM7XgVQspveoD/EoMl5P1JMp9U1iYkgqH5YKxxDp6ohPGzAmqWA3hGzIHlG373lPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6F0Ach3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF64C113CC;
	Thu,  2 May 2024 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644326;
	bh=0zITPawGhbAkeNgYxKSJcYnsGe04x0I+j2ABPijISGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6F0Ach3oPZj4uqvQyg9DS4lYgtGyEqXvNeUqyvr+WSicqNspt9xV/ZkDUq1T2nLV
	 OPl7B6QgdTJ/DM2d1xhq5ZoPywHcplgGuK4TLTkQC2spKNbMV1fiYS0E1Xp6jBJwoJ
	 KHM52OryDO9VChGtA2JhQXxU9wyKgOjYy7610s9KwhCwm59HBUNwLT/bMy4tA87NZI
	 m+fiuBif8LUErP+sRCHOqlUGyaEvZ6TWsSCKSYTyEmcTijmpJp6yUMkgL/k+JlER4p
	 VhoCoQIb3z1Uzrm+ULQ6tI6/PYTY6N4cJEWg4izJ9AA95FQx0BVDdvDBTJbV8O44o7
	 0jwohKpMSSZAA==
Date: Thu, 2 May 2024 11:05:21 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v2 4/6] bnxt_en: Add a mutex to synchronize ULP
 operations
Message-ID: <20240502100521.GH2821784@kernel.org>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
 <20240501003056.100607-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003056.100607-5-michael.chan@broadcom.com>

On Tue, Apr 30, 2024 at 05:30:54PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> The current scheme relies heavily on the RTNL lock for all ULP
> operations between the L2 and the RoCE driver.  Add a new en_dev_lock
> mutex so that the asynchronous ULP_STOP and ULP_START operations
> can be serialized with bnxt_register_dev() and bnxt_unregister_dev()
> calls without relying on the RTNL lock.  The next patch will remove
> the RTNL lock from the ULP_STOP and ULP_START calls.
> 
> Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



