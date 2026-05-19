Return-Path: <netdev+bounces-289418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODFGN1BNDGqWeAUAu9opvQ
	(envelope-from <netdev+bounces-289418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:45:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985757DEDF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D963300EE9B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF414A13BF;
	Tue, 19 May 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA5LbG1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38673A9638
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191013; cv=none; b=bD8Nv0TBb+lB+swSPx77kmSj45SbYIyiX2gkZY9n/5LM/NQbeh/bZjqgpIH3whpWhBN/cWrPPaaU7nk01UxJC/hnkrG7iliTPm2MdqY8oS1PUvDH7nEe7WxaY5WXTnpz5VFaBTXB5zW+OAEcbKr02bje2CmfLNcwWvHZD9LI7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191013; c=relaxed/simple;
	bh=uqnz168Z/NZnWLL+NvwgL7tHVJZg79BGKcxiyfYZqas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfCgAfbwFtL9PAtI4xE9+3IB0W9/ZJZZTJzvadrMo+XqZfFLzokX8+njFwrB3L5yriLDJbIfUFrkzM0OiNnxv61jI2Az3b7Il09W4UAE6iVbSQWv+zGP51Yl/VnG8upyW1m0SVR8mpH4Xdg69Nya7vgF2dc7CR/g46dqw7LkoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA5LbG1C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so2002827f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191010; x=1779795810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=830uqqsTMsd/ozJU1fiYeCoziwF9njvd4GwHw/ftDHc=;
        b=CA5LbG1Ctk7i1t9L2quu16aCEVkbnhAZ8gP5ZZcUdRvrGjM3IxL6yWjZ0IIyT+OIs9
         TdaAVtspbfIB+WyrJ1k5TjuFgtl4R2kAlcLeWylPXquuVQA43HSevO1c89U3KwGCXQzP
         cL8plifMWgQKDof6HO4cGWUzxidYasBCQJTi4vbfRJSiFnJc3oaX7+uzvPhkd+uUE5Dx
         EAF1S+eC3Lc85bNYjFHsigOLvOCEFUZhbR43vqZjRj06cofFlV1lKvbT5s1ZzQFqBZlj
         nUQRZUJ1MoDXnSrFvH3P5VfNybtH/QbPctLspAOj8RRkk6b85e8+FokgarE3kU1W1HZJ
         ObPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191010; x=1779795810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=830uqqsTMsd/ozJU1fiYeCoziwF9njvd4GwHw/ftDHc=;
        b=lI76iFYGReEcl0abjkAUoN3jE0kodYc+C3Ka3QMS0CZJt/sfHZGXXPrO0P3uN9UejV
         h+CXTKi8O/2Oe+HwI54sTWIAo1dGrNoyn+Ui+hHjAIy/zJiphoYsg4SaywfjRn/jBWKM
         IconIKx7WtWmyXr1CosuftBVDLbCEJMypsEagEZsrAAfnq+dPhJ2ZFiYhHgX45WT3LOb
         qjQb6JruV7URSYuibIYfnWm5tVEv1UU9MnVPy3jCShhReiECWqE9OULIeU/ECrO9ObJz
         ph3cWSiAMueWKXcFjsmKGkwWw5QKnZ0tcfNgdfY8J+wgg6EJX+vDumnvmiXAYuspAYsa
         gY7A==
X-Forwarded-Encrypted: i=1; AFNElJ9jp5d3ysQxo7xxVDKBi9RyH/n1b4VlSdCWrYIhXLvJrhq3jCe300n4ZAz7ZzT44RmAZuEq+ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsmcGik8Q2MKq0/jxDOWSt5UJWFMlJP1txBgDOlMl1P0bgKN3
	EHBnaLlCl7qkZSpS2JZCdwhgumeQ20IkVFk3Fxf09mk9iwNh/ZT36s+g
X-Gm-Gg: Acq92OHycs5ffiI6t6zvkAIMuQVjbfx4cdc+rQ6POdojtyEnu3FyIMw9Iyqg5gYy03N
	YCNhIA9rh1N/kFfOFAVxD9y9eaGUczeLsGsHQ5zl7WJoBnTHypx3dD//CXT+YNe5zCi0uvKq4y/
	q0lsMBu/j0MdcpWt7ZnwsZEUQfTdb/iWGSw8L8GFbgNo7wcdLxdcUaRwvQ3F572YNaX7sXG3HP4
	JtadaP6ihjX4yba9S5Ava4TkrY/brYmnxM/8BqkhmcHvRGRtSkjbZ1weNE1gLpatgwzf4LQ/IT+
	wjDAb1FGC+feJ87tDVHDlDyxWCgxR9Ch2hZKTzbCdTxsfoDm1tCYANoNNRmT6wP0s4R89o+CVEf
	zOdhipNhte2pbvLW7eHvrLENEoG50ti5lf16VsXVrXqcgNvWZMbY7ZrNZRrqAY36lB1WeSrz8Ye
	3DUvPap9F8QNMwd43gf38+yrwcuW64lvuF4aId5Z0z8/N8JYrTlUC6crZd8ep7gEDtOr6KZ6sO0
	eRwPnUiPPktvJyztQ7jvdgWbfT/FGFBbuXpgvPcP03xAxvAmRrLS1e+QjJDFNhj3IYnafhFFEk1
	rw==
X-Received: by 2002:a05:6000:2087:b0:441:36b7:7262 with SMTP id ffacd0b85a97d-45e5c36735emr30499432f8f.13.1779191010036;
        Tue, 19 May 2026 04:43:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm49237372f8f.13.2026.05.19.04.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:43:29 -0700 (PDT)
Message-ID: <260923ea-7871-420d-a822-cde2f4c105ad@gmail.com>
Date: Tue, 19 May 2026 12:43:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] io_uring/zcrx: add CQE based notifications and
 stats reporting
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Vishwanath Seshagiri <vishs@fb.com>
References: <20260518153532.2835502-1-cleger@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518153532.2835502-1-cleger@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8985757DEDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 16:35, Clément Léger wrote:
> The zcrx path can encounter various conditions that lead to internal
> fallbacks or errors. These errors can have a large impact on performance
> and functionality but are not yet not being reported to the user which
> is then unable to take action.> 
> This series addresses this problem by adding a new notification system
> paired with a statistics structure. The notification system currently
> report out of buffer and packets that fallback to copy. The statistics
> structure report the number and total size of packets that were copied
> rather than received via the zero-copy path.
> 
> The out of buffer notification allows the user to actually adjust the
> buffer sizing when registering zcrx support for the ifq. Some future
> work could allow the user to add more memory on the fly to the pool so
> the page allocator doesn't run out of memory.

Looks good, I'm going to take the first 4 and send out with other
zcrx patches.

-- 
Pavel Begunkov


