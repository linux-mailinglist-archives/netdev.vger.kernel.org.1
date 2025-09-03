Return-Path: <netdev+bounces-219663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B6B428A9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D861A3ABC96
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221873629A3;
	Wed,  3 Sep 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="md+9jir5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39322F3619
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924130; cv=none; b=TzI7jtPiTDNw/hkTW2BxbAzklgsJhjy7MlCQJa3UIMEpMC+prxchCaM2z5KeEvHasPWUBtaYu1fLFQJnBUsOFq3nJR8zT7k7jlK1efrtUny+IlkXLHifvaVsQrEv8uN9DTv2cCGvEkPIqeCN3rif8cXWyaHliffgUAcBXwgVv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924130; c=relaxed/simple;
	bh=FjHVk/M7R7cq6oenTQHnHeIq5ckPjb7qqqcOY6jQcyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwZMSPMA5qC2Lu/w6GOia7ZrzAKma67VxTf6gw6TNGWaYvZQYMG8Azx4fjPwpHpWZUPVUeWnBs6xMid8GzJ4XkkOGUcPu2RkS7CoLMabHDuyTVv134sSfyw2EbNQhIEtMJEWK78pAHmj0QjkA/dNZrY2dBrBfoLJSRyXnr0Zw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=md+9jir5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b21006804so2517005ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924128; x=1757528928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjHVk/M7R7cq6oenTQHnHeIq5ckPjb7qqqcOY6jQcyg=;
        b=md+9jir5LsycZRgJNKnGTJu0DtopN1odHFmsvIlIC22RnWxfcKs96niB12uic4o82Y
         zsx9mjJLLIE51+nbuf6wxFuP351ujACB8lx6h5qhpApLui3Juf0YMdzoQsVC9xWdCtG/
         JPygT0lUUGj0cE8RUHgfSEd2W9KNGkofxPX4VvHhjHR/lTYsm7RPfeCPpn58anct9lcX
         EijCkAnMBrPwtcoNbLtqg9YP6Z4YhI7pRXcIK3OC2XNhAd53u+FTnQ2IWsYdccXO8OiN
         A8mgo+2l7q52Ln25n5kAnKfgfQmRzfHVZ8y/4z+FiTVrOAsjKsnJCMzc7nbqgBWSGAaR
         pGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924128; x=1757528928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjHVk/M7R7cq6oenTQHnHeIq5ckPjb7qqqcOY6jQcyg=;
        b=dfo0o0sIccVooFhyiYdMBLBejdEbnaLBQtpqj97/Alm6nphsBaclIPvZivZ7JTyv5k
         Bncl3CATAWbzCOau3mFtob2AfXi+iw+MTeAlY6qb9Li/xbkahEQzI3W5Aod9onuVttzU
         NvE6r5QwtWHLQQo87RRSUFIFyDh38xlU9Cutp+y3dntgFkxUX/zO3WhDCcQOQfuXLBXf
         QeNqJ2+mqxnANOaEhcPUiih/fHkmipMi2AiIGRIux5WA3SRTbrUDoQfWUTK3DAYV4PFm
         3ULO6035kcQDd/QvcqKTU+VE3SytYFB8tcH/S5EAs/ut92UL0zfj9+3TFMNJ7ts04Ig9
         xSpA==
X-Forwarded-Encrypted: i=1; AJvYcCWNyNmO9J7VOvoPtvue64YbYQ1vQljSoeCujb3tQ/pcB8IsldrXFAHRDzXYN1qmRAi2E+A7Wrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+s+gTyfM99FolRz18DmfBwr1CzY/8FKcnL83zh5nj9wbYeHbP
	L6vGFPJgFMDpHQgnEtWa6dLIMJDDC7b/NDCms/u06HMHOPJnMbcdilWW1ut0h8TPuW955fSnhEC
	Hski5rxqDNzvtshL6nwDusRTeqJPzpiM4tvCtb1cI
X-Gm-Gg: ASbGncvsUgU6qHL0Lhh7zfGnxzzN7GkDPRoiQhLAuw+tnIdo9dM7NKVQW74BZnvdFV3
	Uu6+7BNAwvBDX0727ht72GsS0LypCRsSZQLUjCWIOv083OZtvFHAsDFhREad0mNJlgHhqbqWKoc
	/wZaYopHgT73DR2+WKRQtmQFfUacM9Rm0dSbDgQ+aFNFYuQ91ycU0j9ey9PnHE9mUA/iv18ilR8
	pHGUOKXN93wMZUTRsS4PV+ZrYecyQtwyEEenAPi16SZJF3MAoseifTgZJggZnodUdvjvdiFT8vG
X-Google-Smtp-Source: AGHT+IG1nKWDxbUJxqxs6RYKPRpHqJJ91jm62O5cmdOiCed2IZb45LyK9LKWlLmP01cUKiwWQG03OzI6UeIkTBpwbHI=
X-Received: by 2002:a17:903:46d0:b0:24c:9c14:5638 with SMTP id
 d9443c01a7336-24c9c145a13mr30662455ad.22.1756924127776; Wed, 03 Sep 2025
 11:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-3-edumazet@google.com>
 <CADVnQyn-=hBRJ10L7AapP4nuZQ1x38B=1+4+KdQgt0kDMo8MXQ@mail.gmail.com>
In-Reply-To: <CADVnQyn-=hBRJ10L7AapP4nuZQ1x38B=1+4+KdQgt0kDMo8MXQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 11:28:36 -0700
X-Gm-Features: Ac12FXyt-z1ST_dZSS6BnTz_SE0Nb-DaL4FJM0V62KC5KrKvR5TZB-cqoBCRD-w
Message-ID: <CAAVpQUD9iFBcPkfqODhB-yeD=oB0qztBMp2MA_W3Psr8Xv9fZw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests/net: packetdrill: add tcp_close_no_rst.pkt
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:09=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > This test makes sure we do send a FIN on close()
> > if the receive queue contains data that was consumed.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

