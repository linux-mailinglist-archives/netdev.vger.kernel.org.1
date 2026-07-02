Return-Path: <netdev+bounces-304099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fMhVMzxCRmr+MwsAu9opvQ
	(envelope-from <netdev+bounces-304099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DD6F62E6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=NOKtO6Ls;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304099-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F275D31ADE85
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F54373BE4;
	Thu,  2 Jul 2026 10:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C84357CE1
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:36:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988566; cv=none; b=D5pY3hMe5EuINEO7CoL3/f1L+anAIW52tfhrB3xKytWf/UDYyww9Z1SYT1x3MTb6UpzkD1+fKzubyUxsLJnLgynFaSahvgyHy+ydHcijLQtCrUnilppxnOzK8A0t0hgOTb1dgeZAQjY7mv93mMoSc+RCICGqmqwZEM9700GQcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988566; c=relaxed/simple;
	bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuhmWuMXapUKoXsC57Z9J60BHTE/WBJMxjVb0OQFiLq8exOzSMSMgUHT+kJIOf3lYQt0cQ22YEcL6/B1WJvCVF0XkuWOcCP6NPwp8WKmwmqs8rU3im4v6LEmvsMhHmChG+5Co6v0WXeLTgQ81Fdm6lp3H+2pX1AyuVJNgy1ig7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NOKtO6Ls; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c12758e75afso261339266b.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782988559; x=1783593359; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
        b=NOKtO6LsvoIK3dwQteCncaPJ+g6OcppeqhO2+Xa7XrRrDnbeZvy5DdHH2UutfGIVCr
         S/qkYU3bKmUr2e32gAzY1EhNJD8B1nrnHdcCz6BEJ1cC3R4fjw7FpukTx86ePzDS0BaC
         buJ0EfBWH4I4bGQKG07nN8TzsvEgrmylGq9sqUt0AfEgTX8OAMM0b/F7QMtZeCvjPWb8
         RDXgFFbgwrYUPQnNlgkipCiSMg/+5h3Y1DBUcKl3wG5ILjHi7di+v5NwxvmiCUWE8OCE
         Kr5Nt6+UAcMs3o0pbMx7lWiXQAiJgcyuiWJl64+r/UifjbmQCzoUtnuK+4n4jV6bSlRg
         71Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988559; x=1783593359;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
        b=O1FYhsX9DLSBQzyTW7ZWCjQLxgIyAIjAoM91TdEm2VhQyHanxx9+4Sn4y10ephY09u
         u0nj0hEHFLHm8jHq+/iycqr/YEs7EzcMZ4ku7MduriAN1Ylzz8zY1gc0zMKf9Yq//epU
         Brb5ZR8aQIoTPpf+RxCJ5zFPl73FKuK9Sgh0JwyJO0GgiAIenFy0d+UuX+ND37su5mI7
         IUrTkPlcg11Fd5hvkYoff++24rHGEZdjLDR4FnFUJavboq4mrfmEiyFpVr7X/CVKwjjV
         zE9dLh1emgN+OE/zHnrbYeLo2R7OWJX0DMIQbWz2KXPNh9yJqPY0BChMGfd8VM8Y54Xi
         z/VA==
X-Forwarded-Encrypted: i=1; AHgh+RqO062Hky8DRMKLMRDfpuUiVU4erfMItLxjsZiajE6rV/cG16asB+rncB+GigPOyOt3dw1rS3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpoGkqJ9XIy9fd7b7jNuaKmw0JFQOQlcgsE9F7RI2akjMbLGe
	Ib04AzZwQAvRFjegMSxwF/a/lQOpi42YbObSwLRp98XBpcxzSqG40nMT9blB6ueZUbI=
X-Gm-Gg: AfdE7cllaoYzG0OxYJV6+8GcVRbRL/yNgN8CAbkMT1JcPEwUhuOI0riQay5SkEUdHWG
	JHaK87U6ozrjOOTNJPgmEU7wxkNSxz66Gr9EGu6sSPNOTkT3mEcHBBBfTYITXVgBMKHyW/0vaqc
	QVi5OGDwAKzGEvcT/C1DWBO61/iW13jj5EP1UKbulsorijClBaTR3DDtPIHAFTSX2ZzteOhK+Kz
	KFawcsPXZtonHqo78ekLGc7lXPjsqO0yHhB2Ikvx4RU5ePZjbf38ArAjjyMsRh2B06Sz68guTIv
	Oay6MItctHayH+owcZXNnME7c74X+gA1ToOyM0l8T1cByx6JfQtiaGzQiby2tcJHQOazssdlzZ/
	cvis3LldoV93RysdWjWq7wkDjgwMW2V39N9wZ7ZbgXl1CPnxMZq43tVpA7oiyy3yAt/X5joJTh0
	5aIwMYdyudre4NSao=
X-Received: by 2002:a17:906:44f:b0:c12:4f19:fad5 with SMTP id a640c23a62f3a-c12ae77c901mr167169566b.59.1782988559046;
        Thu, 02 Jul 2026 03:35:59 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62907ffsm107708366b.40.2026.07.02.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:35:58 -0700 (PDT)
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
Subject: Re: [PATCH bpf v3 1/4] selftests/bpf: Ensure UDP sockets are bound
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-1-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:19 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-1-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 12:35:57 +0200
Message-ID: <878q7t3che.fsf@cloudflare.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304099-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:email,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 713DD6F62E6

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> Update sockmap_basic tests to bind sockets before they are used. This
> accommodates the recent change in sockmap that rejects unbound UDP sockets.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

