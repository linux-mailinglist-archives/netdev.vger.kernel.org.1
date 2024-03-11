Return-Path: <netdev+bounces-79207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437568784A9
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6AB2815ED
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429D4503F;
	Mon, 11 Mar 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="s4CT/k2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36F51016
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173398; cv=none; b=OcZh5uQoGjhWeaMlupkT/DJFotaxx/sKD/V9ARPoQHKcxkNhgboh0/mELRBBFtdcTk/fmmFNjqAd0PTP7CrBMAclI8ieDZrepUKwWUlToHWj8PRcaLk0BqZ8xHZzRLDzxAudKLuy4n2ESAowbLuJJ+9R1UXTfFFPxap/8lIT9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173398; c=relaxed/simple;
	bh=J6kRSjU98lcI7ALeHBCbhHXHpYAwIZMkxG529nizQY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEypPyLwWZNNK78h0ivXjhC0kqqYoiB/pRS8SGK1Ezy58lQ0XHf/uHVxJ7VPSt9d4YECk/RIQ5PWc7hXOXrXmd7/6PaL1wzEUpWkfsjM/Uzjo69ZkLVtMhwsQ9oBiL25XxYb0IjkMYW0mAsMsb9s/vfZefkD7qiBaFWfv6fWPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=s4CT/k2R; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso38002101fa.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710173393; x=1710778193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jND2PoWlobXTgtKVu0nQYGPU8PyF4qGmKQ9PbpaN6TI=;
        b=s4CT/k2RTYWC63pSHnVq+i4QkKWbgDfFH8aWR1M2xwEQa0wdKafU/JDdPfx/sOpKg3
         VceVUHSHQcYuAJxg7xQXHRid/E/ksJjSP+6X5+NiyW+KwSerkNCWvxBZsExNe1biRqDY
         vkVL4u7s4g0/OUjbi8VjyoZh+By+90PiOIE5EKOMufSkwn2/gfqNPmrQ+jtOqKjL6io6
         maJKrJqJl/i/hiZyDvyS06U72w8LdpBwIa9CxBayYWbQUj62s3/zoS4Gms4xk0d+84Fr
         FLXmCiyTQkmUjLOnY+wxhTTaVD3t4AE4SauTygKccrluxtGkeciu4FA2CHu4O9EzWJe9
         WZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173393; x=1710778193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jND2PoWlobXTgtKVu0nQYGPU8PyF4qGmKQ9PbpaN6TI=;
        b=Ge8LLa1ofeV8QeUDm90bq9Vy98tqTx2lLwgJfIwzD7cUZ3RMsj7+pokndP+SF/xTkX
         cw++kNhJ5EGM8T5uA+eUchJKu1t7ZsZFtP4kCvq0FQXO7z8v/2NvpekgHb7Nf6FbyJTD
         vPz+0QNtY/NPygqUElpQ3XHjz11+OudfF8QvWUih/S6evQMld66gz1FsBTfpxC3CwIUa
         XdeSKAwFMjMtwZK1wdw2A/wy/ir31nG6GbowfrUolbm2c404YPKO/p9oXecaqEyHUnzN
         HShj6RgdfI0pZsTKb2yCi+DM+lDhXUbNRID44B8OP6LfoZF5+tjhwFI0Q6p09D9H9ZmK
         E4bg==
X-Forwarded-Encrypted: i=1; AJvYcCURyWr3lBPV8Bo04oVVPe/TJ0PMxuIVCLI/XRAEmNCHvCyxwfnjXBP5DCqPN5LdQVk+Guk+rqvpMHtwbrPqp4iUWL5z0xRj
X-Gm-Message-State: AOJu0YxlafO432KDa5TqNS2Z/aMK+p0vuQzWbTFRnxhguLPW9UxG/5ub
	hwnoubf+uGzEKrIE11CdPU5mPTP0fjKioOB870iyKU2G6KsRQjPVsEBA+CaD90A=
