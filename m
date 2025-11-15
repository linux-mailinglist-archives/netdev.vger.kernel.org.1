Return-Path: <netdev+bounces-238841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F16C60111
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49DA44E2B61
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA819DF66;
	Sat, 15 Nov 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLqe2tVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44B2AE8E
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763191574; cv=none; b=hTbRadwkp+9b58frKp8XePhceAVcwdzsT4YFd2NpDEhdjCDmUhSIESChtq76DgvXmDp86+3Lkhb1i4WfH0rWYqN0wH4vrKwhrGU5EJyzN9Gh4e8cMRozVZpd0S326UlTnA3n8zGvQzkX8GQ4S4WijnHK0udFFGnHk+B5MvQ7nFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763191574; c=relaxed/simple;
	bh=bjdPbl/NXjnDjvD+5omD9xvNwHgkugrw/izKOAZGols=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eWvEVse2Ig7s1ZvkYql7SjAkdvzxxpJIAK+KimLxsyNX5SLUjXbNRM7VAvXZWjI02pp6CV/nM4ToRDvKHkZ3SXuRxzB/ZQo75WuxyNwRshXlMSUwAovgfKHvKv4JcRQKk4Fc2XAveJVRvWfS0KNUUHxm5uv0C1Qw4ZX78/uzEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLqe2tVQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b90db89b09so190858b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 23:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763191572; x=1763796372; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUKbwtLyB/vZd32q6qaF/9SPHcci3ieSV2S6w9kjacY=;
        b=lLqe2tVQR6P4YwKiW7NhE0kY3vDlLzcDM9Vl0F66ZYZpBICYcPb3ovkWOVrSiwZKia
         SvYMUwSXxDKkh3Kk/JkqjOqaUjHZlEXZCGKE0QDCLZHdwvrZrIHu36VLd2h5ciWIRoXJ
         AXPxSlCApKefZLfck9O6MehyRafG1O41fRzDoMAgoP3QAdses2R0UajCeOj3OcSauNPb
         4XsKUizFcmQyG/ENQ99o/9DAsU8/qlF3jFmP2W+vSWxW0mhE/u/dH1OgqIZ6BE9pP7wp
         cPtS5UUEE7nsLmBwpJA3TVNI6jH/CxMgJiXQ0XFl3bqCgYycZgFEgxxQ0EulE0MX7olw
         o/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763191572; x=1763796372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUKbwtLyB/vZd32q6qaF/9SPHcci3ieSV2S6w9kjacY=;
        b=FQa5XfBvApSUBmgJlo///q5RArfCIDSPGyupSGtMpjnyf6Urq7HEk5mdQWMaOk4c87
         dA5BLzn86vcqMqW8dAf/JNZv37JBIxch/jYnDcMB7hm2dvw3RmvLMkbE74oj6H00fw3y
         x2TNLtLc8o2uxZ/EHo52dEyn9ZEXQR8efKHTMeymm4I0Db0iLM/WQNJENx9CNHfsompQ
         9BscJnsZACToyP5swRw7DD0kcsDw3NuJF8PgLZnc+ffjIwu0rCHO+6QyNifEhANTrXOO
         78/t9UMThm9hRphV8wL4gi8enZdGIymiaTAoP0Y40n6WsfbBk4n+QSVLtT6r4Wp0BOhS
         7jPA==
X-Gm-Message-State: AOJu0YwWpmBlsNjmuO7Q+qRMsBbC8xEHLrScN7ncx5AVBQtpkHyPR6t5
	2OIRFJij2oqzbbQ155BBsppyBwU09admWBKaUJgakoyVReMPCHIjTUPCXmKtKtJ0OB8=
X-Gm-Gg: ASbGncvMU/wdcnn4ewwIZsIM+6shJtfF7DBW51tmT8gq0vTYr9N//cQeKEmQczPAJJ2
	ckWRZQmA4xQoerifH6ENxcizsuFEeuHBxC4n0WNOjmum4PNYI4bXiEMSORZ8LxI1+uWG1bNI4AU
	Rjx0M4efmNebM3WD1HLpzCIiC+6sex9DlRVhjaZTfgvuDoh3EetBxSBliKAzkSya6D7v6X/lOAY
	x2N4avliv4cRzQrGLgL2RZeGOF/P6s3l2ufAeO6ugThBlOIyqyf/CKnnHyDjJ62nJeIJ+Wr8Ybi
	kkpJ+X//YpZWgrlaK6ID3ZKBaoFvLXMQEH6fyIbns84zlQGxtOD7hGScS2+0zhGLD2tDTqJdvGf
	sjr2jpHzury9uU1VXVZSHZsjGtsLIretbKq6RsFmIdYPUsQi02WkhYILxsjA5x9kH6wvBDSJcr6
	H2OyLdsDeFWvwZcQj3jQUMLwM11GxIB5Uu/UIWt7DonMNJiPgyM5hLZ0zX2ixrTg==
