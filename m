Return-Path: <netdev+bounces-216001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90720B3155F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EDB3B866D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE0263F22;
	Fri, 22 Aug 2025 10:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E462D027F;
	Fri, 22 Aug 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858188; cv=none; b=Lu3M98ANwD3qvzfxlSXRUuyom1bxsf64JU4FyO7LEc6upwO4rY/6e72RhqyW4D2Z6O8P8Vh8x2VRIdwrEPTZBu6ri09969eS5j2h7IbdHOjd2xT8jx+9N41emZp3geJk7ZV0mg6K9hGmiZQ5/fJ59kdWt/brUxdokH8x3V8RVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858188; c=relaxed/simple;
	bh=8FUQrWvDjTxYnIZCT7TvAH+8CqzkKfBOd7VLTbkkB5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyMz5xkmPxJfxEFfBCLUmbdct2uX53v5gQON7H60Lnm1RkiMHSGhW0jrOX+q7AIlKJfMNIl0B2nni5kM+wFIMT8CwjT3HGHFb+xAPeZsCBoDe4GnmIo1e5mNrS9nUlnWo/fIcHBCo61DNBH8FnQO0o0rCTzuDAoB3xwh7qrYAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A775860288278;
	Fri, 22 Aug 2025 12:22:23 +0200 (CEST)
Message-ID: <0c85712e-0a94-434b-998e-5713e6ec491b@molgen.mpg.de>
Date: Fri, 22 Aug 2025 12:22:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: fix set_local_name race condition
To: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com
References: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: remove bouncing brian.gix@intel.com]

Dear Pavel,


Thank you for the improved version.

Am 22.08.25 um 11:20 schrieb Pavel Shpakovskiy:
> Function set_name_sync() uses hdev->dev_name field to send
> HCI_OP_WRITE_LOCAL_NAME command, but copying from data to hdev->dev_name
> is called after mgmt cmd was queued, so it is possible that function
> set_name_sync() will read old name value.
> 
> This change adds name as a parameter for function hci_update_name_sync()
> to avoid race condition.
> 
> Fixes: 6f6ff38a1e14 ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME")
> Signed-off-by: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
> ---
>   Changelog v1->v2:
>   * Fix some minor style comments for commit messsage.
> 
>   include/net/bluetooth/hci_sync.h | 2 +-
>   net/bluetooth/hci_sync.c         | 6 +++---
>   net/bluetooth/mgmt.c             | 5 ++++-
>   3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
> index 72558c826aa1b..eef12830eaec9 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -93,7 +93,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
>   
>   int hci_update_eir_sync(struct hci_dev *hdev);
>   int hci_update_class_sync(struct hci_dev *hdev);
> -int hci_update_name_sync(struct hci_dev *hdev);
> +int hci_update_name_sync(struct hci_dev *hdev, const u8 *name);
>   int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode);
>   
>   int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e56b1cbedab90..c2a6469e81cdf 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3412,13 +3412,13 @@ int hci_update_scan_sync(struct hci_dev *hdev)
>   	return hci_write_scan_enable_sync(hdev, scan);
>   }
>   
> -int hci_update_name_sync(struct hci_dev *hdev)
> +int hci_update_name_sync(struct hci_dev *hdev, const u8 *name)
>   {
>   	struct hci_cp_write_local_name cp;
>   
>   	memset(&cp, 0, sizeof(cp));
>   
> -	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
> +	memcpy(cp.name, name, sizeof(cp.name));
>   
>   	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_LOCAL_NAME,
>   					    sizeof(cp), &cp,
> @@ -3471,7 +3471,7 @@ int hci_powered_update_sync(struct hci_dev *hdev)
>   			hci_write_fast_connectable_sync(hdev, false);
>   		hci_update_scan_sync(hdev);
>   		hci_update_class_sync(hdev);
> -		hci_update_name_sync(hdev);
> +		hci_update_name_sync(hdev, hdev->dev_name);
>   		hci_update_eir_sync(hdev);
>   	}
>   
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 46b22708dfbd2..da662e1823ae5 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3876,8 +3876,11 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
>   
>   static int set_name_sync(struct hci_dev *hdev, void *data)
>   {
> +	struct mgmt_pending_cmd *cmd = data;
> +	struct mgmt_cp_set_local_name *cp = cmd->param;
> +
>   	if (lmp_bredr_capable(hdev)) {
> -		hci_update_name_sync(hdev);
> +		hci_update_name_sync(hdev, cp->name);
>   		hci_update_eir_sync(hdev);
>   	}
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

