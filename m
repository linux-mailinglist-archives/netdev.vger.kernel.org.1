Return-Path: <netdev+bounces-158112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE70A107A0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1853A1A4B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE14234CEA;
	Tue, 14 Jan 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkweZc9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FBD234CE0
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860872; cv=none; b=Vg55IWowXziM+swCgt722JAexu28kAy6yEudweHPWO63x+QIRZinGFMKgKjOeUE5vHIg6cMsf5lRYTRroRDeTWIMflEa4QTsgBd7nJrQuIAgqhxQa39tymj0SRVReXyAVw2IEfhZ6c+spk/hCuqQoKx0iBiA3URPvsyzzZuaf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860872; c=relaxed/simple;
	bh=D09UgQ0bZg0HONkOUNbwz69PyeuMH3Qjhg/IicOODnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YulvTv/FAsRt/aCe3KlMcKGVsEnyxZUYR61k67YBUBX4Fya+jyZJS1w8qmBXcBax1dJNfwoutzW8ZJe9xzWaWkuNkQmc8UpzG9iRTu+vLIsveT3saglbZe/EA/yq2BGE3C5d0pRYJPthVWWkHi/ASTfx0nue9EVG1CBp8wdMTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkweZc9r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so174236266b.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860869; x=1737465669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D09UgQ0bZg0HONkOUNbwz69PyeuMH3Qjhg/IicOODnQ=;
        b=BkweZc9r9v/cTN6uPmscZD45gQv9t4yOH8484oUwxgmvbMe6tj6oclgGWr2fGlvs/5
         R/TxtfhWchnH6bXp4RmobGiIOB8NmLpr8oO70C9x2xY3LfmNlvru6w04XetvDDO/Prd2
         uFVTimLKjK7UT/YwO4otMHdP4P2iDRfE5iUWLSs34L+TSK+zh5Awn5TVmLTGBLAxHKmQ
         4uiax4blWj2j0PH0lQZgTD7VSb0EmcPPfwAer3WtuFblG66iCCHSO7mZhbxn4Pi+nEp/
         GNv0lwvEui73/rnKXDzsAv66pyyhl5q15ypeZ/SQK4pGjtZ/FFFyd4wKotkJJ5131Nqm
         oItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860869; x=1737465669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D09UgQ0bZg0HONkOUNbwz69PyeuMH3Qjhg/IicOODnQ=;
        b=L2O5VVWeI6xrJvVXyJwYPGJuFFc19fMEyI9nifSJwRhEZx5u3MRK5GWxHoKBa9rYBL
         nK3b6f3vgYivhp+02QpndYrRmGk6adT16m3uwjG8tse6HEZXS7gbGOazGMo3Cdo6uJw/
         zCDh3tE4n4ZGLCmBoLL2smY/jI7Cc3lAnU6cZrKvA9tV45hV0zoo/9ngajRMTf2xd2s7
         JXQ2cP9rEj+7bXwFD7bgY1zqdoPXg7j/H48rOHV1rpjZ0OlApMT7/DbIPEzoTNbwfqUI
         BLsTQkpS5/w++yql7L3uBxIp5oOMBZB1R/eDBLTCsawG/RjKRmnXaM6OiDO5NP3BsT6d
         Nojw==
X-Forwarded-Encrypted: i=1; AJvYcCX9W+sUHdNja4FvoIyZryZu7Gwv0SNrHhvBPHCRJGN3FGPhuLJLkyzqhkkR9ofK/d9p+NFekys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIpe3clDT1Hal8yovm18UKJG8iS1KShKTeDMMK637bmDkpZ2s
	qi8GLVxrno7oIoTgiFCfiVnnvlyrLxCBxuoX+G/eDOvE71TNylvu81DJiEbizfRQNPidsYGNFdl
	pBwI6JM2fWpK7zHL5YqqGh5rM7KJTgEbMrkW2
X-Gm-Gg: ASbGnctqMKQHGUmvKVgpUBQ6eMyOaTX6gGJpGIWtGeoT6ZEmsAB6mWDEfc0PBqCciM5
	f5y1Hb6DaXdkzs4Ru8hIFmPOIMUpfFmBUaIx0rA==
X-Google-Smtp-Source: AGHT+IFSjz1Ho5cAyXJJpz9JDzV5rjyLk7VN4wuZIQ4LpUQLdLN1hr13bNT9S7JvpUalO2wZy1HXS3SAtXpOTFhsXAw=
X-Received: by 2002:a17:907:9447:b0:aa5:b1bb:10db with SMTP id
 a640c23a62f3a-ab2c3c2833bmr1711849566b.1.1736860869179; Tue, 14 Jan 2025
 05:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-10-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-10-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:20:56 +0100
X-Gm-Features: AbW1kvbv2voDdSqmQJ0TQe-69LF8wy2EbI8_qvaWjTFxbFpV1J7qYsOH6yBcr54
Message-ID: <CANn89iLvnvfh_MfOCqVFYbiWXt4WdbuD1Ewr_hy3GOZeBT7eKw@mail.gmail.com>
Subject: Re: [PATCH net-next 09/11] net: protect napi->irq with netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Take netdev_lock() in netif_napi_set_irq(). All NAPI "control fields"
> are now protected by that lock (most of the other ones are set during
> napi add/del). The napi_hash_node is fully protected by the hash
> spin lock, but close enough for the kdoc...
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

