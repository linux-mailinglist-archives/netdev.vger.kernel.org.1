Return-Path: <netdev+bounces-256447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGUFC8JEgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:56:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B6DDEB5
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C885A30013BD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D63002B6;
	Tue,  3 Feb 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y++HTROo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8430DD0A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144947; cv=pass; b=Fi5ny5heThPbj1Lx+AP9JIviQ8GkahxnxtJ9T2fkh5eJp6+mSpbrl6/MtTj1ihqvhqptwmIUSyJ92VytS4PGeJvP/uVks3RUFnAnF3b2IaKWB9qUhgokJCj1xzSK9BodGElgqg5nWsCMkdqO4rrmnOvcqFcovtHsQsBCmqJ6PPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144947; c=relaxed/simple;
	bh=fOSoB3PlF4gVQZwL8YtzxZGdoeRvGK1XhSxyBdXZKE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSyAJ46BFHKs+1CUNfJcCYwmjm2J4WshnWYSpwqbQ3yVpBp7naJf6qayq5lGt0JNmNmDuyfWz/rxOMRvurUFoVVBZNLaczupL5oj/mSCWOjPePCd+SfKXuOVy1D4ZToeyECNZHyNnyg4kXrXBDtpOQIJKM2PNo9RhLaGRL8c0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y++HTROo; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-566360cab02so4400314e0c.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770144945; cv=none;
        d=google.com; s=arc-20240605;
        b=UNnB6ha7B4mqlFL2XlOyvsOaGX1lV1GuqulG7Bn4NIPBKCKlF2VLjPbcEO8vjfh2Xd
         uKo8CaQ04ZBaBEfuP8Mnf4KaJ+QtxwYKli7lc82Dx+tBvDdujm2osTSE7K6SGcn5wI67
         STlDHyQ6sofS+eo/rPNOcFaipYPcZgdTM4RZwp3iU+EMsqX1dVsdfvdyilP4ZuadqVhj
         r6JHJsRBwYDFcKNtYepEHZOIOWtxPFQgqZI13ka/q803OqDHE3qUINVC0EiLkpx7N7Rt
         IBIOCJDjMM/Oibf13Q0o5WySGwznHe4ZiklyHf3ps7MtYFjjLiX5IFDslOXJIo6Nbj3o
         GaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fOSoB3PlF4gVQZwL8YtzxZGdoeRvGK1XhSxyBdXZKE4=;
        fh=6NL+27sIBxvB5wwZ0ZBQmTcL/aD2DfokudLcOu/BOqg=;
        b=cRQvvisHmNRhcxMyQV5uQn+SZuMO43HP7iRcwpRLAlVU4NEeblLIJroXKFnMKh+ppY
         exTj9iHsCG2lBNOoaEB2wOSIR9sqEqhYB+96CApMb/2yFjzrmu9M2C7VANu0z9gd+9j+
         zSGA7puNWATMstDRIJBovw/I6m9QIQdBpy2B2BEuxXZGt14CfOlsSRBb+XBYOLB0dwnk
         Yoh5LWkMrRKhiHCQyR4ncHXdttixbrK7usr8yE1EyvfVYUyQE5V/5PkstB+7HbJ72KIS
         /9cRjRFhnp2WW5Zb9d2984cVYeHloFAarhUOSupkk2aUViBBuKbyHBwPyQos3zd2GXmb
         GDTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144945; x=1770749745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOSoB3PlF4gVQZwL8YtzxZGdoeRvGK1XhSxyBdXZKE4=;
        b=Y++HTROoapweM1PG+rbqk6w/0UVz1Bd1e9mnoLXBqSwdZ7nAMlsGiEMS/Q74NsZFiy
         I42EBOc8DIxgKu+r7Oa2dhJOACeoslyJ1Xvi1VoHhvV6jPoLmbTMyvQ9I+OH+/suUkp+
         jHy/n+gnb9AJ/2xJdE/iG8Omf+XWE3T9WXlHoLt5xnO7CIURf27k+ufDrj+zNivvEW/q
         XtqmA+A+E8/LqOUwBr6ij5HYQ20qERvpdFeaghWqcB3LfONRpKhTA4ui/faY8DjVloWn
         Qa2LU1aNgDqCNIyUpci0OBsE9+MEcL1d5AVrq2llEkI5f1NcGftyui5odyITitVAhve9
         TxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144945; x=1770749745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOSoB3PlF4gVQZwL8YtzxZGdoeRvGK1XhSxyBdXZKE4=;
        b=kCIt/Ff88xhIIaL7uJA0VmyBSh0nrotfitQrHqG4w8rmSMfoBuZGmNGxZnMNni5xzM
         IJ5UOB9Qlng+iJHZZ2+GwhpmlPPfqpKtW9sq8Ktxo7NOnSfcxHniYic70c4N+RHo8qoJ
         xAuXKl44ND8P/XGymIUgEj+Cl1/WFDcCtJBCum7nhldPBdsvI8DJY66hiYA+IaMUI6/8
         hhIRBiThCrd5q3PNLkLFbA/TYpN0h4qg0ypyXNp0NIxj6MOMf4/P3dwc2bIGj/aq1ZGF
         dO9tAbsDRkof5CHVkCa9JgR5ey4rwQvMNqp7HN5KQoA46npAyKgtoa0DCLd4ZZWRbJN/
         xudQ==
