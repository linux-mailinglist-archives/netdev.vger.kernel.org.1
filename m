Return-Path: <netdev+bounces-105493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0A9117EA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8891F21E23
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FD110A;
	Fri, 21 Jun 2024 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="e3BCL6Wl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8A625
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932468; cv=none; b=sjoI6MGENRl4wG5SmV8anggPOKF6+9hCRL+IKIFWsXAaz34ssVzHm8CmtbzhKmDowJvuYlG1FdXphq5ZH9vURnxJ50uehMbfYFm18Jd6hHt3C5L9HWh1mG3JyTl9EQctc7pWaANiRumzDmvCwcKoI4dj/DybRpg2zbTynLM4Eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932468; c=relaxed/simple;
	bh=9LB665ltaMQdVDB7NKRuBR2Happ/4VmguFBv8ifDUHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDg/fbTaRVhi6INUHqoNiXrYv21Egj+ZrCXGWZ7G+xnu/lrz8Snb6Kw3+sourvs+wqWVFSEAzPK+p28uQjHelWo0QZ/fkG4pahXgFuqJkMbSDP8RRSKj79Z74WBn3hWmpkJLgN5cR2htkejYkhm0DP2MFiicMFcooHDNTDgyDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=e3BCL6Wl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso1063127a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718932466; x=1719537266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUYxf+zUA8RuecccUfja0ooq4GpO5mq/Ux7aTHSzM4g=;
        b=e3BCL6WlCaSY18Tr2ItXR3kc86UDcdZqFZEaNSrmGUPi8muiH8qcNvOlwk98CUpLIs
         pBJZDZwIo7k089qUAVIX5wbmvFUxSoTPtv3E/eD8lQCyZgXzOYPhbW8XJE337ZVehcdd
         iW+wSUvHj5/tt/vT9ga4lr+JZUIliiIDoIpgzKtYspX3F5ZxjuWWrqHUv8eO1mlS6SYH
         sqMy/Gbp5dOplYknymdpLLrxjrb8r2IwjH6pOvZJkze0eh82ITMhTaUt1CMmVvQmhBnO
         MDiJbUDzLcmcvMIK2ScgwXd84EqG8t0OYuAPRpZB+df0rNnA0Rc3/Q0bB7rjpE8b4N/a
         Je1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718932466; x=1719537266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUYxf+zUA8RuecccUfja0ooq4GpO5mq/Ux7aTHSzM4g=;
        b=VlteZTo9NZuVN7LFFNvAx4vBvHpRHY92gjLh/nt35UbzGgmG3oJMZ1qpK2IzjKLDti
         rEen/bdTdGzY0DM3YIxMoDAn+ujEPzbsMq1keeOo3WmPUJ9jkLtvHgNfrrfBe1l2vtvI
         KSpNzYSz8V3NlUIeYon+YF4scvuZTmkwcAJRYWq8lFmkP3mvBcV9ElWDpkiWKLs88jnS
         NBq9RHfJY2mzGIYt4VuL179R75WZ5hbg/5+KhCmmMvReQ5uhAzDuAWn4d/r9y/n/xxCf
         d9ftyxKJmGvDpfaAktA6Zj5jvXsSH/aR6Sz48cAbcUbsoEAgcO2hW0O6ZfKz3afhWT9P
         o7fA==
X-Gm-Message-State: AOJu0YzQS81DxxnfpwnELdE3d8zgbkys8dh8BlEKjqgLLE0L1KDjO6ZC
	w9sNl2cfFja369f0fLjIYn9ElAfFWNpx8vamp3AaHpq3YZY9wrHbKOsn8kbR1ls=
X-Google-Smtp-Source: AGHT+IEWVwzdtLsB1ONKnmBniPWQKGqKRX1u66bBuGDF5omv1I3oMCG3bOZZppvlKqBHLY3hUam96g==
X-Received: by 2002:a05:6a21:18c:b0:1b5:d063:3396 with SMTP id adf61e73a8af0-1bcbb665aa0mr8759936637.59.1718932466546;
        Thu, 20 Jun 2024 18:14:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:b127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130e8e2sm263339b3a.215.2024.06.20.18.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 18:14:26 -0700 (PDT)
Message-ID: <94ac1a2f-d6d0-473b-80ca-012a0ad7dc02@davidwei.uk>
Date: Thu, 20 Jun 2024 18:14:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] selftests: drv-net: add ability to wait for
 at least N packets to load gen
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-4-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240620232902.1343834-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 16:29, Jakub Kicinski wrote:
> Teach the load generator how to wait for at least given number
> of packets to be received. This will be useful for filtering
> where we'll want to send a non-trivial number of packets and
> make sure they landed in right queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/load.py      | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index abdb677bdb1c..ae60c438f6c2 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -18,15 +18,27 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>                                   background=True, host=env.remote)
>  
>          # Wait for traffic to ramp up
> -        pkt = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
> +        if not self._wait_pkts(pps=1000):
> +            self.stop(verbose=True)
> +            raise Exception("iperf3 traffic did not ramp up")
> +
> +    def _wait_pkts(self, pkt_cnt=None, pps=None):

Do you need to emphasise that pkt_cnt and pps are mutually exclusive?

> +        pkt = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
>          for _ in range(50):
>              time.sleep(0.1)
> -            now = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
> -            if now - pkt > 1000:
> -                return
> -            pkt = now
> -        self.stop(verbose=True)
> -        raise Exception("iperf3 traffic did not ramp up")
> +            now = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]

nit: with duck typing `now' reads like a time value to me. Maybe
pkt_start and pkt_now?

> +            if pps:
> +                if now - pkt > pps / 10:
> +                    return True
> +                pkt = now
> +            elif pkt_cnt:
> +                if now - pkt > pkt_cnt:
> +                    return True
> +        return False
> +
> +    def wait_pkts_and_stop(self, pkt_cnt):
> +        failed = not self._wait_pkts(pkt_cnt=pkt_cnt)
> +        self.stop(verbose=failed)
>  
>      def stop(self, verbose=None):
>          self._iperf_client.process(terminate=True)

