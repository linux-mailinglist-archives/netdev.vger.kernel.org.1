Return-Path: <netdev+bounces-112152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D5937258
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D363E281FF0
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675845C18;
	Fri, 19 Jul 2024 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T/WZXoB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6437708
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354891; cv=none; b=qnMc2AJKaiHMQQdUMpJskT3Y5nOk8WGrHrP9OKjy3paHm4xhvJl6V2Z4ZTJyaraKFPn9nDA4FtsVUehNibWlyuimMaMWPzcOKPrxmaMqUtqyVI7xjJkhu0iJAOGL4XThlCNhRuIBcqFcI6PrtOq0h425kXub2sLGHJANPkPNVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354891; c=relaxed/simple;
	bh=K3kRa8M3XjJ6TYCBzNSI7QLaEzBmwYjbaWzmaybCoBA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=fJz+Ncjt3a0D/+biwUptJqWy+Csyinag56T+dE74vheUZSqi0VV7HkOMpBi4sAbfQAKVny6b5KR0SDXo9bgcKeFrpEN3qMEwTz0wROChlgXOhr9g7UpPPRWfMkXKM71Z52uqgIoZnAFa+qQlxhKmVynYbr3IFxZh6y2T9pZ4Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T/WZXoB/; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79ef7ecc7d4so54991085a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354887; x=1721959687; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=T/WZXoB/Uk5dXKxdM91e+evI9UA50w4YJkvGfiR+KicDHnrBLsl7spyVjtojoh9j9e
         iCHR6bD5sAJXIlFsHuWrttE4dC2MAqvT4yuDWQZPVv7gEZ/5uQZ3WDmZk4H48ucmH/t4
         QwJoSBjQSGvWGH4pP8QEdzEuAKxqiFhgPcNj9zgMfo6F8VfgYoykQIn6mp7KxBuI3AOc
         2eGFnFm63Pt7h3rk2pAvapCKTcjJtW5agpD0ZP9S2YrFdYKurghIoqCZEPU1+k33JGSy
         Lsi5Ag1JE2Zy1HnnsldPiHemkZ7W8W/zj+lwSZdOcqks7yVpZ5TlFdzmaXebJ0zB/30y
         LYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354887; x=1721959687;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=n0wLwynwnCVELh+nzpVXs/47ARLknDOuvNY6ETHc+xt8D1PagDXLcV/aIicst6yoqK
         aiy5ezxpffMJTjapyY3tV/OBoWNJ1v8s1D6Sp/Cnkj6GX0QvO1sqobmdu2F5YcHw/O4P
         VaeE4skVJ6hHO3kNGIO5uEqRL/qwzv65j4wdr7k/9YxH2KSxru5HI3hh/DeqxVyUVXz6
         oZ/V8ip0C48IekrLsU+kR7myui0PWIAS+gFOl/gRaIg0nLU+lk0TrzEROYwDZFgjL9JO
         FTmEPpyEAv0CMsiVRzBTnTtnUsooStozo/CU7v2Y9efknQkq4kQcWfu6J1/J/tThL7jv
         MmUA==
X-Forwarded-Encrypted: i=1; AJvYcCX/02ZqW+jwRIXhkEikNR0BzeiamNahRXFGWC81T2DN2IPc6lir/eDnxaM4yqyDHQXUj+00KcOvXek11SDebbwgkBK5ztfW
X-Gm-Message-State: AOJu0YxhkKOf/4PIgj6a3vV7Eu/nVjnIQhdaCOQQ/r+BKIaXRKUT679j
	DZ+y5ono3wtlXzh8Slz6RbG2FlZ/cr8PD8AKuTzbi9tGkbf2RHTBAfzSsiqTzw==
X-Google-Smtp-Source: AGHT+IHJXqsEfMvaJ3I4voV7h0JmzEBLz/Y77YU9PWIwttNlLAz95UGh+qmMP8iEzkPgMVaZTYkx+Q==
X-Received: by 2002:a05:620a:4014:b0:79e:ff47:3307 with SMTP id af79cd13be357-7a1938c1fb6mr351466485a.8.1721354887484;
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198e9f7ccsm22476985a.0.2024.07.18.19.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:06 -0400
Message-ID: <35bc63dac544edc75c25b8dc6c8c99d0@paul-moore.com>
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
Subject: Re: [PATCH v4 8/20] lsm: Refactor return value of LSM hook getprocattr
References: <20240711111908.3817636-9-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-9-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getprocattr to 0 or a negative error code.
> 
> Before:
> - Hook getprocattr returns length of value on success or a negative
>   error code on failure.
> 
> After:
> - Hook getprocattr returns 0 on success or a negative error code on
>   failure. An output parameter @len is introduced to hold the
>   length of value on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/proc/base.c                |  5 ++++-
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  7 +++++--
>  security/security.c           |  8 +++++---
>  security/selinux/hooks.c      | 16 +++++++++-------
>  security/smack/smack_lsm.c    | 11 ++++++-----
>  7 files changed, 33 insertions(+), 21 deletions(-)

The patch 07/20 comments also apply here.

--
paul-moore.com

