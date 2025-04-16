Return-Path: <netdev+bounces-183472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F9A90C6B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BF1907BA1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193E224B1C;
	Wed, 16 Apr 2025 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVgXA/nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED0219A79;
	Wed, 16 Apr 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832084; cv=none; b=nmq8Wfa5fatopBSlEf48qJXgvW2Ple87vPJFjwbne4aSou6zu6wjE3tWx7CANPrSxk3K1LkL1f53U8hkQ7+WLLs6jE9Q36ngr5XSBg7GtxzljUaSpRJtM1hadpA8cWYxi3CPCmy1eeaOUJ9id7dGUqViMISTKWf07VTaMOGb1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832084; c=relaxed/simple;
	bh=1zN9X6yDeiS9IW9n32HYclfLjKjxXCQgDbUK6JkkPkg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FO3syFjQq4xEzQU6xfurerIyRw1VEKAaH1z+4d8kmGoxH8cVmJVkd4XmzSggJjkQwDGAtbKaf9dA4nluV2M0JKquCbUgY2PULmpe9Ey9s1QHM2qaRgg1Ye5DSSkhS5fZJsiHLmc/ErXh1MUo51oiu8prmHFt9I4hJkq+rZ5hQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVgXA/nv; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecf99dd567so868876d6.0;
        Wed, 16 Apr 2025 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744832080; x=1745436880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz4jCp6R4OrveGAeCbVTPU91qgzQT2hPcqVU16N6WY8=;
        b=CVgXA/nvbDbqrWi0BrJwRjj+uxOzAzNiepPZOV8vkZgJriuAPJWsb2MI6caj7BkRNm
         fSc+F+N8z/NEaDYiw7BkXj0kzaWo9BJqq0119ZF7sD/lcqS0qOW0FEd7jaBj6uGtJQpg
         2EZBFRaSeh39qi2KgV11M8cxEnYqSYDU20fkanzTVkpl171tK5x9O0BFZ4kkeLLC08HA
         g5x1Vova+2VgXu62uHLOI5P/8riH390Y2mYOkYWn0oJVaaFXJL3QBAH3QzbIPmnKCW7C
         LPuQD1sIDlaJtxNAFk5vpS7WF5KniAfJ0PhJEmCkDgZkxsIyFqsEkiyx293S3cQfbzbX
         EuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832080; x=1745436880;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gz4jCp6R4OrveGAeCbVTPU91qgzQT2hPcqVU16N6WY8=;
        b=LJXYoVNHZSEed3/b0yCV6cxupXhdLfft1tNAFATnkfTd5XV2KGeEFGUeMIZjokCTC/
         M0BvMUNQwF0aQwqD+Ts3odywbclEKTcJDNEa6Ut0DNyeCqwKKxLPz7/IEpjgxQd5ktDu
         aNN+0TLzLZPwI3uioQlO0UYNp3u+jnD4N/DaZmkU03qjTx3KL5OY91pbtSF29O6GHPbo
         P9tjZo0XIg+knwFDSufP3SfP2C8Wp+nLajYsENUyOLL5UTtwbe79mhQhLqVst+ETIleK
         LvECzu5BsKVwIbzqYDzmEk7LCds1WGcQZWZZUgBaJOW3ZBTR2BRS17rBxLTYj6rbJLrV
         ymvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgv1RUYG3/3skfn/8fZKTyrydGUHgEt4VEwFRr5LSNPcwefgc8QvCZ6TDTgvTE3dq1rqukYUjM2yI8kKs=@vger.kernel.org, AJvYcCVdpGnimWZsp3XzbnNKBbW2ZNa6rx7uIvWVJA8lFPrJprqAPUqcM3hy+P2rVZHpuuHcgoFWbE8X5clXyflhwet6diqg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6imuEIWTLTbOFfyLzHn5FOSoeLZvDQYYoxhxb3wlIOGkY2Dr2
	2Zj8xNU8e4m/cMsdAcX+S0nGzE4UAOa0sXeazjHwEZvOHEf6vOah
X-Gm-Gg: ASbGncvtTmH5M6DfCohuRIWv8ARKeh4xxncrPZtezyRg51MOyYCQK2EoByIOMQM5X4W
	9/jSeFCTHCR/lovdrrrTlXafyHi487jjdY7IOZj6GadR72CCHWVHgpIaRILlLtDWvpmN1GpE1zX
	b7EVV01wsyGmOQ1mssGQW5BT0PcAeMaQ6XfxtzOi7+zZlQObJWGvIjV3Ees54fMo/6W58Xv1KzG
	W6amJzGVYCzr1UduTTDsFPoDND+vgYh+kQD+wgmZ+gco0FpluPp24bHmQNnXwyquIdowUsRJh86
	lCRXlWgmIJc32JX20ab1dc1nHZ51RWWBqORGb+HkSu5EIlVr0SJIUChtuYtHpG3jqA7boL7VA7A
	AdN2RWDvz7I+fPOTyHWyg
X-Google-Smtp-Source: AGHT+IFz3TMw+fdTGgJPSgCnpNEMY2Hsn+/wirjgyY+ZXnp17SPLHUcKa/dIsNFQJ7i08rr/6azZaQ==
X-Received: by 2002:a05:6214:19c8:b0:6e8:ee68:b4a1 with SMTP id 6a1803df08f44-6f2b2f22a1fmr46961416d6.8.1744832079844;
        Wed, 16 Apr 2025 12:34:39 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea10825sm118667666d6.116.2025.04.16.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:34:39 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:34:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 yonghong.song@linux.dev, 
 song@kernel.org, 
 kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
Message-ID: <6800064ea440f_fc9d7294c4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Add a lightweight tracepoint to monitor UDP send message operations,
> similar to the recently introduced tcp_sendmsg_locked() trace event in
> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> tcp_sendmsg_locked()")
> 
> This implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> creating extensive trace event infrastructure and exporting to tracefs,
> keeping it minimal and efficient.
> 
> Since this patch creates a rawtracepoint, it can be accessed using
> standard tracing tools like bpftrace:
> 
>     rawtracepoint:udp_sendmsg_tp {
>         ...
>     }

What does this enable beyond kfunc:udp_sendmsg?

The arguments are the same, unlike the TCP tracepoint.

