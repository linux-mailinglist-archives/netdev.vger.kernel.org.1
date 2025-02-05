Return-Path: <netdev+bounces-162879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49930A2842B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEBC188208D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE692288E2;
	Wed,  5 Feb 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXE/voVu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF641227BA9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736073; cv=none; b=txD4yw1zOF/Pa+jqYbe9zHna/Pdgrpr9VC93KqlNKXSpN07rb8udzwdRyEk5mF5wIb9/rj9U/EGTTZKYDs/F0icxxzYgGoZYyEg95KkEvG1WOfHb6YQfVUQFBDS8mD3gp2fwB4bi4UXX1KxSeNRYwVt9FvkYDbN3K7DfvsAuHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736073; c=relaxed/simple;
	bh=nhE+eCRNsPwTleG0Am0YeDahvOlAzVQ5DUTkZkCMQko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsdhmluayuEgZVqsLmbcqHum3AsbydQ9I9Q7XjSvpi2OT50RcbwkMLRweIj8VjlGGTGfNcmPA81Qi8VTSVotxTQW9SRZCFQp0tKzkD8n4z3pcV6NLHPWYREgggomsp6mCA4/Ek7YUYqn7WopcZ1cOVjqbQinUVCjLimksbDKOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXE/voVu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso44236005e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738736070; x=1739340870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P64e/+E7zkO63YvmnLYTR4dZH1q6m+06iv/+Z4Q0R7I=;
        b=bXE/voVuA+0tlzTk7ObVHhQWNtRmmTLVwSlwVdZznQlUGiOsBRN3WpAcXKXO+MrFP5
         bB/dKRffiFAu1QQf1ihUY6UExRCXMUBILqeuY4Ak3bnsFDchtbodI7wmG2tQJvMLTvIT
         MjvppAd139vHzvu6Lk3W6L/0uo5Wy1/xwSZPlip5JpOyRrRVzN72buVbrw/Rf7tHMQQa
         XaWtDmcmnoz5xz+0FbVORATQKUqLyQYmrBrpBUfxCgg4kkAhbbrFcns8vt1nFlaTJy2f
         tJwAfuoW9N7cOnl0z3/zAALwKurwc4WC8VRHUAaHLZcHoHkD96nz76zuaiGBQeFPddH9
         iWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736070; x=1739340870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P64e/+E7zkO63YvmnLYTR4dZH1q6m+06iv/+Z4Q0R7I=;
        b=mIli3GydPtyK10+kbJld6d6k5GmtV697ZgBvPmQ/8DDgI1M7wXk1y6XajI8RyMmUEv
         IFypjqdaUw/ZK8466IK2jEJFCv0k7n/H1h+fpcwmkXrYgaZKrPiMNtlN18rC6c7XDUEG
         TZ7PTLQ9JN96lAVWBiZq5+Ml5gvZERnL5gHmlcExTmLWkymI54yZy4d7o7+oB3pnR404
         hPTxmFODpxYFHLWjm12ug/Fn2cXmP50J7iL2D2AgtyFjz1JFWqlkxciZs2sVbUMk4Pvm
         XHjynMwIfQsegr64A2rQtRkayH/+yTyIxTtavp0xP/JP0gsdpY1fCOATTfhfi20+AULY
         ilIA==
X-Gm-Message-State: AOJu0YyUvCT5Kf+sIJeTUzxt7KxnVAl8afBBYJeTHXRz4bPCQjqcO+6i
	ApH6fuhxp8P3S8QaIve3AbWq1g88jt0zYY4SiQB0OX55qhPFk3ER
X-Gm-Gg: ASbGncsDrXGTZM5WhNPBunqXe7x2XIdUUPfDssGYXS6IQ0rwgryH7RPPdusrGx6MVMQ
	zARtVnwbRKSK4daSr2lhZwqlOXJzfdh+YBsH5SL2m84xweCifQQ75uUZOE4cD2TuU0IAM7VICz1
	vVV2rEZYuTaT1OE4ZPWaELGSHMMXev8A/P8YJxK0Yztl02HbaKB8bB0tsRMW+ric2b4skNeyqwR
	sW95saNnkC+1K0MParfO9wvd/98nfbA9yltyUf+cnNUVh/jAyTIS8W0j4dIMchn20xyh9wkVKa+
	OsYu3cOboTJKsoFkB8IIvqELaEi1PNtcrIeQ
X-Google-Smtp-Source: AGHT+IHvwrjPnfWRGVnLn0lRDCKUJXzVZfN/SlHu4/cFDKbVod4MtaeprYXlL9auqo1VJbUnUe0EyA==
X-Received: by 2002:a05:600c:3b15:b0:436:f960:3427 with SMTP id 5b1f17b1804b1-4390d560f5amr7644875e9.22.1738736069425;
        Tue, 04 Feb 2025 22:14:29 -0800 (PST)
Received: from [172.27.21.225] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4438sm10438205e9.25.2025.02.04.22.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:14:29 -0800 (PST)
Message-ID: <915e32b0-6868-43fe-9413-91c3732534b0@gmail.com>
Date: Wed, 5 Feb 2025 08:14:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] Support one PTP device per hardware clock
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2025 23:35, Tariq Toukan wrote:
> Hi,
> 
> This series contains two features from Jianbo, followed by simple
> cleanups.
> 
> Patches 1-9 by Jianbo add support for one PTP device per hardware clock,
> described below [1].
> 
> Patches 10-12 by Jianbo add support for 200Gbps per-lane link modes in
> kernel and mlx5 driver.
> 
> Patches 13-15 are simple cleanups by Gal and Carolina.
> 
> Regards,
> Tariq
> 

Hi,

The series state is marked "Needs ACK" in patchwork.
Which ACK is needed here? From who?

Thanks,
Tariq


