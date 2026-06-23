Return-Path: <netdev+bounces-301463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0sltNv7WOmooIQgAu9opvQ
	(envelope-from <netdev+bounces-301463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:57:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BA6B98C8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GjpMQAhk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204DD302AE01
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8028B359A91;
	Tue, 23 Jun 2026 18:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A1348C42
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 18:56:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240990; cv=none; b=a6xuRlSVU5blnPLSBLA/034I2dZWA2GEoKjlX8f+8we4vPoNNP+WB1fLCKgSrCCY/NQISo1u2fbbqm1vJJJ6D6FpnpGUmpQG/36yxz4fQrCxV8oxQNoavPPrpkyTOa4a00G8azi0q9e8zl1Rh+BEc8AVnanmIrDlpMax+YNCUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240990; c=relaxed/simple;
	bh=24Dn8UqRZ1p8BQICezHYOo9NJl5h5GUSnVLscYJARrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqkN1iMxkck/PLPAr16MgnmPFH6NI5iu0Lr10jWJHwA026CFvZ2JYBdRiSuolbiw5sVLb0r0wfnDhqRKsN3qIHdJrVhnSUzCz8liwJMV7Hn6tgdzOXCuU0dbhgoFJeRIigDtIE3Mc6mV4Ir8zhHv1CszBdqbNN3iZPPNrCkXk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GjpMQAhk; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso435114a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782240987; x=1782845787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=GjpMQAhkhcE8X4RT++ptLx82xBK1oNGSa/InTX9Vzyn4cK/rWE3Dy226VmQ1csGENE
         4IP8uBlPo7j8O7MVdp03bntvV/2cT/lQtVmj80MQFtZ4M2dIt/KyfcaweKLuCJ+3DisO
         412Jt2KYWBLogZEBYNLk8k6DwvQy3QG4my8QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240987; x=1782845787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=JjeK8/j0ARyXLfGTFDJ975tyv2czzs0pn2Y8/KJygfLlX2G+Pjep24vMa09u3jBJDr
         pWex3E8RJIyXJNazuSg4X1U4Rb8V0VbcExWsqEBtOoTuQc7Y7Ud1VDP/KVua8eFuGWVn
         zN9wb1+wkphBGTKQAEQkNhajEeY1NFMxCx0pSMISG43XY+6WaC4HsoaTxrovrSg+K6OU
         4tvZG2UnlLyHuVjfjsJE6/IooY7BLUZih8OFXUaFhoy4dQvyLCo3GwGRrnXoMxGFiCRm
         +L83hgkV/q9wncIEy2A41fjq0Uu/kshVndTJD5UaH+CC9gYr0NqfwYWVkYI8e7xGOthx
         am3A==
X-Forwarded-Encrypted: i=1; AFNElJ+VzpT92ycu8CgyLNSD6WE7ALrYOKlS1vTkLKTVelJouCiJPoY+0r+mDwB1jrOL884IwihPoZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3iVwB1C1Hyzsd3ImRWHgU/IF+pWy+0uN6YIPrvM1Su6zvOzj
	fGo/PssbbOJ2vnmZfEza0gl8TPnF0vOk2pvX0Fg3MLY3XR27Wv1wcVBgeBkP4vtYv6bNTz10EKd
	S8FIVuqs=
X-Gm-Gg: AfdE7cl04vNF0BN4plVNdnJMu+N84LiTx3wv/9AnZrACfMo/CFi/KrKtRCG9Ssi2Z8s
	KTCXB8KgE2PmUldnyEblgCZVAAYqwPsAccJLUExDiZIz9IejbolXEdPXQZuBEH+NccETGm45I81
	O8f2L14+fCpTemWbiDdfuNkHa3Sp/DMZmQZf6PPTY1dAMJOLNvZWwOvotfO8HpRVblf76Cx21Xd
	p1Bk38sQlDQSn9X3fzQRHMJ+ddZQ88i33f6N7PV62uVgIRqxRVLzHG2rNlmY/YRRNy7N2Y4Vzfk
	biQ7oQ++eaoY8OZDm8HPjvbZfQ/tn9wPbknqEW+8lHVUj7PExxN73jD9i5zJIuRiq+5EMWdDRqP
	qb2gwRNvQ/JZpnKVc9M/BvulVhW2dL/Cl7mMbE0wcAPauPWEBdq5Vpc7xtURakpyNgQUSaLjI9i
	MpShQLHUGgvntsclxMiHj1j6npxrb/3RjoJ+P/9IRdMx6xPeKzn3pSZgcK7AdAXQ==
X-Received: by 2002:a05:6402:26c9:b0:697:96d4:dece with SMTP id 4fb4d7f45d1cf-697d42d3ec1mr2653628a12.2.1782240987088;
        Tue, 23 Jun 2026 11:56:27 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697c1ec13c3sm2566692a12.7.2026.06.23.11.56.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:56:26 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c029505b389so230349266b.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/xLuCPAwNhWBkGClKHM8mDmlaPr8XQRmC1OGFOxd7vs2hN9dHsW9IGaXdtoMgFLQl7jgbFT5I=@vger.kernel.org
X-Received: by 2002:a17:907:c207:b0:c11:8357:40f with SMTP id
 a640c23a62f3a-c11835704bfmr15229166b.2.1782240986490; Tue, 23 Jun 2026
 11:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430011544.31823-1-ebiggers@kernel.org> <7d08a6df54279e9915f5df6bd4e5e5dde52b4fe1.camel@hadess.net>
 <20260623164932.GA1793@sol>
In-Reply-To: <20260623164932.GA1793@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jun 2026 11:56:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
X-Gm-Features: AVVi8CdpFGqem5dP7mBI1VIDKVc8WIWTZWMdjSeug8fejnSzLkFpq4QaapJhuLo
Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-crypto@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, ell@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301463-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:hadess@hadess.net,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-doc@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:ell@lists.linux.dev,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[hadess.net,vger.kernel.org,gondor.apana.org.au,holtmann.org,gmail.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 579BA6B98C8

On Tue, 23 Jun 2026 at 09:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> We're aware of that and are taking it into account in the allowlist:

Note that if we can  just unconditionally make it depend on
CAP_NET_ADMIN, that would be good - independently of any allowlist.

Because if iwd and abluetoothd are the main two users, and both of
those already require CAP_NET_ADMIN anyway...

                Linus

