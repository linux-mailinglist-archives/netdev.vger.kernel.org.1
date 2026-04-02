Return-Path: <netdev+bounces-274395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFPdK1cTzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AA384CED
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BCD30A3D1C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62F3290D1;
	Thu,  2 Apr 2026 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEJGuH3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAD2DE6E6
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112616; cv=none; b=REIYSwY6QtFdIgJW/E+p8rG+QnpUMf0LrknjzcEsPrWH7fZHrC+bBCEqaqBTaXmbyvej6duzh0rRNzr0nBD0ooyzT6JWODpApsKnxZPXc31Q0IQVuWwICuZbNtC0g9iWYcl1fF10hnjeL99Qzg9mGMphlgsUfqYhEJrL9oR4c4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112616; c=relaxed/simple;
	bh=3rSHWn7UoamPGnUOn51s/hOG15hAjXMkfMfbj1N50IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFC14nU+P7MxZ1iPQrKaCp/7DDvq93w5qwWs4vrmNPhjT8sD2blbeQFr+2DfHGAWGuNLg5UNoG66dSKGSD9aIJ6BlHM5pX12P7WNuoPWeztMoWcx+KGdqGPbEP7jQyG+NeA4zPu97AAySAUbd4n9UPv3QQWZjOslQZK2/p15aYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEJGuH3n; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so196166a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112615; x=1775717415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3ehP84OFtuI6XEmihAzRt+4hndxck44CHm2feI8rsU=;
        b=gEJGuH3nWvM1JPG+nVXnOlJl1RB9KwUWRVs3oO4CW9cFjS7E3MR+Rq4fsE4eq3137S
         jyLy2IyC+8rdUovoHOXXS410Rq2xvMlTUhWXr3eYazy439sPn1qASiwEE5NzLs3YZQIQ
         JEW2LjfroqvG6AUEZs7Vqi2cY+rltsZZheRVg3e99VEFvY/jKxz3MZQginXP7YNofgzx
         g04BHd9A1pFhhpqznJ4Isq703LTtaKm8Vl9WI6kS8MtlkfZBWbrjZQ42QGI+t1T/aGDD
         5Nv9YLCYBsJVHRbxEC0eJ0Xn0zC96+kNhfOdr3cfDaVbwEpGzwIcw9nNshSTnwfvPU1q
         FeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112615; x=1775717415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3ehP84OFtuI6XEmihAzRt+4hndxck44CHm2feI8rsU=;
        b=ivBFMFnmIrIqQh4MJAwQ2TArqipn2pkjqGT+En7ZFpBGfzlV5EU5qis1VKKsYpjCds
         8GBtOGXgLyaDhAVY/2tNjsQ5Y+5aEaDKE14XMA79mcH+LjNeLheQkEWTjZEQWjwaA+eZ
         fpp5esbrcVsPQVg5MShvKywDBTrMT9bbzMOZ7ADTeOW8QM+SCs2JDl9LyBtNgGuQsY+Y
         r/WtGKUrmtluTsptm25+HD5VKehexu9K96Jb/4lTV42vTshpSZe+RAnjRVhuhZsfcUJ5
         o/IoCCNQ2+faiEWJZyt6+mvKQaSgxTCOTdBv4QBovE22L1PkF0odAhsFNUJ/bzAzfIz8
         4Drg==
X-Gm-Message-State: AOJu0YzkupCS7j3AcUvEqu67GxU8n6Pb2n10vk+LwfQwHCGdyKHg4KAv
	ys8vfWz81tKWKKh4BdAWDCZ08pQFW0HYpSSg1l0PuGJjHKXs9N53kV0M4oI9kg==
X-Gm-Gg: ATEYQzw5mgy2JSSz8i7eO14JcLi8P7OoWz2BACphsHehDUGBCCgik08OHpAfkND9vab
	A2ErMpbIlLP0PxhUFT+6v+yPpJE/tYo7r2XMSA25lqBTU4VpJnijvSnpAJM3tbEhL983SnFiEiE
	pH9UCjseI0i9v+xrBTqbY6Lrl5rjM+ejvh/DJxE2+zpXssC3f1+N6toAqEEiJWd32ZVIYVOXLAY
	Hbb3hA9E5MHvxOj2RrtHFhfTqHL7F4sQAX/Cj+vlhptBfR+eZ7girWsIKq0FyeZDuf91rI2p/ZB
	Er9mDN4eybjH7x6wxr2//Mex3AicNmun7Firs7/iCuh8k4zigJ5ECruCIUpFBSv4RUmLf6H7EOm
	EeTOJOYBqRhji+biN3+omEZPFQpEGSSOQK/YTonFlhlw4wccMTP/f+6D3cUqS1+hMYTKqrE/HOh
	/hVhn578kys5reeUEo1ipgs8qo
X-Received: by 2002:a05:6a20:430e:b0:398:9fc9:e077 with SMTP id adf61e73a8af0-39ef76b219dmr6945402637.29.1775112614563;
        Wed, 01 Apr 2026 23:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm2444820b3a.41.2026.04.01.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:50:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	yatsenko@meta.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/1] Refactor dynptr mutability tracking
Date: Wed,  1 Apr 2026 23:50:12 -0700
Message-ID: <20260402065013.884228-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274395-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 578AA384CED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A heads up that this independent patch is separated from the object
relation tracking refactor patchset [0] to breakup the larger patchset
and make the review easier.

[0] https://lore.kernel.org/bpf/20260307064439.3247440-1-ameryhung@gmail.com/

v1 -> v2
 - Change the definition of the mutatbility of bpf_dynptr
   to only bpf_dynptr->data instead of the whole structure. Basically,
   only care about preventing passing CONST_PTR_TO_DYNPTR to arguments
   tagged with OBJ_RELEASE or MEM_UNINT
 - Drop MEM_RDONLY annotation as now we dont care
 - Drop passing CONST_PTR_TO_DYNPTR to MEM_RDONLY kfunc selftest
   

Amery Hung (1):
  bpf: Refactor dynptr mutability tracking

 fs/verity/measure.c                           |  2 +-
 include/linux/bpf.h                           |  8 +--
 kernel/bpf/btf.c                              |  2 +-
 kernel/bpf/helpers.c                          | 18 ++---
 kernel/bpf/verifier.c                         | 68 +++++--------------
 kernel/trace/bpf_trace.c                      | 18 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 +--
 .../selftests/bpf/progs/dynptr_success.c      |  6 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  9 +--
 9 files changed, 51 insertions(+), 88 deletions(-)

-- 
2.52.0


