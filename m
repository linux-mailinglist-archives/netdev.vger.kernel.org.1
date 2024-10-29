Return-Path: <netdev+bounces-139767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7569B4083
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37671F22C43
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E71DF972;
	Tue, 29 Oct 2024 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WxPwLbW/"
X-Original-To: netdev@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4E1DE3BE
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169441; cv=none; b=fVKckQdxcoIGt7VqV87mBUqRaDk7mf2RUIdyEgV9Rycrk4R22EZ1zTA7tL1+zY7IlaiI/qCN98x+ccEez6o0ELTIN/xH99pTwx9/uXkcluvkL+24Gkuk/QF/uCnMJ149R0xhA9Ad/SwM6mlPEoSyEN8aRpP40yrnwsPerg1PjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169441; c=relaxed/simple;
	bh=ZEzbJMw3CCX1EgjWoQF+p81ZV6S4EH459xnr37ezgfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETEZlfSZrjZ0YBPYW/JDI2uyFs8olO6tE6p/1K/4VoYTM2d75ZwoXsJBIx4uKj03yu0oqTQlRXH0FVDxUE5QJHWzABt02Jw9hPYhirujI7P9lXND32weyYlCg4QuUpjWisiO/I1Og8alLpQDtc6Wyb+man2ePAwlM1od5daXeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WxPwLbW/; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id 5OWStAcmSiA195c6gt8zEZ; Tue, 29 Oct 2024 02:37:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5c6ftC123QnWx5c6ftOVF8; Tue, 29 Oct 2024 02:37:18 +0000
X-Authority-Analysis: v=2.4 cv=NLLT+V6g c=1 sm=1 tr=0 ts=67204a5e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=0ph4O_eCIKN4VXpP38MA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oMDPNcVjXoJnWvcqLfu45hfxdqLWk0lka10Jtk+LTWE=; b=WxPwLbW/SuaqzhArQ7BFsz/ELH
	TwT+pN4tG9iMfDZUvDJkClRyLScJOllyWTrXg5Ev7B7eQDTFO7dBEZYGIScALP12Zd6mOXYsc2Fks
	oKYmCmPpM6uDZBMwTU0y6XT9rYBX70mLH+7HFhAYmWHudvwm5X6pYcB7wcsOsL0+71W8rcpH657vq
	3Z3cffNmhcxDAsdcBAgQjFfB+rrCOEB6wAOb270LKgysqHG4XbuiU6cwFi4EbjXT2cyoAV89Vlyo9
	iVgtnV78y/6ZiYMGM+GN9mzpszavonEuM5OOgm83ZKXLc2bNRPaDfr+/NGoAtwYOPkxxpI4R2VYps
	W+BrWi+A==;
Received: from [201.172.173.7] (port=43846 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5c6d-002E0m-1T;
	Mon, 28 Oct 2024 21:37:15 -0500
Message-ID: <0bc27725-cd55-493b-8844-ee2c5baca5f0@embeddedor.com>
Date: Mon, 28 Oct 2024 20:37:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241028162131.39e280bd@kernel.org>
 <158eb222-d875-4f96-b027-83854e5f4275@embeddedor.com>
 <20241028173248.582080ae@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241028173248.582080ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5c6d-002E0m-1T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:43846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKxV9bgan+m6teDbOMJhoBsPKtOPbZtqS6Nqt+AaFYVKs7O2kWgG+m4cOsdVKoGJZFDwIEhoUOxkh+SVMWS+f6MNsAgZWHlgj5LpIZqS57Zq56NhnXbx
 vQHCZQqtLus3UVKliWYH1zQA8B1mjH/8lwrcb8XQaMwVZ0dS3saZdoMjdQx77gTQ5JdTV49KZzaGnkb1W5OT1J67ZDWZCa0GDSk=



On 28/10/24 18:32, Jakub Kicinski wrote:
> On Mon, 28 Oct 2024 17:32:53 -0600 Gustavo A. R. Silva wrote:
>>>> Additionally, update the type of some variables in various functions
>>>> that don't access the flexible-array member, changing them to the
>>>> newly created `struct ethtool_link_settings_hdr`.
>>>
>>> Why? Please avoid unnecessary code changes.
>>
>> This is actually necessary. As the type of the conflicting middle members
>> changed, those instances that expect the type to be `struct ethtool_link_settings`
>> should be adjusted to the new type. Another option is to leave the type
>> unchanged and instead use container_of. See below.
> 
> Ah, that makes sense. So they need to be included int the newly split
> patch. Please rephrase the commit message a bit, the current paragraph
> reads as if this was a code cleanup.

After double-checking, it turns out that the patch ends up being basically
the same. The only change that would be split in a separate patch would be
the following.

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5cc131cdb1bc..7da94e26ced6 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -425,7 +425,7 @@ convert_link_ksettings_to_legacy_settings(

  /* layout of the struct passed from/to userland */
  struct ethtool_link_usettings {
-       struct ethtool_link_settings base;
+       struct ethtool_link_settings_hdr base;
         struct {
                 __u32 supported[__ETHTOOL_LINK_MODE_MASK_NU32];
                 __u32 advertising[__ETHTOOL_LINK_MODE_MASK_NU32];

The rest will essentially remain the same as the change in
include/linux/ethtool.h triggers a cascade of changes across
the rest of the files in this patch.

So, you tell me if you still want me to split this patch. In any case
I'll update the changelog text.

Thanks
--
Gustavo




