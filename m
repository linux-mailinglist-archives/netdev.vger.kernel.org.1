Return-Path: <netdev+bounces-210842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BCB1510B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8819B17DBCC
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C829826A;
	Tue, 29 Jul 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryaEyqs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C668295DBD
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805661; cv=none; b=YJug86OXU12AY00R7DNBWHBu+QNhlmLljgyKMMja8jivQM2fmefZJ86f+oL9UOHZyFvn3O09NJB3srLyiR0sDz8Xlu884GCQx9B0/5RF38wzMLdjWA/nrSe0h/13CFxHSSO/zXpCCNDwHxiSh0/zNgBKWohtBK0b+jrljeirREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805661; c=relaxed/simple;
	bh=DLSZQSZEtrc+ZUdbqHC7RvUwQe34ss30fThzyvOIHC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pooPkV7eLId/6oUFg9ahvzfx3FkZcMZgkJHqa9iummsH9kXdi5rkMDJbOB7TIdeLjweffDXvzqQx2kxGDKaT5ItqMYreco2OVPBG/dqoGP5eoxubQkCoySjLZSnbGatmOhxhSriONGZJENhSogDjLRpDLhEUufMdH4gmOf2bFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryaEyqs6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aeb5eb611bso20846551cf.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753805658; x=1754410458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21f9mNPOmN8YbCoX59HIAZl9mOIjPxBUvwYmurnat8o=;
        b=ryaEyqs631O/kqGUw0KMBIYpo0DgPRNBroGqvUw40WZU2ppX+GFJ2vYODxh5V4rJue
         kzVoEqmaa9quv5Kk5T07LI2S2R0OsARtAsubIvJcrW9+fm2kf3rkgQvuQBOFDXG8bJP4
         dfqr2zTQgwZAMAHyKVEF1o69MPqqmqIiJU8tHtmCM7GQhMkbxF6+zV8BlTDu0yx/KOmL
         JqOAQym/uGqXl3xBYpvt52ErKV6+tyXv8LJgWABj+ECdC7SxUgBG1EUKXpHaSmbUGZNa
         AA2mn091g39L0VnxdlWsjzcCq/jrgicpuiMpAVadoaddcN01+UoqMtUXcXrxksTdHzZw
         FjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805658; x=1754410458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21f9mNPOmN8YbCoX59HIAZl9mOIjPxBUvwYmurnat8o=;
        b=ZJ9tnzCqUx8bg8+hlqg7TW0X5fIRXKV88MycM+piF3A1JQW3SzGpR1JrWh+Nx1X3rT
         ZZBngRS2oYI/3Nnc7EVAfUuU9ZDmWMLh1KpFb1oxq//T0JacLVPPt4zzAsDTLQ0xu9qD
         OClUQuLmYZEp+EgggkmxNYmOwRGy2eJCVmwjtl1qkhzwRXZ1WJDnURVYfGAYOBWnH73d
         xfVzwiIC4+pm4tOxAHWlwNYzo5gra/5nfa2itxJsXAlGgId47vGNg+ugvphkknYay1N5
         gWM4WoStbcbRvWgkyJY8t8A2wPuYkFI+7JrruuykOVTp4fXmKiCnoTkehQF4W1w4aLKB
         1iAw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ntmk5vA7mb2NmuIfnFJUyrJprcApe+RiPaxkTKHhqWTKVWDw4q6Yp0x3pXY6v6EFNeCX9o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHFoF+H8Cd4NMZq+GTbdyA1fpY1zLfmeaF/09i8LQ8CZeX6I+
	ihoXzDQU2V5+ZQQrdSJbe0aEgchBmJ5nFB1DBOig6DWOTD/IlYshcO5Q3Xlzx980P0D1po1+q+Z
	vZLRtGAcqVSn6d/QbgkuCcsb9EC4pXdPaMy/AIb2C
X-Gm-Gg: ASbGnctGIfnCI53PGh8TTINr0lF5ov+02TxJthcWkYWapx2VF9Z9Cd/wh0fcQhfT6wE
	m4Fzq/PZq44XSXLzpNRBoLLIMgMyNMiAwP1mDlhnD1VnITThAXjgHQSA5V/G3aQyJBfi3vFC3/J
	LjUSLHuFodiMAozjJGclD/Dap6DnXHoUf+4UsZ/5yfM1qrN84GkMO1dRYzoQRiqeAMyTGr38cdo
	fgTQQ==
X-Google-Smtp-Source: AGHT+IG8opqfcemfGXJ41CpwuFVpY2rWxraxa27xDSbzN5peOZIlit03sDhro+bBPnIahj9U6hiad420EsCVerMBBJA=
X-Received: by 2002:ac8:7d50:0:b0:4ab:6014:f13c with SMTP id
 d75a77b69052e-4aedbc667e8mr3676891cf.40.1753805657520; Tue, 29 Jul 2025
 09:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
 <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com> <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
In-Reply-To: <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Jul 2025 09:14:06 -0700
X-Gm-Features: Ac12FXwxVLZ4Kg_OETg9ZuiFu3BJzAUe45enPbzgdab2hiKHLPl4MN4NwzJhhnw
Message-ID: <CANn89iLXLZGvuDhmTJV19A4jBpYGaAYp3hh3kjDUaDDZJqDLKw@mail.gmail.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in ip_output
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	quic_kapandey@quicinc.com, quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:11=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Sharath Chandra Vurukala wrote:
>
> > >> +  rcu_read_lock();
>
> How do we know that all paths taken from here are safe to be run
> inside an rcu readside critical section btw?

This is totally safe ;)

