Return-Path: <netdev+bounces-215332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BDB2E247
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF84721344
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23991322747;
	Wed, 20 Aug 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="i2A8R9KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759829A300
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707145; cv=none; b=XuYC1KnzxnJwDwAtSRRFOrTjqafzEVwd9cXgM0Cg/LXtrZ9ozvZ4vAv7JIs+pkTOQwDKkHfRExgzTk4WotP6TZtbxXHh2nx8oHohen0tyvxj7xgqz4fQyLjeFb0//qSGh6Nu11U6DNC2XYSrQKF4McsAX27VkhWX3hJ2TKE5Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707145; c=relaxed/simple;
	bh=5B1GLC8V5li6rFlkZe1ZFY0nHNBS518l1eEK/Ae7SEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxU13Bt8OZKxjlbBGdzIfmxZaL8qUkhNjcfBeQZDt/ektGVRF0Hyk6a6ZuqyXCWdG7v1VuCAZ4dkbwvLRV97/AdD7iQqwqidaKMG7hAxzeLBQaDN0MqC8ZJ09Hdpx/B/rzlsDiFfLvs69QwTD7ay+U0tOE3Z0P/4iX3/x2EIWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=i2A8R9KE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so68682f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755707140; x=1756311940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sII6DYHZQV2ULO04/wAV7U72P3vMckfcIiL+iaIl0v8=;
        b=i2A8R9KEkpBJTE3nJM9+NbjTDZEfvDit8+cbpwvnCvo6WIwB60frZ/PS7/RUi1llkP
         S06hiVXOvRAy1MkPJwQcWb3FMYjnNsCZWX2E7oGpRn7bGP8ZxCXsuV0siKR09fhqojX6
         eMBE8H6Dl5KeJAdNGexFXXPAC3nSMiXdBaD5UUyxfFKqBfCtxz2AknuoI9wMaj0sOyZ/
         Pc+tdxYpJCU8n5IXkVmx8xfSCM7++uBSPA3djEjLMcl65ZNFtZ0FyrIVXU1Cv9A4fqEZ
         oSyyzwN3TeozK1RogC17rU+vn5v4MjsWJZ2vkbt5oHJYinSNu2y/CUeIs8XRMi0T2P7j
         2qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755707140; x=1756311940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sII6DYHZQV2ULO04/wAV7U72P3vMckfcIiL+iaIl0v8=;
        b=i/QF4hql8dF2X+uMO2S81F3Vkpd83Zgmn7UDWrUwL0KGGAPEfgThEM0k/lj0QpnSOu
         aXn0VXax5FGIDh4q1GsL0ZpGO+FjtMkyvVca/cBs8tDSiIeHl3P1ic8wuyluJbybI3TW
         Ki5HOEdiI5wl1dOSR/k5pefvuURbP+usXGl4CohuLj1GoQ2OEj4o/rr0VPkLTwX9jJOK
         4fOSOW9atvEo/Z9pA1WlVFwi3MhTetPsP8nE5yTeoo3DLKVpo+W1epvyWH7IIu4ZK6g6
         nq8S4hFemYR0Joe0lgcuK+n4YEmbx2iSvU9QOth1KAGGkoQ9IZvQPWvCsHlqj/vO4eUC
         maSg==
X-Gm-Message-State: AOJu0YwLNYr7safP9rT4XWKZ50ZbJegenGriUe0OueE4DugA7EH5QP4y
	fSBpaySY3MEbszf8mY4O+9imWDP/mF2kPBJ2FQP+SUgARJrWKNK9cHzColreEXdoK7A=
X-Gm-Gg: ASbGnct+r+K+hrK4G9pWy1PjnhYS7U+n+0fawguaFLDF+1uZYjNRK4WB1DIJ7XV6OGy
	hmrcP44PyEPUhHp9YA2ki0kq/qCvvHeSpNuAcDOclP+46N5vHhPK+Ud6XXanPvVi7StQolvDhJm
	ewwM40jwK/2d6SMBQ/2tFLgA/WmCtJj3VMb3DDfNYuX3RQWp4QQYJ1TNK9JU73JIpaqIeV6lSDj
	CKb4BuoclIK/nrWG+aizKLvTI7sTaFbSMMFpGKDh9mI/0FJQ7NUq/0r06/slxTsolwHI/m9awhy
	XiiOBlt5B6hJypfEaTZC3rieJrtEzFM062EGzC2BsCf3NBBxoPway+irw0z4igynvwsA1UK9Vmw
	odL6x8ppdt6seAaxP/itSYMBkzVp4/0+L0QXLDTK4yRhSS2u9xFRzj/7fny8SI7UwInnaexAEJf
	Y=
X-Google-Smtp-Source: AGHT+IF/Ok01Mse4X/UcDjt1v7X2C9fGn5557dO88RrFRL5gQ7Yz7bQZxPsEgdLkZInjbRJmBJLOlw==
X-Received: by 2002:a05:6000:2508:b0:3b8:eb7d:f82a with SMTP id ffacd0b85a97d-3c32da77724mr2530341f8f.3.1755707140321;
        Wed, 20 Aug 2025 09:25:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47cad24esm43298555e9.23.2025.08.20.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:25:40 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:25:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Andrea Mayer
 <andrea.mayer@uniroma2.it>, David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-ID: <20250820092535.415ee6e0@hermes.local>
In-Reply-To: <20250816031846.483658-1-ebiggers@kernel.org>
References: <20250816031846.483658-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 20:18:46 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
> index 6be1cc54..cd8c5d18 100644
> --- a/man/man8/ip-sr.8
> +++ b/man/man8/ip-sr.8
> @@ -1,6 +1,6 @@
> -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
> +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"

NAK - do not change man page date for each change.

>  .SH "NAME"
>  ip-sr \- IPv6 Segment Routing management
>  .SH SYNOPSIS
>  .sp
>  .ad l
> @@ -32,13 +32,21 @@ internal parameters.
>  .PP
>  Those parameters include the mapping between an HMAC key ID and its associated
>  hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
>  packets.
>  .PP
> -The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
> -HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
> -The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
> +The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"

That implies that newline is part of the pass phrase.
The code to read password is using getpass() which is marked as obsolete
in glibc. readpassphrase is preferred.

> +that will be used as the HMAC secret for the corresponding key ID. This
> +"passphrase" is \fInot\fR stretched, and it is used directly as the HMAC key.
> +Therefore it \fImust\fR have enough entropy to be used as a key. For example, a
> +correct use would be to use a passphrase that was generated using
> +\fBhead\~-c\~32\~/dev/urandom\~|\~base64\~-w\~0\fR.

Shouldn't /dev/random be used instead of /dev/urandom for keys.
Also, I would prefer original author evaluate this

> +.PP
> +A blank "passphrase" removes the mapping.
> +.PP
> +The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and
> +\fBsha256\fR.

