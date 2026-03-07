Return-Path: <netdev+bounces-264975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SXx2Enpuq2lqdAEAu9opvQ
	(envelope-from <netdev+bounces-264975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:16:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B64228F1F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09AD3023DF8
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98B1F0995;
	Sat,  7 Mar 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f326SsiA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6A15A864
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842615; cv=none; b=BHPvfFzEseKH+iBSuLqhX6Ig/KkPhAPktxS9W2b8X/s0/oQK7lXVdPsrXbReFPj7+yvMHa1XVhZ8l8TPAD2UWTm0o6sjdPQZJQe/++3NDr9cPNhdy/dVYgxAiDmzaQUa55FJmtNX4dvpxIvKmBg9rpLnICrnyp5UKNvkQi11Vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842615; c=relaxed/simple;
	bh=1jv0YDV7RqtdHN2gn4yLfwYeFPs7ErJgmFYQAG6c4fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRwTHUaOutPbLG86+OLwgf34oRHBrEXAcCcPbX0wP3mD2wxrElK70nHJYpLb+9/I/+NOP+zmRS2OCXx0wJ9N3MwwSAWcYM/x/0Mr33VfoUY3rBD5VgdyMOTkZ/JjO1HAx8jhMa9EVBkE90NSCB5fptA7KlgxIporZbzg7b/dw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f326SsiA; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ee486a76eso3297362fac.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772842613; x=1773447413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khtC211O1SPtjgbhHkTQFVSuPgpVRPnMlK9wnraiQFs=;
        b=f326SsiAz7HyCwRtKvTPOZwnlA0cFq66ndD7DS3dBnG7oMXxo0HQxpoh2d36FsLIgb
         vKd3OOVWAYm8a2fF4GhMRCOvNAxONvbyYEfL3XhuOgbAKE647wN8d0kWVgoSCTwgEmHd
         zQTC7HwgeLhi+kaeqHrrVKn7Oq7mbmF10syOm28Q9FxgUYNFXfxunUZxamfN3MkmyX8I
         z9BZD3A5p3wPI6vZI1TMt97rzu5KTDQQGo2nFQwZB7RHzpHRHiQF1aDYKaEzjMcYE2kA
         vHLhSmmPOPUuDYlIYcw9pVNXoBfEq/hhCkVraZmAP6AnIgvj2UPKGA5+ZOqX2r0vNAip
         E2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772842613; x=1773447413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khtC211O1SPtjgbhHkTQFVSuPgpVRPnMlK9wnraiQFs=;
        b=wlIVH11wUBe9Ie8g6nL0iARNOBOkoqhpYnOsjtiO22KNDobCFyEDF6BAZ89t7LpFbj
         omKVgj3+ZpRUKijljLoaHPKjrjhQ0EVxDM4vxqOkIAhNHEHua6q8FJjQgRHxCt2DsW8T
         W8zaqk/XTaXxW/hgRSqlNf7+GaOutpNvy4mZ8IRZq/5VwaQQzZijEN85upwvcFpdAt60
         FArxkXBB8azfg2JsU5MtEQ2iJxTK3YBYrfGIYi4LIgLkNYD1sPDBSj2D+I3mdxPusjwJ
         xwRnfozi4QhWVZDQjAkoTV9e6JnXVdEpGsf7JschXRmM8Obuyn7uAb/dUWTaABKuVLAN
         627Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZzTcR/e2mRsk6tu/GOj1RI3gQPREikLbg4BY1wHE3c2fG8GF5NQlJ4GNacBS2721IBmiqHFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzif9DD7zBJMRtygbdvXCHETN6LQGU4Eai4RpY4qlG1BDs2roKP
	JhFDlaiu7JiZUQTEDrhjag9/xdX0XR2zbAJVQMjnBFSzTV4tfzZYpX0/
X-Gm-Gg: ATEYQzyYjxu1pvTvEctCdRT27Z17qGz9bUXnUYWoMP7PHvTKqtKGJfKNfHN/nAH6Ya8
	AQwwnsYVL/jY6wA1bsRdvVIF6iHw/2aAvKhOZFUUc6EhrN2A0In0diSa/Rc6Hh6+ch4vDyPop7M
	4DAYcVW4rMosFtWPKgI8ETP1TCHBj9rNMH36/CQPxH8fXYAjTp7ms4DED+m+aPlUb7sMo4Tsek3
	ZC/aKfOjPecUVJnhq516kbPZRkrPxn6UGU3vWwKXpGCkCzNQ5QEw46gLS4vTXAVKocdtH1lPSJr
	p/wrAxbDSDdYjcj/Hdn7aBDk1n4VERW2Nlp1wBPaIopgyhIP+RpbhnQLX5e+yfPyfjkNEKfF10A
	bqPkgr7mwm5Sdk1QHjSclAgLu8mUN5diPvc13BvRsO4I0YkUSHA2UWGsPr1o5z3DHFQW8xTnEeB
	bHOUWL40EN0R76/ndCJ1nxY4MLi/7nRKECqr643OliDZa4S/g9CzRMv95gnio4C27DzWpOsikRf
	JIu3D6wFl7LpKWrpXly4UMkrkbM
X-Received: by 2002:a05:6871:7817:b0:409:770e:84a with SMTP id 586e51a60fabf-416e4415b81mr2392465fac.34.1772842612701;
        Fri, 06 Mar 2026 16:16:52 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-416e61b9c24sm2739930fac.0.2026.03.06.16.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 16:16:52 -0800 (PST)
Message-ID: <8d4e0668-9f96-44fa-bfd5-898e6f5a2827@gmail.com>
Date: Fri, 6 Mar 2026 17:16:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/4] Introduce FRMR pools
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96B64228F1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-264975-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.876];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 8:51 AM, Chiara Meiohas wrote:
> From Michael:
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 
> FRMR pools are used to cache and reuse Fast Registration Memory Region
> handles to improve performance by avoiding the overhead of repeated
> memory region creation and destruction. This series introduces commands
> to view FRMR pool statistics and configure pool parameters such as
> aging time and pinned handle count.
> 

reference to the kernel side patches? have those been merged?


