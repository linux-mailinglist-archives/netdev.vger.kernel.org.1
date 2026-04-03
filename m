Return-Path: <netdev+bounces-274900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGSCA4tiz2lZvwYAu9opvQ
	(envelope-from <netdev+bounces-274900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B63917B0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 042B0301CFEA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F46A001;
	Fri,  3 Apr 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOU2EIey"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EA2FF657
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198854; cv=none; b=kenZAjceztrvHbZU2/XaHRK6uFUDF9G/ZScKIHI74mQJyvGFTjoDETbA+M2YyikyTRJg/NMwhwV3NwcSOIAZ5u2i6BhwEo8H2uFtjSXCVffiMIYHpZSK5ewMe3lDAVHhUCf2dwsO34jWN/WrWZRRoIJ0zXb1l94NM0W1CI4S94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198854; c=relaxed/simple;
	bh=/Nlv6pv9dyh2rkzGIInhoEc+cQ18b9nVotbkcIs7kDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5Y9p6pmxRzfq3Zx8DFzk0i3/W4IjND3VbUDu84IfDQr7Ln2JEpCKGFYPaM6k5ZQYzE3Cwh5Ke9M6P+ZMd5G+bs+jxxhhABGzpXnx3TepKfc74/coNM1lDbCC4JKUrXZ1JjvDB2pe2tf950Umkms/sJyrCplzC2S93uWHSeFeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOU2EIey; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358dff8447cso218513a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 23:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775198853; x=1775803653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQfPR85esVVTomimAESJxYAPjhrPwWLUtGGzTJec/vU=;
        b=JOU2EIeyaEPiAk5JlfYDmie7GQ/129OitsH2ODnf5Z4YYklsqpTlLKyKFFjAP2faak
         TSZlF5Bu5nfSpcz3rl9cbM/FrmCdvBVdQYGLfbf7T/OQcXUWHJt7U5gn7+BPHF16nkSu
         gKwTx5timb0gPtFXPZAPdhYOOJxoEsDEfFWQ1xQDaWF9dSMdaTiiF7qDff67ShvY6ZMO
         qBk1q2alV4B9FcVLaXtlF9357u40YV7hf89UKzJgKUsr4BoRv33uC/zIO3CRLqwgbNB3
         BmrG+i6LjV8DKa3VtNEZm7nsdFSTSJzFslItE6g2ylTyfjv372wCrpIiLuGY2r5Wf5o4
         5gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775198853; x=1775803653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQfPR85esVVTomimAESJxYAPjhrPwWLUtGGzTJec/vU=;
        b=OWcbowet5JMfGuR0mZRe9VQ6GQGzSEUb+YQvc3O2+DaKLaGiyucBvrbjkiKmwN8Fkh
         4nPh8lzmHL0n+W1xweooXtegbZ3KvkfbVw/Y4Tqgy51ksMrLVnjVttcZWh6FBFi2Ic7m
         C4RDQs7GwJp9XYQ3P6yHsUIc+ODoj0MxJXF7p+yU6k5cWFGH38GiDLV9GF7mDf4vUHj5
         turjp2uOEisqZjYoAjmyAzAFhFQek4R6mJiXeRXxRUDGOrD19+UvP9nzvi0fPwubb4ZC
         PiivmPfHHt7jhn5UivFPiMipFf7hqGW/igGo/zoR8RzHoO5UI7PJZNm+3TWGcn07YlYJ
         jOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlbJaKnABuZDBwIkSQR+heIUeKs9PL1qoKP+kQzdvxVJKN59175TiwDPVhLaY7x/FY4IPIAuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQp2p9tCA0OzJ4on1fiPz/tx5daVbbQUJLvbYP9GHDKBhjyeC
	CpDU1aKPex6yh63okTW6Agd9AVeqO3lxNlNBXt1l063CdvOpyT3BN5bc
X-Gm-Gg: AeBDietUXyhsPgLDZFoYISPlzDSVMKkAh0cbP74ZssTGbpfJBZEsdjXS6RzqcXhVvve
	34ItSfI3IYnFJnKasnloRbtTEG2d019Th7e8SWGbJCvSOVtCFKUse1iezl+2iNJdXiD5PYg0so0
	Oj677yp5AmrJtTGxM5NEGo2TTJ/EZG8QmJW5zOdViQ//G0xUKZ8e2BN/QVZhQbDohg2+Qsj5DRw
	ryobFAqouxWow4orGYuZLhIOQ8554enEmq6zBoJJ0cemmz01HxK/aKKbZbOuTRPloBVdMcmYKBd
	RKkJ6b8F8yP1YcPwovsbwU+p/FnF+PSBbM/5U9fZwOYyk1bVvYduPXq9s9iISqWVkPdSyz0e4Uj
	mGKkR54fonInY0BCR4KD4j/4p5SBAVHY+v3m80wwBf/LwpXi2Iq36/kz45RoKnsZ85sPhGDu8+O
	bfLe7N00spbmoPlNWKLOPSyB2n9HigvJi3
X-Received: by 2002:a17:90b:1dc1:b0:35d:b736:e4d4 with SMTP id 98e67ed59e1d1-35de6954621mr1096597a91.4.1775198852754;
        Thu, 02 Apr 2026 23:47:32 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm4813993a91.6.2026.04.02.23.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:47:32 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnault@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] net/mpls: fix missing NULL check in mpls_valid_fib_dump_req
