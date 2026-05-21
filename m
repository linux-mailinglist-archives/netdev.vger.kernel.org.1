Return-Path: <netdev+bounces-290180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLDfD4ZYDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:57:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B259D734
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB13301CFB8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864627466A;
	Thu, 21 May 2026 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFCqsiKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DF156661
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324906; cv=pass; b=ToYbHqGSchWkdsdLlCcM4iyIKrQ0NcgVpTywhgKM85DpCmVNiS+E0kb1LzsZrff8e2YpNyyqmeVF3nScLmnLHe7TtQO9c9+SArrhP5id3LPfF9/NDO9Pfa/EkACl8iRJ9xxOosctYp6i1hcQQd96T9oVSuY8pT4oWo11z1cxS1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324906; c=relaxed/simple;
	bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyIH/R4W0FmcA8tZdqNsU4KxjVuf2ZjLpcJ66XUeirUBHBP9C6vwhYjBxxmQuoEz9R9Kl0w5xulUCXm+aYVR1uWs28Em/VDEJ79n8cq2mZ196pJEzskhSodMTA1pKt6+m0Uap9/RuSJdc9sa8RsWXt6BNvxS4JxVdIyTTGXPkbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFCqsiKp; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso9843031a12.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779324903; cv=none;
        d=google.com; s=arc-20240605;
        b=GYeRor6Jjcq/ExwDhR23ibhYAwPNt1VZlAilfAfm+k3McUHBLMX2S3+w5WgZvWHfr1
         VfxTuxH03OGqZ1YSgew6H28pZmiSGyAVlraq6nKEqZ7Z/Ld+BAbFO/Fox9+x1S1tJuHi
         Lgt/U03q7taDXIRb6Y/tY5cAJ81sf7ZgIZfZethX8cX8SiCBSdJ+Uy7XysijamOsh476
         PNmzuhMr79jQLdd+0NZtr4h/9bcCgyHHR7w//6W629gqaLzlOwzFIoQFpidLD2XRT8Ze
         tkIRwLXYoNw+Y6WIXGRPR53uPxbn36ozK7SPHFTzwRLy+bFkuFU9AxUkIq8BK0qmg3lH
         mL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        fh=2wiBsgO4ajjbqfXrb0q3PnOXIVSj2VG32cjFJecF/3c=;
        b=UBdhAKYzB/TBdOnTGlTSBX83liOK8IfS+uwD6LojEg3IrJG+es4Qk8g7p6IUh+ZiIb
         fok/DUeUtmmmurQcY18pwoJ7JjW4jO/cFk2EwNCvfwmZ9WBsL66lqkHjtr82fkL0D64I
         4BaG7GdQlaDZnt/0akB4VF1XTFzPDIZNJRZa5y3sgm0qP1196vxHULmTg6aSOdplUYTy
         PO/woyLfBSh9w1APVWyd7aJNZMW9Whrp1qhwf1L8JSzSD8fAB0prikPlF7gIMbGCIlJu
         iKLSPkRXJ1PTOGvdCbOLxiNgBncgtNKHm+K8gPD6gDXRWa+gpoi2pRr8J3jQKpVd0Xwq
         FAzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779324903; x=1779929703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        b=VFCqsiKptHR4J2U3ZzBY3Cj01GpmS7AhsD9fLl2fZlQ4zsBr5KF5Zi6uIsJtfWPWQb
         AjVOw7ybtfqYqgYlUsoNT3ynVvRSj4BGfUtQVZl2NA0S2/Wh41QQ5/Y/si0XdNcelUoJ
         XVcSJZgIPTMksCedyM6nN+fsJSITJsMIXLPvZRyI5owaRqknizG7nv/1fn4dPDAG+Do/
         GwdwjuSxSa3bz+1a4iT2q+wdmkWdp3kuRV0wMeo5nvdQt9sEQxPiTgUJx1EbUg/8jYYF
         aFZe5VvoNsqx6SaIycP0W5EwkzTWn+FMyexFJYG+YSSmJg1FPeLvmiBHeXOypcuovG7C
         2Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324903; x=1779929703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        b=f2f6043f0tyq2TCVekoe6sNtSgakG2jG8urDiLiVGFvUwhE6KNXy1dG4R8lchyVtda
         g5t0CPhlePKBVqpL/IgxzW6o5dqpf7Y1yj7Ur19TANj8mjl3SekHj03Vd3grz5iXJ5tu
         XKDL0yvllYoTJCirN4r1UwZs2uEpDZNcFRlpfqJO9wVp6qomvqrfHRoO9ecDYgVNk9FX
         Ioin76/RBembJb0sG7gaAv3G5LpWOXzZlLJ66MXNfjvvJwBM8VV1o33TyqMb3IOqO//T
         9Yua2iuXTPmhY+IF1JKTBV6DuypZH8PmYH8Sn1mrmvDvy+pwfmMt+QUXs2KDK4W1DxJu
         xAOw==
