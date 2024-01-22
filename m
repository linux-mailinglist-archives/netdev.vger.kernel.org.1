Return-Path: <netdev+bounces-64696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E151783689F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B35A283EB2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B705651AE;
	Mon, 22 Jan 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzab3uhU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E506518E
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935951; cv=none; b=L5AWqdmZ1ZFKBA+kKEXN0ZG+axhvYShAGRMeyjQyq/DVX/w2AnohyZQX4+C4o2ZtMPq3Pg+nAtru4yGJQIWFjtw7C7olnBWInFkUKhWsUv9MGyNdm5guv6v7JpUjX94jGo9rOh5S5lrVHOqRB6BtJW6pPwVkJjVs1WJQrMw5Kl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935951; c=relaxed/simple;
	bh=N2j0CY6jjvq+WY+hWxAeMMaQzn9JQjgc5wObVxVtAXM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j91tj7Wq7iw87xNLNBE2GYct8I+OF0Ui7+UZtTAIaprNr3QWTaLnCH/bedMggNZQmPxQq6sgHKhXGvSCB/kQBNsz01105uS9NRujj6Jc141JHM3IxiSFIXYL7tKvnmRLTFO+ljYpOwehNgo1DPDuMiZRhfLOuJE59ME4OdMmL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzab3uhU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68687ff4038so9972156d6.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935949; x=1706540749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5i/CQN+UnYcVG7SbopzwOts958sSk1rHttXGH9i29I=;
        b=Hzab3uhUajnLD/JPTpc2K3rclR6ZkfViV7PcKSAcUO2BcZiZbtzNng1mVwBO66yTgJ
         xR5f+0QxLQ1VYzS94tIuw/ZzSGa0Jiet39TXc4dxeRyuEx43lE2B1B61iT179w9hR7hr
         wNLsr12Q3iFjia7f63MG5yYnNHDpjRhR089eNfkJrLjczWcDOPBSoo/lZmdY8QFek17k
         +/JOy/3whodtRXN8AreNaSG30VKjeITdE+4v2kl0bKAu9uGFLi6ad0v2hIz4jYxbPkL8
         Khcvm38vRPZ5qwBOm3oPtXaDf/8dw8r7baDg2a5wer+daWheu5VLIv1uQmi0zcUjp31+
         KCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935949; x=1706540749;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X5i/CQN+UnYcVG7SbopzwOts958sSk1rHttXGH9i29I=;
        b=PaZzKQzdoM3Gz0cG4ltL2bVvkhjZUQbMGmjqg975Coga5u3l8FWvjkN+S7dP7+IWr3
         qvP7TmZ/FKCz3wkMCIfUONkAtCZBuTuE0f6+ivOgF+Rke9VxHgGpZ1PcIW2afsbLO6Sw
         3TRaGC0cVeiYg/asG0hnKGnzPHLvnIf+SQ1MDzzBb7gCbvtX/38h+6wm00sz/bBE99pu
         Xl5VRVqGi+aB2zxE1jFWjzbHvzeNlcW85+v2fbrhuGB0hwWn50nO9IIubzu44pfXjH6b
         ZwwoNNU2xZgTPV/dfoZFeE8fZTRzn4AmzVjRb5dW6pNxBYnY9Xv7rM80jN6wBZ/z3h3w
         327g==
X-Gm-Message-State: AOJu0Yxj3QPgnxEaixChv4Y0NkWvVUMyP9e8IY68+WUpj5uxH/NQ6gZQ
	bmg1UO8LrlCfmM7ypWy/V8wernVqXz4Ep1BnJCBr1nRKOR5EduVu
X-Google-Smtp-Source: AGHT+IHl+zIFRNecbo/1impeUUarM4KRjcjDXzuTXgToFZPvFithUo5YuAX/h9o5IxBxz2GXETK8FA==
X-Received: by 2002:a05:6214:20eb:b0:686:5b4:3582 with SMTP id 11-20020a05621420eb00b0068605b43582mr5474845qvk.13.1705935948974;
        Mon, 22 Jan 2024 07:05:48 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id kr5-20020a0562142b8500b00686910acd86sm1014254qvb.121.2024.01.22.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 07:05:48 -0800 (PST)
Date: Mon, 22 Jan 2024 10:05:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Martin KaFai Lau <kafai@fb.com>, 
 Guillaume Nault <gnault@redhat.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <65ae844c2d5df_308772946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
References: <20240122112603.3270097-1-edumazet@google.com>
Subject: Re: [PATCH net-next 0/9]  inet_diag: remove three mutexes in diag
 dumps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Surprisingly, inet_diag operations are serialized over a stack
> of three mutexes, giving legacy /proc based files an unfair
> advantage on modern hosts.
> 
> This series removes all of them, making inet_diag operations
> (eg iproute2/ss) fully parallel.
> 
> 1-2) Two first patches are adding data-race annotations
>      and can be backported to stable kernels.
> 
> 3-4) inet_diag_table_mutex can be replaced with RCU protection,
>      if we add corresponding protection against module unload.
> 
> 5-7) sock_diag_table_mutex can be replaced with RCU protection,
>      if we add corresponding protection against module unload.
> 
>  8)  sock_diag_mutex is removed, as the old bug it was
>      working around has been fixed more elegantly.
> 
>  9)  inet_diag_dump_icsk() can skip over empty buckets to reduce
>      spinlock contention.
> 
> Eric Dumazet (9):
>   sock_diag: annotate data-races around sock_diag_handlers[family]
>   inet_diag: annotate data-races around inet_diag_table[]
>   inet_diag: add module pointer to "struct inet_diag_handler"
>   inet_diag: allow concurrent operations
>   sock_diag: add module pointer to "struct sock_diag_handler"
>   sock_diag: allow concurrent operations
>   sock_diag: allow concurrent operation in sock_diag_rcv_msg()
>   sock_diag: remove sock_diag_mutex
>   inet_diag: skip over empty buckets

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

