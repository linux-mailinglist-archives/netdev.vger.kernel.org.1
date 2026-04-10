Return-Path: <netdev+bounces-277271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI4HJHWa2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:36:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5EC3D2D59
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 991B03008E05
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CEB387367;
	Fri, 10 Apr 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UR9UOcbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C795371896
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802993; cv=pass; b=i6Y0MVJ10WYmDSNJrFZCfxzWKLTAAlzTNwwFNJsONND5iojsC6no7vu81lC7tXJR1CYT4zh29r32f/oXu9GqxNoN2cYkhWWocBNQtDk9NL8AJ43Pmgt8sqQ4tG6dHggP2tRTiJOKhNFAPWkyQyvVutjtxtRE2fUHbvF4kfPPE4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802993; c=relaxed/simple;
	bh=ncvh93jAnc+Kh1Rm86nCGET2vwT0AL0foIduL84AyF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqvHvGHBPtJhsmxCWJcEFWrAiYHJmy4JPeDddcHdJq9Goj1lH9mALhE2jhzksZXzidmYyGDvafpXvm3Mdq0z+9coBbpMOjbPyn1Ui24+Gd+/LIoIFBYb9ckG6PHwKikWq5NLM5efOaZ7Bz02jpZVsiejWSYCWxv7lCHISBDJxwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UR9UOcbh; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso10976398c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775802991; cv=none;
        d=google.com; s=arc-20240605;
        b=Xmo3IzXvE4hY8B1bxCgOEmTrvd7zhkaVGUibothMocBR38MXuXyc044+k2te3pBMPS
         q2vaTudHdTE4yezTTlEb+0kb2rAe4KViyrsFK0B6j+rZI20Nu0659izASZZxfMQBjhZu
         ee7VQ7mdlkRMu3qtzyqpRj6GkmrNIByby8qq1/t/l23hWL8/kgMwPX76O6ScK2jIhpMX
         NQ1bRxlpZbqKSCOUh1erY53pa4faTarUxVI6lryHAVGhbTLiJ9P6AsZET8McVhEIDZcM
         tli7vi1lq/ZGuJH4QgW8gtQbzp5w+zZckdj5nP5EwEmaobW00wB0m7k0tb3nVx+je2m4
         XzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ncvh93jAnc+Kh1Rm86nCGET2vwT0AL0foIduL84AyF8=;
        fh=izLNP8uZrs+6xGL3Wwj3PRVLrTep9wQ8017H2lmEY+I=;
        b=MGPLW5/sQDJddStAsxb0iF6nWN2EhJqT1Ht/NmveZoTRSI0R2uNagOYcUVk44KXBJH
         OL86Np8BCON/V0sA5LSi28jmyzSd2cjYqfFw/MjS1NAmuTXmHDMLgpyc82hLemaCPhAx
         gwJ+wkJxO0yWwUJ/tkidGKH7dPG5TDHEDlupCw+DE5JuiXiGj1ceBukCi1oC4ieBIATj
         ybP6mB452VPZrJ68VSjVDGs8p7+BdzHe1rNXl9V28Xg335Ga6M1H/X1GNmVpj4EL6VeF
         EdoBu3Olp/2dvcvcOVeacoxqTR9Nqq0bktHSUBfD/KJnfSbyWKC6DptkIJiv4acGSxXj
         9nxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775802991; x=1776407791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncvh93jAnc+Kh1Rm86nCGET2vwT0AL0foIduL84AyF8=;
        b=UR9UOcbh+qTOKCldI3OlTdofG3xUEZ7eR9Uh72Lsuk+Qc2FklAMd3zC/CsMnR9Jiry
         HojDn6wFgWKxBJ5fIXcOdG/WRSVuXrCE+TW9C/lYw/cC5OCTlAl3BQ9YfecFycxr4Xia
         ZR+rQWk45aAOSdxGMCUJZaLnVvfPxhvsKSy3i+EEhgyZuVbhaM/l7EIA1YpJtAR+58Qt
         f7+Ry5RQWwJSs+4NxIo9oo2cIgXlLJz08Fw4WMHWJDHYZx5hLeXxl9jtF9BQCSVNNWII
         hEAMX9d/0zRyian4gUSMIIdD85iJgH+vvEi9TXG9yE0iILcxg86mI2/XbM18P3vxoibE
         I/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775802991; x=1776407791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncvh93jAnc+Kh1Rm86nCGET2vwT0AL0foIduL84AyF8=;
        b=GUgDVoCO4gAhA1NceNncrFGJctQ1s61ZELC17aJtkWpzq9D0/2extWjH44O86Hd0vS
         41MSI2b7w5VIkLhEt88U5qclVaEDQW78lJAv9KB/V7MeNZbvgHr46ISKs6hdPCHhr3Jf
         e+GOew3BZq+INdvN1UZIPtQod6PkUTRIrQZrzEhc3f3ea6NW35pkvC2I3GXTHKbMH2vT
         8uTCbANoBxhuSCWYIM3stm2BZdI+FXyQ7rd9b7NQgUViMdbA6ZKZYpUe3+q/xE2gCSM8
         FTsgKA/txkKUHZTlYPg7hedUUApcKX+c8SOs5pa4D9AE47PRSuY2fLc4AKixOkch6CGw
         hslA==
