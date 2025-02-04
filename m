Return-Path: <netdev+bounces-162640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D58A27743
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A811884893
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA852153E1;
	Tue,  4 Feb 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="i4IvqSRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522072C181
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687047; cv=none; b=WqOojAt1B+WMINhz445Ye1BtB6/PF8aMgdon9eUs9Cl5k3tH3Q56dSRO6OmRsdjbyy+HymILeEzQq2gAFmH3ubPmjGPMKh471vXYEaNpbCsG2ea7v1yZqc3Y0Mnu/0BSbXPrmZmz2qf+zBWMdRexrmIxXRqj+2zvD/wzP+C668s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687047; c=relaxed/simple;
	bh=fPq06NlDQdz/LRLCf6EQqJJhEZySSTtJ3Nz0eKYaPEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXx82ntORQUliU3objhsDMlY4JTVcd+C56Wn9gCjrhDx0MNdak8lyq6MFh6iJIM7/RHmqn/ngGJtVb1rgWGqvaQvfb4C0KbPEP8SgeARudWVcNytOJjsfJo1w7yYan2pHr/BxhWzz1R/oN1avsVZVGsms9glYaDPyTZyryErmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=i4IvqSRq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab925654d9so1067844066b.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687044; x=1739291844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaLuc67TVwcQpFAP8+pUSC2+xrF48qTdAKagds5bnKk=;
        b=i4IvqSRqhWYZyqXmn5bSUWPahO3gFXqkZY2DtQaLNNAqlLVP8UdnVFcJk08ebSeuBz
         nQKlYhfX3jYo+Fj2mE13o7W1Y9uw7+SOQE0ht886fEmJBn/kLaO1LxDe6PYEIx0LFuym
         NRLpz6oMwzSKj8/3DZtQ4UW3iohhq7kbSrPJVtSREut3SCXRF8w3MUMAPzbIedO3eHf/
         bl5uMWgTn3+qYbSy0NKkaVuiAMDyy9AQ3mRGY1Y7kaJ7Z0JitjQTySoKyVd+2TWQYa6H
         MXm36MkgJ9X6i5h2G1Vr3rdsuzl7E0urdn2+mVfQ51XvBshhry+ysiH/yjTxf3bXLegP
         rUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687044; x=1739291844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaLuc67TVwcQpFAP8+pUSC2+xrF48qTdAKagds5bnKk=;
        b=slY1k6HLhig0UjTYIiafDNnf43RXaLIEEoqBgv/255tEs+i2D+VIpfR8rh1y7rmm2H
         n+dosJYeIJElxCkHDLQZenHIB29JC44RNqi8N3/7xVdbdNcj3entj+KEwz5bzqQJVmsu
         9ph6Tf+xOoFlawQKtGrDUR7FWk2g5Zbng/vMSBLBZWiBcge/HoSBjE8bxXlwPY1ytZYm
         +wpz36SNb3v22yr6d0Z6a/17cC83kxQ6q6GwHuzhk8BWJxDPtYcdEr3Z/XECcVVcJwuX
         2hKvqz5MUZXcykEHc+8m3JsldlbJv3FJt2TPcWmU8ggTCTaqcLzDGo7JI0iF8LnrpguT
         AKCg==
X-Forwarded-Encrypted: i=1; AJvYcCUH1paiMKJ5TG02bg/Ed4n5p+Wtu4FBCI0aMTx5NK2sBXrRpaRY6pQHzJOVpjgjPquLFEI9pR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotvCtmfTigmqcrJYHXF4YuDg7K3mepaql2G+Dbb2uEUQuOeBy
	Ri9zfgsOMOlcG+7803deaBj01edhJx1Qc0PpWqJZOP+AzBpkAGAORj0G9iA8rqk=
X-Gm-Gg: ASbGncs4/CFkniqVTmoN1lBLo2pwXk98ZrtheEQ3aMYif+ayMOkL/KQxYNayQ3USRp1
	YNzbKJ+kYZd5Jugg+tP1Z2FiBscQTKWxpkZHbZtKuSDzAjJ3J8HETl3IRUWtjsSAx3AlhbGih31
	bcAN3X0dPr55DyPqzq36l56BFKp1xHcniodA8YaaOqz/hEBFD8ZH2dzoG41LGK7Xag6Y9c2lw7r
	czPLGYeit/mBFHjGPqdDIylZw2v5jIWzPKPuivGlVEAiyoY6Rghl/mKuiH8LK5zTb1W3EJs+Zh3
	ufYAE/Qb6HV0UPppvV2/wic7OshYHDdvFzwL4dRQ7xkjeN8=
X-Google-Smtp-Source: AGHT+IEZ2dqycZJIEl+1QB8mrOB2Bhw193DOZ+HDB5KhaY7vJPcNIPjyDFiTTuI2icA+g7knCugm0Q==
X-Received: by 2002:a17:907:bb89:b0:ab6:d575:3c53 with SMTP id a640c23a62f3a-ab6d5753e5cmr2795691866b.11.1738687044358;
        Tue, 04 Feb 2025 08:37:24 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f1e23sm941857866b.82.2025.02.04.08.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:37:23 -0800 (PST)
Message-ID: <e8db0f78-9b01-43b2-9c94-9e06fd3b3450@blackwall.org>
Date: Tue, 4 Feb 2025 18:37:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] vxlan: Refresh FDB 'updated' time upon
 'NTF_USE'
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-5-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> The 'NTF_USE' flag can be used by user space to refresh FDB entries so
> that they will not age out. Currently, the VXLAN driver implements it by
> refreshing the 'used' field in the FDB entry as this is the field
> according to which FDB entries are aged out.
> 
> Subsequent patches will switch the VXLAN driver to age out entries based
> on the 'updated' field. Prepare for this change by refreshing the
> 'updated' field upon 'NTF_USE'. This is consistent with the bridge
> driver's FDB:
> 
>  # ip link add name br1 up type bridge
>  # ip link add name swp1 master br1 up type dummy
>  # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
>  # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
>  10
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev swp1 master use dynamic vlan 1
>  # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
>  0
> 
> Before:
> 
>  # ip link add name vx1 up type vxlan id 10010 dstport 4789
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  10
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self use dynamic dst 198.51.100.1
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  20
> 
> After:
> 
>  # ip link add name vx1 up type vxlan id 10010 dstport 4789
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  10
>  # sleep 10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self use dynamic dst 198.51.100.1
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


