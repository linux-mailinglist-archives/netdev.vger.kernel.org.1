Return-Path: <netdev+bounces-186517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463ADA9F7F8
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DBB3A7753
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8A42957AC;
	Mon, 28 Apr 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNUJfWsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C592951DF;
	Mon, 28 Apr 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863438; cv=none; b=Thp89GhNvFGlNJJVFQqn9Sqc8bIMjtNqGocsZp0tYKDQ5SZMnaK6HNlVQ9VTrPErRo0CQHpEH8PSXp+w9V1jqjrZMQW/H6JEkbYDcBRAxUpLM7NOSOGaHHIRT093G5GzBd7JVzAcK3j4CvRjFG0wVtNgnuEqg7LlH90mbcUMNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863438; c=relaxed/simple;
	bh=3mrunX2wCW3v8UoNSP/xGZpZLdEawxATxyP2Eq6jwvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIAy62xOvDIVEiy8K2lp6TIwgiyN/BKCVfnDkkVvbn3Gv+Rbgz4HMV5HBiED2D615kNwGcWRkPiT9ZF/jOZk5kEvyT+pxXOXrRdzFANlnT/nQS+t86Ldc56EmhEtI5GXanGrhkZP6haxWUWr3WRtX5h05wsgL3jIis6f64DMoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNUJfWsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279CC4CEE4;
	Mon, 28 Apr 2025 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863437;
	bh=3mrunX2wCW3v8UoNSP/xGZpZLdEawxATxyP2Eq6jwvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNUJfWspUi7bWN54awdeqtZ35YhV76uh9X5LOJWgO7OCwYtAR0f0BAC3CU/4pecdS
	 iYWmQ/wrPlJlb0cl5uRjCHlnne9h/wJQ1w/f39RgtheWim/kLv4ewNmHAHVTRFJS2g
	 srScl+O4IyYI4889G9HgSu7bzb1rbhNDyfLenmk1pf9mXzTZML56oCN5hHgyMQ/UJ4
	 vLKowqVmECRrzvfBt2GN5IHXTsE5QO87hJPTWPueOquwSezWn33DfWGRAZr+UKEu09
	 38Nwb/pM9B8X9BzHdm5eXH33EOUe5HRGpY58Mi9k1xOH10XLSAKd5zvLIhd/oJi/FO
	 mKbzhj3vNSz0A==
Date: Mon, 28 Apr 2025 19:03:49 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-next v2 08/14] idpf: refactor idpf to use libie
 controlq and Xn APIs
Message-ID: <20250428180349.GF3339421@horms.kernel.org>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-9-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424113241.10061-9-larysa.zaremba@intel.com>

On Thu, Apr 24, 2025 at 01:32:31PM +0200, Larysa Zaremba wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> Support to initialize and configure controlq, Xn manager,
> MMIO and reset APIs was introduced in libie. As part of it,
> most of the existing controlq structures are renamed and
> modified. Use those APIs in idpf and make all the necessary changes.
> 
> Previously for the send and receive virtchnl messages, there
> used to be a memcpy involved in controlq code to copy the buffer
> info passed by the send function into the controlq specific
> buffers. There was no restriction to use automatic memory
> in that case. The new implementation in libie removed copying
> of the send buffer info and introduced DMA mapping of the
> send buffer itself. To accommodate it, use dynamic memory for
> the send buffers. In case of receive, idpf receives a page pool
> buffer allocated by the libie and care should be taken to
> release it after use in the idpf.
> 
> The changes are fairly trivial and localized, with a notable exception
> being the consolidation of idpf_vc_xn_shutdown and idpf_deinit_dflt_mbx
> under the latter name. This has some additional consequences that are
> addressed in the following patches.
> 
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
>  drivers/net/ethernet/intel/idpf/Makefile      |    2 -
>  drivers/net/ethernet/intel/idpf/idpf.h        |   42 +-
>  .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 -------
>  .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
>  .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
>  .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |   91 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   49 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   87 +-
>  drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    2 +-
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   89 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1622 ++++++-----------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   89 +-
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  303 ++-
>  16 files changed, 886 insertions(+), 2613 deletions(-)

This patch is rather large.
Is there a way it could be split up into more easily reviewable chunks?

>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

...