X-Forwarded-Encrypted: i=1; AJvYcCViAIx5Yvnhgs28tkCBDlGci18+k7t09qYQiNL0gsNSoeGudZIt947M5kuj7vCDVtjUPMXBvzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDdvsGM4GTIxSEgSlenKK4xcDPl6Z93SA2sYjO0tLXTrQEhtD
	SieeOlrEKUHQDXruZvgpyHNpdsPm1sLdWagwSp+iUreAuNHf+dZlL/za2ypm19MDy5R6KEPTvPK
	gr05PpyOwEQcKYiDlCdOGo0YfO2q3A3LSMIGxGpIu
X-Gm-Gg: AeBDietHaFQpLE7SBD9/bOBLj1B8PllZFLLaHcopatOSoBR+bW1s+QKcodE8zIsTBxi
	1LgHXvDCOy9SUs2Y6ZwwwwZ4V95MpRcqkvmom9ZO1k0RxErXG1WttEExL5IDUSDkYir56yhg2Zi
	iVeags0hzyQXXiY0qVRRaxeoNDfm/Opie5mmWo6Lqudo0UE/xT0f6DkfSIkgdKuZo27zSwBNpIn
	35JlA0T7xKzcbvNyMp+i8NJktTDSMTRdsya5N8jW9RbrC8zrQ0IRcpYwXp8vZBS38gdbwHGrLtE
	XowTrDXk0ihGBn9gnQFm3Gts9qMvBPlVBoplUaMpxka1JGruhm3N9iCrwxbQ8ee8VncS12YfqUH
	eOxR6+Ac=
X-Received: by 2002:a05:7022:62a7:b0:128:d577:dc21 with SMTP id
 a92af1059eb24-12c34e712b3mr1137078c88.13.1775802990860; Thu, 09 Apr 2026
 23:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-9-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-9-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:36:18 -0700
X-Gm-Features: AQROBzBQtCRp41X6FJjmzDXEjYP_LuOgV17w4FamhSIrTd-CjmpREkmyTrBBvoI
Message-ID: <CAAVpQUCnTyyf+a0E+WR_y7Ry9OY=sUgycmKUNL0E9RwRUAtLwg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/10] net: team: Add new tx_enabled team port option
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277271-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0A5EC3D2D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> This option allows independent control over tx enablement without
> affecting rx enablement. Like the rx_enabled option, this also
> implicitly affects the enabled option.
>
> If this option is not used, then the enabled option will continue to
> behave as it did before.
>
> Tested in a follow-up patch with a new selftest.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

