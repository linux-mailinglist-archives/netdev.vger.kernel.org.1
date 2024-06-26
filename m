Return-Path: <netdev+bounces-106982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EF918598
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE5A1F279EF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041D18A932;
	Wed, 26 Jun 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI0Roogo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74418A92E
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415275; cv=none; b=JeF9691W+4vUW7ELjRR/umBHwfrqadLGiYquyf9wEoR2vdiNUf5+B7QTtchNCEulHai5A/qhzBdi5tUMiUUqaRurIJXGnPr1tzjQO6bDWihXMCKXnFM5MFerdWC6iBgQj1GlGZo0qPzrmHwH+JzZHNpFrugbE/C7mdp1a3V5rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415275; c=relaxed/simple;
	bh=bOe5eXS2hRPANp8cq/qQCaW5Z6zjM83IxAKafC5gv3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as0A4eFO49l5w8kGygr0FbS3lj2C23jaSpeHn5LrGCn7riOVDTnya3wd1f54JJc4lfhCroCfCdBH1ZK6WZ+xrLH/hqE6QRACUfukSiFRavcykPl0Lw5iDJImCMq8SzH61sIPR4rx0i9VZzEr2lZEVBycZ9FA1zZYqMIET7QII0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI0Roogo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424a2dabfefso20414065e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719415272; x=1720020072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP7OA/00XqQylaVO0Mk/sBlWFkRyliYL5xcYn1Y2Zsc=;
        b=KI0RoogodgZG8Mn64hWPofLnQIHR5mfWx1T5cqYNjjddmm5Oi5MPntZcbQ+1obW3p1
         MlO71Si/OeiXExvJPJ8Cw9DLX2Xqt3rTI/w1g5eyF4CtCQRS8lkOmZawGiXdKTILIKwA
         LdtzH0gBI+aN4MR3Z2mb+MOWq3/VOYxB5L8sVpbHIupUmgvAPqrTAgvLhr8cpN1axvcL
         J1c6IXFz+VXuznflRF9t7BdH3CS4TxzcQG6gYeCBHQ5UNG8xk5RWK1riJQVPWwCezLD0
         sAulKpDyQ1inOhSN30SR1ywsfC82jF2zSMcOmEIaWEM4DaFxZjBKlPTWAY3H4wp6qlEs
         nTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415272; x=1720020072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP7OA/00XqQylaVO0Mk/sBlWFkRyliYL5xcYn1Y2Zsc=;
        b=pOH2JdAMWoR3f3JwTEyOnwGq/crdG+8b/eyLyNOreavAf0/IUkNkwFdCATZsvIFx+4
         fyzKD5kDowhOouaio34a3RyQNkt+tQP1QY0r8SvfsGj1VMW8EcI5G454LRiDRQwBcbAW
         n8jiYjKlFIYCOP66N96XWBv9nKq7+eTj/bRarIuN81K0W77q6eLx7TGjnm5sRnJQ5Lwj
         toIYo86e/C8BEhO3Mbmd2/gLoEynTrDWgfyzXJ2dz+nQUv7z5+/RwldcvSUsBwGGAzfr
         SmAWghggnc+FvtuCg0H/I0dwxqct4P9LtaFfl7oXifL2yasRpu72eBe5ZikA+rth2VER
         OR8w==
X-Gm-Message-State: AOJu0YxYQOcMHw2QqvzYXXdQO+KZ2fXT7VN0vwNI88wcZvwBzCVm2BFX
	tZsaFmq3DIQvds3XywSBbNBbL/pEcPhabmc1EPrrJ1GTXQawP03i6EOhwdWavFrbZQz3ZnGjt82
	4xZU2oVHURI98Ea7ItmNU8bFazoI=
X-Google-Smtp-Source: AGHT+IEbss9swjCajx7+2t4+LjygzEAmC7BPB+dWUNmodq1daUjyb/fEPFfgEn9rEIA9XHiGtt+DtIb4daoSU55wK/0=
X-Received: by 2002:a05:6000:1863:b0:366:ec30:adcd with SMTP id
 ffacd0b85a97d-366ec30ae93mr10299769f8f.7.1719415272135; Wed, 26 Jun 2024
 08:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932614407.3072535.16320831117421799545.stgit@ahduyck-xeon-server.home.arpa>
 <20240626071648.1fe1983d@kernel.org>
In-Reply-To: <20240626071648.1fe1983d@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jun 2024 08:20:35 -0700
Message-ID: <CAKgT0Ue0dA394E=2Lg9Y74DQkfEjV==SoxmngHdEGjBX0-qi+A@mail.gmail.com>
Subject: Re: [net-next PATCH v2 02/15] eth: fbnic: Add scaffolding for Meta's
 NIC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jun 2024 07:35:44 -0700 Alexander Duyck wrote:
> > +/**
> > + * fbnic_init_module - Driver Registration Routine
> > + *
> > + * The first routine called when the driver is loaded.  All it does is
> > + * register with the PCI subsystem.
> > + **/
> > +static int __init fbnic_init_module(void)
>
> kdoc got more nit picky in the meantime, we need a Return: annotation
> here.. or maybe make it a non-kdoc comment?

Thanks. I will try to follow up. I see these are reported in the
patchwork so I will make sure to address them before v3 is submitted.

- Alex

