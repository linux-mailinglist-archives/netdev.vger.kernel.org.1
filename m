Return-Path: <netdev+bounces-219621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA6B425F7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B251890079
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C3286D7B;
	Wed,  3 Sep 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3y67Mlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9A2405F8
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914668; cv=none; b=kUYY/G9VMxQAbkAu1RXVK8ox/w3lTulSaMCvTqKqTAYDlfdv6EAugkqSV1QOjLNVYlbn9xStHsdi4I5LlAUNdT35NqG1TR3BlyUxIKSGRfgU0DQcXYQZJQZ1hXlc1+o4Y2A2PYpVjpkav6yBcpvVsr8dae9zGcX19Pe6JR67zcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914668; c=relaxed/simple;
	bh=e0JHaBP8/GVFYEwhAJPRax04g5O5lWewA8BXZ8PnRM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc63qPv9igjzLaOyRuGCC8o9fhoKTw49CgaU5g62BIIGIjnxHyeh718zrwWaZAtPgbpM57mlgizvW19za+B3ALVJSgUG9mvlGgjO77dURA0l60eyLGXbJ840Nt2eWcUdBk2hAgTbX5RB+4bJ9A+XEyHz9mxRkpLxVta0kHDIaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3y67Mlb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-720f0dd2809so11135266d6.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756914665; x=1757519465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YoHnX0hblFct0Koft9iwqKNnoFVZeTTlcteszDq+zc=;
        b=I3y67MlbHrs/Hb9GMOp3zQsSdycQeRjTaUnahT705Xvz91jVBBbxHGrbzzBoc91lmp
         ipcPvw0wq4ebAEWg24AApQhAXU6q7UUVf+AYBo0q1kJwRzKB4tysoorx79xb7LVeRC74
         fjrSej9u2jMnVfCTnTm0WM5zthb1642+5MYSYBTlbz7CABdVEslawMmRSu4gb+aeoAjm
         AlhKxJ2IisxlV5MRqGXz35VSgPrQXEM9athftKd/T9QbUc3Rs6MqlHvHiRUePX4YA7GV
         dvrBnmeablTrUICYNto4DO6VMsA+eoIUTJdplwPuG1oncXZUIEXDDEWDCqvDH3f5SCzB
         lRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914665; x=1757519465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YoHnX0hblFct0Koft9iwqKNnoFVZeTTlcteszDq+zc=;
        b=PRw3znNguR9AQyQkqn/jf/5jUy5WKMsObRADtWhoGaxrCgZh/fRoNFGUVaTwOCdLwm
         JrKwI7L7aNpGZNaiTYnBB++jFwL7SVPVmalHNsVMAiwhLcBaYiwfwI5+WEIRpdmjv/5h
         fZwvMrQxBa8UmD2ougwGK+e8SC1xTBvzHMstHaaiDJDBmWtWsdk8hkEeAFDob3N0y8t7
         Jk0PKFs1Nd4zhOjZJZQ1+WrBUgMCnwP9l2jzN2iOis0/EgzIGRhZTStEbPQSBn2Cw1vy
         bPSjgYSqbA3O/Xrfe9pN70w30RM5qs5RofNZ8zGeWlzg6Z92RL+RIZkaSPiGtzEkkx71
         /y7g==
X-Forwarded-Encrypted: i=1; AJvYcCWjY93218NFU9gG+Ul+2k25yzW5rX3YyyXdqfa1uG5ieNLrx5wIqL5WGvV5g/YmgJKI1/OnqiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhAsLDAIn3m1iwN2PCc0/Rf+a3GmEP438ojgvz4Y145zQoDxHs
	PRY854qleBLr8LuuxYr/Oup+diIyvnpF4IxYRebT0fz1vbcRmkNPg2sH
