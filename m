Return-Path: <netdev+bounces-137545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED999A6E19
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3924282DFA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D7136328;
	Mon, 21 Oct 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DP5o9aBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C533D68
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524483; cv=none; b=YAODWRMPl1PjxpLERZIoZvhfB3qykwd5oHZ8mmwezRpkP5JVLGONm2gjqYWerDdDV528F9Xg9WlG8NQqXzqxd5esQoB1kDkKJvZ3SpIyMow5jZWtkDqAEMjmgqFmJ86cyu0HiLpqMqe36veboh2mvbAefJEB3zPZfGx7gyZTklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524483; c=relaxed/simple;
	bh=nv2ti2VLDg35idg6XZbkZTZ7JN7/mw/x6VHeFJLQSwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPSROEmqL8F+ZXQeAn7SQOB8wekw2XNltF83w3RFYLoNgtegJ9FLdtGDf1gQrjduvRmmkYLDofbxXyGo6bAZ9zKGtEiQUnF49MwU5nFVRfjYlt8o+qq++Y9hrp5E10F5rGp+s/82HxMzkyzgTtN3BBMZFEpdk0a0n9uUhiY5pKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DP5o9aBW; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab6cbd8b1so156442239f.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729524480; x=1730129280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjWBqmqjt2x2Uv9XbFQatXnQGGyRKjtoeD2ucKh9A0s=;
        b=DP5o9aBWUiNS6wy3ojk6UdhcypMYfdtCXHL8pqyavtZF243vh44YeZn2B0Lj6QCu09
         NS5brzHqBWuQc1Bms3JAq/5jD+oK32UN44KO+3YZD9aYH6579mgHoVwSuhPG9lRO55Qa
         8sApUFkGd1zPZtUXrpbQCdKy33ejwt4RQTO0BvwkdgAml1Sey5BuZm5igugOo0/WhOdw
         FiayEUKTKOdcM9AThG9Xssv4FwQpZUH13gb6wW5nUiHagbp/eMn2YEvvxfInHPVAXN9E
         Xd76zkU45+Gsx8H9hzQsBa74f9VEbSVGSNkylS2S5nkXloTKPU71ULAMKZPHvRzrNnzi
         v89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524480; x=1730129280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjWBqmqjt2x2Uv9XbFQatXnQGGyRKjtoeD2ucKh9A0s=;
        b=t3YAlNWng6GCOv/WgEBN4D3Uu/B2zl1b6LV5qh8fhHnVoz3ra5O8IxXFUNv7vol3Zz
         9LnT9ejVKKTo7johpg+NAc3Vumo1R6fo4FXUW/Eky4cQpixC+9uegQyHtGYMEWCj70UP
         Mdg2o2OZkz0+me8PTB+CMDWz4gI8I4LxVCQo94KtAoKF6hAP23qg5KkZ0EJCMTzOtA+7
         SClyyVL6iUy+i2TzSigKWFAxliMhx1KjJL7NOnS+ITmJqE0hL4glVesYfA7u4d9Ri7dr
         Ngr+RlGOdr/ej0Cz84kQ5hRAVwMB+IdPzAIgevgzYusJep527b3gSDujw4rKmYWXL636
         P3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVeMBgU9wjvddUy89woDhQETrMS/nA82Qy2XpSdX7Uwz54YA+Gobmj5X4wMfQ83JmP0J/OORhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10Ipo4Q6R3XXY3eCHPj0u6ktnn0aLCQaIGV3w8hURO9+oeGkn
	5lals41eESBcaIy3UkZgjPybt/l0EdGU3x7me/+WbDoV5GRtKkUcYJi3ZNS2Qkqxj1y+YXXPhX3
	d
X-Google-Smtp-Source: AGHT+IHIl3pXKp/ZTWv1FpdI6p8zUnVKGDFvh6+mFBdKBn3nyEcQ6Xcc2f8ypADoA/1gPUu6YAyPsg==
X-Received: by 2002:a05:6602:1549:b0:83a:b33a:5e0a with SMTP id ca18e2360f4ac-83aba5c5755mr953616139f.4.1729524480134;
        Mon, 21 Oct 2024 08:28:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a586cf2sm1025441173.75.2024.10.21.08.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:27:59 -0700 (PDT)
Message-ID: <55423797-8362-41fa-99f8-58017aa43e52@kernel.dk>
Date: Mon, 21 Oct 2024 09:27:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] io_uring zero copy rx
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016185252.3746190-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Ran some quick testing with the updated series, on top of 6.12-rc4 and
netdev-next. Still works fine for me, didn't see any hickups and
performance is still where it was with the previous series (eg perfectly
stellar).

-- 
Jens Axboe

