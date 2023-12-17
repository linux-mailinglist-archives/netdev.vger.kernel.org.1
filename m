Return-Path: <netdev+bounces-58335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF910815E5B
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0341F220FC
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6C1C33;
	Sun, 17 Dec 2023 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsqZJ+vB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CE6FA5
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 09:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24132C433C7;
	Sun, 17 Dec 2023 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702805884;
	bh=rJCxPOezq/xtwUk9zZm1AIheVKwcz/mSEj+5gAZJskc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsqZJ+vBbfsUCTuqFgyNCzdHu1q5MVvGgEyxZ95AEh8ltDGqrjNdI71EEswJjTcaL
	 Pg37QMniSROZ/xTr7zKUljLEr52HKDKd64XGrkDIazzd76LZovL63WIelMpyV8EsH+
	 7NfDQFqRYWmgyZmZQVafbmGy/4Sl48DG5j7wtFeBwr+SAT7Wq6NZUilM3kARYtc70L
	 HedsBhCeGdcCtzT2RDCl48x9+C6gAjTGADpjEf9Ex2v3fOUUy5xKzMys8fP8G5WZXm
	 bBnsxd4r8hpf792xFJ+PDsZqqUZv7XzitjVCzqU5PCodg25+orqbgpdS+LupYVfewk
	 pIaSopwMwi2eA==
Date: Sun, 17 Dec 2023 09:38:00 +0000
From: Simon Horman <horms@kernel.org>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next v4 1/2] ixgbe: Refactor overtemp event handling
Message-ID: <20231217093800.GX6288@kernel.org>
References: <20231212104642.316887-1-jedrzej.jagielski@intel.com>
 <20231212104642.316887-2-jedrzej.jagielski@intel.com>
 <20231214095553.GJ5817@kernel.org>
 <DM6PR11MB2731112F4E12DF69363521ECF08CA@DM6PR11MB2731.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2731112F4E12DF69363521ECF08CA@DM6PR11MB2731.namprd11.prod.outlook.com>

On Thu, Dec 14, 2023 at 01:37:12PM +0000, Jagielski, Jedrzej wrote:
> From: Simon Horman <horms@kernel.org> 
> Sent: Thursday, December 14, 2023 10:56 AM
> 
> >On Tue, Dec 12, 2023 at 11:46:41AM +0100, Jedrzej Jagielski wrote:
> >> Currently ixgbe driver is notified of overheating events
> >> via internal IXGBE_ERR_OVERTEMP error code.
> >> 
> >> Change the approach for handle_lasi() to use freshly introduced
> >> is_overtemp function parameter which set when such event occurs.
> >> Change check_overtemp() to bool and return true if overtemp
> >> event occurs.
> >> 
> >> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> >> ---
> >> v2: change aproach to use additional function parameter to notify when overheat
> >> v4: change check_overtemp to bool
> >> 
> >> https://lore.kernel.org/netdev/20231208090055.303507-1-jedrzej.jagielski@intel.com/T/
> >> ---
> >
> >Hi Jedrzej,
> >
> >I like where this patch-set is going.
> >Please find some feedback from my side inline.
> 
> Hi Simon
> thank you for the review.
> 
> >
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 19 ++++----
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 26 ++++++-----
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 +-
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 45 +++++++++++--------
> >>  5 files changed, 54 insertions(+), 42 deletions(-)
> >> 
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> index 227415d61efc..9bff614788a2 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> @@ -2756,7 +2756,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
> >>  {
> >>  	struct ixgbe_hw *hw = &adapter->hw;
> >>  	u32 eicr = adapter->interrupt_event;
> >> -	s32 rc;
> >> +	bool overtemp;
> >>  
> >>  	if (test_bit(__IXGBE_DOWN, &adapter->state))
> >>  		return;
> >> @@ -2790,14 +2790,15 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
> >>  		}
> >>  
> >>  		/* Check if this is not due to overtemp */
> >> -		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
> >> +		overtemp = hw->phy.ops.check_overtemp(hw);
> >> +		if (!overtemp)
> >>  			return;
> >
> >I like the readability of the above, but FWIIW, I think it could
> >also be slightly more compactly written as (completely untested!):
> >
> >		if (!hw->phy.ops.check_overtemp(hw))
> >			return;
> 
> I decided to do that this way in order to improve readability,
> but sure it can be changed.

No need, I agree the readability is good.

