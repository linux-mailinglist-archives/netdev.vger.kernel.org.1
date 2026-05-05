Return-Path: <netdev+bounces-284591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNtVOThv+mngOwMAu9opvQ
	(envelope-from <netdev+bounces-284591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D64D4596
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EC5302CD17
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3C49251F;
	Tue,  5 May 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu+jN+Yq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5763DA5B7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020148; cv=pass; b=GpcZFDt+BQnHpvim8gq6Sg9cOnWzjJi0sYXTzj2DJ7PQ0hJbyuj6sXbX5tdZgrrpkdsC90ZsayRmdH4Mg/atyyiLzDUa54Wzcia1HVmgiRgV2C2ihVJEHMWUaVwsr+co3J5PuIyMeGlWq/kjSSvpZR0urO3g2fUYUKt3zpZ05rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020148; c=relaxed/simple;
	bh=wgUJU7HlqKp0jFFA4pM02AN4stLGq+/Q6dBLMXJyRnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erRTXwlABW9NY7/zDl9Vb3XV/lU0CqSJc/klCzM7SVv5//OG+FoBq9oudF49KlkiGh1Lfn4sbf+51dTAZhjsc/HyLKzZDEHfSRUhmnAnGBZkmNsd3q40bCc3bc5Qy4Stsysk4FfrUfAG+PUoVrBKXwooV4iPuXiv6n/TUu/oOlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qu+jN+Yq; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1a170a50so7714700c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 15:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778020147; cv=none;
        d=google.com; s=arc-20240605;
        b=OfjSDLjAeaDqa3tnZTrazVy4v4j8NN23fl/Dof0Kn3/hkRj1NdxmG1gwFD0SlcQhDE
         CoQsucOuZqBXsV9aIup9XJg+WdvJijFERzm9vPlfXjvhJTDJVpyRYSR0viEB52gS8cyH
         9pb02N50lDFNnoG2zseBx3wIIrLmlYw1CJHgGMaNrpAbMZ4cZdUn/lufL0CKqU67gNMI
         zTSYyjwC9UIUPPjxWTZF2yUG19uFQN4dmzWyVRhXQyoyPu6XmkWBdVPL0odiny8mcLPE
         Fp3iCU+hvDrnSSnmWGvCLD4b1WcByOqAAizuJUyLWa5bkGFLzM0fPSks1dzR4pj5UURf
         SEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wgUJU7HlqKp0jFFA4pM02AN4stLGq+/Q6dBLMXJyRnc=;
        fh=OPGGPutK5jIF8D4QRHa/5awrhL9gqiGFEdm2/3t9ypU=;
        b=DUkkx1MGoISjPJH2jnFhm3yAot76m4LDoI/i67fCc6sH7x1WfqOZn9zkWUvZGmuCNq
         KRJJFJeRlOrH6Th2LQYxh4iazpYeXwpDKPj+P1lpbcHLaxFaKkaBj10OQ5yjxhg0giei
         51dQJrcSh0M8eut/gmy5dyJpOYnKzcXlh8L+akoacS3ZYmFJTwAkr166UrY6kOpUWuTV
         rcSi1cDF+QSGtyz8t430kSlcO6JhVd78+klqkB7y/N0Msd6lkNAnD8FEGE6RpW4eHC3J
         A0PO2eltcidnQHm4nQYpK29U0nQQVA/gQ0I0iv4Y+GS0EgVO2ZfjGBwq8ZzQjrZ8/vrc
         wgVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778020147; x=1778624947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgUJU7HlqKp0jFFA4pM02AN4stLGq+/Q6dBLMXJyRnc=;
        b=qu+jN+Yqn7/wZinF1eoU1nx6YFZZYgQHjDg6sydPaQw6cMkhCimGaPNDInXSoGwL93
         Q6ZuUBPeqMa8CXcrX5EPEiJX5nyC4TXJDWfeaXH6K8HH0XxXUfiebh+iEnHb6SusFyo0
         pNLfj1xr2Ulx2HkLwsp6UrL+ar0CPPHnJBRRV+fZrztfiICH0Z9p7X6w15thVyFwvH7a
         wzHeiE1xr52ToZekzLiuvbrCMTcWgnbPHkuM6qQxRBp2PHHKcd9pnMD3BGA1JAEdWtVp
         w+Tv46/VXn0avNHEsORD0YxAOjkEa3hNjbCSpZKQj9YLZtCuU8k2i1pRIQo0heJ0X7OU
         XNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020147; x=1778624947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgUJU7HlqKp0jFFA4pM02AN4stLGq+/Q6dBLMXJyRnc=;
        b=dZFjS6FNJfvOCATXpDhmWBLwf8ye5hClWJIxVOY94WDFM29sMNNOM9fa9vbY/XuoWx
         reqpNNx4qjmjMedKxBWWMhdnpHIq75a/sKdg7b9AJ27kD6ZxabVmb5xJ3Obmlkbhi89R
         Up3l4fuD+GeMV4OToy4uHl13juqFLIVXOyKZg4+0d71OGFgxVLROgZGp0Qul9RHdNX8p
         lCA20829IJVF4GlWeK6dqnCSIG6L2jskCAC9Y38ntb1vQVnYeMelG2+nrtVK/eHdWrAy
         o4+z07dFArdoMnqIqGZu1zSjCj1NCEphUigyU6n+dqv5TQ3kfiC1yZ/C9c4XwmESGdu3
         Vvfg==
X-Forwarded-Encrypted: i=1; AFNElJ/gp9HStaJXBR+gfr8RV3eL3oivoHKGMjFPrk+pIC/8A7irVbaeEg30kUrtc654eLrOJ9zP0Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJdxGAjgipS8M4+2CP0X/4D2pG1sJkhFIFdp/S3KwoVLHVJrJ
	p2o+n7f9MRLX6s5HSKHOKnbZlepyL+wWhix2e77FiOO2K6EdodWeL8xf2/hLX+ZftdN4ZqeYkBp
	OUyx0cLFoqr0kqNY2Qy67H3jgIWtF4KRNJ8sC1Z1y
X-Gm-Gg: AeBDietQxueuWaH3mRWrA4pISGzLyAtPRI9UQB4b8ZHkVxSWARsVTHprBQ4xiyVz0qy
	B2/eTy68b9kBU0gGKdF9GDCoIJxu2IabpnTQZjrLMqo/ObVM6yjzq/XVe4f6ZM0ob96w1/lHS2c
	QpAQfLHwWZBQIH/tn2M+ZxXcvYQI8lNc2+BGXL07GMd9yq7gYJB347bJIdPqsqIC4dKkDjd1Kjn
	YbMJWIjLF2H2dI0rWb287PEsq+el05oayDM3Aa/eoCc1J4DBmZt5pFZ5F9bbE6t0a8Yw2KUxspT
	s3MrUEPAOq4dEMDe2PBScJkuEDnslO77X8EmC6RxC4q0BW0z7gZfrGzUaC/Vt4wV5CrpBwKe9Nf
	kFhZkxCl+QB8dq+1TDiGyBE8vmFoiIrigVjjTpSBEaYO7bOEvbE5H6rEsYVAV0jd0scxvm7U=
X-Received: by 2002:a05:7022:4a9:b0:12d:de3f:f3e6 with SMTP id
 a92af1059eb24-131a69f30c8mr515793c88.38.1778020146094; Tue, 05 May 2026
 15:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505153927.3435532-1-edumazet@google.com>
In-Reply-To: <20260505153927.3435532-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 5 May 2026 15:28:54 -0700
X-Gm-Features: AVHnY4L93pdlM1gGhXvGm17sGt1hZ31NpRe2ygoTkKYOssrG21cVm7uWUlRPHkE
Message-ID: <CAAVpQUBiH2-nnWRKzK08a4O8VsvbD6NwWo+Zvm4f2D2Mb1iS0g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_child_process() related UAF
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F3D64D4596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284591-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 5, 2026 at 8:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcp_child_process( .. child ...) currently calls sock_put(child).
>
> Unfortunately @child (named @nsk in callers) can be used after
> this point to send a RST packet.
>
> To fix this UAF, I remove the sock_put() from tcp_child_process()
> and let the callers handle this after it is safe.
>
> Remove @rsk variable in tcp_v4_do_rcv() and change tcp_v6_do_rcv()
> so that both functions look the same.
>
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

