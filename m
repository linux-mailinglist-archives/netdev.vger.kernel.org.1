Return-Path: <netdev+bounces-281122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDAmCmsC7WnmeAAAu9opvQ
	(envelope-from <netdev+bounces-281122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 20:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C303467337
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE3D3011F17
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1C363C4A;
	Sat, 25 Apr 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eodqC1a5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07869358376
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140003; cv=none; b=NjTOSYdEoLqcAlas1+et/d94bRwaHBJxP99NyTkl9/vWT1wW9cZhvbx0cs/LsnMQRr0QWfktfkfC62l2tzR961kmUgvI/72d9wM4Onr4bt7qLRO04F8R8/qVmbd5oc0iRWOzcMdueZL6WOFOcnT3szZp6tDGE2cEEyNmgyk7gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140003; c=relaxed/simple;
	bh=CK9YYDsSVZGCgJah9TQvpjQXc/1mFwRV9PzA3lTyxVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXaVUJ7X+q3sK9NBbYC4ERb4CI9txEW2tq2NUgoveqkifqLwiD+z92egrveYAHi0FWnmkfjLLo93UfYlEkkQDyB8PwYBMN+HCEFAuFT3yHCNlgzK+g0XGXK9JxbiNrX0Tvxboovd+vcw8jLINkfGyyXDwFoFUMD5wkjMLcPLHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eodqC1a5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so4656715a91.1
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777140001; x=1777744801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFcDbOFyHJ3yOFFB2U6uoZi3zDlX/raHpEMdVEL47T0=;
        b=eodqC1a5xSY4OQOtI1+tC7j6Hak8NtyEN5Q1FmzULRhs94K4UIRBhDAmqM4RfrX2oR
         sE+hdQZgSpbeEK4VqNYJvXJNKDwMlk/KGwbjpIVBGEqGO3sqvNndJ1h/iGDss72ESTjr
         7FWe3Xk0WjQyjWZN2S4l6yAEH17x2iQLaA2IGCJXdIe5oPSc7muDq6gAt7G61Jla3xkQ
         pW7/0RQ/1+ypsIUYi2irOx4TRLQrK07pATGK/3V492UMWiDCEQOBS85xuPyFG9IhDGVr
         21z/fa3uC3shqk0HRCPsjtwmaSSqe3SmbsG7ZPP5PMChw950Ccpn7ecvANVFV+tmYFO9
         dnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777140001; x=1777744801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFcDbOFyHJ3yOFFB2U6uoZi3zDlX/raHpEMdVEL47T0=;
        b=qsvxmvz5iEanXQ56Qg2uDDDlORZJ5rN4YEexSOI1oYnittmaJFTNyp4jAONHjjq7Wg
         wQrgrbCcAJZYJnPO8ZQWutNa1j+luxbrk/3+Hd2CPW4DbxXAiXXvQqFiRFb2+OZGscd/
         x1P886ZFQBwj++iDvkRpJfoUXn/Na7YMRZMe5REALVJrVjpVlh55CuxYQ5fqnkPP+EIZ
         cHb36OUFDPE/T1xq6IuNip/k9nqnkJxmYHe71A5mn+N6nyg2YR45J1+juro8d4nN+AP9
         tsqN+XEytegX3tns0dPk0AZmf2N4+nEUV1QTFHlIJYBIqz0JRWTivRXiS9ZW7uqunmf7
         2s6A==
X-Forwarded-Encrypted: i=1; AFNElJ9okGb3fGCQqYUXg9LES1roGB3gDvQPxJ8gD3xKr2xSUImUfBlv0968ctenWT0oCmAd7DRobTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjQR4GwyeNpxAr96cUInx1UKYt7YhrCMy4Z1vfZmc2Z9QqEkE
	uZU8uWPftKPF4ydOZRGmO5R5Uxa1MFWRpJ9LDyRWjap/lkV5b7N73zql
X-Gm-Gg: AeBDievVwPF6qfpHHnzy1jw12uICsMAY898CWRPh3Y9aFhlrRdc9bYeCLzQOcQ7TZZo
	K4pYUVAGxmzjKaf00JHx8K43lGHW9CTXJFTFAmjv1uzYunm9nJqVwmskZUZ7cl8P1DH9mj2zP92
	dxBgnNQzAV1OgyjEgYm/IFO5OTGKusmHmBTFBjAsH+xyYPI3agJG2PmdAPRiWx1SiF1UfoUpJPT
	FDyIUzJqnRFGse0lk2NriStyTvg45wYjPI/oCM2jEesDjFNUqKW2zmITGRXm8YyX/KLFfV7cI9O
	EMOkpDolnPBdtCqfP+Ia8sInQFPxmWWvoJcD9oTk6kx3CYqTZfcgGIUW5Hmz40qWothH74OB/ni
	cGzBnNcuzvKgz9wl0lG8rXWLwbLRrKkMUYXl81P/TQXSp63oQSMMecGP+kRtxA63WPdZdmGBBco
	4+9t9I5+c/IjxIPZxam9urrghhIHdRAfQZyX5kOk1mu6xy8Gk3lqKuX0MhFunG6RovLwglQOoH
X-Received: by 2002:a17:90b:384a:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-361401beeaamr33976893a91.2.1777140001191;
        Sat, 25 Apr 2026 11:00:01 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm258765765ad.68.2026.04.25.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:00:00 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:59:51 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	Xinyu Ma <mmmxny@gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
Message-ID: <aey55I9gC0VtaN1p@Air.local>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
 <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>
X-Rspamd-Queue-Id: 7C303467337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281122-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Air.local:mid]

