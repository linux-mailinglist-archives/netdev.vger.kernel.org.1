Return-Path: <netdev+bounces-203697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45451AF6C93
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657361C20DBA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF522069F;
	Thu,  3 Jul 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHtGvT09"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1E142E73
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530544; cv=none; b=jCXQQGPiGg1VdKVwL+s1t8kDew8IrHpTuwuF1VGUKOVTUx1t/KVmI63PPSjhderaqEqCm5m3Hkkiks1Q3QrGOKQVmOM/2308TgNeIKHN0Is+SVSXkpPaCHU2EPSPPq7T/q0wnprruiiipIKVe7ieHCKN3rDjw/m7Hf7PK7V7Oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530544; c=relaxed/simple;
	bh=Y8EjxT4nutZwJyenL5L1UqFQP/0sHTkMsnQVidt7IFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjmAMAXohbX82BocEmE9WYL+auy6sD/SMU8wWdiQObuJge5x9TzK8EHrd6GKPsU7FINquVCkL7IjaHs0jT53vWpGZ332A+xVIEwXaLLdh8XuCvRctaWyShsrUEqokOH7P5kxioEflax71SuLTURyI8KAPVppoDYIJokJIu1f1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHtGvT09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751530541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ait+Rekj7OXXHfkR/oouMXwI4L0rS9W2yDZaIGO5xTg=;
	b=eHtGvT09E6eOEzCDYdGdyUeAUT9N0Z3AALuxz8UFoFnSr6vga/XhwslGeSbWFPc1kg1lwf
	JCUZVnPLp0LUYaz5Y/zbec26tvGAkPOWu9CUcIRISszd74TpZ57S4wlzUQLbzpCGgA5O2G
	LJ9g6wihxSbu75SSsKSS26ECfKPxSJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-YEkuWbk_N0OE-8aYWqaOQQ-1; Thu, 03 Jul 2025 04:15:40 -0400
X-MC-Unique: YEkuWbk_N0OE-8aYWqaOQQ-1
X-Mimecast-MFC-AGG-ID: YEkuWbk_N0OE-8aYWqaOQQ_1751530539
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d64026baso41894755e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530539; x=1752135339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ait+Rekj7OXXHfkR/oouMXwI4L0rS9W2yDZaIGO5xTg=;
        b=qDu4ZYgRWVtUw2gqrblTeteTwGbJb/ekgN9B40megnMHAboVtkQLUPd4cU95Rv3A8Y
         yzio+p9fumNNrOfWkHtsrrDBOpW7m7VOuhaT9cOKljFLA3V5/xjWrImWrbQBNz7+lLA6
         nGng4iLyi4lu8F4bRKSi4fX0zzhPqI5xClij9RLyL8AN0SRrwhOnb7q9xwTIrVhMTdbq
         KNDz5W0WCK5W+M0RJl3dGMgD6qkbI/UD3c1/gO1ffN+dm0sujozLAvo1I3FjsxXhByNM
         H5v+8I3Kd/C9DF/kSzUrJFgPJ5LM50o1O+X4rUSQUJX2lAspqT0z5olwtTsp/X/UXBIL
         NZSg==
X-Forwarded-Encrypted: i=1; AJvYcCXHpfbB6YPQAlTETuAY+KyXR86viJmGaD1CApUOu/NWCtYWvw9wUxHT3kgOQZxr5zKsL9mumpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqn2E7evOPIF8PbB8gDdp1YFOoEecp8JaPaTaSZkjoZpnJA1d
	qJhBq1sfPc7oYJpyrQtbQQGN8HrwBBmWFbIsJ/1QMpDIH9O/CT6b0dma3uKYDb7UgvHA4ft3IjU
	ZM0tlLnGs5nvT8izu5XhcvsJJPf+GQOYizTLMYcg/jjuDDNAAUTTzH0hUOA==
X-Gm-Gg: ASbGncuVYMxFnR1R+xp4Q8kxdaZGtJ7ttRMBWPqIiK6bpmCVfX9s+gekZ5A5LWJBfUr
	ocy9L3RqQ55Xnha6QpqgJaVXfex1oJ/9L6t5QTzke1MWyu/9LcFoCUA6dZPedlLdRgTjuMqQgIo
	HfdUrtIErWqG4IjKo+axm3WbqPAhqLG5RfczWmLYTZJn3rO9tQzvTpNDTMUCX8hjHL5CaqU/eJA
	CDi0Ynhyerf3of8wtWjvKw5jvZhnDp4Q6BZ/YPMC1rcMTaNUUpAO+B8HJbeo8qfThuv/i29hlWt
	/HI6LmVrNCRDGM9yFhAWW/RXS+XVhF+iTaw0j7gZ3aOu/d4vyW1FHcCcUsuEgzgiJh4=
X-Received: by 2002:a05:6000:25c8:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b1fe0f0580mr4621292f8f.18.1751530539018;
        Thu, 03 Jul 2025 01:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSt7pnhVp94lzGN3AReJTKkrysYKdo+bIb8+FwO+KG9Cq16iqrorvhIOG5ldrDqrJ4A1P5Cw==
X-Received: by 2002:a05:6000:25c8:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b1fe0f0580mr4621248f8f.18.1751530538398;
        Thu, 03 Jul 2025 01:15:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9966919sm20211185e9.7.2025.07.03.01.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:15:37 -0700 (PDT)
Message-ID: <af16a28a-18b9-4d45-9ab9-1b150988b7d5@redhat.com>
Date: Thu, 3 Jul 2025 10:15:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250627110121.73228-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 1:01 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
> 
> The patch does the following things:
> - Add XDP_MAX_TX_BUDGET socket option.
> - Convert TX_BATCH_SIZE to tx_budget_spent.
> - Set tx_budget_spent to 32 by default in the initialization phase as a
>   per-socket granular control. 32 is also the min value for
>   tx_budget_spent.
> - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
> 
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
> 
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

LGTM, waiting a little more for an explicit an ack from XDP maintainers.

Side note: it could be useful to extend the xdp selftest to trigger the
new code path.

/P


