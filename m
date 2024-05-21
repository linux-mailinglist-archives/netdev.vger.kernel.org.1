Return-Path: <netdev+bounces-97290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426748CA852
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35D3282832
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2B3FB8B;
	Tue, 21 May 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="gk4/wb+U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01737F
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274981; cv=none; b=fQYXu0vgUVKoGo/U132HA0vmMf5RfTLOYe5VFLa2uxjcLZ7956s1OlGkeHJ9177ooQxkjeibfov1DwI2AdIvO6JSOAw68XFA+T1K2vjPuaVjNc7cn+48OKf28/MKa51kE51/J1j0tHI9xwoRmxsPx9kGjn8a1/JaU7T+z6Xuxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274981; c=relaxed/simple;
	bh=FYeONf00nGVBZvbGiouUjP3pIN7aojFXVqoHaU9TBGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/HmKvq0bBLiM/oBvzwqYAcsLG+7jcy1ozXXrnfk2m8vZsGlCkycOUhWOn4KFZvWBbZRXv0PWgCiBDd2qx9U3btXptJjm3nkD1EVL0yO3iKJcJYGlEfw5emz+R958fVFZZNMy9yWvuyWCODm92FKq1c7JKLEu9MrI/rF4OBJVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=gk4/wb+U; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44L72l9E001064
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 21 May 2024 09:02:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716274970; bh=wpveKqifoFK0cFVSNeJnAk7s8e61uCZREHHL7jrQZsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gk4/wb+Uxu3/szz4tKwTF42IjRPSrkBjoGryZpvhCrqAGsaXxlUI0UeXaFvpseAD6
	 cLfNWpVr7HhO1H6WIfuTFMNQI1AcENVqraqMCnhQ+yFEP6Li11Um9XyVqz2cmuYwjd
	 NVOxXBDgB3rpjmU0MqAQYj9n1zp6HkSlh5bRB850=
Message-ID: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
Date: Tue, 21 May 2024 00:02:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-vladyslavt@nvidia.com (User unknown).

Hi Michal,

On 20.05.2024 at 23:55, Michal Kubecek wrote:
> On Mon, May 20, 2024 at 11:26:56PM -0700, Krzysztof Olędzki wrote:
>> Hi,
>>
>> After upgrading from 5.4-stable to 6.6-stable I noticed that modern ethtool -m stopped working with ports where I have QSFP modules installed in my CX3 / CX3-Pro cards.
>>
>> Git bisect identified the following patch as being responsible for the issue:
>> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=25b64c66f58d3df0ad7272dda91c3ab06fe7a303
> 
> Sounds like the issue that was fixed by commit 1a1dcfca4d67 ("ethtool:
> Fix SFF-8472 transceiver module identification"). Can you try ethtool
> version 6.7?

Yes, forgot to mention - this problem also exists in ethtool-6.7:

# ./ethtool  --version
ethtool version 6.7

# ./ethtool --debug 3 -m eth3
sending genetlink packet (32 bytes):
    msg length 32 genl-ctrl
received genetlink packet (956 bytes):
    msg length 956 genl-ctrl
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (52 bytes):
    msg length 52 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (96 bytes):
    msg length 96 error errno=-22
netlink error: Invalid argument

Thanks,
 Krzysztof

