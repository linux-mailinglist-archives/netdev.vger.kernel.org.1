Return-Path: <netdev+bounces-82621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E200F88EC22
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF26299110
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0A14D701;
	Wed, 27 Mar 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VTizb/8e"
X-Original-To: netdev@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805F14D43F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559336; cv=none; b=gyUd8MIMFljim9a4vY9NCTyuR3+uHnUVUY4qaZnZ4TxWiQ71DcKldHazakMW5SzncjtIlDGSpnKGvkuIKiPetWHVIP4f5RQiKpNCZCIXkY+S9AKWny5DYOZ/LhX5Bt76fKLdNK8e+QQqvZqR7uZJVpAi2296JWMIiYWMEt2Wkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559336; c=relaxed/simple;
	bh=gMN/vy1OEAGkXDYuiqVo7/hP63UcoJ3uKwb/j9S4MrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8eLRke9Ot5ztJSGvG9J/p1QMT3CBItkYL752W5+wcRh9HE20gP75REAoso4sNC2/zxfBhpQabYfDtCONwe/kizrxBSxJUM4Q1cEzOEYueRq0sLrkAmEKzytksP0s7AF00QQRNRHRcSVmS7dQTxxV1OOSlzQzRg/GfBPTbhEqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VTizb/8e; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id pWKkrzz1YQr4SpWlcrhNaV; Wed, 27 Mar 2024 17:08:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pWlPrxda43g73pWlQrvuHg; Wed, 27 Mar 2024 17:08:36 +0000
X-Authority-Analysis: v=2.4 cv=esUUzZpX c=1 sm=1 tr=0 ts=66045294
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=94brYO8VEXWNUbGmlHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lSCdqTkx1RljbiqDMVW8JxneDk+aNzMqtkDooNcx1vQ=; b=VTizb/8erBSeOHgRDK4TOCBTbK
	MNAbyEO8E8ekOM4tvOVc9aqjXSOPBiWwcfNJTHM3i5qI8apQrHoPJv8/ZvjKd/DQ5CvS+TLX7CuwU
	/VOXsNIWvAEI66e1BdhRuZoPh/dEVY5+S9VgOx8UJ6jvXf1fU9xdddpkbi5UndS9i921mPdD5XgDp
	XOQmvJ8ng1eNr9C7n8kXwmLbE/cnu832gPvDETyWYKgWV/2uk90nuYcB0AjMOqFZniGx4WB1x/eWF
	wDIYk3l03cUgta1YH/XWXc/Q+O2YPHQaoev7Vis4cp83P67f4lvN6dHEBpto3KjtukxfjtmlVMj+R
	eAlTG9Nw==;
Received: from [201.172.173.147] (port=54120 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpWlP-001nk2-05;
	Wed, 27 Mar 2024 12:08:35 -0500
Message-ID: <d5b0c70e-8369-4b99-9a42-9a4a93098251@embeddedor.com>
Date: Wed, 27 Mar 2024 11:08:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgRIF1bkXlZlaK22@neat>
 <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpWlP-001nk2-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:54120
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH6hesUrKkn5Lldkee3GE4eo2vmbWdB26yB5VvOahQ8tVrlGAsSRQ93w65NKJPQpPskgFAkq3GZwdmyi3okHdGwAZnlk9KG6L0CISimsrjll7EuWNDde
 YG2rownS2KbQa+V3tcc3ZhKzmUcq19beHJZoLjw+wxkjaIhYBAY/3RRMbtlbYq96+/Grjcjq61l1mnIV2rfSRQHMmhlY0d6WGSI=

Hi!

On 3/27/24 10:55, Luiz Augusto von Dentz wrote:
> Hi Gustavo,
> 
> On Wed, Mar 27, 2024 at 12:23 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
> 
> Which tree is this base on, I just rebased bluetooth-next on top of
> net-next but it looks like CI is still failing to build it, so either
> we don't have all the dependencies already in net-next or perhaps you
> had it submit while the tree had not been updated.

This is based off of linux-next.

I think net-next is missing this commit in v6.9-rc1:

d8e45f2929b9 "overflow: Change DEFINE_FLEX to take __counted_by member")

https://git.kernel.org/linus/d8e45f2929b9

Thanks
--
Gustavo

