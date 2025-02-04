Return-Path: <netdev+bounces-162638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ADA27741
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7441884947
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4712153E4;
	Tue,  4 Feb 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="X7kXtNQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE42153DC
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686984; cv=none; b=UiJQ5P0Nkesa/wqFummPC3L55r3x/5ptBnuxzBiDd+20A//Td2Jl+ittYSCKvhzGa61O/Oxa623o09W6d6i0M7wlhPIIuqyLPN+BWCmYYxnzNHqD2HADrgV+g3e6KBOM6w2+mhMEIMF2zJyWb0qdmXA6trMgneTKha+veoakrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686984; c=relaxed/simple;
	bh=aGyS7fvVmb5F1e3rF3etFL7CF/URxIql3Lc/osM+HFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVw38zV0iQacvDCpMxUYaBf9gPvdSJCdXJELJjI9fFw0t6mvhj2Uhs4sqdBiItOj2wsLijBK+YieJyXM58xIyyYj5u+vX8RW6N6a8RxNM4Mx/ulYX6fGxNJGV3bBOqk9F0XN6orpZgqDUXGD7HksfW67orzIFN/3Q5PX4Tv9tAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=X7kXtNQQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso1158789866b.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738686981; x=1739291781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IO8Ch2jFqU43zznRIk9Z4HD7pfehZN2/fooj6HLjStc=;
        b=X7kXtNQQx4A2hP/T0NB6EsjfIGPMVO6xqBczo1UdPQPhwvVrmr+CkHrwag940GlmvT
         JOyIPxP+Sb5AL53AzqWzVHuEICASFGVWCvRpHZA2NAOJPQXxRT1lknJuGLd3C7HmlfMo
         fTLsdNSINWfuOjxsuDxUdwaAHVYJeDMws22t++EDEy2Sg9VolSeuag88Rq1/tIyy61uw
         RHo2hfDQfITEKKVmFH2qYPScSWBE+Rn0RL1EztUt06r3DWCtXD2PN3Kb/R55YYGkidFp
         kqGI4Nx6oPtIqdnzMkttnoh083ALfHQd7IjiREabG4cSi0IDpym02KeUdXflfnU5xfVS
         +5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686981; x=1739291781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO8Ch2jFqU43zznRIk9Z4HD7pfehZN2/fooj6HLjStc=;
        b=UelaN89pnGwV2khn0gH5qZ3vkaEouhRfwcdwqLgEwH6QxON7x8UFboqr+lNlMRddjW
         EEM6DRYKp+/OjbtJ9htv+MY1KcBvw+cxleMK4etcideQ2LpUAPhzJJVXUizTzajd5ZrR
         X2WRZqYDlNNtytwMGGhtVMsqrCS2njCT36huI592oOUeCzArZaW9wGgQtQoDBN4HLwvg
         X1P/TYDvrHIqHg4gO8MzpGZ6IIYwA2f+rcou+za5kSnyY4+Pe+LawfyKIhFLB5kzlxFN
         RGo813Vx+vXltifEykacsJWlJxNr4Dc2Ul6OkRRgR6dGJ1658W9v/5Mtk0Sk6QHeh3qr
         tA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc46Z/KksxFYp0ZqoDmgFQHUOAtVjk2sn/ucF2CwFWVGVVTKBGN9NzI83kv5zyy3sdR9LTJY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBlK9owIacR5Zota6ZwfvYiPb/WBuskB/Yl3cENQ5t3VFJ21v
	5r6XfuNSfQYHkr2Rcw5Mm7beG2WnXOHlhqJdJx/d18Fo0C8s2u1PITh57DUBaGI=
X-Gm-Gg: ASbGnctXm0o1tHzaCRcpFaRKA5YGLMOSZ2JBJDWcPpC/AhcE7Hy0FR2bRf0wmVsaelK
	jRbWd3MLNwZ2Z0o8whbmXrIpIOWbkuDsmPgPRIZvnMVIwec9TmPRrX65Y7Qu+N2N1FmHwvdpTJe
	zxqcz2Ug3MoTF/nNvI1+ttlinjJJFD231e0IsLr217mbSiwOF5CV/LkZHByZfggyYzMgajBJPji
	Z5kURivxc+0p7Q0QNjcNg4vUI4JL+34mse5LAHg6ejH9hI3bXVcNfLSk8TLQCbQDoDXO0NvWa0X
	JQJk4UZVyb3isPiAItm1Pcb/lemIObRKrPrHk7Kz2XFpZMY=
X-Google-Smtp-Source: AGHT+IG/GxlTc9eaGLAwVdvFO8GVZEK1BRUnf3vF0jFakptP8FeaeNbcmYWNSbX6+9/Ocae51Na+nw==
X-Received: by 2002:a17:907:1c0c:b0:aa6:5910:49af with SMTP id a640c23a62f3a-ab6cfccb952mr2946741366b.24.1738686981575;
        Tue, 04 Feb 2025 08:36:21 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcd41aa628sm470353a12.13.2025.02.04.08.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:36:21 -0800 (PST)
Message-ID: <c13ca23e-d1e7-46d3-a3a9-20709362b1b6@blackwall.org>
Date: Tue, 4 Feb 2025 18:36:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] vxlan: Read jiffies once when updating FDB
 'used' time
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-3-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> Avoid two volatile reads in the data path. Instead, read jiffies once
> and only if an FDB entry was found.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


