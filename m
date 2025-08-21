Return-Path: <netdev+bounces-215760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F357B30254
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311083A75DE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A80311598;
	Thu, 21 Aug 2025 18:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFD277C8D;
	Thu, 21 Aug 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802325; cv=none; b=hVqLTz1N0WJiyvjBlVop/yO/sVVQ8zc/dTHdSfNwKKJR7bzgLd0QDMy+fsuKUfLYPQnAq0HrpKNeKTu8i5SyCTjX1BCCkShfxzWQ6t6/2vE/Dks5gclyMRavPUlIuhA3Mo/RQI0EC+NtJYLjtEUXxrjtkhYlimuoNLGOTVfGaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802325; c=relaxed/simple;
	bh=X6QcagUhfF69pliuFAqHEuOqwjnHLuM9ux9ZugDQwlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2WC6Y8jS1mr2wsvFzz1ANi0hex8kpaU7el83doMSjxnncnZW2IIF8BjW2UnS9yeN7nDozMfqldQoHam1DuALHFAN1i4kWNlUtjI+HwvEkKyS6fvDpHEMVryIjVZO6vAMKt0TSpt+Q6Od3LQjR75fwj/SO89nlHk18+Piex1rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af188.dynamic.kabel-deutschland.de [95.90.241.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F40061E647B3;
	Thu, 21 Aug 2025 20:51:05 +0200 (CEST)
Message-ID: <49c37b61-937d-449c-b7f1-27704a8a325e@molgen.mpg.de>
Date: Thu, 21 Aug 2025 20:51:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: fix set_local_name race condition
To: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, brian.gix@intel.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com
References: <20250821160747.1423191-1-pashpakovskii@salutedevices.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250821160747.1423191-1-pashpakovskii@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pavel,


Thank you for the patch. Some minor style comments below.

Am 21.08.25 um 18:07 schrieb Pavel Shpakovskiy:
> Function set_name_sync() uses hdev->dev_name field to send
> HCI_OP_WRITE_LOCAL_NAME command, but copying from data to
> hdev->dev_name is called after mgmt cmd was queued, so it
> is possible when function set_name_sync() will read old name

… is possible *that* function …?

> value.
> 
> This change adds name as a parameter for function
> hci_update_name_sync() to avoid race condition.

(Using 75 characters per line would save some lines.)

> Fixes: 6f6ff38a1e14 ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME")
> Signed-off-by: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
> ---
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

