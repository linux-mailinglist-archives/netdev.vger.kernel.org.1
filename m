Return-Path: <netdev+bounces-189734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602ECAB362B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B4017BC36
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C125A32E;
	Mon, 12 May 2025 11:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBE1DD0EF
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050413; cv=none; b=WEk8FFaI/JD1TDbUPWUPzVLC5BZ/26mfv/B515oOfPva0QA6awvQ+fuD4KLDRj+9bmVFuHWHI5IwNIyHCQemgkekX2juaiOpf3yMNzIZcO+YmGE/LKtmOVH7L+N8OxELeb/Xo9n6W3P5FQcTMGI+IHy722/DQm6ITOYKKWNnwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050413; c=relaxed/simple;
	bh=sxe+D6WPZla4nTFWkqVGfEE6SdYt5eJKh51Gz0YFsV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5nq8ouFk6k/sNiz531cA4VH/6sstHrKC5TpPScff+YKfUpFZ4RpkoLTet8NEGpZWnBaOQhmiIRPCCxq1qnmwCyKjICDJnkR/Z5BEdwpvjqPbPcM/GPrf+nkXMHpSDZwepQRyWGSwnW0mlVWAvgeDOcPc6wR5JZJOfgsbsnwolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C12C61EA1BF9;
	Mon, 12 May 2025 13:46:08 +0200 (CEST)
Message-ID: <b5678313-0ec0-444f-962f-758a35c5a46d@molgen.mpg.de>
Date: Mon, 12 May 2025 13:46:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid mailbox timeout
 delays during reset
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, madhu.chittim@intel.com, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, joshua.a.hay@intel.com,
 ahmed.zaki@intel.com
References: <20250508184715.7631-1-emil.s.tantilov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250508184715.7631-1-emil.s.tantilov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Emil,


Thank you for the patch.

Am 08.05.25 um 20:47 schrieb Emil Tantilov:
> Mailbox operations are not possible while the driver is in reset.
> Operations that require MBX exchange with the control plane will result
> in long delays if executed while a reset is in progress:
> 
> ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset
> idpf 0000:83:00.0: HW reset detected
> idpf 0000:83:00.0: Device HW Reset initiated
> idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00 vc_op:504 salt:be timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0 timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:510 cookie:c100 vc_op:510 salt:c1 timeout:2000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2 timeout:60000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c300 vc_op:509 salt:c3 timeout:60000ms)
> idpf 0000:83:00.0: Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4 timeout:60000ms)
> idpf 0000:83:00.0: Failed to configure queues for vport 0, -62
> 
> Disable mailbox communication in case of a reset, unless it's done during
> a driver load, where the virtchnl operations are needed to configure the
> device.

Is the Linux kernel going to log something now, that the mailbox 
operation is ignored?

> Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_lib.c     | 18 +++++++++++++-----
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h    |  1 +
>   3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 3a033ce19cda..2ed801398971 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1816,11 +1816,19 @@ void idpf_vc_event_task(struct work_struct *work)
>   	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
>   		return;
>   
> -	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags) ||
> -	    test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
> -		set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> -		idpf_init_hard_reset(adapter);
> -	}
> +	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
> +		goto func_reset;
> +
> +	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
> +		goto drv_load;
> +
> +	return;
> +
> +func_reset:
> +	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
> +drv_load:
> +	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> +	idpf_init_hard_reset(adapter);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 3d2413b8684f..5d2ca007f682 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -376,7 +376,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
>    * All waiting threads will be woken-up and their transaction aborted. Further
>    * operations on that object will fail.
>    */
> -static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
> +void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
>   {
>   	int i;
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 83da5d8da56b..23271cf0a216 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -66,5 +66,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
>   int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
>   int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
>   int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
> +void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
>   
>   #endif /* _IDPF_VIRTCHNL_H_ */


Kind regards,

Paul

