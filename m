Return-Path: <netdev+bounces-248094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CFD03A8D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F99308144D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16F426682;
	Thu,  8 Jan 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5QoP85R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3JbxpWe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244C42189D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880909; cv=none; b=XKFjd6RIXaMtc/Wo0wtM3SmBJli+nqulgsmo4nSfotiY2x3lJykpt/lD9ZhJTtYBASbdUjeFkPUMpEk9sblJeTEdVn7to9C9AAaCkctkmRh2GGFzDrogKPKXOk/xpfjMyv7SwAeY+JisJf/CmNdVKbxnyen12vD6zWXfRKGTlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880909; c=relaxed/simple;
	bh=CtjrmsOB2mCj2lgwPdRfiuPc5BO/uYM9mUDMD9vab4c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WiRqbCjk01PVqboOq82GVyMCyeZdPvRDw6ZIVfUAAYF+JdknfeJoJg3UttwxR2E2vdvVqWp/HyYGdCTHfCGZRqiDqaOC9oTDNeEb9yxl0nxPfwLc2ZJrnxAfLiUZkEYVQ0AZn91wfzHszUSX1jRmZfPiVNrb6bpFAbACWHUBreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5QoP85R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3JbxpWe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767880906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQa7/1Zt+dnaRaD4ugLaeRuqXLaoL3JF8Ifb+lDa748=;
	b=Q5QoP85RLWHfLIq/ugGxsnZKV+47mGwDS4+ZXdqgGj5QR1ypuwOaDHQfxrP+mt92bGYV5J
	49S8BXGv46bffPCictgQz3+VoKEFh1kV1qMsV8RSDp3Zy41+vADOpmDHoElxilhgRM0XTe
	Oe7g7ehRpCk0UHh5tCIRjFllojo9aeI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-EslUXk3fMnGZtGk5r3L5KQ-1; Thu, 08 Jan 2026 09:01:45 -0500
X-MC-Unique: EslUXk3fMnGZtGk5r3L5KQ-1
X-Mimecast-MFC-AGG-ID: EslUXk3fMnGZtGk5r3L5KQ_1767880903
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b802d6ed5b0so579873366b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767880903; x=1768485703; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQa7/1Zt+dnaRaD4ugLaeRuqXLaoL3JF8Ifb+lDa748=;
        b=d3JbxpWeuQO9rcdUUkNfkwp3+YV0q1CvsHwdSGiy0We+TTptoOAT8OMWYbxLSoZ+hO
         yzUsC3Y/j4/rZi0PvaioKmacFmgz1X8iup3N2qkh6DktmVb23aYJMXRbxHAPNTTOJoa8
         wmFkUTMxvia5axuSFE0V78Vi7a3HFPKZoUvJiUDx+UcY6hbVOKcWAT0FWJoI+ENpOSZj
         4TBwy28BhEsZwB53ce+Cp5bUoCeyRT902S1aFPph4Ow1qdqvYXx2tPTqqFd5AJ0OZB6t
         VgnnDHkiIHwzvG7yw/peAr+5LgKdSyy2Mp+2DJV75AWcq7nT7JVbavJKvATQk8SxcEB/
         3c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880903; x=1768485703;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQa7/1Zt+dnaRaD4ugLaeRuqXLaoL3JF8Ifb+lDa748=;
        b=XVRud/bNYy4KxpMBOzLPjcuAmxHdoSF28INLpo52IFT9Yp077cQU+fCALKAOSbvl07
         /Imyv2Bg99hf5snNDQvGUfbnYVW177pN1HIK1cbwMLjPEt2L5VFACwti8NUrwx0RSdlM
         YgEwipKuLRtJi3Qil96F9LSM0D4HXafcargcg8MEUYvnbUyaDoT5L52PwRAl+/MVVE1+
         vFhjE/zdxyhB0UHLTf53wJXsx628IwKCvK84fru2ABkkjcmULbSSF6qCcLjHZnOY0B5o
         RcJtRUAfoMg8IFwS51nbN54IpcRS63dRrnMbvtZ02lTvmD/P78k7B2fMpXpBzF6BFELl
         UBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUJe8galhCfFRwyf3gSyDOplIgyAfYRyX7nLg+hes5+puhlhOAjmxnkTRRJVjhTe+W0sv/WBzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5a+YO1KNq9MkjIWDtbW3XujzofN7vw1/W0FWUcDvlgZ6ez+aP
	ANK4TRW/CrDZLBvKaKUW4eSVNCr5C9ZQgMmuLbaaLxzjOrtdhKSj2jYZeGg9hDQTI7JXlRV72mg
	bTlf1tmaqpkoaxGAdHjVG6r6RRnhxKbxAPyF8/IciBB+fzP2S1Ty1O0drjLxmL+qqpA==
