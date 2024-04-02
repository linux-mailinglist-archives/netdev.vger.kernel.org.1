Return-Path: <netdev+bounces-84062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2FF895646
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D78D285B89
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6D12C7F8;
	Tue,  2 Apr 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWY+gtZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E112BF1B;
	Tue,  2 Apr 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066986; cv=none; b=VsthtT81RJem/avA7MeSlXucb+Z4WR+4FDNoZiVjvTvKOvfgBPAU0hE6TI/MftWNA6roi0QQJskdsRvLovmUj319qPLuJ7tgETKAEfbycz/g3anHdTkeM4TvWe7Qjac9TDjSSGDWIi7JLH8davt1p/xFRfhtdLTGG/TL5h7Ou6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066986; c=relaxed/simple;
	bh=7tl7YgY+MKV1mJK0tEzWTAATtwUoG8kyzmnl3sQmnGA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=chlC+XRsR+WAiEJ6CgLX5JDMuMx5ROTwE14fXKjP+NzR1mVuMKxquiSo4ZFy/0fVjriouSmrHT0sO/oo+M15IEHIXtpSSnUCmaWFJ4WAAUDZWY+p9VWitsrSHK5LkTfvGwAJKFk6wHr6XSX1RoyI7gJJ3U3a7YSTeB0jbnEm24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWY+gtZs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso1701048b3a.2;
        Tue, 02 Apr 2024 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712066984; x=1712671784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yao6M8BZe8LPQTSQBWB5LPvC1cQXjIBVUMQ/S2AXRQ=;
        b=PWY+gtZsVAA1DcBJHroz6N+/vo/C5GiLw5yllhUvudUiRmbm9uC1caPwqGOHtfAP6o
         r38aoO4Jf1o+0TtuH084g6ERtkt7Ot3T1zHjSqwYT20DVmsdGLslgWR4T0pVnlw6u4uS
         94IpP8cTglgjnjrGJDwOFBKh4dXeO2tWWtB0WI3pVDs76q9weoUzTF3r7d4a+56YZP9B
         25WdsufdOz/EB+8GNqbOImqv8L1GA/kW+xNCy2rioGv299HZaShEJmp9rW92l5CiDwEy
         muFZ/76nYJBQaP1rmr5fwgUvFrKCNtfAKJraHPb+MkNOo3qZhztImkxD1IsLTPIDInAk
         ARFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066984; x=1712671784;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yao6M8BZe8LPQTSQBWB5LPvC1cQXjIBVUMQ/S2AXRQ=;
        b=VNnKTKv3JWJuFn02tSEW/pJEJhtYJDJqa1mtYcBiVm0gQMaQ4eFlD3QEY7SFdbQzkZ
         woOzvDOzHpBlre8v5NBLARv826yLPGCeYAmphLMS3jaWzHlpe+po1YIQmpnLW6Cyyfi9
         9deMfhW/Fxa7R/QMHHmsQkm/ofx4y26a4NEMIaHMiPvDwSYJGcXynvUlPtQI5ThZ+cfy
         0mMuNDHBKkT4dgWwgeTFMx9TsvxXfCSnysGs171xDb9YNym0dq6VhQv/eI9AtZE74Z4y
         ctRCnGlhupcNEp2SUPA/voorrHCUIwa8cIaZTFHJTH8EyxYoJw56NNbk0L9+/Q6LCBdo
         KQaw==
X-Forwarded-Encrypted: i=1; AJvYcCVEltULL66K+SYjGPGD8UrMRIuCGiVarFk7X4I3qayDy0vp3N1nQphgEGT6LmTE030uEEmwaDbrJQqroFB7rn53rAd5
X-Gm-Message-State: AOJu0YxZc1Y57NHJZ0RGJnPvLSeJ3/Muvjtze56yeO+N5qj1lo9vjZr1
	QWmq8Zx18chdcOPOspVTHB5Pjc8RDr/t5OOZMRyi85WrkEN6IbvH
X-Google-Smtp-Source: AGHT+IF2tGblpwSmVjYysthYWlwftyqFV6Z4Z0GvepkHJlYkEQODcyRSbo8LLmO+W+sk6sLfCnXAww==
X-Received: by 2002:a05:6a21:6d8e:b0:1a5:6c73:74b9 with SMTP id wl14-20020a056a216d8e00b001a56c7374b9mr12511738pzb.48.1712066983898;
        Tue, 02 Apr 2024 07:09:43 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b006e647059cccsm9828830pfn.33.2024.04.02.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:09:43 -0700 (PDT)
Date: Tue, 02 Apr 2024 07:09:42 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 kernel-team@cloudflare.com, 
 xingwei lee <xrivendell7@gmail.com>, 
 yue sun <samsun1006219@gmail.com>, 
 syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com, 
 syzbot+d4066896495db380182e@syzkaller.appspotmail.com, 
 John Fastabend <john.fastabend@gmail.com>, 
 Edward Adam Davis <eadavis@qq.com>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Message-ID: <660c11a6b3315_1cee208d3@john.notmuch>
In-Reply-To: <20240402104621.1050319-1-jakub@cloudflare.com>
References: <20240402104621.1050319-1-jakub@cloudflare.com>
Subject: RE: [PATCH bpf] bpf, sockmap: Prevent lock inversion deadlock in map
 delete elem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> syzkaller started using corpuses where a BPF tracing program deletes
> elements from a sockmap/sockhash map. Because BPF tracing programs can be
> invoked from any interrupt context, locks taken during a map_delete_elem
> operation must be hardirq-safe. Otherwise a deadlock due to lock inversion
> is possible, as reported by lockdep:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&htab->buckets[i].lock);
>                                local_irq_disable();
>                                lock(&host->lock);
>                                lock(&htab->buckets[i].lock);
>   <Interrupt>
>     lock(&host->lock);
> 
> Locks in sockmap are hardirq-unsafe by design. We expects elements to be
> deleted from sockmap/sockhash only in task (normal) context with interrupts
> enabled, or in softirq context.
> 
> Detect when map_delete_elem operation is invoked from a context which is
> _not_ hardirq-unsafe, that is interrupts are disabled, and bail out with an
> error.
> 
> Note that map updates are not affected by this issue. BPF verifier does not
> allow updating sockmap/sockhash from a BPF tracing program today.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Reported-by: syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
> Closes: https://syzkaller.appspot.com/bug?extid=bc922f476bd65abbd466
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  net/core/sock_map.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Agree.

Acked-by: John Fastabend <john.fastabend@gmail.com>

