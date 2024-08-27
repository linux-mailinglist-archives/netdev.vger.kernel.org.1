Return-Path: <netdev+bounces-122419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9396136A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727F71F23FC2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAD1C7B6F;
	Tue, 27 Aug 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bcBs3bXI"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836871C6F5A;
	Tue, 27 Aug 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774229; cv=none; b=mBNanEbICubtK6aj6gpbgo2lNMcpSlA1nre5hS1ADESp8Tyl9//L6y2Wl73kMx+UQ7HciegcF/kicW7STKx131nAuwKeHCKKssmV1M+UowOjXp+V9d5Q5vLQAO+u3v0XdccthmvvtjqV22pIWybNnqes07eEPtQswAJtDxdNF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774229; c=relaxed/simple;
	bh=zLybsmmA/dNQBCb0K47ZvCTt1Dkq9mWO7n4NyLE/qqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPGNEzByI+Wm7Fbk5yFdiR5mUsULcXhHxhjsNg6jc/TcKseHNSPjbvyHSfY8YsW5i1GBSsR8m3tHb6+hzcuO8OA3t7kKBvL9vQljF2gqEJvi0Nkzn3jadkPkNY0xprv5XsH9X+0BDBM42QDUT3CMns/Il6gibUlLpHZpoWPCRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bcBs3bXI; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JkCeEAt5cHITP7RetqruZ1Th0EarylAXUF4nlRsvpc0=; b=bcBs3bXIF7BAuka7a6hoXXbOCG
	Apma+jiH5SFEvgzdZ3hSPXkJuUHa74VIgGY7jU0DRGFBsgp7ZyUpEXnsYbhzTy4HynZ1UiF38Rvo2
	FbLGYnbmBgi/sUQo+BbSGEAvX6ZWErRUewomNgVCFFB4grYErxVvRU4ft9if95Vv7DKQ=;
Received: from p200300da77101f3b1403fd89cc64965b.dip0.t-ipconnect.de ([2003:da:7710:1f3b:1403:fd89:cc64:965b] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1siyYu-004f8D-2z;
	Tue, 27 Aug 2024 17:56:52 +0200
Message-ID: <02024954-6ea6-47ca-9f89-2e66fe268f7f@nbd.name>
Date: Tue, 27 Aug 2024 17:56:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: fix switchdev host mdb entry updates
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240822163836.67061-1-nbd@nbd.name>
 <a7a33be8-6ef6-402e-b821-8ce9d4620a1b@redhat.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <a7a33be8-6ef6-402e-b821-8ce9d4620a1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.24 13:03, Paolo Abeni wrote:
> Hi,
> 
> On 8/22/24 18:38, Felix Fietkau wrote:
>> When a mdb entry is removed, the bridge switchdev code can issue a
>> switchdev_port_obj_del call for a port that was not offloaded.
>> 
>> This leads to an imbalance in switchdev_port_obj_add/del calls, since
>> br_switchdev_mdb_replay has not been called for the port before.
>> 
>> This can lead to potential multicast forwarding issues and messages such as:
>> mt7915e 0000:01:00.0 wl1-ap0: Failed to del Host Multicast Database entry
>> 	(object id=3) with error: -ENOENT (-2).
>> 
>> Fix this issue by checking the port offload status when iterating over
>> lower devs.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> This looks like a fix suitable for the net tree and deserving a fixes
> tag. Could you please repost adding both the target tree prefix and tag?

Looking at the code changes, I wasn't able to figure out which commit 
introduced the bug. Do you have any ideas what commit I could reference 
in the Fixes tag?

- Felix


