Return-Path: <netdev+bounces-181544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DBBA85625
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CC21BA1D52
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B6290BBB;
	Fri, 11 Apr 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B+vFVWi1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B379FE
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358781; cv=none; b=foe5O0SQyRBZrOZQlNy08cGty2b8a6EzBdOCJmyGvvp+zgXKdHGTofi2Cf1arfshcVpM7QdpF178dqLg1DKXAn/EkcnfWcCH6JsGp0jiUz5Uhj+4mwaX5RL4ALcvTJ2X9kK421apC0zxI1wBOUKp4JS9jLNLtY7AbqjOvd66NIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358781; c=relaxed/simple;
	bh=25gpjSM2pwypS0nnqcZaK6eDCYbGmXx+lmeJ0pd9c70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/qAFcK3fZu3JZ1YrtW8fff0MxiXFjtLic2qSwexSrARrACdvYUkKGvoeWh/HXPjj6NBgcFY1+DYWbg+BOfmHjzNF7F86eCDxNSTdoPK7w8Z0UFSUpPmE+veCmklimkBCKj/OeAVWfhlcdn3M1rFkKKqr9EF/xE6sF6ZVjnlP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B+vFVWi1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39bf44be22fso957390f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744358777; x=1744963577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=isqlcTTyZ7Sm6lBmUjMYNncUIpye7YFqhmstYJsaMMY=;
        b=B+vFVWi1z8O3qyNMUa0rhbuCdIiHug8G/6ggkTGAqrR96eavAETjBJDfw0VxlW8sNa
         PeUbZEj+5P7U9xlY5SlJej7+fAbADHDgFEuI+UERNCP40NyKvUmIdkiH9/hxqxEWTdCD
         KFFDCaupS/wYrNA0QTYFaCQSYZxN6gPA51fWN8jXOZhAjePPmrtDh35bvMANsjzvrZ2r
         v8aAseGP3MDrYu3ihodIrTKT0ZwmMy22y2dEIfz2QEn93pJPd9ilZG82SrzvDZpm00uC
         lM3ISGHTAwwbICIU5MxmvvWvTk42AfY1GAFSb0Jcyi8SlHbvH+4amDFqOrHAEb3rNGSO
         rMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744358777; x=1744963577;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isqlcTTyZ7Sm6lBmUjMYNncUIpye7YFqhmstYJsaMMY=;
        b=Y1FPElM5P/dRS8ZopASbui86tgqcUOsiCCUs/DSnZAaL2cPGLeKw9Hd/3WVsXsSGvg
         kXf8rfeDp8iF9/yqo8FJQ4ia4QTUGfFxjjAKrfGi0//elp0vYThVlP5NsRfPnpuUpas1
         Vc+jVQN5HdCoRLPDmuhLxbWQGE1C8HN24f8sRMPTuXkaN+zX7/+ihZj0EX/8QV9xmXJl
         jk6W6KUzvYu5bUOre2b3oWF9XDdzU9QYcZzqz5ooCvpmWVr4bRf82u2mOjzFHgCcNAXP
         wFllYusbcICmyBK3eu5d/22O6lBz9hSoSUgHH6F7HYThR/oiA8yBZwhJTOw/pw2xIQsG
         Ik7g==
X-Gm-Message-State: AOJu0YxejO1NJOLexTBkYDn62M1nxlZpn3Je8HLCk/FYYB23DYNpN9pQ
	v3Fny0OOb4LlhSwk050MXVt82ADQiSbOP03E+pdHGuJ8xZjxFCUiVa31+uHO2OssJeS8uNMM3D9
	sW8GpNpyfTJq4hBMwod75Oq4DjGdBc3RMHrsCtfSQe+r041hylx1MMk84NnkA
X-Gm-Gg: ASbGnct04G+/kMSGQv9Gt03AcGilmZP5eS9QdkWXBRRypJyS2UlaAP4UALq549U+hXR
	jqQAkW4tAKhXwpGesuTNSk0tfXsCyyMcvbaapMFVpYhilkV3IeT0iw0lhVyLi0J8sHKpu2F53me
	z+3SSS2K+AQkVjqn9Yb8V802Ua5CfI/XCX7T49/tzHP8lChsAtPLXxOxHPY0zQ0ccAQclMUZNp4
	DVrQbHYFOA+Ovg0yACuX/kz9qFJYnyQ4gfrDSY+O+gipmYv1Fip4AItu5XTS75oY/eycOLX5cxd
	sm5gSCZe/YpX4P1L3Yhc6autx/lmYPrRdnkHamTwszV0Lu8CxqiYP106laWuWYL/GrG5eP3yZVP
	LulU=
X-Google-Smtp-Source: AGHT+IGSDtegkKJY64mlTCzxcAmGSdXhvH2SNshDQWGQBnzWzeEgK+uqlJuIomQMWE1qtExRuuPWJQ==
X-Received: by 2002:a05:6000:4205:b0:391:4684:dbef with SMTP id ffacd0b85a97d-39ea51f5804mr1148582f8f.17.1744358776666;
        Fri, 11 Apr 2025 01:06:16 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a273fsm74655795e9.9.2025.04.11.01.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:06:16 -0700 (PDT)
Message-ID: <b3980874-ef04-4688-ac98-1f35bb1e677e@openvpn.net>
Date: Fri, 11 Apr 2025 10:06:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 02/23] ovpn: add basic netlink support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
 <20250410195822.41a77f1c@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250410195822.41a77f1c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 04:58, Jakub Kicinski wrote:
> On Mon, 07 Apr 2025 21:46:10 +0200 Antonio Quartulli wrote:
>> +        checks:
>> +         exact-len: nonce-tail-size
> 
> some of the checks look slightly mis-indented (needs one more space)

ACK. Will fix those.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


