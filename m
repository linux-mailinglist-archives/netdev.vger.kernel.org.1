Return-Path: <netdev+bounces-146224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5579D251A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05A2B24E95
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A01C9ED5;
	Tue, 19 Nov 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHA0Q0Bf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC831C4A24
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016675; cv=none; b=XoTtIt+YS0ycCwUsvKJ1pmqJDa6xK6CeEEysBAK9bKdDBeoWsRPXRjkLCqoc+x/MlXMTbAODnUkvBy8nGMExQlYfThLCZ/INHRBQecKe9nBEDK0nyUtiEDLJ/sh0QjEUgd9egO59QvCRJdRwPOEKqMtbpP4fC0U5OFom0Yq/S2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016675; c=relaxed/simple;
	bh=f4tKIcMN7vBtR4ST2FQCV5bl7OuhORHbAKErSqdp4Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbOR1UE4oYBQz0C9jiuVFJn39v3rcPylpKv7vpFhskAZo5/68JkvvApFTc1vuG6Un+6AL0MDDpqmMNw8k4CKohNF03T+B7UpMDhbNiA657nNWLK5SryCK3YVPKX0qihNY/EQSgFlrC0Dp5N0Yj8OAB2BQZULOpKs3Tsj5sPTMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHA0Q0Bf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732016673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4tKIcMN7vBtR4ST2FQCV5bl7OuhORHbAKErSqdp4Ok=;
	b=NHA0Q0BfTdzly151nlhOVKNeJ1/5EGQa/Flrjzm3knabeVXtILFDVakZSMnC1cRbIMfcZ0
	TJt5+W5sIKAb5sYruysT1aKpnSzQHpW04sGyup0NfdFeLUHzVKfh8FzwOIo+YFVTgFctk2
	1pQfqOsEsVAe19SmdrECH81ZHNLEp4U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-jDAoH0RYO1C2yq5GWed1-A-1; Tue, 19 Nov 2024 06:44:32 -0500
X-MC-Unique: jDAoH0RYO1C2yq5GWed1-A-1
X-Mimecast-MFC-AGG-ID: jDAoH0RYO1C2yq5GWed1-A
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b14a4e771fso87619985a.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016671; x=1732621471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4tKIcMN7vBtR4ST2FQCV5bl7OuhORHbAKErSqdp4Ok=;
        b=WfRXIqGqzgpPqMsxHpQhlUvZj3oi9cL/TUynIrdWVGlDCptSVBPwjOED9DTWCzhjSd
         nyrb9WLCRytlUW9NbiHy3ryA7Kv6jhBOT6reDRFCHDuVQGCHIpQFDwp2hwTmPXrE4oMS
         tArwgLSr0FBeph7o+Kdlg6rlVftP8AAL/KwC+IxIQ6wjLHpfw8gXWLblR7pGNGyskyx7
         PcTrHYYoBPW6rFDO8Nsuv40HFEV5LSZu8ZbH4ItakuFJgd1lRGQodNfEJtFm+9DDbeNP
         Mq5d8n8TKrSpbciEssjwQzXni2n+ihfwAUniBgNzcGXDowdcmOuAMQO5XKD73tPzTsxI
         BSNg==
X-Gm-Message-State: AOJu0YzU3b1w+kNxN2pwE/exYTOwZb22U9P/tGX6ufuv5O1FkZdAUMKB
	smgn725SM2cJa+9KW5wYEemmiqp4vEp8QBXhcB3z3FWAHbobeX/Bs4/jxqWfQ941gHxvU04kQZG
	95P/5q6z5NINqKRFXEs4VGjsU4yU0tt/U+AF/ejvi/7CwFpchB8kWtA==
X-Received: by 2002:a05:620a:1a89:b0:7a9:bdd4:b4ea with SMTP id af79cd13be357-7b36229f0c9mr2162369985a.9.1732016671626;
        Tue, 19 Nov 2024 03:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK5+OxRQWXQHKP5IEgPJVLZTHomJ4aAb+TacL2h3S/6VXE1p2FnFeTpNsWz1IQmPlXUYA02w==
X-Received: by 2002:a05:620a:1a89:b0:7a9:bdd4:b4ea with SMTP id af79cd13be357-7b36229f0c9mr2162366785a.9.1732016671249;
        Tue, 19 Nov 2024 03:44:31 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8643dcsm84759285a.61.2024.11.19.03.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:44:30 -0800 (PST)
Message-ID: <31508271-5087-4d55-a509-13bb7218824f@redhat.com>
Date: Tue, 19 Nov 2024 12:44:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 0/5] Add more feautues for ENETC v4 - round 1
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, frank.li@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 09:23, Wei Fang wrote:
> Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
> some features are configured completely differently from v1. In order to
> more fully support ENETC v4, these features will be added through several
> rounds of patch sets. This round adds these features, such as Tx and Rx
> checksum offload, increase maximum chained Tx BD number and Large send
> offload (LSO).

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle



