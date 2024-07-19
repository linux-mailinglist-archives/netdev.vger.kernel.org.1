Return-Path: <netdev+bounces-112150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DA937249
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461C61F21E2B
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99F383AE;
	Fri, 19 Jul 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sglmx1f3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A0224DC
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354889; cv=none; b=LkZhxXOXW5xTKjtZrZkijHTzvop0vauc24bELrfzVDYZiSDSmayuyjM9EZ6QYyqkVfws/+9BGv9FJ0VpqUf5Jab09k9ySG7hqbzVyQcZeAiM5qk3/OVHds5uRBluz+auBG7DZOa6+P84JNx2/7HMExEpTqoyPeKW4KZmt0+KIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354889; c=relaxed/simple;
	bh=3kQS2cZBJ39f+nV1qKNmNoKNDB7FDTY1mI5qcsc0L6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KN/giISuiqqNRYx+rRm6jYKhjCgll4OYReuFKeT0cwSpYwNTN3wx0o+vGOQ4V3A/mE2tsVPr1elw2wf6vMc/taDtYTvF/hHRtNYAvGn3m+p9PgJ0ucaRJ/d/vdd4ZajhLjNqDcbVAB9xdiZ1M7ypwybuWAoSt0QpKZ5ZgFj40/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sglmx1f3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b5f128b199so7914326d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354885; x=1721959685; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=Sglmx1f3HxwYDuZhNdqszpf7ee9npoLHouQusVyxJTkA612qitV26LgWBlT7XaBiKp
         5G8FhtA4Ko05Q6Ly4/q/voIWCCgMcit6EpD5v8roA6MDiD+8THrG4sPgqFb1aJ/oW+uf
         kOG5YWA4XecbZJeGTyp9/RnudcenATcktfFG5SShxjgGUVAPoK3ESO95raBdZaTmaCHc
         0NqgoNZjuruSZ+gGuEb7aO83g6Zh0YUfs58/SisBYf5zS4WB3Ffm2HiCVMZtQZs/MLca
         9u6BNow7pAxIGdsDaT6Dhs9/v2z9TH/HCsghNHsEZ8eueX4UAxDQ/55u/7Z6ODOC7dBa
         p9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354885; x=1721959685;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdOweloEpaz6RcCvISa0YGQIo20b47lcaEayePDedxM=;
        b=Vx8H2/uPSSGFX/Jo06LLJ/G8cuaX0B2n4VGUoj+SQ/CKkZOsQWyM8MaSOk19oMj28/
         DXuiNKo4k9J6A21w8Z57Nm0iZj/IpCX/d1yrt9bfp7kUsV9hHH/UxH6HPosTZb40SlM8
         uWUuOKC9peV9hf5Lt4m6DObayBklcBuHvDFx2OolyGQxSEkUmmbqMyJtukHd6oF+p80H
         ZZGkpZt6an4zeVtono439XGNaCsrF2cVhXKsnFnglTvxc8a6oAvbiGOavtq+O0JWb5ff
         MtFztpO4lEgeSp5CGGb1gru8FleQBXNaZ8wzEYUlpF1Cg6h4+cd+MdB3sFAQljBiKdms
         jn6A==
X-Forwarded-Encrypted: i=1; AJvYcCVMvYEiYHE6VRAK9QbhZ+mzDmEapMsWH2brGdurwZQNxB1qgIdasQrMijhkG6ok90ueHblDuHsL0C3gzYs/5RmhWUpk9swR
X-Gm-Message-State: AOJu0YwvATOK2aD2vxv92CWD6e4fnG+BItD8Qy3r2LqBLGWrf6nacZgc
	H95tnd1ia18Oia2FYI0jVFJKMLRGFwLIjNaIc3pK8AYIKIaNvnNenk1MNADJGA==
X-Google-Smtp-Source: AGHT+IF74+EqudtKUL7i1ZCCvXjz+qd3zopM19m0jWGVbddz7RHlAWv2UgDf87dhf8FKY+88djubgQ==
X-Received: by 2002:a05:6214:2301:b0:6b5:3c06:a58b with SMTP id 6a1803df08f44-6b78e364c4fmr77396666d6.59.1721354885611;
        Thu, 18 Jul 2024 19:08:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7dfc97sm1785356d6.46.2024.07.18.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:04 -0400
Message-ID: <6e79c031aa6c223df552726ac6537d44@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 6/20] lsm: Refactor return value of LSM hook getselfattr
References: <20240711111908.3817636-7-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-7-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getselfattr to 0 or a negative error code.
> 
> Before:
> - Hook getselfattr returns number of attributes found on success
>   or a negative error code on failure.
> 
> After:
> - Hook getselfattr returns 0 on success or a negative error code
>   on failure. An output parameter @nattr is introduced to hold
>   the number of attributes found on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  5 +++--
>  security/lsm_syscalls.c       |  6 +++++-
>  security/security.c           | 18 +++++++++++-------
>  security/selinux/hooks.c      | 13 +++++++++----
>  security/smack/smack_lsm.c    | 13 +++++++++----
>  7 files changed, 41 insertions(+), 21 deletions(-)

The getselfattr hook is different from the majority of the other LSM
hooks as getselfattr is used as part of lsm_get_self_attr(2) syscall and
not by other subsystems within the kernel.  Let's leave it as-is for now
as it is sufficiently special case that a deviation is okay.

--
paul-moore.com

