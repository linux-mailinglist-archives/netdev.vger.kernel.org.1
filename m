Return-Path: <netdev+bounces-241497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF0C848D3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15184E8C8F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D831327A;
	Tue, 25 Nov 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghL6TZui";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oHZjatak"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AB26ED46
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067616; cv=none; b=ucY0D+oN5AqnkYOxlIjqMgOcUe9Q8AiBUrZnyxSLLwREf5zh5TaTP3zTCCsrVlazch6XowIU3QY/2yTjTt3EKR683Ax6MljvjrR5mzyQyMhgZwkapIDJ8Xu+7vNbXmTzkcKbGNfFJGTOy7A75egeYBaIIvjx2jjNR5pCfsWt6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067616; c=relaxed/simple;
	bh=Ud7pIRA4Z7Jly5QQoFb0O3a9JDsvXMxAHCyvat1w0jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K64TtZJq4qghBHW22IjPMNgy66E3mOxx/p90BBnMgk/m6wAnAmLaniFfZHLgdxInvZkSno3LpVZF38muZ2Frym1bnuTtCeat8v7UDU73FWirV+pOZR58QtqEfz/rfz0m9DzWf80lxYI3YE++Ovoz52jULxB9AB70ko/fX+ShUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghL6TZui; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oHZjatak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764067613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYAYVMsEi+5ZQ8xw/QuX6lwcbwAan3VcdA5SJfLfCOE=;
	b=ghL6TZuivVoTNuDCLWiN+PfQCL3hHsDiZ2/hTRI9uDm5vq5+Bnej51ctDu0or2n/8R0OGf
	V/VuLhxiP15uAG8xI8tEN8cozt0GZ1EQCnspVQ8VQ9qVg7YUj5cPXLeRvS6Jf3jktPABGg
	iJj01/3u+99dm+N/mhNXzPRl0B6Uhv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-6X1SZ6_ZP-mFlz4B22nmRQ-1; Tue, 25 Nov 2025 05:46:51 -0500
X-MC-Unique: 6X1SZ6_ZP-mFlz4B22nmRQ-1
X-Mimecast-MFC-AGG-ID: 6X1SZ6_ZP-mFlz4B22nmRQ_1764067610
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779981523fso55197255e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764067610; x=1764672410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYAYVMsEi+5ZQ8xw/QuX6lwcbwAan3VcdA5SJfLfCOE=;
        b=oHZjatakuPeV9Qp6wNj7qNB1rm6l/8BHxa84ez2rXOUc2LDeUx9HDBdPNCKB4ybKIV
         bmBWs1Y2Y2O6+DAYYlDz/51mm9sRItFL7bXvGNWPPDci5WEu8XQVBt9LiqEzKwCkDut6
         Lmc3aK8sddHkX73etYNi8db2vBj4kYbU6p8DuWjQrLu7ehtOptml6GkCIhfCzFUb+DlM
         IBQdsUNcQaL0Pxg0mYVMh86+8PBoT9Sp4+6ozpTKxQXtEJOtIz9u9LnUJxeFKqYpYqLQ
         FFumIpWl3T8rc4Izdq77rVa3pmG/DSBmLuc++VXnrcficEbfmPoOHrQs41/seCQsh/ab
         SGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764067610; x=1764672410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYAYVMsEi+5ZQ8xw/QuX6lwcbwAan3VcdA5SJfLfCOE=;
        b=eEoJcJEy5+XhtM9R0jUMbOy9d4zuL0ijzHqdtkt842YrqxER3AABTpm3Odg6SdyTMg
         os0TZJ9SfJSMLR4NjDbVtFlyxqPpUv6QIpEeqAayCjOntIYunlEWj+3dxB7a8+fi98AV
         0RMcRLHz4tlKV5dgK+G1jcatRDEExu+OPsIBwajH+QSzC9PAAxNDbCsJAuOoTfiHRZme
         a2hdL00Plg1SgKLng+ybeQNdz5z4vCyusjrontI0dgI/1JaAChoTta/WaYZIkQR8YsP+
         fcejX3sEJg9AMhlAbFoWVay/UmKsNRKYaw7S90NlvkpzZwmjjCw9rKzhqr1CEMyIfUUm
         pj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPNRf+NZKcpduYbLZfLMx8nwfLB6Tm1ryA+7zrOvZXaNTFyC4XJXzberpDL/UM8DfKJ7FFFuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByyDKf+R5jlsjhPSfSnT9+6sOgqNgxt72KUulB58WxJOtJStD
	RkTnbN8JzzHyBNPKMYev49iSUxgchEbt+HFgbGev9+1wy5FQ5uaRyiSSXd0BDx9ORYQ4XTU0RP7
	J9RRv8POloGzFrSOd5uo8TPkIhysWmFwVg/WyvPIn2G1RpFbdGbVbSVS9SA==
