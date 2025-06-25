Return-Path: <netdev+bounces-201124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3577FAE8292
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00773B65EC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D7825E452;
	Wed, 25 Jun 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p48+zz2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63325BF19;
	Wed, 25 Jun 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854102; cv=none; b=pPt6bK34ek1KkISPzJKxr6RWC6UUovtQHQmk0BgOroDDxpI684vFJOaVz8qwxwx2I+xklh9j6jqUSej3qMGleB4E3tOU+43r3HPvxFCrp+hJv/goZ1Nx22XzLSYm7dFSR5+UPNk55fzmZWkOVfSxPjLt/aE4UfAabSD7GtnlxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854102; c=relaxed/simple;
	bh=f8Gg0B0ETY0QdfV8ZauRjJQHPe3VqiRnhHvVy3Iu4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2RJDo2dCnFE3Gl5ihnBFWtdds3hjroSY3at6DsnpmnVaz6DeLb7wsnX9UPFlT5WZ9/HXi0eGAkgWDAsqTYKoci3BTnbQccWdHPLuNMoPsy0ephE65J8GiDr5B5FPeqhT6xrk6uoHZEZPKfRQxzCU3v7dLh6KzWX3IABsS0yuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p48+zz2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD96C4CEEA;
	Wed, 25 Jun 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750854101;
	bh=f8Gg0B0ETY0QdfV8ZauRjJQHPe3VqiRnhHvVy3Iu4TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p48+zz2nxK9ZkUx7/stu3afSzjVbDbl6PiqaTRATlK0NaXeZW5TzO5Jf3ZGj15rpB
	 EquM4vuL3++P/8R0klSsixml46q9GKyJyQFQbLgM04aIidVkJtV6wtTJjV5gPp7gw2
	 VNQqsoiee3irexPZNXlWbN5YKp8brUdVuI2AS8Qozvn+2CefgvenBCykB6c6QKjKS3
	 w+CVZzpRE4gFANAS6GR8en73jOWm01yr91qfXln+NN41V/otJY+Uiq21aaqeHgVWsJ
	 v4zlYnnnwVyoq2YE2MBYDEGPCbPVKDUKuC+k6dKOEK7Id7yqhSukUp6Awk+OajqmAt
	 YVWJnlDY8x0TQ==
Date: Wed, 25 Jun 2025 13:21:37 +0100
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
Subject: Re: [PATCH 3/4] igb: drop checksum constant cast to u16 in
 comparisons
Message-ID: <20250625122137.GD1562@horms.kernel.org>
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
 <96d55057-28f3-4f77-b5ac-6f2b6769aeb5@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d55057-28f3-4f77-b5ac-6f2b6769aeb5@jacekk.info>

On Tue, Jun 24, 2025 at 09:30:44PM +0200, Jacek Kowalski wrote:

As per my comment on patch 1/4, some text should go here.

> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>  drivers/net/ethernet/intel/igb/e1000_nvm.c   | 2 +-

These changes look good to me, but I think we should also do:

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 12ad1dc90169..44a85ad749a4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2406,7 +2406,7 @@ static s32 igb_update_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, (NVM_CHECKSUM_REG + offset), 1,
 				&checksum);
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index e654310b1161..c8638502c2be 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -668,7 +668,7 @@ s32 igb_update_nvm_checksum(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");


