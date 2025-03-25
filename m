Return-Path: <netdev+bounces-177275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2570A6E83E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 03:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A3918823E7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 02:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE3156C79;
	Tue, 25 Mar 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXtpaM6z"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BD13632B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868279; cv=none; b=FDPJPXRlSOZKryNMNNRVug/iHiH+XP3EVhiBKLHNXmbodtZtCqzNIo/qwrIXuMTTRn0vKf0Fon80NcD+PeBg7iyrI3Ogo9FAzR9txls7xupfjlFpZnL87nr+rKm+iSgkTNkHI0rdC27VZmM2sidbAzSGzMWkjDkvBWbRaLcpdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868279; c=relaxed/simple;
	bh=8BWzNVWYLGh4d9zmOLVT+xWgCO3/+GX4W3aOPDaI/1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROdUxoCq0Ob5vIecGrZS0SaCO/qiH2utZfrM4kRaDBNQpTZUbCxfASSu8Pvcmuf8PGrEIcusjj49yw2Ab+hCKhPreRryROtRSHJSgl9MNaD+TaPdcK5sUqUjquWBfrlmxDdN8IH3CYlY/G7sJXfsGAr1xpUZdXvNTCb7fTVA/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HXtpaM6z; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e368ba8-f306-449c-b05a-0c5bd9258190@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742868274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEt2p5iUZP8HLfRK3m+jUCk7CG3FI3QMG6/eweTSjuM=;
	b=HXtpaM6zR1S3KqOvN6kp4ybgvP/HfmBdPEbXVC0jN8nCPeyf7YID9M6sJOPPd0oumaJY1X
	d/orciLRWF594ZC3I6qPBNvPGgcdmFTrtepjFpe6pQTOHwPXcwZfvVK3AM8u5EGxFN4U9w
	6r78ssGVcah+82G4H0li7Zt1uOBlJuA=
Date: Tue, 25 Mar 2025 10:03:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
References: <20250321095200.1501370-1-xuanqiang.luo@linux.dev>
 <61e8fbbd-83d3-4838-9138-1ed6dfbb4b61@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <61e8fbbd-83d3-4838-9138-1ed6dfbb4b61@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/24 18:54, Przemek Kitszel 写道:
> On 3/21/25 10:52, luoxuanqiang wrote:
>> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
>>
>> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
>> pointer values"), we need to perform a null pointer check on the return
>> value of ice_get_vf_vsi() before using it.
>>
>> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR 
>> filters")
>> Signed-off-by: luoxuanqiang <xuanqiang.luo@linux.dev>
>
> Thank you for your patch, it looks good.
> To apply it you have to provide us your name in the format:
> Firstname Surname
> (or similar, could include more than 2 words)
>
> please also CC IWL mailing list (CC'd by me) to have faster feedback :)
> would be best if you put [PATCH iwl-net v2] in the subject
>
Thank you for your detailed suggestions. I've already sent out the v2. :)
>> ---
>>   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c 
>> b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..53bad68e3f38 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 
>> *msg)
>>       dev = ice_pf_to_dev(pf);
>>       vf_vsi = ice_get_vf_vsi(vf);
>>   +    if (!vf_vsi) {
>> +        dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
>> +        v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +        goto err_exit;
>> +    }
>> +
>>   #define ICE_VF_MAX_FDIR_FILTERS    128
>>       if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>>           vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
>

