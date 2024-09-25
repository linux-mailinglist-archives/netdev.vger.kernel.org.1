Return-Path: <netdev+bounces-129827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7E9866A3
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F87E1C214FD
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5713C8F4;
	Wed, 25 Sep 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnrODvQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE3208CA
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291211; cv=none; b=dpBc5eoeqhGw/9AfsLR7gAmWKKrSlmgroisxEpVjJT5Ud8F5unbjVWojATtML9NW1VIVO8EIicDXFCeeMsnTCDrM1X1jfUtPtKU7NmgCccUSllvxqbGDUQLFOrAMRq9C2PcNHZNH+zQNSsVHaMWqeePYXDffocBth4sRQfIDAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291211; c=relaxed/simple;
	bh=YB3EmrTbToNcjlLBJKR6jJqkDQvX+/1mxzSeCzXCE/s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YnaP4P9zO91usBvG8vo8s33Wef7dT7r8N+PfQThi3qY36LBZNg5/BbwtbIFxwleJKi6YfK02rkA415CfJwgMoEIFG7lx9twd8tZbyE768944vcuqA7PriaEoqCqH8Lrkaq8hihMDNl/QFq8JLad/IWY5YcFkW0qhQGZJ+GdLRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnrODvQ1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so122719a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727291208; x=1727896008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3RvaHwPUVJomnG8o+QHWC1QOmPIT6fdMzTuanYAFeq8=;
        b=MnrODvQ1Vo2C+l0BINZ+CLImluY3dq+WzK1YSRE/64aNw2kicbimcvBcsB1Vi25sU/
         AgCkew/1KQ1p3vzWwM2Tw83YYQE6EcE6vTUp00uFOsLw+Nxg/ky27y+P9Lwn3Wk3JK9g
         L0ek+R+gPRuxBwV28Zken+aI1TNd/Y0JL5rqVFBXf1vsjxp0K/DNQ0lwMP9uA0itT9rz
         u9zNL9WgkVAOc066i96kKqW6y6gmSvBFlfb+OmzF3iR66KV/hbcZ3oHcN8YTFb0oR3u6
         VlflCKILQyLusfDrcpCCbVmIBVmeko29ucdamkLlb3mTVs+n692iZWeXENu1URHcZJRR
         bOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727291208; x=1727896008;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RvaHwPUVJomnG8o+QHWC1QOmPIT6fdMzTuanYAFeq8=;
        b=lFSZFMsfqzsym/SwcRpfF0sqpO6hwwStYgz+jbeUiQC+MnxIbdxd5aECKTNIHzCafO
         U5z4tjU9vNlG2f9Mttu0HCtbNejKfBIldIOmbrsAor5Yd8ZkPY4sJE+6mX4hmupsocli
         YmIHcZqHQqT9edi8NyQCELebcPdNtxxBtg0xA5qa4cDWTtoCthZdOBveQDK9FPy1nS5/
         BZuVFzG+2U0xWWJKZV8evukaw0NW7yXiXomdYvI869GYt/HVRqFdZ9qWmlo+oXVVeCNC
         hZlMpN6dMtEHOHlq0yc8LSzDOtdU3syBlCVv8JLA6YDmPiduS2MvNVKG1Rk336Va/Nae
         iitQ==
X-Forwarded-Encrypted: i=1; AJvYcCU31C1STpqILowFN4hgSE739wxYZDsk7KGLhfvMEof2gqkeTacGNpVMXKytETlyTtZR7sx2kow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsedXJqKHfUfq4/dKO0FMi+ih5G0u5ghP9RvSKlsYqf7zScxd
	lvRkn4sudTWzWRe2LwJVN09/11T7DfPD55dm6I/EtCUgfZZv925s
X-Google-Smtp-Source: AGHT+IGaXyvmMB/af2cN2UVxnDj7bGDS/VRmnVWgovIT15lBapLIl0Ci5cfyI+hQIox8tfcfUSI2tA==
X-Received: by 2002:a05:6402:354a:b0:5c7:1ffc:f58c with SMTP id 4fb4d7f45d1cf-5c720641103mr3091786a12.28.1727291207943;
        Wed, 25 Sep 2024 12:06:47 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49dd5asm2202513a12.54.2024.09.25.12.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 12:06:46 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
Date: Wed, 25 Sep 2024 21:06:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Massive hash collisions on FIB
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
 <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
 <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2024 19:18, Alexandre Ferrieux wrote:
> 
> I see you did the work for the two other hashes (laddr and devindex).
> I tried to inject the dispersion the same way as you did, just before the final
> scrambling. Is this what you'd do ?
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
Doing this, I discovered with surprise that the job was already done in IPv6, as
inet6_addr_hash() uses net_hash_mix() too. Which leads to the question: why are
the IPv4 and IPv6 FIB-exact-lookup implementations different/duplicated ?


