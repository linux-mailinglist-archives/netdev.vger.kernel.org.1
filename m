Return-Path: <netdev+bounces-196062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B819AD35F7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3187A252E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62928FFEB;
	Tue, 10 Jun 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CqlhZdvz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194528DB50
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558067; cv=none; b=lbFi+k6SZobovfPMdgYT7+TZ9ChYvnUWVr1x4RR5UdfXRj7pFAYiQXr3lGFrSdXJpRpvu9j2nNDSSFraExQjKYuaO4R/f/vmclO06BRYtGZxnf+89URIrxtfBbErVmnUTRlT8HoBUhWNYrSZWwjE3r6JB2y3M2Z5UQwvbQZBiiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558067; c=relaxed/simple;
	bh=u0j01G9fvtcien2pLULX5dEIhNEOfJHSJYRvt2F1akk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dacRusbn8/JtLrU7pWE/9do+3urP8S/+b3plpVQo/gCX5KhfbdX4McKKyemwp5HQR/VZlY3zofWzvq7A0ky5QMryr/f+PsfU/LeVWLhN8l01etioWUUxy635wNvwDBs+IaZAOGRW6dBb7K7SRQyujSZD5gfYEDtIAFkkKAIeg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CqlhZdvz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5534f3722caso6134539e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558063; x=1750162863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwioawj3LoM8t1kN/tzjpsLzY0VIcc0CS1zTnNXsK2E=;
        b=CqlhZdvzH87XBMgS5iqNtKez9C3mWBH3bERbsleFOM39zNy8QZulsqyhu8Ig5f2qFY
         rWvwkgjQJLE/FqcsPSKJRz+6Nqq7aqr/FP/RneLwKAIyKVsJJn74jWx/qZPK2R4QHAiK
         ehxRz49j3RAEdiKGTdSDQnNc94aVvvG/gbH9gq3dILnZD6TVuwOpQ9aN6mSFLRVwimHx
         GL8tCBNv94mD4/UHKjf2XT9Eb4H3evQjA70bgQ0Qe0ani9NLRZqMzmn4lvrlHS2IJbRp
         t+G1tthroJy4d8c+zoAwJiR667daEuGL1Try9lslisWxPArehN0HqvPvOC+raCkeqavY
         +7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558063; x=1750162863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwioawj3LoM8t1kN/tzjpsLzY0VIcc0CS1zTnNXsK2E=;
        b=mcoMzgmSknh3IXZA8QsR6YR4QBO7WsRy5ukK/0qGQ7kgudKbr1IytiOeCkKwKE+1Ev
         Aq/GftN0CwqYDFXPb1OLluhjhygLDoGHluznz+XZjHvJukaD2sByYHdE9ZmL0AYEpSt9
         /H0x2GvE5th3HGccw7NwPU90wqzQqGSUOlN1leUSDNesdZGAiPyY2Jwddm9vJV1KjWTJ
         tfmOWVW6GmIxRKA5AzbT2wCbltLO1A0gFciOR22BhhFmzN014p//OSVWKYVSbmQ7GxIM
         EqTcE34ijJ7p+RCxpqN8w0a2vOoO8DNL6H9LvUE0thbhEWiDowO3YjlpymRG6m910ttG
         h7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWQWTnCQPDbARhfVKXrSc8Vb11ShOlgtIj+gV+LfgPeJ5yQJ5QWUHxVFdWtF4T3T+qJ06E2Q0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bEm72JpbAhY7O1H4ev/+3dDe4qZH4M5mSuz1OFHJWyN5vP3q
	X7QDqbWoSG4NE7XCfu7Z4pzA6Cvkz8PCs5ehwPgX+upH8CY/00UVmZkVQwjDF81cQfE=
X-Gm-Gg: ASbGncvm5DlkO3DGXfFJLEArZFvlo+XGwTVCKo2xB5ig38C987FJ1i2uJ2nYClbJ6+R
	PImF/2LRGwek/Pv5Wd9hE2aQQ8i/J9pLYhyDkWWShMIqpd1HJyRLFVtLsKd93ewJd2hTikTiWIE
	bFL7f6RDvQicU4UfaOZbgGQEUqdfq/4QDiNE9XxCZ0cF4jbWEKPPtE71qXqGPnr4ocYjGaFBgsM
	70+MbRLXKk2EbCj+629/BDrdb0rL83lc5pKN0h84POlQBjT1Lc4zAGRIsP8+RGh/Lu4xYnJLq1s
	KMlK2RmWHOp0/A/c+7olwiitEPm1m0ca1zJljpU5anpV21JhnzkR2gg8uUW1c+RQtjqttevqScy
	/YCFf+I2lut2dhGArawzkTfwwgNJQhYk=
X-Google-Smtp-Source: AGHT+IEspqSQo2l6BoJsMZshtR+Z6E87KKc2jCvflDBVZfWYLnYP+yI6/3Yx/J8lMpyaxw9s1GFUHw==
X-Received: by 2002:a05:6512:1248:b0:553:32f3:7ec0 with SMTP id 2adb3069b0e04-55366bd0d03mr4190897e87.9.1749558063127;
        Tue, 10 Jun 2025 05:21:03 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553677330c8sm1527573e87.238.2025.06.10.05.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:02 -0700 (PDT)
Message-ID: <2b1350f3-ac60-42d6-b647-251d040a36a6@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/4] ip: ip_common: Drop
 ipstats_stat_desc_xstats::inner_max
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <b1514e637ec85b85fb76360c29573a4d9dc15dbf.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b1514e637ec85b85fb76360c29573a4d9dc15dbf.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> After the previous patch, this field is not read anymore. Drop it.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   ip/ip_common.h     | 1 -
>   ip/iplink_bond.c   | 2 --
>   ip/iplink_bridge.c | 4 ----
>   3 files changed, 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

