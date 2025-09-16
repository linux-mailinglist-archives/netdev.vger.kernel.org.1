Return-Path: <netdev+bounces-223757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9342B7D5DB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9333A4DAB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382C27874F;
	Tue, 16 Sep 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxKy4Vrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B781D2FB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061004; cv=none; b=WEwvqyBs8yhOCyhGvanVB6f5c0bKfspnY8ixAbfmLLg6dKBT8p4hDdIk058EtvFIGcvIwobGpz2W2NL/hxMRGfv58EmAZ5HJgoaAqNcEbOjBs9ETc3AsVPUAUtOyhy1AQtfzOBcUalxmtcCOk2sczw9+4HdK6kEvxqW7akH0dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061004; c=relaxed/simple;
	bh=ZhrtNX2kW4+SEm0NDR3oatPjuXJvSmAGowa5Ma02sfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQx5QARNO3SYu1/HrIN8JfxiVGJGnpi5y/xfpwfhK4cLLXaBeok6Wxs5xf9UVNcohQ1B+qjMJAT8jani1fECga8ke8FybAIHqlXlmOBf9BK3Mpmucy7IuDAKHyew3HgMx8Ke60T/lDHAzxvQigfQwwsXDS3ldb+gBOfdXNkE5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxKy4Vrc; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-32be6bc21c7so4356716fac.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061002; x=1758665802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykbi9ORR6F/chC/kV2ctSfLFRdnZlKnXwUjsJoavaTU=;
        b=SxKy4VrcMoh0eYAxDY4MNWX9pcdyCoEU1I/knjhVy4Gyv6q2WMKcgyaLgu8fcMmpIk
         21C0dobTWZluv6lDhyonKKqpL3Unf/xSfT3uA4mG2fD2rwuU+ClLK4g1kUOD7AuBVJNo
         I03OBZpoTnd/a8NdvdO8XrMhZUxw2nYgyBztTETTU3XJYs4huj2OB+nVXtviwEH2ApQl
         Wwvm7g07JGSgJ7SM2n9kMRtC7R3B+RXOH1g/YPczazQerjq4ON5AKE6Och+qeA3KSFl8
         JegJq42pmGzSvK/xh5nia89hTI3A/M6gChlrE+6fgoskzRRM/UQzTAdyReEci8q4/O/s
         MKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061002; x=1758665802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykbi9ORR6F/chC/kV2ctSfLFRdnZlKnXwUjsJoavaTU=;
        b=rSsCjmNxNCc4bL89lLV5vgv4/xUoY5/7d1bBKavYXEzMxR4IkiKuoIVJlLabJ0WSo4
         chSTvKA9gjnUFTj82tfD3j/IJev9zovbVNqSZr9Q5ycEOJ1U7c6x/L7nH1BKqXErxvjH
         jVGlHc/fgQL8cS2nInlW1+0LhkBnhysAXy6oAJZhrkEn8pKe1I6auvUbmTklmOfrPe+Q
         dKrxfW4n2B95SO0VUvrzUOiSi7Yl162P/QH+jrg5Q+3jn3Jb9vrkIMfJ0GYzOqNctsTJ
         e2AyT/KU3bDTykPTNKlBakEJOEDfozdp8gFcpt2PpSvJQlvMwQD1QJGYRRFbzbioUUSh
         o1hA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGibb4OIWYosBhqwFBOP1HrSXe5AGNyl23hmtmsvwg5VlGzlz5NpLHmgMgmhhFr7kKVQ6aZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeWFX4qGeaLckT2WEsPJNu65Lbvo+/wpnpeo6QllsfuJ94oTN
	/BB7Q26Re83h2gUMqJF7AsoE2P2osKxtzFKDuQxdasU9T7rIT5/DlvbB
X-Gm-Gg: ASbGncsB5+pStGKCO7v2UODI7gfpBjf5TzEn/8q+fqQWWvgviy5poKJca03HYlFA4eu
	G2lwUSYag26u82adZ4hKaY2HRuDU3Vi2ujEESehOKrS37TaBA23FfTLrG21wCHu/jJ4oB6DJzx0
	qgKOIPqDf7QORKd26QZR8K9taW9BaFuazn5vYRjChFzSfPhiekRyLcuBa0ciQ7e0bQQ2Cb7tRx1
	brVOKZhU//XavaQQ8GD7oKEN84Wj1uv+RC86I3bA8RI/8NumHmQvPoeNE8IdzAmqq53+akRD9oB
	PvIRPs4Qiw8d437dMcbEOSKtvhc5xwcc7rVT0LGVvb0lcRJBGRYFy0pf9YqjPLdny+jSq3KJOrJ
	nNoP/8XYN4NKGhgJS6FVf9A3TLlz9mW4yNTQ/ZFjbYAV1N0AeKbOBEsQu1Dm5DGzXKOMCF5f/tu
	gkktIGEwPHfEfiRd580H8zc7fCnq5G2kJM3Vc=
X-Google-Smtp-Source: AGHT+IEZnSDUvYgihKJtLaN2Xpm1odOGPMiQ/3sbr28jrHO6rgLxPXvbdax1sAYKsoitj5HevBF6BQ==
X-Received: by 2002:a05:6870:b251:b0:2d6:6688:a625 with SMTP id 586e51a60fabf-335c014cba9mr29867fac.37.1758061002296;
        Tue, 16 Sep 2025 15:16:42 -0700 (PDT)
Received: from [10.0.11.20] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7598664d715sm1707318a34.0.2025.09.16.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:16:41 -0700 (PDT)
Message-ID: <c36676c1640cefad7f8066a98be9b9e99d233bef.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuni1840@gmail.com>, christian@heusel.eu
Cc: davem@davemloft.net, difrost.kernel@gmail.com, dnaim@cachyos.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 netdev@vger.kernel.org, 	pabeni@redhat.com, regressions@lists.linux.dev
Date: Tue, 16 Sep 2025 17:16:40 -0500
In-Reply-To: <20250611164339.2828069-1-kuni1840@gmail.com>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
	 <20250611164339.2828069-1-kuni1840@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Thanks for the report.
>=20
> Could you test the diff below ?
>=20
> look like some programs start listen()ing before setting
> SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
>=20
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff
> *skb, const struct sock *sk,
> =C2=A0	if (UNIXCB(skb).pid)
> =C2=A0		return;
> =C2=A0
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	=C2=A0=C2=A0=C2=A0 !other->sk_socket) {
> =C2=A0		UNIXCB(skb).pid =3D get_pid(task_tgid(current));
> =C2=A0		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
> =C2=A0	}
> ---8<---
Just came across this when troubleshooting a resume from suspend issue
where I'm get a black screen after suspend. Initially saw this with my
distribution's(Linux 6.16.7-2-cachyos) kernel, and confirmed the issue
in the latest version of the vanilla mainline kernel. Bisection is also
pointing to commit 3f84d577b79d2fce8221244f2509734940609ca6.=20

This patch appears to be already applied in the mainline kernel, so
this might be something different. I'm new to mailing lists, so wasn't
sure if I should report this issue here or start a new email chain.

--=20
 Brian Sampson <brian.scott.sampson@gmail.com>

