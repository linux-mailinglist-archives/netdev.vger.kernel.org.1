Return-Path: <netdev+bounces-108011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D91D8BF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AE41F219C6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431578C8D;
	Mon,  1 Jul 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+3HPSYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013179B87
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818194; cv=none; b=Q5NRz9qX4KZ31mDUQwDAjgFf/cAWGznOMgmTekKhpe11AaHseIQm/MM5BCaXsIcVQYPu2sHf5NL5G8XMXua41rqRng/MCUbyPHOXdQwUDZFQ3XXRCDT3XyrBK3vRHfusw4yF6gU6cdJedjFoHsh9ItkA4E7pWqZjzR+Vdh7XfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818194; c=relaxed/simple;
	bh=3sMdIjt0zNB8mOI+VcaaG+vSQ+embNoX/DFtwS+97uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq+qOTmCOHM0u2GsVqfGU9hRqYdbTWonhWwY7wkd6rag2C4NmfyNW7M8MCWE9ATtgV6zkxsRzdigRXKW3B6fZtGvkfkXzG20mNYLQPyel9WnUc5MuCP2vV3mt9601tppwbCiGrdFKfIZudQBJr7rmbcj9uScXhTVb3LaVJm4+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+3HPSYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A1C32781;
	Mon,  1 Jul 2024 07:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719818194;
	bh=3sMdIjt0zNB8mOI+VcaaG+vSQ+embNoX/DFtwS+97uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+3HPSYeppyqZAgy7q4uvKGgmxxKZg5qvcsumlGX1ZFLTfnEMQtRUfgmAxdyrOfoW
	 kN0ONlK5HEoh9y2sL/W4OgME7P7tSUDvu00RMtSNZm7b1SEBb2eFmSViYjcnYEWjIP
	 INY+xASbA5NiztG+hcUCeQtycU1visjS4t8w7Bt3RCu8BDz8FBC/Ljn3TfYaEmj7xo
	 B+02IVdwj6Jx6xe9VMp12qawF7HLqLVqJzLoyWIK1Qyp+6Fp6GuDCvWogryVDJbFa4
	 zlMajmtSD6ejkv9pq3ra/z/02lXc0Rsa0Zk4glaij9E15VLwqqBHnUcEszOrP2R3BP
	 12FMwDJ+Szekg==
Date: Mon, 1 Jul 2024 08:16:31 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 3/4] ice: Use ice_adapter for PTP shared data
 instead of auxdev
Message-ID: <20240701071631.GE17134@kernel.org>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
 <20240626125456.27667-4-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626125456.27667-4-sergey.temerkhanov@intel.com>

On Wed, Jun 26, 2024 at 02:54:55PM +0200, Sergey Temerkhanov wrote:
> Use struct ice_adapter to hold shared PTP data and control PTP
> related actions instead of auxbus. This allows significant code
> simplification and faster access to the container fields used in
> the PTP support code.
> 
> Move the PTP port list to the ice_adapter container to simplify
> the code and avoid race conditions which could occur due to the
> synchronous nature of the initialization/access and
> certain memory saving can be achieved by moving PTP data into
> the ice_adapter itself.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 1d87dd67284d..de73762e6f27 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -170,6 +170,7 @@ struct ice_ptp_tx {
>   * and determine when the port's PHY offset is valid.
>   *
>   * @list_member: list member structure of auxiliary device
> + * @list_node: list member structure
>   * @tx: Tx timestamp tracking for this port
>   * @aux_dev: auxiliary device associated with this port
>   * @ov_work: delayed work task for tracking when PHY offset is valid
> @@ -180,6 +181,7 @@ struct ice_ptp_tx {
>   */
>  struct ice_ptp_port {
>  	struct list_head list_member;
> +	struct list_head list_node;
>  	struct ice_ptp_tx tx;
>  	struct auxiliary_device aux_dev;
>  	struct kthread_delayed_work ov_work;
> @@ -205,6 +207,7 @@ enum ice_ptp_tx_interrupt {
>   * @ports: list of porst handled by this port owner
>   * @lock: protect access to ports list
>   */
> +
>  struct ice_ptp_port_owner {
>  	struct auxiliary_driver aux_driver;
>  	struct list_head ports;

nit: the change in the hunk above seems unnecessary.

...