> @@ -2520,15 +2045,18 @@ static void idpf_finalize_ptype_lookup(struct libeth_rx_pt *ptype)
>   */
>  int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
>  {
> -	struct virtchnl2_get_ptype_info *get_ptype_info __free(kfree) = NULL;
> -	struct virtchnl2_get_ptype_info *ptype_info __free(kfree) = NULL;
> +	struct libie_ctlq_xn_send_params xn_params = {
> +		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +		.chnl_opcode	= VIRTCHNL2_OP_GET_PTYPE_INFO,
> +	};
>  	struct libeth_rx_pt *ptype_lkup __free(kfree) = NULL;
> +	struct virtchnl2_get_ptype_info *get_ptype_info;
>  	int max_ptype, ptypes_recvd = 0, ptype_offset;
>  	struct idpf_adapter *adapter = vport->adapter;
> -	struct idpf_vc_xn_params xn_params = {};
> +	struct virtchnl2_get_ptype_info *ptype_info;
> +	int buf_size = sizeof(*get_ptype_info);
>  	u16 next_ptype_id = 0;
> -	ssize_t reply_sz;
> -	int i, j, k;
> +	int i, j, k, err = 0;
>  
>  	if (vport->rx_ptype_lkup)
>  		return 0;
> @@ -2542,22 +2070,11 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
>  	if (!ptype_lkup)
>  		return -ENOMEM;
>  
> -	get_ptype_info = kzalloc(sizeof(*get_ptype_info), GFP_KERNEL);
> -	if (!get_ptype_info)
> -		return -ENOMEM;
> -
> -	ptype_info = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> -	if (!ptype_info)
> -		return -ENOMEM;
> -
> -	xn_params.vc_op = VIRTCHNL2_OP_GET_PTYPE_INFO;
> -	xn_params.send_buf.iov_base = get_ptype_info;
> -	xn_params.send_buf.iov_len = sizeof(*get_ptype_info);
> -	xn_params.recv_buf.iov_base = ptype_info;
> -	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
> -	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
> -
>  	while (next_ptype_id < max_ptype) {
> +		get_ptype_info = kzalloc(buf_size, GFP_KERNEL);
> +		if (!get_ptype_info)
> +			return -ENOMEM;
> +
>  		get_ptype_info->start_ptype_id = cpu_to_le16(next_ptype_id);
>  
>  		if ((next_ptype_id + IDPF_RX_MAX_PTYPES_PER_BUF) > max_ptype)
> @@ -2567,13 +2084,15 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
>  			get_ptype_info->num_ptypes =
>  				cpu_to_le16(IDPF_RX_MAX_PTYPES_PER_BUF);
>  
> -		reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> -		if (reply_sz < 0)
> -			return reply_sz;
> +		err = idpf_send_mb_msg(adapter, &xn_params, get_ptype_info,
> +				       buf_size);
> +		if (err)
> +			goto free_tx_buf;
>  
> +		ptype_info = xn_params.recv_mem.iov_base;
>  		ptypes_recvd += le16_to_cpu(ptype_info->num_ptypes);
>  		if (ptypes_recvd > max_ptype)
> -			return -EINVAL;

Should err be set to -EINVAL here?

Flagged by Smatch.

> +			goto free_rx_buf;
>  
>  		next_ptype_id = le16_to_cpu(get_ptype_info->start_ptype_id) +
>  				le16_to_cpu(get_ptype_info->num_ptypes);
> @@ -2589,8 +2108,8 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
>  					((u8 *)ptype_info + ptype_offset);
>  
>  			ptype_offset += IDPF_GET_PTYPE_SIZE(ptype);
> -			if (ptype_offset > IDPF_CTLQ_MAX_BUF_LEN)
> -				return -EINVAL;
> +			if (ptype_offset > LIBIE_CTLQ_MAX_BUF_LEN)
> +				goto free_rx_buf;
>  
>  			/* 0xFFFF indicates end of ptypes */
>  			if (le16_to_cpu(ptype->ptype_id_10) ==
> @@ -2720,12 +2239,24 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
>  
>  			idpf_finalize_ptype_lookup(&ptype_lkup[k]);
>  		}
> +		libie_ctlq_release_rx_buf(adapter->arq,
> +					  &xn_params.recv_mem);
> +		if (libie_cp_can_send_onstack(buf_size))
> +			kfree(get_ptype_info);
>  	}
>  
>  out:
>  	vport->rx_ptype_lkup = no_free_ptr(ptype_lkup);
>  
>  	return 0;
> +
> +free_rx_buf:
> +	libie_ctlq_release_rx_buf(adapter->arq, &xn_params.recv_mem);
> +free_tx_buf:
> +	if (libie_cp_can_send_onstack(buf_size))
> +		kfree(get_ptype_info);
> +
> +	return err;
>  }
>  
>  /**

...

