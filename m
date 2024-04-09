Return-Path: <netdev+bounces-86046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9289D572
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E32836FD
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC577EF02;
	Tue,  9 Apr 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="dVGzmd31"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991B7F487
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654628; cv=none; b=bAyume1l6O7nyGcKcSQAPkqOwW8p/+TW75Iusv4pvLKtcXlIVsYXW36ycsb54TLljPIwEUyYwUWwJpboZKGRGRVp7jPUPI0MzicIoCbTtpyF8j9cWSZoVfJX8YvsndOHQuf3BxI4M6d6hw2/9dufRADJNsH/BuWGu0KynSIOyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654628; c=relaxed/simple;
	bh=ATcJ3L75SBuQiCChFA4mEUfgnkW7L16yPOdRV8sp60g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi4YWsn7qXD4ZMzAhHQqT/0/E7v56IKPwixEie6+ACsd4kSQSUBR7ceevquyELfJ2TaGeYHRzhEDrkpXkWbPq7IQHmgegMI/qyGjdmYMlIDv9PzAsNkdrR398nlvydmwwkoIfjivCMBP+SFkoy1Z9LYNKZH1D3r9p23uthjgk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=dVGzmd31; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240409091331bb497318e6964b7779
        for <netdev@vger.kernel.org>;
        Tue, 09 Apr 2024 11:13:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4Kw71aoe8njcZtPrp28GbNsxnD6SNgQ2lS14UhfIrRA=;
 b=dVGzmd31SW8X65XCb81/LP/gZPThSsVwpVM7FCQ1V4526BpcPap/nWGuD1t7bvc9OSAiAV
 PSAvVPPo/p8U0u+P1DaPYPaco09THFXBOmLllXrRyphl8BXI7sOg6l9NQqo6Q21/LFkmjKaV
 lmGyxH2/qTMwZ0W1QXTNi1VlRQrc0=;
Message-ID: <65ac9f42-1b51-4603-839c-cbaf69d2daf0@siemens.com>
Date: Tue, 9 Apr 2024 10:13:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 02/10] eth: Move IPv4/IPv6 multicast address
 bases to their own symbols
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch,
 danishanwar@ti.com, rogerq@kernel.org, vigneshr@ti.com,
 jan.kiszka@siemens.com
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
 <20240403104821.283832-3-diogo.ivo@siemens.com>
 <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 4/9/24 10:07 AM, Alexander Lobakin wrote:
> From: Diogo Ivo <diogo.ivo@siemens.com>
> Date: Wed,  3 Apr 2024 11:48:12 +0100
> 
>> As these addresses can be useful outside of checking if an address
>> is a multicast address (for example in device drivers) make them
>> accessible to users of etherdevice.h to avoid code duplication.
>>
>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Changes in v5:
>>   - Added Reviewed-by tag from Danish
>>
>>   include/linux/etherdevice.h | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>> index 224645f17c33..8d6daf828427 100644
>> --- a/include/linux/etherdevice.h
>> +++ b/include/linux/etherdevice.h
>> @@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN] __aligned(2) =
>>   { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
>>   #define eth_stp_addr eth_reserved_addr_base
>>   
>> +static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
>> +{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
>> +
>> +static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
>> +{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
> 
> I see this is applied already, but I don't like static symbols in header
> files. This will make a local copy of every used symbol each time it's
> referenced.
> We usually make such symbols global consts and export them. Could you
> please send a follow-up?

Yes, I'll send a patch addressing this issue.

Best regards,
Diogo


