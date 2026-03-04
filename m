Return-Path: <netdev+bounces-264043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP9aMLuiqGnKwAAAu9opvQ
	(envelope-from <netdev+bounces-264043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3E207ECC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E06303FAC6
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2E384244;
	Wed,  4 Mar 2026 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yrq6Z+fD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C86313550
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659292; cv=none; b=rE+rLwcKCcMjcXPZow8+j29qm/sVhgjeN4loPXHSEYaVV8XNP0isg5mCLCW0NveAGbA1uqC10A+ltbuzRjl7fy2p+/ECZuM03VwtXFkZMwuJ3jbm814oh059bllKKek82MchVQBcysj3mo8mxM2x6itNfaowBW6j9Zzh6dc+MjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659292; c=relaxed/simple;
	bh=8/0BGGAqYQUjeK0d4hFg5aiF0xhSvfaKJmVrjkPdSgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8qLpew4AEZR6amMGw3xSR4dE5hNE/hYnApqYK+Go6BlgQE9LVmtwRzlBioIVXXS0L1BQYTdcK2P1OD/Jha4ileuBkLdVSI7/rXv5VngZ3oki/9/pyayEfe4TnIqb/RucGO95L9QGfMXXvk0Hma0V45zpGK7H/At5aQakVrkUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yrq6Z+fD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e9577ceso165139935ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772659290; x=1773264090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoobhABnId/ABnpFfMX/36VvKKNGMl1cV4RO+RLbNuA=;
        b=Yrq6Z+fDcySVUbYBs/Qcp9ZO53hp8q4/GMnGiAWb8CtffJScUfid476K98Td1/dUvv
         nUWsgQoXW7wW57+MZQdUctwC5hnM3ncN6aSH7z5Y/7uj/wIm0VjaGLgAeFycoWM9k4qA
         y87ZdBQzqum2Zlwo7+6ixqAkExPxcYG7G3P6IOYOt7vBy6VDiGoHei91wfR3JP9XZNO7
         mjNZ70gVCkdhunV86WcWKtakIuSDrVXiUpldCffZZY3Y5RSAgleywbriKu+/Y2xknIn0
         /3HqZl2eYU4Pwpj4MntATnHKqD8y7kIjEvsJ6wscXe+w9F7khHYdI0UHpzgZ3jpb2yYM
         w/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659290; x=1773264090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoobhABnId/ABnpFfMX/36VvKKNGMl1cV4RO+RLbNuA=;
        b=DPSgsj/57JsS7a7iafvpfB13oZWlnqifoOTBIuMsgk86Mklk4MUM5JkwZUspKvCNim
         rJLYlQihhzRCcubb8OQCn2BBC4hSkCJXcOnP9/uIuA7YzMruBYb/8dyIlcrTyjk7jX+R
         qvbbuymqkVp0eOahQLU9F/NF54bK+44ACRqvyfHPAibW6lgPD3POwuhhZPz9CNrgBnVW
         jl5FdG6qs4QvBSk1GyaX8I9yMUfKgKlrTzsNqPDUuGxnDSaUxCdvS8jisI2DLA4sQQ0J
         E9ppyOxWoIpdUayRDcfEarDpY7Q9LXjmzW2XNQWsTAUp/Z54xyhjDuxnKPPEnSgCz1n1
         0iIg==
X-Forwarded-Encrypted: i=1; AJvYcCUWGVhge89TAHQ6J27j4P5OZSOzGCWa7XHc2OnmLjH216hHGfeNQBMHyuTQoSTCRlXmq6JP1Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiDruLwFK1S0mjM2X7FGqb6/OaDOe3hzZ2v6I9aDgr1tYbxRK
	dfZL2zps51LjA9nJS9QpUiHaucfoXVolKcCCewttBidsmeUUQ+9NJlMXHFCbGK9m/ieQTjB/RVm
	6NyPc+g==
X-Received: from pllo14.prod.google.com ([2002:a17:902:778e:b0:2ae:3e55:f044])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8c:b0:2ab:3cba:42fa
 with SMTP id d9443c01a7336-2ae6ab2519bmr32290315ad.46.1772659290127; Wed, 04
 Mar 2026 13:21:30 -0800 (PST)
Date: Wed,  4 Mar 2026 21:21:03 +0000
In-Reply-To: <20260303170106.129698-2-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303170106.129698-2-jrife@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304212128.1943568-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on abort
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jrife@google.com
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, willemdebruijn.kernel@gmail.com, 
	yusuke.suzuki@isovalent.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 47B3E207ECC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,gmail.com,isovalent.com];
	TAGGED_FROM(0.00)[bounces-264043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jordan Rife <jrife@google.com>
Date: Tue,  3 Mar 2026 17:01:02 +0000
> Currently, udp_abort() invokes __udp_disconnect() which clears out
> socket fields like inet_daddr and inet_dport. This makes fields like
> dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> hooks following an abort on a connected UDP socket, since they'll always
> equal zero. This differs from the behavior for TCP sockets where a
> cgroup/sock_release hook will see the address and port that the socket
> was connected to at the time it was aborted. This causes issues in
> Cilium where a sock_release hook is used to perform map maintenance when
> sockets are released, since Cilium actively destroys connected UDP
> sockets in some cases.

Just curious why Cilium does not unregister the socket just
after aborting it ?

At least Cilium should know the key at that moment.


> 
> Make the behavior consistent between TCP and UDP sockets by not clearing

This patch makes another inconsistency with TCP.

As you mentioned in the cover letter, before the patch, even if
aborted, a bound socket still reserves a port, but it does not now.

This might be surprising for non-reuseaddr/port sockets.


> out these fields in udp_abort(). Instead, just unhash the socket, mark
> its state as TCP_CLOSE, and preserve the state of the other fields.
> 
> Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  net/ipv4/udp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b96e47f1c8a2..01a0a0fbcd56 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
>  
>  	sk->sk_err = err;
>  	sk_error_report(sk);
> -	__udp_disconnect(sk, 0);

How about passing another flag and avoid unwanted init only for
bpf iterator ?  This will need another layer of __udp_disconnect()
like ____udp_disconnect() (I'm not good at naming), or must make
sure the flag is never used in uAPI.



> +	sk->sk_state = TCP_CLOSE;
> +	sk->sk_prot->unhash(sk);
> +	sk_dst_reset(sk);
>  
>  out:
>  	if (!has_current_bpf_ctx())
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

