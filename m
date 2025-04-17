Return-Path: <netdev+bounces-183772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9867A91E34
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D227A1E24
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC524BBE7;
	Thu, 17 Apr 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+jcB7I1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E60248875;
	Thu, 17 Apr 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897125; cv=none; b=mlESZ/+rpNdKDCIcmHkG5aIz8R0RPp638Wc++MDOlaYAbpY5gzmC63XFrCed21GtZu5boF7YEk/94NPFdwys4keemZIuPqaVZTNGYjNqaAjl78Z/R3d1YzhHtiFYtBQBRUUeMzqouKLkanAIPp336KO7vEpDHSmLM6VSOHnJrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897125; c=relaxed/simple;
	bh=8C0dSVw7r5lOGDtA9d/azTkQ9s2yTaFzXl3TvgOz75A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U1p9cu7SP11A9ZTEXyAv892aYKwjmBmq8+I8617JcdmIV7ILpRwySFC2JgEA8tfGAMlRLFTwfF8cOTzRex3SUj7/5xNwTRBqQ/z4fffqjNAwbhRIQn9yHmnOvRaR7ger9/UCeofV7PpoS9gL1yA8a8tqZDTdy3BGPeduBcbZ/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+jcB7I1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so72932085a.1;
        Thu, 17 Apr 2025 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744897122; x=1745501922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy0m3qi1IN2B12j5Teydsz3odFT+tBC2P2Hm5Y80xtQ=;
        b=X+jcB7I1x9i1OBH+XyeR3p1usDGzeFqtQT2pYjG6CQOWBkqm/0OUcB7tb5Bq/4i7pJ
         3DszUIwDoaXf4pimmOptdEzSheRLG6uhzS0WHjs5oBPFfbsPxk5i1M8AlhvflERABHPw
         0XKoxw77FLOd48wXi1/q21z9cPnqw/vLgBnTdwrflQYJCzprQWxUo3mLcZeWhbV2KMhC
         gfNDcZqOksQdOhmW8DpvZykMToe3Xl0/OyFFT0fJl8bSxNIAeMLBjD12ZVQ9uUbtFo9d
         1WSqo/LrOHnUdT0sKv5u3LIlQas8nBK7epVfPp77WtuqI8dATxe6UQrD8OeraNaNKGAI
         egmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744897122; x=1745501922;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fy0m3qi1IN2B12j5Teydsz3odFT+tBC2P2Hm5Y80xtQ=;
        b=b1DhOcJjx6zg5cSNu7bwjRSyADwpZISNbb+2S5evePX1bDBO7zpM8jqTT8Pa9by0QH
         YL0z+XFJGfrIWyCKloubz6mdQGz1bbLO23IXkbEHebpsoRtSYSNUjECHZH4KYPfM1URo
         1NHqGsHoIio3R4lSFN6foa1CppocwET6mp2VSH3GP5JmaOXT3n8Lvl3CfdyXQay8xoJB
         bJ3XwO1fBrfd05L4BYQdnIdhX5XTrGj2mS+s/GdaVhgoqwiqYEzfXkMNfI+RRNZNsb/J
         rgi3As3xR9Z6GSnDrZQjD3DRtmRu/QDoFpq3WjEUUwNtv7xXe/B5cG2WbYO4ac5jX+eC
         WY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTiUmzs/jlO1UFIjJ3oY6nsZrbR7iustEURDMO7NAmM+0mpS5pk7ygFI+JnmPXeoqyzZWwhMuGK+bD6T3Hpj2ITQ7P@vger.kernel.org, AJvYcCVCLb//mBM1/ANzs33nUlwDNmh0GipQWhRvTVOl4ZDshtQWqWhFfNvzV6y5sdKuVmjDFiqdbqya@vger.kernel.org, AJvYcCXThp7eIJo0z7IUffJjGEFDOBsv8buWDQSDyGk3f5O+rfs/EXDsq1u0gqcLYA/qjyOs+3JL2R51lA1FVIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxdFwMJb9fMME1OP0Gc0qkUgiHZXi6uLzgmnKqyqB7D0cMrk2
	38O9JszR7td6oKXa+IEFg5t0oD6DIc21kQzQzeCeiMAW70fezde/
