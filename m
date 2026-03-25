Return-Path: <netdev+bounces-271339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BkUKNEqw2ktowQAu9opvQ
	(envelope-from <netdev+bounces-271339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:22:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8E31DF5B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87116304F00C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E071BD9C9;
	Wed, 25 Mar 2026 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrQg87yH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F110137923
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774398157; cv=none; b=D5b6vL1hmd6W1enxx4NBSqkUbZIrw+aYG4BKmOrK7b86AC8m5LlMDqMEdRVCPEQLfPbdyKTEFgyfM3+Cr96HhMRJUd3McC3EFZYFEboRbOQXDvjHEbk6xICP0iJ4GSZVHxo9+nv+oQReXsqpflyUQ3mZEY34b+IbySh/wK1bXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774398157; c=relaxed/simple;
	bh=C/gC1RsuIfC8njdMKE3omVveD/LHB1wKAyLzaOf575Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbV3rv7LBxYJuIOKLxUPnt6l9yta68//2rodnqhE9whZnqwxRlMIJxE4ujtPiZhCu3MPyZ21Cs0iRqlIzL5/ZKH6t3CXljym41MQVM1FaUbKZKhK/DQ6XCX+tcbS7dXcO1sdAgTSw8LlRDAG1ZOz/yq+hyGl12nHkbHNyTBrPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrQg87yH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fd27754bso15316675e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774398155; x=1775002955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3jYf8Bnnp8/yLh5y/kKlLzKOcooQBVfzdC+8/FhSVs=;
        b=qrQg87yHAUL46K0i1kpNqSYIyYg95isv1XEaKrGtwi9XeLbEOzLyraJWrHFtGNKKPE
         1+4oL2apc6ZxzhqKPhll3Sk3TOvXgvvRtBVqVd9UGZYKUarzzdZSdvZ85iBGd1WLxeVw
         Q2RaRhAYWCGOBKhRTtqNnwi7Qobm39GT0Bz53HFlftExnt6HVfAYtTZ8Yjx3+ZGJ+OhP
         PK/YtbQ3T5y9o5yb69stikaJKQnb+SWQb2yVuuBkHgXE/y01L1UwgB1cwtWGc08oKo4F
         oDP9WT5CzmCaUCEX0iuvmeAXzMFbJpr988wLGtvy9aXLhgiZxuKtM6BKMkp4MdncuJUq
         ZoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774398155; x=1775002955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3jYf8Bnnp8/yLh5y/kKlLzKOcooQBVfzdC+8/FhSVs=;
        b=HNtsjIKMNadrPQs65Iv3CRN9a8WkbI1IjSTfQa9ZAECKsRhPpTaykMRT3NUdkYZ9JT
         ccwFEGP5w3J/ZEQzdsF6FpdDBg+N7+2+ufVn5Wvz4Hf9ZW+Z2p42CTkeVifHlk28tfrd
         1rtk5hfJyhtNUZqf7fWYc1W1rBBagkO1KQHZpIt0QmSVud8rrCj1eUqs+X2uqdTUyTLe
         gHSbEk8BjGnhAYyZFZMtQhLatMVcBVHZF3S4yYUgPj7R9aYg8s6aKzdTRK51JnqZx+hX
         TEiX3mM+4ocKsxbzHBzbBQ1eh67WiJyC+na8yB7hUo+fbUbc1q8VL81TgQMIUkR7wDhZ
         7UuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXt+Oh4a7XYXpKRt+YhMxs8CblQlNgwQfqCnl9vSWxmm2XPYfQWBn5zXGfEsUWmRvno8ToKmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNeFB80edaadH9cj9/Ki0WMwTomeUkUym/j42OPQ07y/gchl9M
	Lv5y8QwpK80Q+wlehwGv2oKg+Kh4isNJ1BS+G3LwdToOFHpgAMjJhRGn
X-Gm-Gg: ATEYQzzkE0RO95F4mpYvBtmHH/oy0uOjVc3IdaCC+jO8fJnD3Tg5SZ9/oRtrh/QL7pO
	Cj9jx2oJPnlXTErORGBIKuZw76k20nipfxWH+77PZEhAtIc55uW61mCz7T+IH4cz8Vn2b4HA90x
	wgttWX8HcitwbhTc1FNQ92t8RiGIFb4/Z/lYvgJExQ9EmfX3IAIC12DwbeYYSrclTB0e7N6mdyo
	XUzm8YfoGcMUVNsYGRY78f8tc5pmvJ+5nUH+UN1nSmpnUvu+xxajTQ/kl4Nre37Z2LUeyzJ2YuG
	pk8q24it8nuFB8HIvsitQbcvTXI2emqwItwy2C59iED+9KOF8fTM7eNXTBPwQ1ZaKOkNHCDDS6R
	69F4XCA0N+kfjrUgLBkh1XSX5ZMae7xRWSwiEN2Z2dNMJBAuFJeKvUW3ZgoeJeMrjAFS0eYSaWX
	2QZSe31CTpF07GSExD12YHbXygi3u19lNuLkQ5DyD426V36JnsVISWiBztIcmLgMMqcUFlizwxA
	q6jM21G+lI5Yg==
X-Received: by 2002:a05:600c:3e8c:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-48716051e15mr22818325e9.20.1774398154499;
        Tue, 24 Mar 2026 17:22:34 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871736befbsm5605825e9.25.2026.03.24.17.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 17:22:33 -0700 (PDT)
Message-ID: <9763c19d-131c-45ca-8976-a6473539240a@gmail.com>
Date: Wed, 25 Mar 2026 00:22:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sfc: avoid format string warning
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>, Jeff Garzik <jgarzik@redhat.com>,
 Ben Hutchings <bhutchings@solarflare.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 Kees Cook <kees@kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260320151924.3474821-1-arnd@kernel.org>
 <90a03d3c-def3-4e34-89a0-6e952d3b0d7a@gmail.com>
 <61de3aea-26b3-4c00-8598-3a137ebef1bc@app.fastmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <61de3aea-26b3-4c00-8598-3a137ebef1bc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271339-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BF8E31DF5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/03/2026 20:48, Arnd Bergmann wrote:
> Right, I took a bit of a shortcut there. How about changing it
> so the other format string is just a name that gets joined with the
> number?

That would work, but all those -1s are a bit unsightly.  Like I said,
 I'd rather have two different efx_fill_test() functions, one which
 takes a unit_id and one which doesn't.
(Also you need to change the kdoc description of unit_name.)

> There are not a lot of good options here, and splitting the line seems
> better than an overlong line to me. I don't really have a strong opinion
> on where the __printf attribute should go either, but I do see that
> after the return type is probably the least common, so I'll change
> that. How about having the specifiers on one line and
> the type in front of the name? that seems faily common.
> 
> static __printf(7, 8)
> void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,

I'd rather just have
static void __printf(7, 8) ef4_fill_test(unsigned int test_index,

Admittedly that puts the ( further over so fewer params fit on each
 line, but I definitely feel the function name should always appear
 on the first line of the definition.

-ed

