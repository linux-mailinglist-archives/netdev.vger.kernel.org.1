Return-Path: <netdev+bounces-204678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6AAFBB20
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A318986EE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE826560C;
	Mon,  7 Jul 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxbIvMWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A0264FB5
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914149; cv=none; b=bLbfPSnxZesczPdqPPZQyVH9dAQJNZRn8ULfh0tU12sOgORc8yVs5nSUQgbG05jmC89R2SWVbS7CGkH09IQ/GXC7kjHS2e/ViEGz+jlJt1Tn0CR9GEmXUIGEcP3rQ5lomRAuqMtLKayvQN7veGNPmq6QBCkl6rNaEK/OuM4SAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914149; c=relaxed/simple;
	bh=aJnLvBEEZbnL+uu98DjTZaoxxjR8mifkHxn537M2Twc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS15l9DEZn89K0SBe5VsnMsdw1Bb1aEkLGHvveDQNqXHCWRMDCPvoiNsext03RTumURbrXaIcRUlsK9PfJrvv6pABVpl3vH4myoC0BdORlTXPPIX8JRp6vGaCAcQgYDEfL8ZKq/hqaDPUfcl8q9Ofnu/fuD93lsMk0x5uafyX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxbIvMWv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237f18108d2so34665ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751914147; x=1752518947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbLpetxYftBk9awSTLcJ9ED1ywf3jWFwfEbkZR89PpQ=;
        b=PxbIvMWvoy6Y0Z4cOA/rN6OWuK6oP6ZLENu6FciKGlW7NQQRlodfkXOPNmdeVsm0zv
         O1M7fODoXOz0vz8c/6jJOuJpyDzxNxrN0gtajuEOr2I0F9vSP1jxqNBYNDcVReO5f+5d
         CgQA5sshyHeYtLsdbstSppooXIt1DIxPuah4ITJzvJVixpX3W67IDjZooXqKvzmsLHlW
         WkwyGqCnGpftAsbZ+kN9Ud4HXoSWkhMhO9NfcsrmNbX/BPZjDtjwpGTkmPVBJsRCZ3DC
         Q3shnvA6A0ezmFpDP5tuY+6FJUknjOm6EdlY8SqoEW4HJjk8YXRFddhpbsU5ioeYJxho
         c23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914147; x=1752518947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbLpetxYftBk9awSTLcJ9ED1ywf3jWFwfEbkZR89PpQ=;
        b=vxrrkpA7C/cPKlsnVNRJnZX29lJZTBzpIcfC4XtXnokAm+k+3k+LP0Iu7nF8ecG9Gt
         AqbxUcVRJeh7vSaZ6ThzzLF6K4LhnjTh3M9lqZ3Eq0F8TsPJB6guxMDY3wUvHshiORd3
         HlDjbJnjKzsLBrBTFC9BzwpkF3jUb2Emz2vowqLSiRPZ62CfOOojX7C+MJsrZPpubEGl
         4v1X7ReFCoTu2beRd7oILRerDDFCBgXqz5NvfApB+s7VqbgdIXoISmbnxXprTLvN3aPh
         wsTVnbLIIHAIG+6cDuqKVXJLSVYH+z5ekLlRysZhH8FDiDyuWJ9B2v5+3EAfqZp/tX5s
         K2kA==
X-Forwarded-Encrypted: i=1; AJvYcCVVCc2p2COABArn6x5BwY5ll5hc3JxJg0wzYRummIgMC2gmw9K2kVQr8sMQdHfTY6r5K2gzQ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERV9a17yltSuWlzaniC2K59eBGwbXKlXdaaMMm8yN4bDDa2He
	o/sC+erGWkzq93VaE+jks451WDrdkc45YOBnnk1pa76nxbGmHKyYt+aAO6t1r4pnWUYfZAkX7rE
	/oDXHAxAGBhRhEzhb6Jf93dORRO3EjcKguCmZoIbl
X-Gm-Gg: ASbGncvLs3IbtZNLeJ+LGYt/eZ8Kwokj9GJ0lHSJY2Lr1oZFEJXETswVUrWl/biqpS/
	koKfj8W8JbIqcsMP0SQeyhLRDQh+w/1GidKagvcHYqUYs77ZMHYnWTaZwr7j/mc2Euhl51zzuXW
	Cr3IwxCXmhbtv6UkwNnWBacq0e0SJhV/trMnOUA0LaJDJjxa9/cFZUmONnhdb6FINa4nRaJraWI
	w==
X-Google-Smtp-Source: AGHT+IEg5t8XG8BnF4k7T1v1Wy6xEwaxF7wvaK2JoECULiD6cDaaTfJJCXuVTAcYqSYGP/3p/C+ZTkTRDwsv1PB0RRw=
X-Received: by 2002:a17:902:e5ca:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-23dd11d4882mr221445ad.5.1751914147250; Mon, 07 Jul 2025
 11:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702104249.1665034-1-ap420073@gmail.com> <20250702113930.79a9f060@kernel.org>
In-Reply-To: <20250702113930.79a9f060@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 7 Jul 2025 11:48:53 -0700
X-Gm-Features: Ac12FXyWIu3Y4yshjHkawSrnmMOadPMVVuaxwuq-UIS_rELDSzwub3bWQ56nAAY
Message-ID: <CAHS8izPug-bFu3Tqc_sanCO-gip_e-pPY2Xx7qTAUV0+cKySXg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, sdf@fomichev.me, 
	jdamato@fastly.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  2 Jul 2025 10:42:49 +0000 Taehee Yoo wrote:
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, make configure_headersplit() sets hds-thresh value to 0.
>
> I don't see any undoing of the configuration :(
> The selftest should leave the system in the state that it started.
> We should either add some code to undo at shutdown or (preferably)
> move the logic to the Python script where we can handle this more
> cleanly with defer().

I'm sure you're aware but this test in general doesn't aim to undo any
of it's configuration AFAIR :( that includes ethtool tcp-data-split,
-X, -N and -L. Sorry about that.

I wonder if you want this series to clean that up completely such that
all configurations are cleaned up, or if you're asking Taehee to only
clean up the hds-thres configuration for now.

Also, sorry for the late reply, but FWIW, I prefer the configuration
cleanup to be in ncdevmem itself. We use it outside of the ksft to run
stress tests, and folks are going to copy-paste ncdevmem for their
applications, so having it be as nice as possible is a plus. But if
you feel strongly about doing this outside of ncdevmem.c itself I
don't mind that much.

--
Thanks,
Mina

