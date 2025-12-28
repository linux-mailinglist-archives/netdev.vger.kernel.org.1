Return-Path: <netdev+bounces-246182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEA4CE51E2
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 16:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC313300C2BF
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9EE2D23B1;
	Sun, 28 Dec 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7ocIVmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98E2D063E
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766935495; cv=none; b=phYSwcFfjw0g0hYqsF/t0FNY3OEscWj72y9XnmqLojZRenDT2q62yXVpnLsObBeokC+oeAWUoxAEcPVyxV4vZyZ6gvZYt4HJ2WSm7dY0iTRriPwY0YPxHUxZkhmmcqgz46qpn7tsupSsFffiIW/FbSpTJCFzN06JOboi5Wd/J8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766935495; c=relaxed/simple;
	bh=gKz208HoA0lKUERj77c+uOjHx3I6d6ESCccnt9Jc9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToZ07WlN7z7qYGUF3gFf9Jw0cRNoN6nfDLaf1TAWvocCKllTlcML+XZmt/jQRo8rbTPzBN5nVuCM6IqrBKNVTjldBlE1NeqkGIPlN5GK9UU8vZRrMcrESBjXG6TZ82HyfcxPhVcecvir0Bz9f2kFJad/XvF7xLJv91IfbktJpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7ocIVmd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso11488877b3a.1
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766935493; x=1767540293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86hnBlF/xxjU8l52S5b0vRQrwZV1Vplm9wa6+9hiw40=;
        b=d7ocIVmd4T07+2mzWnia4c3ZaTrreeutKL8AoH1H0+s92W9UKu8ww10qhpXMq4utIL
         zyAV1MJMADON7Gq0EnpnYXaZhleLGf/R9PXAlmStXHIHqAovRi/gN87SMf4x3fT2Dic/
         2Vpw724eW43EaZHTfh8AAPhvMZfFaZXvHuRxiPGdUlWZEswDCWLwbzrxkHFOrZM58Xro
         5On6xBBszVhyg7DsFY6FJFQ72RLZ+EwAnfP/2LEtmFUxB0R6CeL8tQl3HEmstR5iLjk0
         45IWM8hmbT4c/fBpcYaJNr9VZV7gf9i6lA51JZTAAfSQpwU2wJNLMDwRTX3z55uC+fDj
         5LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766935493; x=1767540293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86hnBlF/xxjU8l52S5b0vRQrwZV1Vplm9wa6+9hiw40=;
        b=TrpNdxJfSp0HYkjXdX/3CYlEcy9KauvhlPs1GOy1wVASaUCu0ACj6j4vvRJmfk2Lsd
         HIEjMOF3my3CI1EzqcPIFH0++WAge/s0WV/NhU1cb5sCPXRtOkxIX6vpWayvtwCA/Mes
         HDCIfcNcQFjawFWyvAVacm6oA/imMOAptJq/Lk15Q9LOLKOzUSznWhsWhOCvfdM9GH1r
         QxMoYBdDP2xFEkdQNr94ELw9eNTTWINXlCUzUhOXa0txBrsO/q6ozAEp2D8XcL80TmDV
         +XK9JWJGLeWyzUM7AiloSjpCwnZIeqhPG677MvGJosX/O+1xfgoVqfKheRLDye6yivgn
         LYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSL8hy3wQfDbqsqOGrzRprOPC2FZKUYVDEekn5+pHmDe5OmzoEXGQ9tJCCQYRbSvtZHvCVSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEQXd5lltIWX85IE+IBv59pzJh6Nxu773wUEgyofGKji+Ewcg
	qGA/tVxdmuGExjFFKURpVqMfWqHAQxzpLiwv+6NV/S7CE9IMnPIDoisP
X-Gm-Gg: AY/fxX41mG3GoWzboBXpiAqKGZiaKVt3J+TNcM899CW1v2+mjTSLrkVygJ/QA1Css9E
	QNbABlKkbFwUVdftkrgQ1IY1uwp7SH1ykFzABfdVOx3zi37mQuKcNE3Cx1ePoW4JKXo+LQBlHUN
	GCIbLFVM22ZjkDivKPzWzZT7PZeAqsaBJ4QmyxXY3UdCyApyBdwTkXSflx7U37q+gfnodM7o+oa
	aar30E2uIRYFNu8/Ooybcp7+I8cxBQj6uAeLS8ul4eefNLW13zPc3NYMkeNmxE3wuT+t1tWKB1V
	R5yfUsgMXRSqLTtD9HvycSem/zbP6OdEuT+lXya7u++sAq4CGH6W42oXk+bOU2Cq+kQk7mM3dZ3
	8gYVo3IrOH6l4wIZf7xWppEMU2gpNH4LYVX5nTct0U0dwmUpghKeUd7Cl4sIO8IYAa3D0P3ZZe1
	VGSFTewf56vVYK8xUDq63Ost4VjRngcBnZzSrL4IuCyu1VjX0V3hueUrnf
X-Google-Smtp-Source: AGHT+IGL1LF3B/F5yxQcO4uYNnE4qUPfxB0A6/0dLPnnFCr3PDN6MxrD+QIWvtnxHGtoB1ABBZBWhw==
X-Received: by 2002:a05:6a00:90a2:b0:7e8:4433:8fa2 with SMTP id d2e1a72fcca58-7ff6607bcddmr28705577b3a.42.1766935492499;
        Sun, 28 Dec 2025 07:24:52 -0800 (PST)
Received: from ?IPV6:2405:201:2c:5868:ee97:849f:cbc2:8d2a? ([2405:201:2c:5868:ee97:849f:cbc2:8d2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e892926sm26958008b3a.66.2025.12.28.07.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 07:24:52 -0800 (PST)
Message-ID: <e68da695-2fdd-4692-999b-566c1b521f47@gmail.com>
Date: Sun, 28 Dec 2025 20:54:47 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/sched: Fix divide error in tabledist
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251222061306.28902-1-ghandatmanas@gmail.com>
 <aVA4YJIT6at11JwH@pop-os.localdomain>
Content-Language: en-US
From: Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <aVA4YJIT6at11JwH@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Cong,

On 12/28/25 01:19, Cong Wang wrote:
> We are reverting the check_netem_in_tree() code due to user-space
> breakage. I hope reverting it could also fix the bug you repported here?
> 
> See: https://lore.kernel.org/netdev/20251227194135.1111972-3-xiyou.wangcong@gmail.com/
> 
> Thanks!
> Cong

Reverting the above patch would fix the bug which I have reported.

