Return-Path: <netdev+bounces-147549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2909DA1BB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B6F2835DD
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A35B05E;
	Wed, 27 Nov 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="heJKQn3C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8628E8
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685798; cv=none; b=sRwlIFODg7Nni2Zb1zCxmdXPMM8XWFrXugkCatp+Wbi+Cx38cs6b54GyTGC3jcA3XDcMYAdWwWm5HiGcbu4PNUIdUBSWTzlQ6iIYG+Vbot7dslP2jLqohsTQukb9qBv30tTGfeEwlx+RUkn2p4An6UbbxudEJXancdi08PD+OYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685798; c=relaxed/simple;
	bh=75wCkoj/VVBRtfswy0/lvkY3JToTOY4IY3HrrQe2k+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmPR4IEcGqV4F4C3PBLULhqRGOF484Hk6GouCqg5Y+lmtbtHlbtigDw1JztdIi0duR3SbX+XjWTR5scKmG6eljy7ZaUfqmiPFkuke1KX3WoqHM7hkcD7ZuxwM8rq0cYxgFH+Lf3zX8lAU/lk7YY4jxt840KgmRCaCLTL14vWIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=heJKQn3C; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2edfd7b48b0so882740a91.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732685796; x=1733290596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fugBDWEYLhNNJqXKdLHebrVHnbrvwNiYdn4wHfJz06k=;
        b=heJKQn3CYdTimVadVzf9vnqwp0XyFecAhNjCz03CYIuJbmU+ozuL8KfJTKj3AEd8A9
         kx2Mbs1ar6lMhAUNLyeV99EJTvWta5CmHVzwjKHc9NeWBRXvCdvIqVqkoIqqcukIm51I
         suI1yH3qNTTWpT31SdJMayucvC+P5UFTkiWtOittxhMx+aaAm726glgiUYeunhvi0suq
         Bse7W0vuVug6lPvjLpRrUZ3Ja+C/eez8L9qfDVxKs3YSADzMPM8Qli8Bk/FBcFJwuDuZ
         eCfhy0UZEIEhgGLtZxjrhgqjqtSzV9hX4TWRh2f0VIIBOR8Tek7uPUF+b7j3veSPKZfl
         2qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732685796; x=1733290596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fugBDWEYLhNNJqXKdLHebrVHnbrvwNiYdn4wHfJz06k=;
        b=nZc4PRDArtaa/49/h3IBTvlUv8nEg7dMBXeTY7eJaAM6p2UjIhj9MxGo0rUV3c+SmU
         d7xAc12tcVOmvrmHBMomeyG0BxOwmSfwV5qjL5piKxeBnIPAsUiqSmwqf+fvGxsZ89zQ
         j/H4oMKiw705d4UjM3mdLybJw/ggFUZ38U2AuuwZB1jXsZ2WVaPDbw57MivMiJnTifgh
         9zJfKXh6V2EpjLyrZ/PhEoDJ+ymcw56N/1FlG55bM6YzRJ8vddFNurp/p9DCqSsNz52D
         7Q4QLFncoVWivm0xVxOSknJl5ZFhv6DWR8wbfyesoADPPVuLn2WoqN41WIkmNNpZmzcB
         Aoqw==
X-Gm-Message-State: AOJu0YyoTzMSK0q4EY4BojFV+FicEMX8dXM5wN3X7S9ys/3JW93gX8Lw
	QqTg4NfMNMTnm56ifLbBOVMRh5K0nTSF438o1f2Sh4MO4xcZA04nbkFVf32zzxJVECq0hPJ78BR
	3
X-Gm-Gg: ASbGncvPxC5DXolbpxJSkXpfkpRz9MwjPmGN0dVPTA55GeccgNIhn/9C78LEnvw2dyA
	zay5Va7krb5ChLX8WEOwJ8BVFLWu8IwHYbphiP8GSjUWhMEDoDVi2Gh+8/XCmbKKGjlmHqw/yhF
	L1lZA1mms9aDlcY8RaOb9lvBR2OXa07tTfyHJJNw1YwaUeez8S5miTT0RbFnLwtw+bEkCIiT571
	V+PvxBKqm52ODVFiPueQlOV9r+VBIa7d/CBV55mnB4MLKM0Xrw2p8YC
X-Google-Smtp-Source: AGHT+IEPGjZfy5tkggZzR/upR9aQU2ek5g7IvMQSi2NYEW5iJLQCvhsI1srZnIvgVeDiG4eRKAA5cw==
X-Received: by 2002:a17:90b:4a87:b0:2ea:3f34:f18e with SMTP id 98e67ed59e1d1-2ee095bffb4mr2157557a91.23.1732685795637;
        Tue, 26 Nov 2024 21:36:35 -0800 (PST)
Received: from [192.168.1.11] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fab7a11sm567024a91.47.2024.11.26.21.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 21:36:35 -0800 (PST)
Message-ID: <059ad0d0-db28-46ef-8f53-06bc2f2ce30c@davidwei.uk>
Date: Tue, 26 Nov 2024 21:36:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/3] bnxt_en: refactor tpa_info alloc/free into
 helpers
To: Somnath Kotur <somnath.kotur@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241125042412.2865764-1-dw@davidwei.uk>
 <20241125042412.2865764-2-dw@davidwei.uk>
 <CAOBf=mvEEHeLP4CF76b7ip2VHz82V+c23trCkVeArjP9iJ0sfg@mail.gmail.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAOBf=mvEEHeLP4CF76b7ip2VHz82V+c23trCkVeArjP9iJ0sfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-25 22:30, Somnath Kotur wrote:
> On Mon, Nov 25, 2024 at 9:54 AM David Wei <dw@davidwei.uk> wrote:
>>
>> Refactor bnxt_rx_ring_info->tpa_info operations into helpers that work
>> on a single tpa_info in prep for queue API using them.
>>
>> There are 2 pairs of operations:
>>
>> * bnxt_alloc_one_tpa_info()
>> * bnxt_free_one_tpa_info()
>>
>> These alloc/free the tpa_info array itself.
>>
>> * bnxt_alloc_one_tpa_info_data()
>> * bnxt_free_one_tpa_info_data()
>>
>> These alloc/free the frags stored in tpa_info array.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 148 ++++++++++++++--------
>>  1 file changed, 95 insertions(+), 53 deletions(-)
>>
...
>> @@ -3461,13 +3468,17 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
>>
>>  static void bnxt_free_rx_skbs(struct bnxt *bp)
>>  {
>> +       struct bnxt_rx_ring_info *rxr;
>>         int i;
>>
>>         if (!bp->rx_ring)
>>                 return;
>>
>> -       for (i = 0; i < bp->rx_nr_rings; i++)
>> -               bnxt_free_one_rx_ring_skbs(bp, i);
>> +       for (i = 0; i < bp->rx_nr_rings; i++) {
>> +               rxr = &bp->rx_ring[i];
>> +
>> +               bnxt_free_one_rx_ring_skbs(bp, rxr);
> Minor nit; Could avoid a declaration and an assignment here by
> directly calling this API with the 2nd param set to &bp->rx_ring[i] ?

Sounds good!

