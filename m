Return-Path: <netdev+bounces-298706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgbyBr8nLGqRMQQAu9opvQ
	(envelope-from <netdev+bounces-298706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:37:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430B67A8E4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:37:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WiE57XDJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298706-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6017A31E3768
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6233F399;
	Fri, 12 Jun 2026 15:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90440392C57
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 15:36:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278566; cv=pass; b=ncyMjjVMhDhzL07LRq0VKaqHG2mCd7PP4aYjGiwMfTm6Z34GcZFHIOgzr2oxBNFQtyydW0BoThot9lNRKbTj3w9M9OIEOg9VFTuZJN5xxYCbH9jN96I8opfsS+HMl243Uz3b+qdeKoNXEfjgpcyE1Zc7lko7u+dSKIAM8HjIwpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278566; c=relaxed/simple;
	bh=dyQmHhRmUxRk/ewrJ+8l2Agq7OnmlXrg/EyyK+vOCYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6oTJb3IkIiBD6uF1Iqx3lEi0rg2WvV5xZMDhF9Xrn3wIWUCOwPCmW76VAhCmbzn1ORJCg2DcgbTBNyaKriz2sbv6ouWO8qdGOVrjx2RRukHuSEB3Dh5WFFthh42ZFuZmCEglcx1W+gkFkteG5boAHVDmi5yMkSalLHk9qZn4Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiE57XDJ; arc=pass smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-befee9e5ef7so136103866b.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781278563; cv=none;
        d=google.com; s=arc-20240605;
        b=F0bgBxVMs+CFuWKO0x66bR8GIH5e5R7uH39z7boE5X2XDrmgyfnM1OLbPj57yCARu+
         bjWldXyHtbEugrI84YWLQudPQLGGWHBHvdkwCSU07RXtBMKHwG749PY0rq/47AupF0P1
         z/30HrKw36mYlxlOB3x+SOe2tgoTYy2Y2xWhYhA8ZD+Zj26CSLlfEfaTTpCpDrQmLoib
         Q5dfG4lrRjkgWTH8QRh/FHVWiNFjT/GbGdEhiPgxqDrEAYKljHBpaxcWOXQatbsLr1sF
         vSrYf7OlUhCNrIZkc16nl+UojVibbkpyxgno+8EQ+aiIUH1uC+pdtt3vKPSJW12fYxd3
         ftsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dyQmHhRmUxRk/ewrJ+8l2Agq7OnmlXrg/EyyK+vOCYg=;
        fh=2hK2yNmcLiWfUh6i1gLf7IoB23DuF5QQZOiBM6ZR334=;
        b=QMmB8SMarAXqNp92TIWKVK4qbN/MhoVsq7jtnwh4S5r/jS71NTpOkrAmBo+5V6NNE6
         bIEG8ruXdItAyq4aa66Abu1NDFq9hEDFE4jqvEQVywNR+y/yFRgOGSHRokF76t7VVhYI
         SzPBHWv5GR1w3wN/RFIcS64EZK/fKfOvuNtKdbZQAtH4mI3Nw9YGxLcMUJiu3MYcF7xb
         oSsRWGQ7CeejhFXxQkVQn3GArtI1EPnLRLHYcXcjhQyuRlyscpj6uidNOwrFM29Nj6cO
         2W4AqnDvGfn+iU+qnv2KA5ciqgUOQ00pnaODN+oY4ChgzrWDowhA6fKP9wnHgM/1g7nh
         RNKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781278563; x=1781883363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyQmHhRmUxRk/ewrJ+8l2Agq7OnmlXrg/EyyK+vOCYg=;
        b=WiE57XDJBUWPenVj0SQAHt9PDOBGXtJGrbbrukMniSjSj8l0Mwp6K5wrg4FQfYr3VA
         SyjxljMqiB+n1bDNZwINelaMVEpHkysm+aKzpPxKfqdfZ9jduPk2ttk2JuVAVbe90qH5
         V5Y7XCY1YFs2rzGfHWUgzb63ligml0STODSRe8r5XAMU0zUb5H803P4Qs0yDVa89+/wb
         85o38Gnyi3YoLzG4pYhasFrjNkrUhZA6ay1ujoFRfwjpA6i5v5H3TdSQzSCti1FAEPAn
         FHwNKODLF0i8cfxljiSjIuSMhmdS/kWKo1bdlnn6nSgjLmRiM5E4BY+nHsXWn2qOfFxy
         ZPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278563; x=1781883363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyQmHhRmUxRk/ewrJ+8l2Agq7OnmlXrg/EyyK+vOCYg=;
        b=XI8mskHz/XeCGbWUBL1+yarLFPGl0TP5lRVPuZmtxLbHSwE5BsNis3pKUXN76DXutt
         ouRZTd/7dVlJd+Aek49VJV3kqQ4grdhW2pRFqCkiPkgU0myDBAAk3DjFDnjCPE6zmXq8
         b3Ir6ExuR++Tn6ltk8cUtcdr9HYkPNF2yxQktJuEBk1XIxQ424VuzWhkxnzES0jokKak
         53XiKi/DydFbWBHvmc71u1o2wOvznlZXB66hoPUu70oHM6XQ/s39FGZZNV6f2WUmlofi
         BQw8ObRoPtq/oZECs3Au1msDHYwqPLFZW2pMHb0emBGDMd86LdIs8C+HkqqNpndkSfkt
         XwGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HWIOj4hZh1g/YC4XvOp69ESy+5oF0fLIoN3Gkdi1kFCoxw4goaUPA+ZWpmRTLx0q4jww3Ixk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeAjRfwHQRkLaVfXph0Ve+koUOchZegpglg6fvtgoq/ybryYz
	D9x3uffGqGp4pwl9POHtQq2s5JKH/9jU/La/uybQXuAlyCfkslF53BQhR6b4r9tAGxOfaIn1yYQ
	mzEOjIhWXvrdvb4kpYWjj4kf60gqHUSw=
X-Gm-Gg: Acq92OF6z4gPlM72y17dNIp5bFIG5LWgqE7KcPg14SKoN5oZW/WHz2XKMZl+O65iji3
	POeMMMK071YKQ6dyb9Yi2lD+W0prpiDEAB77enr195zmXeGE57uaVfpa9+FQ46NBYLJ9/KASvQf
	FjzqPYV7bMwweFJDHbsffpRm78l1bW+VJFT7Cnrr+dHinRVt+jJUqw+cic5+mhRlc/OkHhQee3f
	z+wYMN/kSDc2Q1ZG3GqUUjq3u8ENX5CvSlnpiXqJu9vESVo7GzEBQKZxjiYQ278KWigOQa5ZxFM
	lhD1Kime
X-Received: by 2002:a17:906:8479:b0:bed:36cd:4f35 with SMTP id
 a640c23a62f3a-bfe27e0b312mr120377466b.1.1781278562764; Fri, 12 Jun 2026
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608165546.61347-1-dbgh9129@gmail.com> <20260610083544.0da95356@kernel.org>
 <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090> <20260611104547.22cedb69@kernel.org>
 <CACrCO_UAjAdi3K7y0nHcSDoCXaZnZRCZ46b3u3vdfyWEY1GC9w@mail.gmail.com> <aitnzFHczBlsY_O0@rkannoth-OptiPlex-7090>
In-Reply-To: <aitnzFHczBlsY_O0@rkannoth-OptiPlex-7090>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 12 Jun 2026 11:35:50 -0400
X-Gm-Features: AVVi8Cdco53sA-ybYN3clZiAMzRdM2q6gODr6SQaddqL33q7DGp_HuYBQTof79U
Message-ID: <CACrCO_W513d_t+KAmUO9D3NNuOGza4=FT2xqnMoo2EhzUACGEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks
 in debugfs
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sunil Goutham <sgoutham@marvell.com>, 
	Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nshettyj@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8430B67A8E4

On Thu, 11 Jun 2026 at 21:58, Ratheesh Kannoth <rkannoth@marvell.com> wrote=
:
>
> Thank you for catching this issue and for posting the fix!
>
> We currently have a large backlog of patches queued up to post upstream, =
so
> there will likely be a bit of a delay if we handle the submission from ou=
r
> side. If you have the bandwidth and would like to post this (passing rvu =
object to debugfs file)
> yourself, please feel free=E2=80=94we will gladly help review and test it=
 promptly.
>
> Alternatively, if you prefer that Marvell takes it over and posts the
> cleanup, we will definitely include your tag to ensure proper credit.

Thank you for the clarification and for offering to handle the cleanup
from your side.

I would prefer to wait for Marvell=E2=80=99s cleanup patch rather than post=
ing
another revision myself. Please include my Reported-by tag or
otherwise mention this report when you post the patch.

Reported-by: Yuho Choi dbgh9129@gmail.com

Thanks again for your help with the review and testing.

