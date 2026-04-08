Return-Path: <netdev+bounces-276668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB8vFoOS1mmiGQgAu9opvQ
	(envelope-from <netdev+bounces-276668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 032C63BFADA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44A30300DCF6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0D3502A9;
	Wed,  8 Apr 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njw4HuMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB33D4134
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669764; cv=pass; b=mD9Uf0F+zeYPz6sjs5WhvB7/V4owFFcsNnL9ZHs1lnAxkVtPAG3+ghpvjboeSkSQLtw+uH0dcIFvI3pgBurOWTHEsfb6g+7nFxSgTJSbTHcDicR3XlaqvQHmbRoWSQcyNzUZWZRC4e22lo4rv3Ohvd8jda8TuJlsAyJTEMkEZ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669764; c=relaxed/simple;
	bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M63vUEh0mk9ky8lRF/pPPd21RGIwidCXaNfLuJ0pUW4DoDeAXzBYiku0NFsyKG9Ftq5mIdRU3Cy6znxWT+vdnPchBYlspTDbaS/sN4x1H5IKu8aB7qDI7AR5crEH8DZnpRhLck9jbWD/eG+zawoUq46UPC/y84Ibpqmk+WEr7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njw4HuMx; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbb6c072f1so11536a34.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775669762; cv=none;
        d=google.com; s=arc-20240605;
        b=FNMHBNdO90pX3jzuTOrSjLyaAZlAWwOMhv9gz3a9ACfEgVK4kK8ymuLdH4BEbqAuuM
         OZoW02MsrvsqepJ+18LcD3CGLpNG6DwlsfQgpK528JenXJWXZbK9EJjM4If0pQIq6RMA
         StwwDAcDazyRDRbi5V1AwAV/bUp6Ibq6lZLgWGObUqS48gTT3fSwGviDjQJKOqb0z8xo
         yII1kWsab56LDMsYSNvRQD857NeDUkcc3eZ/+d4yfR2N7alHPtneRF/lZhJUgIWrtaNJ
         VOnB5d6/eTvQG/UclUCbO7i1cJ5MPgWbEz8TwjoTPVMQ5nGjqgyy4igELMEyGtPF1NLO
         9quA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        fh=5rTj0EBNEAGe16jmUrKiMGEwyt/4uLXcgSkOXZE9nzM=;
        b=bP3U/qxPncXqtYsbXo0TZYX3WqwrTSMO0+9YqpcSMPWsTncEQnzr9UY08Oh02Dqsgr
         i7pGxzDMi6gRDcOGSLAwgJ4H/g00Dj3Kgtlv6192xhKgqk6mJsDoYrjfiBVs3k23bVYx
         R1ZJpZJKEojaP5BIIZvdNCl32CCsZ7kae0kXbNsOTC1WdUXorWoW3+RDsDwZHfIQKEWu
         4zu+ZfElt3Z5DHtuWWZJKZtLzbZIA/8Z9uD3W2vRMeLfhXNpVdrN3j/yC25xD9rjgCmU
         kLSzGvf8uDnUtgmcxNRybF0RNHYBvvj4HW/R7x94MjZCEU2wQShjqPbyyjbJXKIB9eJx
         Yk6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775669762; x=1776274562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        b=njw4HuMxtsv/QsfaK/hV+JlfmS/9Rxv7xSDZdRaRRV7MH3tHyzlIJYpOJMmsFpN2pR
         93m4oHUNYzxUUL8jS1uaKr/aNp6DxYOZrC4LHJv5mNkiyU6B+34ItcB9RF+uz8xb9Qy9
         EawUB5N0too7FanC9vc59CRHZWvBrLYXyyNmjLVkDYUbNeVGG9JkDxybi2YiO5/H98uz
         KYezJoSQ9aB8VMX7Y7q5+4YFwNAECMXgYTGl6Ha4V+2jQcKZ608wl14TXqCpR99a+H2Z
         18Mvi1IQQt5AuO4+gWbkc8U/WoXwYeXa/CWjaObCIOs3Yk9CsbKfb66XMxjpEX2Flgrw
         yEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669762; x=1776274562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaJf5mzQGy70d85gRscVT43zgnA2ZshjO06oLmu9+Sg=;
        b=q0b8YixpOM3tGEcqHCcZWpfGKypbHIwIoZctBWWRXOQjUmgwpcbjcuIN8oYqkLODui
         en3IM7qx/RuVhbq2zPuE+azRqXGH2bnBC7VThXY+MLjdAtbBf2X+pPXzvW/AIDDIVa4+
         2UPcFVWAvBV5zjoMxp4zdImCKaXTG7LHQuNfQly+7X8AJhuVfv5R2nb4B/BFxWgJavMx
         xSPaBLkwT3ZHo0PKeOZVIpTGoTj1VAsqrszDd0Kc0CjSjdiokt3oit139jS9HjrWYWcV
         cy4zvW4lMqp1eJcNL4TLCfBGJp5OGa8EUaf0JJmydN5+YXWGV+k1e3kzoSNioCZ0XYCh
         UN2A==
X-Forwarded-Encrypted: i=1; AJvYcCWV7nMEDX4JOIJOcm5d5uz3MKGzCFgC06ZMTRDLjC4qRnCBtIER5jm9TJR9ZsB+TtmRW708YGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSGoKPfn+ComINjYHBEhNv1CCHYyVKYE/mpC4g3DWO0sy1WO5
	kSuZKK3iEEBgRjlAtm81Fbyol6Mct8EPWf0xNagkcHYKxu1cxEzL7bQLIS8P9krBwPRzJxpaaIu
	j8YYhxRfmlN1wAMRSU2WsT/RC0U18Mtw=
X-Gm-Gg: AeBDietiWLTPt1GT+FJd78BUnbrRZtm2ZUE29j97f7kgAOiw3fTFAH899iLlVPhe8+O
	Uuxos5ovEtgbQDeXwdijLPPDSUfXPg86kuKOmyyB9OBw/hAagvVRgSFCeOCGTnI7pchM0S+NnBA
	paPiQ9ITWGkp2EwEN3yJRWq/L5qsxqweE4+G6v46CxPMUjRQ9aYAXgvrncxIPJ96az0VptPGz2k
	dI00Afxyhuvw2p4mKpmkw6MG7BVmruR2g6OCkID1iuoqqChdzNUr15oD8jPRbkQl3gQAH5NqEgu
	QrBZSdgoH0MVkfrE9+12qdopufUxmIDOkY/HZQ==
X-Received: by 2002:a05:6820:993:b0:67e:d62:3d16 with SMTP id
 006d021491bc7-6821d237e42mr11887737eaf.12.1775669762076; Wed, 08 Apr 2026
 10:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403200732.497307-1-devnexen@gmail.com> <20260408170206.GI469338@kernel.org>
In-Reply-To: <20260408170206.GI469338@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 8 Apr 2026 18:35:51 +0100
X-Gm-Features: AQROBzA4BkTik_A3H5i7-wdhUsPm4frrCXgC-oXbnU0n_oa2ffPQRz-T3wexVIQ
Message-ID: <CA+XhMqzdEUiG4RHf8FbTZnS+dKwT+-MjEcMEStD1kA5Dc+d6VQ@mail.gmail.com>
Subject: Re: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()
To: Simon Horman <horms@kernel.org>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Shinas Rasheed <srasheed@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276668-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 032C63BFADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On Wed, 8 Apr 2026 at 18:02, Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Apr 03, 2026 at 09:07:32PM +0100, David Carlier wrote:
> > napi_build_skb() can return NULL on allocation failure. In
> > __octep_vf_oq_process_rx(), the result is used directly without a NULL
> > check in both the single-buffer and multi-fragment paths, leading to a
> > NULL pointer dereference.
> >
> > Add NULL checks after both napi_build_skb() calls, properly advancing
> > descriptors and consuming remaining fragments on failure.
> >
> > Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> Hi David,
>
> I appreciate that this is on the fast path, and thus I expect it
> is performance critical. But this patch largely duplicates code
> already present in the same function. Would it be possible
> refactor things a bit - e.g. using helpers - to make the change
> a bit cleaner while not hurting performance?
>
> If so, I'd suggest splitting patch(es) that refactor the code
> from the patch that fixes the bug.
>
> ...

Yes, valid points, I'll submit the v2 tomorrow. Cheers !

