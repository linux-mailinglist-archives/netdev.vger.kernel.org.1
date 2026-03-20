Return-Path: <netdev+bounces-270038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA98ERSbvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA72DFB95
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 818193048894
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C6303A01;
	Fri, 20 Mar 2026 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f12mF43N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C863016EE
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033478; cv=none; b=LaoHaXPtW+13tKQKdxRxOgGUcBEMvqitnqKL3RgUrEjuOeQgjHqT/WQm7RKFJNnX4OyvKyNUtcHQnHlLqxcrOiUwgi3dgJhmu9w1eCWsXBkYM3+LrbK5bvrt8qpvChaI3CLIZMcy5w0p9Wf6WK0uYBoonZpJW6QAo+xa9et1y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033478; c=relaxed/simple;
	bh=y4xjiVBHeQF5JqZbrncshkWLcltuy9g0ZxsUn3RToTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSNKnM4fWTmHsr481yG3i/2BFBJ8F5AP7rhei2hwut5FCFBgQzU70Vhiqn3RxdD/zFJaXQm+EmcI6dsbqf5QzXX8W16ItlE+LCTlK9AJCtRnXxfcpiRaCLHS1ibxeQVz34GpWu3I2h+oA/2Mxp1ab865Lr1/nnS/BgJk6kuRBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f12mF43N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so2256116f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033476; x=1774638276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rU8hROsash8pjNenSuRQmTzxfx2+/q618jsTqv5sedE=;
        b=f12mF43NfOplMF26NlyDg4yYTjXoTv3VrPZ6xJYEXxrg7SENZXSyRQ7bU1Q3PjjAAe
         gxYKlkUJoWoAKvKMU6iHeLIQzV/SsPFlFWw2iKzfyM/QY6haPg+HMnC8ZGqDH81fkbMX
         sdxVPwt/QkL5IMbDLdMJP+bbL0EQa0oZFE43Uw727N5cJqPGV6XZG6TkEJ33TI8jIgO/
         ovJ42EEzjdI75D/ugCeMxu4g66KyaX3fhvxi7anAhN4q2u4r37xDhCd16BSIQgVWxzP9
         IJZioZD7BJfVOn9LdPt+m6Sz+LnQgU4nfAS2FEVeIvkxEZPke2cd3j4wFdNOmdtIEmfT
         7hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033476; x=1774638276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU8hROsash8pjNenSuRQmTzxfx2+/q618jsTqv5sedE=;
        b=jF3HoTkUtPnZKhXX7EeW3PvKvCaejq6uocNqSgNZ/CSqPWOqc1AN032suvFJuykl0g
         LVucmgwJvV3a/c/9H8VLZteTDh8f9uvxnwV2B9iSQQeOnupLI4XlIaDYaXW28pvRLzOT
         ti87wll40MIprelNlxNH4kYjzGOowBIBqdM9ssi9JltqnZH92yTK28Y6OBJaxXSPqoaa
         a4TO/Vk/KvNH3VkgK3buKGhhkHrI99xP21tgR+gc4Of6QQts9XX3ChFvaJ0OmrzP8v1g
         8ALUQBQCjnd0ylUcWOmNhz5nTaFdHbz6IXR+bu35O4c2SUWJBtvM++i+EVjZpy3Kk89e
         ZZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfTDYSDa6RAio7GM4kYt4H6q7a9jVbvCuGR7Wx58y/R2v/yf4vMPy7gomYuNS1VjRgaZ6bbgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlspwONqvNVAERY44RnW1CrQDYzbGKZ/2BhbXdzMEG89uF5d5
	6hs6EgXhvW3Z/cdtwGrhKRcQN5nP+hCCB/fi0frMlnvLcPqQfeY0Hk5v
X-Gm-Gg: ATEYQzyOp2V3Ae290ESBZNXyxtwLzMoeZWXqmuXHwPxe1ib/YvmQnH8FtOaeB8UPG9S
	uP7CGJ716IAYKAP2QQxxjuAVqHkAk+dpinaMfMzKZbdSPjJ1LxgPYRcJdVYfutz0VJPZKwPCG4G
	bgME+Y1seQsCtESXldzYwvIJvdpAdPscrbOFLvL3I5QyQrZRORXPkyv7hV3pd3YOdmD9cXPtdwt
	K9/sfP8f4vxreV+1z6I5YCOgDPDkXuCWq3a2isA0OQIi2YnufyQhITx90fl/bTdW0CHEMta9h3r
	trFTm5x2RxhFA03LVw2eFL4WYEsqBE17mDjfknLBkeEoFBhDBvRGgiITs36RSXj5MJwXVeJqYkj
	PTXezNUZQ7Xu5sJNKpK+ffnZrWzAHBsus06QNm65i+cpavtzthimxNQgRVlHJJRl/rprO2Lxe3c
	kle/spXNiKAleiZ14ijpgFRAOW5X8pqwfXU3Ne31eytSExPOc3qe7AfkjmHm8ELMkssf+QU7QTv
	SydGjjeQ5eTWE6z4zdrTF00
X-Received: by 2002:a05:6000:2407:b0:439:b3d2:3766 with SMTP id ffacd0b85a97d-43b6423fc13mr8053476f8f.19.1774033475555;
        Fri, 20 Mar 2026 12:04:35 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm9802710f8f.12.2026.03.20.12.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:04:35 -0700 (PDT)
Message-ID: <90a03d3c-def3-4e34-89a0-6e952d3b0d7a@gmail.com>
Date: Fri, 20 Mar 2026 19:04:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sfc: avoid format string warning
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
References: <20260320151924.3474821-1-arnd@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260320151924.3474821-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.893];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: D2BA72DFB95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/03/2026 15:19, Arnd Bergmann wrote:
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
> type checking and avoids this warning.
> 
> Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm not convinced this is an improvement.  The function takes *two* printf
 format strings (unit_format and test_format), and this only annotates and
 varargs-ifies one of them (and doesn't harden the unit_format, which has
 the considerably more worrying-looking "if it has a % in, assume it takes
 precisely one int argument").
So it may make things 'look' hardened enough to satisfy the compiler
 warning, but that just hides the unsafety and might sucker future
 developers into thinking "oh, the compiler knows about the format strings
 so I don't need to check it by hand".
I'm not sure what a proper fix would look like — possibly a rewrite adding
 a separate efx_fill_test_perq() function for the cases with a nontrivial
 unit_format, baking in the knowledge that the format is always "foo%d"
 for some constant string foo and thus we don't actually need to pass in
 an arbitrary format string.

> -static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
> -			  int *test, const char *unit_format, int unit_id,
> -			  const char *test_format, const char *test_id)
> +static void __printf(7, 8)
> +efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,

I don't like splitting the specifiers/return type from the function name
 like this.  It's not Linux style[1].
(From a quick poke around the tree, there seems to be less consensus on
 where the __printf attribute goes — some put it on its own line before
 `static`, some would put it between `static` and `void`… sigh.)

-Ed

[1]: https://lore.kernel.org/all/1054519757.161606@palladium.transmeta.com/T/#u

