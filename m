Return-Path: <netdev+bounces-216946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9DB3647A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98117BEBA0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EEF269D17;
	Tue, 26 Aug 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/p4mXQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FB2F60C1
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215433; cv=none; b=hb8xoNMyGY5bn088Xrts8aZZts7vhKFDqXXDCB1PD2LPKO/SOv2wIYIylLQYLjJYJzgY9YcPQziYidxzvo7j7bxKU3FPPiXOqxAhGl0O1El1DK/buPWFTVrxXXvcdNmA/KFQJpVeRuzhqwmlydG4kpjlxYnfTegubg4K5sWiHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215433; c=relaxed/simple;
	bh=UWKcaQet9GG4coXO/bspCLJgGio5qNvxiIgBeW1qqtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOPOrKK19zQgEwfc5U5IUDDhDdbuFIozieqWcErUGGgogUcAmxEZ3UcMtryG/reuuhOYoNho/EmlCHeq9c4JNI0Sq8TFwbqZHu6AO8zvRg2SWJpxPYRN3nvH/2aUFQEoIMQG79qEPnPA2CzELOOMrw9MeNZScW8zSu4Y669BGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/p4mXQu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109919a09so70334871cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756215431; x=1756820231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWKcaQet9GG4coXO/bspCLJgGio5qNvxiIgBeW1qqtI=;
        b=K/p4mXQuGOFQHci8xWo4hdz13MOF+8fmXVvCiDYi1cyGJAjhID0n/3jEoLzZV2Bese
         Ezm3yLuuH0y4jKNKKAUbjJEiq9Z4r+u/0TSDgl7iqsYwZjDaqrv9ZCNKFGhwSCJrzwfa
         a5nPahhWb29H/wJ4AlD72fS3f/P41qT2v7BnBwsms8yogVQDfYcXYGYdk3NKVfsfTf5C
         3KzT1WeiCc8vWfTQwFTd5Ixn2yJqlBOSTCKQT4WP2pX2EQn0eKV0vQFy+QrWHpUb3Rp6
         3/jSJy+Jf5eI9V41b+bsv5WimvETqzPzwpapCOqDepyicjWThskjUnDMvri2ZnSBxuun
         +toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215431; x=1756820231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWKcaQet9GG4coXO/bspCLJgGio5qNvxiIgBeW1qqtI=;
        b=SBvbwSq/qw0qqGxDBqGNCTgOLpSu1isGMSyGoxMtjSNT3zngFd+9Wa+ydM53Ryg/yV
         g1BgjZWp/4zEkxnrbV9ILhH/TUMcpSwRlbX3bBbOJpPHh7ugUkKdrGPqzoE+jRUmfkI0
         br84SI5aLFSvT4zcZj3OcqrwHxoCqS/ZxCpVDZO0aAQnMtwDAkQSrPWWAjSW0VLZMbhy
         94Xf0CqZLchmMaqyuyxCCZknPlbeIL3ed5eT9DtgX+z5Dzz+FcLvWyjKMdcKIfo21prj
         K5e4uwmeFPwpq1gFucQFA076VpuxXaAu07md6W6+b1zO68apsgNO59KgQykH1aLKpy64
         22tg==
X-Forwarded-Encrypted: i=1; AJvYcCVIPnvC5oJMrrqU5XrqU7gySTr88o0oez67lrZqbwsZW/L+3nNG59wELKVdZTpXnL5eLElR704=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtm5Fa/0NH0Z6whAAIk4+K23dct9QxFyp75INmYXebYgFdb2B
	sDrTkbhDRCd4YRTQPWs5fYXI0kRSRhsLHq18c88BdnNAYGxKknKo2sEzao1UEgU1kabACzPl/2U
	LsWvD7aQkvYJDJbnCbFI/NvaHbilwtVTdeMZjhXKdRqHhfEtgFRoExI/hrio=
X-Gm-Gg: ASbGnctEcRfs0beagHpJe55taqkm9w/07oOZE2Mxj4dBT/SMflmR9plTE1mk3kPsvrp
	MnBWk8Y1iXtHFuXUdCbyEbQxBDWTw7AFPCOvkQVSuDHCBeUImZymvC+FbMhO8o5DgYlmlKYJAXl
	Idgtj9x+1bFD7i6oFkYj2//ii281crbS8AnN55nqzqDbMX08Jh3YI0x6y9gAfyBdUt9tCucR+u9
	SrWMP7xfLB+
X-Google-Smtp-Source: AGHT+IHrqOk5SmffLvdK/bqJjBp80w2upAJzBf78+g6wJP/zWkCTzR7bBDn1IaMjULRpq6wErimmbZnDFHc4midNifE=
X-Received: by 2002:a05:622a:1ccd:b0:4b2:8ac5:2584 with SMTP id
 d75a77b69052e-4b2aab78871mr169722741cf.75.1756215430791; Tue, 26 Aug 2025
 06:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fff0b3eb-ea42-4475-970d-30622dc25dca@free.fr> <e92e23a7-1503-454f-a7a2-cedab6e55fe2@free.fr>
 <acd04154-25a5-4721-a62b-36827a6e4e47@free.fr> <CAEoi9W6kb0jZXY_Tu27CU7jkyx5O1ne5FOgvYqCk_GFBvnseiw@mail.gmail.com>
 <11212ddf-bf32-4b11-afee-e234cdee5938@free.fr> <4e4c9952-e445-41af-8942-e2f1c24a0586@free.fr>
 <90efee88-b9dc-4f87-86f2-6ab60701c39f@free.fr> <6c525868-3e72-4baf-8df4-a1e5982ef783@free.fr>
 <d073ac34a39c02287be6d67622229a1e@vanheusden.com> <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>
 <aKxZy7XVRhYiHu7c@stanley.mountain> <0c694353-2904-40c2-bf65-181fe4841ea0@free.fr>
In-Reply-To: <0c694353-2904-40c2-bf65-181fe4841ea0@free.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 06:36:58 -0700
X-Gm-Features: Ac12FXyf89HBHm7imLexRw9jKiyzhTuYmW54Ay61Lj-JdQeGJGH0d8xxujuA8Dk
Message-ID: <CANn89iJ6QYYXhzuF1Z3nUP=7+u_-GhKmCbBb4yr15q-it4rrUA@mail.gmail.com>
Subject: Re: [ROSE] [AX25] 6.15.10 long term stable kernel oops
To: F6BVP <f6bvp@free.fr>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-hams@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Dan Cross <crossd@gmail.com>, 
	David Ranch <dranch@trinnet.net>, Folkert van Heusden <folkert@vanheusden.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:31=E2=80=AFAM F6BVP <f6bvp@free.fr> wrote:
>
> Dan, I thank you for explaining why the patch actually did not prevent
> the bug to be still present.
>
> I captured via netconsole two occurence of kernel panic that did not
> follow exactly the same chain.
>
> I hope these files may help to find where things go bad.
>
> Bug is systematically triggered when running netromd daemon and
> performing a connexion using ax25_call()
>
> [syzbot] mail reported KMSAN found uinit-value both in kiss_unesc
> (mkiss.c:303) and in mkiss_receive_buf() (mkiss.c:901).
>
> However I did not identified the bug.
>
> Regards,
>

Make sure to add symbols to these logs, otherwise we can not really help.

cat CRASH | scripts/decode_stacktrace.sh ./vmlinux

