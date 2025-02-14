Return-Path: <netdev+bounces-166490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE26A36259
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C513A22FF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4789267387;
	Fri, 14 Feb 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fahawTC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A3267383
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548350; cv=none; b=k97MeRxeRc+OvA+C9+5lOyURfrvQCOE5KvHqy9BgzT2tzlqus0GdVMZ7RPRfDOTjn0334fgP7JnkOD4igTke/9ANM/IT9tN1PjNYuGq9rwx4oduZKb9HoqM+HgfPbsgoYO8CMDdR/5TT+weR7jTL6NJcpjPJZxfIL5T4lcJQUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548350; c=relaxed/simple;
	bh=XV7RWNxqz2JtrAix1tJBxjzLRk2Aqkz0rONk4zwOU4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKp04ey/8TUmiKE5R2lpxNpCB4NzzIxyx7ejCRAZGXOZ9E03ClbiSlvBEykMT2cH7Pwn/42fcLYx2rOsmFLFYP1j1NdGCFktH1XAFx5d0txUBh86qMON8h0ipz01SQLghTvx2qjz6lW8uRODsT3V6zejlOl4CyuKucnTQgBMntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fahawTC/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso3572768a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739548348; x=1740153148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2EbIYC0uVzNCy7iTVx+Dy809rdJPatzogkVI08UHyk=;
        b=fahawTC/R0jojmxMvKRyyjXnPM4oUtQvHGgpqjfepoX/TpoxqYCgKDADKRY2FJpk8l
         UkBOfWOExfpASTOOG8B86HdG7X0JsMsUYwzX8IqVFxf/uBUaGqZMzFYbJjJmrCei1IR6
         qh40CsrnJ7f640/FqBPYRU72YoDlDuClO9SgAHDxgPAP2BTvNmB0LheXABhEZyCTtHLb
         vZsb1Ho6eWgyGJtzw5C6bk8wCM+d/6m9VoYar8sT+mYyZ8MM1u27JovlvrHaptZrYdwi
         Cz83hQ7GAm3YfZLsWYJ0WXDL07tztWiQt5nRUEtkk4b4tI29q2eGAZciIGWA8Db9+I/t
         t6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548348; x=1740153148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2EbIYC0uVzNCy7iTVx+Dy809rdJPatzogkVI08UHyk=;
        b=b+As1aEgXV1U6ORg9g92OQ2bD0SQzIxMvhTq631Oc4YJ0zc2L+Kht+hr2oKfkRPOUA
         fQltK+rAeHVfl8xLxdioOBLg0/R8XrvQCOOXCnEeL08K0ycSWexj/tdnv4IEcNnu4Iiq
         sJx2TWOKGSVujbfb+FQhmPoLoECEXDrTuHGzrGDCPD3hnuv+0E9tRUvKtkGcqPBBrlUN
         mv4PgtyJTOWy0UoZopVroD620Az+4W5Fa27mpW8ZKXA1EjXGtpgJnl3UQj1eMLuJTRQ+
         vu6S0Q6fkibM+VQRclRZoJahyK3+h9MyH9hguGdpli9j2/kqHhUceTXZq+YICxcbf5hE
         I6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWcFnUpEmP4AXTEpfpVlBELX70e1IeF9NslpWsjERcCuMDBFF5Q+lfF8o2ym62esLDKWBMB1Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCrmPFJ13zNWZKravnTkqE8eVf6bUaPKoK4QIkZUVzBGid+US
	ZM71/r4PYiuxx+C9Y/PNpHeXV1OccBVGWnGVjhxttIzeBqe+3O7Rdf237HHvByc=
X-Gm-Gg: ASbGncumiipti/RNZxXwr4sKS5ycBNvCePLpD7DgY5MGj7bi4O3ENAIfoA5i1JxuatP
	FFgxaCvmQAKw6XYUaCl0sIopmGVyk907R0alzDE2ZWY/NS/5LkMtL0x0jUO/5uF+787ohmbWkg+
	7hY98h+EJS/RojwVaAuYFnOj+j0d5DPDpm9IwPgFX5jBiBzMNByaVZ/CEDM17Khf9H4I2FyUAM4
	HXfMrlE24LjAdInpqpQ46485rdK1Ypcvj4SHwJ1ki3rWoKrUZGdAhIhwNG2cJ7UX60mUhgZgpvu
	yTi8cV7G1JLHeB6u/vNjr815R5qLs+K7tDdXs5vwKr2sAwsGj2cQ3Q==
X-Google-Smtp-Source: AGHT+IHI/9edEZ6v8VD549f9R04P+ORdW1u/DMbgiKYp1XqYeJmHgWxiAjXV5XwLrbJoSGkgLLoxQQ==
X-Received: by 2002:a17:90b:288c:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-2fc0fa66b82mr11914353a91.17.1739548348126;
        Fri, 14 Feb 2025 07:52:28 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::6:902a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b602sm5360490a91.35.2025.02.14.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:52:27 -0800 (PST)
Message-ID: <2d3c2e58-914e-4151-a914-044ddc05ec9c@davidwei.uk>
Date: Fri, 14 Feb 2025 07:52:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/11] io_uring/zcrx: add selftest
Content-Language: en-GB
To: lizetao <lizetao1@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20250212185859.3509616-1-dw@davidwei.uk>
 <20250212185859.3509616-12-dw@davidwei.uk>
 <81bc32eee1b1406883fb330efa341621@huawei.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <81bc32eee1b1406883fb330efa341621@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-02-13 19:27, lizetao wrote:
