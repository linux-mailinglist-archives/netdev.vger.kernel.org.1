Return-Path: <netdev+bounces-210826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A1B15015
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C18A3A377F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649F292912;
	Tue, 29 Jul 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYgMCsN6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA10291C3A
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802408; cv=none; b=sDc4alFTtd8+oJ4en44SVgmZqAEpAx9nKVSVPH2eVs+gh9iaq5y2fdltTZwM3jwJCB8fSMq33dqmMt7XJxFBrVEk337yifRpHAlu2buYf2cbe9qf7FVQ3BEOpyLwNFNFYG2U19L5uJskAGhZFrGgMppF1PyGrf5uIVg+KuOtSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802408; c=relaxed/simple;
	bh=v5jSoqdDjF1LAWNsEWf6Xr1g8OQU+xdzaS3lksRP2AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXL1QH+aJ5V/2nayKLZUUUVSrLblkiWaaSJtr+3WCx6mVvmgsSVUEJ4oFTaUkOL9lOofk3WHXAsM9T+747BPEPMOVyijJ3SYlELVZAZCXNNoBbqPwY+rakTlElKhIEm7HEgsrXyVjMAvHFWGTUPedOQ2qyQSwHYmpbT7vZdYoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYgMCsN6; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e3f449fa6fso810015ab.3
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753802405; x=1754407205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5jSoqdDjF1LAWNsEWf6Xr1g8OQU+xdzaS3lksRP2AE=;
        b=WYgMCsN6oQmBzxtxgTqbYMg/kkZcKmbVhMDvK6RLJLEnS8wJ4nSV+iCsrp14srEGts
         JOqExkBH5QwpcCP2bY0JIB6wQjlSU76i+yzqndchk3YgRvTG7Q/ErbqeqH1gwCCOhXpb
         Ik7JU979sQvKlCCwTEk1sfW+xVF6n3DSPFV0MfeoTi8olrLLXDpQGasVoIWiIWJs5pz1
         VIVYXFwCxarn/mrLFBn9BsbtVD6xbTs7e+uOyV7VPIsatoVrHsYq2wd60OwqI5JcAgDE
         VQ2mG9a8/WqEZf3C1w0LCsxZ7DkUSwjYNznk2tfk5tjflK6hZaBzwsm5c9IOsHqGtJS+
         sYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753802405; x=1754407205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5jSoqdDjF1LAWNsEWf6Xr1g8OQU+xdzaS3lksRP2AE=;
        b=t1ZT39/1OgphOmptMG7FfXO8MNTGAgOVsfkQphi4wJ472lJ+RgppsXpd3qnXVOGpYy
         ZdkiqS4in4XsHDn0iIb0GdqM7IcwM2aJBV9PI6fzYQbj5ldhK1f/pTepz64/rRxxRpqf
         317ul5iA8PqKpj/Lmx0rlMsArVOh/PcJ1ioaPFUyF1Dz5eZ2TlZD23Nx6XO5JSDsjDVw
         xBQfwBCeD+F5ZvGY1ro7jw8Tn5tNWFViqYU7CA5vfVw3nSyHxFEQuWCTMpB8DWJlZd0P
         LBQPrlT7MtYATdM/3XQP/po12/UzgB3Gzu7AJn42gJ9V6ueTDEFRj1s9OqNcgHY8/FdQ
         M5hA==
X-Forwarded-Encrypted: i=1; AJvYcCVkC4j9A+cw/MEUxwM+5hvLTU9Y3hA6qMxxCrZRQGpYJRbnAZipoeQe8TNjg+Qv0tYO8ZpYWAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjx263a1HFj7A8O/RD53Gvgnpvp/ItoBmJod0buiqVle3RZGJV
	vLEm8d4+LtOC37MaXMOiETT5flvWy+YGackuVUhV2XN+ECOo1ddU2PRm
X-Gm-Gg: ASbGnctjakFnOWPcq7h8yvAVplfdsbYZ6gF3lkDZIBWxTSAnd8IGVjF8S4nz7E373Im
	WJZb3jAqby4r/kVJkFTkMjR5sm1H5DIpYh8m+LM23zNRrelQlmTZ3KgynYzTMswZPPU80RcN2KZ
	oqKDhquDSicA6gxHqIr2Xd4qm35gDMkkNHM7aE4oA0aE09quW//XmIleF+I8XNpPYldf8Bnnoj6
	cpX7Oi6PkEKiXR2RmmHF5yyCiHoB2Kg6hlL+ymoZ5qVaUS3N3wsx2xbaacfoh/TBKeJjyxb5Zgp
	oey/poCGx5AZNOqtcoYCjR8/Ztmx4fzk25li3eiwL+WrTZwLCjas+jPLX3XK0UnBiv6JSj0cUe0
	qLHtNEZfCEx33In+w5tWVOTcWc0LwBrhN8+tj5w2avhK/DmUkfTOzsTXpUo9tatBxfL4rj/rusU
	BPWrg475eo
X-Google-Smtp-Source: AGHT+IHl1xz8y2Z5+8C5ruSqP9m2OsV3pDb+K3EnKUuc5256XHoBSA+FHpvP9Y2frpahTMgdXcMCFw==
X-Received: by 2002:a92:ca4b:0:b0:3e3:d968:bb49 with SMTP id e9e14a558f8ab-3e3d968c092mr139949165ab.1.1753802404677;
        Tue, 29 Jul 2025 08:20:04 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:1122:1338:f1d4:15b5? ([2601:282:1e02:1040:1122:1338:f1d4:15b5])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-508c91eccc6sm2732942173.26.2025.07.29.08.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:20:04 -0700 (PDT)
Message-ID: <379e1e35-4aa0-453e-95a5-0ea970e56651@gmail.com>
Date: Tue, 29 Jul 2025 09:20:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Content-Language: en-US
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@microsoft.com, ernis@microsoft.com
References: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
 <796ca41f-37a1-4bdb-9de2-e52a2c11ff49@gmail.com>
 <20250729112340.GB15902@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250729112340.GB15902@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 5:23 AM, Erni Sri Satya Vennela wrote:
> Shall I mention about adding this file below the Signed-off-by section
> in the commit message or create a patch seperately for this file?

either option works

