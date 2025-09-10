Return-Path: <netdev+bounces-221639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EBB51527
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B44453EA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB43191BF;
	Wed, 10 Sep 2025 11:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EB31D37D;
	Wed, 10 Sep 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502746; cv=none; b=YrX/HXrPpIZ62iAhgyuPoklXzNPWwhUS5fql6N2cenlx5QiS3w3sjic7iO4tqrRW6/R3XpExLIoq22E9jDN/K9e1hDZetknVgz196gh37SFfpxE/UFNAWOw06dzL4ZCLNrRBXOuNDBS94Wj7DeOpy7/hCMNx9GQjvcok5Oyz7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502746; c=relaxed/simple;
	bh=PKr2I9o/Z0nYzv3hFWpk9gwnN/cFKToG0e7J+kAIrtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8reEHPhl3b9K1F3ewsngskuaBdEYTjbEVa6zX1k5yEHYSifX1mXDw/+2Rrhb0JiG3gEe6t1/fM3dTeW/WD06keUqc9RGh5LX1/16+mX9dFbuExNxUNXocL86EVs0h2FkyxHImIMf6DpBrvLR7awZfpRDKPKoIsLQaNVqIPVBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p5dc55aad.dip0.t-ipconnect.de [93.197.90.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 988B260213CBB;
	Wed, 10 Sep 2025 13:11:53 +0200 (CEST)
Message-ID: <bbf020fc-4567-4c12-8400-5077ae2a7718@molgen.mpg.de>
Date: Wed, 10 Sep 2025 13:11:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aMAZ7wIeT1sDZ4_V@kspp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aMAZ7wIeT1sDZ4_V@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Gustavo,


Thank you for your patch.

Am 09.09.25 um 14:13 schrieb Gustavo A. R. Silva:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the __struct_group() helper to fix 31 instances of the following
> type of warnings:
> 
> 30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

You could add an explanation, why the macro `__struct_group()` defined 
in `include/uapi/linux/stddef.h` fixes this, and why it is preferred 
over `TRAILING_OVERLAP()`. Also, the two underscores would suggest to 
me, it’s some kind of internal implementation.

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Use __struct_group() instead of TRAILING_OVERLAP().
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/aLSCu8U62Hve7Dau@kspp/
> 
>   include/net/bluetooth/mgmt.h | 9 +++++++--
>   net/bluetooth/mgmt_config.c  | 4 ++--
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 3575cd16049a..74edea06985b 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -53,10 +53,15 @@ struct mgmt_hdr {
>   } __packed;
>   
>   struct mgmt_tlv {
> -	__le16 type;
> -	__u8   length;
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(mgmt_tlv_hdr, __hdr, __packed,
> +		__le16 type;
> +		__u8   length;
> +	);
>   	__u8   value[];
>   } __packed;
> +static_assert(offsetof(struct mgmt_tlv, value) == sizeof(struct mgmt_tlv_hdr),
> +	      "struct member likely outside of __struct_group()");
>   
>   struct mgmt_addr_info {
>   	bdaddr_t	bdaddr;
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 6ef701c27da4..c4063d200c0a 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -13,13 +13,13 @@
>   
>   #define HDEV_PARAM_U16(_param_name_) \
>   	struct {\
> -		struct mgmt_tlv entry; \
> +		struct mgmt_tlv_hdr entry; \
>   		__le16 value; \
>   	} __packed _param_name_
>   
>   #define HDEV_PARAM_U8(_param_name_) \
>   	struct {\
> -		struct mgmt_tlv entry; \
> +		struct mgmt_tlv_hdr entry; \
>   		__u8 value; \
>   	} __packed _param_name_
>   


Kind regards,

Paul

