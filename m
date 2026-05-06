Return-Path: <netdev+bounces-284978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID4YNNt/+2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8614DF091
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB9073015A5A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCF4C0414;
	Wed,  6 May 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2Q3BSLg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048214B8DCD
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089941; cv=pass; b=PQxQre4IqKsG+4HqwI3aq/JlB0E+rtENvfIA6Gbv4+opYO/qLMztaTWj5OPgT4L1RCQixCFqlBFE5wDPRiiWEOVV6Lgb0B1rMdT0WPdMvNvS9wGMbO0vsEP8B5639kXktHDATKo5n/K8jhQjAS+DBgoCsKjnzRj4pCgeuhLRyaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089941; c=relaxed/simple;
	bh=WNG++N8CnHBllI3r0/ILDjrollUsaQjILPAVsXW5Quw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1PUDd9yt6QsFflOylYsVyW1FZlRU7gwT/drJQ7ananKwG5cB1wGKw2MfGDfJUuiJo1FyQTiv/gpGpCIdb1zp7j5LFYmoNa+672Xr4hrSC1fPS0xMz5C0rcX4EAX3PIKeMF+6Mz4RX57Erm37u9CQMem42HIFICsUcBaI5UJvMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2Q3BSLg; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-130c653cce4so5123147c88.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 10:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778089930; cv=none;
        d=google.com; s=arc-20240605;
        b=aEXBFy/3H5wNI2voiMBprRAgv3ZvD//TZBzFQjqq38y385x6T324utvVgfo21srm1p
         hzTb701NNNS+d0/Aw8s6+18gvleQAf6RpeTMyd/I98BeuQJhMKtxjhO/qV5qMEKv0WC5
         AR02XAlK72IEuBXsgUgAt48hZ5ttA+TxJKqx9HZrxBB1gPg1qSz2aptgXCfUC1aWJtwM
         xxDPsIZRBHbncgx/WQLXa3YnyZ8w85uEJyyvh5yFCG+MU1mbmczRtv5jhyGF1NTTOdiy
         VctCfBiCPFeZMu5QpOyMZQeb5M7xCXHyRzir/ulCGRmqvCDxMF97K7go6EUuuTWc+97y
         9YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WNG++N8CnHBllI3r0/ILDjrollUsaQjILPAVsXW5Quw=;
        fh=QET2udKrSq/6vlP3Nl4rmW5+Kf2zWcwjpcHMvxzXRuY=;
        b=ddIW2LRxtZoio/I8KlG/24QN/5DlfDRZVIpP4//ovlBag9ygOCipkb63Lpjqh89Cfc
         qV8ciW4vj8qXhRm9wLzJ0YXMrFBbYVotbPN3YeG/hivYXn/oBy0li+37fSO1xGnDCfQw
         2jCKZBIr/m0TWccJ0UCkxnNKyZAeos53C2a5yog/FQ30Sha7llbA6AqCikPcI2Rj3Bti
         fGI7N4i/0vCUE+zV5ifvDSGir0ADvpBY4xUqAiTkA0WHHVwEAGy5pALBfuCi6SEwSEeN
         yR9gBTgbkCuk9290Iy9YlLCpr5epIbBwkdHcvZYhOCFp8fIQDZwC56IwPF4+9IAMSfgG
         iVSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778089929; x=1778694729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNG++N8CnHBllI3r0/ILDjrollUsaQjILPAVsXW5Quw=;
        b=H2Q3BSLgbdINLOXjBCBUvOjonuL23SpQdGhvJjQjMulruTjWD5ysVvV82X+KrEefrn
         RQecxVTz5B9ZAALjDRjSxFU27+uR919+x9EvdPZgbdcU9Zo32beslSXUKn5htXTWvRek
         pvD00GfSHS13NCk4ApRa1aD+jou8tcUc/pENylTn434/8J/mhp5wKTTtE40VdE+hxhD3
         6HymxJiHgxscR+AOkGUkMTsB6MQAkshjUTAkmW80OGUlS0HHQGvVGhPXWQ0kQldZjBkh
         Jzom1qJFS7PkHYCCemNYLRiYgTJLJw66nRVp1gFKIq6/iZePDsMu74SgkeXxTIwCEbmz
         OJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089930; x=1778694730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNG++N8CnHBllI3r0/ILDjrollUsaQjILPAVsXW5Quw=;
        b=NB4HnlCdueFxJCmxk4QZQgHwOfczOnnqbvYsQhpwiP214dMNWvu4AOHQl6/C+feDUo
         FKmumD49KD4k26GBnmdneQ5kiItiAoTwFv+nfOUenXVZ8uVfmx4lQw6P6aA6wPg8yb/8
         hD+ugYvkakjUHaOIg0aFVFhwiq2UEVj9uqt0WCNYVbi7Wlm4CLsmQyJamYevycab4isI
         m3CpJ4pzFH4Fy1SyGfyGYT5OHFUpvU3nGzQcOsQMtu6pCFesS8cbJYWNeDazXJ/zBmZk
         PDff7jz1+8yg7pO9sMZxXsxBnoV8wYIIhCowZy+mSErHhIqIDGF/EfPlYKUxqqI6ns7k
         NiKw==
