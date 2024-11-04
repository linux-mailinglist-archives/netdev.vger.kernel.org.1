Return-Path: <netdev+bounces-141462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C249BB057
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59153283072
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA031AF0D3;
	Mon,  4 Nov 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15TwyIPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83601AF0CA
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714135; cv=none; b=GtNxIDoVxk2NNYJDJ/oB+oGOhsU5DbQHZEgsRahWMqPpsavickm3WRMhk+eu7VIe7q/N0dq+Xs+gas6kgK2pL+GiItrcw+e3p3wl6g4Kk4/UqjvJAaTolo6J0QqMuPASP/WY4rrTYgkmAkYeAryGWvcmOp+WMwg4n4MTt4s+f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714135; c=relaxed/simple;
	bh=xSAtFSAnkwh6AwNI4YW3YErmShzQiRDf0yaYvMo3UHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7gaxTRlVUtr4W+i4zcB2Q69hJ04VwcuW+nk1DmUc26yiXx1DX2wB+/pyiQu5Lzrt38W/Q8NcQkj9FLBN9c0NTYAbGJGjlmHR1jbq03Xxej8KgTS+WDQkzGHO8dhHwlSstiJGZG4ZyGlzVsVSiehba8eoWohoF8Zd8QgpE1Kxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15TwyIPc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so1797995a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730714132; x=1731318932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSAtFSAnkwh6AwNI4YW3YErmShzQiRDf0yaYvMo3UHw=;
        b=15TwyIPc6CVlWT/nmgOUltogkjgvmDf8MP50DEHYYL4qid+Pjo2u2X2xNQHWFMj+VA
         W5FpTKkEPl48k63ejcK8pnsU4fNhZjyzRyZBtFqzF4Hru4WBXb1Um993rL9KzCBg2Icf
         4DHimq5Iq7TUhX0x6ZU91pL1qtioI8gxV+94Dw9wyIjDte14knd8BAOyDnSXWK5OFOPc
         vQZNFZwdxNAZJh0a5+EgyDNvjN2FfbOZzptOoAMKiKR3W0ViFPAxE+Q15v8R7YxdwfI1
         l5sGwOAG4ppBQB728VeTp5yq7Y1jSQu4mfQBXquj+YiGDC6OV626Q6hLBUi0sk+aUuQ8
         zSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714132; x=1731318932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSAtFSAnkwh6AwNI4YW3YErmShzQiRDf0yaYvMo3UHw=;
        b=R1uXDAng+vHFVaW0meCCv8xywEbagQcq0vxMiSjlTGb3izKLLNgvC08CRXRU5mLhRm
         cKeDzYXDCEy09MInwmVQ792bEJag2uAuZ+MZaKIHPS5Dv1TKZEp1/aTIYX3rC6K0KZKf
         ITFOesgp4l/b3TWYnqNkKWfWKbjSibrbN2v2LN0cKJqsQwArcAORUPaVqxD6f7cEBDpD
         W3Mz4uT4SRzNFsOBTQHvDg+fcn94wo3b5qzvLJuxjvWp7vy28OAM7b32FEAGkKizHKJZ
         cXjDPqaCVw5pcmClkfozUR717/cW8wXGEb4lA3Z4mksi6owT+uOhJ5ueYZyUO3+DIxmd
         AlUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfdj/SBQvERpNbrPqKiCZzQVGu5b6pjQm+yoEo+rRVQhnjdV2quk7eR9ThZ/5wb0619fPB+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDedbdgBnJmLnszcT5GHdWliBCIEnS1+JOeEcalrAomDHUjg+g
	Eq7EaXPLKcSlThyrpFJJJ5eFGh34ODXfb4Y4fd+hPYK3+Ol3rh2DMWmSlaxr3zf4dhkJQAkG6zG
	EXUaZZ0Gk9z39V7spoPVSwRYW8G9RGfUAJuP7
X-Google-Smtp-Source: AGHT+IFQhjkT0LZZoC8OrBJvLyx0YFtWLRLnWfrUPFJMvFrd8IrlrZ8wGVUXlxqM34G4t1l1y/b+nKpYflGVAFlHjjo=
X-Received: by 2002:a05:6402:210f:b0:5ce:add3:feaf with SMTP id
 4fb4d7f45d1cf-5ceadd40012mr11520796a12.22.1730714131931; Mon, 04 Nov 2024
 01:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104070041.64302-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241104070041.64302-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 10:55:20 +0100
Message-ID: <CANn89iLCNoZBiodhJumA9-bbRzngC5BXJbWj2SieUC61r=ekxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: tcp: replace the document for "lsndtime"
 in tcp_sock
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, dsahern@kernel.org, lixiaoyan@google.com, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 8:00=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Commit d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
> moved the fields around and misplaced the documentation for "lsndtime".
> So, let's replace it in the proper place.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - remove the "Fixes" tag in the commit log
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

