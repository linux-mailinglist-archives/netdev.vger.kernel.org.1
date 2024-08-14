Return-Path: <netdev+bounces-118560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B109520F0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4661F230C7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C11B1427;
	Wed, 14 Aug 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vultr.com header.i=@vultr.com header.b="rfwIbEnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43C111A1
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655916; cv=none; b=SfDj8ReYLy7RQy7xAdyIL0+sUwUtWk/RZ7kxynuHd51TaqJlTdRpTI/1SQi1TfvrCcneiAZQAmiU3rC3pksTYAPIFwdK9HYIiy8rO8twSnT1j51W2aZiVZWnFHvq7SHoqrOl8gH38sdLN9aISUCzbsSMz8504UE6bNxA4C7WMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655916; c=relaxed/simple;
	bh=6j8bCJuh1m0qsR6j0TmjO2TaoF0tBU7IBEOZrn9uAOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlG0Cbr7umotPVr7A+ZV3t21nXDwTYbn5EFb/xlr6PTS7oRsvbqb+wTeMrAGn8eIp0aKzJqwrauM1gwvXsA6WP6q7fkwvhdod6d2UzASVmO8kJ+R6JYppq8H6BWb9zqAOycuKGj2iH98oL9nOvF0Krn1E7O4QRYZOXaMPiQ7e1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vultr.com; spf=pass smtp.mailfrom=vultr.com; dkim=pass (2048-bit key) header.d=vultr.com header.i=@vultr.com header.b=rfwIbEnn; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vultr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vultr.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso45939eaf.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vultr.com; s=google; t=1723655914; x=1724260714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6j8bCJuh1m0qsR6j0TmjO2TaoF0tBU7IBEOZrn9uAOg=;
        b=rfwIbEnn+cctfdKj7RZHyTJwFYxWfFWNOr8R0+KBXMxm4NccRlkcoZ4kzQyOwWxaXK
         MXSRb0fFA6ymFIpe4VRNWsbFovlo9vBJ4nAzy0StzpPOMsBOh/EQpKPJS6cKPtO+dWWN
         fk/oUp+bIQS0yRRMTgmSol9nHmQV77KN81rOsrK69HH4qihwMSl8acPtA361WjVrhE/y
         hlOjeLMY5mOPWx7tNxv2zVtxr5zCyk+beVaIiSLTQtNKJCHqFF9jY+tb1symhvmE5XmD
         C92DwMxZt8G8r5gTMk+A7DBgIMO6Wv+a4XPjtqV4CGbpHBcCWTianonORkCLM5st/Bgk
         PjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655914; x=1724260714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j8bCJuh1m0qsR6j0TmjO2TaoF0tBU7IBEOZrn9uAOg=;
        b=XTM+Ob5g3Dn+bdCRXQgvgkvsODFSwGl11eklnKjtCelbWirXqYGd1BPfX3P8mFun8B
         BBKtY3QCvmXOZCHwDo2egR06oGpspivqR7Q1D008sRnlY/gnB0+4M4u2dew+b8fM/av6
         sAMUJaOIZYd4nOSqcxOH1Tgp1t0HeyqBqzISZHxoHA9PF7tq7/ICwO/QhNDfEOTdOX2s
         x69tG9F8zLeRo4YxBQGm5ehA3/c5h6NJ+1332rOCq1BWRfE1X1kuxZH1xozi6YzPEBfC
         OiIdk52QVL9X44ph9Oh0iKNzuNm3wYMRaOayRR3WbiE04J8/svL/YNLyzQnA8hyzLPPu
         HfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOV1HXTloUQSM8wdu53ad2ffUvhTENDalMGBRTGRanotvwfLTDtAZ9P8hj6P6dJBBjn7d4xL5ByQq3mSovhPMD9XF1A6ch
X-Gm-Message-State: AOJu0YzhrV+phiTWGESzkKQ2xcyYtY0P+XxzCihTalp+lbMpHfYP4vr5
	5Dcns3KkY1JedO8LCZpnBmjAleoFcWxBGRWhEFmpoY+JvpNt2o+kRhfyCYP4X4uks80DWR1XDPH
	w2rnW79KUd/PFayHtd1HKLgm+st9TmhnaLj5nHVqscJBE2RdtUPZfKA==
X-Google-Smtp-Source: AGHT+IHi5Xp36aAbpk3vPMgD4UHKbn7DOgtIEEz1el12pPj6efwBVaXN2qxe2qu2/Rhve4pMLR/Dbr7l8E9J1uVkTl4=
X-Received: by 2002:a05:6820:1693:b0:5da:73a3:f2c3 with SMTP id
 006d021491bc7-5da89401ac0mr137710eaf.3.1723655913747; Wed, 14 Aug 2024
 10:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABmay2CxFPpsgzSx6wCxyDzjw2cqwAAKs6YjiArR1A2UPLpgJA@mail.gmail.com>
 <ZrzVNV7Ap230Lx4h@shredder.mtl.com> <8c364f52-7173-433a-aa4a-dc2f9908dd5e@gmail.com>
In-Reply-To: <8c364f52-7173-433a-aa4a-dc2f9908dd5e@gmail.com>
From: Mike Waterman <mwaterman@vultr.com>
Date: Wed, 14 Aug 2024 13:18:22 -0400
Message-ID: <CABmay2D240LxDg4awx_Gq_OQg-h8V3em+O6ZJnWeU4JNkVPDLg@mail.gmail.com>
Subject: Re: Add `auto` VRF table ID option in iproute2
To: David Ahern <dsahern@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, stephen@networkplumber.org, 
	=?UTF-8?Q?Daniel_Gr=C3=B6ber?= <dxld@darkboxed.org>
Content-Type: text/plain; charset="UTF-8"

Sorry, I selected the incorrect package. That said, based on new
information (for me) and testing, it appears we won't need this
feature any longer. I'll leave it up to the experts if this should be
ignored or continued into an existing package.

Thanks so much for the time.

Best,
Mike

