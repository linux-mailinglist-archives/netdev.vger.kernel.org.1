Return-Path: <netdev+bounces-304124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EIQbK79JRmpLNwsAu9opvQ
	(envelope-from <netdev+bounces-304124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760F6F69AA
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=DsoWddnP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6A7B32A82B6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD03CF020;
	Thu,  2 Jul 2026 10:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056C3EDE4D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:52:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989561; cv=none; b=k1XaL5F/vKiNMWKhXs5Tz25a2h2cxZTwrcWCFCJJK3a8F9535/ftnVn5undJqbp95vJt5rBhxABqa9Yp8zfE3ZlAV4lJjnI4Yimcx1KDcdIFwPHuLSmJOdHTk8c7YaGQ6tSkjVqOq1JedMsS6O+8MmT9HzfunPeSuVU5VbbLbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989561; c=relaxed/simple;
	bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ePp//F5aa8aEh4nv3IblPz4AY/WAYwMnZsccp7kYBSnync3bUQ9Ktygoa3BP8Li9k9ZvKOG7p7GfQJatJQoBVrpDbtD6udv/0WG7qei6mJS2MfifCfbKiLEadjLa7QPtuFCmk9GCfUQvImks64xgMnYQgGXK20fBDTdWzsQt4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DsoWddnP; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c126553552dso230334066b.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782989558; x=1783594358; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
        b=DsoWddnPLORJX50bGQIzSvkSCZs4ChUh7edzQZAYeXJf/uV5TQJAoepEYm0CegibaC
         tKmmdUvYq9o++MnE2mW8dekLZytuN30Pijfczi63OasWLgrgV6yXrH0Ne4wAFgvn5gJe
         GnPNireYmU0O65qDZJGso0gmGVHcwJ5bg1tRIKkSDUf9J3Y2/GaaRqKJp53TovX286h2
         jI0yICsxqVcNUh8N6cTn7BzGi9Xd4b508G4iiVSlcO4YIqaaHPd8G/mIi15F5SuadqDt
         pYlpVlzy3Yf7GaWW1+mgY43lxhbhAgQ52nkxao1hxigN4OKy0f3oss9AXcggJlc/4/ac
         1lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989558; x=1783594358;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
        b=iQMrpFaCq7yfQYjMxfHBcjkcJ+cUbfh/tPC7+R4r8GHW5SvOaUf2NQk0YOD/nvc562
         1XjX3LJ2b6MJD1VjndXFEhjYAKfKd0OkGrEnAp7oKxUpGN5I3NQYuKBvjCS3/VXtXdQl
         gOZdoWsrCInyLVY/SQY3fk5ARXdsSMwKbGqmhZz7FAfb1OHlDyrAtg9UCDeI3ysUCdHD
         Ij2BOnUnqiysgRHDL1XW27ylq5e1oktNIV8uQTHhVPLZ07Mxq9uK7l4TEaifjHsUPZYe
         KaaMlkBy+H/wuKG/d6sakHveuJxVgpEzaTJxCA+xDim6Uamr9E//2rQ0ISMU+Vtl5yWR
         CEqA==
X-Forwarded-Encrypted: i=1; AHgh+Rov9HLb5VR9BEx//WcoaqB/UVyzFMsgwJ+8bzn8lcUi7gPspMn+Ln2aWCncwg8jzQiDp4zjT48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPW1+r+d69mvCq9H5gVKQpwUdCGTTY9EG01d8TviPoPjbnpJ+I
	o7k9jXsD2iyWo/9P5JndCha04YUB+Wt3lrV++yczjLiR4rrqXqyAbyhdggE0U/Lj33E=
X-Gm-Gg: AfdE7cl17bhMH2mOBM2xwZPvJNc6IldoQaNZKLFyNjgbXWuyI4OxVYA9vzpREx3GDo+
	GiUn83R1vd5+KIzaxgBbXOGCW757NtmVDhrjfRvIfWpuHLLrusPflXkiDoFhNlUAyzZ8MXPjALS
	IrEn/4nKKptA/7H97WpR8jxVlI0hto1BKhnOkXDBWrkdXxkGxLsvJXwx1OE6a/gbeZIXvWuoXbM
	UpWfLz4YqYqysATCU87F4m+OR+xmxv+7tdri/7IawyxRI2Cpn01nVTTpEr5a8YitS+NmuBUocjT
	1uYIJnIdEPmThTFBNloJbRS92J83C4GAxp27KDLzkLdYxf3dWF8lc+9lCo3O9RRroXK/day4Swa
	V7m8qNsL8VnpklhefImFmuEkdeQPbNE3m4pyqk395C4WQPr6EfEov91RcjLj7UzucSGqlPrXSTe
	6LrU1bxnvzw9dhdsw=
X-Received: by 2002:a17:906:ba84:b0:c12:a417:30ad with SMTP id a640c23a62f3a-c12a9d386d1mr240239066b.7.1782989558379;
        Thu, 02 Jul 2026 03:52:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f5c52sm110937966b.58.2026.07.02.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:52:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error
 handling
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:21 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 12:52:37 +0200
Message-ID: <8733y13bpm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rbox.co:email,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5760F6F69AA

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> Update sockmap_listen to accommodate the recent change in sockmap that
> rejects unbound UDP sockets.
>
> TCP: Reject unbound and bound (unless established or listening).
> UDP: Accept only bound sockets.
>
> While at it, migrate to ASSERT_* and enforce reverse xmas tree.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

