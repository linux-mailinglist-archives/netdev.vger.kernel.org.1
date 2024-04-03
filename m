Return-Path: <netdev+bounces-84204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB74896077
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B5128795F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B156161;
	Wed,  3 Apr 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMQxbw1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31C1859
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102736; cv=none; b=i7rRq2nq1eGJi9I8lLRUrH3YYDb+THimdtyVIOGZ4W0c1v3j8VhBU0ZearGb89SLaDbPXSi/m6fUBSPyrlu81IGKqygAfDwwHPK1mz1Gy4U2q+vRGoK+sdnK6mq7yBFMLesSfBNUyYW3rZUMJ5L16N98rf6rufRZ+Grnl2iU08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102736; c=relaxed/simple;
	bh=RDMYY18P2NsSYIurbiIbP840Ysle6CNN0GbmZSlGRfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6NumvnNNU+6pI2MLISATNQy0TCUXj6PQuF3GaR5xi4vPTpox53BvYT/N3V5m2st+/XAve0cC6gD4pOMTkE2RqrrqBl36BxAImh434MdgEo4WCQnTpCY4b2XkoBO2w0axhFjPU4gau+fVM9jdKBOMEp42DqYhtZV6ffaimKh0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMQxbw1S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78c609a533eso40020785a.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712102733; x=1712707533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDMYY18P2NsSYIurbiIbP840Ysle6CNN0GbmZSlGRfo=;
        b=pMQxbw1SvbH4nwFpgHxLeLL2NtslguVTdUm5k1GaqmFnP5QeetMxCtJqiy+Nr+xwPS
         ZFDvBU0dATPx0E/V7i2FXwtxSIURJIkX07j6tf5xgtmAKnKYsSGMHyv3ClZOe8aYFGUW
         YUi71R79qqEuKJaEYTP8PjhknujDt2qlt9Ru271y5Zns8er2hFweD1bpquc0eLbHNwKf
         harD7Q/Xb2Ep3zmSQAR9KoeTbYQ6HODmAMnkXSp+i+t81YDC7dzaTZSBo+S6ZpDSIOZ0
         lqMGweCLwHH3dLZLzX5x1fHwHK6p4rH/qXDQ1EqxheMHhS3nE+SVBCwPICWQUlkNKUtZ
         bnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712102733; x=1712707533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDMYY18P2NsSYIurbiIbP840Ysle6CNN0GbmZSlGRfo=;
        b=OI9prgdfihNKsk92SVyYNpHCE5mDI0rV3hu5RyBx+O3Y5ZrvDaEfwdoNcb86xEkInb
         pDEs57LKdAAZm2S5QTKVwf/F0aN5Ar2/is6XVxPXSbJwGpVzVs8dnhV0Nz8GwLo6Lbpv
         8Qlsp50n98/Hv13undkt+PEg0OP6ULXnnfkpxMe4HtDj0hulKpAr86le6UYVFvoduFnR
         +rqlZ+JPmV6vWWDLDeHXJOnoNF0VtETi2H8IWNfzOUR1IctmyBYqurBtOHSr5cpJxEvD
         ZfxD2oyvCnRejHAzMmeu6hHMvPcjpvhUQdeF/uHAelZesExVy5SHvPeEw3uuu5i2O9Za
         7gnw==
X-Forwarded-Encrypted: i=1; AJvYcCUsV/MfwlL0sH/JiVQH5EqIuHODGremO+Rqry0UGobeZio1Oo4cqt7TPIbIZ+wSp6+L6R+lq43B8vi87OT6KwjC+F61O6Uf
X-Gm-Message-State: AOJu0Yx8pZFxRGcVsO6lH7pY9xngeIHpmQfBCwmlCEb/8kwUKwETFV/N
	Nd+VFYBMTN9RXdT/nudRHpacix02J9E09AxKGeSeIvsxkG5BvfeWRWRl48egmqSKJxaFaM7rvod
	e9z5Z9yPP+vHMcGTnJPS7tgxumBN94f08dEe4
X-Google-Smtp-Source: AGHT+IGypiqeNAIc9rEaIDvehU8Z+DZPGsok/ERp0AwYGK9F5oxxCPI4U6s30cz39L8i2hIPuXr2oSdiP8wgAKaUYeA=
X-Received: by 2002:a05:6214:326:b0:699:11ba:888d with SMTP id
 j6-20020a056214032600b0069911ba888dmr1736867qvu.30.1712102733505; Tue, 02 Apr
 2024 17:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.1808635-6-jrife@google.com>
 <59c52263-edd2-4585-b4f0-28c8d92d572c@linux.dev>
In-Reply-To: <59c52263-edd2-4585-b4f0-28c8d92d572c@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 2 Apr 2024 17:05:18 -0700
Message-ID: <CADKFtnRt=5r__PdpZ14mpJz1LfeaLQHjUJMHzCpWsMJ4m2rEjw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 5/8] selftests/bpf: Factor out load_path and
 defines from test_sock_addr
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The newer prog_tests/sock_addr.c was created when adding AF_UNIX support. It has
> a very similar setup as the older test_sock_addr.c and the intention was to
> finally retire test_sock_addr.c. e.g. It also has "load_fn loadfn" but is done
> with skeleton, the program is also attached to cgroup...etc.

Thanks, I wasn't sure what the preferred direction would be here. I
saw some discussion
in the AF_UNIX support patch series about prog_tests being the
preferred approach and
there being plans to migrate the old test_sock_addr.c tests to the new format.

I suspect the changes mentioned here (load done with skeleton, etc.)
and helpers needed
to support the tests in my patch series may also be helpful in
retiring test_sock_addr.c.

> Instead of adding a new sock_addr_kern.c in patch 7, it probably will be easier
> to add the kernel socket tests into the existing prog_tests/sock_addr.c.

Originally it felt awkward to try to merge these tests with
prog_tests/sock_addr.c, because
while the goals are similar the flow is different with
loading/unloading a kernel module to
drive socket operations. I'll revisit this and see if I can merge
everything into
prog_tests/sock_addr.c. Switching to kfuncs as mentioned earlier might
make this simpler
as well.

> Also setup the netns and veth in the prog_tests/sock_addr.c instead of calling
> out the test_sock_addr.sh (which should also go away eventually), there are
> examples in prog_tests/ (e.g. mptcp.c).

Ack. Sure thing.

-Jordan

