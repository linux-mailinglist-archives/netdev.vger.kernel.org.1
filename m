Return-Path: <netdev+bounces-60151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE781DCE7
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB065281D00
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF21EAD9;
	Sun, 24 Dec 2023 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Gh625lmY"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E51101D0
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cCptRauw8t5sQ+p3gOt6TSNfDWhbM5MoDu9rtKW3GNs=; b=Gh625lmYN1gp566kDfw2i00ZVy
	MCDkznfnmVcd6ieAAUk8EspBgxx8edo0bWBmxcFKQ308o+cFpal3e4VcG7GuXKkvOlC5fRnqIQAcY
	w8+VM3URbQsNy/vWKrtxkZC730MxVi+WXBLgdIlj3s4jOMhLEfYYkqTGwf89nByU02Zs=;
Received: from [88.117.59.246] (helo=[10.0.0.160])
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rHWZF-0002gE-3A;
	Sun, 24 Dec 2023 23:03:30 +0100
Message-ID: <b232b24f-abe9-4f62-ab6f-e3c80524ac38@engleder-embedded.com>
Date: Sun, 24 Dec 2023 23:03:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Revert "net: ethtool: add support for
 symmetric-xor RSS hash"
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, ahmed.zaki@intel.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Jeff Guo <jia.guo@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20231222210000.51989-1-gerhard@engleder-embedded.com>
 <20231224205412.GA5962@kernel.org>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20231224205412.GA5962@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 24.12.23 21:54, Simon Horman wrote:
> + Jeff Guo <jia.guo@intel.com>
>    Jesse Brandeburg <jesse.brandeburg@intel.com>
>    Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> On Fri, Dec 22, 2023 at 10:00:00PM +0100, Gerhard Engleder wrote:
>> This reverts commit 13e59344fb9d3c9d3acd138ae320b5b67b658694.
>>
>> The tsnep driver and at least also the macb driver implement the ethtool
>> operation set_rxnfc but not the get_rxfh operation. With this commit
>> set_rxnfc returns -EOPNOTSUPP if get_rxfh is not implemented. This renders
>> set_rxnfc unuseable for drivers without get_rxfh.
>>
>> Make set_rxfnc working again for drivers without get_rxfh by reverting
>> that commit.
>>
>> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> 
> Hi Gerhard,
> 
> I think it would be nice to find a way forwards that resolved
> the regression without reverting the feature. But, if that doesn't work
> out, I think the following two patches need to be reverted first in
> order to avoid breaking (x86_64 allmodconfig) builds.
> 
>   352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>   4a3de3fb0eb6 ("iavf: enable symmetric-xor RSS for Toeplitz hash function")

Hi Simon,

frist I thought about fixing, but then I was afraid that the rxfh check 
in ethtool_set_rxnfc() may also affect other drivers with ethtool
get_rxfh() too. I'm not an expert in that area, so I thought it is not a 
good idea to fix stuff that I don't understand and cannot test.

Taking a second look, rxfh is only checked if RXH_XFRM_SYM_XOR is set 
and this flag is introduced with the same commit. So it should be safe
to do the rxfh check only if ethtool get_rxfh() is available.