X-Google-Smtp-Source: AGHT+IGkrKTAvHacmSG1CNnnLPCThTx1yNA3g6myyFp7H89NpWF9vt+fnB80XGtlrffnHHbGPssylA==
X-Received: by 2002:ac2:4c05:0:b0:513:4a0c:b83d with SMTP id t5-20020ac24c05000000b005134a0cb83dmr5455434lfq.46.1710173393070;
        Mon, 11 Mar 2024 09:09:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004131cf78b4bsm10308255wmb.12.2024.03.11.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:09:52 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:09:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, kuba@kernel.org, horms@kernel.org,
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, victor.raj@intel.com,
	michal.wilczynski@intel.com, lukasz.czapnik@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 5/6] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <Ze8szTcH9jHR4fgw@nanopsycho>
References: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
 <20240305143942.23757-6-mateusz.polchlopek@intel.com>
 <ZegsMb-U8WbbT-mr@nanopsycho>
 <5853cc14-f630-4394-9d87-6ee5b1e10228@intel.com>
 <Ze6-NDACeH8j8mgW@nanopsycho>
 <ef0ced4a-5134-4304-b15a-5940f14527eb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0ced4a-5134-4304-b15a-5940f14527eb@intel.com>

Mon, Mar 11, 2024 at 01:49:37PM CET, mateusz.polchlopek@intel.com wrote:
>
>
>On 3/11/2024 9:17 AM, Jiri Pirko wrote:
>> Fri, Mar 08, 2024 at 11:16:25AM CET, mateusz.polchlopek@intel.com wrote:
>> > 
>> > 
>> > On 3/6/2024 9:41 AM, Jiri Pirko wrote:
>> > > Tue, Mar 05, 2024 at 03:39:41PM CET, mateusz.polchlopek@intel.com wrote:
>> > > > From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> > > > 
>> > > > It was observed that Tx performance was inconsistent across all queues
>> > > > and/or VSIs and that it was directly connected to existing 9-layer
>> > > > topology of the Tx scheduler.
>> > > > 
>> > > > Introduce new private devlink param - tx_scheduling_layers. This parameter
>> > > > gives user flexibility to choose the 5-layer transmit scheduler topology
>> > > > which helps to smooth out the transmit performance.
>> > > > 
>> > > > Allowed parameter values are 5 and 9.
>> > > > 
>> > > > Example usage:
>> > > > 
>> > > > Show:
>> > > > devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
>> > > > pci/0000:4b:00.0:
>> > > >    name tx_scheduling_layers type driver-specific
>> > > >      values:
>> > > >        cmode permanent value 9
>> > > > 
>> > > > Set:
>> > > > devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
>> > > > cmode permanent
>> > > > 
>> > > > devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 9
>> > > > cmode permanent
>> > > > 
>> > > > Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> > > > Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> > > > Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> > > > ---
>> > > > .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 +
>> > > > drivers/net/ethernet/intel/ice/ice_devlink.c  | 175 +++++++++++++++++-
>> > > > .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
>> > > > .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
>> > > > drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
>> > > > drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
>> > > > 6 files changed, 195 insertions(+), 9 deletions(-)
>> > > > 
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> > > > index 0487c425ae24..e76c388b9905 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> > > > @@ -1684,6 +1684,15 @@ struct ice_aqc_nvm {
>> > > > 
>> > > > #define ICE_AQC_NVM_START_POINT			0
>> > > > 
>> > > > +#define ICE_AQC_NVM_TX_TOPO_MOD_ID		0x14B
>> > > > +
>> > > > +struct ice_aqc_nvm_tx_topo_user_sel {
>> > > > +	__le16 length;
>> > > > +	u8 data;
>> > > > +#define ICE_AQC_NVM_TX_TOPO_USER_SEL	BIT(4)
>> > > > +	u8 reserved;
>> > > > +};
>> > > > +
>> > > > /* NVM Checksum Command (direct, 0x0706) */
>> > > > struct ice_aqc_nvm_checksum {
>> > > > 	u8 flags;
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> > > > index c0a89a1b4e88..f94793db460c 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> > > > @@ -770,6 +770,168 @@ ice_devlink_port_unsplit(struct devlink *devlink, struct devlink_port *port,
>> > > > 	return ice_devlink_port_split(devlink, port, 1, extack);
>> > > > }
>> > > > 
>> > > > +/**
>> > > > + * ice_get_tx_topo_user_sel - Read user's choice from flash
>> > > > + * @pf: pointer to pf structure
>> > > > + * @layers: value read from flash will be saved here
>> > > > + *
>> > > > + * Reads user's preference for Tx Scheduler Topology Tree from PFA TLV.
>> > > > + *
>> > > > + * Returns zero when read was successful, negative values otherwise.
>> > > > + */
>> > > > +static int ice_get_tx_topo_user_sel(struct ice_pf *pf, uint8_t *layers)
>> > > > +{
>> > > > +	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
>> > > > +	struct ice_hw *hw = &pf->hw;
>> > > > +	int err;
>> > > > +
>> > > > +	err = ice_acquire_nvm(hw, ICE_RES_READ);
>> > > > +	if (err)
>> > > > +		return err;
>> > > > +
>> > > > +	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
>> > > > +			      sizeof(usr_sel), &usr_sel, true, true, NULL);
>> > > > +	if (err)
>> > > > +		goto exit_release_res;
>> > > > +
>> > > > +	if (usr_sel.data & ICE_AQC_NVM_TX_TOPO_USER_SEL)
>> > > > +		*layers = ICE_SCHED_5_LAYERS;
>> > > > +	else
>> > > > +		*layers = ICE_SCHED_9_LAYERS;
>> > > > +
>> > > > +exit_release_res:
>> > > > +	ice_release_nvm(hw);
>> > > > +
>> > > > +	return err;
>> > > > +}
>> > > > +
>> > > > +/**
>> > > > + * ice_update_tx_topo_user_sel - Save user's preference in flash
>> > > > + * @pf: pointer to pf structure
>> > > > + * @layers: value to be saved in flash
>> > > > + *
>> > > > + * Variable "layers" defines user's preference about number of layers in Tx
>> > > > + * Scheduler Topology Tree. This choice should be stored in PFA TLV field
>> > > > + * and be picked up by driver, next time during init.
>> > > > + *
>> > > > + * Returns zero when save was successful, negative values otherwise.
>> > > > + */
>> > > > +static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
>> > > > +{
>> > > > +	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
>> > > > +	struct ice_hw *hw = &pf->hw;
>> > > > +	int err;
>> > > > +
>> > > > +	err = ice_acquire_nvm(hw, ICE_RES_WRITE);
>> > > > +	if (err)
>> > > > +		return err;
>> > > > +
>> > > > +	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
>> > > > +			      sizeof(usr_sel), &usr_sel, true, true, NULL);
>> > > > +	if (err)
>> > > > +		goto exit_release_res;
>> > > > +
>> > > > +	if (layers == ICE_SCHED_5_LAYERS)
>> > > > +		usr_sel.data |= ICE_AQC_NVM_TX_TOPO_USER_SEL;
>> > > > +	else
>> > > > +		usr_sel.data &= ~ICE_AQC_NVM_TX_TOPO_USER_SEL;
>> > > > +
>> > > > +	err = ice_write_one_nvm_block(pf, ICE_AQC_NVM_TX_TOPO_MOD_ID, 2,
>> > > > +				      sizeof(usr_sel.data), &usr_sel.data,
>> > > > +				      true, NULL, NULL);
>> > > > +	if (err)
>> > > > +		err = -EIO;
>> > > 
>> > > Just return err. ice_write_one_nvm_block() seems to return it always
>> > > in case of an error.
>> > > 
>> > > pw-bot: cr
>> > > 
>> > > 
>> > > > +
>> > > > +exit_release_res:
>> > > > +	ice_release_nvm(hw);
>> > > > +
>> > > > +	return err;
>> > > > +}
>> > > > +
>> > > > +/**
>> > > > + * ice_devlink_tx_sched_layers_get - Get tx_scheduling_layers parameter
>> > > > + * @devlink: pointer to the devlink instance
>> > > > + * @id: the parameter ID to set
>> > > > + * @ctx: context to store the parameter value
>> > > > + *
>> > > > + * Returns zero on success and negative value on failure.
>> > > > + */
>> > > > +static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
>> > > > +					   struct devlink_param_gset_ctx *ctx)
>> > > > +{
>> > > > +	struct ice_pf *pf = devlink_priv(devlink);
>> > > > +	int err;
>> > > > +
>> > > > +	err = ice_get_tx_topo_user_sel(pf, &ctx->val.vu8);
>> > > > +	if (err)
>> > > > +		return -EIO;
>> > > 
>> > > Why you return -EIO and not just "err". ice_get_tx_topo_user_sel() seems
>> > > to return proper -EXX values.
>> > > 
>> > > 
>> > > > +
>> > > > +	return 0;
>> > > > +}
>> > > > +
>> > > > +/**
>> > > > + * ice_devlink_tx_sched_layers_set - Set tx_scheduling_layers parameter
>> > > > + * @devlink: pointer to the devlink instance
>> > > > + * @id: the parameter ID to set
>> > > > + * @ctx: context to get the parameter value
>> > > > + * @extack: netlink extended ACK structure
>> > > > + *
>> > > > + * Returns zero on success and negative value on failure.
>> > > > + */
>> > > > +static int ice_devlink_tx_sched_layers_set(struct devlink *devlink, u32 id,
>> > > > +					   struct devlink_param_gset_ctx *ctx,
>> > > > +					   struct netlink_ext_ack *extack)
>> > > > +{
>> > > > +	struct ice_pf *pf = devlink_priv(devlink);
>> > > > +	int err;
>> > > > +
>> > > > +	err = ice_update_tx_topo_user_sel(pf, ctx->val.vu8);
>> > > > +	if (err)
>> > > > +		return -EIO;
>> > > 
>> > > Why you return -EIO and not just "err". ice_update_tx_topo_user_sel() seems
>> > > to return proper -EXX values.
>> > > 
>> > > 
>> > > > +
>> > > > +	NL_SET_ERR_MSG_MOD(extack,
>> > > > +			   "Tx scheduling layers have been changed on this device. You must do the PCI slot powercycle for the change to take effect.");
>> > > > +
>> > > > +	return 0;
>> > > > +}
>> > > > +
>> > > > +/**
>> > > > + * ice_devlink_tx_sched_layers_validate - Validate passed tx_scheduling_layers
>> > > > + *                                       parameter value
>> > > > + * @devlink: unused pointer to devlink instance
>> > > > + * @id: the parameter ID to validate
>> > > > + * @val: value to validate
>> > > > + * @extack: netlink extended ACK structure
>> > > > + *
>> > > > + * Supported values are:
>> > > > + * - 5 - five layers Tx Scheduler Topology Tree
>> > > > + * - 9 - nine layers Tx Scheduler Topology Tree
>> > > > + *
>> > > > + * Returns zero when passed parameter value is supported. Negative value on
>> > > > + * error.
>> > > > + */
>> > > > +static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
>> > > > +						union devlink_param_value val,
>> > > > +						struct netlink_ext_ack *extack)
>> > > > +{
>> > > > +	struct ice_pf *pf = devlink_priv(devlink);
>> > > > +	struct ice_hw *hw = &pf->hw;
>> > > > +
>> > > > +	if (!hw->func_caps.common_cap.tx_sched_topo_comp_mode_en) {
>> > > > +		NL_SET_ERR_MSG_MOD(extack,
>> > > > +				   "Requested feature is not supported by the FW on this device.");
>> > > > +		return -EOPNOTSUPP;
>> > > 
>> > > Why can't you only return this param in case hw->func_caps.common_cap.tx_sched_topo_comp_mode_en
>> > > is true? Then you don't need this check.
>> > > 
>> > > 
>> > 
>> > Hmm... This comment is not really clear for me, I do not see the opportunity
>> > to change that now. I want to stay with both checks, to verify if capability
>> > is set and if user passed the correct number of layers
>> 
>> My point is, during param register, you know if this param is supported
>> or not. Why don't you check hw->func_caps.common_cap.tx_sched_topo_comp_mode_en
>> and register this param only if it is true?
>> 
>> 
>
>I see now. Okay, I will simplify that and I will send new version
>tomorrow.
>On the other hand I plan to send other series for devlink soon. That
>will include an enhancement to check similar stuff in drivers in more
>convenient way.

https://patchwork.hopto.org/net-next.html

>
>> > 
>> > > > +	}
>> > > > +
>> > > > +	if (val.vu8 != ICE_SCHED_5_LAYERS && val.vu8 != ICE_SCHED_9_LAYERS) {
>> > > > +		NL_SET_ERR_MSG_MOD(extack,
>> > > > +				   "Wrong number of tx scheduler layers provided.");
>> > > > +		return -EINVAL;
>> > > > +	}
>> > > > +
>> > > > +	return 0;
>> > > > +}
>> > > > +
>> > > > /**
>> > > >    * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
>> > > >    * @pf: pf struct
>> > > > @@ -1478,6 +1640,11 @@ static int ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
>> > > > 	return 0;
>> > > > }
>> > > > 
>> > > > +enum ice_param_id {
>> > > > +	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> > > > +	ICE_DEVLINK_PARAM_ID_TX_BALANCE,
>> > > > +};
>> > > > +
>> > > > static const struct devlink_param ice_devlink_params[] = {
>> > > > 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> > > > 			      ice_devlink_enable_roce_get,
>> > > > @@ -1487,7 +1654,13 @@ static const struct devlink_param ice_devlink_params[] = {
>> > > > 			      ice_devlink_enable_iw_get,
>> > > > 			      ice_devlink_enable_iw_set,
>> > > > 			      ice_devlink_enable_iw_validate),
>> > > > -
>> > > > +	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_BALANCE,
>> > > > +			     "tx_scheduling_layers",
>> > > > +			     DEVLINK_PARAM_TYPE_U8,
>> > > > +			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>> > > > +			     ice_devlink_tx_sched_layers_get,
>> > > > +			     ice_devlink_tx_sched_layers_set,
>> > > > +			     ice_devlink_tx_sched_layers_validate),
>> > > > };
>> > > > 
>> > > > static void ice_devlink_free(void *devlink_ptr)
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> > > > index 319a2d6fe26c..f81db6c107c8 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> > > > @@ -286,10 +286,9 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>> > > >    *
>> > > >    * Returns: zero on success, or a negative error code on failure.
>> > > >    */
>> > > > -static int
>> > > > -ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> > > > -			u16 block_size, u8 *block, bool last_cmd,
>> > > > -			u8 *reset_level, struct netlink_ext_ack *extack)
>> > > > +int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> > > > +			    u16 block_size, u8 *block, bool last_cmd,
>> > > > +			    u8 *reset_level, struct netlink_ext_ack *extack)
>> > > > {
>> > > > 	u16 completion_module, completion_retval;
>> > > > 	struct device *dev = ice_pf_to_dev(pf);
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.h b/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> > > > index 750574885716..04b200462757 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> > > > @@ -9,5 +9,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
>> > > > 			     struct netlink_ext_ack *extack);
>> > > > int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>> > > > 			    struct netlink_ext_ack *extack);
>> > > > +int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> > > > +			    u16 block_size, u8 *block, bool last_cmd,
>> > > > +			    u8 *reset_level, struct netlink_ext_ack *extack);
>> > > > 
>> > > > #endif
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
>> > > > index d4e05d2cb30c..84eab92dc03c 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
>> > > > @@ -18,10 +18,9 @@
>> > > >    *
>> > > >    * Read the NVM using the admin queue commands (0x0701)
>> > > >    */
>> > > > -static int
>> > > > -ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset, u16 length,
>> > > > -		void *data, bool last_command, bool read_shadow_ram,
>> > > > -		struct ice_sq_cd *cd)
>> > > > +int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
>> > > > +		    u16 length, void *data, bool last_command,
>> > > > +		    bool read_shadow_ram, struct ice_sq_cd *cd)
>> > > > {
>> > > > 	struct ice_aq_desc desc;
>> > > > 	struct ice_aqc_nvm *cmd;
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
>> > > > index 774c2317967d..63cdc6bdac58 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_nvm.h
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
>> > > > @@ -14,6 +14,9 @@ struct ice_orom_civd_info {
>> > > > 
>> > > > int ice_acquire_nvm(struct ice_hw *hw, enum ice_aq_res_access_type access);
>> > > > void ice_release_nvm(struct ice_hw *hw);
>> > > > +int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
>> > > > +		    u16 length, void *data, bool last_command,
>> > > > +		    bool read_shadow_ram, struct ice_sq_cd *cd);
>> > > > int
>> > > > ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
>> > > > 		  bool read_shadow_ram);
>> > > > -- 
>> > > > 2.38.1
>> > > > 

