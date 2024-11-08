Return-Path: <netdev+bounces-143427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50A9C268F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72842284623
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F91C1F3F;
	Fri,  8 Nov 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFeVnsPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB651C1F07
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097661; cv=none; b=pZauKm2INi0ATdHzara3cCFIw9UCAW0zO3plk0dF1A1UeqyMRU2W6OGEy+QERFu54q5Jra+R0VDR18MIqJsgE2xATrRMGxJdMbGe06dti5VpIRKraiqt+wm6rKhyj8FweBL8vNWi5zSA1jSPzs6299eQ/Xn2246vaTJLwasTgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097661; c=relaxed/simple;
	bh=Mtk4M7wTEghMQKho85bAKte8Qxs2DGGa6/kh9xByoZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6ppLxR/HwT3wpciWfvLq7Wh2nyfcZhFZzZlZqjJAdyHOrpfJaY5u04qj6BDS8NIVpJVSXTrAj+YuTcA6Jfc8OIqh2QybfDU52MLzqpLw/zT1sTUU/XXXl8M/sx4bRHFN5x9qbeU1XnLKkjxdrf0MixRq/+JyBzy5uhOeiqJHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFeVnsPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B9BC4CECD;
	Fri,  8 Nov 2024 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731097660;
	bh=Mtk4M7wTEghMQKho85bAKte8Qxs2DGGa6/kh9xByoZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFeVnsPOuTTMrtzHRehk5QDVPph7DwMryciEuYeeJGu1dZb0l0JFSw6iuyyHVtZu8
	 yczsPl91Kr/Zzxekyc7cxlQJbkuEIcUj8C8EDUQBe+O83RMw6XrO3Z7UfY5JAkrnFw
	 dGlAYlucPYLmO1BVHyudbiK4WNnqvZ6tDZm3HZJbnqfEN61RqcsNb/JQQDqbwloRT8
	 19PQf6g6VrG/nKWIbtkiHr/RrsF64OC62eyHz86JpJw5tkpdSYYEf0whzjNybSs3nG
	 YPVrOjBepTTL/WAdAF5KNGlddmAfPVjUXLoqy8IJLlApWCghd9IdywqPmy7dFEJM/U
	 tm2ppA6nvfgPQ==
Date: Fri, 8 Nov 2024 20:27:37 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net] ice: fix PHY timestamp extraction for ETH56G
Message-ID: <20241108202737.GI4507@kernel.org>
References: <20241107113257.466286-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107113257.466286-1-przemyslaw.korba@intel.com>

On Thu, Nov 07, 2024 at 12:32:57PM +0100, Przemyslaw Korba wrote:
> Fix incorrect PHY timestamp extraction for ETH56G.
> It's better to use FIELD_PREP() than manual shift.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


