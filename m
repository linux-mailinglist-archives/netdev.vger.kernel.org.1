Return-Path: <netdev+bounces-268262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAZABQZcuGl0cgEAu9opvQ
	(envelope-from <netdev+bounces-268262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:37:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4829FD86
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A05E302A396
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74B3ED112;
	Mon, 16 Mar 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V9gJGEMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3734F486
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689859; cv=none; b=e/5NTATdYOUCtb4bULJwq/bcI/UsLNDYaCFZkwKMXHSBWfeevNcIsjweGba5nMSPXf8FQ1tOnKOwmuvuuCmWAnmCRZgaqYgXvFcGiAYTRrma9pRTMj0komGQ1RN0crYzRo/JbiD+Szi7uhVN/h+SSWLz80OnO04f6P8hH7+TYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689859; c=relaxed/simple;
	bh=ZvsXSyiI3XkbsKZuNkcSgsTni+v4WLMdb2x9NUrXcM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3pCAyt26X/2IJCi2zkD7tUPBqMlo27cg7Ilo96XEYcA0JtNYlubLi4AAHQCg3PbcM0uqgJV/y2VrIK3o6T8GZbnoDWfWgrMIkhFSWc2h0H0214ArP3QldI/L/NGQWRUfpMst7zLmglAPP/5NfHbezLkwH3j8qkLtKCVDoorJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V9gJGEMJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d1872504cbso69604a34.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773689857; x=1774294657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTI4ZGyhMvb0csBBlNJg9TpIQ4OoSUyId0bqLGFvRG4=;
        b=V9gJGEMJeyQPEUQoq9izwPN833JdTjNkNnsg4VZ/+fCFTH48JFcd8wv+fsWT8ST/yU
         klaxnuhF6HFEsSdeMgQwqanoKL/qJ+quPTuHr3gYGCAp0XmpMvHHkKjPCK6R6sv7tm3m
         vjvFoOi2OItk0dQPsz6Uj1UvINuWVdab+kma3F7x2JkQUD9rVR+ddS65zDiAYR8RfJsr
         pxr7ojJq5IHyxUtV8KJ2jMkKbj4jjyRyzF67oaCRQ0hFY1J4WZsFggqVVpDz0tnOplVD
         OGQYZliyau63hDIggJOS/5aPQi4M+OC+t0xjnvbEdbKeZUpLs1MqwiH2Fhmw9m7x8Ra7
         BWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689857; x=1774294657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTI4ZGyhMvb0csBBlNJg9TpIQ4OoSUyId0bqLGFvRG4=;
        b=rWADEw97tn6DKWpmfYwQdfrPe7V/IV5HLl0i3gwISHFbUfT2IUSDdNPxSW1v6ce/t+
         yJTxydE0ZZqKayMyARmshWqT2CNMz01AEmNo84RdG5J3FJYM/jvbMIeivwuAUBMkg76N
         zmV54we0U3ID3hSQLHm5uvisKI1nFBnVBzAJz2u9QBkg4s0DNV1zFqUWppQ7++A4xPAb
         yDSZK/vDSS9tkC/AE4z1QueYYR9GML5GggY4cwpAn6SGOevvJxwnNReausGAd7E3F82X
         mRVwxViXPsbonG9OKHLByK+c/iRiCXAvAlAOdTDTI3w8MuNwDwS/aVgGFi7ozxlLWhbh
         m4SA==
X-Forwarded-Encrypted: i=1; AJvYcCVhF7+yrDO9nhsfVHdUljDQ1umFx2dzR1U9prfoH015JyETWBFe2Da2QAatWVVWD6eKrp9SziE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6+4K10edzhHL/NmnqRqmgGVCx10IqmS+Kii+Ao8FnEJAb2Yp
	qTzVM88f2GefCHKNvWr9V2J8QoI9bvBlHRKJ0+xHJNCDHQQlIpwAg8m85n/9E8K4C8X64Ki1HZ4
	oxt6dDDI=
X-Gm-Gg: ATEYQzwh4QZh30FkfsQpzYcHrNf1rQYVyhE6f3K/StxF0/nq7nUnHicFXAB9nCVjwjy
	9COXo0LT2swsJm4Yml0ULUILRKBzppBvbAOJfGE5Mn/v+gaDGF8cbmEMdDUIuqxLzKp58TK8R2A
	ebsJJDro91vwpYgv8tRSWM+bAwV+70aRTZYA3LTSurd/vnF8+bSv+sHfsCyxKssHb5BEujtY5C4
	hu4g3mp+h5Jrm6WV10++tSKAGhX7gJGpBVNIbEPS/tJU2qY5zUQVdq0p6c3EC846+4VzJXLdBWC
	kXf5EuJ7Wp82TVpkY5qbqXojxw51hLNORA4s1CEuEEbZYEugJiFyH1AADFJRBjydoFuTAstQdEb
	6rJ8XUniaWMjAwIpuGt6Cgcnfg/TvWBVgxkVmJLdNUNdr8pDTaRLEXg5RMfL1tEnanp8NEKCbHa
	2eMCkOhm318TFguCzUiczy41SW+ygyLyFD0YErlDG7RAnOcQadld1Y1O3FyEgovYw2hNt/s8GgA
	9ut79Ckhw==
X-Received: by 2002:a05:6830:3591:b0:7d7:4c90:ddce with SMTP id 46e09a7af769-7d7bb6c99b9mr470879a34.7.1773689857004;
        Mon, 16 Mar 2026 12:37:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae39b39sm13970767a34.15.2026.03.16.12.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:37:36 -0700 (PDT)
Message-ID: <1f79957a-5b23-4bbd-af8d-9d1c86791645@kernel.dk>
Date: Mon, 16 Mar 2026 13:37:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: cast id to u64 before shifting in
 io_allocate_rbuf_ring()
To: Anas Iqbal <mohd.abd.6602@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316150636.2123-1-mohd.abd.6602@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260316150636.2123-1-mohd.abd.6602@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268262-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: ACA4829FD86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 9:06 AM, Anas Iqbal wrote:
> Smatch warns:
> io_uring/zcrx.c:393 io_allocate_rbuf_ring() warn: should 'id << 16' be a 64 bit type?
> 
> The expression 'id << IORING_OFF_PBUF_SHIFT' is evaluated using 32-bit
> arithmetic because id is a u32. This may overflow before being promoted
> to the 64-bit mmap_offset.
> 
> Cast id to u64 before shifting to ensure the shift is performed in
> 64-bit arithmetic.

I'd be impressed if 'id' could be large enough to cause this to
overflow. AFAICT, you'd need more than 64K interface queues registered
to hit this. So I think this should be reframed as a cleanup, to appease
smatch.

I'll defer to Pavel on that one.

-- 
Jens Axboe

