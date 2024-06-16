Return-Path: <netdev+bounces-103841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB8D909CF9
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF551C2099C
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD82186E49;
	Sun, 16 Jun 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg3jRpHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B3225CB;
	Sun, 16 Jun 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718534243; cv=none; b=NR8WSBi3huvWEkmnzkC2d6eIotBV5yUiQG7BvS7IiNTwxq2b26FnRlUkFM7Ok5AGqdtyqRsaGsgjdZ9zd/GU6sX9CAtn4pTIEur6kWJ0CFYFMPVEvtjJufvMpPySO9XjK14oyQtUFQ2qZ+sOV0iH2kn/XlVP+21MBBBBVX54deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718534243; c=relaxed/simple;
	bh=ruStX8XwMczPkp2XSSF64ST0aUbVsnqvEzT7+JmVBf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8ZaQFTxcgfhxe+HWg2PrkLWSIhF1kGR8YfpI89R7eXDroU0ahtAR3rXeeN73vQgGj42LD2m/H+iXyh8IhbylU+e5e1jTwMthSQIVcTJ9Nrz9pb4umoC3101XXiaV9rkc1JS49Gl5m+lncW+SkHF4zdQVIhiizD6QYGtb9nRxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg3jRpHz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so34095421fa.2;
        Sun, 16 Jun 2024 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718534240; x=1719139040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnudTXKEVZpw3sPOJDR4teZ8YGThXnDgP8MT5PhMeyI=;
        b=fg3jRpHzlV3UuGM1G37l2WSRU51pz4gWP6fJiaaMehWg6flRUQ7avByGboXlMGNtkd
         WtmOrEvM7EGCgTKSXr46NEMDvNnTZxt45S2IdnaXxL9EDxfPddVEaamcoMvgPCCN5rrb
         W038gN8L4F4H0TsMBBE5NmAPHjdw4IZR3MstFODAervjqNN4fxYU1M6nw+T5Zry4mCZE
         iOfI2ApGI05h1TBxpNO7oARzKV+EW6QMJj56UQN9ZWWpVEBN/dx2V+JXGFWDfxszQXww
         pTiXgJFV0ZOgpSqSg8qOD6clDny37v1MnxiTJvo3kAWDMF41GfQ3ugjucjiYHx+85Wne
         MBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718534240; x=1719139040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnudTXKEVZpw3sPOJDR4teZ8YGThXnDgP8MT5PhMeyI=;
        b=n1v/NygyBiFeZ5L+aDI6abhqzJuZ5lYBfcyv5yrMwu4iquOK2G8I/vLfpG8towwIMr
         O/q7nscLUuPbPqpr7V5IDKogBjY8cdicDw8AOdIZicNg9PSMoESHWd57++5nSzrnB9M7
         lNHpG6VT5wCql7mZ9Iqh5dhPcOEGRlN7COJYcLj6q93+maMi55hS9qyveYXS67EUJTTp
         q2jNfcdKi46l4STT0Xv35sj+/OGixS7Le6V0sq/MjK99BMZZiD1r2e4OlTGd96PuXHoX
         QpOOLNwZsfmjqlqM2bf7/pQREXTLbhgUzaend6ojhMh4gwRDD4J7IjOyB7NkZAPW8XBe
         O0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQPY7OH/htClGj5Vley2fmIrCRFXDY+Bd14oobstOadVOCt1zfBnhs+mEB8Hs9FcvgjJqKim8mcP3VH+uAAIoPSO5RUGbGjSCO+yf/rKUizzJ4akc8vQaSD8o63efLAUOktnlCVijVUMSXR891E8q+BXNKpLa1QkGsbm5xa6SeomWrJtqP
X-Gm-Message-State: AOJu0YxE7tQmy4gPafol9mG75lhZ/iUhTEFhz2spOvMq+BphnHwX/zSa
	98wuF/7SoxKXonwdpaUl44G8RbgrkD8wG/p30d8dLZOIQrU7TN+G
X-Google-Smtp-Source: AGHT+IFV3jINcVjUAZCgb1fqaChMrO8isp5D53PoAkpq6Efqxgt70VyeOwYhbXbr4zF4cs5Q1OBbQQ==
X-Received: by 2002:a05:6512:1107:b0:52c:adc3:ea9f with SMTP id 2adb3069b0e04-52cadc3eadbmr4470035e87.0.1718534239963;
        Sun, 16 Jun 2024 03:37:19 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:9f8c:610c:ea5a:e832:8757? ([2a00:1370:8180:9f8c:610c:ea5a:e832:8757])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2871f87sm957896e87.123.2024.06.16.03.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 03:37:19 -0700 (PDT)
Message-ID: <fcdde042-6424-46a8-9fa6-e4f4021b0717@gmail.com>
Date: Sun, 16 Jun 2024 13:37:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bluetooth: handle value within the ida range should not
 be handled in BIG
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 william.xuanziyang@huawei.com
References: <000000000000bf4687061269eb1b@google.com>
 <tencent_880C74B1776566183DC9363096E037A64A09@qq.com>
Content-Language: en-US
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <tencent_880C74B1776566183DC9363096E037A64A09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/24 1:20 PM, 'Edward Adam Davis' via syzkaller-bugs wrote:
> hci_le_big_sync_established_evt is necessary to filter out cases where the handle
> value is belone to ida id range, otherwise ida will be erroneously released in
> hci_conn_cleanup.
> 
> Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
> Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---

There is one more user of  `hci_conn_add` which may pass too big handle 
which is `hci_le_cis_req_evt`.

I think, it should be resolved on API level as I tried to test here [0], 
but syzbot is feeling bad for some reason


[0] 
https://lore.kernel.org/all/31ac448d-2a21-4e93-8a00-5c7090970452@gmail.com/

>   net/bluetooth/hci_event.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a487f9df8145..4130d64d9a80 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6893,6 +6893,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>   
>   		bis = hci_conn_hash_lookup_handle(hdev, handle);
>   		if (!bis) {
> +                        if (handle > HCI_CONN_HANDLE_MAX)
> +                               continue;
> +
>   			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
>   					   HCI_ROLE_SLAVE, handle);
>   			if (IS_ERR(bis))


-- 
With regards,
Pavel Skripkin

