Return-Path: <netdev+bounces-195433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A6AD028E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798A83AF469
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5222882B4;
	Fri,  6 Jun 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv7RFqbi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB1287515
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214258; cv=none; b=DGbFhirHqC9jG4kjQAGNzmsn95Tvr8Ey0w3SjUGqUfHpLnPLYL9gcUTcxT21WiCDQ88B0j2CX3i7uYClCs0zdfsiF+ReY/ZZKnCgVgMth6/MDRLgg5tYvqMyIDixenM3L4chVEJY30mTsC/ety8dr6wKdIX3We7YreMkLphoY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214258; c=relaxed/simple;
	bh=+p2DZSFTm66PxkpOawJ0N9At4uCZLvjiuZ2KtwQ0YiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKHgQkyEsW1m2wCrpu5usJlY84SdDh+DZ9YVRFca1liByYKaaZvPc6Sww7FWs5jqQWCIk1Eso/l9kh3UXsiLYTlyd67HgL8bOO9c0Ol2og8HUxMxIGjNDyTg2cHZbtAwxZwZE8iX5J7JcsnzJTFjukZzoVaEI2PC9NUG1yQCMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv7RFqbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C671DC4CEEB;
	Fri,  6 Jun 2025 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749214257;
	bh=+p2DZSFTm66PxkpOawJ0N9At4uCZLvjiuZ2KtwQ0YiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dv7RFqbi958ihacr9YitAYENyxMHHGYR1P998+qqQ4nfrFJ6drtyrLo/kptNUUBZv
	 HLBEkgiz91SWV3yfnG6qhIsRs3T35HFT1IE///P4tjXLcB1MbwHAHWwZ5YVi6wTMxc
	 6BOqQ/wAdl4yqY+czFwlt1+INe7Npouj0bQm9vj7iut9mO0DmLV/ZSGegqKViPK92e
	 YpiPdI4nubYtdo06eFOMZwpsI4EAuLh6BmK1p3Zva0Vk5JPTCtdtDwZDRGpEYEqGx2
	 gYXZ9vii+cQIsq2b1PgDrML6KwFrXHXOclZL0JKtR/Y8mUICxO/oEQyDWkz6D5Duch
	 DxkWMJKPaOVsw==
Date: Fri, 6 Jun 2025 13:50:53 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 4/4] ice: read Tx timestamps in the IRQ top half
Message-ID: <20250606125053.GD120308@horms.kernel.org>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
 <20250520110823.1937981-10-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520110823.1937981-10-karol.kolacinski@intel.com>

On Tue, May 20, 2025 at 01:06:29PM +0200, Karol Kolacinski wrote:
> With sideband queue using delays and spin locks, it is possible to
> read timestamps from the PHY in the top half of the interrupt.
> 
> This removes bottom half scheduling delays and improves timestamping
> read times significantly, from >2 ms to <50 us.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


