Return-Path: <netdev+bounces-171599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8CA4DC57
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79B71889948
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E53201019;
	Tue,  4 Mar 2025 11:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482961FF1DE
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086998; cv=none; b=o6bTcZZ+UvyI9zpw88aAwpdP4S8ddYNa0X3O58cxJqRh+pzY/6cEefm/llBLAz5Pc9rL0ZNS1PeTSkL4Q7kyzPhiZztSI626UqrR/ZlLuaMrz4ajw/8wGnD1ssBJZG56oyfQ3+JvDPo43MlSqPqUdIzbeduSZTxyu/l2R4VgQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086998; c=relaxed/simple;
	bh=SwlsRYrllrlhCOgySq+sgp5w+qo2bhhZUxTpP6TOFqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmQrh2GAlxsa0Dxr1CnoD0V3Vsd21p0PF2J3UqEHYag6vszXSTHibnlqAOkAsCGvbmofylzQEpPVh1Dgw7gxvOcDTVVQQvpjF/vNmm7/XcefLynFGpjJ9FUuTgKzE1GJHztEfhiTTa0uvNjZsh4zaV+5zCnB5McGhkGfmvD2sKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F3FE61E6478F;
	Tue, 04 Mar 2025 12:15:58 +0100 (CET)
Message-ID: <9f6b830f-d2ee-4fde-a131-a956a6e84df7@molgen.mpg.de>
Date: Tue, 4 Mar 2025 12:15:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-net v3 1/5] virtchnl: make proto and
 filter action count unsigned
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Jan Glaza <jan.glaza@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250304110833.95997-4-martyna.szapar-mudlaw@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250304110833.95997-4-martyna.szapar-mudlaw@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jan, dear Martina,


Thank you for the patch.

Am 04.03.25 um 12:08 schrieb Martyna Szapar-Mudlaw:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
> should never be negative while still being valid. Changing it from
> int to u32 ensures proper handling of values in virtchnl messages in
> driverrs and prevents unintended behavior.
> In its current signed form, a negative count does not trigger
> an error in ice driver but instead results in it being treated as 0.
> This can lead to unexpected outcomes when processing messages.
> By using u32, any invalid values will correctly trigger -EINVAL,
> making error detection more robust.
> 
> Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> ---
>   include/linux/avf/virtchnl.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
> index 4811b9a14604..cf0afa60e4a7 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
>   	 * 2 - from the second inner layer
>   	 * ....
>   	 **/
> -	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
> +	u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */

Why limit the length, and not use unsigned int?

>   	union {
>   		struct virtchnl_proto_hdr
>   			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
> @@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_filter_action);
>   
>   struct virtchnl_filter_action_set {
>   	/* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
> -	int count;
> +	u32 count;
>   	struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
>   };


Kind regards,

Paul

