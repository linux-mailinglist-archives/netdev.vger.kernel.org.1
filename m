Return-Path: <netdev+bounces-243572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6DCA3D86
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B4293006731
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F748346799;
	Thu,  4 Dec 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq+/j84N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD1346795
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855617; cv=none; b=Oz+acfx5pqStczZBaPS09Z0hN6WK4ZhEKx0ocUlkPSr+r0YKDKjV1mLejpKmUaS26+KfCD+hBbUrJRN8T1t8SbJnC/oI56LeirZU3bcAPaoi3qCNwmq5ts+w+HEinSHJmEL4jMtxhf7iiwIAfrxhz8w/6zVgvC4bESQhwkZCMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855617; c=relaxed/simple;
	bh=b656+3o2nJ5GnHJZDti0zbUqGxm3s0FMxvBJSY9YqBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdoiM8DMSvQOROfhM9n7hj8N4UOiNI96xWrS88SAGXboccCslt7FtfLVNgmrbsVy4+Gf2MrNkGx50w/juW5uvoJIPAir6t3L7tz0lSbjWEqjceZKDZpjpJGbIDng+7EKH+SvUdGmHyBQF/wFMXsE5nQCSgs5Allq/rMIjaIJ+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq+/j84N; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5e1fde1f014so320282137.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 05:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764855614; x=1765460414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/57pqJ4nq/b2568hFFEN34aRWvKmwLOKfrziMnDDx4=;
        b=Wq+/j84NqZZxcJEdkr1ErdYmnNefbZ/vJ4OKrlTQMGpvO3hnJxMt9TIj0VPVCnNb/L
         DbFrWOEeEbmUVXYYKyR9kZ0kyGWj2nc+kF9lHcZHRfsNp9fxgGCYH8u0NaM5Do8d/z63
         i8JZlsMsaKFDv7uMDpPGW+xn4HJe8RyW/yoGlw/cXpqMC5VvGbiCmjxy9ji9YdmYBjDW
         0SpglcSF3apxY20Vj7W3EIir3yABI3dtffPCPDw9wsoYstQsCtRU+EgIKVdV3ZDcL0Cp
         9raM1s5b2yEGZNmh+BYXR8leWhRxwYigKKnsaI1nMBIz9KGsrQo28s8AgvtUZb/+Yn1l
         9rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764855614; x=1765460414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/57pqJ4nq/b2568hFFEN34aRWvKmwLOKfrziMnDDx4=;
        b=L+6HEO0SetM3Y1+i8+rp5WBjfMiumvHKmoGvSS9LmC+0vPMsQJWUFVQOP7pVFTTfHR
         tWkkSxHVhcaKJkPlBTmDCfsxaCQOUMOIzzj4cRVGChoirGN6B2O5OdlHfexNS4A2qjk/
         Obp25BKyhy0gn3D7scPIuzSpsPODHO8FO2AcFOqzw/yKF9PH59Cbrtw04kGiPTAbBHBT
         VtTAVG6Of1+r6dy9N+SfmprooV71DnI5qgaz3BSPSBoUw+D80/ZRkQCMlrgqM/yIMihr
         7vtNoyJl9FMFLFoWjR/eKmc4asWxTvsy25KNK4Tv3yCHs7USXitQ8rvcsqC4qfuwxpsM
         666g==
X-Forwarded-Encrypted: i=1; AJvYcCULeCK96s5ldjxax6gnKlo3SVXlQqrEnTAT4iJL9o0/vTw6tu6l4E4sruZKC6TbNikB+PX2GiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW20uxhN1bBdGQakKyeSS2I8Xt6qhakE5VzCa5OhZ4n7vRJlgW
	YyJxn/cYVqtT2fASmy9fTBsqr6Tbm7l8hCIKaDdUU719aCGuqk3ilDLqmX7qB5KQvCJZIJ/j4dF
	CJZm3Zgc7h0vlpb6jezeK8rywKonQ0gI=
X-Gm-Gg: ASbGnct3KbAWrkMYrfnV7QvpTyhPM8MJdiLMXCllDls0q23hiswvkAizaUQZd4iG1yt
	NN5LNyUNGmg8orK8RLqcUZhZl+F9XqQ4jlXsZFImXehyewfaWu1lxdTUZZoGvgfevQrIyNrjYE6
	UdUJMq0hi4q6JlWAedMRKgBcYOFVc7Zaahr+nSz+0UWfO9+uxF+7OCgSm4IjDsvQmwhwb5eMmmN
	otFS+/iNKUNsZBXJrEPbmaDyJoylq75fFZR1/x9r65iFpbPHs7FYpAZ9cTYmT84bqBSIdHh8w==
X-Google-Smtp-Source: AGHT+IEiG3TFmn+PeIE/qNJK9+RlwTlGpblyxtxU8XwyCFKW1BqcARhgFhck17Ael69Nt54OW5t7mAIgcmRbl25ggoE=
X-Received: by 2002:a05:6102:e0b:b0:5db:3111:9330 with SMTP id
 ada2fe7eead31-5e48e34b9eamr2036600137.27.1764855614363; Thu, 04 Dec 2025
 05:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204062421.96986-1-ii4gsp@gmail.com> <aTGMX7FddV4zgEgY@horms.kernel.org>
In-Reply-To: <aTGMX7FddV4zgEgY@horms.kernel.org>
From: Minseong Kim <ii4gsp@gmail.com>
Date: Thu, 4 Dec 2025 22:35:58 +0900
X-Gm-Features: AWmQ_bl-s1sTeWNvsYp3uGB8S5aWjAfWMJ3ZkDfiQRX0HBapu4nLNEpbVKgd3E4
Message-ID: <CAKrymDR3DPTxeaKYmz-wxcOf4byt_Xyx3k7ZJz6tJ6_NftmbhA@mail.gmail.com>
Subject: Re: [PATCH net v3 0/1] atm: mpoa: Fix UAF on qos_head list in procfs
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks for the reminder, and sorry for the quick repost.
I understand the 24h minimum interval rule and will follow it for
future revisions.

Best regards,
Minseong Kim

2025=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) PM 10:28, Simon Horman <ho=
rms@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Dec 04, 2025 at 03:24:20PM +0900, Minseong Kim wrote:
> > Changes since v2:
> >   - Replace atm_mpoa_search_qos() with atm_mpoa_get_qos() to avoid
> >     returning an unprotected pointer.
> >   - Add atm_mpoa_delete_qos_by_ip() so search+unlink+free is atomic
> >     under qos_mutex, preventing double-free/UAF.
> >   - Update all callers accordingly.
> >
> > Minseong Kim (1):
> >   atm: mpoa: Fix UAF on qos_head list in procfs
>
> Please slow down a bit and allow at least 24h between posting
> updated patches. This is to allow time for review to occur.
> And reduce load on shared CI infrastructure.
>
> Please see: https://docs.kernel.org/process/maintainer-netdev.html