> 
> >
> >>  
> >>  		break;
> >>  	case IXGBE_DEV_ID_X550EM_A_1G_T:
> >>  	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
> >> -		rc = hw->phy.ops.check_overtemp(hw);
> >> -		if (rc != IXGBE_ERR_OVERTEMP)
> >> +		overtemp = hw->phy.ops.check_overtemp(hw);
> >> +		if (!overtemp)
> >>  			return;
> >>  		break;
> >>  	default:
> >> @@ -7938,7 +7939,7 @@ static void ixgbe_service_timer(struct timer_list *t)
> >>  static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
> >>  {
> >>  	struct ixgbe_hw *hw = &adapter->hw;
> >> -	u32 status;
> >> +	bool overtemp;
> >>  
> >>  	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
> >>  		return;
> >> @@ -7948,11 +7949,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
> >>  	if (!hw->phy.ops.handle_lasi)
> >>  		return;
> >>  
> >> -	status = hw->phy.ops.handle_lasi(&adapter->hw);
> >> -	if (status != IXGBE_ERR_OVERTEMP)
> >> -		return;
> >> -
> >> -	e_crit(drv, "%s\n", ixgbe_overheat_msg);
> >> +	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
> >
> >Unless I am mistaken, the above can return an error. Should it be checked?
> 
> Since we are inside a void function we don't have many options to handle that.
> 
> I could be:
> 	err = hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
> 	if (err)
> 		return;
> 		
> 	if (!overtemp)
> 		return;
> 		
> So i decided to shorten it just to 
> 
> 	if (overtemp)
> 		...
> 		
> Some solution instead of returning here is to log warning when error
> encountered.		
> 
> >
> >Or alternatively, as this seems to be the only call-site,
> >could handle_lasi() return overtemp as a bool?
> 
> Actually handle_lasi() was designed to handle not only overtemp events
> but also link status ones. When changing it to bool it would be
> hard to differentiate them - then true only for overtemp case and false
> when link change or any error? I am not sure if this is a good direction.

I think it would improve the flow of the code a bit,
but you are right that it's not entirely great as
the callback doesn't only handle overtemp.

At this point I think what you already have is also fine.

> 
> >
> >> +	if (overtemp)
> >> +		e_crit(drv, "%s\n", ixgbe_overheat_msg);
> >>  }
> >>  
> >>  static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> >> index ca31638c6fb8..343c3ca9b1c9 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> >> @@ -396,9 +396,10 @@ static enum ixgbe_phy_type ixgbe_get_phy_type_from_id(u32 phy_id)
> >>   **/
> >>  s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
> >>  {
> >> -	u32 i;
> >> -	u16 ctrl = 0;
> >>  	s32 status = 0;
> >> +	bool overtemp;
> >> +	u16 ctrl = 0;
> >> +	u32 i;
> >>  
> >>  	if (hw->phy.type == ixgbe_phy_unknown)
> >>  		status = ixgbe_identify_phy_generic(hw);
> >> @@ -407,8 +408,8 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
> >>  		return status;
> >>  
> >>  	/* Don't reset PHY if it's shut down due to overtemp. */
> >> -	if (!hw->phy.reset_if_overtemp &&
> >> -	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
> >> +	overtemp = hw->phy.ops.check_overtemp(hw);
> >> +	if (!hw->phy.reset_if_overtemp && overtemp)
> >>  		return 0;
> >
> >Previously check_overtemp() would only be called if reset_if_overtemp was
> >false. Now it is called unconditionally. I'm not sure if it matters, but
> >the check for reset_if_overtemp may have avoided some logic, including a
> >call to hw->phy.ops.read_reg() in some cases.
> 
> Sure, the previous approach seems to be more efficient. Will be restored.

Great, thanks!

> 
> >
> >I wonder if it would be nicer to go back to the previous logic.
> >(completely untested!)
> >
> >	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
> >		return 0;
> >
> >>  
> >>  	/* Blocked by MNG FW so bail */
> >> @@ -2747,21 +2748,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
> >>   *
> >>   *  Checks if the LASI temp alarm status was triggered due to overtemp
> >>   **/
> >> -s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
> >> +bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
> >>  {
> >>  	u16 phy_data = 0;
> >> +	u32 status;
> >>  
> >>  	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
> >> -		return 0;
> >> +		return false;
> >>  
> >>  	/* Check that the LASI temp alarm status was triggered */
> >> -	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
> >> -			     MDIO_MMD_PMAPMD, &phy_data);
> >> +	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
> >> +				      MDIO_MMD_PMAPMD, &phy_data);
> >> +	if (status)
> >> +		return false;
> >>  
> >> -	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
> >> -		return 0;
> >> +	if (phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM)
> >> +		return true;
> >>  
> >> -	return IXGBE_ERR_OVERTEMP;
> >> +	return false;
> >
> >Maybe (completely untested!):
> 
> I like it.

:)

