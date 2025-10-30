Return-Path: <netdev+bounces-234506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E25C22402
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691F93A56AE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616A2765DF;
	Thu, 30 Oct 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="KUb3umUm"
X-Original-To: netdev@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E062AEF5;
	Thu, 30 Oct 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856260; cv=pass; b=JJ/WqXendqE6TsogY1SOhfgQa/4RBBB4LGfG5wCFoYsJi3B1+ex2asa7ziFzJJ6DSfg3jhavL9KLK0TG0zok4OqOLEt4cAqRAoNikxtymadX+gTvJuxM9aRokVEGHOTPbMjXhhusPaglT7QWl450dMdKh9Ov1cgpi+5cbr1Fw+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856260; c=relaxed/simple;
	bh=aEyoDquK8jAwPsAQ35ZiPdK20ciUdFTGMEON6HpyF4U=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=P/6bhEgcgvr/0L0QSG+A3Iv/HHY5A1CT2AwpDwQXJZCPto20FJ6kwfdaZq4fMM2r9M5asmyr85bYOeiGs1P8I7FC0LEhP9nNBYxCGfw7qsiOE1HUDwWiB8LyexfH6kTCgibtcymzmEYlPdq+yr5OEjB9HfRHrLbzCQlT3WlAYic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=KUb3umUm; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2FD83122527;
	Thu, 30 Oct 2025 20:30:51 +0000 (UTC)
Received: from fr-int-smtpout24.hostinger.io (trex-green-5.trex.outbound.svc.cluster.local [100.121.213.161])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id D7509121E4F;
	Thu, 30 Oct 2025 20:30:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761856250; a=rsa-sha256;
	cv=none;
	b=W4sLALF+qWRi6YFhm9pKU0AhFcAeETFdMSMjeuNgQOOe30Svjb5143UUVJioNqozSV0J9m
	NuBzhcujJx3fTIqg5ENq3I84VIy5IDJOvDb/youv2e3Y7+j7OEQxlXu7LkuOm05vejeglH
	sf1W0o6qYupVeOHlLL7gBwoJIg6oCRh94JG9QgwhUtMmTjUArSjSLZxQJmL5v4fbcLoW2+
	f3kCCOhw4XU2p9DeiKcB+MrJkC138i+ozw5mQbD02j5+Oc/JlrpJXkoLX6v65+xeFXYqpa
	urNLiw9HSRIvQHFihW94tf5m64SXUoYvAvhYVhP2nJuUNm/3J7/qOnsEYnR5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761856250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=a/3w0tSYmbrdB8Bc4VelKk3WHGunz92aPVIP7o7nUFc=;
	b=bNxOHqPHJFk4pM9jx7Fekg0BHSeXHBdSyjGJVawywlQhTDcYZxUCVMR04hvlq7tgFK9Z66
	lqU+bsxS8CAyYaRvYjDYoqGj2uXohbt5/ntKBlzGzljYIB8FWLbqKUwsy0pM2aK8SDbUp3
	RMiJizSUdyFnMDP+XxoLt27fDvYWqdNkt2d4hF0gOAWgO4F0qqd5Lb+bfRIV+zEuyYHJoD
	zlcrGKUrw2tPDLxfVW+PskBJ2mh7U1LoVsFuiZLqllpqVPILPZ3c3+YXUNVDyRevPxFzK7
	WzgSXd0HwUkU1mbPawObgvyXZOxJ+GDkcxOaVX8mB9V46MReFnBO6k8ndqtuQA==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-w6swn;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Thoughtful-Abortive: 7dfbeef6333ef82d_1761856250704_2966912137
