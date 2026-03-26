Return-Path: <netdev+bounces-271794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBXMCn+UxGnH0gQAu9opvQ
	(envelope-from <netdev+bounces-271794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:05:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995FD32E32B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D3730036DC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110D224B12;
	Thu, 26 Mar 2026 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpj5ctjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4503275B18
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490429; cv=none; b=CjZX2V+jcoqFHZ6O/JdWvD3I3J1YUtf2IIA+BB997chZOcHeprRnsrs+qTFWiwcsfIKngOKdFI/yLRV+/OKbmUl5sBCtYlf01iHs2g6ejf9waARmNqDX0vQqZ0HsGV+b1JlFanjQknQPgfv167L88/FEb7JeM2jCek7vY4K6LMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490429; c=relaxed/simple;
	bh=RfijQGsKWUEkGdgHfWsVT1ZhVP2PeputQJ9VXpu31nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1DRtq8Q6jqyETgVHhJU5obwsTAxMwaeu8BxYzufgWynl/49wfGeKugJZo9mUFd9sk+Zglcsd79OihnGohLCo+6YGil/8hn2bUhbhBnFTEaQo0ZyNCD5aCQsFowwanBluAdgCAi6rGCnigNcUAYYjRgFUa+or2Djs7dJd03NqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpj5ctjF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so4460815e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774490426; x=1775095226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhbkdLidpODGTRsYmLRF0FS3n+wDOfvaXSzlGywSvfg=;
        b=jpj5ctjFPZaj9H6LLVDzUgyNEThHIOeQvBsaFa7xuuWc3a/lWsuUZhEmiKb8gnLAeW
         KE3eLRRD2yAOdLM4dm2Zgb2ozn4NvRNsWk1WlTr9opooe8wDD9DzuHHDUbUUCFrV1FKh
         5SSqoRvP8M2IyqN8Sn7zy/ttnrD7eqsksxRElhtQvStAGAkXUdmk+VKYXJZpsOXnPzu4
         rjMzxrfxj+zAI+FQfkxTW2IsrGz8Aqt9N4dazhq6kGv+QVVbYilPio1j7R0PFTyaiScH
         o87zC8Es2llo2IjIjd/AmTkWr2jKGoMeof/8E8iQ8UDRtvNPf8fGYrP7bSPFg1tQgv9x
         +Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490426; x=1775095226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhbkdLidpODGTRsYmLRF0FS3n+wDOfvaXSzlGywSvfg=;
        b=mfJ3VcTyBXfJs4PWm/fh9LVmqPKM1ZtS5KcJiOwtiCyceiBcjzjF182zr2607byLT5
         HaqGwSv0GfoQvJH7vYvs7fPLjj/h1RMQjAMIllfUefmc/q0AoystRIhbsNKLG9m+iykD
         AmFPNzS0uaCW+uO9CUqcy561TzE5Jb9WjHFlUT5Y4aMyEL9VBVTGhoQVQ9KmOvwWQFZH
         Y4KF0fS3N3qFIzBJHu6U05iMHLgOc0iz73RgJ1GxJnJ9oFvHPwmwhDvjWlHkIZNp877d
         B69vdfEJzvxXDPOQhAGgAqCiLxj0jDqEq7NCIIW7Hzk/wj6k7x12oYu3G3EkPZtnLmhF
         C1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW0PT0XSO4BzvPFd3um7hBfspRsGgqSCDoTkB3YMl9Gtz3OzC/WghFFcuPJ1PTx3Uv6UbV5FUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4X4cKTGNrLIwGeZKlvlAYRWB+PQIgmIUWSSIYEVZzxa/lfhN
	KKlF6c/vXrgFDBRHBGotqgLzsWdW4lc9cNEqZ1Chdr6wSkZoBL80FGlw
X-Gm-Gg: ATEYQzzq0K/VgNENs08YUcTDWK+SH4xhXgk77efY4s4UbzN0hswFKIsBC05h0Klubu+
	pNl1MDym7Rb7mq3er9R7svrLjCglJGDjTW77uVusZovIUWq5II3pE/wB7jvKzVpdLQp+lZZcR89
	aqPAULwaeZVQQmSGfZ1NsZjBPxtkbanIrUrjQIsURPYvgYGYLsCYtjzgfKRhH1zAPliFHr1AiCS
	T4Dbinl06QWDpcAbL3Qtk27jy/21LRcM4F/cuhcqEGbGi0FkhhEQpwbB6VqmU1WJd11+ymCZCfT
	rNc3vvtjfjsClWwHkoiDMufrGxktCDoRIYEU6t1UKkWUvFt3vBiveRMXGVEbCf6MyQpcMBIOUf8
	Tlxq66mpNjb91ERyBk4RIgsef1uLHVL1f7c35DOP3g1oRppT1V5SNESKLn/GVBlqaeKvcRXAaGR
	hwNH9YrZBfItKqd4Of5tlmZUAjxSPxJbDAU+/pa9BtxeA3e+iQxdJJDuahEYaMXUKUFUJjq27QN
	x96njWlcFxYaQ==
X-Received: by 2002:a05:600c:c4a6:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-48716042c15mr81428365e9.21.1774490425914;
        Wed, 25 Mar 2026 19:00:25 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb333fbsm33300625e9.3.2026.03.25.19.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 19:00:24 -0700 (PDT)
Message-ID: <fab5260a-b83f-4750-8b4e-ae5c1313d7ba@gmail.com>
Date: Thu, 26 Mar 2026 02:00:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] net: sfc: avoid format string warning
To: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>, Jeff Garzik <jgarzik@redhat.com>,
 Ben Hutchings <bhutchings@solarflare.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260325134557.3406655-1-arnd@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260325134557.3406655-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 995FD32E32B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 13:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Three sfc drivers contain the same *_fill_test() function that takes
> a format string argument that gets passed down to snprintf(), producing
> a warning with clang-22:
> 
> drivers/net/ethernet/sfc/falcon/ethtool.c:227:60: error: diagnostic behavior may be improved by adding
>       the 'format(printf, 7, 8)' attribute to the declaration of 'ef4_fill_test' [-Werror,-Wmissing-format-attribute]
>   210 |                 snprintf(test_str, sizeof(test_str), test_format, test_id);
>       |                                                                          ^
> drivers/net/ethernet/sfc/falcon/ethtool.c:210:13: note: 'ef4_fill_test' declared here
> 
> Rework these to take a varargs based test_format that allows better
> type checking and a non-varargs unit name that gets pre-filled by
> the caller, so that the compiler can validate all format strings.
> 
> Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

