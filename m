Return-Path: <netdev+bounces-227235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B7BAAC7B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46871C323A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57617263E;
	Tue, 30 Sep 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moWNPIwY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA839ACF
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191580; cv=none; b=N9Q2Gb5rrJLJUU75imKwbMvTzdcdBvWA4bnFCH/ups1OdyeUHnb8p0JBYEFe9wJu65YuUm7HGkDnwcWH3DNVEvAVlMGApfUvKK+CUfk37er4yOCSDRHLtiGBvGf1uU+rh2CiBkbzqjr8kMLhvZK/2iTDEh/MB/Nr3uf7QVL2h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191580; c=relaxed/simple;
	bh=8iK+tN4D0izXVy+LVrIeR4VyKFqX9lz5pzaqb3RrB8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0+9lhUNUtWu9JnLajQArSKLoVowRabv9+AkucHSkZDxwIXoZyqC9ZiLODC8xvXGokOQXOT2KASS7UC3la1H81qFiqUyq9GxTLs9+ZAOVuguOyWQGjkyh9D4uyPM96PhSApdpkm0AtnNNddKHprbRAS8ZEtqPAtsmatixbkE1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moWNPIwY; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f715fb494so358151b6e.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759191578; x=1759796378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrXHTeZA7VdvtwhZTAFAV/ylzGC1dykqJ/gmIE1UwAg=;
        b=moWNPIwYK32jOr0zdy0yosXwYIWnb8un6D03FIJdcvrnFXza6Owhl0cQDe3vwRYJNq
         lqeXBt7bLWOC5BAGLAsvPSKwKnlI1KDvgUKK+GaY8Uj9aWKZi8o7C4uFGQPwbDbX0VEa
         FXSY7nMd+XuSTN9sggkP/nfRQNiYocVDfRcyLAgKzAL9ILqfE8K7EGQ1BPIAzKCtdgji
         InVM6wLqzDE8LZg/8F8DGB0Rygn9aE3wiXB4y9UxtvuKl/tp0dKF3uasnuOE+R5Ho714
         ew7cedLi6qbtL3K5x5GMXuTkx5xzGhxyIgGnLkbQiFEX7e+kqkx8DTX0gkUDKy6GHZX9
         X4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191578; x=1759796378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrXHTeZA7VdvtwhZTAFAV/ylzGC1dykqJ/gmIE1UwAg=;
        b=iabs/abE+HJjqg88V/FBM5S3q7Yl3r5oyYyr4G8ZFfhoFHuMJX4KU5HACWbr52Alrp
         8jqH+MsKYTE6qNcuE4FMI7exoSL0ZGaSJ9XmJlCOM3HqageIkFD7q6mfjlW5viR/Dt3a
         CA4sttqWjfomBj5cGhTs+Vts0esqdCxPMuNMtnbX2XiaJxwSO44j/RmRpes0ZIF7e8Vs
         gWiP3G/mAkkeN+DLTJBwgC91gB0Ov5QeNCHOTBy0s4kkJAEy7wJ4ALWvV7PRcLsBtO1f
         8yqy/Qyl80sxzWIBGkl8Pz3at7xr3M2rFffhxPFK30fA6gbX+knXZRI/du3VzcBgTOqx
         HJwA==
X-Forwarded-Encrypted: i=1; AJvYcCWBA3n/d8oR3OOJiYWcca+6x0xwVsoOPDL8bE7JzUTWTNgiituJ6+GplWgaLRyhqaGwqS7E62Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3MXdBrkHWmDpoQPNOrt9PX54NLTwAdacei8cBs/BeqgC6QlQ
	q+NloJ6GW7lYFkZPQpYMMX/ZK0ASxWdaOppMvQLDqChvbel27Nvd9pHF1UkiOvy+QhAMJencV4V
	9eSUA+CoRz2QSOxj+rR4PyyZDpBFLPas=
X-Gm-Gg: ASbGncu2s56i/JsR124DffGQeeg0y7b9VD8LixUx0jSEm3z3czbUR2ThDo19nRf6Qbj
	hLaGXi5lpQ/sYR96u/0pRnmvsB972HOLqQoPmmymDRP1AnwP1iRx7PceIMX156lt7ibzo06CKoH
	cf8iHenGGDCxiLOsvzKfXw7OsedbPjfeKOmCohXnWSF48c6RctrywIT3FIXjHUUSYwCrdlNFupc
	Mgq9BpRQVDd8TV4X/8liGGdqcfX3SuI
X-Google-Smtp-Source: AGHT+IEoqCrxrSDtjeiwakcUeo4XvYHnkurteyUGsD+XZGiCOYn4WLrmwUbEMwit9w8V5MZ7NWhBL6FCyd9E1Ycu9YQ=
X-Received: by 2002:a05:6808:2209:b0:43f:228a:2098 with SMTP id
 5614622812f47-43f4ceb1890mr1941152b6e.42.1759191578178; Mon, 29 Sep 2025
 17:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153311.2202648-1-sudeep.holla@arm.com> <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
In-Reply-To: <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 29 Sep 2025 19:19:27 -0500
X-Gm-Features: AS18NWAXTsCPF22Xk-8M1rm_I_ys9f1EVFIsNceI-O_ANRhki9_9K-pzSBC0jJM
Message-ID: <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:11=E2=80=AFPM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
> I posted a patch that addresses a few of these issues.  Here is a top
> level description of the isse
>
>
> The correct way to use the mailbox API would be to allocate a buffer for
> the message,write the message to that buffer, and pass it in to
> mbox_send_message.  The abstraction is designed to then provide
> sequential access to the shared resource in order to send the messages
> in order.  The existing PCC Mailbox implementation violated this
> abstraction.  It requires each individual driver re-implement all of the
> sequential ordering to access the shared buffer.
>
> Why? Because they are all type 2 drivers, and the shared buffer is
> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
> for status.  It would be execessive to kmalloc a buffer of this size.
>
> This shows the shortcoming of the mailbox API.  The mailbox API assumes
> that there is a large enough buffer passed in to only provide a void *
> pointer to the message.  Since the value is small enough to fit into a
> single register, it the mailbox abstraction could provide an
> implementation that stored a union of a void * and word.
>
Mailbox api does not make assumptions about the format of message
hence it simply asks for void*.
Probably I don't understand your requirement, but why can't you pass the po=
inter
to the 'word' you want to use otherwise?

-jassi

