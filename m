Return-Path: <netdev+bounces-179281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45AFA7BAF1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC55F3AA4EC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DD1A314F;
	Fri,  4 Apr 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xhLDTzIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA719CCEA
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762745; cv=none; b=YrCkWPfC83yWDxLtTB2msPoRoVXYVW5txuMCPxD7+7zG2fLq9Uso2JscEN/5IO5DAYYKg4GGTXIceJKYKmlud3/xCHHb+jPkZFg9nVQrhwdrPTdKAvcSW1TT83WO3KBTXfsPpE7Kl8QLn5sJ/Q2E3mlLMlrog+Yad48K5S2oVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762745; c=relaxed/simple;
	bh=/eefFO5H2rkJhZAMwjPkmwG4Oxm/AsjJOcWPdE69QPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rg1heJ6eObbqq2uVK0Orss/A5qN3yIJRiRgEnAOCEEngrvGHVnsK9OOPSV9Eb8fAok+Vy35BL1vyju+h9RVuenXlCEVI8PaZ5CPMCPlif0jF8RYeT/cP9dYv4258ixak8uErteyWzMi+NTcnJNz/bS/4gqtFXXDTcqu2M4u8E1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xhLDTzIR; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso12878015e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762742; x=1744367542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NPPqHWD7AMDiD4PKiUNW9Uy03GasUv4r/53C4cJhf4=;
        b=xhLDTzIRUEi2FQZG+D0XBBqeSZK8P0jXTfh6BZhLBmquP6qcVjqVpTBV2T3+dY3od7
         MtMEcPrVEBbwt0UniFNg9cOlUeO5y1p51v3m7YFVtIkogSrQ7oJ/ix2/+2U+f4VhAzJg
         /7XPgS9F2mw40EXqx9VaEgJnGpEf5QTEhGrGQzoWehYwH8TN2nrHmsL3FlbxDu+cKvdH
         4l9nHDQaQE4+a7TVds9zVNylZne9zUByjsoNMt2yMvCgTRT2dDMVn7QJK6umYGxsfWyT
         NNjG/EGJ66slkj+Ij+UpO6ffJq7s/IuXEp0+u0E6vzKGOePsPJ4nGOfHK/TOy+tsARRr
         WYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762742; x=1744367542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NPPqHWD7AMDiD4PKiUNW9Uy03GasUv4r/53C4cJhf4=;
        b=SwNH/aSBgfEK6Pr1oa4DzpsbaFK7LWrZTNLwQH5Brr4+L1StwGvWsZhMhj/iWrEz5G
         rku0f5CrqKxT3RaRz/eeW3vuvgWTL1ZOQRExhkl7cTSH0YOp5Xt4UQWZd1TdFxegU/Qh
         0gdBL9npj5eAm5cHJfqgUojN5sz8OfphTRFJWy0WCsZacPNj6wtOBHc2z1oUAEGOr5dW
         M+MIlVIXcKZGL9rPHtGDIWBk7yieph/+aowGfNHAlmJMOEpjhn6Dp+zfiljg0ZOT8zCJ
         cwV8Wz43eUkTrFXZazG8RLTz31xWCy5NfhS3bkO7FUTnpZj35kd91+9Wr1nAQL4MeBfF
         ZzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkf/VLyGmctdQtw3AtbyHbBgf0nZZ6ARncpAJO7TXpu7CgnR6tK00t+CL54rNc7Bh75wWsZi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QvVdqSr32VKIohopIxkLgtogQNj3/o5tpdKlyznoRwRmukS7
	afiHg0/tI0EQV+VgxlwMI99Y01MJqdS4l2dekNgZhEGGr+s/NC8IwxP31AhXejQ=
X-Gm-Gg: ASbGncv0oQa7l32pz5gTBW+ZrFg7gd7yCq49Nl8Afesd5PbdeiMJZjPVdEjmV+Q9ZsW
	jxyHxWWmsPu/G2QqzYkR6jTf0Iqvghd7l9dnnZIei2jLD1yLdi4K8T9fmHn2WIB4sdaRWCReZhm
	GEAnyHHbuUlOI2pUW+c+ILBCzwSBn79/8OFAd4JXLhyQkJVsKDEWnPYhUT2BOBeBhvCCsbEyCF3
	AjjTHVU06o2Sl7MSCjSvK8ls05eaKKxuy9aoIfl8uMso3gjPmeDltRCmWOnqngvPfkR5EE6WPSN
	mC7nlRbRw7SqTE6otjpR5bRLaPlb6jVEakjo1wqcytLc3cT6nya+COFlQVBlUf4eztpb2ZWByt4
	0
X-Google-Smtp-Source: AGHT+IG631D8DMeVx3hSdyqQ7JDFDf392sDkYb35wAo8+cxTeaolfX7nYV8l3wZAFDhfxjEVcwG8UQ==
X-Received: by 2002:a05:600c:1d14:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43eced994a9mr24466825e9.3.1743762741641;
        Fri, 04 Apr 2025 03:32:21 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0a38sm45200295e9.34.2025.04.04.03.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:32:21 -0700 (PDT)
Message-ID: <662b83fe-ae5e-4460-b2ae-2042ef8e59af@blackwall.org>
Date: Fri, 4 Apr 2025 13:32:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 iproute2-next 0/2] Add mdb offload failure notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>,
 "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
References: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:54, Joseph Huang wrote:
> Add support to handle mdb offload failure notifications.
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250403234412.1531714-1-Joseph.Huang@garmin.com/
> 
> Joseph Huang (2):
>   bridge: mdb: Support offload failed flag
>   iplink_bridge: Add mdb_offload_fail_notification
> 
>  bridge/mdb.c          |  2 ++
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  3 files changed, 28 insertions(+)
> 
> ---
> v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
> v2: Change multi-valued option mdb_notify_on_flag_change to bool option
>     mdb_offload_fail_notification
> 

Please CC bridge maintainers on bridge patches.

