Return-Path: <netdev+bounces-159328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF788A151EA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC827A256B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B81422A8;
	Fri, 17 Jan 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9h8qe66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FA20B20
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124510; cv=none; b=YYEPWPaL89fc36cQoOKgnjF5hfFuWQYewdXFms7BqRkNWYqvX6XZkcbCB+9RoPnkJ5JCT8yAjQrbUHusoLLRK55XQjE8yW5deIC7uznhDN8DG7T1tueI1rDF1ui/TScefrMV8E/aehdigACdOtE0YjGuOlOU/U/vz27TDzcoHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124510; c=relaxed/simple;
	bh=RBOmzvdf3GotooCuHS6i9sK/AMVSIf6owHWDeBb0YBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKZR0MVRXD/oDrbYBZ1HC6yAHOfbymgRsSEwbRV0NIMco4lCNQVJgQJWjhAQRrVZa/t1gPL6rmi6yx0ufFS3X4dL2KSXKtw687hXBBaPz86Q4vW3KZ1KLyG95qmuOxQ9CRqOKKGfgGCMGcPsEKJJTAt9Jq7cTsa+J+hvjiIwm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9h8qe66; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4678c9310afso211081cf.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737124507; x=1737729307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gkmUH6rnCH4M7CtAF8xgXNOL4c3VMsXAk8tY0xp32A=;
        b=d9h8qe66qAtnjuf/7OP/6yhQ4pt0S5iM0byZZgdADYIvO1/9zJzpVH8tUAXAI7fLbI
         Y/IP8B5NcR6/DCDDTSNG7khFJEJ5vhj12TWrS5P5IGpe4clffv55QVg2KxxUkhkP4Mvk
         D4OUoe+wSs5VJCM38Nds3Q4/YEZaBDBsymbEB3o5c+777fhOld1+CYqdF6AdHhh8BSiU
         l0yHlcvnzr9z/1nl9hzwaTodTFtF8wE25QYAZ6U9iPDrSzF0X03CSlsHMTQ/6sZZPnJS
         DdjhtWJs6/FZQbDMh0RC/sVDeo6XpOWaUxI7EPOroJwQ3oz9iYjfJQ7ZC0FvIJ3WjdFb
         p8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124507; x=1737729307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gkmUH6rnCH4M7CtAF8xgXNOL4c3VMsXAk8tY0xp32A=;
        b=kpAsiHanJ2BChK0DLkLzYDVHZWtR0wAdNEDuxEm/GDBsfrDR7hdd0LTS8TRZwS3Xif
         pm1xQMe2LN+GF+e3KjpC380tpo1QPTefd5fs+kZ6cIFd58AVVu5UKhRX6bTtA7FLZws+
         DiFez2WUnrrr9dnGS4QIBX8H/f+keg3Tt9MoQR146tZKd63W0pQ5u5NobSbMNjBh2KeN
         uHDouu6qOXWuLJtMQbECKI5O1f/RzZhznaIZpw33xeN9Rnx9BatDeP7ZRioEiaUNOZRp
         W9mFDHA1LaYp24jKrtEwGOb7GPS3klCTVgMQ56IkxD+qAdY+oBgV7PRAfBXhej0JQtCy
         BE4g==
X-Forwarded-Encrypted: i=1; AJvYcCWyX/8jn1JPM96L3QY1EQ9yviY6VzTaBv61BniSyO3tcCkygj9KX3ne3Yu/6/7G/jduEwiiY+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWu6JGXooJbuq0fZ7UwfCieM+4jhNKobMyEsOxDoSUdojPazs
	qi3eQtKfrrdQLhSY+GDajKzU4oLKBdlRTNul6A9RIHeyEyvnfIPVlANJtaDFFDmqKU4fP2IREsH
	8cqLAIvZe6xWZeUhyFGjOdc4eCPMyLqfTeUxV
X-Gm-Gg: ASbGncvWmDJimveWhacvaxheISX7H4XAfvRpTn+Ocdlx5tZPnYx1E2BJnI0GFGVQ9ZB
	1nPYXmPcmUB6kvmk9E0XUHOQuKrnOl5pxIzW+qC7KNddRMMfcS3SM2lAowcJww9Ne6kAdmQ==
X-Google-Smtp-Source: AGHT+IFpXDDoYyslWZd0GxM2rONI8ZPb3ET0Yyjpp9+Tfzlqt6W5LwAD5Q/fPjfLMY9j5t4ZH20hiXtNEQVUbR/OWtw=
X-Received: by 2002:ac8:5a45:0:b0:46d:f29d:4173 with SMTP id
 d75a77b69052e-46e11a9da9cmr3926151cf.16.1737124507171; Fri, 17 Jan 2025
 06:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
 <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com> <444436856.605765.1737101558108@mail.yahoo.com>
In-Reply-To: <444436856.605765.1737101558108@mail.yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 17 Jan 2025 09:34:51 -0500
X-Gm-Features: AbW1kvZiGaR_OzTqJFRHP_xMfA7jcRNUL9bMqPfL35PzTNiLRCg8FjeUal20xko
Message-ID: <CADVnQymhhNG-W0XAMC-=ptANc8meG08yi2z-C9-+M0yc9-oSMA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 3:12=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo=
.com> wrote:
>
> Hi,
> >>>+ What is moRTT? Is that ca->curr_rtt? It would be great to share the
> debug patch you used, so we know for certain how to interpret each
> column in the debug output.
>
> Yes. moRTT stands for ca->curr_rtt
> t stands for tp->tcp_mstamp,
> c stands for  tp->snd_cwnd,
> i stands for tcp_packets_in_flight(tp),
> a stands for acked,
> RTT stands for (tp->srtt_us >> 3),
> minRTT stands for  ca->delay_min,
> d  stands for  total delivered,
> l stands for tp->lost,
> tRnd stands for ca->round_start
> Please ignore the rest.
>
> >>>+ Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of tho=
se tests?
> Yes.
>
> Best Wishes,
> Mahdi Arghavani

Thanks. Can you please send a v3 version of the tcp_cubic.c patch with
the tweaks we have suggested above for the commit message.

thanks,
neal

