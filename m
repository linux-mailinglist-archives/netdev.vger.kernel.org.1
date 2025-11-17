Return-Path: <netdev+bounces-239001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADC6C61F81
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 01:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84416357CE8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7291DE3DB;
	Mon, 17 Nov 2025 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giuspMsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396015A864
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340803; cv=none; b=B/BzMOtvqVXJMNKBMm4e4PW8XKB4zHqOklOKAREoI27cefDeQULB6LC4xOWN7fI8PKadMWUUgVVCeBClyHMnuGm04lWDk0530EtQM8LazJ9ufh/DEi7XgEkyA7DtZdFDyRxJdPEeJSTYR5DZIzfprdhThPKJIXffYabC41FPo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340803; c=relaxed/simple;
	bh=Kg5z1iMcsOLKMPVWTEPh3dJybVe2996SFQHo1OWCtPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0moBDpSIhfxIlMeQk8XF+s0JyddAQGTD7XCXbmIvjc2ULXndNesuhQmHsyC+fQADYlFqd2I99QUtxeiZpV/M8naqZ5UxnS/iMJFwk9/tWTJy0sQ7SdOG/0PUa27cychbsH1t/1Sd2iADLhmtymBAEfia7Hq8w3vMzKoHwJXCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giuspMsB; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-433100c59dcso15703955ab.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 16:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763340801; x=1763945601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg5z1iMcsOLKMPVWTEPh3dJybVe2996SFQHo1OWCtPQ=;
        b=giuspMsBq3z4KIkvK7Fvi2RSX+HQol4mopbwvCMd9mV3IjLB4vSAqv6RCBustTHNKB
         5yIEtwwYzEoB8V/5hwRehMimXmtuO106zi9HLAcjZGrfclfBzroQsqoBWikWah3pDkVC
         atEylk0ou7HHspQW1qHPNhq8GBi03TPJqXyO6srwWbBUSQYG0D3OryH09Ek74gsmebPa
         W46e6SMd2Svgzt1nqBtepfvfHuqk1eFenqBN14ToIewZRcmQXSsv4LNQqm929IpPNH8R
         bELN+0ipqdGjKY8dNpEz/CLZ2Pm4GQwm5eOfoZ6yUgKp+2dJ9rQbjA6VVmCiMHXDKCSu
         3+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763340801; x=1763945601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kg5z1iMcsOLKMPVWTEPh3dJybVe2996SFQHo1OWCtPQ=;
        b=dR7wZr84uVC4D2UNe3RFgul2zAqoR3HV+YRMFuwGRhv9tz6eNElmdS/ELRIOFL3Vt2
         k0xyFvUNZZQsqdXf//kipN7Ri9JCiIVhHxVQnuz5yp2bl01yA2fntCfPg3QIlLcx+usw
         Ww/zuQSPyesaBN834ly4S8kwgAdTXjFe+XLO2xTaWbs48DHgAa1gwGMl2X2Nq+ds4fPy
         rRMW8uzFwh8UJRMETneJlNXbPLWgEscwBHjZOlfsrhkt145xrUk2P826aBlZWT/+t0eQ
         O/yLIXR5UiYvMivOR3nlTLkc+WhZMrEf4c1xXibMxfMc45+Aw0wrXLa/scoKGkGMutft
         IkHA==
X-Forwarded-Encrypted: i=1; AJvYcCV6pbyptDEb5ewB1cX50CJo4u7+tF9CtLQTHQ+5pSso5Uazzc9XlmVsMMDwY8Ad9+j31hkOIGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoOWQDyuVTaFDX4iVZV0/ErSoMX9wfw5DWRBTqDR6kDAv5BD1
	olyaDwhExAUJSHXUFHo0TCQ1VyRvM6gk/zLS0MKf5yusaXNsXeeAJUFBdW8jLfhEDcKhsTU6pA0
	CLgPn7zaL7spmFgZaY0GMPHGa+kvlbYA=
X-Gm-Gg: ASbGnct6MzlR9Z00TVYss3/CVLpXKNUdFoBtu/ft+ZjlUx2u894UDhjpvXwHu/zwPIk
	UF8IBEB8ghrcpOEHP5egNr8eH3EDHiH5Gimo6Ra2YFXiYOK4VFJMxUOSPqr1wcecr5Oi8CnEyuf
	vMEVN9xi8SxNFEjtpFXqFziCarTd0m70z6PVwckQxMgL2HVNXLdhNeGgs9yIt0LqrtXN/qqhs/g
	i4uuiD2nK0CTCB9xDA0pdGMODVIJllBSJ2vVz3BJkQAbZuAgB0oi1pSAD9wDIXdmO3/uQ==
X-Google-Smtp-Source: AGHT+IGNRhQi6urh16RftyFqqK3bzqL4Mu/7CPMK+M82nGAG8upKW0LWbvnUIaGzHMpkUIdk5PmjhATsCd6oaNESFBw=
X-Received: by 2002:a05:6e02:3f10:b0:433:794c:8480 with SMTP id
 e9e14a558f8ab-4348c880e53mr148686865ab.11.1763340800900; Sun, 16 Nov 2025
 16:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-3-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 08:52:44 +0800
X-Gm-Features: AWmQ_bkRRkJ8RDNJxbh2uZKTk9pKXhjAwMoKqRUta2D-jE5HaYmTDwabQbzO2LU
Message-ID: <CAL+tcoC2o7E54Sf4VSSckOEpWxAPPQ-iaKfsFjGZ71njtk4dMQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/3] net: __alloc_skb() cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This patch refactors __alloc_skb() to prepare the following one,
> and does not change functionality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

