Return-Path: <netdev+bounces-103961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69190A961
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D4B1C21874
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB919069E;
	Mon, 17 Jun 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="htnSs2OO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6719306B
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615751; cv=none; b=Osz+T0LKuP6qacTVvAO8M7ZraOs79fpPL/GoP0GUDiHhUWcNioSbP366JXQ5QR8VcFDhNo00P+ayCg4UTHIxjVhiWzepEerCdwaYcb4ccx06IO8bTfnu/UbKQ5uns6nTaORXuPR7fXkCFAKAhIBg8dIAVZsClU+aSghGqyaloGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615751; c=relaxed/simple;
	bh=7pBygSvXUEzeZ7KKPjlgK315+kvra+m68BJk6VAaSxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvBgxZZ0g1BRGIgTlizftcSeCYHgydmkOT44PHREx4SI9w0qf/ZZ5QG6hBpzLAMogndL838ItJ96haUudpp92Z07pty2m2LGLU1KC36XJlRDRft1R5kSXMmr9KPGxRPEKJckUJDk2X7/7VybDwK4cKsN1DZDzRw0TqyayRw9OVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=htnSs2OO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c85a7f834so5357845e87.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718615747; x=1719220547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQak7Db+UMKRyf8ZpE5gXlX54BwJSl6zSRtqkVj0wTQ=;
        b=htnSs2OOHfRFS+ufMLYwCW/SRQ0iKMQtoyBn5hBvGyi0gDwBjNnWSwyKyob1OAFRG5
         6eK9fBNRSJvEBdn4DRpmFDRUtMOqaEkEUkUDjSt51gXOiH5ZRevS/V6itTZxzAxFSuLM
         3mhbiI0d4it6MgwNFgsDz+BpS7xUHLJE05VmbrOs3oDQQggS4QH29qpVYiyexhadPH3Z
         21xMjUrA+i1y+x2yQMasx1VkLtH8AV9xzYGJWddFdyM+C+9VuBjATZc2ddDUOSI1vR2R
         Sb5MuiiqWyzwjNdPNGjckOYQrkEJkrViPv9dQiTVnTsIKA/0RC5KJJ5gcKqwmuGe558o
         p1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615747; x=1719220547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQak7Db+UMKRyf8ZpE5gXlX54BwJSl6zSRtqkVj0wTQ=;
        b=rEs/FqdOQ683vVDPzZ69fCOhaDp09tjgAMwwUcTSfByKml6NGOi6MaLQOqZ1NjQ4cd
         6hPgYAOX0yKQJTajAuG2xxuD3KIG2m6BmVg22VOb6vaBd9y0dpwkR3lvRyDWbWgOQCcI
         VSEWSBV1ZS+bdss/cdwcz3G+Gp4f1SAXyPrGvsOpwKrqj3FT9DCYc3uhbscKNxVX/MCW
         psA2ULJ9maaICKg73SRxC4RLTwlO8+S7gGj5HpeE3zd+BCTJpL3b0Ngpd8GgpJ7RP81o
         qaePPj0xNmU089/ru/j7SUdla0zCjb0sBMxJhPEsuPVWd1LKcnYdWG2u2qohlX79lHRX
         wg7w==
X-Gm-Message-State: AOJu0YyGFXJfXoxlIsBAeyid6/wndFlQd/sPDEzcVRPdTnGOlR+c7ry3
	KaO+WB03zYeHv3QLISuHivFKEVVwxkcQ30NUWILl6SvVyFzKE0GW9IEiedtbR7A=
X-Google-Smtp-Source: AGHT+IHyH7tZQn6XRBtI3GwRcgpqypaFk9N8hQp+j3wV/AnV3ciPkuFOkeCLW7VmKjk2ZCUCROydyA==
X-Received: by 2002:a05:6512:692:b0:52c:a88b:9992 with SMTP id 2adb3069b0e04-52ca88b9a22mr6933243e87.52.1718615747038;
        Mon, 17 Jun 2024 02:15:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad221sm11494243f8f.58.2024.06.17.02.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:15:45 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:15:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <Zm_-vk5heG6rkZEf@nanopsycho.orion>
References: <20240612170851.1004604-1-jiri@resnulli.us>
 <CAL+tcoARbB=xBqsxQJ6PWbCcHUgpFhoXBq0BAJHrKc0+1NNcvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoARbB=xBqsxQJ6PWbCcHUgpFhoXBq0BAJHrKc0+1NNcvA@mail.gmail.com>

Fri, Jun 14, 2024 at 11:54:04AM CEST, kerneljasonxing@gmail.com wrote:
>Hello Jiri,
>
>On Thu, Jun 13, 2024 at 1:08 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Add support for Byte Queue Limits (BQL).
>>
>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> running in background. Netperf TCP_RR results:
>>
>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>
>I cannot get such a huge improvement when I was doing multiple tests
>between two VMs. I'm pretty sure the BQL feature is working, but the
>numbers look the same with/without BQL.
>
>VM 1 (client):
>16 cpus, x86_64, 4 queues, the latest net-next kernel with/without
>this patch, pfifo_fast, napi_tx=true, napi_weight=128
>
>VM 2 (server):
>16 cpus, aarch64, 4 queues, the latest net-next kernel without this
>patch, pfifo_fast
>
>What the 'ping' command shows to me between two VMs is : rtt
>min/avg/max/mdev = 0.233/0.257/0.300/0.024 ms
>
>I started 50 netperfs to communicate the other side with the following command:
>#!/bin/bash
>
>for i in $(seq 5000 5050);
>do
>netperf -p $i -H [ip addr] -l 60 -t TCP_RR -- -r 64,64 > /dev/null 2>&1 &
>done
>
>The results are around 30423.62 txkB/s. If I remove '-r 64 64', they
>are still the same/similar.

You have to stress the line by parallel TCP_STREAM instances (50 in my
case). For consistent results, use -p portnum,locport to specify the
local port.

Then run TCP_RR, also use -p portnum,locport to specify the local port.

Also, double check the CONFIG_BQL=y is set.


>
>Am I missing something?
>
>Thanks,
>Jason