Date: Fri,  3 Apr 2026 14:47:04 +0800
Message-Id: <20260403064704.2323691-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c5c71526-047b-480d-bf4f-6ebc47357f49@redhat.com>
References: <c5c71526-047b-480d-bf4f-6ebc47357f49@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274900-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,debian.org,vger.kernel.org,gmail.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6B1B63917B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 11:25 AM, Paolo Abeni wrote:
> On 3/23/26 8:15 AM, sunichi wrote:
> > The attribute tb[RTA_OIF] is dereferenced without verifying if it is NULL.
> > If this attribute is missing in the user netlink message, it will cause a
> > NULL pointer dereference and kernel panic.
> > 
> > Add the necessary check before using the pointer to prevent the crash.
> > 
> > Signed-off-by: sunichi <sunyiqixm@gmail.com>
> > ---
> >  net/mpls/af_mpls.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index d5417688f69e..28bbea30aae3 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -2174,6 +2174,8 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
> >  		int ifindex;
> >  
> >  		if (i == RTA_OIF) {
> > +			if (!tb[i])
> > +				return -EINVAL;
> >  			ifindex = nla_get_u32(tb[i]);
> >  			filter->dev = dev_get_by_index_rcu(net, ifindex);
> >  			if (!filter->dev)
> 
> If you reorder the check I think it will lead to better code:
> 
> ---
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index b32311f5cbf7..41510dce5329 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2170,13 +2170,16 @@ static int mpls_valid_fib_dump_req(struct net
> *net, const struct nlmsghdr *nlh,
>         for (i = 0; i <= RTA_MAX; ++i) {
>                 int ifindex;
> 
> +               if (!tb[i])
> +                       continue;
> +
>                 if (i == RTA_OIF) {
>                         ifindex = nla_get_u32(tb[i]);
>                         filter->dev = dev_get_by_index_rcu(net, ifindex);
>                         if (!filter->dev)
>                                 return -ENODEV;
>                         filter->filter_set = 1;
> -               } else if (tb[i]) {
> +               } else {
>                         NL_SET_ERR_MSG_MOD(extack, "Unsupported
> attribute in dump request");
>                         return -EINVAL;
>                 }

Thanks for the suggestion! The reordered version looks better to me.

And sorry, forgot to add:
Fixes: 196cfebf8972 ("net/mpls: Handle kernel side filtering of route dumps")