X-Gm-Message-State: AOJu0YyIDoTfr8I0cU5NKrml4BCV6EgRG+oyXZoAEG0Fimp2WREG5ldh
	dbk1a6wnWS/DlvQGiEUB6Z0/piQcaUIJ1jFgRW3zAybmGGNbTZHlubQ+WJ/vtO41/3jeilcMu3L
	gVZw17/gzO7/6LByW1axDlNxPftL+JGsg9ukdBxfhmQ==
X-Gm-Gg: AZuq6aIwHoqDxADNHxWEEd2qf2Yh0r4/CmawWtwb6o/nBb3zYtYa5AkLZEHPiWz4DqJ
	9Ny/v0pS8b99w8vAHhNy8cyHix0RHT+TnanYsgiMSJ/4g+vnNCx+R8Frs2OUyrMStWHjhpwkx+x
	sLNafeWG768cqjnF85wel7zfesGDUNinvg7ogrk6ojKoWCGBy6oHxyGTEDdVEY78P7nfGpiyIUe
	Ir3yBfQlw0jnu4ckE/ffiAc9UQnq5S/3w9MkMmzE82SMzygMQHv6JZBQeM+FG5YoxORJaCp
X-Received: by 2002:a05:6122:e46b:b0:559:dc01:8cd9 with SMTP id
 71dfb90a1353d-566e80d5690mr190607e0c.12.1770144945139; Tue, 03 Feb 2026
 10:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192851.86670-1-rjethwani@purestorage.com>
 <20260122174821.70553ffc@kernel.org> <CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
 <CAKaoeS3ZLtiXNLNoJXGyTRp_-4yywdmDdCbNtjA-Q_w6mT_oaQ@mail.gmail.com> <20260126161601.1c2f18ec@kernel.org>
In-Reply-To: <20260126161601.1c2f18ec@kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Tue, 3 Feb 2026 10:55:33 -0800
X-Gm-Features: AZwV_Qg8_M_GYmMkPhzBRR0VMqO_HQfjafDrfeLFUKPZm3G2_jZZ2EHMb6GQfd4
Message-ID: <CAKaoeS29J7bONONKF8mjyuW3zkW1=hrNx6oFCyPOvv+s=i5pAA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256447-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,purestorage.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C5B6DDEB5
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 4:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Jan 2026 14:07:52 -0800 Rishikesh Jethwani wrote:
> > > > Selftests are a hard requirement, I already shared a link with more
> > > > info with you.
> > >
> > > I will run the existing TLS selftests to verify no regressions.
> >
> > I ran the TLS selftests - all 898 tests pass:
> > linux-kselftest/tools/testing/selftests/net# ./tls 2>&1 | tee tls_test.=
log
> > # PASSED: 898 / 898 tests passed.
> > # Totals: pass:898 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> I am asking you to implement selftests that will test the HW.

v6 introduces a selftest to verify hardware offload functionality
https://lore.kernel.org/netdev/20260203184835.3619101-1-rjethwani@purestora=
ge.com/

