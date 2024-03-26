Return-Path: <netdev+bounces-82274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E888D064
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE5F1F61626
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624D13D8A0;
	Tue, 26 Mar 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD7rG1NG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9613C9CD
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490629; cv=none; b=UDyNtsxYLorhj3mbepNu/+rm54f8bLX4T6d/s4qvwGPki8VpJle03gq4hMTkQdIlGCkkZHH2WDPBIxSxM7xiuzmsjTGFTH1OtZ3s1GdA9HTIv8V7HM8/Jqc1EFId3nEpinaRC5eIU6Er2VqljjEP7NqfOFXcj0JFmehhFVi/HoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490629; c=relaxed/simple;
	bh=7TKd0saSqO2snc89msEoa1QA+B9bSgZkg7SBKFh1Jf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anMnKy8tQPZb8WgiHTMWcSBpU9a8eLVBjly3f4eHFONz+GQaty8JSQjU+f7W/Vl7X1Su0sKOjuspa6DnAI4gdqWvJTVGpvgVebZsWKdNrutkQyuLz2SuyRG4SLFkfzxo3HjxUsw++s0tgKEYbaJNV64+aB6ELD68sA855bxDuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD7rG1NG; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4a14c52fcso2801730eaf.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711490626; x=1712095426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7d/79/qhHAW4S4hPjrpaIqd9akj4wQ6SZW8rjZq0n4=;
        b=fD7rG1NG+OHiGg5VhiYoJN7C/FlWdoQIp69p8l7V5r+cNx/H1JhnS6PhijjxUhGIt/
         1Qyx4lxhgYdZU7IeEybQGX/DOulQEaOK6AGOOfAq0ZK892hUzPCS2ftEfli8tzOgaFlB
         KwTt/UGsCvHlvBJYFejtX6Rj1/431KQ2aMsnImjM5bpF25RtdKQVVo18/33lEkXzx+Jm
         nAOEluiqH3o2Yn6pc3wCxXrCg1IXOikfEbZIrc3/HX+E/ziTSmnPOt61Kwi0/8XB0EZQ
         bkA0KxPSqUUmiF/anMfw8U1C9/tgKc/zYSNdNmDp5SDTVbVM48zjOvP0teaS1irOgZNM
         Ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490626; x=1712095426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7d/79/qhHAW4S4hPjrpaIqd9akj4wQ6SZW8rjZq0n4=;
        b=ZoQ1Wv1o2AINfTXoiZrzWbMBtTu0FD3rTpJSOlhOCnq9I05cwphHIneV2880+ziVK1
         MGkArNZ/m3WUNO59y13ia3tUFBMFVqE5ufeCDHyAwn/5r5kdP6RWpbyDKUyZKPZ8/B4R
         eZwHYIoSxiU3hL8YUVwkw8tZptgfcjMdfhipYLZiPRYylm7TyA/d1DEMephHkY4UVoC6
         CQ3wJ32/J/CV11XNiR9LMf8Xu0h9a++ZFD9Uy5pcR8SDX+/5sNJrUOlFJbdRbovFhnEB
         xFO6iCY2bi95CTgQtBvBkJe70zWIiyQyFYkUpK7ZkLDxw2eLqrOUUNNyLUOr9euwy/hQ
         jGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7PeI8G4PvMARkhh2B0/mng/bpORYivmiURuplpvu9HhTra8q4pY7S24wu+xFkwkx8Hgt29BPd2iSKEkIqcew9P3xZEqqM
X-Gm-Message-State: AOJu0YzgT1+Mi5xwNvjvB6ahFp98c6HmOdN/8W7MjNkXJMTQio7lDylB
	a5eDMyGJZsoK/8ObusZ8SukoMwrJ439qUE0Mg92kVWIucMtJ81j1u4ex1UyoTRsN3oCwj6AF2Lh
	FnhyljJWV1QEJuL3NpEedueU4qqMybYvSthwS
X-Google-Smtp-Source: AGHT+IEba+EtV8PNVVMiJ5fkeS9vgWsunJxg8PCAWEwaSa5ZMzBYSCbP2XNrmTzPWLRRu4EsCOf+4pcyZLJIse3HFg8=
X-Received: by 2002:a05:6358:4043:b0:17f:5980:79fa with SMTP id
 a3-20020a056358404300b0017f598079famr1378375rwa.20.1711490626147; Tue, 26 Mar
 2024 15:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326133412.47cf6d99@kernel.org>
In-Reply-To: <20240326133412.47cf6d99@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 26 Mar 2024 23:03:26 +0100
Message-ID: <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi!
>
> I got a report from a user surprised/displeased that ICMP_TIME_EXCEEDED
> breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
> finger at Linux, RFC5461:
>
>    A number of TCP implementations have modified their reaction to all
>    ICMP soft errors and treat them as hard errors when they are received
>    for connections in the SYN-SENT or SYN-RECEIVED states.  For example,
>    this workaround has been implemented in the Linux kernel since
>    version 2.0.0 (released in 1996) [Linux].  However, it should be
>    noted that this change violates section 4.2.3.9 of [RFC1122], which
>    states that these ICMP error messages indicate soft error conditions
>    and that, therefore, TCP MUST NOT abort the corresponding connection.
>
> Is there any reason we continue with this behavior or is it just that
> nobody ever sent a patch?

Back in November of 2023 Eric did merge a patch to bring the
processing in line with section 4.2.3.9 of [RFC1122]:

0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP

However, the fixed behavior did not meet some expectations of Vagrant
(see the netdev thread "Bug report connect to VM with Vagrant"), so
for now it got reverted:

b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving some ICMP

I think the hope was to root-cause the Vagrant issue, fix Vagrant's
assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
2024: "We will submit the patch again for 6.9, once we get to the root
cause." But I don't think anyone has had time to do that yet.

neal

