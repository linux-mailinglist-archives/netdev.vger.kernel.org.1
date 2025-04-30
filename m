Return-Path: <netdev+bounces-187001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF92AA46F1
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6853E3B14DD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABA231840;
	Wed, 30 Apr 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoiEfcyx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE4171D2
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005123; cv=none; b=IP/SyQrQDA5lQR00vDw/r7BGs4Yd7GkiMKhhdrT2DlP/ZWnnpNmzJjQFbGvd8olE8uo0g6jbEWqRFYIKmyChYL5E6C2PECQ1uHYiTVFH5YZ2B0h5IO1lK18g5J9VasHdUkGVReQ+7xQCHPOU6uuduyR7GF1hlHX3C6Fh3OGZNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005123; c=relaxed/simple;
	bh=L/S/cstdhaw0q/9+lapFQUBWguY35JuC/j0+aEzJZXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZtErnEsg3YJsJb1qUgr5LHwPsa+7RoXBIX3zBZfqVoFwg99sPvPGpsOUyNti/8FSHCg+S18xLP70rWbLNxnBlw+fF1JesvMaH2+eF2rLvA6TB8HZEaH7eexiWq2OKmFHazG9npyTZm6moIEAlIMPsEproBBPMCWu03EjbVYrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoiEfcyx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+volEyBef2ye7NUghL7e/PLx9YGoFozJlvYKJwtiFcg=;
	b=AoiEfcyxZprVaLTx4JiGm8IEKc8ccVShEHSTZzomUFTHhCSgBGzJ3bt7yNDlfRgBJxILri
	L+PVPKETlnIdyKu6pqL28YDHzF8pliP5SJcSTLXJiRARbZ9BeDdTw1V7khloxXoUKXq2lr
	zYdr5s4AnjqtaNU8WaL7yg8uJG8Fvbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Z5mF4TYpPjOcm2gJr7Qjjg-1; Wed,
 30 Apr 2025 05:25:14 -0400
X-MC-Unique: Z5mF4TYpPjOcm2gJr7Qjjg-1
X-Mimecast-MFC-AGG-ID: Z5mF4TYpPjOcm2gJr7Qjjg_1746005112
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FAF41800980;
	Wed, 30 Apr 2025 09:25:11 +0000 (UTC)
Received: from [10.44.33.50] (unknown [10.44.33.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A7E219560A3;
	Wed, 30 Apr 2025 09:25:06 +0000 (UTC)
Message-ID: <c6a24765-2b9d-4e64-a139-d2c3ddcc7b89@redhat.com>
Date: Wed, 30 Apr 2025 11:25:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/8] mfd: zl3073x: Add support for devlink
 device info
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250425170935.740102-1-ivecera@redhat.com>
 <20250425170935.740102-5-ivecera@redhat.com>
 <20250429115933.53a1914c@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250429115933.53a1914c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 29. 04. 25 8:59 odp., Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 19:09:31 +0200 Ivan Vecera wrote:
>> +static int zl3073x_devlink_info_get(struct devlink *devlink,
>> +				    struct devlink_info_req *req,
>> +				    struct netlink_ext_ack *extack)
>> +{
>> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
>> +	u16 id, revision, fw_ver;
>> +	char buf[16];
>> +	u32 cfg_ver;
>> +	int rc;
>> +
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_ID, &id);
>> +	if (rc)
>> +		return rc;
>> +
>> +	snprintf(buf, sizeof(buf), "%X", id);
>> +	rc = devlink_info_version_fixed_put(req,
>> +					    DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
>> +					    buf);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
>> +	if (rc)
>> +		return rc;
>> +
>> +	snprintf(buf, sizeof(buf), "%X", revision);
>> +	rc = devlink_info_version_fixed_put(req,
>> +					    DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
>> +					    buf);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = zl3073x_read_u16(zldev, ZL_REG_FW_VER, &fw_ver);
>> +	if (rc)
>> +		return rc;
>> +
>> +	snprintf(buf, sizeof(buf), "%u", fw_ver);
>> +	rc = devlink_info_version_fixed_put(req,
>> +					    DEVLINK_INFO_VERSION_GENERIC_FW,
> 
> Are you sure FW version is fixed? Fixed is for unchangeable
> properties like ASIC revision or serial numbers.

Hmm, should be running. Thanks for pointing out.

>> +					    buf);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = zl3073x_read_u32(zldev, ZL_REG_CUSTOM_CONFIG_VER, &cfg_ver);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* No custom config version */
>> +	if (cfg_ver == U32_MAX)
>> +		return 0;
>> +
>> +	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
>> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
>> +
>> +	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);
> 
> You need to document the custom versions and properties in a driver
> specific file under Documentation/networking/device_drivers/

Will add.

Thanks for the review, Jakub.

Ivan


