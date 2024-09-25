Return-Path: <netdev+bounces-129825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F4986697
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F57B281772
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E46130E58;
	Wed, 25 Sep 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6bhlq2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37111EEE9
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290534; cv=none; b=IoDd1LQrYYXQhviUSc/05jKgwyAs3UOuQMmDo8Qbyd1FSZHgqGQllXwJGSpBQx8XbXKohbowEDlkpFhtRWnoW7kEkyMPmro2SU/FYbLfyJtcRRQaFlLPxcS6lw1kwbm7UFGgn2QdkBadzGNIZzAgo4v6PglDNkKw6j9mzTAl3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290534; c=relaxed/simple;
	bh=Zt8/rAhSAWDeZmOca4Bf7F2VJ+YmEYr2nlPgL3d/2qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sht7lXpiCYbTEnb8dhxtXAfT1GzbewyaAcekuqiE9Fbiynx1ej3/RSm7UKfSbHwKnazScPQ8CEDD3cOMoBZfHjJc5SUnm7p5Dn+xoyYUzgpd4BS081zPA5yUj/54F7MHVKcT9xG9s5U+P7KDgGPUz0otOzwJ8FFrjJh3fswvJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6bhlq2/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5356bb5522bso226842e87.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727290531; x=1727895331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt8/rAhSAWDeZmOca4Bf7F2VJ+YmEYr2nlPgL3d/2qw=;
        b=r6bhlq2/I3SJ4BDyZsRg4h6WeaYA0KTDpfgNwQWSSsuhIHyfVGqEOZwFry3FZgheG+
         q/9it9s5dgCaQ5ObZu3luaOzn+O+VNATFHgCKmFDoYKvdaKCSyktYTCzOrmYSsLaFVtL
         ntj7kgXarQY/oZDhjMXJ35bg4X0EXy+0IV7KBU+6HuIpdPzwPr/w6+K7z5AiM+9213R2
         8PeRvaCp75lut+MlIoz3yZHicgBhVBb+/Evo/8cioBXi2JEe9M1LB2scCT8vqX1YBp78
         67CE3CDH/tEaIdZ92aseFjFxVi61hp3JIJNHcRWhNGbaNqrpzSO59gqwe+5YKn2aQbz3
         e9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290531; x=1727895331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt8/rAhSAWDeZmOca4Bf7F2VJ+YmEYr2nlPgL3d/2qw=;
        b=TEx4p2g7KJuGgQ/cTOoBJPsjBenbCC6gsva/MvwfREOT3AUJT32AL4sQtseoP69XPU
         zaoS0KedvWSUbqeCF3fxWVM5sRZJ9THNB+snsgSGFmv047w89N/FpmH9k5XKt6B85Umb
         NmR2SgPn+zFNSrhZf5ozyWCUVrUPjkDhINZdQIdq6IV9XCqc0/lti6Xj9dOlIkG8FEy9
         9IehzGj13Rv0BJbOQcWuUmOVavMHx4Fa14WFy/3oBJp8Jgp4QR/E9q+257XUt2bT9ZrB
         /z8b6u6quEVL9/ja7KUjDys6S+Fi4u3dv2kbWX7/GVbZzfm14L5TbxDOGecFb+UG+sgL
         UZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXiDCk/odgTpGW8g5zbh+mWNUCy6cKx9SG63lF4kXoFoi8A7yPPl/8TJYftH0SlSXdx6gLzVmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTV0EUNOp5fUOkv1uz05quxfezaNMZGdDDDkjffZxkePSQ63+
	WPyQ7uDf8i+WcdPOWjUP6kzP+GMzURJ+18jULWMFFTG8nZyqqWgf+PSMdZFanegAcrF6MGvD/aA
	Ep2TyH5sSbvVPt8f4w1Jfk122gFcKin7MZnUE
X-Google-Smtp-Source: AGHT+IH/S+tAQgecGTR1SoGVP/pIQ5w2xb/dpf+LifA4G+1e8jTGV1BYw7P9Sv/j1U5ojzTPH6Q5IrouDIRs55E7yco=
X-Received: by 2002:a05:6512:3c9f:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-53877565f1dmr2471966e87.54.1727290530451; Wed, 25 Sep 2024
 11:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com> <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2> <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
 <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
In-Reply-To: <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 20:55:16 +0200
Message-ID: <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:24=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>

>
> > git log --oneline --grep "sanity check" | wc -l
> > 3397
>
> I don't know what this means. We've done it in the past and so
> should continue to do it in the future? OK.

This means that if they are in the changelogs, they can not be removed.
This is immutable stuff.
Should we zap git history because of some 'bad words' that most
authors/committers/reviewers were not even aware of?

I would understand for stuff visible in the code (comments, error messages)=
,
but the changelogs are there and can not be changed.

Who knows, maybe in 10 years 'Malicious packet.' will be very offensive,
then we can remove/change the _comment_ I added in this patch.

