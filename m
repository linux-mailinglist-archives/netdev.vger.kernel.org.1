Return-Path: <netdev+bounces-106552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D8916CD0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E897C1C20AB0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFC49629;
	Tue, 25 Jun 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCawl/S/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5D45978
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328545; cv=none; b=YdYGz+HgltU+EgdmFobRR2lb+U0trfyMe197UTIgV/c+gWFflLG4qbmdRMPbYnPZVJa7xPXWyaUGzsDWmeRJpe3bbgJj/TednxktO78SOAwTaJvlqAC9tIL+nWy1p48aXzME8ANCf6HidyNT+jebIo1eIy0Kaqk+ureUcYQodlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328545; c=relaxed/simple;
	bh=/LlhogYLLMLmO4gbvWiOGQRvh20MdJ7Y24xcyMXrsQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hChyedrtTECU257qVyuBXzU46deo3hu9GV2ok9gt+IfymseiFJUvxJtkSmRCMF+9WNLLH4V2gFTfKTucFCiemVfvkKXuliVvnBA45pM1RBRGGBAcSFr7TcBe3mKers8kV6HpZmnpMqu6/QMCFGVry17bzXDObaIjyF3NqVqN1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCawl/S/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79c0f8d6ec5so24044485a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719328543; x=1719933343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhwX8bZt5jtQgWBmD+P9XqWFMaOyPTotaO8VOFUQrdU=;
        b=LCawl/S/uY+uVBAfpMjHp7cvzt+3n9XVQw9oMD6ugHzNbjke+X491Gpu8k3u/UDPwN
         k3AtN+g0DPSf+9QcYOL/1D5P34jP/tx4GrT1SWrVn9vV3NeW6rZVqUDjwmi7RccTSVvL
         dzF25QCtF0YpOWneo3aNSTQarJHYFAN7wW56YiEeZGrc5MSMwaV6SToRcgr7y/QBc9gf
         IA/5yKARJui/Gzv1yH7OmgH/BfoY6VrEAJ1o8MYMzjxykJ0oh2XtvhmzDjVylm1RZRdw
         ex+/wLZyiY8tRG2Hw0XVBL28qHAXyS8J4vMNWk+iOKrxFaiTxVD/OdW8uVQJyfN/W2g3
         gQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328543; x=1719933343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhwX8bZt5jtQgWBmD+P9XqWFMaOyPTotaO8VOFUQrdU=;
        b=rdr8Z+Nw4t0gYw0u48xDcKpC/JTNkY0h6PEcZBoPMyuDbQ6NASAcyFHZXVK6K3wxJy
         M+FptaBHml7Hg++SE8ey/IA8T63+LywM4+FZKAZemM5lnNaA/A8BTLmZmrWUhD8gf6lr
         FpD8IbhyGI0uJwxn8DD239ZqU8hd3Bz9i7K6sPy+zacWAkJSMa/5N5qKXiJLimVAa/cj
         0W+9PGXmoZ22oQCsJZT1T9m9Zqlqus2MzIDFb/mjADCnRYWrXRUkNHOAoGigr52B+0Dg
         fqId7Lcbejz5XfFqNI1f8fMXKxOVq7X2Lw3jlkkceNLG73RN3buRMPvi6oVYv1CElXcs
         GB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhqh6wNIRovtloCgjION4hkXZ5ghQ5HXmDx2NmlVAPuisZMujuPumiu18gMWgzt13CeQyZqybd0xiJrClVDIwi7zY0gxME
X-Gm-Message-State: AOJu0YwKRWB4zXstUkr++nkqkzlmr5lSl7a3dNGjIs4HBo1jaXmnQ3Wm
	mi6XLZoOCd+U/xqlq2QsHuOd7LIXqHK6Q1laUJEwohISQlmv0mP98wClJ6RI4ygrtmuq7L0S8cl
	W4ylyRRHM0HLEe3b6Qr7xWm3pqQ4xRXJJLj8=
X-Google-Smtp-Source: AGHT+IHCwSPLWE/gT8MS0BesOST9f+rCBKlQ48wCGuNVlPPWmzq8NxdkJh5H4hz5/AbbzdoA3hjv93pG1f+wNRludNM=
X-Received: by 2002:a05:622a:3ce:b0:441:431f:1483 with SMTP id
 d75a77b69052e-444d9224c65mr90085101cf.57.1719328542927; Tue, 25 Jun 2024
 08:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
 <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com> <DM4PR12MB50886C5A72024A6F5D990F86D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB50886C5A72024A6F5D990F86D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 25 Jun 2024 16:15:15 +0100
Message-ID: <CA+V-a8vwaCt-hspXhdrVSKzTYDnpn6ppHpGcpbD5NSgiQrGeTA@mail.gmail.com>
Subject: Re: STMMAC driver CPU stall warning
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Tue, Jun 25, 2024 at 1:11=E2=80=AFPM Jose Abreu <Jose.Abreu@synopsys.com=
> wrote:
>
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Date: Tue, Jun 25, 2024 at 10:30:41
>
> >     mtl_tx_setup0: tx-queues-config {
> >         snps,tx-queues-to-use =3D <4>;
> >         snps,tx-sched-sp;
> >
> >         queue0 {
> >             snps,dcb-algorithm;
> >             snps,priority =3D <0x1>;
> >         };
> >
> >         queue1 {
> >             snps,dcb-algorithm;
> >             snps,priority =3D <0x2>;
> >         };
> >
> >         queue2 {
> >             snps,dcb-algorithm;
> >             snps,priority =3D <0x4>;
> >         };
> >
> >         queue3 {
> >             snps,dcb-algorithm;
> >             snps,priority =3D <0x1>;
> >         };
> >     };
>
> Can you try this queue3 with priority 0x8?
>
Thanks for the pointer, but unfortunately that didt help (complete
boot log https://pastebin.com/5Fk0vmwa)

Cheers,
Prabhakar