X-MC-Loop-Signature: 1761856250703:941208266
X-MC-Ingress-Time: 1761856250703
Received: from fr-int-smtpout24.hostinger.io (fr-int-smtpout24.hostinger.io
 [148.222.54.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.213.161 (trex/7.1.3);
	Thu, 30 Oct 2025 20:30:50 +0000
Received: from [IPV6:2001:861:4450:d360:c0a5:3392:2a75:70e6] (unknown [IPv6:2001:861:4450:d360:c0a5:3392:2a75:70e6])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cyG2q1f02z1xmj;
	Thu, 30 Oct 2025 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1761856246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/3w0tSYmbrdB8Bc4VelKk3WHGunz92aPVIP7o7nUFc=;
	b=KUb3umUme+l1IZqbe9VYEU0d+/Tfpt4Xuvf0mIDDtIk8O+OnQAIooo1HyJSHxZqyjWcZqn
	cGHfiM9bVWL+WnYI9ArPL/DGnwDQ/s7J/VfTILVwUpdva5klS/XbnbpT0BDmm3v6m/72bF
	7QFl8Mj8QC5g4yxhkznK8yPVWhyQr2lbsWffIJVQfKrVHAM6PZQ/K37EiU+COSbyYiuiF1
	HRXfyl34zjYy4OAAmGG9U4kb3C2Hkal5BtqaVuODDxmVAfA0U3tbotkkKV9koXDewL/Y4f
	avu5mRahhaTp0+H1XrAdEvR57RErj1vhld5vLOrBSzZyKd+Mb2137TUde7dz3g==
Message-ID: <b0624cd1-c223-459b-81dd-ddfe05ea23bf@rootcommit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Implement emac_set_pauseparam properly
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 30 Oct 2025 20:30:42 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Lflu6Sfi c=1 sm=1 tr=0 ts=6903caf6 a=oMt8lXEVxmMAvUTv2ASLGA==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=d70CFdQeAAAA:8 a=J2c-WwRuk2R10H0XxeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfDFDEgdfardwUXzuBuR06atOkE6SSVOwQrmHHmrTNGXJHeYVxusT/9hE/NioNVKaOlepWagMqC+D5Q3T+2W962ludmIA2u9300rs8JLhqXRwlpqzwX4M MFf9UPIPfXHJfXSpraVAWY8YGDgne+pB6Y5OJB5/31YRJwyqp74hdJvfkhD6a4n2C62p4rdwS1YlgxDn8wrQ5A6qEtA++lEeEkkz2voj7dVCNaQB9JZpZn/n 713oZYTAyiLt10pcr3UunZS+Ev+jNOaVHzEQoX1ni/lvpd72LCBAhDjM2R3yeeRKYV/2fsesLhRDWzca9vPv+tHPlU93czUqLAbU41gCK5wXoeKMW0TiXAyM usj45M9xNUSqrdkVAh/Hc9ZlaqhO89H97nYT5Qm4DI5Kly6w6nN40dlkDAJ29s59eFgaxQbloaJXKfZ4m3AVXs+hz9/2m664ih8Ou/xV+1035TLnYiG4VqYs 0OHFRS6Ul1DiFJAfrEDxjLSF26kNxaDUQUAMcOqU4k4vg4Yplljoj8j5HP7nIXlIUXo6mxX1cMjWD7xMPgHqNsiNS5WeX/hBSgkVxHLIMrPW9iJCu2OLJqK3 bdcZokvTk9RTFkZwBJvMPI8spnmBdooBlYmWSuNgjy6ybm6PTnd7Vzv5PpTClndSPRGQE7CphIsPUsDGrqfBnWG/cLpfLjFHY3o35c7IGMoQRp9Xi9ASUStV iX7CBJQYXDg/Qxx4zRdXOVLJqsXdkCN+LPtLk4aocTmA0PhtGdy4EWfVB81hxdfOT0kZZrUazI//H1Hiqsm8sW+si5CIzBgJux7NrupIzSP0C1RTSk0VFIEY 9KkcrGnThmWQSvMeNrg=
X-AuthUser: michael.opdenacker@rootcommit.com


On 10/30/25 15:31, Vivian Wang wrote:
> emac_set_pauseparam (the set_pauseparam callback) didn't properly update
> phydev->advertising. Fix it by changing it to call phy_set_asym_pause.
>
> Also simplify/reorganize related code around this.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   drivers/net/ethernet/spacemit/k1_emac.c | 48 ++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 28 deletions(-)


Tested on OrangePi RV2 through performance tests, on 
https://github.com/spacemit-com/linux/commits/for-next. No regressions 
found:

root@orangepi-rv2-mainline:~# iperf3 -c 172.24.0.1
Connecting to host 172.24.0.1, port 5201
[  5] local 172.24.0.2 port 49948 connected to 172.24.0.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   946 Mbits/sec    0    339 KBytes
[  5]   1.00-2.00   sec   112 MBytes   943 Mbits/sec    0    447 KBytes
[  5]   2.00-3.00   sec   113 MBytes   948 Mbits/sec    0    447 KBytes
[  5]   3.00-4.00   sec   112 MBytes   941 Mbits/sec    0    475 KBytes
[  5]   4.00-5.00   sec   112 MBytes   940 Mbits/sec    0    505 KBytes
[  5]   5.00-6.00   sec   112 MBytes   944 Mbits/sec    0    567 KBytes
[  5]   6.00-7.00   sec   113 MBytes   949 Mbits/sec    0    600 KBytes
[  5]   7.00-8.00   sec   112 MBytes   939 Mbits/sec    0    600 KBytes
[  5]   8.00-9.00   sec   112 MBytes   936 Mbits/sec    0    600 KBytes
[  5]   9.00-10.01  sec   113 MBytes   940 Mbits/sec    0    600 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec  1.10 GBytes   943 Mbits/sec    0   sender
[  5]   0.00-10.02  sec  1.10 GBytes   940 Mbits/sec     receiver

iperf Done.
root@orangepi-rv2-mainline:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 172.24.0.1, port 47834
[  5] local 172.24.0.2 port 5201 connected to 172.24.0.1 port 47840
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   112 MBytes   934 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   942 Mbits/sec
[  5]   3.00-4.00   sec   112 MBytes   942 Mbits/sec
[  5]   4.00-5.00   sec   112 MBytes   942 Mbits/sec
[  5]   5.00-6.00   sec   112 MBytes   942 Mbits/sec
[  5]   6.00-7.00   sec   112 MBytes   942 Mbits/sec
[  5]   7.00-8.00   sec   112 MBytes   942 Mbits/sec
[  5]   8.00-9.00   sec   112 MBytes   941 Mbits/sec
[  5]   9.00-10.00  sec   112 MBytes   942 Mbits/sec
[  5]  10.00-10.01  sec   640 KBytes  1.04 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.01  sec  1.10 GBytes   941 Mbits/sec     receiver
-----------------------------------------------------------
Server listening on 5201 (test #2)
-----------------------------------------------------------

Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Thanks!
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


