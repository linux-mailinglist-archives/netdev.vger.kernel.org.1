Return-Path: <netdev+bounces-164551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CEA2E2F8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3283A5256
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94613B7BE;
	Mon, 10 Feb 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDSgRFXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595D143890
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739160005; cv=none; b=gO/SNM8oJWPECMFVR8AqnxN0b03OLLSJ9kiI4+Khyq3b1UtLya++f/uPSBmtVn3u7T/Vb3tkQdfmMx+AmZx163SXI5ybBIX5+LubQCGPbW+Wt+IOOSSF2BOip9hs79DxUasRcTeXuzocpqwh7FNgwE2qxt8ytZIkhIjGLoWCngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739160005; c=relaxed/simple;
	bh=o9L6wygnIjlk6pq9qdbVxhm16zGSITIhNwPAA15zuSI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=czShe8qFJc5+4OHMRnN2db05wCyHTboSngMGYeHtsN/2rrE90avUUDlaP1t9uOeFIm3GbzowvgT+W71aB/h/4n7Xu3G3XRw0nPGFHtTOsqh1e6+VgM1cXi59zC+9CrI9sF4nynoKTottWLXjmRiN13CDownp9JRXdPqFueBt//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDSgRFXn; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e45258610bso13069236d6.1
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 20:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739160002; x=1739764802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os5zFJQwD/r4LzPwyBHqXJLn1SZv18rznMv4qe6uQrw=;
        b=DDSgRFXnJad60RRoemObG+RCpm4T8XQVTeChYNiqAUyoZrz6gwZ++h1q4kcMSw3j45
         9eueRkX/jq3Ej0fcMl62DaAog5CZrW+otY49h0+v4wmm496w6/Wcb+eLlI6Ix9A63/Ib
         tyPILmpW43FKQ539I56F6YNkqskWb2jQtUrw/5EtygIcHcCMGZFx2GXdhDytYRj8vGhV
         9ESJyndWWghT4OE/XC2inO+EW5Rq0ZxYQCWxkLoLGmeounOVQZA5j5IMy0P5lNnVCbBj
         0LBgBuIwQLQTl9GDX9aFRkWnQ7Jj4r5mdQTVdrtK4s4WQ98K18gSE2X1+qxbivw3Qol9
         rDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739160002; x=1739764802;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Os5zFJQwD/r4LzPwyBHqXJLn1SZv18rznMv4qe6uQrw=;
        b=Cnl+oF2yF263wCTEEvvaub4e7Zub7Z9JhwUlBD27TEGq3Y5J8RdX7Z8L5+KKKIlwUJ
         QnAabLhKUh/BfJhO+nEe0XwVE/GOlDF1mGduUpq9gl8Inxh/BwjuqJlFUcV6xoLnkjfV
         O8/y+7W0pq2eO5UHHtrEjZ/dXgsKH0czCJ2jGX1RXmzumaMck4II2ncX8iD/KScAI1+c
         sKWvPV1KIwtQo0vrIBM7tKjU/FqzwuQ1HaemiRF97YHx9Gg+aKqrAyr52AJQN1DbYGw6
         AB40v174KBrKrpthgsO3OVFkJCgdUb7CF6smOUr0zJRCRf/11tP99lkyiH99jASX9qj1
         tRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4JdBQVyCnK5niU46GM216qKiW0x4Yxx6aIW8x1FMQNq52VSoh7umNcBEJ6j5ADphPDHwVMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNf7QnA5HdTh9ZcZYAPyUqem0dBB3YtXuKNqrO0nxXtUKfj5Bx
	a+/c8NAZIPqNK06Ug9F2qjYJdiaMRDEfP/WUM/Jum6Ug/UJ2lZiF
X-Gm-Gg: ASbGnctB2nktACra85pxWf4Kz/48ClLy+b4ZI4MzfOapAfl8DqausF1mMaaw6kUsTZb
	33Vx3jXAyTFxIAwHdV+gknanQkSnYLZZ2P2hsxwvQyFyO3W+LZ2/yx5HZj2cdmM5FixMGY5+VZL
	Gi3zG5zx32C2B5nCeGjbih/8c7T6HNh09U2zLGm8lDT/ILntnAnDTnW1fXh2V1TrFy/EIvkwp8v
	tAGCK5oADwvhRqfVxNFH78NESSPaGDcxhUVWRVzE6SZJz2WyaCKe1C6FWaWu57sHemPF82khcNE
	E52uWxg7Rn923jRv0A4IrppIwhE8rDbrTMr68nH+Yzn9IGYWWVb9LucRTG5tOeU=
X-Google-Smtp-Source: AGHT+IETfLyH3aymVom07P4nR7/6YN1xQAv4syiBwRbBajDX5W7WtiRToL5URmn0iRmJdGdvRo+vqQ==
X-Received: by 2002:a05:6214:c88:b0:6e4:5b6a:9d48 with SMTP id 6a1803df08f44-6e45b6aa0d5mr69761496d6.7.1739160002470;
        Sun, 09 Feb 2025 20:00:02 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb74sm42663326d6.77.2025.02.09.20.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 20:00:01 -0800 (PST)
Date: Sun, 09 Feb 2025 23:00:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
In-Reply-To: <cover.1738940816.git.pabeni@redhat.com>
References: <cover.1738940816.git.pabeni@redhat.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> While benchmarking the recently shared page frag revert, I observed a
> lot of cache misses in the UDP RX path due to false sharing between the
> sk_tsflags and the sk_forward_alloc sk fields.
> 
> Here comes a solution attempt for such a problem, inspired by commit
> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
> 
> The first patch adds a new proto op allowing protocol specific operation
> on tsflags updates, and the 2nd one leverages such operation to cache
> the problematic field in a cache friendly manner.
> 
> The need for a new operation is possibly suboptimal, hence the RFC tag,
> but I could not find other good solutions. I considered:
> - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx'
>   group. It arguably belongs to such group, but the change would create
>   a couple of holes, increasing the 'struct sock' size and would have 
>   side effects on other protocols
> - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
>   would possibly reduce the side effects, as most of 'struct sock'
>   layout will be unchanged. Could increase the number of cacheline
>   accessed in the TX path.
> 
> I opted for the present solution as it should minimize the side effects
> to other protocols.

The code looks solid at a high level to me.

But if the issue can be adddressed by just moving a field, that is
quite appealing. So have no reviewed closely yet.

Question is which field to swap it with. Something like sk_rcvlowat is
not used in UDP. But is clearly not a write_rxtx or write_tx field.

