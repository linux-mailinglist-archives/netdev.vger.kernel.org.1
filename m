Return-Path: <netdev+bounces-229057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA28BD798E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A9818A28CB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD72D12EB;
	Tue, 14 Oct 2025 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUS0zvyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B323F412
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424208; cv=none; b=eeqtkirOplzdPqcB0MwltsY0zqqGumkPJkVTlGot3r0O4ATMY643svx6Fjtmpw9zeL/QyrhQeBXreLsKKPrXgJYPcNuvKDjnylfcD2gP8yi0Iivpu6NB11XTVPtq3Cqv7Et1n7BcetH/wc4wHfREM+xL3T6IjVm01zv+V48X4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424208; c=relaxed/simple;
	bh=8BmtnVuF+NR+683lGUyRlkHB0hCfWgNPU/uJQGt18PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZP4YIDusyJfTuE9jGG0lNIwIl0NUOBcykpxIqCILNTabnhlCdwaSf8kU6qYsc8RPV7b1cr0mJ+/3ZE7NItcfHmktPzrn6xmI5pG7CFHrBet8s/HHV3fx4eChN67M0+7hUkAPOPaD49+RTluwD0v3krIhKavGAqCTF4yTFBwTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUS0zvyh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-855d525cd00so882388185a.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760424206; x=1761029006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhrDyaN2J3TqzVAMvoBpM4UfVuraiqPhFHlfn6YNa1Q=;
        b=CUS0zvyhgV2/Go22Y7HkQ19GOeOGM7KKKP/JOjpK1ecUY32SpPMkhlzMCad2Pngq3I
         ghnd72vjwOUWBfzW1GQ2LkjOdpClhw4Y+vd/FvRwH1Q0L5L1LVbf+G9agyg5oszD6lst
         mFwbc0HBY092wPiXq9dBHw2Twl7zFWS+rmsgoEM9g01v3Y69XBiU6Zb0R28hJjwEJrsf
         DUTrZX4rXGDfaeXl5MiQENJ5nnJ/6F2LTGR2nVumQDmqzc2kyPEAIW/6I3sV6N50Z10k
         019NEAHfXny7YSruo2tyCkmp5PclMHCw+/gaX1U6Pg8wxkfplCUZAaAi+Ukc2kQ+bwdr
         Un6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424206; x=1761029006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhrDyaN2J3TqzVAMvoBpM4UfVuraiqPhFHlfn6YNa1Q=;
        b=mIpkNwLqHT4Wm8lLUGYJe3mhe462lta8A0hQGOk6Ng2OAY+7IpYlHLdvkb8iHw840g
         dcx/5zMtKcZk/hS8TTlGPsjVPJYIXk6KSJpVRurDaeSm9JyBGyE3AGXx5xq5iJXohv3m
         trTUtlPWpMXO9DO8wx4zr4PrNAI+KKN/WwfuCRCvNmONnqijExfB2/I7ame21NVmqVhV
         hX0SV5lEKAZ4HpJLbf3ryLvtWNR5hTpGY0oKDsVCmNmjDOAzHafGsJZkRE9ma/FVuzIv
         2A9MYhTPZpxQQhU41L9XCWB+YIusgmTPkGCKLbyMeIYJeJXVAJBMkpnipARPh2IQi1Gq
         +CWA==
X-Forwarded-Encrypted: i=1; AJvYcCXF7SZxa/EyggYQE1lI1hl3gEVOMRaC8I+IiMtf0MQgc0rnPyuU1qsmIhrYEHeda02tZoOnpH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBQrOMoO+RadnK6d8I3AeltrFk1Bln/qQm0Lisf7NeCKod4/a
	QZzXHXX4cMOJLRHqjMVmCQVY7kly9/G0agqaWa/GxV8OGch7DM0gbcvH3040cGer9QeyZ1+Ah4v
	ifPR3m9A5WnK9Qy4/BMX+eNO7W2FwREw=
X-Gm-Gg: ASbGncu7Ksv/hvDq2kdByZ6ZMmn5qGOJbj60hSJYPsi/HzLNv4jqlrZu37BKQIn9QlC
	34JAGchXfA49PFVXUDUfHfJRj3FzXFPAOzcveGK86GafCaIYKB+h43K1JcpdAOPUnErdoHo2oJm
	PCEo5QmhTJFWEKtYLlTzxr5G/mR6JsBHnfo4yyX6/Y4vITpt5wxG8r0QIuL9U3BPJdG7JAC4hHt
	iUmEBhhYVV1WJ7BL7+G+dkx4NKLXqMUBR4Q3uY7bNC2ZCLIpQu+MtU3djLVVKB+qks0Q/YpzuTU
	iK0=
X-Google-Smtp-Source: AGHT+IFYutlmQKCrkDt8XJQ+cgRq1f7xMcV72qnx5j0NhR1+uR1WTW9C1BFQIW6/sa8OGzcLx/Y98zV9viwi45m4nU0=
X-Received: by 2002:a05:620a:1709:b0:848:6b67:ea57 with SMTP id
 af79cd13be357-883502b6ce7mr3038377185a.16.1760424205591; Mon, 13 Oct 2025
 23:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
 <20251014035846.1519-1-21cnbao@gmail.com> <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
In-Reply-To: <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 14:43:13 +0800
X-Gm-Features: AS18NWBkvzMB1sYbudY7gB27K6cY5x7_rxgh42n5L8scA-jiQSzN7FZuNS0QWLY
Message-ID: <CAGsJ_4ySSn6B+x+4zE0Ld1+AM4q-WnS0LfxzWw22oXr7n5NZ=g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, hannes@cmpxchg.org, horms@kernel.org, 
	jackmanb@google.com, kuba@kernel.org, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linyunsheng@huawei.com, mhocko@suse.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, surenb@google.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	willemb@google.com, zhouhuacai@oppo.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> >
> > A problem with the existing sysctl is that it only covers the TX path;
> > for the RX path, we also observe that kswapd consumes significant power.
> > I could add the patch below to make it support the RX path, but it feels
> > like a bit of a layer violation, since the RX path code resides in mm
> > and is intended to serve generic users rather than networking, even
> > though the current callers are primarily network-related.
>
> You might have a buggy driver.

We are observing the RX path as follows:

do_softirq
    taskset_hi_action
       kalPacketAlloc
           __netdev_alloc_skb
               page_frag_alloc_align
                   __page_frag_cache_refill

This appears to be a fairly common stack.

So it is a buggy driver?

>
> High performance drivers use order-0 allocations only.
>

Do you have an example of high-performance drivers that use only order-0 memory?

Thanks
Barry

