Return-Path: <netdev+bounces-280584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KCnFN2M6WlwdAIAu9opvQ
	(envelope-from <netdev+bounces-280584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C48944C74E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 868EA300680E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233383C5523;
	Thu, 23 Apr 2026 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ej1N1txR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B323C5526
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913623; cv=pass; b=IOuB27AGM7vTk21buln3qFertWJOpT+A8qHsi0h7LdMfDRIJf6UeUMt5CNJ+/BJezQWtwgSRSymKesrN8ANJoH45slR8nZnsNQ6B/x1PKBNmUwmvR8mWKd40MCFLIzfq6wmnSFVYe+TgBt7De/dwKsScbbl+x/AHhCZ3/xPbFzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913623; c=relaxed/simple;
	bh=XCLXDbphdhLQ8I7NEFQiQanixH7UqHhty+yjIG/7YyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7nOTGe0V2S9QEkQN43AV62V7NgZd4k0K3UFv5lpTnUpE+OQdQsiOXwRmFuUTcSSNdEMSoMiHiZQAwJ4QzHX5MZyIjd73GbFryLae7uBQj7tRFTAF+yPYgiwkriMRH5PHTsF7mC5sAp0pvrlYoFFV6cspVyZ9VjL2CfdxChk72U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ej1N1txR; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12db7bf1541so2454296c88.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776913619; cv=none;
        d=google.com; s=arc-20240605;
        b=HK7bbQiIRwBZYd4b2+gl4a1Nb1BXkWYd/wUFLsX8Cmb36dAXquLWW3+tUxIUJWy0wF
         ZowQZ6HC8pghAJPqvVirdDNmPt7LUcD48LTIvigLuSk8jCqqtR0VH06Lc8uU3W1b6rBY
         o1tzyGY6Ir62CuyBS3Z0V6P9nlwxxu+Tnop1jk8Qh2kGPwcK4AHyvvxKyVCQcE5hW3zt
         Nmp8cJGYHdcjXqibGUxcYCdbgMfacR9hRar5GV3D6u8mX+DIfr4nzjraT/W5QE2nn+kz
         OYxWyvcgoZRW12yUlcwaizlIFIVyReYFJQkexB/F2XS3+DXJlfjtpH9CIODpqdXfDwnr
         6GDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XCLXDbphdhLQ8I7NEFQiQanixH7UqHhty+yjIG/7YyQ=;
        fh=L9mVfi8LAkfPbprz6IQJwAMN+QXvcasfQJU6bimWxdo=;
        b=IO1MpCpLsE2jRC9iebp4BEWZAXrl6uf+ZmB1h+99PlgUQrBs+tzs3p5ouUJ2dRjylb
         36hYDNszrWUxioUdKB8Eh1Dz6NuvN2RNjCBk4n88CtybHOOfg7QdPXbWFVga8FjK0lNz
         7Tobqyq5rRBtxRV3Srl4e99cCXOYomKAhGdofP23VLPPR52F5ShwranTb9BFaxKrhB9w
         lpsgRXjJBJ8zuQ/xXXG7z5HEg21PDW2NocheB/MzBm49FaPPQOgiV6Hqg9cQfkP0/QeD
         N/NxgEcmqPE7J5rSOQ4qPfUYy4wNGENwiW/8ugY8u5Po5yEl+Ue6NtC/VuTb1wlCKCZh
         PdOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776913619; x=1777518419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCLXDbphdhLQ8I7NEFQiQanixH7UqHhty+yjIG/7YyQ=;
        b=ej1N1txRZVXBkMgsUrykOzJKn/MqbcJKlGZUKe4lnycAS8NPyPEpRLAX/T33qNpbS9
         eRJoKxAEZyLiBK0XaxPKYzkP6v1RdRdzOwch1CochPY75yyExkZdl6wqdB2UR/cT9KGN
         XS6J8CePVkHpDvfEW4eQ3Mh7qmCI2FXYBQs93+NBc34+3XUGu/xUCnwCWK+nlmDwd1gK
         rHk5TT9X7A0yrxByOGSigmQiST27c1mDDZDilDYcoGS/uJe9QNdS0trGyYnq2ohDmZIJ
         r0r9fj104cE5q4xv6IabjccFCCi347D2P/jbc5t1+zMCZJ7F1yjhcVjSa2peysZL8+hJ
         2YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776913619; x=1777518419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCLXDbphdhLQ8I7NEFQiQanixH7UqHhty+yjIG/7YyQ=;
        b=F3M0CriJ6xVjruawShZxZN1woLv33l0tH0CuUoGZ8F9myEznEziHgi03ZqVzYYmWyj
         0ZER2APz5aW4dxf6oLlTo4/Ogbszf2a+DazF/lnyLCDZ/IhaJ4MJwqbW5XZHCopL4mj9
         97LWAHhGB1KPIW807sR92aJqeWPBWNpa7qdkItSo4GcJuCznENM7hJea8W6o6Qn0oBaC
         DaVRFwUNnAMzTatQvUeAHg+thrZx1CTCJy0O2I80f52AZfBE8wWifo9kRFCiK24bcFf7
         0ZjVkvR6WQ6vy9/8MFR3mzgBukAgWgnAI1bMIrzJx1du+GxjBwVAIK2e+CETwvXT7Oo2
         kZ+g==
X-Forwarded-Encrypted: i=1; AFNElJ9mqtyjbxEpOytP403TgBUFgckbjater0DvF5UwSBNCxPqYd2anMyiScMX3781FYMzGkjw/M5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFdFF4AbUV3+6skFXUgtf4BYqPjblS99+DPuTQvSBc3EhZ2uT
	R0zLOHl+YqhRjrmE0/636I6vrAYqz9uem37icnXE+9CePMW5Bzp+SWHkAFegCfR4hAklDmY60ve
	DmXdX8d4QCaEgpIit0JN5E6DDCqpvFidx9VEI2a62
X-Gm-Gg: AeBDiet7hFUoWRP4pkWEzhUv891IBFPloyTkfdn8uMKeVy3hd5SBAAEuNrVzM8pFOMs
	qcil7LJQLms2/gWmM96bvwgFiVIzq6csqLIpfpL4/IM41sVCwFunLhpEjlc5EhGi1pVY9//IEzY
	OGhOA8DjHjU6J79ucKql5BXkva42cVrOqhNu/qO+ER6b/h1a/sY+5WAlKiSILAEaShTopKODTNY
	Qmv9B/7R9hPJra1tSRR3kehDVr+c114bAvCC9L86nfde+lYXV1svet8VhcD/K3Q/LSmATO3XD3h
	TTHENPTvwg8mdB105llPC0AkPU5EKSXSHYG0xZGfPVxEHhcYwDkhJrKkPe9cCWm4I5p6JA44x2l
	UuJlsys+PFhVZ+bXsFA+k/dPIx6ul24rXLEwRXR+LiE+E/LMbyOH6dh8S8AB5IpnckHWuhtgjMg
	==
X-Received: by 2002:a05:7022:eac8:b0:12b:ec96:c936 with SMTP id
 a92af1059eb24-12c73f70bc8mr14367576c88.14.1776913618818; Wed, 22 Apr 2026
 20:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021824.1293976-1-kuba@kernel.org> <20260422104522.GK651125@horms.kernel.org>
In-Reply-To: <20260422104522.GK651125@horms.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Apr 2026 20:06:47 -0700
X-Gm-Features: AQROBzB6Gd9vT7YrdkLSBHh2mcbacrp5O3_yj1j4ISHF0fFTaxESKOHzNGh7T24
Message-ID: <CAAVpQUC8N5+V+ZSq_=TVf5N2f=L71vrRsyo65U96V17as8+0kQ@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, Simon Horman <horms@kernel.org>, corbet@lwn.net, 
	skhan@linuxfoundation.org, federico.vaga@vaga.pv.it, carlos.bilbao@kernel.org, 
	avadhut.naik@amd.com, alexs@kernel.org, si.yanteng@linux.dev, 
	dzm91@hust.edu.cn, 2023002089@link.tyut.edu.cn, tsbogend@alpha.franken.de, 
	dsahern@kernel.org, jani.nikula@intel.com, mchehab+huawei@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, tytso@mit.edu, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, johannes.berg@intel.com, 
	geert@linux-m68k.org, pablo@netfilter.org, tglx@kernel.org, 
	mashiro.chen@mailbox.org, mingo@kernel.org, dqfext@gmail.com, 
	jreuter@yaina.de, sdf@fomichev.me, pkshih@realtek.com, enelsonmoore@gmail.com, 
	mkl@pengutronix.de, toke@toke.dk, kees@kernel.org, crossd@gmail.com, 
	jlayton@kernel.org, wangliang74@huawei.com, aha310510@gmail.com, 
	takamitz@amazon.co.jp, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280584-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[46];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,vaga.pv.it,amd.com,linux.dev,hust.edu.cn,link.tyut.edu.cn,alpha.franken.de,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,netfilter.org,mailbox.org,gmail.com,yaina.de,fomichev.me,realtek.com,pengutronix.de,toke.dk,huawei.com,amazon.co.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C48944C74E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:18:23PM -0700, Jakub Kicinski wrote:
> Remove the amateur radio (AX.25, NET/ROM, ROSE) protocol implementation
> and all associated hamradio device drivers from the kernel tree.
> This set of protocols has long been a huge bug/syzbot magnet,
> and since nobody stepped up to help us deal with the influx
> of the AI-generated bug reports we need to move it out of tree
> to protect our sanity.
>
> The code is moved to an out-of-tree repo:
> https://github.com/linux-netdev/mod-orphan
> if it's cleaned up and reworked there we can accept it back.
>
> Minimal stub headers are kept for include/net/ax25.h (AX25_P_IP,
> AX25_ADDR_LEN, ax25_address) and include/net/rose.h (ROSE_ADDR_LEN)
> so that the conditional integration code in arp.c and tun.c continues
> to compile and work when the out-of-tree modules are loaded.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