X-Gm-Message-State: AOJu0YwkvQr4mddI4Yvsxw/zYzSEVfokZhJRY2+B945GQAiA+/lpvUD4
	1iBtXJOwxAstnxMQf3ZlcZ9OeQ7+sdsUnZlN+lT7SEyxIrQxt3KsW5Yf/obfT23VOmPWvxQ3kj1
	5tQbhcXcBWwMpBwBAgHAepQeVJDB+8TU=
X-Gm-Gg: Acq92OEEJgclYQkqdl778JlUf8kX6KZclfG+K3om5Efcix8nwXny5YNafzkT0YmOo2r
	r4JqIua1oQS8xDNvYD9eE0yviIT+E2beIt5Ps8h8YFkl7sqx2v55HJMHs/dELNgTk2eTF0/yDI9
	y0Kw5tM0ckaougzglh1LWNDmIA282E3gKiKSo0yG+qMiAJq7koohTndqb3/nCsWX3yRalP0f0f3
	AI5O8xmp75cmiMxkFb01jWFGllh3S6AI6qYxOi5bhmJDacobE1mKM9NNAm41tpt3onknSEihYlO
	U5ZYW9rF0hSfkDO34Cb+2c+IJdR4rIg6Y2CmAgsaNWKrBZq93XIDCsh+RFQpCDx2/1dWR2iiXoO
	NvLpEAJj6isafw8Njk6ArnzhHkC/bm4ymIrMutFcN6lyll5UbFqEfeXr+0g==
X-Received: by 2002:a05:6402:28c5:b0:683:a318:a3fc with SMTP id
 4fb4d7f45d1cf-68836ec8852mr171786a12.24.1779324903313; Wed, 20 May 2026
 17:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com> <20260520174545.69766438@kernel.org>
In-Reply-To: <20260520174545.69766438@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 17:54:51 -0700
X-Gm-Features: AVHnY4LkK9r44PwoZGpc9qKOSt4BjRg5xozweKo9ZsJP-nfQGoQ-0m2a8vIbcVk
Message-ID: <CAKxU2N-4kAmvMjodZdoPCiYzKxfjkZwewXY-sTHD54AtswWz0g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD1B259D734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 20 May 2026 17:39:41 -0700 Rosen Penev wrote:
> > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > Collect received skbs on a local list during RX polling and pass th=
e
> > > > completed batch to netif_receive_skb_list(). This lets the networki=
ng
> > > > stack process packets from a poll cycle in bulk instead of handing =
each
> > > > skb up individually.
> > >
> > > GRO should be even better.
> > GRO will result in slower routing performance because there is no
> > hardware checksum.
>
> Mention this in the commit message too.
Will do.
> Network adapters without checksum offload are pretty rare these days.
Qualcomm continues to make adapters like these.
> Speaking of being old, do you know if this driver is used in practice?
Yes. In OpenWrt with kernel 6.18.
> Maybe we can delete it.
Way too early. I've tried previously to clean it up some but got rejected.