> Hi,
> 
>> -----Original Message-----
>> From: David Wei <dw@davidwei.uk>
>> Sent: Thursday, February 13, 2025 2:58 AM
>> To: io-uring@vger.kernel.org; netdev@vger.kernel.org
>> Cc: Jens Axboe <axboe@kernel.dk>; Pavel Begunkov
>> <asml.silence@gmail.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jesper Dangaard Brouer <hawk@kernel.org>; David
>> Ahern <dsahern@kernel.org>; Mina Almasry <almasrymina@google.com>;
>> Stanislav Fomichev <stfomichev@gmail.com>; Joe Damato
>> <jdamato@fastly.com>; Pedro Tammela <pctammela@mojatatu.com>
>> Subject: [PATCH net-next v13 11/11] io_uring/zcrx: add selftest
>>
>> Add a selftest for io_uring zero copy Rx. This test cannot run locally and
>> requires a remote host to be configured in net.config. The remote host must
>> have hardware support for zero copy Rx as listed in the documentation page.
>> The test will restore the NIC config back to before the test and is idempotent.
>>
>> liburing is required to compile the test and be installed on the remote host
>> running the test.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  .../selftests/drivers/net/hw/.gitignore       |   2 +
>>  .../testing/selftests/drivers/net/hw/Makefile |   5 +
>>  .../selftests/drivers/net/hw/iou-zcrx.c       | 426 ++++++++++++++++++
>>  .../selftests/drivers/net/hw/iou-zcrx.py      |  64 +++
>>  4 files changed, 497 insertions(+)
>>  create mode 100644 tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>>  create mode 100755 tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore
>> b/tools/testing/selftests/drivers/net/hw/.gitignore
>> index e9fe6ede681a..6942bf575497 100644
>> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
>> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
>> @@ -1 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only iou-zcrx
>>  ncdevmem
>> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile
>> b/tools/testing/selftests/drivers/net/hw/Makefile
>> index 21ba64ce1e34..7efc47c89463 100644
>> --- a/tools/testing/selftests/drivers/net/hw/Makefile
>> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
>> @@ -1,5 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>>
>> +TEST_GEN_FILES = iou-zcrx
>> +
>>  TEST_PROGS = \
>>  	csum.py \
>>  	devlink_port_split.py \
>> @@ -10,6 +12,7 @@ TEST_PROGS = \
>>  	ethtool_rmon.sh \
>>  	hw_stats_l3.sh \
>>  	hw_stats_l3_gre.sh \
>> +	iou-zcrx.py \
>>  	loopback.sh \
>>  	nic_link_layer.py \
>>  	nic_performance.py \
>> @@ -38,3 +41,5 @@ include ../../../lib.mk  # YNL build  YNL_GENS := ethtool
>> netdev  include ../../../net/ynl.mk
>> +
>> +$(OUTPUT)/iou-zcrx: LDLIBS += -luring
>> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>> b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>> new file mode 100644
>> index 000000000000..010c261d2132
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>> @@ -0,0 +1,426 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <error.h>
>> +#include <fcntl.h>
>> +#include <limits.h>
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +
>> +#include <arpa/inet.h>
>> +#include <linux/errqueue.h>
>> +#include <linux/if_packet.h>
>> +#include <linux/ipv6.h>
>> +#include <linux/socket.h>
>> +#include <linux/sockios.h>
>> +#include <net/ethernet.h>
>> +#include <net/if.h>
>> +#include <netinet/in.h>
>> +#include <netinet/ip.h>
>> +#include <netinet/ip6.h>
>> +#include <netinet/tcp.h>
>> +#include <netinet/udp.h>
>> +#include <sys/epoll.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +#include <sys/resource.h>
>> +#include <sys/socket.h>
>> +#include <sys/stat.h>
>> +#include <sys/time.h>
>> +#include <sys/types.h>
>> +#include <sys/un.h>
>> +#include <sys/wait.h>
>> +
> 
> When I compiled this testcase, I got some errors:
> 
>   iou-zcrx.c:145:9: error: variable ‘region_reg’ has initializer but incomplete type
>   iou-zcrx.c:148:12: error: ‘IORING_MEM_REGION_TYPE_USER’ undeclared (first use in this function)
>   ...
> 
> It seems that the linux/io_uring.h should be included here.
> 
> Also, after include this header file, some errors still exist. 
> 
>   iou-zcrx.c:(.text+0x5f0): undefined reference to `io_uring_register_ifq'
> 
> It is caused because io_uring_register_ifq symbol was not exported in liburing.

Yes there is a circular dependency here. This selftest depends on not
yet merged liburing changes, which can't be merged until the io_uring
kernel changes are merged. Which can't be done without a test...

We have two options: merge io_uring (this patchset), liburing, then
selftest. Or, merge this patchset followed by liburing and accept that
the test cannot be compiled until the latter is in.

> 
> Finally some warnings should also be fixed:
> 
>   iou-zcrx.c:288:17: warning: passing argument 2 of ‘bind’ from incompatible pointer type
>   iou-zcrx.c:326:18: warning: passing argument 2 of ‘connect’ from incompatible pointer type

I'll get this fixed.

> 
>> +#include <liburing.h>
> 
> ---
> Li Zetao

