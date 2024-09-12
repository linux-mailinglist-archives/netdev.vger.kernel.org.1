Return-Path: <netdev+bounces-127957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C326977368
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0071C213F1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2B11C2422;
	Thu, 12 Sep 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgrAtnXr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312131C2326
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175693; cv=none; b=ecikbgF9aSKNHy29APbNCJSss/fTjKJtdWBu0Rd6j+46+YqpeeKcSwJ4qwoyfGdi0DqWHbimWR3QczhCb4vG2YQZlGh2Dqr4ksicxk11Jj1oJ95xtDZy49Vz+xNk8ZN2VafEs8hlIi/SohnjWfM78mq/UCOW6bmkfxJguN0aG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175693; c=relaxed/simple;
	bh=peVnoRwbqecr/0PJF00iv4hFysL5tmps7T44YTBQn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lybie4kkNBhdSKvkus3c6VeZvk2423bOYzILJ90OHF2NZoKPO/khhJRePZkc5GQxb5hDhiWklCfLT9SbqHsKBZxezGqUu5OPG1lhVvzmALKafXE/9s74jge7wIUHS6ptjM964ylto/ATnTFcUv1JPhsKg6tnfiuKpqqIL6qI9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgrAtnXr; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e03a5ed4d7so745760b6e.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726175691; x=1726780491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EO0qmaSPp73jvXnTs7TJzCKL8q51LBbEbQNyisfg4c=;
        b=TgrAtnXr/7OJjvCVwZLNYSuwZYI+CkWtp53jxLr5DY6OZMrP9OBl6+HAyQk39Vmnoh
         qqFlvNt44CLztfbZrj0FuRCR2iGPcc5KwKMipprl2samIjPIUTwaC70Mb9o7pSqUALGS
         Y1XgtxzCoN2PV7HZ0F2hE5CbBIAFQWCEhapMSPTvKUjbbG/dkBUb37F4sJm/Y1dxF/Fr
         W6/AXeohOW30JF1yMFMif9gq8qYKoFtgGFkSwa9AId0I5wgxwi5PemXv+4fDECM9suBZ
         3A3nv5hCG0cMhnOLAQ3WtQ+XBjSLOF1Q0kJvhR5D+s+tgs3yeGY0AdbQe17Y81c19wFz
         +PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175691; x=1726780491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EO0qmaSPp73jvXnTs7TJzCKL8q51LBbEbQNyisfg4c=;
        b=t0L53+iG+cN9sDuE0Umajb4rgBkqUCZ6qOPsA/gAhoO0WuA2m1KF1x61Q7aA7rhDBL
         k1f4aEU6QnKVFUG+Bldz6UNaMBJ43R0HRwNLFxPi1myHQdKizUBBL31fGypM/paKjNiM
         XEQCHfrX+hO+wV83V5kxO7SsgsTUiTwrkE91wwVqFNvLWRcamAI/J0NxQ277+IkfiUxs
         8FDSPWkrwVIR4kd9WW/3f6+il8I9ictPfvo4IBM1Y9ZoFCNSnoR8fWB6dNH2GZFsw/gB
         +YaEZ/lSHR+CwyJIT3w3fKXDMU3JBPZbOGepDwTUUr810b5pWJ/s01EFQ2XHRKJx2PDU
         ht1g==
X-Forwarded-Encrypted: i=1; AJvYcCVzsAKbmLBxK3amQgtcoOq4/maQbYF8as0zzMMQCqWyM1TxC9jI3TtPNCJqf51b2DmrVzSuEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNzlOZeMnAbXoFfBcheb/zLlbOLNFHD4vhVc0r1VUvsDQTlgk
	BpWNf1hA6f/X+P69jqshA+Io5HjdHTeXYCNwNdcGHn/vSu1RU0alBbt9cvbKMw==
X-Google-Smtp-Source: AGHT+IEXhrO73skogk/s/nT+zYKnKQ0Yub0DnxaAiKfl03Q20IYpu3fPe1nRti4noHn1qI7LW/QNUg==
X-Received: by 2002:a05:6808:399b:b0:3d9:3a2f:959e with SMTP id 5614622812f47-3e0719ee561mr3950771b6e.0.1726175691128;
        Thu, 12 Sep 2024 14:14:51 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1cab53594sm2250200eaf.43.2024.09.12.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:14:50 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:14:47 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v8 4/8] bpftool: Ensure task comm is always NUL-terminated
Message-ID: <ozoyqz5a7zssggowambojv4x6fbhdl6iqjopgnycca223jm6sz@pdzdmshhdgwn>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-5-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:17AM GMT, Yafang Shao wrote:
> Let's explicitly ensure the destination string is NUL-terminated. This way,
> it won't be affected by changes to the source string.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/bpf/bpftool/pids.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 9b898571b49e..23f488cf1740 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>  		ref = &refs->refs[refs->ref_cnt];
>  		ref->pid = e->pid;
>  		memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +		ref->comm[sizeof(ref->comm) - 1] = '\0';

...

>  		refs->ref_cnt++;
>  
>  		return;
> @@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>  	ref = &refs->refs[0];
>  	ref->pid = e->pid;
>  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
> +	ref->comm[sizeof(ref->comm) - 1] = '\0';

Excuse my ignorance, do we not have a strscpy() equivalent usable in bpf
code?

>  	refs->ref_cnt = 1;
>  	refs->has_bpf_cookie = e->has_bpf_cookie;
>  	refs->bpf_cookie = e->bpf_cookie;
> -- 
> 2.43.5
> 

Thanks
Justin