X-Gm-Gg: ASbGncvfRvKarWqUVjWHp5wE3Vhqu60Eq1KitGFviUOKyDe9BuBRtx8woTUg1oihe+R
	WA09iOMPtkO68c5rFlbLdbVpljQj5Z8xuPUWD0emPc4YVod6wKZpDHwxWp2fYZn6uBHmqDdx310
	d6PDHjAhMnTTDrceBUzj47HqxeBRzWD+JzB7uoWJz75otCuJayVaCgf1EK69NO/u2U2egLpp6d/
	6yFbvqxpiyo7lz3WmSsbXBszxMvmvF9mrBQ8ESH6k88AnoeYIEWZyLeFGwB3NX2iUYh1WYxBF7J
	dthok1/kIpZrIrB+mdzmVTRlTvj0PLkwBP+cy2SUaoEkRF4lcE5JPvsnf1lzOMO8hDCtllwkrw0
	n0pkUT5EDjGtDnQ==
X-Received: by 2002:a05:600c:3ba4:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477c1123ae7mr218159455e9.24.1764067610095;
        Tue, 25 Nov 2025 02:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAJfWhKgd09T2car/i+8ldH3Cwh2rfeHteEUcaudCDaxCulu+WwtnB46ubUTkQ9KQ4y6UHUw==
X-Received: by 2002:a05:600c:3ba4:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477c1123ae7mr218158975e9.24.1764067609714;
        Tue, 25 Nov 2025 02:46:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8e54sm34315468f8f.40.2025.11.25.02.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 02:46:48 -0800 (PST)
Message-ID: <ea2ce128-537a-4718-aa70-d9192cfb94b8@redhat.com>
Date: Tue, 25 Nov 2025 11:46:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v07 8/9] hinic3: Add netdev notifier interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus Elfring <Markus.Elfring@web.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1763555878.git.zhuyikai1@h-partners.com>
 <ff986bcacacf77b6d86a241139eedee9fce4145c.1763555878.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ff986bcacacf77b6d86a241139eedee9fce4145c.1763555878.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 1:43 PM, Fan Gong wrote:
> Add netdev notifier interfaces.
> As we stipulate that netdevices with a vlan depth greater than 1
> should disable the offload feature, Layer 1 vlan netdevices use
> notifier to modify vlan_features.

As mentioned by Jakub in the previous revision, the net stack can send
packets with multiple stacked vlans. You need to implement
ndo_features_check(), check for the problematic packet layout there and
ev return a smaller features check excluding the relevant offloads.

> +static u16 hinic3_get_vlan_depth(struct net_device *netdev)
> +{
> +	u16 vlan_depth = 0;
> +
> +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
> +	while (is_vlan_dev(netdev)) {
> +		netdev = vlan_dev_priv(netdev)->real_dev;
> +		vlan_depth++;
> +	}
> +#endif
> +	return vlan_depth;

AFAICS the above can return any number >=
HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT ...

> +}
> +
> +static int hinic3_netdev_event(struct notifier_block *notifier,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(ndev);
> +	u16 vlan_depth;
> +
> +	if (!is_vlan_dev(ndev))
> +		return NOTIFY_DONE;
> +
> +	netdev_hold(ndev, &nic_dev->tracker, GFP_ATOMIC);
> +
> +	switch (event) {
> +	case NETDEV_REGISTER:
> +		vlan_depth = hinic3_get_vlan_depth(ndev);
> +		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT)

... so here you should use '>='> +			ndev->vlan_features &=
(~HINIC3_VLAN_CLEAR_OFFLOAD);
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	netdev_put(ndev, &nic_dev->tracker);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block hinic3_netdev_notifier = {
> +	.notifier_call = hinic3_netdev_event,
> +};
> +
>  static void init_intr_coal_param(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -309,6 +364,36 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
>  	return 0;
>  }
>  
> +static void hinic3_register_notifier(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int err;
> +
> +	mutex_lock(&hinic3_netdev_notifiers_mutex);
> +	hinic3_netdev_notifiers_ref_cnt++;
> +	if (hinic3_netdev_notifiers_ref_cnt == 1) {

Why do you need this notifier accounting? Instead you should be able to
call hinic3_register_notifier() only once.

/P


