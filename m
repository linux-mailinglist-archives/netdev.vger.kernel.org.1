Return-Path: <netdev+bounces-283134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFSQNjtW9Gn2AgIAu9opvQ
	(envelope-from <netdev+bounces-283134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:28:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12D4AAFA3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B805C30067A6
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074935A383;
	Fri,  1 May 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa43aQYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A18021767D;
	Fri,  1 May 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777620535; cv=none; b=l7ZRa19yQa4DOVfNy28XNTYixNWAhp7ECWxwdFXYDKSq3us0mxhdpXQc1VD3vJo24sdzkfYhe4XhXNv9faCgVrX1Af+KTFmIh2CURlu0xUQdqfiAi3iJ7/HltEN+EGDBKA8pANp4aFnzcff9nL2iZ4NK7/pqN1DYWWEmOAjNfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777620535; c=relaxed/simple;
	bh=gHtu4eFjUZRmQUMrmjbJsuj2MVGkgojo6i+6CR5kDLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsgAWZRUKqJAC+Xg1ARl+2fBS31WZI2lcypJtoIQvGdmR7FmXlXuxFUWlqXhkD2mKeV+TnaUOGj1f2GHqoj47UAEwxTjlqL/bzu5joKmzBzDI5IIVMPil5XFPbwTaOOzmRRC2UUDhf6u1ctYV3s+cUj4gBItZoT244ogrXQe54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa43aQYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A817C2BCB4;
	Fri,  1 May 2026 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777620534;
	bh=gHtu4eFjUZRmQUMrmjbJsuj2MVGkgojo6i+6CR5kDLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xa43aQYv2po2JC/SOCRrFJWkdwHcHJdY4kLdOLiEjWEHaeGxp7b3UWMaWnipRBDxa
	 6ByZQvHTvW0riisxgeufSDEJM7Wm87XR58TfmuObgHonPJ9abK2bIHCmUBoUlUoN0S
	 917ZDf21r5njNNBGrDuTrUAVLfPfG8VH7WjtTezfOiTyuU4JgNCbNfvSObyA24tBEs
	 6+UXiFopTbQW3qlVk/ca85liR0L51NdxuXnbdwKf09PqsVR60YLlOcTSJ2/q4ng+YZ
	 ecurVcoM10hRK73U6XR0wdOovrY04emSYPqJgEl4qss+rLc2ATyXmmFkWNyykkzVQr
	 PwhPnTWLxW1mA==
Message-ID: <f9292ffc-e62d-4048-879b-042ec4d7d0db@kernel.org>
Date: Fri, 1 May 2026 09:28:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] veth: add Byte Queue Limits (BQL) support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Chris Arges <carges@cloudflare.com>, Mike Freemon <mfreemon@cloudflare.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260429172036.1028526-1-hawk@kernel.org>
 <20260430185825.43b2d0aa@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260430185825.43b2d0aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6C12D4AAFA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,davemloft.net,google.com,redhat.com,kernel.org,toke.dk,tu-berlin.de,debian.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]



On 01/05/2026 03.58, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 19:20:27 +0200 hawk@kernel.org wrote:
>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>> latency by dynamically limiting in-flight packets in the ptr_ring and
>> moving buffering into the qdisc where AQM algorithms can act on it.
> 
> Does not apply (am I remembering right that it's not the first time
> this series doesn't apply?)

Rebased posted
  V4: https://lore.kernel.org/all/20260501071633.644353-1-hawk@kernel.org/

The conflict was on tools/testing/selftests/net/config for a change 
applied 16 Apr, and I send patchset 29 Apr.  So, yes it seems I forgot 
to rebase for that period, sorry.

--Jesper


