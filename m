Return-Path: <netdev+bounces-259649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGeTNVXvl2lE+QIAu9opvQ
	(envelope-from <netdev+bounces-259649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 06:21:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22125164BFD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 06:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38268301455C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 05:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0021B9F6;
	Fri, 20 Feb 2026 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELt96fV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FD1D555
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771564882; cv=pass; b=k4E+HTYY1WVuLSYzQ+cqK3taRIi+ICanJsUdRCjyvKkkjraVntKi05dRiXLq6RkML5tjqwAbZK++aajomFrBUlNcWt8remGTFx0d89t3GTZ4oIswBY4TdjJIfSbrrfJsePcAJoS6Z45XYB45AGmv/L68a1hb+Mg7dcZsp7MoeDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771564882; c=relaxed/simple;
	bh=N4JPblEGnoyPiK22YFf2FU1LT0HEklrrgT9ldQoLmso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls79q3npczIUDAM9AnfyL9dZb1hJdXiiIz/zMorHVxxgkjdVeSA/75AODRypODtKObbdLWJJ+GbO0pzEnuBNe1gFmXwS6Eedieks7EeM3upJWfaLucTktqF7z9FxqFZyBHao5RHWMHAU2WeVCoDbFu6z5uPpFbtwuO3drmtJYiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELt96fV7; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8871718b00so274156066b.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 21:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771564880; cv=none;
        d=google.com; s=arc-20240605;
        b=Vs8Z1Zeolp+py0SM7Np40ep+HHFrNWfTYcDbJlF/antCQbvCnGIN0q/h8qayCDkgP1
         OR0s1fsK08ijxVfWynqEfJQPdpigC/zuTVfghWrVkj11tq4+7TYEHLVcpc5B2vNnXckh
         B2RKOfZ0CDrqICTXf/xeBih6i4jWyUjCSGnwat1f2cF/4txXOb8fNYyijsbaj8d43lTn
         hbMONlCrmgaYe8oiK8xhiKB494nXGapNtiZlmADUQgEAlLZpDrfL8gqMKlxpj38sMSZF
         CXOgH9UwP2/n3rCJiyzvmjogRlg+7g2aeYU7EMZbI7LHtrhX9z6NknIXVnArhr+E8Hdt
         45Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N4JPblEGnoyPiK22YFf2FU1LT0HEklrrgT9ldQoLmso=;
        fh=u0s9yshcN2rD2ID2ZwqGlIcqWqhbCrzD6r93v7EO1AA=;
        b=bc0/zWIKIzJMqevZZPb5yEfnZc+77Kx+/LB2apmF9AyrCY8/UVqYe1/ejC2otAV7KW
         V7WzYHzgi6XiGUQ6OiNWuhI8v6Pk71RyhjaiACTDdV2Wm8GfrGsV1nwbhPd4lfVi3RaJ
         S+he7KwEjgu/zF0voEL3mz9M33kHyCOHcLYGU9cvvLAU224tkXVgxDWzmznxEXN9vnhW
         txyzTaRH1A5w7lZxkgzu1HGxS9fSQubLFvlisJGMbLQQrQXX0ghzJXbEzucUVStDiVRs
         3Uh+t0FibZgVyoOa23KCaR7fmqGkHOA8ynJYX3yswRe85/9Vnb36oPhYnBF6zg/Jaax3
         j7Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771564880; x=1772169680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N4JPblEGnoyPiK22YFf2FU1LT0HEklrrgT9ldQoLmso=;
        b=ELt96fV7CXXILCXHwDSEECPz31cgM+jfd5oImEwPuOkCEMeD4xBQ/vVUWvl/IZPymf
         Lhjmn0IAkyiY91OKgcIcbuMD1K5WPVKN3stOt+8g56tzz9ULP9kSfvcRfBqvtuQt4eXw
         qaQrTpBBfU1I1KEe0WyyzYdpCuPrlIdVn7ZBKPT6B0ZbXGeG1ZMuVjpT6TLK3ii9Lzgf
         r+qeaCLvUbjVGNmROyfHJWclRzR74WFCdao3CqULfmz5rb856dFdlnlFE+19eIwN4zoM
         /Og9T1INnQWK2I7DEYo8XQhmEc1YvG8t1YVoMkmxSc2ge9821AYHa/J3phphXPYXKncw
         gtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771564880; x=1772169680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4JPblEGnoyPiK22YFf2FU1LT0HEklrrgT9ldQoLmso=;
        b=ZHfq0EdVCUTw+DFtnye/rDlYH0VugJw9tkJz9gF1bBSqHPScb7qoXy+T7yDk50WDCL
         KRvTtISWxs+pDkLk9nVkD4iCWLj+os7ILM8LDeZsqfOrXbW73hMgW/DyTF/wkIZgoMIi
         xOunaIEYdQumCWttdOZ3s6yW+hMGKaARH1mn72FveXb74H1HEj6UkGDeT51O3VIL4Wgo
         kWgBhy3Zup5KPWM8l4e6macuMv1bSXYIC1i+LlDMbBmarP/nevSmnwhse8BNMCCuSC6I
         lxWk1TA8MqmiJTiS5IGS+ijZCZiyjgaCqRVKcYeLnXpsF2JWiP5s6YVTkaOBFQGTDXkG
         wQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXC62Z9eqcm4JbNFXwwaKLVTl+xMMfoAgx3OmsCLCE4HnoiGvM0FEY69vEzsbLVJp1YHJ8zKlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwueU+O/p4CHblve4GanlajcIi+dD9eSz/wGALLEjOqb6VhfE8/
	o83fz8Ax1srzRkj7La4qp2hUrvdbpSHxKrrGKf0yAQ8OUGwuW0zUokPsXI0gua/WrBhOLjskyk3
	ZRWYRDg+V+M/YZ22RgMSN858nyAowU5I=
X-Gm-Gg: AZuq6aJGbXyKujp3G3MOhRGHpKugKUfQg+UrOiI5d6bEVcoGA8+0chkLKcLUB3iFpPZ
	WbTP8FBKwQIl/HOwQN4ArkSTPcqePqbLBq0OhgYk2mFVNwDXV2IWcbfb8o/0mpRKWcwv9fTZiKk
	2njHoLsWXpUnBsyZeylvGheFgVzvfHAcYhVCaolc/Q2txVy0w8mJd57W2c2TVRlDkAe2KJakJ8i
	IgMJv3seX9PX+qooz8wP0K0uzwafLwpUM/HZfYHMuHhRE///e8maa4x+RS7pTnjWgy+Qi8rZsKC
	6IhvkC/pJFlMqfzbbhLfeO+u4r6/szeXCdLdaeU=
X-Received: by 2002:a17:906:794d:b0:b88:5158:d10e with SMTP id
 a640c23a62f3a-b8fc3a3554emr1276957666b.21.1771564879325; Thu, 19 Feb 2026
 21:21:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch> <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch> <20260219121213.5b5ab0e7@kernel.org>
In-Reply-To: <20260219121213.5b5ab0e7@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 20 Feb 2026 10:51:07 +0530
X-Gm-Features: AaiRm50x0owFg4i1vUNImJ1k_0zSREB4p_jCFZHUBnq3cpqnsAXzMHSPf11TN8k
Message-ID: <CAPrAcgNP0av_d+Ai175QoEu5shjHXEEtObtqkhcnKufpHwHWDA@mail.gmail.com>
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259649-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,davemloft.net,google.com,redhat.com,kernel.org,queasysnail.net,fomichev.me,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 22125164BFD
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 at 01:42, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Not sure. Another alternative is to implement the long standing idea of
> having an async / sleeping version of ndo_set_rx_mode() orchestrated
> by the core. Because a lot of drivers need to sleep, anyway, so they
> just schedule a work from that callback.
>
> Then we can say old ndo_set_rx_mode is under netif_addr_lock.
> ndo_set_rx_mode_async is under instance lock.

Hello, I have been working on this idea here :/

https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan@gmail.com/

I am calling it ndo_write_rx_mode but if ndo_set_rx_mode_async sounds
better, I will go with that. As the constructs I would
be introducing in v9 (enable/disable deferred ctx) should be useful
for other NDOs that would want to do their work async, I am looking
for concrete use cases to justify this. Right now, I have
- ndo_set_rx_mode
- ndo_change_rx_flags
- ndo_tx_timeout (Few drivers seem to schedule this and it's under
tx_global_lock spinlock)

Do you mean rtnl_lock when you say instance lock?

