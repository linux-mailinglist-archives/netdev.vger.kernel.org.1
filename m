Return-Path: <netdev+bounces-122872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3794962EDC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E491C20BA8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A919D8A4;
	Wed, 28 Aug 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ZWhLZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F351514EE
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867352; cv=none; b=XP60Qs6pevY93UD4lTYprTvk0BVOBpf4zB7RXW5qgUjGTnqpGXZu8+PF3ZcCRNL0lTCWDFwXXmZZ/H2NdL2gQJTja0igpqKtqDfW3YPPGonb3uqcGJ/XC+OCjFJxbVO0Frbx7pdL8mpaH7GeT36j5rNnrNRk1lkOcUcPLp6Q93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867352; c=relaxed/simple;
	bh=pDv9mbEE2MFkuShcDIECvQYDq6l+CbGkgJP4De1nnC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmdnXhxrvTPy7vLrIhfYtAB1BJERXmcjvMEya8qr1lZUj5wu2YCCN3YIIT62/HtSj+Uzk+gqRZqQuMm+nltqdlKGgeW0CANHUP5H6jyj80XPbtdaEhlf+XutdlyF+hUK9TONfOxDDSmlhNc6gUeg09IJwMADV2BojWz1FCAh1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6ZWhLZF; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f23f22so4952114eaf.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724867349; x=1725472149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obKf1CGrn6imkfaTxaIr9r8JF1aWiUq2+9MARfSUV0Y=;
        b=E6ZWhLZFR8qfLvoCsOT+vJRsoYwhG9Ji8p9LmRFi5QuF2tFaYYK32J7cEDF7TZA87i
         +DemR2D7jcZxckpy9iH46vundNpyCC4Vz0/RdUFngkUyFgp5RztTeZwxXOXdJ0SpPK2f
         A9xJ1EvrKzFXGC97gsJMfR6Y3BjDA/S8uYXzzkHtd5te4qwF9P5rTtILvPajiOD5whit
         uIcmSBUUO2DERGOmMPFjrpxrSzqeEe/yYVWJ83GZaJa3iSaNCORJ8CMW89sJrnoFyGtc
         TmywjkZRaVzgXSIa+Eae3jfq4LiTFNn/bg+U6K2kBvy+CPPOhgfbWI3slWUmfhbAp1Nl
         3Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867349; x=1725472149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obKf1CGrn6imkfaTxaIr9r8JF1aWiUq2+9MARfSUV0Y=;
        b=qOBpNzBU74KiabOsy2XbzWRzUI+tDdVuGvrgBotf/cgsWGlz9e3wL4skbKUGyjcZ8U
         dMb7h/Xw1+YfYGape1UoToE/oTVl6u+sJjPIEC+IyRm0f7ogQLTyoZ55Ou+u1OOYgq1F
         HCEY4Ehm7/xERxQfq6hau3xdORO2i2OIfOee6NlZAIw4QTybKd29BlRU9ngvJ9zhbu7t
         fwIloiNAacStL4u0c4RUscVNTS5Svp84ZaM5LLB2WCIHAgjROMxqBozalquQ4wSak1wZ
         cIFtp0yslN/maaqxkQybD8uETXp5PEPKWF5S/5idKLaDlA2xaSolehbqmOkw3+nBqy+d
         FFcQ==
X-Gm-Message-State: AOJu0YxSg3fux4zc2DlFKL40t8afBr2lSfQLj3vVKq/cMEXL8OecVNHP
	+9ukO4ljIYDEnbA/28YcaFDk9d1+ChPMPGHISwLTbI3nl9teM+KY
X-Google-Smtp-Source: AGHT+IGU3sHZH8l1W/JxDkybxqw89o2qsWkT4xWRHUSuwgDtgN3Jo9oESf76Xwl9ZCZ5PoSSj1b/EA==
X-Received: by 2002:a05:6358:7e87:b0:1ac:9bc7:2da5 with SMTP id e5c5f4694b2df-1b603cce624mr63546355d.27.1724867348711;
        Wed, 28 Aug 2024 10:49:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:1c59:4088:26ff:3c78? ([2620:10d:c090:500::5:6cee])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad7dbe4sm11167595a12.91.2024.08.28.10.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:49:08 -0700 (PDT)
Message-ID: <34c52e04-00aa-4507-9150-0230ce760c9a@gmail.com>
Date: Wed, 28 Aug 2024 10:49:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: Add ethtool support for fbnic
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-2-mohsin.bashr@gmail.com>
 <Zs7D5hij6gQOiEGc@mev-dev.igk.intel.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <Zs7D5hij6gQOiEGc@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 11:29 PM, Michal Swiatkowski wrote:
