Return-Path: <netdev+bounces-201120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C780DAE8275
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED01177AA9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2362147EF;
	Wed, 25 Jun 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjI9DPZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599F1DFCB;
	Wed, 25 Jun 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853913; cv=none; b=nhVEa3Cl68VEY2dvxqUdJyzIvgnEXCxoFEr2dT7gNoNlrEiqcHNGn6O6xZlCqAU1+fBsFzESmLmAnCUnyVV0PIQM4hVSKEKtzzwFJ41DaGeL0Szt7EAuQisbXhaXvapze/XvplCOaY3EAiDUztXRQSW2CGNrYaijz43bNtmzAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853913; c=relaxed/simple;
	bh=YcD58soRZs6EhUzGV8q+5DJoG2q3WNRV/I6q3HlGoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFOtBr6VQwxLS77lZGV7xz3qXSQ3DvyTpSQVo+AxgLgPiep/mjrQa0OuTda7YW9gTliGxtvFEYfx5JSMb101dJfL+i7N3fF5Ny9anOYoS3QU8NuCoGsrTC11k0ixYi0WCyxqx1D1qHEjpCBrZfIMk+XfCsqZPf5+pqRTzNgBnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjI9DPZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE704C4CEEE;
	Wed, 25 Jun 2025 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750853912;
	bh=YcD58soRZs6EhUzGV8q+5DJoG2q3WNRV/I6q3HlGoI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjI9DPZCwGR1deh3fSwu1ILgyrtOM8spHBVFLmLlUx+zMR6QzfUK99kYAaHP6Dsv+
	 aTVzSgm1kNY+HTSMCetYQ4H/q5wqjyuZ/CeBSg2dXt8jMs//57nvenmXP1kqWZZJ/f
	 zWZf3bc1X6Y3OrW7bF1QpNbabl4Sp+J+a8zopi7igGuzvWeEabiFXJn5VTVfuSkQYD
	 G6fGtAN0dy6s3/kYxGpAkYgrruwj1vbJ8m7z3dE9BxEETF3Xe05+kaNDy+xU7KAI7D
	 311zoO8jJmbt9vElQ7SQUNOOXpKw4GfcjNNNwWjupgdnQtDWq7Lu80ZdrgVWylMUfp
	 nDuc7l5NK3HAg==
Date: Wed, 25 Jun 2025 13:18:28 +0100
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
Subject: Re: [PATCH 1/4] e1000: drop checksum constant cast to u16 in
 comparisons
Message-ID: <20250625121828.GB1562@horms.kernel.org>
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>

On Tue, Jun 24, 2025 at 09:29:43PM +0200, Jacek Kowalski wrote:

Hi Jacek,

Thanks for the patchset.

Some feedback at a high level:

1. It's normal for patch-sets, to have a cover letter.
   That provides a handy place for high level comments,
   perhaps ironically, such as this one.

2. Please provide some text in the patch description.
   I know these changes are trivial. But we'd like to have something there.
   E.g.

   Remove unnecessary cast of constants to u16,
   allowing the C type system to do it's thing.

   No behavioural change intended.
   Compile tested only.

3. This patchset should probably be targeted at iwl-next, like this:

	Subject: [PATCH iwl-next] ...

4. Please make sure the patchset applies cleanly to it's target tree.
   It seems that in it's current form the patchset doesn't
   apply to iwl-next or net-next.

5. It's up to you. But in general there is no need
   to CC linux-kernel@vger.kernel.org on Networking patches

> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

As for this patch itself, it looks good to me.
But I think you missed two.

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index b5a31e8d84f4..0e5de52b1067 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
 		}
 		checksum += eeprom_data;
 	}
-	checksum = (u16)EEPROM_SUM - checksum;
+	checksum = EEPROM_SUM - checksum;
 	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
 		e_dbg("EEPROM Write Error\n");
 		return -E1000_ERR_EEPROM;
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 1c9071396b3c..556dbefdcef9 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -588,7 +588,7 @@ s32 e1000e_update_nvm_checksum_generic(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = e1000_write_nvm(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		e_dbg("NVM Write Error while updating checksum.\n");

-- 
pw-bot: changes-requested

