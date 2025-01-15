Return-Path: <netdev+bounces-158354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C248A1177D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C347A3106
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39C1465BE;
	Wed, 15 Jan 2025 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNVmokXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0022DF8F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909478; cv=none; b=eYACVCCN4ixF51dbGaKcp5UDZCHzdVgwyh0LK7umBimeZy2AqK0kAH20cUD2ijWQr96b7jfJd6JyI4F6F3P6Ox0YLkWcl44651SVzL72b6Wc1FeAzT/c/FCTnDB2FpIKPOWUegAe5NSMq1X/hetVIZQKCwGGu39piKFT66oZ/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909478; c=relaxed/simple;
	bh=Ol1foyh0v+J/5oTdMoykClI9Rf1Br3w7yVmhBxRK+sU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jdTNPcCg6wU1Rw/SfuHEvaaDG2VNsNkz1CGJyiw8c/hd6SyY6MwlqBPAXc0+K6uQrb9D0eKaOhIOUo6qMbjuUBN3TpVPGBWUklAOR37V2Qwb00R4jd65qek4z9OAE56AOtKCh73lFuiVxWBScmUcrbFo9EwbLC6RWfXacHYvir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNVmokXp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43621d27adeso42908505e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 18:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736909474; x=1737514274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97jHUU/zDxIQl5qdvo3rd8r3MNE7feZ3PfjTB4KTijE=;
        b=FNVmokXpBA3PT1GbBh7lWpe+i6PrNK2AxDhAFgV8Q5d6xIiCiWxb9ccnuKDc5vzDGx
         SCqyVEslGVNmhYFA5DEVPB+2D7wrpK8HpI8zJNGtngUSjb42gwxqHIhJbOcfhSZgiBCo
         HhRF3ER2ynRWlOceVYO0u7gscfEqXDu9R479l6gpKMeexPqL9j80/LozvN5Z3Oa7s5pH
         H6Tq1oyFJvm+YkInvt+Gm6+GOPg98fmLRM5yr4Cd5o7gzCoMe2CpX1ZG7YR6ybeja94I
         QAsWovl1VkVVobE2PqIIC38VMTJ6aTvrvQ0J3UB6GyWsR10pkrV8NLXvzHY2C/DYnSro
         cCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736909474; x=1737514274;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97jHUU/zDxIQl5qdvo3rd8r3MNE7feZ3PfjTB4KTijE=;
        b=i3tz2Ua4T0KcpD7YSc4KSVDzISJoURE+M81PeQEU8w+A+eGk9nfT5McszJIRi3b7gN
         dahyYMt3AMtSH9n2Hnt31k3z4A6whkhOrz++sucVPfOi2oGiW21qnhFN9WVHKNV/B73c
         4ZCzsoSzz/nPqTUsdwUgioAUW6ORT6zHL0jqI4SpLoW3vMF7eGyJ+Ia0/JueWOhWtysz
         19KEX/Ct3JJ+IjEDwHlSKnghaUjD4LTWHhxnRiIpTkGTKrWFMAuqPEwnDY5n/cSX8Ngm
         Se+75oVODmNejL9lrlx2DLsPVW12YFyFwXaRIqp+Y8iIn75VVc0TZ9wqHxt0dX1m461W
         TwJA==
X-Forwarded-Encrypted: i=1; AJvYcCUpMQGXT7siZKu+n2GDQiyc3C+lC/zMdrBdigHxIa8ZawLrPKz2eCaGDwkxSBe0W7o9JGWDvtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk0UL5J6NAAlCR5I+fVjuYmGEm8+lTe+i6DloxMFUlmxfE7Jc
	7mvhSikEaUeothNmwOYpW8tJO+ewfKXw+4zQrDYvq8BsrSY+Ct9b5NRiqw==
X-Gm-Gg: ASbGncschSiRC+2WeL+mt/TkgddsrS3c5KgfFfDrO3bcDD6Vy1buOSC9lS+xyNIGpKz
	oU1xHDCqx1WOSuugRxWkZ0CWCh2rKhnur+q/oSCSy/Qdurnk6szoEWiPInOyiwb8P+Tzfd9B7HE
	/hg/yrTNKFtWoLi/oLtWNbsTYFeJMSR4qoLiu7XzkTmwov78GMbmFRLidbNsfQB1whW9H8fc6Of
	hBWNpusMl+S1GjXbncMHbj+3opYz+5Ld1A5GXb3Isp+y7Mcj7PFXu4VyQglR12b9nHuwJxGeZXb
	vfJW9rYsvqUIT5D8SuNWCAPydT9tYUElHVZ1RylAPxSV
X-Google-Smtp-Source: AGHT+IFzWMQ4xPPxDUyyDouZPHa9Vc4zJh/mL0EaxCe51iBMJJUz4R9wg04YBWfSPKYEFB+ZkZ3sUA==
X-Received: by 2002:a05:600c:5750:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-436e3ea445dmr266356435e9.30.1736909474253;
        Tue, 14 Jan 2025 18:51:14 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d2f5sm16501529f8f.17.2025.01.14.18.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 18:51:13 -0800 (PST)
Subject: Re: [PATCH net] net: avoid race between device unregistration and
 set_channels
To: Jakub Kicinski <kuba@kernel.org>, Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
References: <20250113161842.134350-1-atenart@kernel.org>
 <20250114112401.545a70f7@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f87576e0-93d2-42fe-a6da-09430386bc16@gmail.com>
Date: Wed, 15 Jan 2025 02:51:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250114112401.545a70f7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 14/01/2025 19:24, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 17:18:40 +0100 Antoine Tenart wrote:
>> This is because unregister_netdevice_many_notify might run before
>> set_channels (both are under rtnl). 
> 
> But that is very bad, not at all sane. The set call should not proceed
> once dismantle begins.
> 
> How about this?
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c index 849c98e637c6..913c8e329a06 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
>                 pm_runtime_get_sync(dev->dev.parent);
>  
>         if (!netif_device_present(dev) ||
> -           dev->reg_state == NETREG_UNREGISTERING) {
> +           dev->reg_state > NETREG_REGISTERED) {
>                 ret = -ENODEV;
>                 goto err;
>         }
> 

Would __dev_ethtool() need a similar check?

