Return-Path: <netdev+bounces-271538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK7dKT/cw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A6325529
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D0FA30078BC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4C3D5670;
	Wed, 25 Mar 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw/UpztU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E283D5646
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443090; cv=none; b=RtrbSoEfABo2zFXWuufhfYqJ7A7t7enQibt3at++ifJLKpk9uzHtYaqySVzBbpbB+CQ/TDAoQRvH2GJuBxylzvwOeagDyBqnbFtu89D1guf1jBymV0QlOMAQJ1tHtZkUc5sSysyWicYyYJYLdnZnFMhqVdCr4uW7ASRdTgVmXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443090; c=relaxed/simple;
	bh=GPBTp+1O4+roFKFHMU9nfDulOedOh68Qri2l6aoSPhc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqkYpKSPJBT6IlW8uAdTg83ViuIihPNG8kCdPsnjt++2+vRHUto0ZZWNE/ZfkGCwCwWRRyh8KzObxXx1MH3J+0F2ersjhaNEHT7LE+TKQ+CNRXq9YtNZ3nNUyuGmgY9dJKgeWcGgkjyWwjEYYXKpSnfSPkH+4vvuHLd9+VFtgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw/UpztU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso44953735e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443088; x=1775047888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZG+AxjObasS6xwUegN7FbbmRxqAFvfcWHCDJeVu0lU=;
        b=Uw/UpztUI/fwK/0kWmaICCJCsgBuI7s8r37hRp0B7mNVy69q7vWu4z5CkKIzzJ8nTa
         6KcI66TElgzmXbJyBwjJSdXdPmQ3b0ntBEQavyWOAX3V94aBR3KmUtguB3Q+MXY3RpKn
         KIWTLZIqr/jy2pvYBXs21o/6oCBXESOU2ToR/5N2EyI9OO0TFhUnxSXgQWTHJbLNABmF
         BZgVfP1wK38qZsN/eI7x11EvPVJI5Z92aLCGQu+LwOqw/6CVftuDG2oldc0qIOUYtvSB
         NRVjm9h3O+YsXje2m+o8wgfrWX0Zn0wbXVFv1H7azG2ztwltcGMBojfknS49LYY2LS8a
         wE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443088; x=1775047888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZG+AxjObasS6xwUegN7FbbmRxqAFvfcWHCDJeVu0lU=;
        b=jZ6XzEj+u24nWipKUm/2SQlbxWXqjTh2UeizOo+PFhiLmdQgHcHVhztSjFBmB/lPV2
         jOIzzymrQyXdF1WygcbBfgyAJ+XPfkGd2jneqMwg8VcNXpVC+lovmpRN64Arq66UBb4Y
         oaTHPAi5SKqVEHeKB2NbuAD5U+3Vs5d+gD593B5BPDj9quJVab65zkdCw1Hp9fnmL8lv
         FfRt8qYBP8ypqyUjKdTO/ptQqXtTUyP9gbyV0x3OaWfkHjZLyV4LMIH2u0IsAMz7YNrt
         Yy3QCWUoRRg5qC18nD2DcSh1r9DvvMtFTa5N8z7CSp0Iuq4DcTfQ+uYGr7wuR4qRZwrs
         MkaA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnqx8snnyGGcDjc1+QwQ+657VPfGnMrDFq5lOFUXfV2i3acSI+xVD79CmOuA48Y2z9EnETa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgum2bkC6xQOjOS+19iO30nL1+jkhAKWAcHrSskalU4IyRqVdv
	sqocB+dUeTAx1hdKPmELCi8gaKcmIeMrmOBeM3zLFb8Em2GJP+hqhJ7+
X-Gm-Gg: ATEYQzzzEelSgYGjridtISrgNOBh1KWT2AfSQ1YXyYByQz5okEMjDR2PiurIHPAgGRt
	rSIRsSK6kqsbPmGpm8Nm0YdaMCuBrx5RDcdxl2/giZJVQqV00C8KSu8cC8aYybZlheGi/sTFMUs
	8+AfMimbJZb6WeF7qelVHi2P7vYKJpZA+ruMKNTD3Nq/LdmiNwX8xeq1r5jVvKGWca7sgsyFefs
	yTjM+ncrPa1TxlOd9CEKJvIpCPS0xNS4IF5itVen/7eRX0lcs6fau1fK4gWSEELH7Y/L94p8Z8m
	MkGTz9L29JwxbtmLUXo3xawvrDQBIIaFekL61ppTTaUPBaPPqzZ8RsFS211Kxn0Fid9zrlPSRC5
	cXYyfC61Q4+o/V3eGKKDCnRmthHLvLUXLhCY3JnFUgXEtz3QHDnk3owAaDcaSiin2Qalwh/aQIk
	hC/XtmFuHY9qc=
X-Received: by 2002:a05:600c:6287:b0:486:fc94:d8f2 with SMTP id 5b1f17b1804b1-48715fe2ad3mr45978195e9.14.1774443087426;
        Wed, 25 Mar 2026 05:51:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c0c13sm271961125e9.7.2026.03.25.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:51:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 13:51:25 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
Message-ID: <acPaTdLd70YI_uNW@krava>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324150444.68166-3-leon.hwang@linux.dev>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271538-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 4F7A6325529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
> uprobe programs are allowed to modify struct pt_regs.
> 
> Since the actual program type of uprobe is KPROBE, it can be abused to
> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
> kernel functions.
> 
> For example,
> 
> SEC("?kprobe")
> int kprobe(struct pt_regs *regs)
> {
> 	return 0;
> }
> 
> SEC("?freplace")
> int freplace_kprobe(struct pt_regs *regs)
> {
> 	regs->di = 0;
> 	return 0;
> }
> 
> freplace_kprobe prog will attach to kprobe prog.
> kprobe prog will attach to a kernel function.
> 
> Without this patch, when the kernel function runs, its first arg will
> always be set as 0 via the freplace_kprobe prog.
> 
> To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
> freplace on kprobe programs with mismatched kprobe_write_ctx values.
> 
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

hi,
so it's another issue in addition to that on with tail-calls [1]
do you plan to resend this fix as well?

thanks,
jirka


[1] https://lore.kernel.org/bpf/20260303150639.85007-4-leon.hwang@linux.dev/

> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 12330466d58b..f8257bae6081 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6404,6 +6404,14 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
>  		/* remember the offset of last byte accessed in ctx */
>  		if (env->prog->aux->max_ctx_offset < off + size)
>  			env->prog->aux->max_ctx_offset = off + size;
> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
> +			struct bpf_prog *dst_prog = env->prog->aux->dst_prog;
> +
> +			if (env->prog->aux->kprobe_write_ctx != dst_prog->aux->kprobe_write_ctx) {
> +				verbose(env, "Extension program cannot have different kprobe_write_ctx value with target prog\n");
> +				return -EINVAL;
> +			}
> +		}
>  		return 0;
>  	}
>  
> -- 
> 2.53.0
> 

