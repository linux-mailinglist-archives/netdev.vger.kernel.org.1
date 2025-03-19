Return-Path: <netdev+bounces-176094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA65A68BEC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81ADA7A31FA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3D25486F;
	Wed, 19 Mar 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cwBX/CPg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B120D4F6
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384416; cv=none; b=pHEGKNg1sFyL9xd78/7nFUXDlU+bUBxepukL6IBPSz1NyoOlGy8hrlDOAkHNqS8G+RoXrAxLYE5ZvVPceZtWoWF89tUwBbOOf0KxnUa6nANTUnPnijm9TnxLqqFaNfX5MStrI7QX6exknoJshMj0IF0wW1bcarfJrW1GjI7/p/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384416; c=relaxed/simple;
	bh=PllLzwtSjM+NYMQ6VGcBKLgkppbbydL3rKJ7HwL5b1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePac7A4kr2IUKmZtBgzuV0pX0gPFv/ja+GMI1QkNFSQ00qiXH9CSFos5Awh3d8HQSdjj7f/edqS09z4j8eO/FHe3Uptp5GL6IQ61E4bF8VWeoMLKiN6QJ83PMBDhlO+/82I3Nar564b6rE9XLulcbgXjHLma4PC6TXdFMe5wSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cwBX/CPg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso399144f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742384412; x=1742989212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9+K3/jtoYnr6zdEcuFmh576d/bFwVptRrWlTDg86vY=;
        b=cwBX/CPgyYhQbp8jDBApMq2tVftV2ovUyhfnRVeDn6+He5XrmA3Z3jb9OIiC3kOTjC
         fPu66t9jDWgEq1LxxJtww4lJzjDrM/tKbJEORRn90zs8AighLlwOfoHDO+Y2sHlj/vDH
         Ft6qEeZsMtZWZ/ZENeGrVHph3BMbR5a2lQAngizmz+suAYnrlUFIRJw5Ue9O4biSTUjk
         wK8oE6MRmsWnWTA48IhjrizYc0uGxS9Kl5Ri70f52l9UbpLoETerkPr8+Y7viEWOjj7F
         b4Y0PRQnEfxIlnNXIn4q3UsbZX2kLjo11478K/ABqOJk90p1zkC5KYwDJzOj6xXzY49v
         qn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384412; x=1742989212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9+K3/jtoYnr6zdEcuFmh576d/bFwVptRrWlTDg86vY=;
        b=Idm42Ikva4PeeXMofvFaW/adJZpUY6ylABg81gVPOyDVo4O7nM9lnQkClkezQ6djXf
         R1r3PBYIICWkaDeoC++bbDx+hTXic9CL54nCKQH+eLduN7pd5Ccp++mqNnYhJHqOh63U
         No7kUQdG3vbSlgzO43Sg3zJD4v8M6d5cd+AxF9FceE0F7NvVpNYKgmIPuS1WotMuThf6
         o2up/FNZhAgBkHK8jwoKGMf4aabPGyHZUx6ITxxn+ufTeqRY5vH9Ko29+Z30cyTstSFB
         gJ8kKF+qJhVOAS98UPi/Kkn5KJoMuZm4ThZZwFldBputkhXt8p0hL8Bejo41QR36X4/p
         1CjA==
X-Gm-Message-State: AOJu0Yz5rQ8Vd07Hpnjv/y+5Ej/fjNVj+f0LzQWWzq6eaxc+BRUGI308
	PL5Ckgr0wlcEBoHhfqS5egE/DaRAbvLsZYetWc1xZP5Rc8eZX5oOhMVq8ttk+rA=
X-Gm-Gg: ASbGnctrUTOExdUQLU8ThG8Hc5Q6H94KXVVbUGILSDkzxA+yEIYSqJZpcvf36yzJhh3
	iuResObTcoWprT/DyH4l9T+y7k7qCmlaYPmp9DZlUiMKiTeSrxZRswX3VxarvZRvwdIiMxwQ/2F
	cWp2yra+JtK81tMQ/wnIHoMUCYgNPXmOcvXvre7h+5/9NmoF2YlcZNmybFA9WGZJPC1MSF0x9n/
	U3572RSYdg53Q+FfuMOC8CikRsQX1iiNNer3AMGiiee6pZSzwvLLsow+UJP9UyF3Q7e1+luNHGG
	jYn1aERtuZQ8UvC/XMAzBKwoIv0hR86RblvNye9acYbgdakj0wKjrnJ9D42Jce5Hxzr7scGdCyC
	a
