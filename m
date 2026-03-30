Return-Path: <netdev+bounces-273195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJwnHIJ/ymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76235C4FF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7483037EC9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C43D0930;
	Mon, 30 Mar 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8f4jU1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2123238150
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878151; cv=none; b=mYdVAjGgnr0XKE0wmllN3O4moHuw+MvJp+DnbgtR9L4ZXc9R28jF9MZh3SNvdr2UZMQUC94gvMW1s64rYd+wZo+7dDTyHXl+5AqmmA9eDe8MhyvfO0mEg3mPdqa0Seucw3CKDhkzrgNrXD8QTSH18NEohU5QG5kvP5H0s3aelqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878151; c=relaxed/simple;
	bh=OxeMDfIOeJPo0liFSF+iS4Bsty37kddULdD/aIXYKGE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DGD20JVL+kvCtwogqkAI2WnrxJPCK7mxyrqxGK5q6OHCU7kBtgXSGhZTLHZyM/sKt6RjmzQ1QmnEXZaRLBhz0djhwKdVgS+viDUkT5bcfzPBpaq3mGl3GV5btkj4w3XHgCaRMsImdlvfRte7kN7cpGIFh2IpP2oC4iHThK1ioBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8f4jU1z; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65003f40a22so4295542d50.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774878149; x=1775482949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dReUoPRdYJoj/PVvzy5/qVwqlhgJ0D0SdiCFOdc0j84=;
        b=P8f4jU1zWYaPeg2MbgI/MgQcMM4Di0TOPJMh+/7IXFzaq1Ve+FGzdTgr31JvePwvgX
         j4L14uLya5lWF/Bu+aQzl/q5WzLnPg5WXC1xuG6SphyaD0HH6HtXRgGWXeeE4x/SNN0S
         5OeSSorGYaonjJloIR3LOT6t89WXqT0y6W4eex8Eo86VKYJTg/ZnGSDUcNpDTGNj6v8a
         RmbOVWQccJisKLHxwG181MKNxehwD0akU6h6a+SnBeKOKmwhwjkcRjKLnLCapcokL/Rj
         4iqdNqqhoOCPz/bmy0/Bx0k/kC5sHmKXud5kKyNjjxhq9mh83zxmaTw0dYKpos8SNGhY
         XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878149; x=1775482949;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dReUoPRdYJoj/PVvzy5/qVwqlhgJ0D0SdiCFOdc0j84=;
        b=BJrm9gbnpGu3YZDw/rzO1n2dp9JH7AsHtaiqTJ/l/Bk657pC1FTioiuKaLTIA5a/aP
         KZS6aYXOQRcFV7kH9PTQYIPtW2DkLlNiK1Sh5T2nmBWy5XN66xR0IN74YgIwkQZG5MOl
         3qC/asR5KncPN7acPCmEGjYQo/huGk/AZ4brmI/+dasfT3Z6PX49CHclEJ+Xx/2q9i2q
         8t3XD3LypETXs7iKcncX4VMsTkjF4Y3hsZpKZ4dU6p77ijA/iz/VIcouy22qj+GjS991
         kw9vKQOkDn7PHeKdUt5KtWMvUskv2jR2TrxHkjLrO+yrO3kAUjuPInNxZJfYIsA0G+ES
         DdgQ==
X-Gm-Message-State: AOJu0YwjVxa+2Wz0lHmgY2CmxW+zIqPj0oEevAOegC+jPTxh5m6FvpN8
	jb05hsCsBBVanRzO9FnXbeQ8A8gD6J0dBtH/Z219ENjR+IA8pgBeskCp
X-Gm-Gg: ATEYQzx4GQgVoykxtUDrn+TfVZrKktjYw0y/9kX//l02JbmW7hJfDmHeTvwd9CCDZAo
	VSMqBrBlQtbiodbGqvEkKpWkbpOtawQTnV+kRvSkWiZ08E4s91JF9NEHDQanmLgKMnD4/qLzD+e
	72DZiKsn0h/VhtrT6+N62R9DB86EnI5iPgeEYVIeiNae5I+BFo7F7/AIvGp597Sc3j2XH1op8LS
	4XCqcUzgcPyCVS+AS8cEq9L4QuAL+PmujM7ZaCWJ57HZ4mRph5DQc63LDBM6jUPm278KlM+LHeL
	dyb0eHDT6cSAon0yolFTEkhL+o55L9ge/BQnsElkvvEAQEwsd7GN434+OSAt3qXy2STGqawCDP6
	mqSwN7ok+/gCZTAPNJ8NkPgCmrnxybj2ZIQ5+CzmwfOgvKeM64FR60H5tZD8exBJZukztQ/ZcKV
	HsQpjx8yCCMN+FIQP3RULdy9RN9iHG8Jos2H9zd7I1ANXRE1jJR/IrC/Mt8iLsnlzKB1j7jao2a
	6sm
X-Received: by 2002:a53:d005:0:b0:650:1bc2:7e13 with SMTP id 956f58d0204a3-6501bc286e4mr3068003d50.7.1774878147225;
        Mon, 30 Mar 2026 06:42:27 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65009200901sm4033085d50.1.2026.03.30.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:42:26 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:42:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 maze@google.com, 
 willemdebruijn.kernel@gmail.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Message-ID: <willemdebruijn.kernel.15a62f8f2870@gmail.com>
In-Reply-To: <20260329180428.2657785-1-kuba@kernel.org>
References: <20260329180428.2657785-1-kuba@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] net: clear the dst when performing encap
 / decap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273195-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC76235C4FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outermost
> IP dst.
> 
> Make dropping dst unconditional for bpf_skb_change_proto() and all
> L3 encap / decap ops.
> 
> Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

