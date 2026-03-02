Return-Path: <netdev+bounces-262923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOMpFmkPpmnlJgAAu9opvQ
	(envelope-from <netdev+bounces-262923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:30:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71611E5779
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C792030880F8
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF729D26C;
	Mon,  2 Mar 2026 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+Cgq56G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF121D5151
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489862; cv=none; b=ql4h5xa5pdOjQwacw3TVkkjhT7o9R+J/7XnWu6BhNUWV42Y/WlMlSu+zdR9pXDPw8ypdB3YoFVGwg9JRZPFqOEQMjuPiJkim2/VVBrLTweha19B6LKFUewR7JDgJPrcy3+q9x437xbveAZ5J2JsTFZr9uvKXhdtwVfpg8//5EG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489862; c=relaxed/simple;
	bh=e5cz2bIVLbsU+cAPQA9qjkP/tzkHzHpAi6s7NlZ4zYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSbW12s4BQVTlrIS/J/5+YboJjqKc/jpRdHNoaKA1UjiJpVrba5E7AF8kDOtRSqVyEF0sUkRuqJcGXxGut7BCEGUYg45fozQ9Z5cAm+6MYK7ZdbbyMijulcOd5FR7YRyXBzZg4/BLj5VNdbT1Xb9TWOPTBVn8Wvgi5opGZ9TVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+Cgq56G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so3864454f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489860; x=1773094660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20ZBvw+8A17JrzKBL3m55KShBJ8EWIYwmxPjaH7SOVY=;
        b=g+Cgq56GKNXjRgcpH+R3pudFJZol/HdQb7EjXM+tstBiGT18Pp6c41cSgku7oDllCz
         +Ld+BcEgylUkgHnVSlg1JYMtF71szWuapD1ierRfTTHCUgemsd2jTkF9ije+d0NC0AfB
         O3a0MnOmaC8sDt+/Bh3nlTT2vKVAhTB/5ptTLhHjAWiGPF9vFiok3QUJkjbPZHCx598N
         h4JfOC1LCsISTtOyBUT/cly2k/WdnZs/Bqp+v52qjHlFAZj+lCseSkBQR1E502MWw2UM
         NP0jnIkchYlt5PoXAV5mFlkjeGPq+10Z3cRxQuE/tiYkeYtV/ux5aIR5Kp0LA9OyhG2o
         7Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489860; x=1773094660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20ZBvw+8A17JrzKBL3m55KShBJ8EWIYwmxPjaH7SOVY=;
        b=tY6pThy1JCmtfgwYjwBFZoK0H8/edUj9l33iop0vLTmT2SJSdP852QYcLg9BrRDXoW
         gq+P16Z/eqRZVrQHGmfBoGqo9bbR4GlaNzZZbpPNnuoXbXl0fGNJeXxDXtCeYwAfZWnX
         akDPaCN5euBFsXjU1qQc1MsYUS7EKbqcmS4piJjoRVCQ+a4Ys9I+nO/NOxcWwRUTEon5
         MV+Yu52RVI0jaG934gD4ADk3lnyl4vmAICLVGpi0lHNcid3K1P9wSTw9FArqEQ2CmmDw
         lC4TrvNe3IDhKq/EZeRuCMCa6TngEstxXGnoU3KMIBw2N/hiNO8d/xyttJ6c3szMhVER
         Waxw==
X-Forwarded-Encrypted: i=1; AJvYcCVcX83sffW9dz3ZmgF2bAuzUKlluGWejvyfuUtENmeUZsm8QpG7KhgiuNDyMA8Czu0jyZK4Iq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgy5bOz743Af4PMQN0cvd/azqqxAIFqkG+SXshfCbkJwk7bw+2
	vtthDuqiPormCFreGC/dAYqL4HdNnWHiT37A5MqrSl0teBfAPseGHVw0
X-Gm-Gg: ATEYQzxPNTtlnXQMsiHe78WsOSLdRbSGKGM8VOfTf8cZbt/GhGt1aM4nC++NlrXsTLy
	/jZQYMOlc5be6ZMEZwembyDJ3FZZAz0RraLSQtOObd0PIX5sjADD4w1IYabZ2+4aVkXmJK0JEvz
	yDuzKo3G37Bqu/adDRDvmlvjrY7l3Xox5RuA95gCtLFWLtuoQZPS5H1oYckER32HAp1vpDqBAlR
	QzrA0F8tPLX3XFHZD0+K4imeNlqvuAbCPC3AdZN4rsz/xi8DNLpvlvi38k6oTMdRfrysIP97coP
	i4tRqQxL5EOZg47xsPaT2L5D3sntebakvm3IRfO81uZxWPt6PWC+NBoxpp2yi9RuYHIMVe7bBKV
	9uszifJX76YAI2Ad66hdUwagrWQr3WxUHWrOp1bpkxb24mDV8vZqozxeNEr54h9G6sAbsu+Rv2v
	cOFLtO5yWnMm9e+5+CmXU7VR5ekBe2jtmnYVwId9vyrX1N/sdDVZlaqSCN7u1fS8w9iy9piuqkG
	y9fdTNCf9Se4Aje9vid/gCpGCHd7rGo6LZPcIzsOadEM6OQQMnbAnKVw9syBsQmoRvV0/L3poCc
	lA==
X-Received: by 2002:a05:6000:3106:b0:439:8f32:8674 with SMTP id ffacd0b85a97d-4399de3e2b8mr25504482f8f.53.1772489859516;
        Mon, 02 Mar 2026 14:17:39 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ac9f3e5bsm21544589f8f.37.2026.03.02.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 14:17:39 -0800 (PST)
Message-ID: <0350d0fd-3037-4c04-b9ae-31bdb1913ada@gmail.com>
Date: Mon, 2 Mar 2026 22:17:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix post open error handling
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk, netdev@vger.kernel.org, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C71611E5779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 22:15, Pavel Begunkov wrote:
> [ upstream commit 5d540e4508950c674d6feef1d95463d039bbf4f5 ]
> 
> 5d540e4508950 ("io_uring/zcrx: fix post open error handling") fixes some
> post queue open problems. Instead of picking all dependencies for that
> patch just move post open error handling out of the way, so once a queue
> is open we can always report a success.
> 
> Move copy_to_user earlier before open,  and xa_store() should already
> never fail as the slot is explicitly pre-allocated.

I somehow lost a stable-6.18 label in the process

-- 
Pavel Begunkov


