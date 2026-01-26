Return-Path: <netdev+bounces-253605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MY6AM3ld2k9mQEAu9opvQ
	(envelope-from <netdev+bounces-253605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CC8DD77
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 762773004689
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63582DF716;
	Mon, 26 Jan 2026 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IsMk+QCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B472D876B
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465286; cv=pass; b=UJd6VaZ0VbOV0l12hTE7Ctr3S7e4v1UWHdY7An8lweylglcqPZmHXawHmsIPyF+FF5WqyGZ6L/sNC2EueTynqTNdhyyzi8XZEsPgmC3Lf2WQFr6khGmSX7GnSSrFcwUCIWq5xizHfyKc34UNIN1R/0/jBe8AswSjIyJ2Ojefa9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465286; c=relaxed/simple;
	bh=1WpWTEYnQFU24311RN7E2Bm1qH3Q3fjhO2tNvVjnXQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nh2jZ7gtaIR+RVL27TfHiPOnW6LnN/gCPvTDLXiu7m4Rb4YdxNB25MX+WiwPsIwzank4STvihypMX7K15sT08OjUVQi2mxp5gIxrEWjMb3SrZoLev9NKW95Fl7YbM/cS8OHKWfiAEXDUWnr7cYfYtaH37qwrJQoVgsAo/YAiF/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IsMk+QCc; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-563610de035so4625326e0c.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:08:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465284; cv=none;
        d=google.com; s=arc-20240605;
        b=QfE8YuHLXRxWyhcVsEtoiD8HwfqjyGuE7XAdP9Ggvnbia/iOD9I+0V8Cv2IoKoVRgn
         HEYf5GHcgueg6tc9ACb9ub+0zy6Uz5cibuH07b2fbSGC2ugNo7kv+3EFyUzQG4fyzvg1
         YvreWXBC1alhPVUptig1g2M/2xPt1xOZ8hXIl9DRAf+jSGGBFrc2e9JWXejw+8aUg7Rf
         YwTewztae8S7PCh41cRPhGlGTGJRTrFn12cX9Kw72m8hVUtblkNJOmKI5Nxrinb2yjev
         KIjaq4PCBsBRG60CmqBYid2CFD12XLgj0Qb9rBqWZu/6LFGB1/mfKAZZ0AqURdjyGx6I
         IoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1WpWTEYnQFU24311RN7E2Bm1qH3Q3fjhO2tNvVjnXQ4=;
        fh=6NL+27sIBxvB5wwZ0ZBQmTcL/aD2DfokudLcOu/BOqg=;
        b=ZZw3SBw59nmigcbvvyTgX4Ze76bu1xpT3w2lFdRQf5t6VlngPUgZpqLOpI819hbOY/
         iH4kp+ziW/eZ4wvEOs9gjVmv/T3UJvNigwXo1N4RHCC+PxgR+K5AizzrdS+D/5YOQ636
         RvvBVgIK04IAK85rc0fl7GrXJa/i8gRSOj1JBySLreXhl98JoHhRvjngNr8hklANu4+9
         iQZIJP5u9GoMePhQSwu8UFKGpWU1wZ7fR4mtcvozmWUi5jQI5GK/aj1GJ94eiFaJyGay
         xrH0o+YpmnNEdlYuxb9c1SVi6OAmnIGGm8VBcPhLj1ER4OXVpmxIjwrGaWALYp/VaAW+
         bPlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769465284; x=1770070084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WpWTEYnQFU24311RN7E2Bm1qH3Q3fjhO2tNvVjnXQ4=;
        b=IsMk+QCcT+VXgePEWywEujBF4THTNiswk+1ppFJ9I0Z1sl4HarSvB8ZsMwi3MvFQWQ
         /tyReAKunNJKALcaW0i19VhtEj8yq2uK9vuNQ6F3+ki8w/+46izOgSDfG+8g9RW28BRH
         Z7Ow4VluL+pn8qjAoEH0WOU2Rsie9ymjNCWcVv4YLCAt54cBoAMsujHD6w4UItJt7Q2+
         izFN39RBiLLt2YEJzPOD3t3hzDR6/+GDwGtxWdYey17R2kBEhwswyBEM937CGsZz0bQU
         Vm3z4Eh5q2QJRQ22Ry1qHuOmwftBYmSGzIbe7HKP6qvfmyeGTmD/Vti0pY0UnhjB9BVS
         Hl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465284; x=1770070084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WpWTEYnQFU24311RN7E2Bm1qH3Q3fjhO2tNvVjnXQ4=;
        b=Du+Eb+A0WfOjwRlFw8QtP1IaSgmV553/ocaUThrUkety0FnbPk4kM8Y/FZcwIycEpv
         iI4QqJj7PEtHglp2Zq6VshuFAsYieOnBZaqeds94mGbQ+zoHUVBL0X1zZOCxa3MQOJR8
         cV9Ah6QIgGQ39sKeRt+U7zJq3i/SGkdKMn5UcAzGs+iSNPksZ7NqT/rnmb2nStdNnYdM
         2fiL4z2z2TyivUttkZCIdjs/ZifUSeyrAL+alNKiIoUiY2NHnAknHapy4psG51wR0SSp
         npHSSe9xai2ayz2GmNTE38eisXYyWYopfkTseFsrpf8CsfLpdOOQXXF/SCGUMTkKAgrz
         g4NQ==
X-Gm-Message-State: AOJu0YzjD/B/xnhfdLkqaBjyYmb2q2dsjt4qSm5J6nc34qodHYZvzRt8
	E6k3Eb/uDpT/f8OlNvPuxaxXOti0Ly8Z8KGL6oTbHPY60LAYACM6xGKltuJj3VYBxgqKYom6Uqf
	8JqiF1/SK9E0D/vgLklQQ+HdvqV2z4qmgiV3sAtyy5g==
X-Gm-Gg: AZuq6aK0+x3AQLyOw4EYOVw8N8JeGjBBxl8mFqY8TqVjeGyE5YQgUpDIr5tilWHiW9S
	TmpcPYXa88GpmwtISeDbWZOTM0n5np6A15RP7/1wYzXf9jPFnZ1owGH36w8ag/Ve/ESgIIrZMun
	+YNIbmqib4Tthamq3U+Kknb+kv/g0fzhph1SHmA4k+BO0d5NjeDSiySxdfgjcjHm1sIkoK36VSV
	JrwVEaNH8jBZPnjeHDcX1fdmwMNGfeeoxklT8RZO66btr1uUnSZWOX6V2c91eXhRaDll7M=
X-Received: by 2002:a05:6102:a47:b0:5f1:4fb8:6b9a with SMTP id
 ada2fe7eead31-5f723933e1cmr210798137.42.1769465284222; Mon, 26 Jan 2026
 14:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192851.86670-1-rjethwani@purestorage.com>
 <20260122174821.70553ffc@kernel.org> <CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
In-Reply-To: <CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Mon, 26 Jan 2026 14:07:52 -0800
X-Gm-Features: AZwV_QjLget_D5AcRoAHST9cnXs18MozWBEr5b6vlH_I8F7eqThXVZ8Vr39T6Oc
Message-ID: <CAKaoeS3ZLtiXNLNoJXGyTRp_-4yywdmDdCbNtjA-Q_w6mT_oaQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253605-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F37CC8DD77
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:03=E2=80=AFAM Rishikesh Jethwani
<rjethwani@purestorage.com> wrote:
>
> On Thu, Jan 22, 2026 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 22 Jan 2026 12:28:48 -0700 Rishikesh Jethwani wrote:
> > > - Rekey handling: HW offload key update (rekey) is not yet supported.
> >
> > Not sure this series will be merged without rekeying.
> > We'll need to discuss pros and cons.
>
> Rekey support is in [PATCH v5 2/3]. Split into a separate patch to
> make review easier.
>
> > > Testing
> > > =3D=3D=3D=3D=3D=3D=3D
> > > Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> > >
> > > Both TX and RX hardware offload verified working with:
> > > - TLS 1.3 AES-GCM-128
> > > - TLS 1.3 AES-GCM-256
> > > - Multiple KeyUpdate cycles (rekey)
> > >
> > > Test methodology: ktls_test : https://github.com/insanum/ktls_test/tr=
ee/master
> > >
> > > Please review and provide feedback.
> >
> > Selftests are a hard requirement, I already shared a link with more
> > info with you.
>
> I will run the existing TLS selftests to verify no regressions.

I ran the TLS selftests - all 898 tests pass:
linux-kselftest/tools/testing/selftests/net# ./tls 2>&1 | tee tls_test.log
# PASSED: 898 / 898 tests passed.
# Totals: pass:898 fail:0 xfail:0 xpass:0 skip:0 error:0