X-Google-Smtp-Source: AGHT+IHSIX58se5OeP4cS5idbed468sRUVkJ5Z+ZKjRzYnHbEFjtEt/5GsZ/c9id6VkImZ6Xmc72IQ==
X-Received: by 2002:a05:6000:400f:b0:391:23e6:f0ac with SMTP id ffacd0b85a97d-3996bb44c4fmr6150992f8f.11.1742384411905;
        Wed, 19 Mar 2025 04:40:11 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f855efsm16290535e9.34.2025.03.19.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:40:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:39:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 2/4] net/mlx5: Expose serial numbers in devlink
 info
Message-ID: <xtt6lkxht2ewaa7wncf2pq6rkgp7x5deoszfvh3hswrerqzfof@hvlgtcws6qx5>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-3-jiri@resnulli.us>
 <20250318173858.GS688833@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318173858.GS688833@kernel.org>

Tue, Mar 18, 2025 at 06:38:58PM +0100, horms@kernel.org wrote:
>On Tue, Mar 18, 2025 at 04:36:25PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Devlink info allows to expose serial number and board serial number
>> Get the values from PCI VPD and expose it.
>> 
>> $ devlink dev info
>> pci/0000:08:00.0:
>>   driver mlx5_core
>>   serial_number e4397f872caeed218000846daa7d2f49
>>   board.serial_number MT2314XZ00YA
>
>Hi Jiri,
>
>I'm sorry if this is is somehow obvious, but what is
>the difference between the serial number and board serial number
>(yes, I do see that they are different numbers :)

Quoting Documentation/networking/devlink/devlink-info.rst:

   * - ``serial_number``
     - Serial number of the device.

       This is usually the serial number of the ASIC, also often available
       in PCI config space of the device in the *Device Serial Number*
       capability.

       The serial number should be unique per physical device.
       Sometimes the serial number of the device is only 48 bits long (the
       length of the Ethernet MAC address), and since PCI DSN is 64 bits long
       devices pad or encode additional information into the serial number.
       One example is adding port ID or PCI interface ID in the extra two bytes.
       Drivers should make sure to strip or normalize any such padding
       or interface ID, and report only the part of the serial number
       which uniquely identifies the hardware. In other words serial number
       reported for two ports of the same device or on two hosts of
       a multi-host device should be identical.

   * - ``board.serial_number``
     - Board serial number of the device.

       This is usually the serial number of the board, often available in
       PCI *Vital Product Data*.


>
>>   versions:
>>       fixed:
>>         fw.psid MT_0000000894
>>       running:
>>         fw.version 28.41.1000
>>         fw 28.41.1000
>>       stored:
>>         fw.version 28.41.1000
>>         fw 28.41.1000
>> auxiliary/mlx5_core.eth.0:
>>   driver mlx5_core.eth
>> pci/0000:08:00.1:
>>   driver mlx5_core
>>   serial_number e4397f872caeed218000846daa7d2f49
>>   board.serial_number MT2314XZ00YA
>>   versions:
>>       fixed:
>>         fw.psid MT_0000000894
>>       running:
>>         fw.version 28.41.1000
>>         fw 28.41.1000
>>       stored:
>>         fw.version 28.41.1000
>>         fw 28.41.1000
>> auxiliary/mlx5_core.eth.1:
>>   driver mlx5_core.eth
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> ---
>>  .../net/ethernet/mellanox/mlx5/core/devlink.c | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> index 73cd74644378..be0ae26d1582 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> @@ -35,6 +35,51 @@ static u16 mlx5_fw_ver_subminor(u32 version)
>>  	return version & 0xffff;
>>  }
>>  
>> +static int mlx5_devlink_serial_numbers_put(struct mlx5_core_dev *dev,
>> +					   struct devlink_info_req *req,
>> +					   struct netlink_ext_ack *extack)
>> +{
>> +	struct pci_dev *pdev = dev->pdev;
>> +	unsigned int vpd_size, kw_len;
>> +	char *str, *end;
>> +	u8 *vpd_data;
>> +	int start;
>> +	int err;
>> +
>> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>> +	if (IS_ERR(vpd_data))
>> +		return 0;
>> +
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> +					     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> +	if (start >= 0) {
>> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +		if (!str) {
>> +			err = -ENOMEM;
>> +			goto end;
>> +		}
>> +		end = strchrnul(str, ' ');
>> +		*end = '\0';
>> +		err = devlink_info_board_serial_number_put(req, str);
>> +		kfree(str);
>> +	}
>> +
>> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
>> +	if (start >= 0) {
>> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>> +		if (!str) {
>> +			err = -ENOMEM;
>> +			goto end;
>> +		}
>> +		err = devlink_info_serial_number_put(req, str);
>> +		kfree(str);
>> +	}
>> +
>> +end:
>> +	kfree(vpd_data);
>> +	return err;
>
>Perhaps it can never happen, but Smatch flags that err may be used
>uninitialised here. I believe that can theoretically occur if
>neither of start condition above are met.

Will init.

>
>> +}
>> +
>
>...

