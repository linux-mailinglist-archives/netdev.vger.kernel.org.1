Return-Path: <netdev+bounces-97293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0E8CA916
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730D11C210C7
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0F50A6E;
	Tue, 21 May 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="AY0ceuEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6C256A
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277098; cv=none; b=IE6Ifag/QOo5pEIuCrz3YWNmdvymLTE7vfLJbMKsVZXt44Lvti0OS7z+J+f0ITBQdR4LkpYMa4sBxQ/zlcLyXCrmzS9+XR+3gUfZthsOjZh9yCQCtq7kS6+uGMvYcwYB0p3QFUFglLtdJJ84O69J9u7RwViRQhXPPlDh9aS+NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277098; c=relaxed/simple;
	bh=FwIRMnyUp5kd3NuY0l6H6P957sNYMECc/Afd4x7jI0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkN5k9kcVJYaKeDJd7FmGmmviJtbyNOGGIZqlsCBugdHFEBiQ2Ffif/C69XvLbSRVFhfIvzoFyuMsCE5kxyTHW7G397hcMLezLRTYEqNH6JX2fy1O9dQYcQk3Mb/dO5SrGOng4+hZRiDfTI4q9V9AzA4Pzh6ha3OZ2vGxXidDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=AY0ceuEV; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44L7c4eQ002808
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 21 May 2024 09:38:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716277086; bh=t7UpYBHGY7Wq8MymFqkl3bxG72ubJEcZ5cnXZlniOqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AY0ceuEVEOWWqHxQVu8SkB3v12Em0yrqv4IzZ1GfDJPEnJMgD+TtrOc2wigi6LRXl
	 JAzZ905227BqZd+YaZAfMD0DHvgnKoOu5e+H+gGHZj/kYhgIHdQDTbpyMFElLFKewe
	 m56ZNlayXi+LxIcOV4xplq3/KiVuR4k3sZ0968pU=
Message-ID: <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
Date: Tue, 21 May 2024 00:38:02 -0700
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
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.05.2024 at 00:34, Michal Kubecek wrote:
> On Tue, May 21, 2024 at 12:02:47AM -0700, Krzysztof Olędzki wrote:
>> # ./ethtool  --version
>> ethtool version 6.7
>>
>> # ./ethtool --debug 3 -m eth3
> [...]
>> sending genetlink packet (76 bytes):
>>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
>> received genetlink packet (96 bytes):
>>     msg length 96 error errno=-22
>> netlink error: Invalid argument
> 
> Can you do it with "--debug 0x12" or "--debug 0x1e"? It would tell us
> which request failed and that might give some hint where does this
> EINVAL come from.

Sure,

# ./ethtool --debug 0x12 -m eth3
sending genetlink packet (32 bytes):
    msg length 32 genl-ctrl
    CTRL_CMD_GETFAMILY
        CTRL_ATTR_FAMILY_NAME = "ethtool"
