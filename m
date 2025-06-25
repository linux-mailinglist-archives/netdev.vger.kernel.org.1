Return-Path: <netdev+bounces-201125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9200AE8296
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FC03BAB60
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817525BF09;
	Wed, 25 Jun 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quK9fvsH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031D25BF06;
	Wed, 25 Jun 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854164; cv=none; b=ag7oUAFynddZtRz65fqDrRp6tm9tki0h71TUwn0r+J5OyotmwIZ1iy+s7yXLvW2+OFjhRETm5p4abjMcYnUAoxyPN7QEy+ERg1H5gZ4wvYhzOPr+5dD4Tows6PwPUJXcSD5Enln43anWihlw/9pfZ7CQaEboGQUGVIDOBru940Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854164; c=relaxed/simple;
	bh=wkVGryBaCpPd1NvNZOe7YYPCa/Neq2VMCi4HihyJ7xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3KMew9Us5QkhjcU0zt+ElWnqBuQAz1HfL4fvlp4sy8wCAK51G2o6Anc2zdv/xCmj5vYg+cgVl0O/ZY//zIQrx2RKIO/02WkNFFiPS8OqDB8sJtUSeHN7GNEHakfZuKno2+yJpDVoC6JYyXEtxgW67IwvulKC4Cy2fgV1dHUqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quK9fvsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84A1C4CEEA;
	Wed, 25 Jun 2025 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750854163;
	bh=wkVGryBaCpPd1NvNZOe7YYPCa/Neq2VMCi4HihyJ7xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quK9fvsH4UXmpUu60MSRW1iQNEjuq8IdOP7pt1+LbBeRRJEWO1TBbuzlfuXM0DZ8d
	 LaTFyeGBQoQCO+Ym/F+ifNYiznxvNn3i5HxnRXp7D5amEIXgl80bz8r/wUkW6PqKD8
	 Uc+202/3AazXAbnLji1WX2KE9cqUbG6wvahPk4ZV+M4y5475gDT+/nrGKFAYXGe5bF
	 8xuwnE1uJvczOZLqc2DKsWVUPxnmSL3LiUYzMGDXFUjZjJPVa5F57c4qZ5CzV6JpTJ
	 VWj5JlKExq8P2k+B37Q+VwbnHofGzJFb8zieSPLK+u+JmU+yBt85PGOqr6nP6NimM+
	 mhLaAZQ6oMUZA==
Date: Wed, 25 Jun 2025 13:22:39 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] igc: drop checksum constant cast to u16 in
 comparisons
Message-ID: <20250625122239.GE1562@horms.kernel.org>
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
 <5589e73f-2f18-4c08-8d10-0498555dd6be@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5589e73f-2f18-4c08-8d10-0498555dd6be@jacekk.info>

On Tue, Jun 24, 2025 at 09:31:08PM +0200, Jacek Kowalski wrote:
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/igc/igc_nvm.c | 2 +-

I think we should add this:

diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index c4fb35071636..a47b8d39238c 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -155,7 +155,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");

