Return-Path: <netdev+bounces-292707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNGhHBJQGGpMiwgAu9opvQ
	(envelope-from <netdev+bounces-292707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10855F3A24
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 828E93038D1F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27282370D6B;
	Thu, 28 May 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+obPDqz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyo9gDbM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3924169D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977756; cv=pass; b=MBUfP7nibtNI27mfdbeWCvV/JLyaNFVhN12SjQ/djAbh+9J5twEpoGHbmq4hGfJJ7PUHsdFX6Cl9fcJ+0LU73Gk7FQcI0jV1YCSiV0Cqd2aDcNl3/S43OtYe35hcuewdQYenaNUSFtVAWJR5KAhWqL0TAgwWAEEz9GZ8iHOdZJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977756; c=relaxed/simple;
	bh=WCINTFxmfL3sU4xVFntMQBv/3/7s4jrtCmibfDtQPIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPlPyELn+L4KLd6X0px3yH0T0O7SMos2deacBLuMT5gGe0n57whVhrM8Yb/3r90RpZMUU8KftQ78WgHwygC8DH1ujtpwUVXwjkvj2hXk2z9nzpIVuxSO6M9OUeBNWEC03sqX41xcms2u8dxRkaQqyt54EaszbGSWebe/tMFdcy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+obPDqz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tyo9gDbM; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779977753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCINTFxmfL3sU4xVFntMQBv/3/7s4jrtCmibfDtQPIo=;
	b=d+obPDqz1Y4NTAadRfX2Tb/TxSvYh5iSIC7zmebnRExwBdeGIYawyuXTbHAM2eaT+7bQjG
	epSfw9Ar5dblS4exG4dDYlSgfksBlc5epcodae3A9HsOIKrZmDfVgOjvNR4YCsblnb8b2T
	jtM1q4A4zLPDuzrvROdKZdIVqe3S7R4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-m9zkbh4pM7mhopoogcgVsg-1; Thu, 28 May 2026 10:15:51 -0400
X-MC-Unique: m9zkbh4pM7mhopoogcgVsg-1
X-Mimecast-MFC-AGG-ID: m9zkbh4pM7mhopoogcgVsg_1779977750
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a8d66acdbdso6134453e87.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779977750; cv=none;
        d=google.com; s=arc-20240605;
        b=dbqq2s6OuirTZ6g9DR/dF7hn27S/utAFNNa2JsFFvjK3Mu/Q/q7fMVQEt8H1a59XL3
         s6dHJYhmG7PjN1nJvUtbSJT41DHB2ygQFRc0hyVh7umgOdqgnCV6A8vAbrs8xpO2KJQY
         g1C34IQMWOZeEfOurLwHkP+U9l09iWUa1izZEbuu2D5mwDAZGR7V6xTCJnd+ykFgfYFp
         xgXdKFCMRioS1x1W8VoQhtgkUYJzDLdoevNOt9OHxAX9PlIw8BIvx88Wohe05qIS36cm
         0lXDxfIQ8dt83te7TbNGSDCrH0LtLCr7LI+QlYIBoCfbP88RP8d3cPbOnzd5HnuUb76d
         ye/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WCINTFxmfL3sU4xVFntMQBv/3/7s4jrtCmibfDtQPIo=;
        fh=gbeZ4pXoWUZSTt03PSZdFIYfOlmEs+Cu3GsHJ2Rubxc=;
        b=IoC14MzIUuwUHWTRUBGQM+Zvf4lVOdv7tm4IcXnzDPoFvrPEmUpfGcOgdH+tNVfK6f
         YOoEaKQ9s0s37j1t8adhcrgYJtiPzJFauJFfDmtniGnaJO0NS7GO1j53oX835uFX/J7W
         aoSdDUFhdOEAff5ZVnscli3K0SAIWI4ax0VNYx1hkHRKMd8+K9wU+HyBrysEDpJV79Xk
         +cBLxD5zKP1Llrh3Q+fUIWJPdNdmL2FhT85u1FW5sptNThmf5TOoqO2fJ1JSB7xA4Zl2
         Jm0duqx7hRtcpDGsP0WNwxgTeOdX4ZH+ypwxHsueijKub5FmA088YkAdJhzpaoXzCxQ6
         rC3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779977750; x=1780582550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCINTFxmfL3sU4xVFntMQBv/3/7s4jrtCmibfDtQPIo=;
        b=Tyo9gDbMA+YWKN8ZLGcInQxuFBrXBcATD48rdgav97S+UQmzNKu6ICWQVI+W3NjP/s
         KkHY8tcCB/Ujk9FUZ1KWEU6Fjh9ZHTioT8YHaBtgOm5h2Tt/bDfmSwPNSq24jbx4jpOk
         qc5l4qIb9yZITsPuOxNsoo/ku2G2OIb7AelnSFCePEB1sImxnL84shcDsOn6oRrv2bSG
         BbYsKHQYzvGm2eAf3dwZKLkktYuPIAPpnWrBqPLM8pT2Q+AMIsAEKMg6/OHZuIWTlgyk
         TpS3eEZsJ82diFg5FFb8rTDhMC+4Pyh2rVeb9iJ8McrpscsWaHCd26JMyLlMInsa3fxY
         e2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977750; x=1780582550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCINTFxmfL3sU4xVFntMQBv/3/7s4jrtCmibfDtQPIo=;
        b=orLNqcC+Lsxn3lHrxLCQIrVT6EPFTlx5puuljQlLzH0JFq50ZBw8YenOcvaKQDFVjB
         zU+g9rlB7YlEK5GKCY/x0NFUcktHKk5L84eCLrx1t2PvvZ5USvs8sauTYTU+wN/y6j6K
         f/ONE6x5fuIWFfR3wK7x0YOZRnoqYNOXRGGBaZfyJK5zcTwx5oGA/LGKT/VoYLV5BIgH
         fRRuOWQ7HyxrG/Ct92DtvG5GyHIZlrIytfTDWaEx86OrdRW9rwDupCcyKP/aWhbq6syj
         hkI+k2Y6FAYARy6Rms6RjLrlkzyv2Bxro4FEBK6NofOu6Ush5BtE6qDHUqcbAJWCfwL6
         UMlw==
X-Forwarded-Encrypted: i=1; AFNElJ85dTM4NidliwxF7RH+tFBr52hDa8zsU5I5RdYm8rby6VRxFex60fpsWmiMH2pOFCZa2IzmENM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKihmo+IKIsKGFf/Sux3FaeJodmDYv0BN6JHKNdagbHCN8qjJ
	T7SU6KzCQyxogAb3ffnrIww+74Tz5OqSaoB3YX7Vrojinf/YEcNIO56uxY/uQ9y+NzEB9nIyAVu
	Zb/VqlNPD3I+7zJXyVUAOzJdBOzEGgvG4+194ZTNyT/4CHv7859oUFDn6/rAJ2rUO47JqCJI1iA
	Za9aw1cSad10VtCotxoE0oiQdcV+pM3nKJ
X-Gm-Gg: Acq92OHQqWDVfTq8g5CwOx6J4acXMkalqsUqc+sVF9OxjIj+PVzKHO8av0RnY06J3EO
	BpjYJwRuk/1qxq1pSjcj8hHsCs3ISyHcfTwpb/rAQEhFj8ljSV78uz8Wg4i2cZbOdVQHx2SWmos
	/s4zYx7wmFGQJ/TJBLrURzDQQB7FnCQlnB+fDgWdcAiAzFvTFt65IcNyZEihsNGuCLR8CIrVMDc
	0dBHQLEighzLvyE
X-Received: by 2002:a19:f509:0:b0:5a8:87eb:b118 with SMTP id 2adb3069b0e04-5aa323bbfb5mr5931502e87.22.1779977750296;
        Thu, 28 May 2026 07:15:50 -0700 (PDT)
X-Received: by 2002:a19:f509:0:b0:5a8:87eb:b118 with SMTP id
 2adb3069b0e04-5aa323bbfb5mr5931486e87.22.1779977749776; Thu, 28 May 2026
 07:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135310.GC977@cmadams.net> <20260526175743.1f2c3761@kernel.org>
 <20260527010641.GA21073@cmadams.net> <20260526183122.348e44e7@kernel.org>
 <20260527215135.GB16443@cmadams.net> <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth> <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth> <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info> <20260528153202.14900687@elisabeth>
In-Reply-To: <20260528153202.14900687@elisabeth>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Thu, 28 May 2026 16:15:38 +0200
X-Gm-Features: AVHnY4IApP7IcvuHODparSrVLAjpWG5XbLoqDsjgPOZVg-TUUjj6l8XXpHkpmrQ
Message-ID: <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, 
	Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.25 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292707-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E10855F3A24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CCing Beniamino, NetworkManager maintainer.

On Thu, May 28, 2026 at 3:32=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
> Not a bigger regression, but a regression definitely, even just for 'ip
> address' or 'ip address showdump' which would now go back to display
> / save addresses in the reversed order for IPv6 (only).

One could argue that the bug had to be fixed in iproute2 and not in
the kernel, to avoid breaking UAPI.

> Actually, an eventually fixed version of NetworkManager doesn't need to
> know the behaviour of the kernel: it can just order addresses by
> timestamps instead, as Fernando mentioned.

If the fix must be in NetworkManager, we only need to parse them in
non-reverse order like IPv4, I guess.

> And I'm not sure how relevant this is, but if we revert the fix,
> current combinations of NetworkManager / kernel versions would be
> anyway affected.

Probably many, for who knows how much time, unless all distros
backport the NetworkManager patch. Many don't backport much except a
small bunch of security fixes.

> So at this point the only robust / complete fix would be changing
> NetworkManager to sort addresses as needed. Are you suggesting that we
> should anyway try to minimise the temporal impact of this with a revert?

I don't think it's the "only" robust fix. Normally one would think
first about not breaking UAPI. Kernel's UAPI is not great or intuitive
in many places, but normally it's never improved to avoid breaking
backward compatibility. Adding a GIVE_ME_THE_RIGHT_ORDER flag could
help too, but I agree that it sounds a bit silly to have an opt-in
option to force the right behaviour.

Then, the only robust fix would be to fix pasta and iproute2.

Here we know of 2 affected userspace programs, but we don't know if
more could be discovered in the future.

That said, it is true that this case is very unintuitive. Insertion is
direct-order for both IPv4 and 6. Dump is reversed, but only for IPv6.
Userspace programs won't expect this at all. Programs that do it right
it's probably because they encountered a bug because they were
initially reading in direct-order, and changed to reverse-order. I
haven't dug into NetworkManager's history but I bet this was the case.

In this case I would be in favor of not reverting the kernel change,
and fix NetworkManager, but I'd like to hear Beniamino's opinion, as
I'm not being much involved in NetworkManager any more.

--=20
=C3=8D=C3=B1igo Huguet


