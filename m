Return-Path: <netdev+bounces-295440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GguLfb4IWqkRAEAu9opvQ
	(envelope-from <netdev+bounces-295440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:15:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C448643C25
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iEXUFXgs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295440-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9C843019540
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237831280D;
	Thu,  4 Jun 2026 22:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49830677E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:15:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611317; cv=pass; b=CO9evOnbH5BygZ1mc3sEbWjexk9VUtcKt1tXMDP2u7hW3vwWEvvpXvM+J48OQKcDpyyMokJDA/DJ+1++ERO4e2BxCG2e8DChlQCQ3svc5FCGPKnDfXNXA77zeKNdW+qQVe/MgxN9FAy5JjV4D9JETo5/ryQp9UU3ha/M0oxOTQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611317; c=relaxed/simple;
	bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNoEvVU0JUfq6JUs2U8ojvSmGkOUThjSkcHPwEm3OxY2q9bgACH1Xi+a2Lc4u/0p92G7KnJwKGjGNmnqxWSnr1WfeRHnZobambioM6sPgh1rjJeDHeTxhZQyzMIwDxkyroGXLqgUfyWPLwUXycN9DfeDWaRfFmv3Wsfc6g6nGzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEXUFXgs; arc=pass smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b7866869so14526905e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780611310; cv=none;
        d=google.com; s=arc-20240605;
        b=h9aE5y3wy22W9TWtdijnWjDSo2Yq2twQh+WqbKrP+220GoaVq/dU+Zp0uWhGOC9uFB
         aOgBbFMakfOGH/AOk9s7Awz8KBD5/BA/O0ik471xDjhBvxUGdyBL7koonCa9ywyGL1Yr
         6s6kOBsiFO+Ptt6PzRPKMzyrirVZSXs9T+DbNOOiRee2ezxZangYSM7mDx1Pa2Y+3972
         40bPEQTw+WoxsjAQ0HfTjcRNmCz5hsdT6AekA9TBPmcYCfVnPVdqGH2sfryEs1JnrwQ+
         XMml2bf5GNXCNq9My5Sj5y55it89BgKHXttjW8aIrYtqcGrfzqRV69ogReP8FfGYiWz1
         4o/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        fh=CUQ9qQykhEMabQeRWsmlNX6p1yx61xQ0ny8bJJnh6O4=;
        b=DssSpkyRN28VoLvPu4OXzVezqjfk3yduGk3LbgLCnvmFxtpmLRQFLD+68q6iuQr1c7
         QjfRaKx7KUu9iVFwYFQCnzSLd87ixzSiIZSILbfPjfFRNl4m26Nf17NF/hc3Ekm6RAkZ
         11mSc+NCiT7WQHISH2zY142/VBs7L5bn5KFacR1BKsshBwXzNGL8l6mj0RRb0FcTai5k
         bHY9n1LkolsiOQPtPuc6xEUsUgjWHGrb4GQfkNTrm3mksrhLRAbecPzN8wEC0pUwWya7
         V7KyBHrjESlP9oKmM4XqvoXEFC6ZYDhG2Sm2gErD04/xmhfPlCqJ2ivUSBezSSJyZzB0
         0UfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780611310; x=1781216110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        b=iEXUFXgsNaotlG0sgZ+JlvIz2B3IEpkbi/YW95qSNxebMXaDvuDYK1FoctdNnitX3E
         XGdnsqbtB4LbTLxsLSsWmKbvHMfxVLgVpONZJbuBXQv7W65yD0guZL3TfLImNeuKO6b5
         SiyzRdmgjiAqJ8KCQwMeD3pDCyxQPbr1xBjuHpI7jB2pJxCTCzcq5rx+vfaeEqkIlWr7
         U85Go+1mMusqson7jV7KnAUZWiWoflZ0kD/5TyKyPV9X8G4bqi9udpII6dEIHULzUT10
         2B5foUb0eD7R/bFMQO/mqe4ZmqVo96L7uABjHvG3wiaKkX0g+T+1ky6auP+Tn9R572ZF
         +sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780611310; x=1781216110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+S6n/Znutpvljp2LyGehOTzm7sQwOqrmvx6wxqCpZQ=;
        b=orxlB8wePpiqIzoTNZ+V7EbPFQ4djnMd5tZdoBYwpKz0rtUVTni7KxdqxZvCPeB3wa
         1Jmh09FF7SZKA64n6AxmyshJ/taOKRtHyg5pX7m3RQViHqJkNuRNY2+ll1eBJO7pooY7
         UA3JFqnIOW07Y+PFXdtOVRBV0tVONqXpb74ZcE1bKE/CQ7zjTK8uOEOV9WCW6PyL+b9j
         1VG1QClwmaEw+CAofyRqr9pNGjwYeiVGhl+LM3azRDi3sRrApDFOtSG2PKhdAlu3EQCi
         M3CoyppKs+cPTVYuFuLHgTvs59PcqE03yJSTqq/Z7Wlb5eKXpLBPdhOdMlt1E+OoeQEG
         I5ow==
X-Forwarded-Encrypted: i=1; AFNElJ8RyDAdnL9E0zcuFVyh51Ipbsw7KpXJbh3JQxQKW3g0qeZeiuEcgH+IEJ9Nobjh9fT9kVAk1rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tK50oiw3A02z0a8fDtarJiKq8J7orRYTyWLFaFEJWx+WKQ/b
	YSEKwaxTZKN/rixr9w4z6Z9RRNGQfevmE2qGRHKtEtagzg07yT914IqiEFJoGqBxSw/iD7xp/oK
	B2aq9/+crCSbppnFrq+abGlbaHFyennI=
X-Gm-Gg: Acq92OErZous8BiBicZK24gyIbDMXaP9lJ3TYFgMFT1v611C+CBK0OmkSQPjHh5hhra
	gifjs8OuwmFuGHYSLp7h8iSz0maNQ3fRqAPrGe5HgzCzmiz+28i66cqsL7TuUjo/BH1Lq6lupWt
	H2H8xuTIHS5++8Zw5lcZTFzKqY9nZX2KcD+qzu+MzPjOTABLjcWppG5foGHcUPNLpYGRhxlNWRv
	pVTXJbpE8+9XJSFrogC/7jkO1JJknXUJoUAr7MicB7gqxgx4+1tXa1+bNkg//LpaiQUVxa8WCDX
	w8w8GATbaGqsrTgtw1XEYG5RZamLK9w71LxjWqlXNFDJH/bhLAHGeN0vw0YqV9q1wblFY9SZyB3
	qt0ye9G6in4XDzD/KOKfmKvwgM7jIqKIlYE2VO9DuIG2n55FhI+OW4wTbFIS35/o+DH8RbA==
X-Received: by 2002:a05:600c:4fc9:b0:490:b8c0:d474 with SMTP id
 5b1f17b1804b1-490c25eee06mr6021975e9.14.1780611310133; Thu, 04 Jun 2026
 15:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-1-ameryhung@gmail.com>
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 5 Jun 2026 00:14:00 +0200
X-Gm-Features: AVVi8CfnBYLIp-tlymFRZk0s_Hv9SPnYJxD2LptM1OA6yj_xom8IhP939m0OY98
Message-ID: <CAP01T75pWAgXi4CRR4Ca75grBFwXBKHERdH94KVxW8hDQ3uqog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Object relationship refactor followup
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295440-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C448643C25

On Fri, 5 Jun 2026 at 00:09, Amery Hung <ameryhung@gmail.com> wrote:
>
> Hi,
>
> The main patchset refactoring object relationship tracking in the
> verifier has landed and this is a followup that addresses the remaining
> feedback in v6 [0].
>
> [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/
>
>

bpf-next makes sense, but Fixes: tag looks missing?

