Return-Path: <netdev+bounces-106761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E691790A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7AC2836FD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC015666D;
	Wed, 26 Jun 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="gnrLYrUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A942156668
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383618; cv=none; b=oAXGUt08vCfFBL0WFiWiY96jpa2/1R344LOhGyZr63ElhTMkjSyjpfYlh730zBOe3H7xBZboFRAwwcvLenifTdboZXag2lgzj0BPcu6HjXodXFc2RAbryKrQwvnQ1JsToW/xhGMgGGtVdmqOa6MN7eDLoZluy2w0WA9r/W+wOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383618; c=relaxed/simple;
	bh=h3AOWhGm51EJyTtFmi/RWYKBkUOmaXHktgylVLoRMA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLRYIjxe2yU3r4VnTkRH59xXjGa0JMaj5yi1oNx3RemU2u/+Q1LJczak8h2CelRPcwF5TmWX4NC9JSsyPCnbt18jccOv0reWkdsFcHBDeTdrojPEL9l2WLeoFQomJwVoxZpDuK+idtC5VHpAOQQsUpUwbTHi7zqW/iDYAIXTaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=gnrLYrUS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d0699fd02so3511006a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719383614; x=1719988414; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov1fTsnNY8Lex6MZx7tXhDEISCKhkRi93FvZs6tGQ+A=;
        b=gnrLYrUS6Qb6RQ9UWi864kINKv+M3x8+pTh0vM9fZ3NvdtN6oe487ao30pEW4Dtz+d
         IvaqYHvJhs1vWWawxqnFnvQ8p45l2aNjXJ2pZu+vcNkP0WpMc/epjm5W5GChhFy1XFyN
         ochvvdULdE5zwJqyxVbWuZ6kuhlfOj8Kiot4rI0cnIUaFU2KL8+ozNlzSi/gl5rishSE
         Erdrqpwexm+NdyeAi2rZJF8/0oKn32gLbbDHJDqPKa8p42fznoF+8sfcEF6yzOY2bT3k
         bK6nUz1imsN+/zSTvBNYdRwZnyVl/momnp/0+bs0Ua6N6rynhw2f0vyNExvGMj0DnTEE
         pCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383614; x=1719988414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov1fTsnNY8Lex6MZx7tXhDEISCKhkRi93FvZs6tGQ+A=;
        b=ieAyd9CLW4p1j6ZTRGxwNFJxrhVcR/KW8TTp/oPB9PtbvTuW2bGBqUmBwxja0+zlOS
         gi9Vwv0tycPv1C27toNSs0g+i/pw/z6RIib+g8Z2UtCIs/qaE4/I01rPkl7tfkRyz4fP
         cdXHnrPQHhi3fbHUVQoVYVGVeLYrx2+ztRPi8bhY+VSfN/YuKkDKfoTIYVGlBMoxaZEG
         9LP2RzFmf+rXzcUWeTq85Bqca4ZrIV2QpvOPnHYbXXGteIQ9aLcWy66odjy9P0GC1Nd9
         5Z0X3mBtpsayQtzLTLiSh0KpszupRxNxvWx3IR2IlAVGNRJGaPV1Sf8lmMr18XDFZiMC
         f84w==
X-Forwarded-Encrypted: i=1; AJvYcCXBwVMVtLT7WdVFgMk2Qul9ATono0n+mRUmsA1QN0tod3hfIJNKjqee9JkdSMU1f+eKl1OAHXjwyCQgoCPSAKUjsX540s+j
X-Gm-Message-State: AOJu0YyzCMgBp0AtNd3bJ5RluXqAHQo6s2H1FXrPJtg6OScSVClFLwBG
	ACvKlmwrPbZS4bRheqFM+Wz/eSfpuCZCzMmvEMqr6yy3E3z6HPj3CpsoXKidh+RI5wGdqQZYYLS
	6
X-Google-Smtp-Source: AGHT+IGdcM+giWcwHgajzr0HcaLmfOGDPj6iQyy/PssHcuhIzjEQF2VNF/f0e1YwAEFo8/99kOGQhw==
X-Received: by 2002:a50:d6c1:0:b0:57c:57b3:8d0e with SMTP id 4fb4d7f45d1cf-57d4bd7276emr9503564a12.11.1719383613666;
        Tue, 25 Jun 2024 23:33:33 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725ddfcf04sm221267766b.20.2024.06.25.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:33:32 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, stephen@networkplumber.org,
 dsahern@kernel.org
Cc: liuhangbin@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 0/3] Multiple Spanning Tree (MST) Support
In-Reply-To: <14415e23-a478-4385-b556-851395717142@blackwall.org>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <14415e23-a478-4385-b556-851395717142@blackwall.org>
Date: Wed, 26 Jun 2024 08:33:31 +0200
Message-ID: <87sex0fc1w.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, jun 26, 2024 at 09:11, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 24/06/2024 16:00, Tobias Waldekranz wrote:
>> This series adds support for:
>> 
>> - Enabling MST on a bridge:
>> 
>>       ip link set dev <BR> type bridge mst_enable 1
>> 
>> - (Re)associating VLANs with an MSTI:
>> 
>>       bridge vlan global set dev <BR> vid <X> msti <Y>
>> 
>> - Setting the port state in a given MSTI:
>> 
>>       bridge mst set dev <PORT> msti <Y> state <Z>
>> 
>> - Listing the current port MST states:
>> 
>>       bridge mst show
>> 
>> NOTE: Multiple spanning tree support was added to Linux a couple of
>> years ago[1], but the corresponding iproute2 patches were never
>> posted. Mea culpa. Yesterday this was brought to my attention[2],
>> which is why you are seeing them today.
>> 
>> [1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
>> [2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/
>> 
>> v1 -> v2:
>> - Require exact match for "mst_enabled" bridge option (Liu)
>> 
>> Tobias Waldekranz (3):
>>   ip: bridge: add support for mst_enabled
>>   bridge: vlan: Add support for setting a VLANs MSTI
>>   bridge: mst: Add get/set support for MST states
>> 
>>  bridge/Makefile       |   2 +-
>>  bridge/br_common.h    |   1 +
>>  bridge/bridge.c       |   3 +-
>>  bridge/mst.c          | 262 ++++++++++++++++++++++++++++++++++++++++++
>>  bridge/vlan.c         |  13 +++
>>  ip/iplink_bridge.c    |  19 +++
>>  man/man8/bridge.8     |  66 ++++++++++-
>>  man/man8/ip-link.8.in |  14 +++
>>  8 files changed, 377 insertions(+), 3 deletions(-)
>>  create mode 100644 bridge/mst.c
>> 
>
> Thanks for posting these, I was also wondering what happened with iproute2 support.
> I had to do quick hacks to test my recent mst fixes and I almost missed this set,
> please CC bridge maintainers on such changes as well. 

Sorry about that, I'll make sure to remember it in the future.

Thanks for reviewing!