On 26-04-25 11:17, Jiayuan Chen wrote:
> 
> On 4/25/26 3:03 AM, Weiming Shi wrote:
> > bpf_msg_push_data() allocates pages via alloc_pages() without
> > __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> > heap content is added directly to the sk_msg scatterlist, which is
> > then transmitted over TCP to userspace via tcp_bpf_push(). In the
> > copy path, a gap of len bytes between the front and back memcpy
> > regions is similarly left uninitialized.
> > 
> > This leads to a kernel heap information leak: stale page content
> > including kernel pointers from the direct-map and vmemmap regions
> > is transmitted to userspace, which can be used to defeat KASLR.
> > 
> > Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> > page is always zeroed before it enters the scatterlist.
> 
> 
> 
> As the helper's own documentation says:
> 
>     If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
>     want to insert metadata or options into the msg. This can later be
>     read and used by any of the lower layer BPF hooks.
> 
> The inserted region is meant to be written by the BPF program — that's the
> entire point of calling push.
> 
> If the program doesn't fill it,  the push has no purpose to begin with.
> 
> 
> Isn't the uninitialized content a bug in the BPF program rather than
> something the kernel helper should paper over?
> 

Hi, Thanks for the review.

In my testing a process with only CAP_BPF + CAP_NET_ADMIN can receive
kernel heap and vmalloc pointers through recv() from the uninitialized
pushed region. The uninitialized memory contains critical kernel metadata
such as direct-map and vmalloc pointers, which breaks KASLR.

Kernels without CONFIG_INIT_ON_ALLOC_DEFAULT_ON (e.g. RHEL) are
directly affected the leak is not masked by any mitigation.

Thanks,
Weiming Shi

> 
> > Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> > Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> > Tested-by: Xiang Mei <xmei5@asu.edu>
> > Tested-by: Xinyu Ma <mmmxny@gmail.com>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   net/core/filter.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..ea02239892fd 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> >   	if (!space || (space == 1 && start != offset))
> >   		copy = msg->sg.data[i].length;
> > -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> > +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
> >   			   get_order(copy + len));
> >   	if (unlikely(!page))
> >   		return -ENOMEM;