> On Tue, Aug 27, 2024 at 01:59:03PM -0700, Mohsin Bashir wrote:
>> Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
>> provides firmware version information while the driver name and bus
>> information is provided by ethtool_get_drvinfo().
>>
>> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
>> ---
>> v2:
>> - Update the emptiness check for firmware version commit string
>> - Rebase to the latest
>>
>> v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com
> Correct link:
> https://lore.kernel.org/netdev/20240822184944.3882360-1-mohsin.bashr@gmail.com/
Thank you for pointing this out.
>
>> ---
>>   drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +++
>>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 26 +++++++++++++++++++
>>   drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++++++++
>>   drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 ++---
>>   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 ++
>>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
>>   7 files changed, 49 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>
>> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
>> index 9373b558fdc9..37cfc34a5118 100644
>> --- a/drivers/net/ethernet/meta/fbnic/Makefile
>> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
>> @@ -8,6 +8,7 @@
>>   obj-$(CONFIG_FBNIC) += fbnic.o
>>   
>>   fbnic-y := fbnic_devlink.o \
>> +	   fbnic_ethtool.o \
>>   	   fbnic_fw.o \
>>   	   fbnic_irq.o \
>>   	   fbnic_mac.o \
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
>> index ad2689bfd6cb..28d970f81bfc 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
>> @@ -132,6 +132,9 @@ void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
>>   void fbnic_free_irqs(struct fbnic_dev *fbd);
>>   int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>>   
>> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
>> +				 const size_t str_sz);
>> +
>>   enum fbnic_boards {
>>   	fbnic_board_asic
>>   };
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> new file mode 100644
>> index 000000000000..7064dfc9f5b0
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -0,0 +1,26 @@
>> +#include <linux/ethtool.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/pci.h>
>> +
>> +#include "fbnic.h"
>> +#include "fbnic_netdev.h"
>> +#include "fbnic_tlv.h"
>> +
>> +static void
>> +fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>> +{
>> +	struct fbnic_net *fbn = netdev_priv(netdev);
>> +	struct fbnic_dev *fbd = fbn->fbd;
>> +
>> +	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
>> +				    sizeof(drvinfo->fw_version));
>> +}
>> +
>> +static const struct ethtool_ops fbnic_ethtool_ops = {
>> +	.get_drvinfo		= fbnic_get_drvinfo,
>> +};
>> +
>> +void fbnic_set_ethtool_ops(struct net_device *dev)
>> +{
>> +	dev->ethtool_ops = &fbnic_ethtool_ops;
>> +}
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
>> index 0c6e1b4c119b..8f7a2a19ddf8 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
>> @@ -789,3 +789,16 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
>>   		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
>>   	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
>>   }
>> +
>> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
>> +				 const size_t str_sz)
> Don't you need a prototype for this function?
We do have the prototype in fbnic.h
>> +{
>> +	struct fbnic_fw_ver *mgmt = &fbd->fw_cap.running.mgmt;
>> +	const char *delim = "";
>> +
>> +	if (mgmt->commit[0])
>> +		delim = "_";
>> +
>> +	fbnic_mk_full_fw_ver_str(mgmt->version, delim, mgmt->commit,
>> +				 fw_version, str_sz);
>> +}
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
>> index c65bca613665..221faf8c6756 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
>> @@ -53,10 +53,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
>>   int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
>>   void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
>>   
>> -#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
>> +#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
>>   do {									\
>>   	const u32 __rev_id = _rev_id;					\
>> -	snprintf(_str, sizeof(_str), "%02lu.%02lu.%02lu-%03lu%s%s",	\
>> +	snprintf(_str, _str_sz, "%02lu.%02lu.%02lu-%03lu%s%s",	\
>>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MAJOR, __rev_id),	\
>>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MINOR, __rev_id),	\
>>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_PATCH, __rev_id),	\
>> @@ -65,7 +65,7 @@ do {									\
>>   } while (0)
>>   
>>   #define fbnic_mk_fw_ver_str(_rev_id, _str) \
>> -	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str)
>> +	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))
>>   
>>   #define FW_HEARTBEAT_PERIOD		(10 * HZ)
>>   
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
>> index 571374361259..a400616a24d4 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
>> @@ -521,6 +521,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>>   	netdev->netdev_ops = &fbnic_netdev_ops;
>>   	netdev->stat_ops = &fbnic_stat_ops;
>>   
>> +	fbnic_set_ethtool_ops(netdev);
>> +
>>   	fbn = netdev_priv(netdev);
>>   
>>   	fbn->netdev = netdev;
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
>> index 60199e634468..6c27da09a612 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
>> @@ -58,6 +58,7 @@ int fbnic_netdev_register(struct net_device *netdev);
>>   void fbnic_netdev_unregister(struct net_device *netdev);
>>   void fbnic_reset_queues(struct fbnic_net *fbn,
>>   			unsigned int tx, unsigned int rx);
>> +void fbnic_set_ethtool_ops(struct net_device *dev);
> Isn't it cleaner to have it in sth like fbnic_ethtool.h file? Probably
> you will have more functions there in the future.
>
> Thanks,
> Michal
It would definitely be cleaner if have a large number of functions which 
isn't the case hence, did not add fbnic_ethtool.h
>
>>   
>>   void __fbnic_set_rx_mode(struct net_device *netdev);
>>   void fbnic_clear_rx_mode(struct net_device *netdev);
>> -- 
>> 2.43.5
>>

