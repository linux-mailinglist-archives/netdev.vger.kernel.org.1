Return-Path: <netdev+bounces-132119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF689907D6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BCC28233A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64691C3023;
	Fri,  4 Oct 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NYoVm8lb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127F1E3DF5
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056052; cv=none; b=Q7bMXA7RXZTyS3hvsSS6O66IhMJ0MZggj+TZ4mO1+qfit3CBLc8gGFvPSkVOLMvxVNo4HoO53bj2/7pXoXGNYqb3zdAL5b2ttMrrVFZCrRQV3zAE+80mNAxj6Qm3ps5la4p82uDAbioe8FucQMsLuuypPvZCWbCyIv9LtHH5WmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056052; c=relaxed/simple;
	bh=Y1ynW6pThWLlOoYV2/r/f78bkRzxHOWzqDY0eCxGb8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=muzInJJIjSW8PRADdRu0/gq95inZKIGAtRcJG+t0rn7l9PADz8UvJwL+ad40wPhsiDuiaAaRN4sbwGX//6YTYP8RjEzvkbUj9GWiMxod30BYuPiXiaTzVJSpsrf4cLRbztk/i0Jj4PzuS6iIsiVTiw175kjNhDCh1T/RR4p52Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NYoVm8lb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so1805346a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728056050; x=1728660850; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bzdD1xAX1XMuoOw4BSl5totOVCpRfgbZXfWaZis/9A=;
        b=NYoVm8lbgl3v6WOwuk5/jSYNNqmH6JNDGdr7kUJUu+2OSgwOgaSHhnFGAdxMFyOqAy
         5ICfNkchTAiGh8Q93IDU9ffeCN2Jr0MvDCX5lz/u80WMhr0ZXZQ2mJclv0NFfs1wFoC+
         himEOfTmz+nabFhp1q+IbQzV7G3Faz/fIhtD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056050; x=1728660850;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bzdD1xAX1XMuoOw4BSl5totOVCpRfgbZXfWaZis/9A=;
        b=wlHqiL7vSK+9oe6W/qY/JBrwo0t5nvCJ/DST4S/mLJlbUNcwOsnBnxm72ngFMRLVBU
         lnE/DuKTIc+XUP+uG4dxmgCgigb+OAgfgFBO3UHZt+vzuYT8VeWwJyY05gNhwfwisSyJ
         WAjDm0Sy0wAnV/Ipvzl2tAc3dbMgXRZnXjRSKg2B6wg/oSYs7C57P/h6ql4026DjB10c
         PSmYLrnmrJGeL20XnYAU0nULToRd0V+jl235wV0rXcT8cm8HIwZvuSPJZkfL9TVnZOXr
         S/D7mX4/Rud52IHL3m8W1caQJf93MtDJ/vyNZIDdEIcpV/aemL4/desrJj2shPMVrAr1
         ZkcA==
X-Forwarded-Encrypted: i=1; AJvYcCW/WEFpftfP8suzVe7V2PycyVgo3Tn757edbQXsL8MdrmSmgEwISSYuueUU5x2071Mxa7hpNfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZesmp85Ao3ihqAIJdh4d6yCh53BPSmMbD5/kkTycAUWGL6eT
	/XeQi7bKH8/a2IKLy2ODo62g2J6Jb0DNNPgiD0n2P6GxZBKpCAGteenHuRk0Kw+Wyr6Uu2OyuSK
	/3mGGC6Fa3UcfkgNtpbi8kFRcVNRhFgNJb98gD4DpR8dmCPzktg==
X-Google-Smtp-Source: AGHT+IHuhuF858xSQbIX7dz3Swh7impcIcQ82cdu3JlhX2oxs6EhHnlMKb+8b+pVnXvKUo/jIHETBsL4SAdvCfyCxf4=
X-Received: by 2002:a17:90b:360f:b0:2d8:8175:38c9 with SMTP id
 98e67ed59e1d1-2e1e626c076mr3832597a91.20.1728056050433; Fri, 04 Oct 2024
 08:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162048.16208-1-jdamato@fastly.com> <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2> <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
 <Zv3VhxJtPL-27p5U@LQ3V64L9R2> <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>
 <Zv700Aoyx_XG6QVd@LQ3V64L9R2>
In-Reply-To: <Zv700Aoyx_XG6QVd@LQ3V64L9R2>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 4 Oct 2024 21:03:58 +0530
Message-ID: <CALs4sv1Ea1ke2CHOZ0U75JVY84uY=NNyaJrW8wVwcytON2ofog@mail.gmail.com>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000010655b0623a867ca"

--00000000000010655b0623a867ca
Content-Type: text/plain; charset="UTF-8"

> > The local counter variable for the ring ids might work because irqs
> > are requested sequentially.
>
> Yea, my proposal relies on the sequential ordering.
>
> > Thinking out loud, a better way would be to save the tx/rx id inside
> > their struct tg3_napi in the tg3_request_irq() function.
>
> I think that could work, yes. I wasn't sure if you'd be open to such
> a change.
>
> It seems like in that case, though, we'd need to add some state
> somewhere.
>
> It's not super clear to me where the appropriate place for the state
> would be because tg3_request_irq is called in a couple places (like
> tg3_test_interrupt).
>
> Another option would be to modify tg3_enable_msix and modify:
>
>   for (i = 0; i < tp->irq_max; i++)
>           tp->napi[i].irq_vec = msix_ent[i].vector;
Hi Joe, not in favor of this change.
>
> But, all of that is still a bit invasive compared to the running
> rxq_idx txq_idx counters I proposed in my previous message.
>
> I am open to doing whatever you suggest/prefer, though, since it is
> your driver after all :)
>
> > And have a separate new function (I know you did something similar for
> > v1 of irq-napi linking) to link queues and napi.
> > I think it should work, and should help during de-linking also. Let me
> > know what you think.
>
> I think it's possible, it's just disruptive and it's not clear if
> it's worth it? Some other code path might break and it might be fine
> to just rely on the sequential indexing? Not sure.
>
I don't have strong opposition to your proposal of using local counters.
Just that an alternate solution like what I suggested may look less
arbitrary, imo.
So if you want to use the local counters you may go ahead unless
Michael has any other suggestions.

> Let me know what you think; thanks for taking the time to review and
> respond.

--00000000000010655b0623a867ca
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMysZK6K6NhNWzEuy7em59vBREYmr6ge
2QLD5z2hrTNdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAw
NDE1MzQxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAImTCYZZMJz2lJ/JO6eBaO4jNMkvZCoevuvt0ID7Q9PixXw4gb
tJMjWFFhI0YW36qARTA9Grelic14VrMNfoneZNnBPhGp0vEHVA2pOeZHGnkiA1Y9deZ5xOtGiOhl
vqZ6aqW+MAEDf+KFdw+fGI1MZYoCzUj7dsrJG4DNfgEOdIcZ4g5sgg67b6IinlAKlyeHmW3+3NuR
gWE5HYq6FN3aTOPTkF+d2uTV2zv4dwYa+MZgcx/AeFYh8BkjD6mAy3qpP8gidmql76RKXbAQjSJH
QWw70eN3UDILBEFzg+8GM4+ItMVeButYpE7wPmTvxHeip/d+WL97zYUzOODzW/0Y
--00000000000010655b0623a867ca--

