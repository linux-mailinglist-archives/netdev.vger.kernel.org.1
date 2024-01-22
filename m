Return-Path: <netdev+bounces-64734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A382836DF1
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E51F226C8
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B446BA0;
	Mon, 22 Jan 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVOZDr4l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A95C8E2
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942723; cv=none; b=kgr6r3hzLwW74qkPXloqvHlw5agSI1ACK4v340YeSQ6ObNyTlUKc3KXy6dMgZtkxm4DsaYH1MYqutjNEMvsDE5fJAswQTYF1wzhuofgg/qbKYhRvygY3n8hB1YumxVi15FUjuItSomRyCr7Cksb9Nk99N3/mMvSxSPE1QdUPFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942723; c=relaxed/simple;
	bh=gcLROBLS5T+J41eaqIPOTWitpnTmVpDg6f7GtngFdcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvCHbH7e5B1kUm89g7nEQKY+5dtezF11znBR8lCao4522KlLriNzPegNINDuhwpClq4dwCY3u0bZW98N42kHp45Fyo4ZkqrOtlLFfAKuOw7StakuND9V1DVGcH4bJTQ97AdmLycTZIWGhy9AmOeVk6mdU0McrwF7Y7GwdAT++xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVOZDr4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705942720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAJpOnz0Gq7LXI97aGuCryYTWnk7rXG6vphCck5Cbq0=;
	b=QVOZDr4lq1nUYiDk94iQ9+dsOtjgWgf93a/BPgcXQPrfkHcCm16xmSbsFBuA+28kdj40hn
	3HwHh1fXLQqsgGJ8QnuWOU/2aF8LLbMCPc1gsAXueERxE02bKcqSH6el9Im5YOnLlG5J5F
	irjOJaa6cCQziUA4yHxb2ldVLrssV8Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-fdNn5Fd3MB-F4Rp7jQ4XTg-1; Mon, 22 Jan 2024 11:58:38 -0500
X-MC-Unique: fdNn5Fd3MB-F4Rp7jQ4XTg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78330275051so586886785a.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942718; x=1706547518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAJpOnz0Gq7LXI97aGuCryYTWnk7rXG6vphCck5Cbq0=;
        b=N8a3FGUUM6rNTyBUk9UzF8+XwV6DfHlu+NBOD0SbSMGoAcb6v10z3tbG4CdT+8IZrF
         vZrcpbwhzP7S+wgEOXSi/5FcVAOgDRrb+lVnI93RpRsBfaPxEdQoooXu4REVeUzfaDJH
         P7ATlFwQwgmcSdYw3bSZopwwS4SaBppLKgpCOezhFZe4dpx9d7Iurta1X5jll/qtOqcx
         1BxYeySjHFtOrd187My7P42iEEiho5FxVUhgLX4MeymGWsymau41/LaJTSZ/sPXy/pAH
         6eGtFbWSiW/KSQybKux3VJScXIEY+6saS94YSdNBf1nX5QNhnuksuG+YOgL1jpd/g2sI
         EOSQ==
X-Gm-Message-State: AOJu0Yzof2v4y6lJqKy/9dWynLxxc6cqeQn7e1rtf+1J/dg7rmUvkE+/
	cVcCLHxwnawvDmbUEtjetqEU9c7O4q8EzS0mzKsPeMsk9jTDcIlfueUCUp7FbOJw5wc3+8U+rlx
	8QvUHnwqGDMGp9aq2WSSvwqYdkmLggwbm7ezyxvdQo8Vy3F1vYv7cBg==
X-Received: by 2002:a05:620a:5693:b0:783:428f:526d with SMTP id wg19-20020a05620a569300b00783428f526dmr4389469qkn.121.1705942718423;
        Mon, 22 Jan 2024 08:58:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnMFEKDElqlygNHk6PsXOxLUTYvHMkscbr05reOG67nrfqX8FXts62aoES+riuG6JajMIxbQ==
X-Received: by 2002:a05:620a:5693:b0:783:428f:526d with SMTP id wg19-20020a05620a569300b00783428f526dmr4389464qkn.121.1705942718224;
        Mon, 22 Jan 2024 08:58:38 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id pe29-20020a05620a851d00b007834386eeaesm2256713qkn.33.2024.01.22.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:58:37 -0800 (PST)
Date: Mon, 22 Jan 2024 17:58:34 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/9] inet_diag: allow concurrent operations
Message-ID: <Za6euh/VzIiyU1Nw@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-5-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:25:58AM +0000, Eric Dumazet wrote:
> inet_diag_lock_handler() current implementation uses a mutex
> to protect inet_diag_table[] array against concurrent changes.
> 
> This makes inet_diag dump serialized, thus less scalable
> than legacy /proc files.
> 
> It is time to switch to full RCU protection.
> 
> As a bonus, if a target is statically linked instead of being
> modular, inet_diag_lock_handler() & inet_diag_unlock_handler()
> reduce to reads only.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


