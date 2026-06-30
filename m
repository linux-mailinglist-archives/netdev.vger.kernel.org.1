Return-Path: <netdev+bounces-303005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1rsJ2xtQ2oIYQoAu9opvQ
	(envelope-from <netdev+bounces-303005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0786E106F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:17:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fgN5FXQE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303005-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303005-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BCDF30276B8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6A3D6CD3;
	Tue, 30 Jun 2026 07:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300273D331A
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:14:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803684; cv=none; b=CmCn+VcYwrdx+WR3ioL/j066Qs5ZYyhLxFGVT/9MvE1tlKsoT1UQCbH1zkHQxp8f5ESJkxnpIawhlnvg861sKATmUHZRzS4EXn21Sk6xJoN5S39DC3QiEOB/zTs+MymHksdSmkqL3yG1/141xqujOiGusJAvBWfJqOyhpVE0j0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803684; c=relaxed/simple;
	bh=XL23FZIFV8lgtowgc1D3LIn4aqMyxN0Pts3G4jOCcZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnhOdt3S2J4BUkCdfi07977B2uUL0Iw/alwfiXa8YCswgl/hdYiT4xcV4Rt9r2LHsAIj+YyTXGCfR+z7wB4C0JopknA+X7uhVxKQM/Yo2NvOKVPNw1e6zOn7JV4hsrruxHyCzbt5JK4abv46toZiGBxd0YvfaBU4POLdbfyTS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgN5FXQE; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so1794310a91.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803682; x=1783408482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bDQGREITe91mNJKLkfaBft7iY0zy1ezAMTmaONILis=;
        b=fgN5FXQEFp7ODVTlb5EKin3jjBuoNcnuY813a8+INqGJD5QCMSObTCqWfspj6cY8ma
         e+CSpiBPZz5LxN6QtnVJBNgCE3gFD2r/CTnSo3N0Ib7M7oLJVpt10Krm+HIwJb5SclPg
         4rj8Anq4Lg4dSYXs9bVx4bdr1xQ43iPyYmTNjb+32ccty2ZGU+tfIdHDVxc/8zSxh1Y8
         KyfXqQQYpgaznKXfD6L8u5YDVX44XB7uj4AI+O4+EhBWlqDzFKCRRhgH2m70ZZEVLg3t
         ATC8nct5RdNwm1Uz13EGl+tyzlsLdSgiIfPJLJ1Ngx76lH7MQrzx6y94lX6unE9i7CR+
         9APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803682; x=1783408482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bDQGREITe91mNJKLkfaBft7iY0zy1ezAMTmaONILis=;
        b=C6NqKa4TI4zE/h0fcYy6RgRBvf3Q+jk/EBUvtulgODHW9WoK3580opHuKQDkxhifGg
         xGIM86FmV3LwRFon9UbhsRJA1JNKJRTkSb4XeBwJO5UXyWj2nNMmpM6K/5Pi2XdjcZuN
         KfadPa/ziBI7uBJ/6e5woSu6sj/eJow90NJL2nRD/uDHdH205saRPHQIFuz4jbpluGW0
         skojfWWmNF5Gl6QAX3Sdodk3jgUZ/juesFE0i+9fGtTtsPAa4fUnhaZItZwVTfzV4DQl
         Gx7XRysk1JDVXEGjI/TginD1ymkwAFr96TSB7miYC/DDHj9N+/SbfSqga6fSXuARm/be
         iONQ==
X-Forwarded-Encrypted: i=1; AHgh+Roa1TO1kbKdsfFnXM+AL5G3esQGqVspNhB6zxGddXWGu9GG/VKkM3Jbcvbau78iwPFFZUSZvDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6gsOh2WLcpgOStAzLkLobynzPzTQh042E5G8lurNoZ8GwQyL
	KvTwz+jA1L927o0BmjA1by/CQBZx/6npR7oBsawKcTlGIT7jTeBsskZs
X-Gm-Gg: AfdE7cntGY+owfLt+rZQgYABaPPqQcUjoNmSKy3sG7G3my3R3zH9ywCpbuUFcC6KPID
	0RzbVXXqpcOZI72ckrfmI3XfYizkgs9chB7yH7LSc+p2lrmuAA6mIQuquJBNEvKnQgi6/TUlpIi
	JxDJwb+0tPPcqGmxtstIjueUmlVIzRZlLS7UyU9d1/CkwlIChJ3bybfjvCwZCBpKQa5F/JJ24A4
	Bk5tCq0kL/nvXYBW3hPYBKmKhPCnzXMGMeCIK+CmkYnyjqlhGHV4s99Gus8VYTFn/8LnZvjKzXG
	r9A4DvGYfF/R3yZdc5gF+heiEw86esrU9OLcKF0XhK3PF6fYDeu3Lh8ax4bty3QpUvtD7WlK9vz
	BhumoPBRMpU7VGWlxINCxO/XAUlfqle5Z4jyORxR2ql/72xkLOKdggKI9rh1zzHekxu/WAgSaUO
	2uLdp/QdRXJ0VQsQTlB+M+vXhFEj0RrsXiKgHpXNY51Y0+alrKHcFZDuSoiy0=
X-Received: by 2002:a17:90b:2e48:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-3805281b8d0mr1773163a91.28.1782803682352;
        Tue, 30 Jun 2026 00:14:42 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3805bf2c5absm285378a91.2.2026.06.30.00.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:14:41 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:14:32 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Lorenz Bauer <lmb@isovalent.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete
 from tc, xdp and flow_dissector
Message-ID: <3speqrvxsx25cbyronbm4jatlhkawkjiki7j2b7clrtkbwgpn6@x2gx7rwvpho7>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
 <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
 <akNXhg5K7aV7Opdr@john-p8>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akNXhg5K7aV7Opdr@john-p8>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303005-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:alexei.starovoitov@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:emil@etsalapatis.com,m:lmb@isovalent.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net,linux.dev,fomichev.me,etsalapatis.com,isovalent.com,cloudflare.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,x2gx7rwvpho7:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C0786E106F

On Mon, Jun 29, 2026 at 10:47:41PM -0700, John Fastabend wrote:
>I think we additionally need to also block 
>BPF_PROG_TYPE_SOCKET_FILTER? Did you check this case I guess the same 
>case is possible there?
>

Yes, same inversion. I'll block BPF_PROG_TYPE_SOCKET_FILTER in v4.

>Then another patch needs to restrict BPF_SOCK_OPS users. For that
>we need to block BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_*.
>Let me know if you want to do those as well. Let me know if you want
>to do both patches or just the prog blocking above with the possible
>addition of SOCKET_FILTER. I didn't search very hard so probably need
>to check all the BPF_SOCK_OPS_* to find the valid cases.
>

Just the prog blocking with BPF_PROG_TYPE_SOCKET_FILTER added. I'll
leave SOCK_OPS out of this series.

Bests,
Sechang