> 
> >
> >	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM)
> >
> >>  }
> >>  
> >>  /** ixgbe_set_copper_phy_power - Control power for copper phy
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> >> index 6544c4539c0d..ef72729d7c93 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> >> @@ -155,7 +155,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
> >>  s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
> >>  					u16 *list_offset,
> >>  					u16 *data_offset);
> >> -s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
> >> +bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
> >>  s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
> >>  				u8 dev_addr, u8 *data);
> >>  s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> >> index 2b00db92b08f..91c9ecca4cb5 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> >> @@ -3509,10 +3509,10 @@ struct ixgbe_phy_operations {
> >>  	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
> >>  	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
> >>  	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
> >> -	s32 (*check_overtemp)(struct ixgbe_hw *);
> >> +	bool (*check_overtemp)(struct ixgbe_hw *);
> >>  	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
> >>  	s32 (*enter_lplu)(struct ixgbe_hw *);
> >> -	s32 (*handle_lasi)(struct ixgbe_hw *hw);
> >> +	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
> >
> >I'm not sure of the history of this, or the nature of the other callbacks,
> >but I think that usually int is used as the return type when standard error
> >numbers are returned. I realise that is not strictly related to this patch,
> >maybe it could be addressed at some point?
> 
> Sure, so it will be scheduled for the future.

Thanks.

> >>  	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
> >>  				      u8 *value);
> >>  	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> >> index b3509b617a4e..59dd38dd8248 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> >> @@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
> >>  	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
> >>  	if (rc)
> >>  		return rc;
> >> +
> >>  	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
> >> -		return IXGBE_ERR_OVERTEMP;
> >> +		return -EIO;
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> @@ -2367,18 +2369,21 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
> >>   * @hw: pointer to hardware structure
> >>   * @lsc: pointer to boolean flag which indicates whether external Base T
> >>   *	 PHY interrupt is lsc
> >> + * @is_overtemp: indicate whether an overtemp event encountered
> >>   *
> >>   * Determime if external Base T PHY interrupt cause is high temperature
> >>   * failure alarm or link status change.
> >> - *
> >> - * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
> >> - * failure alarm, else return PHY access status.
> >>   **/
> >> -static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
> >> +static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
> >> +				       bool *is_overtemp)
> >>  {
> >>  	u32 status;
> >>  	u16 reg;
> >>  
> >> +	if (!hw || !lsc || !is_overtemp)
> >> +		return -EINVAL;
> >
> >I don't think this kind of defensive programming is appropriate
> >in a kernel driver.
> 
> Ok, i wasn't sure. Just wanted to ensure we won't use is_overtemp if NULL.
> 
> >
> >And unless I am mistaken, caller's don't check the return value of this
> >function (or propagate to a caller which doesn't check it).
> 
> ixgbe_handle_lasi_ext_t_x550em() which is calling this function checks its
> returned status.

In any case, the callers always pass the right arguments, and things
would blow up fairly quickly if they didn't. So I think the way
forwards is to simply drop the defensive checks.

> 
> >
> >> +
> >> +	*is_overtemp = false;
> >>  	*lsc = false;
> >>  
> >>  	/* Vendor alarm triggered */
> >> @@ -2410,7 +2415,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
> >>  	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
> >>  		/* power down the PHY in case the PHY FW didn't already */
> >>  		ixgbe_set_copper_phy_power(hw, false);
> >> -		return IXGBE_ERR_OVERTEMP;
> >> +		*is_overtemp = true;
> >> +		return -EIO;
> >>  	}
> >>  	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
> >>  		/*  device fault alarm triggered */
> >> @@ -2424,7 +2430,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
> >>  		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
> >>  			/* power down the PHY in case the PHY FW didn't */
> >>  			ixgbe_set_copper_phy_power(hw, false);
> >> -			return IXGBE_ERR_OVERTEMP;
> >> +			*is_overtemp = true;
> >> +			return -EIO;
> >>  		}
> >>  	}
> >>  
> >> @@ -2460,12 +2467,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
> >>   **/
> >>  static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
> >>  {
> >> +	bool lsc, overtemp;
> >>  	u32 status;
> >>  	u16 reg;
> >> -	bool lsc;
> >>  
> >>  	/* Clear interrupt flags */
> >> -	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
> >> +	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
> >>  
> >>  	/* Enable link status change alarm */
> >>  
> >> @@ -2544,21 +2551,23 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
> >>  /**
> >>   * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
> >>   * @hw: pointer to hardware structure
> >> + * @is_overtemp: indicate whether an overtemp event encountered
> >>   *
> >>   * Handle external Base T PHY interrupt. If high temperature
> >>   * failure alarm then return error, else if link status change
> >>   * then setup internal/external PHY link
> >> - *
> >> - * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
> >> - * failure alarm, else return PHY access status.
> >>   **/
> >> -static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
> >> +static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
> >> +					  bool *is_overtemp)
> >>  {
> >>  	struct ixgbe_phy_info *phy = &hw->phy;
> >>  	bool lsc;
> >>  	u32 status;
> >>  
> >> -	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
> >> +	if (!hw || !is_overtemp)
> >> +		return -EINVAL;
> >
> >Ditto.
> >
> >> +
> >> +	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
> >>  	if (status)
> >>  		return status;
> >>  
> >> @@ -3186,20 +3195,20 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
> >>   * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
> >>   * @hw: pointer to hardware structure
> >>   */
> >> -static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
> >> +static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
> >>  {
> >>  	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
> >>  	s32 rc;
> >>  
> >>  	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
> >>  	if (rc)
> >> -		return rc;
> >> +		return false;
> >>  
> >>  	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
> >>  		ixgbe_shutdown_fw_phy(hw);
> >> -		return IXGBE_ERR_OVERTEMP;
> >> +		return true;
> >>  	}
> >> -	return 0;
> >> +	return false;
> >>  }
> >>  
> >>  /**
> >> -- 
> >> 2.31.1
> >>

