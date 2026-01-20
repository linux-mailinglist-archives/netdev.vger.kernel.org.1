Return-Path: <netdev+bounces-251567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COLiAI3Mb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2849ABE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F093380951D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9E350D74;
	Tue, 20 Jan 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHIADCTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42A326D46
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929246; cv=none; b=g1GaEQxBLYjFA3CemvCu8xkoq2bLXPfkyoKJIsrQiFiXtvVfFF3qiUaSQt+B3N4yZpfaSe/9CxQIVzldqM9kj47TXZNgIyKw/ZLJbhox1f0uKnWxE+hN28HTWkXJT1vYy7MQqJZG0cxaM2eAO4JWRG0eWwkEOfD0pzh55/9a4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929246; c=relaxed/simple;
	bh=Ckdv+LBfVcrA4JvvMxCIADVWbw04Tilid9Ikn1lV+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy9HKF8ZJCqJ8qm69/3ShZLU2N6jAErgVF4Yk1yb0jU17qb8239tljraayg95zJqa8x1xawn2kWf6uiPNHlnIvPYyJDuzi6+wAgUeBMAFG7ft5kxd+0uwF1jfD7lbRBlKSBijkm4mVJoByC1ofjdeToWx6XQOXXmWUUUeeQAftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHIADCTp; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12336c0a8b6so11816916c88.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768929244; x=1769534044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=LHIADCTpliQ9GjRtHbrk1xhrCs84ftlZsBP+4XYxc7221cWYqU5ZuaV8OtiQcAOZl7
         Qx5lKuCyjBNUgy+MEstWqBBdJCHu2bXNOxheMlS68l/JdWu2EkpTZCpDHfXmC26b/lyA
         VSFfyGMq/evhusy/Qoh3/OIDKwS/ytrUTjpS0yhiKZLFq19SDL1TQgClJyh2270QGUaS
         22X1bls2yLhstBSW8LMA1iCIQYM4eH2PKXf/T5+EHRY+Drn+c7ImaJlJA9Qqgx/4StKa
         4c7FRVHsLnxpxTpSJKoW2vlGs271QLTWtFCxa12kceIZwkr116tl59yXytN6rXQzTEpO
         jD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929244; x=1769534044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md0g+j6qZSK2w0IJlJPci/fZMbMlDX58xj6TKgMT//Y=;
        b=IdVM9CcMNRxJ1xyh4VwlMgecBgo4UZSHkktKkMSltQ5m/CrHVOJmUkDOpHLxdFau67
         wLb3qeDuAkc2yi56Zz9Q4DY42B1Lcm47Diha86/9EvwXTJiaV6dAYKqeoh3NnmstoDag
         1kQAXy7LWP5S8RIXvuNA0pSscesavYM+xKoHaEwpebuKG3WYn4PXZQN/m/v0/x//Swkn
         kHiQUZ4F4hE1Ly6OIMdgUxFOHrbP7+Rg2S7RJzE2h+aFCywPfIkrmgkdpvB7Lnk/MQOV
         ZSWVi7R7QXX+MTgb2z+5bRAdxD8HNtSW07Uctu7oIdiMsAHwP5WrKGfu5FQ3VvyOKCdV
         kIXg==
X-Forwarded-Encrypted: i=1; AJvYcCU8LJbgyGq8kK2s4JNcXdVz3uTIEV5vLGIwuHPxES7yeRBNrwU1tDYDihXlTlSxwaZlsdJY68s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9arJ7LOLhvgilxZlCLUMoiwUxoTlUCmAJXPu6dxUAO9EYncE
	redTHbGXKJi8Hyu0GKAVgLs/zIVd4YuunM9MtxVpWGOMxY+bpLREPz0ds4B+HQ==
X-Gm-Gg: AY/fxX6KXzkBi6qRXrlZap00gPCvtQcR0GTs79j3fZYTOOXyTN3irnECOOwF/JHoGug
	Tf7WnT8eCm9WFpnNxv299Xz1I4cFAe3uEQQUok47mmxMFUrym3QXIUvn5A3eYHcGpTLuq0N4f1X
	zIdPln8puZLjX3CIpAuEp9DuT3q0sD8JVfLpzLsNhHgVCps00rA0w27+IDVvQillEApU43SF9MT
	aJCzFtouWp0rAdF0SjOL9JYY7RkP3b8RXfOf0ljomM4/PNcDup0KrftNeQeSApjva4G5Bp54dem
	VaEPHy0rakOkICKkd0t9uZpcCjvWReqETtrPKaqfA6vFZOpOKs/JEhottXK6+oXhD6+UFOzOT6V
	+YAVMkKt3ZKsv5eNI6Z07uP2xDQAgNkpnzB4JTYhk8O7i/QCDFyxnxLg7LNl+eXMhxPt/4Ubyj3
	CqOZ8PSZ950DA=
X-Received: by 2002:a17:902:d4cb:b0:2a7:9196:a94e with SMTP id d9443c01a7336-2a79196aa80mr1234755ad.15.1768923524001;
        Tue, 20 Jan 2026 07:38:44 -0800 (PST)
Received: from gmail.com ([98.97.43.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce693sm112017965ad.36.2026.01.20.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:38:43 -0800 (PST)
Date: Tue, 20 Jan 2026 07:38:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
Message-ID: <20260120153807.gzwnhxxtcocycfmr@gmail.com>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
 <20260113025121.197535-2-jiayuan.chen@linux.dev>
 <875x8wuy4e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x8wuy4e.fsf@cloudflare.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251567-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,rbox.co,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,cloudflare.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 97F2849ABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 16:01:21, Jakub Sitnicki wrote:
> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> > A socket using sockmap has its own independent receive queue: ingress_msg.
> > This queue may contain data from its own protocol stack or from other
> > sockets.
> >
> > The issue is that when reading from ingress_msg, we update tp->copied_seq
> > by default. However, if the data is not from its own protocol stack,
> > tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> > native socket, reading from this socket may fail because copied_seq might
> > be significantly larger than rcv_nxt.
> >
> > This fix also addresses the syzkaller-reported bug referenced in the
> > Closes tag.
> >
> > This patch marks the skmsg objects in ingress_msg. When reading, we update
> > copied_seq only if the data is from its own protocol stack.
> >
> >                                                      FD1:read()
> >                                                      --  FD1->copied_seq++
> >                                                          |  [read data]
> >                                                          |
> >                                 [enqueue data]           v
> >                   [sockmap]     -> ingress to self ->  ingress_msg queue
> > FD1 native stack  ------>                                 ^
> > -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
> >                                        |                  |
> >                                        |             ingress to FD1
> >                                        v                  ^
> >                                       ...                 |  [sockmap]
> >                                                      FD2 native stack
> >
> > Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> > Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

[...]

> > @@ -487,6 +494,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> >  out:
> >  	return copied;
> >  }
> > +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);
> 
> Nit: Sorry, I haven't caught that before. tcp_bpf is a built-in. We
> don't need to export this internal helper to modules.

We could probably push this without the 2/3 patch? If we are debating
that patch still would be good to get this merged.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

