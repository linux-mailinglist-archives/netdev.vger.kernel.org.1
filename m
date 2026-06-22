Return-Path: <netdev+bounces-301146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTMMLeFROWouqgcAu9opvQ
	(envelope-from <netdev+bounces-301146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A330A6B0A45
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=ssAA1Orp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301146-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301146-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8BC03005147
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C236BCC0;
	Mon, 22 Jun 2026 15:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225B3115A5
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:16:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141403; cv=none; b=dmX/y+dn7Fvg9SHBxaT9v79XVHuD4Y52Ppi17s3SKvIbarXJfVs8L8HlcyoW8ge1JSPRCoiQvJZZME69babQRIeHcf9U/vL7wE1lKF+rKfanMRyHBewsgjaluj43LHZCzV0/fQ6wJIu1CZ7dVeX2LuDrIrJmfSZm7LkpR+6vL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141403; c=relaxed/simple;
	bh=PWCmc/DdPAE5lPB2uaC4mtjlfAaJCmrx11U4XqZh2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcaxUFCDELqNUcPSTrEGImKdHOeLZNxnpnD4OTi6R4/9eZSNR8J7AKU2H10zCXrILm7WkITzzfx64KwW5TwV16XQIb/9vH5Ftt2GoRi6XX/L1qd5ccU42wbKSTBwb4S8nEvUPXcr1nrxuuLbk2FV/jS4qQvUejRZvcIOep+nzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ssAA1Orp; arc=none smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13986d61b4eso2232646c88.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782141402; x=1782746202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgOrnmcuB5V7BaCB0ix+VInIkmj4v7YUlopcK+jt50Y=;
        b=ssAA1OrpCvBlBQlR9twS+Ds7fAHKgzadlBRYxB2bGtzIx1ABopNADBAvFedHdH7FZ+
         CG4xrO6yOC0S9nUmSia1Nh/vqSL4VZG0XFXC120Fhgyz69CR9r7ZZrz/atyvDb5rRkb5
         K2hpR1wvwLm0uYXq+dSf64UjRwo75Imxpeit6XYTuwTVMeQEcYebPgdJVwAuQ0kIUX+G
         9LFQ/va5vpxsWlLMefgmS5OCKwH+hf2zdKnNlU8r3pJh25911pGDwXC37fWTjkJwTIPY
         7ffXJLzHRnu/x2MiTvEEK5BvHMTc5O5vV0K7aKSz0SkgpQ65OBSmW1bKcKiAmLX7wXjl
         fyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141402; x=1782746202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgOrnmcuB5V7BaCB0ix+VInIkmj4v7YUlopcK+jt50Y=;
        b=ijVAE1Sl+3MZq4gYsXSergDELeS+Ja3DxzyqNJUmwyKebndQ+Zb4qYhgiN7mlZGSeN
         V67HFWWOB3a+tcadMpOq0g2uC0bAbLjjIwFMF0Vt5F40ON1xoAcO3eVG2dyoDtpdy09L
         JgJ0bNX156qq3iGXcLU64AAhuXSBMvElpVMyEiTnU9bk/CGullPQiaZK4efYbmaDPLMP
         O4Y1VSL9VfxHL2e9GtWWlRJlvHD7fWSwQZkB8ms7+c//roqDTsFmwf9Gl5uT8f3k2KL3
         2fu+eZj1Svn0PeqizoseCCTKopXLpGGZVpQ6LLNiDrWknb1o4PkX35elQqiRDh9Ge57S
         P7qw==
X-Gm-Message-State: AOJu0YzGdXRsF4r5IP01VY1ihBdGYrdqn2b5rGdepFUyF273LuFf65Nq
	5xFb97nlyKUzFGGZLXhXNcRE8S/bXP0zDFCWn1vUtysyxIISEpd9BKpp7GN72IGh05HQDN6HnEz
	b46oI
X-Gm-Gg: AfdE7ckob3osMDEu0as+pV3tzhpOHZ7SajI/uS8pCd302Q184v0x+lJFJwBElm/ndLn
	4GXLpDHhjqAqhhUQX3x3ueKC8QjCjOTLP9Wy6otpQ/5ygq/46mzHmScp7ucZR80olduKUDl/B6Z
	sLIAT/9zxt0L7A2g09m0+Z08wjFN370A7FPxCAgDe/U2SVslzBcQtA+qb6kcU6ZIRSZzpXMjmB5
	J5586lZLdRnFHXqaprDcNDbtHPWSh1H03yuCzVfp93Ictw4FLpR3BMRYmPLFzNcYeAnDuom+THs
	zb1oFK6/i1c6j6hioZn2npMLKCGhERQlEUU67zV63HtUJ7mjzFbfG6uTxQYgB9ddcVXWFiAd2mz
	w2TAQlNk/aMfx1kNPpQ4Zq6iY9NJ8V8A88sQt1XtN4GoS2pHTwMzGQTnM2q1u4MUzPEmEIKfALo
	Mdyn1b/j/2E/w7GCGq08ltorXIhF7vEGOM117GY5gMRAZ/WeB46sAiGGzsvKWxGJ/7
X-Received: by 2002:a05:7022:911:b0:135:3025:be5c with SMTP id a92af1059eb24-139ad7113e7mr6576762c88.27.1782141401480;
        Mon, 22 Jun 2026 08:16:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adca1b00sm7758186c88.2.2026.06.22.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:16:40 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:16:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rose Wright <rosesophiewright@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip: return correct status from help command
Message-ID: <20260622081637.172a6bb8@phoenix.local>
In-Reply-To: <20260621180311.8374-1-rosesophiewright@gmail.com>
References: <20260621180311.8374-1-rosesophiewright@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301146-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosesophiewright@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A330A6B0A45

On Sun, 21 Jun 2026 18:03:11 +0000
Rose Wright <rosesophiewright@gmail.com> wrote:

> Currently, "ip help" or "ip -help" always returns an error code because usage() is used as a fall through on "ip" and defaults to stderr with -1.
> 
> This is a minor bug that breaks "ip help | grep" and other scripts that rely on standard exit codes. The fix is to pass the status code as a parameter into usage() and change stderr to stdout when needed.
> 
> Signed-off-by: Rose Wright <rosesophiewright@gmail.com>
> ---

This is the closest of the three submissions, but there are way more commands in iproute2
than just ip. Need to address all the commands. Looks like perfect trivial job for AI
coding tools. I am looking into it now.


