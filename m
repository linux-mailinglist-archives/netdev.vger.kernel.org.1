Return-Path: <netdev+bounces-106407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D939161B4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842F11C210CA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D265148840;
	Tue, 25 Jun 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNX8eMXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEB1B7E4
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305638; cv=none; b=F423txcSuRjGuppkkGfOtmbXeuICqyNkDsXTh02i7kPtWDLEi+lp4qUuyJhffRMtp8vAwAdWJKiqPsvUAd1qB7UPvP4OcNRcJUkvkAIpGnOcUL3LI8BQshduo8S7FZEyyiszCiM52KZek8sFp5S9yME0bl629UDWvsIKSd09aJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305638; c=relaxed/simple;
	bh=1rPzDujyWmIwIyqbCq+2f1bwtgotJykgXqqTPrG5BuI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XSnobSCX+WwspL3uzAlCjL9m3NT3Hdm9c2Y/Ioin5/dH13aByB1Bsb0fF23DSb9yZjgNF3Wa2dAKVXe/Y3b17VBheGCaqtQvYILEw8v2kQHKSGAAz0mGLkdPLV1gBJQKFz+cK5wFc+ba40GjsOEY4q5OK3ktrETR3s8T5uj/zQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNX8eMXy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b4fe2c79fdso21973436d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305636; x=1719910436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebnjgx6ruG8vFL2s8yypqUsblA1wAxOllES2AlifxfI=;
        b=cNX8eMXyBrSjen+IzafyPlRz5YPHSaHS/7aD4PzQvgxhhz6F8jejquOQue5+jOrOne
         qiZ1sqBP+0KoTHNPgZt24nACB2RbvHa13a+HUYSqln5KMjyn3mvn+XNDrjXumAsg62BC
         j2Q3s+4Vl2ZAzBEkQROsEcPhXHI8CzEWeIMNizhdptItoeBaCLQAGxrj+cOlgDHrW5rI
         Ks6LF+4n7Ek/7CgZwG8Rs+WypayXUSpLfdWNU5THwVrDck5Q5GPLb5TRCP5WDfu3Y+k9
         lYkY8W3mwCo34shOG+Ko0bBV7gcC+qQIg7ePUDTJCdlsbCRCXQvy5TtAXODjhc2qmVKE
         xjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305636; x=1719910436;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebnjgx6ruG8vFL2s8yypqUsblA1wAxOllES2AlifxfI=;
        b=HlSccLGEwKooC5bnrCaRbppuW2ukXUX0r6jsCCx8VLqqOpFqd/QWXgqao9yJZsNo8J
         Zrh++QQRvFL2aVdFGmT8KGqFK38lKGF7jM2mTzONM53AoNMZ/sgRqhUGz9ph9C5dha/C
         vGOLAeCwthuTgPO+zV7gZLN5QpZOaX/2PptHn1ppwyUAWSQSlQD93XiHngUbAwYQCkJ/
         PwVWTPBfp/Yv2RTOs/8+yRCteygCTu3Wk54DUDrnM416HfD9iVXU8bCMvqh92kW3L6kq
         aaILcPrnpdTbNWoVpgdYgBZLraDO3WqB5BLNcO/lFbiGY+ZhY6RadY9UHgq742TOVQVc
         fefw==
X-Gm-Message-State: AOJu0YwZAnYzMITOTGkuYeURMpJ0zdhH99LhQ8zZsweqkrNTxI5ZKC9y
	kKLnyB8ip/vsBw2iflMPWj0pRyTem/ItAUkiGvdGzbMw0NAcEpGU
X-Google-Smtp-Source: AGHT+IGzMWXU+idX+gAu0Y9Qsw+KW1Dj5zf3MD3HsSVE0HYfzNSpB6o776sbM1mVZucSRerKBsMZaw==
X-Received: by 2002:a05:6214:528d:b0:6b0:81f7:392c with SMTP id 6a1803df08f44-6b53bbbe8b8mr107915866d6.13.1719305636120;
        Tue, 25 Jun 2024 01:53:56 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef96e39sm41813906d6.144.2024.06.25.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:53:55 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:53:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667a85a38657b_38c6b5294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240625010210.2002310-4-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 3/4] selftests: drv-net: add ability to wait
 for at least N packets to load gen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Teach the load generator how to wait for at least given number
> of packets to be received. This will be useful for filtering
> where we'll want to send a non-trivial number of packets and
> make sure they landed in right queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add comment that pps or pkt_cnt are mutually exclusive (David)
>  - rename variables (David)
> ---
>  .../selftests/drivers/net/lib/py/load.py      | 30 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index abdb677bdb1c..31f82f1e32c1 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -18,15 +18,31 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>                                   background=True, host=env.remote)
>  
>          # Wait for traffic to ramp up
> -        pkt = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
> +        if not self._wait_pkts(pps=1000):
> +            self.stop(verbose=True)
> +            raise Exception("iperf3 traffic did not ramp up")
> +
> +    def _wait_pkts(self, pkt_cnt=None, pps=None):
> +        """
> +        Wait until we've seen pkt_cnt or until traffic ramps up to pps.
> +        Only one of pkt_cnt or pss can be specified.
> +        """
> +        pkt_end = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]

nit: kind of confusing that the first reading is called pkt_end.

I'd s/pkt_end/pkt_start and pkt_start/pkt_now.

Obviously only bikeshedding at this point. Feel free to ignore.

>          for _ in range(50):
>              time.sleep(0.1)
> -            now = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
> -            if now - pkt > 1000:
> -                return
> -            pkt = now
> -        self.stop(verbose=True)
> -        raise Exception("iperf3 traffic did not ramp up")
> +            pkt_start = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
> +            if pps:
> +                if pkt_start - pkt_end > pps / 10:
> +                    return True
> +                pkt_end = pkt_start
> +            elif pkt_cnt:
> +                if pkt_start - pkt_end > pkt_cnt:
> +                    return True
> +        return False
> +
> +    def wait_pkts_and_stop(self, pkt_cnt):
> +        failed = not self._wait_pkts(pkt_cnt=pkt_cnt)
> +        self.stop(verbose=failed)
>  
>      def stop(self, verbose=None):
>          self._iperf_client.process(terminate=True)
> -- 
> 2.45.2
> 