X-Gm-Gg: ASbGnctA6Fpch8ToA3WyU4qpZ+3pY4bAnEKE1pPjdXAmfLZANUJ4UpTTaY91dFpAomO
	hJp8kbXhs1V8arm17Ee7VbZdoiWwjG+pgp2Fp1qsqQMK/OeStRtYvNQp9Wv8Bdnd3HviLojI+NP
	UCo+nA1JQ5TPYwWQViOP+NilOnbMVKPcvxqh2wooHNTWcOkNK56DXyjNdkf+2pmMu8aZtZyKsHS
	xs1y9JJuGI4vhd2vtA6mmYxg8AV2JwJhkv1iJOf/AajKxl0/zjvCv7tpMSWvlcnfps7JuKdk9qY
	kdQ8NG6YEZAjw6YGg9xXiQCUvZa8ncQ2VHoN7eKS5LFbK07uAB7O6WHoAZmNyQfVz8up7jv5ZkA
	PtmeRidWdW8ke1Opwe5EwMXQHdJuBJDdC6VhL2rjoOxT/PPvKrPfA0Q==
X-Google-Smtp-Source: AGHT+IG77Q2fx7264wuU0FDvLpt59gGCsHgQIRieiDCdL4yj2Vv+vo2LUAaCjYFD6q1o4rxYbOl9CA==
X-Received: by 2002:a05:6214:501b:b0:726:a561:87ca with SMTP id 6a1803df08f44-726a5802428mr21645416d6.58.1756914665528;
        Wed, 03 Sep 2025 08:51:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:6a18:1fad:946c:1c48? ([2620:10d:c091:500::1:90f4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm30694866d6.65.2025.09.03.08.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:51:04 -0700 (PDT)
Message-ID: <13540207-c99e-408b-a116-2a34825f7e10@gmail.com>
Date: Wed, 3 Sep 2025 11:51:03 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/19] add basic PSP encryption for TCP
 connections
To: Saeed Mahameed <saeed@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <aLdIUZbwF83DbUiv@x130>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <aLdIUZbwF83DbUiv@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/2/25 3:41 PM, Saeed Mahameed wrote:
> On 28 Aug 09:29, Daniel Zahka wrote:
>> .../mellanox/mlx5/core/en_accel/psp.c | 195 +++++
>> .../mellanox/mlx5/core/en_accel/psp.h         |  49 ++
>> .../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
>> .../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
>> .../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++
>
> A bit too much control path files, psp_offload.c holds only two level
> functions for key management and rotation, while psp_fs is.c 
> implementing the flow steering part and psp.c is the netdev API facing 
> implementation,
> do we really need three files ? You can sparate the logic inside one file
> by bottom up design rather than 3 split files.
> psp is a well defined protocol, I don't expect it to scale larger than a
> 1-2k lines of code in mlx5, so let's keep it simple, just consolidate all
> files into one en_accel/psp.{c,h} and leave rxtx.c data path separate.
>
> Also As Jakub pointed out on V7, mlx5_ifc changes need to be separated 
> into
> own patch, "net/mlx5e: Support PSP offload functionality" need to 
> split at
> the point where we cache ps caps on driver load, so main.c and 
> mlx5_if.c in
> that patch have to go into own patch and then pulled into mlx5-next 
> branch
> to avoid any conflict. Let me know if you need any assistance.
>
>
>> .../mellanox/mlx5/core/en_accel/psp_rxtx.c | 200 +++++
>> .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 121 +++
>> .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
>> .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  49 +-
>> .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
>> drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
>> .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
>> .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
>> .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
>

Hello Saeed,
I want confirm that I understand the ask here. So, I will consolidate 
all of:

.../mellanox/mlx5/core/en_accel/psp.c | 195 +++++
.../mellanox/mlx5/core/en_accel/psp.h |  49 ++
.../mellanox/mlx5/core/en_accel/psp_fs.c | 736 ++++++++++++++++++
.../mellanox/mlx5/core/en_accel/psp_fs.h |  30 +
.../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++

into en_accel/psp.[ch]. And then for the ifc changes, I will rebase 
after your PR is merged. And then no action is needed beyond that on the 
other files. Is that right?

