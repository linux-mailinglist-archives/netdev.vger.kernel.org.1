Return-Path: <netdev+bounces-225680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7CFB96C4C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2FE178B96
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07142FD1C2;
	Tue, 23 Sep 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="k6rLD0Jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A712EACEE
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643983; cv=none; b=JecgqtRLUaze00lw6Zvh1JxK5IulQtAO69qfJALxRn28+6dNP/oYK3a3uJgI7r3bMkcmoYJ9l2UAFlJObEowAFHT4f6vsCUm38J1fF1JZp/95ZPCwzJyjCdOyynAmIhKqLbgJZeLVXLarc9SI+Kntl4p1LPkvX5RxVESGJ/d/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643983; c=relaxed/simple;
	bh=OYyeA46rSCN1K1jiMKJz6BTJCzHtkaWIOI0UDQjqLqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJr/Cww1lzAIgvb83vLOBE685ynzxqlLSSDHA5fMklr7dz07r9CfALBy53wERos2HGlEs5yrpSM7iQbyj9HNxH5GZAw3kCy4Dtw6NRi4pGUfuZPD0ckqu+wmPtsfk58nJovBteFgnqslFxXUH4BcA2CvMtPxR+3F0pCPAZ1RdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=k6rLD0Jg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26d0fbe238bso33557215ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643981; x=1759248781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfnPVSIhj4SwRPe2fDLCwwGn25F8/7TZaQuIesUJWuU=;
        b=k6rLD0JgZJEBiLAlobdF6rT3aQHDWQGQGqKh9kqUANGmygAgInAbBuscjbwJUas+es
         bN9YN/VEk8oEbXSMce88HqCA1vfeVIJmJQ3svSenyVzOLoQaYpq+xNRZEXjGJfY7NdRg
         WEBRCuTwd1Sve+dUBnoDxiKmAPllIQN9hmaj/WFbixLjB3SPiF+b6fULIOuaCyGzbpgM
         AqeP3b/51L4Q19xx6VId6yQn9mEzJGKLAzZa0PPDNxrvy9f/TSJFGrMs3uUUvziB3n0x
         fjxXLkdaD0GQ5oE0fSRG+LD5Q9QdRU5mt+nAxXTMpj86ZbbYsO2BFQ6PkuB4Yuc0cUEb
         PZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643981; x=1759248781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfnPVSIhj4SwRPe2fDLCwwGn25F8/7TZaQuIesUJWuU=;
        b=Jac9UU25dKj93c9EPLSt4C2ssjM9EJtSi22XmA1Twto3elKnfH31oVUoUcGukafrMv
         8ynhfLoUz/yO22D5zChzwg6AhHMS/u0g94fuVjf+CXzxi1GzXZpx2lyi2LkHhAtXnkHG
         vRO4aoTq6Ie+8oNpL4k5/UWoLvwPF5PCt4QzFhFgyNKSp+BLdhNy6K0pCDpwWLhw/OMo
         pPHFeCmuB3wdJxHGZswbsGQgLlC3J0MPb874cw5YiFJc0vvAKGUOohdV2bLfaPi8NeNL
         l86ePnaTYQTNPAmFrJ+SwCDzqm0aA4cOFBD5wDSy4qrX18+n/QHUVjewUnX9JOZzlZrl
         QCNw==
X-Gm-Message-State: AOJu0YzRGAg//ZouVmn7Rvw6ZIxUvPhm8FEaKdkv53WvMy4xHNFKMhdw
	dR9MiPibkHEQnTKsDFW03LQLhmDYT1RtSlLq/FXEbyqRLf/24AG4xT6VJGbRn0Po2q4=
X-Gm-Gg: ASbGncuyZXZYYQ5w00L8lNtN9Xvi86+qUBctei+yy0i+OWpIVlYJ9/Lz9Z8MmOLbeVR
	mfKszGYt6xVjyEgm0mJI3rHuO8Fnx3WUDlE2Zts5RqPhVrNTGm0WubMbzFG8T1eZooOGxwPfwD2
	ux3RbiRScuoe0SwpgWqZiIBswhQqJhMXuHgSWeeY4sOFhxlivlV7wz7TPo76jrn5I8k7QNZ2vRU
	9R3Ubi1h7J17czkOEgwogiMdLaVyGflWSgeYNuacuTtiHOBpVg/AUFjOxMkT3/n7dC5YSPeJ/Yq
	OR0G3N2nbt1+57tqRLRka0WEMMzPZ6qz9NQGQfGRG3Zy1YhD1qwbs5BXqD4WTAFPtTCoT2UtLsz
	H1/LZ5tBB7ZriMU1LNqbey0V4UGklo12A+xyxIa6nANQANbUPirz5L6FW5j48f/h+
X-Google-Smtp-Source: AGHT+IFWdxKMRkCe6/ykTYOrIxuKs/iiJgu0t2WDMo8y2oxE6vXpur1FEkfQ7hTRg4i+K4AWPkymmw==
X-Received: by 2002:a17:902:d607:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-27cc2aac8f0mr29493405ad.20.1758643981385;
        Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698034168csm162819225ad.135.2025.09.23.09.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
Message-ID: <9b75c782-90d6-41bc-8b8f-9067ffc7a3d2@davidwei.uk>
Date: Tue, 23 Sep 2025 09:12:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 20/20] tools, ynl: Add queue binding ynl sample
 application
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-21-daniel@iogearbox.net> <aNGCyWRneDXiUWjv@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aNGCyWRneDXiUWjv@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 10:09, Stanislav Fomichev wrote:
> On 09/19, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add a ynl sample application that calls bind-queue to bind a real rxq
>> to a mapped rxq in a virtual netdev.
> 
> Any reason ynl python cli is not enough? Can we use it instead and update the
> respective instructions (example) in patch 19?

Easier and more portable for my testing to move this binary around
for... reasons. Happy to drop and use Python in v2.

