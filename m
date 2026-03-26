Return-Path: <netdev+bounces-272135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCq2B+hgxWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:38:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB7338839
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BD82306E02F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151740822C;
	Thu, 26 Mar 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAgnWFiK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979C3C7DFA;
	Thu, 26 Mar 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542430; cv=none; b=OIFjZ3xXi9SXJWM8q/gMEGgVO297mRPl+ftVEvNOgEx0nLSkLklUn+k8HDaZjLIeg3EnlJQU90qDWPo5LNbylhiRquMt84poaGBkPBUIj/C/m1E8HurM7NOFrIPl0Jg654bRfGgESvtUwwMKKyzbpktMQNF4PauZajVOFrFwppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542430; c=relaxed/simple;
	bh=FOmmId4ryA+YOTqhM7wpTHuU7R8PWpYh6XnlDyHrm5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0kucDBwfB1XxT7AL3sPph9ICxoYpem0gyIsbwSs1BiNY1dLRbCO5SsDixYg2Yba8DiF74bGx3IxEnPduq/DF9hRwB7aj+2NtLg7F4gztsu2mRGYOZA/GJ/4TKZ6MBeznl1A3D2cGtp6fPEtpMz9GoDrfqg/6lLf+AB6qhX+Fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAgnWFiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DAC116C6;
	Thu, 26 Mar 2026 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542430;
	bh=FOmmId4ryA+YOTqhM7wpTHuU7R8PWpYh6XnlDyHrm5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QAgnWFiKhaZC8sJ4Ors/P5eezAqBFP0cQPr45i3KsYolY5Uq4drWq17upyOaCgjJc
	 UujlgTX0DYvSFjSRak6XNUNyqL4cltjUtObx+U0r8EVxxmoXoC69bJ4EK3X7lAVjs4
	 idWWEMqO5yC+8yWAmK3EMnQQPH5jIChqCAZYp/3w2uPAAfdk8zVXaxjB7FP8EH+nf7
	 d2zLC9irOEcQ9s6w/j9QpFRT/vfgTki3z4hOoZq3m5pjfFGguJPIEkG6ETcZAEOrbO
	 vUB9hlJlBkRjaiBeKaJ/3n3tTbZvxNJjEuMNFWNBTtUXREvUtp9iC1sYAbcn1cLNDa
	 sPw9JDaYRcA/g==
Message-ID: <867939e4-59de-4c12-8fed-7cfeb1fe092b@kernel.org>
Date: Thu, 26 Mar 2026 10:27:08 -0600
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
 <93822084-f558-4194-be2b-cb328b81e412@kernel.org>
 <77792d0f-925f-4600-913c-b9dcdf8e9ea9@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <77792d0f-925f-4600-913c-b9dcdf8e9ea9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2CB7338839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 5:41 PM, Fernando Fernandez Mancera wrote:
> Hi David, I did the following testing:
> 
> 1. ipv6.disabled=1 since booting - the IPv6 nexthop cannot be added to
> the IPv4 route at all.
> 
> 2. ipv6.disabled=1 after booting but before configuring the IPv4 route -
> same result as above.
> 
> 3. ipv6.disabled=1 after booting and after the IPv4 is configured - the
> neighbor lookup is fine as the nd_tbl is initialized. It didn't crash.
> 
> I did tracing to make sure that code path was hit. I tested the
> forwarding with 3 namespaces 1<-->2<-->3 loading the BPF program on the
> second one performing the bpf_fib_lookup() instruction.
> 
> I could do more testing regarding this if needed, let me know.
> 

that looks good. Thank you