received genetlink packet (956 bytes):
    msg length 956 genl-ctrl
    CTRL_CMD_NEWFAMILY
        CTRL_ATTR_FAMILY_NAME = "ethtool"
        CTRL_ATTR_FAMILY_ID = 21
        CTRL_ATTR_VERSION = 1
        CTRL_ATTR_HDRSIZE = 0
        CTRL_ATTR_MAXATTR = 0
        CTRL_ATTR_OPS
            [1]
                CTRL_ATTR_OP_ID = 1
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [2]
                CTRL_ATTR_OP_ID = 2
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [3]
                CTRL_ATTR_OP_ID = 3
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [4]
                CTRL_ATTR_OP_ID = 4
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [5]
                CTRL_ATTR_OP_ID = 5
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [6]
                CTRL_ATTR_OP_ID = 6
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [7]
                CTRL_ATTR_OP_ID = 7
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [8]
                CTRL_ATTR_OP_ID = 8
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [9]
                CTRL_ATTR_OP_ID = 9
                CTRL_ATTR_OP_FLAGS = 0x0000001e
            [10]
                CTRL_ATTR_OP_ID = 10
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [11]
                CTRL_ATTR_OP_ID = 11
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [12]
                CTRL_ATTR_OP_ID = 12
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [13]
                CTRL_ATTR_OP_ID = 13
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [14]
                CTRL_ATTR_OP_ID = 14
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [15]
                CTRL_ATTR_OP_ID = 15
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [16]
                CTRL_ATTR_OP_ID = 16
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [17]
                CTRL_ATTR_OP_ID = 17
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [18]
                CTRL_ATTR_OP_ID = 18
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [19]
                CTRL_ATTR_OP_ID = 19
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [20]
                CTRL_ATTR_OP_ID = 20
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [21]
                CTRL_ATTR_OP_ID = 21
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [22]
                CTRL_ATTR_OP_ID = 22
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [23]
                CTRL_ATTR_OP_ID = 23
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [24]
                CTRL_ATTR_OP_ID = 24
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [25]
                CTRL_ATTR_OP_ID = 25
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [26]
                CTRL_ATTR_OP_ID = 26
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [27]
                CTRL_ATTR_OP_ID = 27
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [28]
                CTRL_ATTR_OP_ID = 28
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [29]
                CTRL_ATTR_OP_ID = 29
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [30]
                CTRL_ATTR_OP_ID = 30
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [31]
                CTRL_ATTR_OP_ID = 31
                CTRL_ATTR_OP_FLAGS = 0x0000001e
            [32]
                CTRL_ATTR_OP_ID = 32
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [33]
                CTRL_ATTR_OP_ID = 33
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [34]
                CTRL_ATTR_OP_ID = 34
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [35]
                CTRL_ATTR_OP_ID = 35
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [36]
                CTRL_ATTR_OP_ID = 36
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [37]
                CTRL_ATTR_OP_ID = 37
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [38]
                CTRL_ATTR_OP_ID = 38
                CTRL_ATTR_OP_FLAGS = 0x0000000a
            [39]
                CTRL_ATTR_OP_ID = 39
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [40]
                CTRL_ATTR_OP_ID = 40
                CTRL_ATTR_OP_FLAGS = 0x0000001a
            [41]
                CTRL_ATTR_OP_ID = 41
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [42]
                CTRL_ATTR_OP_ID = 42
                CTRL_ATTR_OP_FLAGS = 0x0000000e
            [43]
                CTRL_ATTR_OP_ID = 43
                CTRL_ATTR_OP_FLAGS = 0x0000001a
        CTRL_ATTR_MCAST_GROUPS
            [1]
                CTRL_ATTR_MCAST_GRP_ID = 5
                CTRL_ATTR_MCAST_GRP_NAME = "monitor"
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
    ETHTOOL_MSG_MODULE_EEPROM_GET
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
        ETHTOOL_A_MODULE_EEPROM_OFFSET = 0
        ETHTOOL_A_MODULE_EEPROM_PAGE = 0
        ETHTOOL_A_MODULE_EEPROM_BANK = 0
        ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
    ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_INDEX = 7
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_DATA =
            0d 00 02 00  00 00 00 00  00 05 00 00  00 00 00 00
            00 00 00 00  00 00 27 71  00 00 80 0e  00 00 00 00
            00 00 16 48  00 00 00 00  00 00 0c f1  00 00 00 00
            00 00 1f 93  00 00 00 00  00 00 00 00  00 00 00 00
            00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
            00 00 00 00  00 00 00 00  00 00 00 00  00 03 00 00
            00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
            00 00 00 00  00 03 01 00  00 00 00 00  00 00 00 00
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
    ETHTOOL_MSG_MODULE_EEPROM_GET
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
        ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
        ETHTOOL_A_MODULE_EEPROM_PAGE = 0
        ETHTOOL_A_MODULE_EEPROM_BANK = 0
        ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
    ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_INDEX = 7
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_DATA =
            0d 00 0c 00  00 30 00 00  00 00 00 01  00 00 00 00
            00 00 00 00  41 56 41 47  4f 20 20 20  20 20 20 20
            20 20 20 20  00 00 17 6a  33 33 32 2d  30 30 33 33
            35 20 20 20  20 20 20 20  41 30 42 68  07 d0 46 71
            00 00 0f de  51 44 32 35  31 33 37 30  20 20 20 20
            20 20 20 20  31 33 30 36  32 31 20 20  08 00 00 29
            00 4e 54 41  50 03 3b 06  00 3b 06 00  3b 06 00 00
            00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 f9
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
    ETHTOOL_MSG_MODULE_EEPROM_GET
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
        ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
        ETHTOOL_A_MODULE_EEPROM_PAGE = 3
        ETHTOOL_A_MODULE_EEPROM_BANK = 0
        ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80
received genetlink packet (96 bytes):
    msg length 96 error errno=-22
netlink error: Invalid argument
offending message:
    ETHTOOL_MSG_MODULE_EEPROM_GET
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth3"
        ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
        ETHTOOL_A_MODULE_EEPROM_OFFSET = 128
        ETHTOOL_A_MODULE_EEPROM_PAGE = 3
        ETHTOOL_A_MODULE_EEPROM_BANK = 0
        ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 80


Krzysztof


