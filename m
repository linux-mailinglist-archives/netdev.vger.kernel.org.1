Return-Path: <netdev+bounces-233143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00294C0CF77
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714D4405DD8
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79F481B1;
	Mon, 27 Oct 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ7N0aWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF348462
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561085; cv=none; b=NI/AyFJeNeZRwagGd9JmsLv2cHuXo5wfxry4gJWrhh1tLJR+w4VHFSnQglbHekcthyRqKviKSzng89WO4e8wBxfBBcsI6MgtEoWKYtGlbT8+P/LfI6bYm42olrbkHPRXbbHB1q7n7u8iq/3jB9YzPGupTOf+UNwsYcFZQ5PX6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561085; c=relaxed/simple;
	bh=yOjgd65AX/9G+iFAaGGg1Tywsv9dT1W3JvwJansrcNA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=LlEyPBF1E1aVTSPeaIhW+FuPRCpI1JvN8NMISGJrS9VGz14LNUmrXZAW5k93Dv5n74HALHor7+eX9Jt+c8f0kyjM7mIzz5clXK6LDe3TxOOi3PanE8hYqisyjJ+MJr44nEmK0cj5NgsRDnLh5mhKij9UW+Dj8sqh+TRj9Au4cYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ7N0aWX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42420c7de22so2232351f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761561082; x=1762165882; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB4hYHGAySshbkpqu9mTFYkR7uKo2GUF7P88eUApjcI=;
        b=dJ7N0aWXnHwIwAYOYyheAFedotRGXpZ4CfHGO0g/QnqOS+fRbVCT5bRk8IbV6yBdV4
         a2/mdneCdcr+gGvCkkSGNV5f1flSvfvWNKBsL6OFUUD2dm7moMIkUHEofaxIKzCcDPEf
         E2hyiZLPW6tSK0z2xqVFVSdr5/KlCMBZ1wGLZfxQuKSw415/nxbsWMH6C3kvxedo3n2J
         dY+jVtADewqOKRVVYW9LWEVEh13KQv6h6+31TftFKquOPXxOxYsYVYHzAFzgIANf6GFL
         xUda49fbVEHyPtDVNy71Bky18dBUFL4MlBGdAKEK6iFhxGJWNflJV9tGlF7XFL/5etIE
         FWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761561082; x=1762165882;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB4hYHGAySshbkpqu9mTFYkR7uKo2GUF7P88eUApjcI=;
        b=KrUeVqGyIUW65cJ80/NM5ClPzgd4beTAhbSmM74IPmoTRJuVei+kQOlR0bWF0nlhT+
         PZc0339zEH0zjVL+/3giiSXP8QVouzNHFKGwnilBQe23mvdJ4zWDw4oY0wX/WPICmgu0
         mKPfHup1VdURdaPUzKspNGdAsUQ6L2t5rTueGc0iVYjeVok/qUYkeibMpm87xBmKY4xJ
         /VzGDtsvoXdnjkuDfhLDzgUm3+T//MbzGLT8c7rIS0Zm6mIIT98XLkdJsiyL1wMx4Zs1
         6SdwRFGZp38EahAt+MY3ucc/A+erX/A2Q7Kedla+0pu4NDrwzi68OZ5NQCCTynfVk6bo
         ZF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBmE/2/UBjrF0m7+p2UWXuBb6QhyfUuPpzvnPxiTU0Rnk1ySqHQkdoPoZNsf2MoYFGwRXPk6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbSDCv6As8x1rb10ktO//w1fneUuwokSyb6OIZEQ6JAsbO47G
	8QgjyB1E5gV6JAb0FFdfnTubiOoSxuwfHLkGcqT6QZyGUo12nMiupOn68ScUqvgb
X-Gm-Gg: ASbGncuP+Hudx2AGDSg857YYdCQjMdWHhVQw87ky+IIXwkJfat9MjUjwh+fCQhAR+gI
	Q/iHGGmJCegxX3H390f1d9BCxAMvG/PV08EDE74oUGcWAizcg/Q6VOjxx23oCordrcs5bxBNPRO
	NhB1ibD2GiNAA/ZuvHvKSWjPtHzSUUANiQNIG/SecQYHnJpgMoYDZVOrZPo7/vCr8EzASsgUi3v
	slmUHc3kewOxSkpd4qFfuBQ5Aie8s0X8JXAT1vvgGGuRRrWc0+R8WyGRKzQquTd/rYpjdZCWDML
	E4u5DfaDpdsyt7xI1PFNtQnxjgVRlCTEtNRriDqVZ483gMMzV9GWFyzznkWyM9ogpcSVvQ7Jyyj
	lfiH4t/ajbbZ5ZYSHcYzNWujcurB8WYHrI6U2Uoe3vEaIrICGbQEU7W5Vg+iazbb3EbacAGYqdp
	cxCkHQhz6HvAJK
X-Google-Smtp-Source: AGHT+IHiGX7gC8m53YWnXXKjnj52KAvR5zofhgEn3Be9IMKdYeTf+Sb3xajTMDBfradZ5gQAXzVt2w==
X-Received: by 2002:a05:6000:40c9:b0:427:7d5:e767 with SMTP id ffacd0b85a97d-42707d5e7aemr29240580f8f.42.1761561081446;
        Mon, 27 Oct 2025 03:31:21 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5830:b32c:9dbd:1424])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm13436441f8f.41.2025.10.27.03.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:31:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Netdev <netdev@vger.kernel.org>
Subject: Re: ynl newbie question
In-Reply-To: <MN0PR18MB58478446CEBD0532BB7CD453D3FEA@MN0PR18MB5847.namprd18.prod.outlook.com>
Date: Mon, 27 Oct 2025 10:31:18 +0000
Message-ID: <m2ms5cr5zd.fsf@gmail.com>
References: <MN0PR18MB5847A875201DF2889543A61DD3F1A@MN0PR18MB5847.namprd18.prod.outlook.com>
	<20251024080959.55e7679d@kernel.org>
	<MN0PR18MB58478446CEBD0532BB7CD453D3FEA@MN0PR18MB5847.namprd18.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ratheesh Kannoth <rkannoth@marvell.com> writes:

> From: Jakub Kicinski <kuba@kernel.org> 
> Subject: [EXTERNAL] Re: ynl newbie question
>
>>I think you trimmed the stack trace a little too much?
>
> Below is the full output.
>
> #########################################
> root@localhost:~/linux# ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml       --do rings-get       --json '{"header":{"dev-index": 18}}'
>   File "./tools/net/ynl/pyynl/cli.py", line 23
>     raise Exception(f"Schema directory {schema_dir} does not exist")
>                                                                   ^
> SyntaxError: invalid syntax
> #################################

Is that an old python that doesn't have f-string support, or something?
Can you tell us the python version you are using?