X-Gm-Message-State: AOJu0YxX0/wiGrtaTm7LqRDokoU3kiLXY8yG1T+IlvnlVugu6G2pRoUc
	6gyQfZkbZaFqBF+0X37f6F3q+HQ5yeI2H0R3fzwDlfVEhty8Y4PyoXAP8vm8N/x0YqnCZs/C+I/
	ouD2x3KmvnBQoBZukoEj4msJ23JRMI7BnIy7XTgC/
X-Gm-Gg: AeBDies9DC47q+N4bSYUNLTzBUMNbXTUnYgLmi3J0FAjlfJ6/mpD/iKo5j4qAxD3uDK
	umo3gqayqH5bHTK9COPmLyk/yZGHHSWsSq7Qf5Oie+m3hA0mIWN6AK4P/xjb/HMRGWGTfSBQByT
	DSTmdHTeqnnCH9FbU33iZzerFNx0G7qP3kUTCQxzY46oz4EVdl4nDlZjAJLzXk5tGY8XdpXaIP2
	5NckemxSgTOZ9YxU5IYwlxZtbNT3LvBMCrSE2T/QjV7pu4oUkiUtA5TIuqPaCAEpHJezU5bGs2z
	ZxckO4Ea3nRPHrzzJ8Sb9uJ3HO/OJbafzbKQyAIH3mNJRXPbG4aFJZSECRfroCisMUKs/Y0Vz/4
	FHMKayHkGlfjRQOewwXuSJo5g+ASKlaf2GooVB9KV
X-Received: by 2002:a05:7022:6714:b0:12d:b214:7dbc with SMTP id
 a92af1059eb24-131964baaaemr2728527c88.7.1778089928897; Wed, 06 May 2026
 10:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506140825.2987635-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260506140825.2987635-1-n05ec@lzu.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 May 2026 10:51:57 -0700
X-Gm-Features: AVHnY4IgOwnPX3lLD71kyw7SLnZgRh71s969tC8iuOhFue8Z4wUxpMefHNKzlDk
Message-ID: <CAAVpQUDj-cy10kftgNd5NPoMKsvoSvSfhwhQ-a7Kc5D93cBaFQ@mail.gmail.com>
Subject: Re: [PATCH net v3] af_unix: Reject SIOCATMARK on non-stream sockets
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, rao.shoaib@oracle.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D8614DF091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, May 6, 2026 at 7:08=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> SIOCATMARK reports whether the receive queue is at the urgent mark for
> MSG_OOB.
>
> In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
> SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
> so they should not support SIOCATMARK either.
>
> Return -EOPNOTSUPP for non-stream sockets before checking the receive
> queue.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

