Return-Path: <netdev+bounces-299461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4UgtFp0AMGpfLgUAu9opvQ
	(envelope-from <netdev+bounces-299461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B992686CDC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Bdt3nHF5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299461-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60F253002F5C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D013F4DD8;
	Mon, 15 Jun 2026 13:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0C3F4842
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:39:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530774; cv=none; b=LpNYFRDd+Zvlp3kPA7ygs5JJf9FylqwK8X5WVh7dFMa+n2Eww6oUvxYs0I/1GJ9LjcJle9BKaoOY0zoYBL2NX+cdIQkapbhU0ZCEOa4DZEReEa0RqdsNgZH205SI6iQdu+Kr4Dn7Bw1vHJnPFW0hsLxrwBd2Gz38UEtdiaoc1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530774; c=relaxed/simple;
	bh=Uken4tM4LxzRAW3DPWFxQEaIbrL9f7E0s+GyqkDZQbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyVDFayI6PsCqgCx6XcmXaIYjdpM0YDl8Ygg+91k0RlSA1Jc0C58irWPEQ70BxIISBlBGasmMYxp7aLKaVszX1BC+s8ncPFQzq4TyLj1YrX02aX3CpA7hLEqfn3KfXtxeyDzOZ3UD8Z1J1cwEQV0Dt52+XAAo0SRtjI1rjcFMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdt3nHF5; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eedc94d37so1868009f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781530771; x=1782135571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crU/YWEeXaonCN7cJRF0MeFCZ4XnzfssYJGTp4fDCnc=;
        b=Bdt3nHF5hGSg8d0r7B0cj2jqsYQBSlO+7FeZSaKD4H0o3EaOuzFqDclquYq18IBYbY
         VUoAE+YdasM9jcPJTvIDc5Iy5VWYV2nMeNR7FjQfqDHnruNZBr2Ya48ojvyBgX9s124a
         BgHIGRQjgc8ZwVkQ7+j7Hfmb6cD5aCaenutKjBOXigMVdpwoyzrgMsBE2NV5lHCcIzki
         1/H7d1u2WBGx7UomjC/6hKaH/cCJ33Avsg0sIWcyqyd6KhuOShJJijcv9f+eUoU+x9VI
         eNlAqLHFaoPwsyOXb4JQgqrmPB1Kxia38QoNreaep5IK3JptMrdroDJqJQorkyIxk97h
         vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781530771; x=1782135571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crU/YWEeXaonCN7cJRF0MeFCZ4XnzfssYJGTp4fDCnc=;
        b=J7kMGw3MUaCd+8srh89BLJh3Cl1EfWNKFsApJ9FTUHDX5xCjh/dRA1TsPQM0AE56KR
         JacCijmh7O4lMwJq+QgJUqtqnH5uf7P3HrPV/sD8+QbSGfLZEENvLHZXq6uCPuVEqMtm
         /FoWCC7bO9TfCaok3RsSA74AAVpHCpO6HQp15VfMYnxL6UI6s736J1XzVHOa1tUuQ3fA
         3d4Rc5/8jD1bUFNo3yFbhaPCp/BWvF4RohAuLkFNlojAY19umVt5/h810l4o5uDfXQ5M
         vJzHq3s/T+yZpRjNxnl9ClxOaS7kjHbntQV8OK/q97XBbL1TfFVnwZT8wrt8SUTrz30Y
         /Qiw==
X-Forwarded-Encrypted: i=1; AFNElJ+zQZnzncVWb051HOa/xdh633BSRsQ/2c1HZOty95VwbsV0n9Op7mEn6QCgZUFfY4Ygn366+Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9f9C6LPZH9E4zN0ef8R0lLSA4nwzmp81v21U0no9MZc73bBNP
	cOGJD1HmgyQKlgTOMJ58BhBlot0dgZ52pJeB+3MmeD8uzk92Hr7yI0tu
X-Gm-Gg: Acq92OE6kMwAjzT+4O+3bkrcbdMw/SfyGuaHvKLmKv73tZkXzH5Kvj7ZcXESyCkygkf
	lNI+XVfU4XI8Iv+uyOJ48YkcrPyBdVmq1vG8xeV7bwP/1J3oBtZHCJWau5Y+R14UimkYe/YEuOs
	vBAmvLJmPyKp9m/K6koAP+5rmBMaqk/BeTW1v4ljMTS9d1A37YXSRdddR47OdmAM842Qsh/omxJ
	RvzxmGPk3ol2bA5RC6MVOxGrfRYmminEqbNG40WuSxf7GtrFmyRagl0kyfqVKjFQTAhmYYygQXY
	4SzAz3u/ncgM1IhCkOJ5VPgk7LemG4wS66JYYomqBcbLuZ7Hwy9mlOq9eOvkgDJh03R1FQPdkTn
	zcz3qEtPEu8jrsOhl5/ws0fAeFRlt8A1iMdLHuyCSCgkDn0aLCQYXfzLDW8U5fyivTF5fs0xHJb
	O6zy+hkU5QS2GMwIMwgpiFdSX/35Gkd+byO0/YqButAkMRXm1Dn6Xl45Wk+CaotE5bGLGlTW4sH
	byczdIoAk8lj/Y3gOtAp8FUj9Lz85z6QsxF1XHBxUuUdYrO7vNYFZw+HiLNzJ2iY5x87c1kvx7L
	izGw7MNikfie0utVVC3B0+0ZLUZAciXy/zkaRV7KVNw=
X-Received: by 2002:a5d:5d81:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4606da622ffmr21403888f8f.18.1781530771203;
        Mon, 15 Jun 2026 06:39:31 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm35148433f8f.8.2026.06.15.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 06:39:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:39:28 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run
 output
Message-ID: <ajAAkIv0R3ztfc5g@mail.gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615073856.152479-2-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299461-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B992686CDC

On Mon, Jun 15, 2026 at 03:38:55PM +0800, Sun Jian wrote:
> For non-linear skbs, bpf_test_finish() derives the linear head copy
> length from copy_size - frag_size. This only matches the skb head length
> when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.

Thanks for fixing this!

> 
> Compute the linear head length from the skb layout instead, and clamp the
> head copy length to copy_size. This preserves the expected partial-copy
> semantics: return -ENOSPC, copy the packet prefix that fits in data_out,
> and report the full packet length through data_size_out.
> 
> Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")

Wouldn't this bug actually go back to 7855e0db150ad ("bpf: test_run:
add xdp_shared_info pointer in bpf_test_finish signature") and also
affect the XDP bpf_prog_test_run_xdp()? If so, could you also add a
selftest that covers it for XDP?

> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..976e8fa31bc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
>  	}
>  
>  	if (data_out) {
> -		int len = sinfo ? copy_size - frag_size : copy_size;
> -
> -		if (len < 0) {
> -			err = -ENOSPC;
> -			goto out;
> -		}
> +		u32 head_len = size - frag_size;
> +		u32 len = min(copy_size, head_len);
>  
>  		if (copy_to_user(data_out, data, len))
>  			goto out;
>  
>  		if (sinfo) {
> -			int i, offset = len;
> +			u32 offset = len;
>  			u32 data_len;
> +			int i;
>  
>  			for (i = 0; i < sinfo->nr_frags; i++) {
>  				skb_frag_t *frag = &sinfo->frags[i];
> -- 
> 2.43.0
> 

