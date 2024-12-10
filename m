Return-Path: <netdev+bounces-150726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CA9EB4EF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8568F168482
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4C1BB6A0;
	Tue, 10 Dec 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="lIPzDDdG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6E1B3924
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844553; cv=none; b=KkoCEYTD8gdyv+d/vycBdp1zU1rSN0sA0HRYkzNAGCmsVnvHVyQmd7qAg7SBvYlrRAHxEBs45ilTlZFSF8PILomn0BRAo2uiDSZWhec1xwcv8zWn093k6Dy/+AgPouspRJ0sJeTzi+TAV7196N6o3UHaP2ZjifoNQI9iLuqRv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844553; c=relaxed/simple;
	bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWkrSfiFBuha1Xqc3UwRINyPrcr85W3Yy2G7J01y0t3xgIsNp8Eu+1tg0lVeXT0DrHkPtMr3fr0p90w30cTqwDaznVej+gWru7cr4DhwjiY4l0IZKkqEHlNC24GgzjLrZaDFaF4Wvia7tFJiIi3sB3eWR7K2dZq6YV+55Fwimp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=lIPzDDdG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467666cc5efso1821041cf.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733844551; x=1734449351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=lIPzDDdG+CPFJLeRFEhVcbofmEGtJJK88NVY754OdNlLRd9VKojIBZBv3k8elwwDPp
         hMCuB+yigMWGnH2XwWpdGaib/CgUdAFdioR4Ni2UULhO/D+UAkHhj0hfCjMQvrADJs2e
         9yGjrh5Fj0SylFY0c++Xr1R+DatjKJ2zn7dBvubth3oe1AbcWrtU91RUhEX11kBjIwCQ
         5O/CVXGOp3iMqzkIoepLLJWHse76B+RKRoOP9ohseQzC5eMJssPvulOMfTMWRjJ3/xAh
         s1ZJsYAoo+rkzZbtTO8bPkM333CZrKIQSAdxDQc9varOQn3VLiBchI+iFTmhIR3ActWV
         siew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844551; x=1734449351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=u8oMfkRh28pw09E2jehwQIThNzJIz/vr9i5K1IMOLRoXqEOJvedgWLYpRsAMD/QGQd
         tgiaScfqFuDNayKVbIMrKoNHGAFOtYPAbiI3RYPlo3AcCfvbGXRdxYEkbNxwPwRDjWsl
         jKtN1XO+gvaAsWL2Qan+rqKpB4Vf78SIXQzwgDf0YCEBVVY/V4DChV95t+QT+vNsfEzl
         VWVUkEqh9bxazaJr8dvUMGl2M0tI179aX4FAQkgcaeV6UD0ikEe2TNS5nqtPZ5dMx4Mt
         w8XpWMm1c5NMivdqSXRLLgoxR4mDKAI+WobOTFXJ5VA9BSI6i10hqgSXlrA2MURygG+V
         rcAw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9UvSJVFHfGqX5ejzzTyxDjQZYFJBR47VXNeW0TnsT9lXVpukOifDWu58JBgwc4mRAxy7Dro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNV19d8RHUMvXlK8pPzhhS+heBHx8OKdFuKwFY+6NZDMWHF+pk
	F4LGkSV1H8VS5eIAuNj24HCqUosGiXpeD6shfK6HAnLn0LOX2pMy24tVgTn47SKeekrAjde3psv
	8xJBWqMibfP98+7Rkv6jxnKhAvwYtfuYaWpL1OffBfVwrtf2pKjb/gz2zwx7O9TgoX3BNL6lWI+
	LBlrcjRLLKZ8UHSbAEl2AtkA==
X-Gm-Gg: ASbGnctO8M8Ib4GhRbYCsaezymav5x3Ym8lbjkYTkbu7s6B5zGCVkj3VsZP4fgPj/bf
	Rmjj8r0gcsQDrhodOiB+j12AfSNSeTI0wPQ==
X-Google-Smtp-Source: AGHT+IFYp2J8sA1dyCVQ1vOCeeXRqBIzaSBN+hS+fa8YG0sEE7LCygde5whGIR2rD8IsQqAE7colLdcVHHr8uxRzDYs=
X-Received: by 2002:a05:622a:307:b0:461:1fc9:61a3 with SMTP id
 d75a77b69052e-46734ce0dccmr104642071cf.9.1733844551264; Tue, 10 Dec 2024
 07:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf> <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
In-Reply-To: <20241210145524.nnj43m23qe5sbski@skbuf>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Tue, 10 Dec 2024 16:28:54 +0100
Message-ID: <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 10. Dez. 2024 um 15:55 Uhr schrieb Vladimir Oltean
<vladimir.oltean@nxp.com>:
>
> On Tue, Dec 10, 2024 at 03:47:11PM +0100, Jonas Gorski wrote:
> > Huh, indeed. Unexpected decision, didn't think that this was
> > intentional. I wonder what the use case for that is.
> >
> > Ah well, then disregard my patch.
>
> The discussion was here, I don't remember the details:
> https://lore.kernel.org/all/20220630111634.610320-1-hans@kapio-technology=
.com/

Thanks for the pointer. Reading the discussion, it seems this was
before the explicit BR_PORT_MAB option and locked learning support, so
there was some ambiguity around whether learning on locked ports is
desired or not, and this was needed(?) for the out-of-tree(?) MAB
implementation.

But now that we do have an explicit flag for MAB, maybe this should be
revisited? Especially since with BR_PORT_MAB enabled, entries are
supposed to be learned as locked. But link local learned entries are
still learned unlocked. So no_linklocal_learn still needs to be
enabled for +locked, +learning, +mab.

AFACT at least Hans thought that this should be done when there an
explicit MAB opt in in
https://lore.kernel.org/all/CAKUejP6wCaOKiafvbxYqQs0-RibC0FMKtvkiG=3DR2Ts0X=
fa3-tg@mail.gmail.com/
and https://lore.kernel.org/all/CAKUejP6xR81p1QeSCnDP_3uh9owafdYr1pifeCzekz=
UvU3_dPw@mail.gmail.com/.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


