Return-Path: <netdev+bounces-92014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A957C8B4D50
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F321F211B1
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AF773528;
	Sun, 28 Apr 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4sWd3+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F77350E
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326493; cv=none; b=nG+Mo3diBY2eIHEcJVvgIjje9BY+GSJ7QSV090KJxqG73vZnxEN/+R5TLu83pEGCP7RcB8zapBhLnn9h6QgZnl8DWGi+/4Baa9nQU0Sc7y/DdFFtC4pv9nuNczUA9UfrO/p7XjHb/Gs3ehgK8GVkQzlOBkzXfgGEd0nuqLoCDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326493; c=relaxed/simple;
	bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvZfHx//EW6XQyGjp40bJDd/KOWje1g1kVgj5l1tSeXUfdhpCtXcMq9OWVK/4wrmBkUJaAQzVnvUJgbdQzHQDzxcuwsVwE9JvU0j9oaJ/m6SxBFF9hbOU9XJYvwMMrrFe6YmucxilAX/GwMWA9smm3y2bpXFWZRadjwdBZ001M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4sWd3+s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a58e787130fso184118666b.0
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714326491; x=1714931291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
        b=L4sWd3+sEj2NO5C8U9nP2hAUG92qEMs7IS3arCpMGGEmSDwnTShNOSjmXBalO+jjUd
         kzjbOD+cY3wu+bAeLqFwI9LxVjCh4WZ5M68ftWh7F2ONdd6qqs7fhAnkXsgYXGpG1r/o
         44p1leKeBY8TuQm24DizIaIRnya5FX7e97zqZ2E8SKjBlaHsd+2xFlYzw4ufqYVqDZNb
         bDoAH3C4fsi9ffFR6E0drdlCi7LnIRMiEfiphWvS4HjXMO7z8TIUCSir9Hxg6w4SGv/C
         jJXgnx+tCM7Gsh54BJvPV2o7OVj26mf67cBjPvHr2oxv/oUlCtI1O+DvLkhNCfBmJhmO
         n+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714326491; x=1714931291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
        b=WjPr23dYHHgdqTtunv0lkArDD8zbU2EfQa2+9fmOUmL9YwPjwIL6ZGYuGP+n8icYSa
         NE/h+iMNZ9OzfFBMQ5fEm+YpKqnDT+/VWfwxdHEDqD6x7W1/cbdWMCvDWO1ZAbX1fqUE
         Sa72K8auX2El39/sHcfx8AkAa7jTiurji6fBMRib1gqucqqdU+lHwqI77D22Xa87uCby
         ThKl7dOO5etQW7tDjd4uM6L4wLEIdhsYuymhEPHIeoy2Edx6AAyUREtNR8QaXmCTgrks
         eawL2HMOISZ4onqLgoPqw+06OwkLFAcN7sADDdgpEJaHXXSFSlebcMJ90zkgDrb5bNKo
         jmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEQvbwugDmjIHa1ojLmc2vrIi1rWPUWxmwPtkMrzajKc8cISlYxBVzmEnL1fPmp1hpYtCQK8+HkO2D5gFtgvTOS4QGE2FC
X-Gm-Message-State: AOJu0YxU1oPO9xjQHNft3EfnZYq3px9fSnTzAT+TPk/xDJ38k9sopy7T
	7p6fn09BM1s3jXfL+F39l9m6+lUi0mHZ4zbm3acKY8qyZ0lY9v8dqWC27D2KtxWo/VMQkMcNxZA
	6m+mnG0WHeG4KhX9GXaNOGHuLgTHUZ7uAUjzK
X-Google-Smtp-Source: AGHT+IHsqCaumHcpSEMj0qUiqXUFC+VzGr5pfg/19ufHlGUD5YvQ8KDcYV9TqIKpS7vspCjKF0cGITTjN4seBVQbdaM=
X-Received: by 2002:a17:906:4f16:b0:a58:af40:d023 with SMTP id
 t22-20020a1709064f1600b00a58af40d023mr4128985eju.36.1714326490448; Sun, 28
 Apr 2024 10:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev> <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev> <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
 <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
In-Reply-To: <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Sun, 28 Apr 2024 13:47:58 -0400
Message-ID: <CADKFtnQ7L_CSq+CzAOt3PM_Jz2mboGe+Si2TPByt=DuL5Nu=1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Also, all this setup (and test) has to be done in a new netns. Anything blocking
> the kfunc in patch 2 using the current task netns instead of the init_net?
> Add nodad to the "ip -6 addr add...". just in case it may add unnecessary delay.
> This interface/address ping should not be needed. Other tests under prog_tests/
> don't need this interface/address ping also.

I was able to make these changes.

> Does it need a veth pair? The %s2 interface is not used.
>
> Can it be done in lo alone?

I think it may be better to keep it as-is for now with the veth pair.
It turns out that these BPF programs (progs/bind6_prog.c,
progs/bind4_prog.c, and progs/connect4_prog.c) expect the veth pair
setup with these names (test_sock_addr1, test_sock_addr2). We may be
able to update the logic in these BPF programs to allow us to just use
lo, but I'm not sure if we'd be losing out on important test coverage.
Additionally, since we aren't fully retiring test_sock_addr.c yet we'd
also need to change test_sock_addr.sh if we changed
progs/bind6_prog.c, progs/bind4_prog.c, and progs/connect4_prog.c. If
there are no objections to leaving things as-is here, I will send out
v3 with the rest of the changes listed above.

-Jordan

