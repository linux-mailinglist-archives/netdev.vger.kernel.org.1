Return-Path: <netdev+bounces-256176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G7xJ0mpgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 08:52:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41FD5DC1
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 08:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB10D3086991
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA98392C39;
	Tue,  3 Feb 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LLZF0tlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167B392C23
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105090; cv=none; b=nvfh2G7PWPn/hI7nuZmRwKorXOacTvpecAuWx7KMOdp1Q7xZIe587i9V+FwOJvRbHB52t6yhJ1rRYgMS/qfaBRkOl+5iZcxDVIf5N53BpMu1DVFYRQYiERfXJiZ2cfMfuRl48mgnhIaeJS4DGSyAh/LLfDI3p3Hy8N1BRit/K7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105090; c=relaxed/simple;
	bh=WK1m/rfMy+nsMO0sFa47FzExdTA2TNlHubHOaplhbdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nqfy1M+n5hu12bReDaKqu2FRPqa9hjetbvBR4smW6xy6YbSuN12WVVE6vZEP7NFleZCfEccf4RglgNFhNLnIhDHHez2KUH3ZsF6o2kgifQbXQHbCet/qjNhDMGOyJqCK6CRG3xrte1eFzDBjvyaj4VOJbxUKKe4wPDyqn3bCE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LLZF0tlI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2670932so4805408f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 23:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1770105085; x=1770709885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvoMu7jKyWYs7cJ4I1AmXisCkMpA/I5c//QtIjMPJc=;
        b=LLZF0tlIKp7S/JgIVE4d+ANaky85zDDqPGdoF8p0az12wa39SDUDOppqGftkP1nI93
         j7g8U0TtfrqAWTIsr3ZfQdGPIzU82bExeoJJd+DIPuEA3DCaW81hO9Ey4rnbDtB3f2m3
         OQob7u/4R9ozPqEkLqvwSLmhMFZSmNIPCSVDsMLFof4LLTe+QwRyihhX+KvdE+aZhGwI
         7PwTfnKz2hdOMhr1izb65NbmYpaJ0JKeS1y9QuTOS6sxhsD+fVmm0Cuv3YHRnuNk7QSP
         AS63eulqs+HNzZdeFh3SCT9+DQ/by0oKPwO4hI41200VT5lA+Ia7yuhE7cnU2rA50GeB
         7rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105085; x=1770709885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVvoMu7jKyWYs7cJ4I1AmXisCkMpA/I5c//QtIjMPJc=;
        b=luWI9TNjX53gZPE9Wqsnt57TXN8ZJ0cC1QjAdFYQmTDP7PIUocHWa/U8/tc4zYG/n/
         o+kL/51n62AHKUxjBp/81Iyc3Os1z/9L5YGiVmqo15mfRIQvbIcGanVqfiy8aIBFLgiM
         SY50V7m50zaaE7qepqks/U/4sNKhgMvWEcWK8bJKqxXRGmp5oxPHz7HZstKASIh6/2xr
         PenwDMsGPBOIPV6ixP5xYbVb6pvUbqxMJTd3r9UeKe5gefY30+KYwzttxRHQyix88pmU
         gATVwgKK04q7PzENLQT+jOLjvnrFyrdKTGgsiojw+5E3oWVPar6QrsvQI0k2//k45J1u
         OabQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUUp9U+wF8+/YN3vgd3i4HHkWwRp6WvLNYkIenb4+vj/ARUQMyAkLVSIKYCyzFOGZoX+azT/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0M1ONHRC+shbvz6T9c5R3Sgj9YDq0R7CnWky5hKasmYbGKWw
	PxqgYJ3xAyhi8KD63Iy3S/ImG0956tm5F5Abo2IBrd9xwJIWHGzGmXdI3DowHJSRmng=
X-Gm-Gg: AZuq6aK87DMTdOJhVchcW2Xl4fzFBM4V3B7lhC5fBM6Z81wXFBrPlxb491EPblgTYAj
	VH7DErO6XN6m5EVAhd9aagOY3OZUHaVQpn8zpmm2h2PcWD2ERW41YjPsP9v7XSojFxh2Z3qguZB
	geFM+huifXCoY3P0Tg28fAn6sMJr5kGYuRsADSR6lVBX8PxyRPK8XEqxMBu3dVMgldiUC+9cLxH
	zPhebjWT7S2mNQq+CMNqHEXWfJ4aN4w7bFQqO+V8ivpw4arX/7c3pfbqPAqqtSb5ccKBuNe3Lhf
	M4OfG4pLTCjn9eSCt5E9NDx640gDuu2WYtVfiEoVcLifPTTMF8JSknRhVQm5yzVw0E45hIebknf
	8GxCWXqzFucP3/rmyLTYUudyMERvWdb8YACFsE67CLf4/mzble4fUImGp60+dWRj7qL99xLj/qS
	4RrfOz2vu7rDmP9AXSSArrx9fCNS5m1KlZimZMhDBqvw==
X-Received: by 2002:a5d:5f83:0:b0:435:a83e:88e with SMTP id ffacd0b85a97d-435f3a6b975mr18413158f8f.2.1770105085362;
        Mon, 02 Feb 2026 23:51:25 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1048a54sm48458131f8f.0.2026.02.02.23.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 23:51:24 -0800 (PST)
Message-ID: <c3c66f54-1197-4123-bc31-2cd941b58ed7@blackwall.org>
Date: Tue, 3 Feb 2026 09:51:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: bridge: use sysfs_emit instead of
 sprintf
To: David Corvaglia <david@corvaglia.dev>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-256176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,corvaglia.dev:email]
X-Rspamd-Queue-Id: EE41FD5DC1
X-Rspamd-Action: no action

On 02/02/2026 21:09, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst.
> 
> sysfs_emit is preferred to sprintf in sysfs show() methods as it is safer
> with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> v3: Fix whitespace issue.
> v2: https://lore.kernel.org/bridge/0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com/
>      Fix alignment of sysfs_emit arguments.
> v1: https://lore.kernel.org/bridge/0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com/
>      This is my first patch to the kernel! I've been able to build and boot
>      with the patch. I also tested the sysfs reads and they seem to be
>      correct. Any feedback is appreciated.
> 
>   net/bridge/br_stp_if.c   |   8 +--
>   net/bridge/br_sysfs_br.c | 108 +++++++++++++++++++--------------------
>   net/bridge/br_sysfs_if.c |  32 ++++++------
>   3 files changed, 73 insertions(+), 75 deletions(-)
> 

LGTM
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


