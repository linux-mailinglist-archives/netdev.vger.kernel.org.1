Return-Path: <netdev+bounces-160607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56273A1A7E2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD93A2CF7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935320F98F;
	Thu, 23 Jan 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhrj2fYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF820F96D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649988; cv=none; b=Rx4rejLHOmH8E0AKH9aeymYpOxie/1tp6HyWDBE74NlST17qSCvtEDn1ayBZgxgSljB1cULkE4j+TwzGFCPV7HoedtHncBojvkX9zXq6C/j6hiUIDC72teulK46OM62szA+1WD0/sUK7tN83hqRxbaX37xoJdk7Mo9kqrZV7L+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649988; c=relaxed/simple;
	bh=EOPQT40NhejEyFzWm1F1KrCC4QNAF0uYpI1k3VvO7uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBqbxyWzjRwXILAZdDMQk3aEYXgTLxodRNTYpV+7JBnYpzS91La3eMuiRx5LrPlPUrzXvh6KBuntqbM5RUvV6KoTlEyT+9Kz4FtlbO6ddJXyqCJ4Fub/o5hHBAJgJWpQrDAvCLPB04CBU4v6ErEVHhH7bK6y0c2chqEBppimnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhrj2fYt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so1967309a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737649984; x=1738254784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wumv/zu0a+fCS+R0VzEoM7vaSkOwYQ1ynzQaG0twqq0=;
        b=yhrj2fYt43HNSagkmNOR8h78aVhHVGBbz4iu1GVpjqob24ZBAilQUutHJXy4/OR5rS
         wVGwxPs3cUfCWJDknvKuqAnTafJC2Z6thCL0qHG+EMCpRtUmhPa21Zv15/SWirqL07Ac
         sWMIy+Wd/WE2VaBpPxLHXKoOuuo8nfYmn3tq5C5VBW+xBnkZMCsTtxb6lZHyEuFjwh6d
         54Kwd82dL2gj+rCzS1skSy5OWDCh2W5ivBZb6wQjE6J3UCpznhYa8ID6Z+tlLHYvvwTR
         B3zPdG+AQaoTOldpNHXDAPOHBhoWgclpuxHab5FiaexbxlKJQ0TkL2AfsgtbI9CTwox1
         VOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737649984; x=1738254784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wumv/zu0a+fCS+R0VzEoM7vaSkOwYQ1ynzQaG0twqq0=;
        b=knwyRWG3fjUXT0f40YrdUw8gx4Rlgz7PYbWEFe6/loOV91ZpJikVK5vgVdSrtQm29p
         HsB+9aSXCGpN6LfVbBXR1Qwe4y4wfZVx4z5E4g/XxajuM3J2Psl/fWspzGWy4rnXs0jk
         kJdqctkCzsCuxO4JyC06wW4aSqI0UgTqPTYPodSAKWs0vZc57MeMGPf/EVHr8umrscZx
         mAOsurRwDl8mkas/qz2EUZygMSiBZ8OQHntf+Wpr0ieWkPVtPbsWKO8K5SxTErJNOglZ
         cNKhhNmrdXm2QjGWWX21UV2fbJ/1Vi7sc1GN8yZTG4tYNv252W/yH7iE6RmLQpG4MoV7
         YQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4WieQ3OIn4BwqGYy7fh1Vo9iQ/LH1Z2pxPEphCYqxl+07neTGTRyZp0fWxIKLVRy+2LZnpEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iEh1TaH6A/2jf1TDVUbdbDcz2Q6x2DARrYerhxPeKMUAHqTN
	Dm4c0B3VFMiwHuug4i60SRH4mCGhl6gmKiyN57T7dNL5ljBp/KpE3JL4dz5sT/NzUlfGwhTxDRq
	cweBLpSWtGW9jIIAsSuYXSQ+NyPddrSGbniAF
X-Gm-Gg: ASbGncunUkglOqQdFWSzSo8vJJrKqoifyFx9uvtXEhkFabT82ubHhwKyohrxGNrkjPS
	0UhEX4HWa8HllzKNV/EdOr2c6isbB9cXBAhZ8DUhuYEAAaxK/LEN131dhr7qMO9k=
X-Google-Smtp-Source: AGHT+IHA/65SOWRsMHJ86wRU3++SDBQmIsMV+hJ7z2Ci1K/2W48OvypJ/+dpI89ez/lAM4elFBGpxNa8YyPMk2OQJBQ=
X-Received: by 2002:a05:6402:1d53:b0:5dc:1273:640c with SMTP id
 4fb4d7f45d1cf-5dc127366ddmr1383095a12.23.1737649984428; Thu, 23 Jan 2025
 08:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119020518.1962249-1-kuba@kernel.org> <20250119020518.1962249-6-kuba@kernel.org>
 <CANn89i+a_DfERsqHbi6Uu9uzCsN+wKh7WXr6Xh957Cs86ThS9A@mail.gmail.com> <20250123082237.27c5fc40@kernel.org>
In-Reply-To: <20250123082237.27c5fc40@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jan 2025 17:32:52 +0100
X-Gm-Features: AWEUYZnwJNOEPTAvSJBYI93nNMM3CNS6Xy93d0wya9Xn7wC_NdiYLjTrXgdPd_c
Message-ID: <CANn89i+J6g1mD9MEKj7JtWXzMkPRc1SVjeN7Qgd=2i3t9qZ5zg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: ethtool: populate the default HDS
 params in the core
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 5:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 23 Jan 2025 17:15:55 +0100 Eric Dumazet wrote:
> > I am unsure how to fix this, should all callers to
> > dev->ethtool_ops->get_ringparam()
> > have to populate  tcp_data_split and hds_thresh from dev->cfg,
> > or would the following fix be enough ?
>
> I think the comparison in nsim_get_ringparam() should look at dev->cfg.
> If the used configuration (dev->cfg) is not set (UNKNOWN), our default
> is ENABLED.

Hmm, I am releasing the syzbot report and let you deal with it then.

Thanks !

