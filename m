Return-Path: <netdev+bounces-25560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320F774BB3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699671C20E1A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37B156CC;
	Tue,  8 Aug 2023 20:54:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430014F71
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D38BC433C7;
	Tue,  8 Aug 2023 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691528055;
	bh=aaCGWt5PewNBgB1kC+KuCkVDdOigrAoZEpitBv3ac0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGhtmt+xJ2HkR09dH5RhI0OOXKccePel7ybv3A9/oy2XMGpDzjrwefHU7jr6IxQpk
	 V97686VSd7Qj1IdDdzoDcpMuSayOLjhPQFDTJrmG07sTN0Fh9OGYRKZ/HTtwuDe1Bq
	 zVqe43inuHWlYgq8gNyBq8mgaTrvqSGtfaS/gLJEmO5polkaB1Rp2ANF+fZfBRB2yu
	 8e7H8ZrSCANhBPOOMEv/h9HJaWzbWVDNYBhkhTNzmk0WG4dzAjgcRsxf0Al89PUKZ4
	 +cNcKh+R6Om+ILjyhyEkisJmNm0pXnyiHd/UzUG1+pwDI1q29ZsKgFGB/fU4j1zW+6
	 39y9uhpPL5Spg==
Date: Tue, 8 Aug 2023 22:54:11 +0200
From: Simon Horman <horms@kernel.org>
To: Wenjun Wu <wenjun1.wu@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	xuejun.zhang@intel.com, madhu.chittim@intel.com,
	qi.z.zhang@intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v2 5/5] iavf: Add VIRTCHNL Opcodes Support for
 Queue bw Setting
Message-ID: <ZNKrc6xchj8Jkct+@vergenet.net>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-6-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808015734.1060525-6-wenjun1.wu@intel.com>

On Tue, Aug 08, 2023 at 09:57:34AM +0800, Wenjun Wu wrote:
> From: Jun Zhang <xuejun.zhang@intel.com>

...

> @@ -2471,6 +2687,16 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  		if (!v_retval)
>  			iavf_netdev_features_vlan_strip_set(netdev, false);
>  		break;
> +	case VIRTCHNL_OP_GET_QOS_CAPS:
> +		u16 len = struct_size(adapter->qos_caps, cap,
> +				      IAVF_MAX_QOS_TC_NUM);

Hi Jun Zhang and Wenju Wu,

clang-16 complains about this quite a lot.
I think it is because it wants the declaration of len - and thus
the rest of this case - inside a block ({}).

 .../iavf_virtchnl.c:2691:3: error: expected expression
                 u16 len = struct_size(adapter->qos_caps, cap,
                 ^
 .../iavf_virtchnl.c:2693:46: error: use of undeclared identifier 'len'
                 memcpy(adapter->qos_caps, msg, min(msglen, len));
                                                            ^
 .../iavf_virtchnl.c:2693:46: error: use of undeclared identifier 'len'

> +		memcpy(adapter->qos_caps, msg, min(msglen, len));
> +		break;
> +	case VIRTCHNL_OP_CONFIG_QUANTA:
> +		iavf_notify_queue_config_complete(adapter);
> +		break;
> +	case VIRTCHNL_OP_CONFIG_QUEUE_BW:
> +		break;
>  	default:
>  		if (adapter->current_op && (v_opcode != adapter->current_op))
>  			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
> -- 
> 2.34.1
> 
> 

