Return-Path: <netdev+bounces-294991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DmoyOtjKIGra7wAAu9opvQ
	(envelope-from <netdev+bounces-294991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 264BA63C183
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:46:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FrlNUXfw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294991-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294991-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CDC8301A2C8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9661E9B35;
	Thu,  4 Jun 2026 00:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F30142E83
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:46:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533970; cv=none; b=QKxtm1hhQQpi3RoyNS/5zXqBTMT4UEtOLlAqPO5yF1ICyFT1RtikBdy43O9gILaTrqmYBdv6IZFLhMgmY7Y9UQPVXNyzUUMKSf96UHq7IvaO5VOtF/8vkx7+SA9GgVogIrendtI3utiDB7h8SjdDa+jO/J7SiRd947AC5mc8hXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533970; c=relaxed/simple;
	bh=4C6y2z/XTDC26AyRBpojFCbnM2K9+BeYPffxKjyVQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP7cz16rVICy4J+S42k4C6Ut8kkhjxhFYYWLYPHOlx2hrWGqdcOwecTgayew5rizvUbwl4pJnlio2+TxrYiu/7YAxP3L01s0uWvc4MJkATdYrzKVhwXMjnEDeQheKf7S150ywkWGlvfM8+YTTpxBjNJFlKH66eurG8sIh0CGXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrlNUXfw; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so74814f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780533968; x=1781138768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNgRjJgbYuUrLzdW/5WEzZhlyP27Ht6YujPqndZuMqc=;
        b=FrlNUXfwzS7pL69M0DoZJcXE3NOgDfUTkSvA79bs4sMyyTdDjnFXuGIVhIM8R+/vVd
         y8aXmKJWT8pf24DB278QhteM/8sKSgp2WcKgcXGcSroO/nWtaJ+m45Ol1uSVWr8cXaWu
         Ua+QhQ+F3q0XUr4/zTy0zqiEmQsX9/zupw2860iq9a0T2fwHxWTd8ShZduzbH4/qFehg
         9QBY89tzm3g190ZnNNNnaoeOtoxHpQA1pHt2HCY+EzdyUt8BFEYjUBBky1+PHy9WCuex
         fkjxXetILokfBi3bidiZrOB2NXxKGyLjrkex7VBTA4Cy8aA/j+PuYSLndF1aKR9sNJfS
         OpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780533968; x=1781138768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNgRjJgbYuUrLzdW/5WEzZhlyP27Ht6YujPqndZuMqc=;
        b=W678BHCrg/pNvyitJSe+bZ2PtgH9ji8MQi2aIPFhNoMFkPbwr+9OSOV4XdfC71slFX
         iDG0SkPhYgMGbWGo5rTELtjQ0nQjYwjQDmpXfFpKo0ikER8c0dlFMd34aWZPyrDpgwBQ
         l87qgQJUecma0G16onTjPyjI8JVTu59po4lOpPCvX42SZfIHXYDT0W1Cbrb182Nn1v8M
         7hHganispUK2CzPtnzOJCRwydpm8NDvqUo383BgpHksc0LX4L3Q+Hz5NH+8NnAL4YOCv
         ne9KZEikQ/iDHRLE9NhUOMw40pNWCqEsHZc2gkFNtEXbBXImTGLIkftg5Iqhk1nBITQ5
         l9LA==
X-Forwarded-Encrypted: i=1; AFNElJ/t6gxRb5dTJsmKaYvzu/Ckt7elIG5MyIavVr2fx9/MaTIhtwgvmE3zJcvbLHXiWMb1eKOa+c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiFxRB+4cQBXIs6YAZmGSLmJ5VaroJs63PvovaSTYf39uukAw
	FqcOHtqQRjcHZuYKhVYNd2HDhB7/r/Xejhf64Dcb3E2OXdvU2nbXKwol
X-Gm-Gg: Acq92OFWy9Xdj+H8yqntEpuZUoTInsYGHrdAo6cwu+oGnRza4OX4qyB/nYS8yHC4kLC
	+ObnNcRyUJABphb/fiIe47x1v2cywZKIOcvgRkLvJTLtRI4tiAVJEbTtdswYAgpRByMpS/LWQAu
	JBCjhUZVki3sZ2OsnhuYD3HhPU13FssAOaMc+rnFwTUqhcQWVxHcX+sJ3rcqFOS7jwuRnVfsckv
	kIZZJGAmmqbgprRAYGEDb1NcOBEbqER85W1UwllFCxyedaH8U3HGWigw1PQRnAl7e7pT62UQZoB
	3fD7H2MhAt/HgWQ5cv/r9KPImgyiEhgFy7GaKuA2YWK/RSiEiVtUUMIKz9HZMZfx7rjEUyBhr2J
	NWhyNUfrhcw9CyXiT4Xs27dg01FDaik8M3XYJVXgtsy4/V5farnuRrvFEovsTBkwIyfIa2Yl6mw
	jMno0mN3YxWmWV/Fc3pa0yEHPwOw8CVAdnC9dU+/yk
X-Received: by 2002:a5d:55cb:0:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-460218f1283mr6820154f8f.14.1780533967626;
        Wed, 03 Jun 2026 17:46:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcde3sm13029996f8f.1.2026.06.03.17.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:46:05 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 03:45:59 +0300
Message-ID: <20260604004559.1112474-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294991-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 264BA63C183

Askar Safin <safinaskar@gmail.com>:
> For all these reasons I propose to make vmsplice a simple wrapper for
> preadv2/pwritev2.

This patchset is already in next, but I still kindly ask people to
carefully review it. I'm still a new contributor, and I can make mistakes.

For example, in vmsplice I do "CLASS(fd, f)(fd)" and then I pass
"fd" (i. e. integer) to "do_writev/do_readv". I don't know whether
this is okay to do so.

-- 
Askar Safin