X-Gm-Gg: AY/fxX7plYeFaGQUeFtO2rWfGgwQGZBaGlUehiwKJXYa0RwfFPUHqqXrzclBzJaKTGE
	qGi3rt3qCrI1vnLmy8PXgrFG+rCqmdahLwcvAeE0XdmLjq/6wE5sBrY+ePay2khgr8bR9KdhgIT
	7Di9XKRaJfdfyu/45+B7I8Tbb4YR8gbtEP4mw9e+eUA57fJ7ffT6BxeqM998UJJh/JPbxyJVJ1p
	e8ZK5puzwqd4U0SQFY/B3KhWhsaEfTrHcBdW3YLoULWcbnwjO/k6hVCBMBivIv1ocONV+ivzGJR
	2suKja6LeE9WxCdyog9aiELbb+t+NQVibYSJOfqluJ02K3/kYnU7yT2osWJDIRXwy52EdwyMFGf
	QN7qIHFKLc4l/7U5MmEAbd7khUoLdgMl8gkdz
X-Received: by 2002:a17:907:6e93:b0:b72:b7cd:f59e with SMTP id a640c23a62f3a-b8444c8f7e1mr683440766b.8.1767880902584;
        Thu, 08 Jan 2026 06:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlhIIhaBb2McQwvoWk8N0JL7SSuE00CIJ5So+f8CTldzHzJorWqIOgybxuvnaqsIbBkpucBA==
X-Received: by 2002:a17:907:6e93:b0:b72:b7cd:f59e with SMTP id a640c23a62f3a-b8444c8f7e1mr683436266b.8.1767880902102;
        Thu, 08 Jan 2026 06:01:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564284sm829495666b.62.2026.01.08.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:01:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF187408379; Thu, 08 Jan 2026 15:01:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
In-Reply-To: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
References: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Jan 2026 15:01:40 +0100
Message-ID: <87qzs02ofv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> syzbot is reporting
>
>   unregister_netdevice: waiting for sit0 to become free. Usage count = 2
>
> problem. A debug printk() patch found that a refcount is obtained at
> xdp_convert_md_to_buff() from bpf_prog_test_run_xdp().
>
> According to commit ec94670fcb3b ("bpf: Support specifying ingress via
> xdp_md context in BPF_PROG_TEST_RUN"), the refcount obtained by
> xdp_convert_md_to_buff() will be released by xdp_convert_buff_to_md().
>
> Therefore, we can consider that the error handling path introduced by
> commit 1c1949982524 ("bpf: introduce frags support to
> bpf_prog_test_run_xdp()") forgot to call xdp_convert_buff_to_md().
>
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Since syzbot has no reproducer for this problem, I can't test this patch.
>
>  net/bpf/test_run.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 655efac6f133..9a16293ba14b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1355,13 +1355,13 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  
>  			if (sinfo->nr_frags == MAX_SKB_FRAGS) {
>  				ret = -ENOMEM;
> -				goto out;
> +				goto out_put_dev;
>  			}
>  
>  			page = alloc_page(GFP_KERNEL);
>  			if (!page) {
>  				ret = -ENOMEM;
> -				goto out;
> +				goto out_put_dev;
>  			}
>  
>  			frag = &sinfo->frags[sinfo->nr_frags++];
> @@ -1373,7 +1373,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  			if (copy_from_user(page_address(page), data_in + size,
>  					   data_len)) {
>  				ret = -EFAULT;
> -				goto out;
> +				goto out_put_dev;
>  			}
>  			sinfo->xdp_frags_size += data_len;
>  			size += data_len;
> @@ -1388,6 +1388,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		ret = bpf_test_run_xdp_live(prog, &xdp, repeat, batch_size, &duration);
>  	else
>  		ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
> +out_put_dev:
>  	/* We convert the xdp_buff back to an xdp_md before checking the return
>  	 * code so the reference count of any held netdevice will be decremented
>  	 * even if the test run failed.

Hmm, this will end up call bpf_ctx_finish() in the error path, which I'm
not sure we want?

Could we just move the xdp_convert_md_to_buff() call to after the frags
have been copied? Not sure there's technically any dependency there,
even though it does look a little off?

-Toke