X-Google-Smtp-Source: AGHT+IHAPzu6r6tGlzfZ7uoQ/nF+oqhyRihkrlFWIEfrBIckPtD7+JiDmLHMsf0v2M+IuaQPiTAXSg==
X-Received: by 2002:a05:6a00:1703:b0:7ab:32fb:98b0 with SMTP id d2e1a72fcca58-7ba70e8af0emr3060896b3a.4.1763191572331;
        Fri, 14 Nov 2025 23:26:12 -0800 (PST)
Received: from smtpclient.apple (ip-123-255-103-31.wlan.cuhk.edu.hk. [123.255.103.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782621fsm7184186b3a.51.2025.11.14.23.26.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 23:26:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [Question] Unexpected SO_PEEK_OFF behavior
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <20251115043533.2689857-1-kuniyu@google.com>
Date: Sat, 15 Nov 2025 15:25:59 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D16E20AA-9B19-42CA-A501-026E140F2792@gmail.com>
References: <3B969F90-F51F-4B9D-AB1A-994D9A54D460@gmail.com>
 <20251115043533.2689857-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi,=20

> 2025=E5=B9=B411=E6=9C=8815=E6=97=A5 12:33=EF=BC=8CKuniyuki Iwashima =
<kuniyu@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Miao Wang <shankerwangmiao@gmail.com>
> Date: Sat, 15 Nov 2025 05:03:44 +0800
>> Hi, all
>>=20
>> I learned from the Kernel documents that SO_PEEK_OFF manages an =
offset for a
>> socket. When using recv(MSG_PEEK), the returning data should start =
from the
>> offset. As stated in the manual, suppose the incoming data for a =
socket is
>> aaaabbbb, and the initial SO_PEEK_OFF is 0. Two calls of recv(fd, =
buf, 4,=20
>> MSG_PEEK) will return aaaa and bbbb respectively. However, I noticed =
that when=20
>> the incoming data is supplied in two batches, the second recv() will =
return in=20
>> total all the 8 bytes, instead of 4. As shown below:
>>=20
>> Receiver                     Sender
>> --------                     ------
>>                             send(fd, "aaaabbbb", 8)
>> recv(fd, buf, 4, MSG_PEEK)
>> Get "aaaa" in buf
>> recv(fd, buf, 100, MSG_PEEK)
>> Get "bbbb" in buf
>> ------------------------------------------------
>> recv(fd, buf, 4, MSG_PEEK)
>>                             send(fd, "aaaa", 4)
>> Get "aaaa" in buf
>> recv(fd, buf, 100, MSG_PEEK)
>>                             send(fd, "bbbb", 4)
>> Get "aaaabbbb" in buf
>>=20
>>=20
>> I also notice that this only happens to the unix socket. I wonder if =
it is the
>> expected behavior? If so, how can one tell that if the returned data =
from
>> recv(MSG_PEEK) contains data before SO_PEEK_OFF?
>=20
> Thanks for the report !
>=20
> It is definitely the bug in the kernel.
>=20
> If you remove sleep(2) in your program, you will not see
> the weird behaviour.
>=20
> The problem is that once we peek the last skb (aaaa) and
> sleep (goto again; -> goto redo;), we need to reset @skip.
>=20
> This should fix the problem:
>=20
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index e518116f8171..9e93bebff4ba 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3000,6 +3000,8 @@ static int unix_stream_read_generic(struct =
unix_stream_read_state *state,
> }
>=20
> mutex_lock(&u->iolock);
> +
> + skip =3D max(sk_peek_offset(sk, flags), 0);
> goto redo;
> unlock:
> unix_state_unlock(sk);
> ---8<---
>=20
> We could move the redo: label out of the loop but I need
> to check the history a bit more (18eceb818dc3, etc).
>=20

I did bisect on the relative code and saw the feature became broken =
since
commit 9f389e35674f (af_unix: return data from multiple SKBs on recv() =
with
MSG_PEEK flag) and the commit fix for it e9193d60d363 (net/unix: fix =
logic
about sk_peek_offset) did not fully fix it.

Cheers,

Miao Wang


