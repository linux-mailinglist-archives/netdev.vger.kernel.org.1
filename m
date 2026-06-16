Return-Path: <netdev+bounces-299740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vj/UAIXkMGqqYQUAu9opvQ
	(envelope-from <netdev+bounces-299740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CBC68C448
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=QxDfpumc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299740-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6934830B82AD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAD3D8905;
	Tue, 16 Jun 2026 05:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F23CFF60
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:51:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589113; cv=none; b=JvdCSb36jlypJpIiZaBT2/j8v/kDYIHW3+BmO5WJVTGx0h/iLAk8+sIUSjXvfVUhf8aFTPNzPNRbKpMOqxxkQSVDoF8qX/F4ner/+HkF1a5iwnQlu/MLQovRLTytGiFZU5v/BlRQ5REsOXTI6zMmAdJwek6meQbMKh74XYEmZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589113; c=relaxed/simple;
	bh=7BG2QmmZRLh5N3+eiC64oaFFvrrLDzoLyfL/lriehHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0IV11KFO+3nHTMbjvIfYfnC//VJbqLfU+Q4lr/o0c40szUbDDMsSqRCY/SUvIvQrMTjwPgJgTavsMFLsgKwiFibkYfCEfJZW2/T+MgYBNKFHoAjfgCRujEH7vZY9VWj9HMwkiHaMvFroNanfy269CQHfd3fMuZrlGpNgZtICsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QxDfpumc; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso38902625e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781589109; x=1782193909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=QxDfpumcliIkLkFyq2V538vW9GarjHCMoWbjN4HO8T6s/IiDNpncAa0mI5H4wdn/e0
         2wJQDN0duell/pBFWpiRxlH/rx95giBgzcgD2VZ7/Xx6pXrTa5qEJIhfuN/TWR4EbWU8
         pD1dM+RTYz9kjj8R6jAHI9PCvEmMvrnZy9qnsy6SNI8eMC83e4bZhq6PcZtpS4hRHmMW
         fuRAnjH3iBxl/p7geKLZs9qwBBPfgIWIxvSSuosapzeO18oKP41Gc9WUig5HXSYSz+En
         xdZ0j7pZdcayL5dGVLvPUfSL0b9imeKgdXiNL+RsMhqo6X1lko2slE4zbQt7HZ1564xR
         rBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589109; x=1782193909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=UVcr9j3wCG6KNvOOUMPlnf0CYv6ek6xICi8WnJY8nLrpufmD1h2Flt+gsz9AdwsddB
         /c2D8RV4+aFtj95HzlTepjqCxc4MHhSRbtFcSLPHl7yMWAjxN/LbYj809SUkKq9a3tlj
         uQTyN7wHEor5YbkD70XShJCxzs9x6NDQ86HPPutL/Mz1gguW+gkO4mlhLykkJ6JTEDqb
         ODehUbIzVPz6hvwtEeTWhr/uKmxNB7ZeSb997DVzhgPVhkiZDtPTLW+gRz5InIPQActX
         uVUTycjeo58QliVMBAVraxzyAmUShnb9zAl0PAnRlIOq4nbglIPDhKVXTx21/vUX7bdo
         Qrlg==
X-Forwarded-Encrypted: i=1; AFNElJ8cLqPSXaGQG5r0TIb6AZfKu0WlVovErSm3k+8U0/CKmVzGYiB6QxjRoPbVwHqVDQWT3oUytUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUbGgn7MYIlB3GbdT8E0sKiwTlsWPZ9a4pziR5DbsU/2i1dsw
	AlPMOPHjDNwhC2DgNuuLsnlQPUVg9ZJt2mjZxIupiFnI4eWJSVnf+dsd+8qWeHMZJiY=
X-Gm-Gg: Acq92OGXdz1uW5QPb7/DgJYMSsU5gCh7jWH546jm9hc2QJEFxKYvgg/qheLnK0Cak+k
	kUZOe3vkt0ybB7TPuIbJnwy10vmOp5l2A8VF1+108azhU4+v7MznPakH5gSNoXlo+wlGL2t3F2K
	KUuCL+FSW2Q4YehirCwZ0vL1JkTz+aZynb1tVt9Xv+4VujvG7IGK/U99ic/L5oF288LgiwE/Xo9
	L2l2f+h4dtESSGGPGc3lys/DM2kMj8FOYsHOgKoh499TDRWvlBAI0MVUCjax04qWE3CzwhsyJAW
	OugcxKHQLGuO+v3Nznic7iUXkjOrmWEXVBsj0RbS16y5y0rUndE+5qRlsWrLauT0FcEGz43F1PG
	/vS46QMEePWf7c7udyS1wgc5Hj89eRhPHL9W9yExePzpYFVF4E0dq0S0wuaSnyz8TlCYSlNWNsQ
	wBneJgPm6Lj92sj1jku4WvgR+AfO4lfG+C0SrRMjxLzRSJ6w==
X-Received: by 2002:a05:600c:1f8c:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-492200768abmr192521925e9.15.1781589109336;
        Mon, 15 Jun 2026 22:51:49 -0700 (PDT)
Received: from u94a (39-12-139-247.adsl.fetnet.net. [39.12.139.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm12009774eec.31.2026.06.15.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:51:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:51:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org, 
	Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
Message-ID: <ajDiLjjSYPp5p7KF@u94a>
References: <cover.1781194510.git.jt26wzz@gmail.com>
 <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:sunhao.th@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,m:sunhaoth@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,u94a:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55CBC68C448

On Mon, Jun 15, 2026 at 12:58:38AM +0800, Zhenzhong Wu wrote:
[...]
> +/* For all R being scalar registers or spilled scalar registers
> + * in verifier state, save R in linked_regs if R->id == id.
> + * If there are too many Rs sharing same id, reset id for leftover Rs.
> + */
> +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
> +				struct linked_regs *linked_regs)
> +{
> +	struct bpf_func_state *func;
>  	struct bpf_reg_state *reg;
> +	int i, j;
>  
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
> +	for (i = vstate->curframe; i >= 0; i--) {
> +		func = vstate->frame[i];
> +		for (j = 0; j < BPF_REG_FP; j++) {
> +			reg = &func->regs[j];
> +			__collect_linked_regs(linked_regs, reg, id, i, j, true);
> +		}
> +		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
> +			if (!is_spilled_reg(&func->stack[j]))
> +				continue;
> +			reg = &func->stack[j].spilled_ptr;
> +			__collect_linked_regs(linked_regs, reg, id, i, j, false);
> +		}
> +	}
> +
> +	if (linked_regs->cnt == 1)
> +		linked_regs->cnt = 0;

This part seems new, not found on the original commit, and also not in
bpf-next. Can you add some more explaining (in the notes before your
signed-off-by) regarding why this is needed?

> +}
[...]
> @@ -14704,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return 0;
>  	}
>  
> +	/* Push scalar registers sharing same ID to jump history,
> +	 * do this before creating 'other_branch', so that both
> +	 * 'this_branch' and 'other_branch' share this history
> +	 * if parent state is created.
> +	 */
> +	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
> +		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
> +	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
> +		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
> +	if (linked_regs.cnt > 0) {

Same here, the original commit and bpf-next has the '> 1' conditional,
where as your has '> 0'. Can you also added some explanation on this
part?

> +		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
> +		if (err)
> +			return err;
> +	}
> +
...