X-Gm-Gg: ASbGncukTwRkRqOjWPNpJVnhE0gLuBa41wCuGwpUXLy3LyX8//y5cXXK1a5uQ4MVx+g
	XSafEafyfTqLIusSbmJ0Bk0NQjW4DU0kqr4woFR2YuzvrVe9gHl+Cdc+YqP/qH/Not4hbSJ4uO1
	/LlTS24Icv/Wfuur2RFRigxYepClmD1DK63gcpNP2IjZUagtx6ZLjwyG1y8whgbFSdLm3Xto0ui
	1NiLbZwZRy5htF5GClU6CVtfjYQfBfsqbQUbh9ObnybETX3oLQp7awfLNAWHtltXnyDr3HfZefP
	n1eUEEXv7SHKxwdYMxNxbLL0KamhzFsbZ0pkqxMKkzEuyl2X0+GrGA18k5YDPaVEjORm9F87rDU
	9Rzs2T0sPVqZ2yxDKsupN
X-Google-Smtp-Source: AGHT+IEnTx9SwwHNmjQa6zLBu0T+tSHQTbMsJ87IxuVd/DvBqde7hu47qG/yFeRb018+Fo+Ughw5ig==
X-Received: by 2002:a05:620a:439b:b0:7c5:ee3e:54b6 with SMTP id af79cd13be357-7c919083264mr1034030285a.55.1744897122073;
        Thu, 17 Apr 2025 06:38:42 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a0de38sm1171351185a.102.2025.04.17.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:38:41 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:38:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 yonghong.song@linux.dev, 
 song@kernel.org, 
 kernel-team@meta.com
Message-ID: <68010461348e6_159c5529499@willemb.c.googlers.com.notmuch>
In-Reply-To: <aADmq6cGLe3yD9Qx@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <6800064ea440f_fc9d7294c4@willemb.c.googlers.com.notmuch>
 <aADmq6cGLe3yD9Qx@gmail.com>
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
> Hello Willem,
> 
> On Wed, Apr 16, 2025 at 03:34:38PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > Add a lightweight tracepoint to monitor UDP send message operations,
> > > similar to the recently introduced tcp_sendmsg_locked() trace event in
> > > commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> > > tcp_sendmsg_locked()")
> > > 
> > > This implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> > > creating extensive trace event infrastructure and exporting to tracefs,
> > > keeping it minimal and efficient.
> > > 
> > > Since this patch creates a rawtracepoint, it can be accessed using
> > > standard tracing tools like bpftrace:
> > > 
> > >     rawtracepoint:udp_sendmsg_tp {
> > >         ...
> > >     }
> > 
> > What does this enable beyond kfunc:udp_sendmsg?
> 
> A few things come to mind when evaluating the use of tracepoints.
> 
> One significant advantage is that tracepoints provide a stable API where
> programs can hook into, making it easier for users to interact with key
> functions.
> 
> However, kfunc/kprobes has some notable disadvantages. For instance,
> partial or total inlining can cause hooks to fail, which is not ideal
> and can lead to issues (mainly when we have partial inlines, and the
> hook works _sometimes_).

As Paolo explained, that is unlikely to happen in this case, as this
is a protocol specific callback function.
 
> In contrast, tracepoints create a more stable API for users to hook
> into, eliminating the need to patch the kernel with noinline function
> attributes. This solution may be ugly, but it is a common practice.
> (and this is my main goal with it, remove `noinline` from our internal
> kernel)
> 
> While tracepoints are not officially considered stable APIs, they tend
> to be "more stable" in practice due to their deliberate and strategic
> placement. As a result, they are less likely to get renamed or changed
> frequently.
> 
> Additionally, tracepoints offer performance benefits, being faster than
> both kfunc and kprobes. 

The performance argument is fair.

Perhaps we want to think this through more broadly for networking
tracepoints vs more flexible kprobes/kfuncs, rather than on a case
by case basis:

Where do we think the performance or functionality (if exposing
additional info, as for tcp_sendmsg) warrants the tracepoint?

I suspect that the use is predominantly for on-demand debugging,
where the performance cost (and latency impact) of measurement is
minor.
 
> For further discussion on this topic, please refer to same discussion in
> VFS:
> 
> https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0
> 
> Thanks
> --breno



