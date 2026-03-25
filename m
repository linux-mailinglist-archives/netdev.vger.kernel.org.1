Return-Path: <netdev+bounces-271775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OV1EOxkxGmBywQAu9opvQ
	(envelope-from <netdev+bounces-271775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:42:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4232D254
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5C4F3042A19
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE89387361;
	Wed, 25 Mar 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBHVxKaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2236E48C;
	Wed, 25 Mar 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478431; cv=none; b=Ms0/bUYZfgasDnPDWaN5MxwujNz47da4Ass0kTpDbjN68CZEGNeYCQgRk2cvDzUQS9UJzesM4bu/jrOvq14KUNRXhJ1f8o0BuneuvdXBBwEMcYLd8FHaF96wzrXctlFwopr3pBPDXky6sOgqH6LneafpaxhFAo9My3nruga8Src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478431; c=relaxed/simple;
	bh=d4R/wbePxzZGw/Fa1xDByBLweQrEidyig9/1Ao5Q8y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSZI5EYRwnDulPpIhGYHf8Or9MZ0B2p/CVQ9/LHkMZ2oPWmMK1Rkr7fxCAbm7vlnuQFZonzasOMqfDlFR/QE7t22FAlreYjyxv5H1L9cqfe9v0pa8enWxYY/WvXdOl+GGEgUSElIY5HCdRD5v3xtSzTeRt+FCQdOlnm8x/rwCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBHVxKaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA9FC4CEF7;
	Wed, 25 Mar 2026 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774478431;
	bh=d4R/wbePxzZGw/Fa1xDByBLweQrEidyig9/1Ao5Q8y4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBHVxKaUfohwpXkPJ9rABLwPsBd0YriDhMVm0rDjkCYd8Ve6u4g1JC3jN925iQuIR
	 FSNCdEx7I5I9Jg0Pe58Sa1iai2l6duaS34iAW26mhgjgmJjIHHH8enB5Gbso3Kemvz
	 5pe00wfqNkXkrotJ/vW3XmslX3AdRpvc5sxgC0dfoBpUoG2inToJGM91F/3LpwXhC2
	 GFO2tFH3JAG6N5AkmEeMiEsaRso0IsHghTEGxPccrQBpcl9zmpeAiiV1EYOTIdLOlf
	 NuQey4vaNAvATilcWEgmumraamChK0fAljRIoTjx28dFuRE+AoH8462AZVvUT1HJ2x
	 7k26GslG/THEQ==
Message-ID: <93822084-f558-4194-be2b-cb328b81e412@kernel.org>
Date: Wed, 25 Mar 2026 16:40:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
 <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
 <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46B4232D254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 2:29 PM, Fernando Fernandez Mancera wrote:
> Hi Martin,
> 
> I don't think so. The IS_ENABLED(CONFIG_IPV6) check here is just to
> prevent an undefined reference when compiling with CONFIG_IPV6=n. Note
> that this code isn't reachable when ipv6.disable=1 is set during
> booting, as it would have crashed even before this change because
> ipv6_stub->nd_tbl is NULL if the IPV6 is disabled since booting.
> 
> We addressed the vulnerable paths already during this series:
> 
> https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com/#

What about the use case of IPv4 routes with IPv6 nexthop address? Has
that been tested with a bpf forwarding program?

