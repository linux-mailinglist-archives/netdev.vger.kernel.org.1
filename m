Return-Path: <netdev+bounces-229258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D12BD9EA9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC70C547E0A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27A314D2E;
	Tue, 14 Oct 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HINIdKOO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3F314A69
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450891; cv=none; b=SBUEZMPgbTo0BpvZPbydgY4UTf4AlFd8gB3mRDWMDsShBbivRsvaFhECT7bqlihPonvaV5OMPO509YJc2YkJlrjenhYjwTW1VsHYu9sdG1kbtZKNH/UiDJIeixQnmfRbRAsk7O6Qi48azwZcy/y/nfa2c+PPKsQ/JSrb1Dblbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450891; c=relaxed/simple;
	bh=n7R4IggRMS2QWBufKXlW4yIiJgS8ECJudvpdIBUSECc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRIp25/hrMdH2p9P/GSwV/R5DveAYPB+q8nuSjGIDpt69+fIoVsbQ98mAITvlAJ5JW0iNrOXSM2htEvt3oFO3PMrJ5vGkjW4hrUsgB9Fw/7sQMIXEIWJ05BeoYarK+9ZE39ojCgTbIXOkptmgh4TagzLSAixiDGpv9Yt0Iaxt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HINIdKOO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so3578563a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760450888; x=1761055688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxmeIWwCO+DcngB6umPUO6fAm2SQ1pPxfxXmVq4hIfA=;
        b=HINIdKOOY33PkiZDjSl6H+xlz2+rQ8lRBI6ACLxbWwv8/BrGmsmgQltebAMRhWpHGe
         KnSB/pbQZpbsIAF/1LD0+U4sRuFG644ku98PV5QBVYoDojHKLfk5Iku7kGTfkfk0JW4L
         DbmRLl+gN7S4lxs8iRtR6CDvJVriBBYod5omk2HHJ+zqD6aGcGwixhAPppH3TRM63wm3
         z5/GAN+fLXCD+fhpwUy0VkbkGhsGtumg9rMXQOR70H0RzIgyGL2tTHTT7O0tFPd+4CbY
         m3pHhmx7+atPkS0xuzddiXb9l0nE78yugEmvY5kWyuBsfw1rk4bgG6Do0z6cY8gA9iVL
         0y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450888; x=1761055688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxmeIWwCO+DcngB6umPUO6fAm2SQ1pPxfxXmVq4hIfA=;
        b=BGpsSpQ7j0ViJ3Y0swjQ/RnUsXDoFv0w7Z0j4baMK4vi/V+4WE4EM4lZP4x4EhPfHm
         bdvLzIBxYuPfDDgQn8uB50Ei8VgAlq94X498Fowh+1ncWLlMkeoU4eSuZeLBu/I8nu2l
         OmHAXfmYrfHwWb4fnE1cwDk0n15OxM1kO5PraxtNkUoV6LjpeMAOhjoUdgk1EdiOVDie
         hER17cd3uFoBKG6XLPjVhDO4IByh94xtT0TScZ7zgGM7KaIJykj3VzjoExphoEffEFWy
         /FG13JzZUt2DAYj4Z/UrDDo8j/+AgF1nlR9J83vJxO/qHPhiqzDzkvxnmadXk9qdnRUp
         G0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXbNabxZM3f0ngoeXun389/3NhpVuQiigac3WXJx9l0Pd20EXEObjP+ptE/TYHMJZnVK/wPDZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMuEVfQSi+ZKP2DkSLWUHnlQk9d+TeFnQxqx0XswNlL6hO7+B
	x+lZDSRlmAEiawWplWiXYMPcObwzU1OHkk52z8TVMecRM2JNIGTSXKhG
X-Gm-Gg: ASbGncsXI7BTcC1iijgyQrc5SzVWpbqiQoBa4jbyWB68fjDKDp362GgxlhHZGDYMtSy
	/DCzQDDW9BtWIrq5Qdzt+dmrV3WE6VF6YMVY7g33HyHRUHUg72086CB7nzoo5eoqOHNuUxIWTyL
	IFb3ONoQV+bpfBD9XxRbjVA4aybTDlVaYQlVYT47dSees03uRqZLWn0GIQq2gKOB2Vl6oQABKMX
	+rMUqNzSyYhoNeqgPoHDMPS8ijCDyGw29US8GFCvA0bsUOoOppzYbQ0GvU9W70h9JZkvVuQyMc6
	Po4hHplbQM99MEHUYbmTKTD4Tv6HwMUDfQlEThazGEEidufFHu0enU861kgMBi+XvW9KTU45MD9
	40kfBD5t4dw8ltB+gpSzjXyP1WEFW6FfwBpm07RRBKHfAMwhsE2JxnVA=
X-Google-Smtp-Source: AGHT+IEf3qv2wBAqdGd7LLNTogx5CIdl+mKJKNQg4yODTXzc7y9Gqv2epyMUaFIiqHtW+W3ofsjlrQ==
X-Received: by 2002:a17:907:96a7:b0:b40:b6a9:f6f9 with SMTP id a640c23a62f3a-b50aa8a847emr2748899766b.19.1760450887527;
        Tue, 14 Oct 2025 07:08:07 -0700 (PDT)
Received: from krava ([2a00:102a:5031:2444:abe8:833e:114a:fe50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5c78c15decsm7838366b.50.2025.10.14.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:08:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 16:08:03 +0200
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/1] bpf: test_run: fix ctx leak in
 bpf_prog_test_run_xdp error path
Message-ID: <aO5ZQ9Kgd35nWNod@krava>
References: <20251014120037.1981316-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120037.1981316-1-shardulsb08@gmail.com>

On Tue, Oct 14, 2025 at 05:30:37PM +0530, Shardul Bankar wrote:
> Fix a memory leak in bpf_prog_test_run_xdp() where the context buffer
> allocated by bpf_ctx_init() is not freed when the function returns early
> due to a data size check.
> 
> On the failing path:
>   ctx = bpf_ctx_init(...);
>   if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
>       return -EINVAL;
> 
> The early return bypasses the cleanup label that kfree()s ctx, leading to a
> leak detectable by kmemleak under fuzzing. Change the return to jump to the
> existing free_ctx label.
> 
> Fixes: fe9544ed1a2e ("bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN")
> Reported-by: BPF Runtime Fuzzer (BRF)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  net/bpf/test_run.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..1782e83de2cb 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1269,7 +1269,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		goto free_ctx;
>  
>  	if (kattr->test.data_size_in - meta_sz < ETH_HLEN)
> -		return -EINVAL;
> +		goto free_ctx;
>  
>  	data = bpf_test_init(kattr, linear_sz, max_linear_sz, headroom, tailroom);
>  	if (IS_ERR(data)) {
> -- 
> 2.34.1
> 

