Return-Path: <netdev+bounces-204412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134AAFA59D
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DF57A12FF
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E04202998;
	Sun,  6 Jul 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSY0W1R2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937A1D432D
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751810005; cv=none; b=M/RycBb49LoBGoXQIsJbt8xYpxkBWxw78yQEvYnLQu9bhdzPx1TUEw78FojtS5Qfp3miIieERYnjXZKFF7zW+5lmpGeGkTQarKxdSNGtPDVQJCRxuKSNdE7tO6SsJPmRyhfawAHpGV71UwXGPgdoKquTsKukiGiZmf+OVmbLcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751810005; c=relaxed/simple;
	bh=YMKvrK25Vko8CdwpfCdeBs/6ioxCUNzDHOwrPgdh8eE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NEI4fA2R3AokbI1m771VDEDHTC00F6SBxG8vU/r+Gc85E8MQhaxKJV0jwwsyOU1f9+FBE3rju/uutiKPQsRc38gp1Pf+BJBKXTYA5tnLDplYvJeGEaSYwSg+WLsguYj+cIKkQdwMd7cTytHwbozdK+y4bav83H71CdWdZltohJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSY0W1R2; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e81826d5b72so1868476276.3
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751810002; x=1752414802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbTSvpE3MV/NaFwPJygqzq4JzBK3Z/CAs5d9JpUff5o=;
        b=mSY0W1R22ia4GtuCD5FGfOHUcfDEynltPkOYNELUlw318jYSn/YSg/HfWskJhqquz9
         WVpiz4K5O0BJK9ZT2AiLxSJwNeLZ0nUuYNcGElxcbIGmNnOy4I4Ta+hGBhr7RfQaYtOh
         itpuvvNBKk6z+YqeEXNW4+77oXNe1zWPX6iXSqTRfjLwp7uHxBiK8e80VN8voWUp+AtZ
         cI1hYWdKozePK4hnIuoeyxSyJ9OR5kA4+0DJSMMscmXcazhAkf7UTCppG56ujZYHhZyO
         4pKn/hNCP22y6ASfue9YMIfFRre7156alyWn3pPIhce9oqHygaUyvupINnEFGGiMvZ0b
         ESlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751810002; x=1752414802;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TbTSvpE3MV/NaFwPJygqzq4JzBK3Z/CAs5d9JpUff5o=;
        b=dsPioB1i8xZW8SnG38oU4KM9+ffxxS18QGkBZeWfcB+yCgCLtJdKKG1pjuDOcgr/Y1
         TkJB1jHrew6TTMdv0XZTaHtTCENAL6I4TUoZp7ZkYdIcGgTJVGe0DoeOS7pUlIJvy/sC
         CnUcLlhkKD/JUMjULeBChQj2RmTEDzpc+cALrqeoyFAt6k8m9qmXXSRjmyjJzET4Fcs1
         ybE25WL9bMRaafLArwa9L1WEfd55SBdU2dzv7WyLkodlejCh3l/yoop16S3SDA2nHhTA
         NMiJ9a3JXcL9SZbhc97ihDm0FvwHgqPQJmaZj7z8Myp++SJgQkdWwltCYrXaAnRElQ4G
         ICdw==
X-Forwarded-Encrypted: i=1; AJvYcCV78PzmQnFcw5bWdbJ0l3doPcqN/SgIv9Uu76x1bqWYmg4gv+OcBWnzj/mIu9lIolYR2wK1E3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQy8CBMtxsTAZHGYqXth/5XlKZOGRiOHrmQOP73tosq+gBQP2i
	M1qcChdxT/xlMYu8DPQGnKt2IJMpPyFHfM0ZX3wSEQpN73xxTezlMDaW
X-Gm-Gg: ASbGncub+WVHcJRQDVkAA4J+Nqn706McNafqgFmJj/jTFIji+uSsD72bECYcZ0Q0BrQ
	eqiUWgiJXq/ydsiPTzlyY+TsfIKEiDsJyphKjFOUvVTmvlmGn6gL9KUqSwKZUiSz1ATkaLuPoGf
	WJ46TdP6BJxukz6QtlyY9g0v9BcyWO/X3Mio84ljFLf2+7tsVB0om7uUt1fJh9nAJ2p+tMTIiwC
	GmlOMKP1ETNjB34SC9fcx2ixHv/5c/hOiVkQF4IDKls7bZpKsd4slecMalNqdKHY4Hgnf7/r1Vn
	NYb7FZQFThdXQ38q7l/8GZD8D8jSOFthU1MGu4iKhGJScUs8Gcx4vwY0wOCkuAzIt4lPqlPrvji
	EODCIirxPiuk90Qg7AtA/R2/o/ljoeYvG+44wzNc=
X-Google-Smtp-Source: AGHT+IEEgiAtUMg6fd4XOR5bSfBhFD0BM9SnY+DEfBNz3zy8InFJ+HiXlD21vI3QMZdk345WRZyqAQ==
X-Received: by 2002:a05:6902:18ce:b0:e81:9c45:a97e with SMTP id 3f1490d57ef6-e8b3cd912c8mr5782348276.38.1751810002480;
        Sun, 06 Jul 2025 06:53:22 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7166598b457sm12337247b3.22.2025.07.06.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 06:53:21 -0700 (PDT)
Date: Sun, 06 Jul 2025 09:53:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <686a7fd16830f_3aa6542947b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702223606.1054680-5-kuniyu@google.com>
References: <20250702223606.1054680-1-kuniyu@google.com>
 <20250702223606.1054680-5-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 4/7] af_unix: Use cached value for SOCK_STREAM
 in unix_inq_len().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Compared to TCP, ioctl(SIOCINQ) for AF_UNIX SOCK_STREAM socket is more
> expensive, as unix_inq_len() requires iterating through the receive queue
> and accumulating skb->len.
> 
> Let's cache the value for SOCK_STREAM to a new field during sendmsg()
> and recvmsg().
> 
> The field is protected by the receive queue lock.

nit: for updates, but the read is taken without the lock held, hence
the WRITE_ONCE/READ_ONCE accessors.

> 
> Note that ioctl(SIOCINQ) for SOCK_DGRAM returns the length of the first
> skb in the queue.
> 
> SOCK_SEQPACKET still requires iterating through the queue because we do
> not touch functions shared with unix_dgram_ops.  But, if really needed,
> we can support it by switching __skb_try_recv_datagram() to a custom
> version.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

