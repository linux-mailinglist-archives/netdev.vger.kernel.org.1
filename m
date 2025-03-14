Return-Path: <netdev+bounces-174827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9BBA60D49
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C833B631D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CD91EDA04;
	Fri, 14 Mar 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG5d4d1/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319691EEA2A
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944485; cv=none; b=Nw2mkLrj94iU7D1rFQSGlVBjZq505zMAGRxP2sJKWhtmyDMMxu72ZJwEWaYrAE/5c7T5RlS6Qa+mv3NzdfZtJukOcLb7rmlfgGU7qmS/VGczZ4nm0jWCZHEEEF+r4IQ/KmSDrj+sCbGr8zLa4Jk5RSzvu0K3olu1hn2+l5pb+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944485; c=relaxed/simple;
	bh=vsPV74bHjFFKgF9PSNyIa/k5Nno6ObGS6QrL0HdfSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6OW9IozUdS+5lFvegDWtLtYfCDWBdf13wlndHM+u3M7Mdabf+mQZKGg/2BfV0Qdfp+JaJpCiaRNWo/5tWzgRzWwqtNyKEQK1PdZ4eVGDvRSXJvRbGkvK5hAA9oqXLaihVeJdOkWDJ8K4T+zSTJag3h1H1QCo0kjdqjANgm/1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG5d4d1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
	b=OG5d4d1/ResZhWD4CtxyCdEf+fszr2CSWYNVmmo9qQ72Qnr3uAP48ys7ePcju5VMp38bMY
	nPxRGV/bZ8MCpB08PNAk5umx+tEnG7WbrBAIowZSvR1GuEVAj6h3uhS359craMS3juhOQk
	aoeY4XjBSRWKi4T9BdJhcfKQZOV2B60=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-Y8-O8zp-NqyQyJFFbK8YFQ-1; Fri, 14 Mar 2025 05:27:59 -0400
X-MC-Unique: Y8-O8zp-NqyQyJFFbK8YFQ-1
X-Mimecast-MFC-AGG-ID: Y8-O8zp-NqyQyJFFbK8YFQ_1741944478
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-394bbefc98cso1180568f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944478; x=1742549278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
        b=BXVCjBS3KYICKwtRRsAit68FNX6KYn5o7TKauV99eFGcsI/12Y4Td+dYfvgw5z2T7W
         4+ZQEzFZG7/mmZqMPPEN8+AbQeqHbuT9cJK521SDQQ28X1KJFKwiTQpEwUxVSvH7wzBt
         qNi4dMN7oHrf4hzD7ZfCf338XJbkRRc55SPWHvu6BDKgkR2pCBbHNtl5KSgssfjezP5d
         u29uGqQ6ySO8isqJbl7XUqKqlV6E5sLawwMvi5XIm+/qKiR+86vs2UmOtQ2qlBV2lOit
         qTGxCWkWgBOpsPmXNj8Ek7n3FIThR/M7j/0rKOOgFcbXlHmUZTjPs5JL2QPDNfV4A1na
         +qTw==
X-Gm-Message-State: AOJu0YwQtUVNClJsuz3bCpsRMJA6gfF9b33V+9wjl1kAjiOzfqbjuud4
	xUXPdVBhgXeS7LUOZlB0MqLKxtsjDFAsr/9Kv54KhlFIEbygM8aeUnUv5qWhfPOVy/FbksBjkzS
	EF3jqI7a9f9xjj7uXaNlxbi/7xelTRUFWhtv5jbiDPGqf9q3xtEHUDw==
X-Gm-Gg: ASbGncuu9ykNsHJYo3G55E5uYV8MK0p05oPkcK3nuy+yx1Pn8qA5pnu/Je2Tv/fp2yc
	LBFWGq0hLGl06+bIP22MeCbu2wZaKbjW1kjXIhISWbGuEo3fEYdje3AOVf7jhNMPWnSOZgd7njo
	+/rFw2yoYbj/yNgLMO7TnuzQBt1qXOnjW2G0FVb0sNMH4gc/kMVGF1JN4fSw7B7CaEyFNifmDq8
	VCHxhHU2kds7vPYZoCwfOFv2xbe8MGRJmYR190eNPHNL3rp/yROgraTEnkbV/szbKHo3tCXkJU9
	nJQe/Ba2JHgHzWyNWl6v5AGOTGrRtUu8ycf2VUBgL506Hw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439402f8f.4.1741944478425;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZopK7VodYGavJXVWlDpju0bgDr38GUC5squ/pcPs+slUfrLvt93Hpt7yU6EFnjFbYLAnfw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439386f8f.4.1741944478015;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-24-221.dyn.eolo.it. [146.241.24.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm11754075e9.16.2025.03.14.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:27:57 -0700 (PDT)
Message-ID: <0a205f79-b0b5-4cd6-b237-3c61b61bc806@redhat.com>
Date: Fri, 14 Mar 2025 10:27:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 9:35 AM, Matthieu Baerts (NGI0) wrote:
> After the recent merge between net-next and net, I got some conflicts on
> my side because the merge resolution was different from Stephen's one
> [1] I applied on my side in the MPTCP tree.
> 
> It looks like the code that is now in net-next is using the old way to
> retrieve the local and remote addresses. This patch is now using the new
> way, like what was in Stephen's email [1].
> 
> Also, in get_interface_info(), there were no conflicts in this area,
> because that was new code from 'net', but a small adaptation was needed
> there as well to get the remote address.
> 
> Fixes: 941defcea7e1 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Link: https://lore.kernel.org/20250311115758.17a1d414@canb.auug.org.au [1]
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 7a1026a073681d159202015fc6945e91368863fe..79f07e0510ecc14d3bc2716e14f49f9381bb919f 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -15,18 +15,18 @@ no_sleep=False
>  def _test_v4(cfg) -> None:
>      cfg.require_ipver("4")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> +    cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
>  
>  def _test_v6(cfg) -> None:
>      cfg.require_ipver("6")
>  
> -    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
> -    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
> +    cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
>  
>  def _test_tcp(cfg) -> None:
>      cfg.require_cmd("socat", remote=True)
> @@ -120,7 +120,7 @@ def get_interface_info(cfg) -> None:
>      global remote_ifname
>      global no_sleep
>  
> -    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
> +    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
>      remote_ifname = remote_info.rstrip('\n')
>      if remote_ifname == "":
>          raise KsftFailEx('Can not get remote interface')

Thanks for the very quick turnaround!

It really solves the mess I did.

Exceptionally applying (well) before the 24h grace period to keep the
tree sane.

Thanks!

Paolo


