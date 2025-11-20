Return-Path: <netdev+bounces-240374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A3C73EC0
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4C82C2A541
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FE331A7B;
	Thu, 20 Nov 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNT/qRJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548B326D75
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640854; cv=none; b=RqeLKA2/ocQPcAR/rsg5ZYjsi1CKN698mDt8phk1HngBCT9zDqB7U0wSdZmpkgUCTO8X34xgskCETKJhT3N2GdEhNPPTZZELNa+cGv2HYb2/tzQotnk6nABLRJX7h9qIwqU1Jtbaa+tTRB+tlekbwBgxayi0hRAUyBHk1f44Dyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640854; c=relaxed/simple;
	bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/VIZKr/bQfBHDhcWI+a4y+c1GhvuVmgeC+yEoP+uEDuvIOppB2dueR6iKObOgmo9JyP0yQOEI76PbzlN+KZKz+M6YL7L3MIFcPK8ih8IPAfTiSj4aSdCVsnWcnmNywv5n7WtvsblMZgKCC8jbMxbNiaG0dn+NeB6QTUP33BRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNT/qRJa; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65745a436f7so299197eaf.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763640852; x=1764245652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
        b=DNT/qRJaZq445LS7tOTjGSSsmQAmpv7S/qwgqiqKNt4NC+5nuqs2jSZ8wryNrHOPvY
         iYnGl2YWdqKkWXa6OPuxxgkms3acKRXJ/Ju9pQcAWEmFeAtPlAZoyyNhIboXrk4QsnJP
         3JjxNXL1uMp3iwp0J67flZtOzDN8UxI8huK3zFDSYRon6YdR3PSicxk2lcBuoObHNgvi
         8pzZSGy/Hox3U9G6XFQ0WfGyblGakfs4tpA6QEo7qto6SFYS3+AFExHKepNKsSZQd+Bc
         o1hywQBjLpvtXv9FIyNEGHB/amv2ZFSH3TIO7RmD0ZgGFhK91+47BC5fkPVXffj3Tq4p
         YIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640852; x=1764245652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :x-google-sender-delegation:sender:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
        b=ERHRqQI3auhELaAn/WTsl4BWVKIGMfkz5DxrZBwPXwV1rDB/+f2bwsBZHjdTbrMCV8
         oasmvQpk+M81nToiwcY7CnqrcfiR+BwOPe/RVepz6efeyW84qINszQuV+bJneVdLTZXv
         gSel7gnS/TYIP7elWet2f7ZKyKUH7SKHXIvnFkd4U4GvnlaRQYZ1QLubtLga0vajOnHA
         QJYf2a+b4cXxjvtrtpajGaK8D/NU9avhgubWIyoirmX8hq0Bs3ajLUNtv69DcqYKUS5J
         XjWvL2Mrko2TLPsQITfdSBtzQ0PiFJL8v5XRhslA1Imkfk+HSHXuMwizve+g3P75v7C6
         txdA==
X-Forwarded-Encrypted: i=1; AJvYcCWAe7f7RERtsyKmpG+JpeCPsn9U5Klh2ssjfLbJUiG1v+aDw5yJprfcIyW4+0hYA0H/gvHhqa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQ8yQXpJh6oVgyByNbQoVNO5OEXwoHMNVFRcI9NDzaiSChgM6
	hTRaKFJtSlhF+IuRx+0sc2u40xZ52D+bRTrq5yNFbpS2EfN9AWIjI9PMkZYBp+NkH5tNKivDJlR
	ioGmZxFrWWIEJvNhSE9moSoc4FBE8ZUQ=
X-Gm-Gg: ASbGncuXVdHlkW53eOSCqYlDjN6FWjGr22Gg1eG/jCzfG+eeWK4LW7XElnAUbASyUxV
	ga0tjoQ4p+Q8PePwHo99T/D3Ouk3j3ouMhGeKvb/bT/S3ghdgl4OGmyqi/JH3GypEmQNaMmNbVv
	1n73v2TRhOws6oPYQbYVXSCVHYGJavQapaD94ID4G9o+ZVDEAFD7hNvx9gvGXi0Mk/cc2A23H7M
	0GvvN+Ff60cgBvLV3umD3xSbr9McYj5is7TxsXZF2tCpQOdic8r21SvnC/wcWRuuWE+j1LJK0Gh
	upIv
X-Google-Smtp-Source: AGHT+IH/eb3Dv0UCJrH1SZTf8BRjK9wJlIx5viCddf8iUS/Adh5/Wq0DDGKJebipoqWAx6FTViIp4L8FHEEuuUe+tRQ=
X-Received: by 2002:a05:6820:2d8b:10b0:654:f9a7:76dc with SMTP id
 006d021491bc7-65787f3daefmr493288eaf.4.1763640851785; Thu, 20 Nov 2025
 04:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118033330.1844136-1-hanguidong02@gmail.com> <038697aa-a11c-45ce-a270-258403cc1457@redhat.com>
In-Reply-To: <038697aa-a11c-45ce-a270-258403cc1457@redhat.com>
Sender: 2045gemini@gmail.com
X-Google-Sender-Delegation: 2045gemini@gmail.com
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 20 Nov 2025 20:14:01 +0800
X-Google-Sender-Auth: yD23ODSIyzTE7MrBut6Z8fEMW0I
X-Gm-Features: AWmQ_bluxQrCtKwmX5vZq88lt2K-omHHzjSpi9caWAxfKnV3WK2fZc43sm6lac4
Message-ID: <CALbr=LYBs9P92oHpF3-w1k6a+W8u3eTqBpgZv5WncfTm+zCHUA@mail.gmail.com>
Subject: Re: [PATCH REPOST net v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Paolo Abeni <pabeni@redhat.com>
Cc: 3chas3@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 7:26=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/18/25 4:33 AM, Gui-Dong Han wrote:
> > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > prevent potential data race.
> >
> > In this case, since the update depends on a prior read, a data race
> > could lead to a wrong fore200e.available_cell_rate value.
> >
> > The field fore200e.available_cell_rate is generally protected by the lo=
ck
> > fore200e.rate_mtx when accessed. In all other read and write cases, thi=
s
> > field is consistently protected by the lock, except for this case and
> > during initialization.
> >
> > This potential bug was detected by our experimental static analysis too=
l,
> > which analyzes locking APIs and paired functions to identify data races
> > and atomicity violations.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > ---
> > v2:
> > * Added a description of the data race hazard in fore200e_open(), as
> > suggested by Jakub Kicinski and Simon Horman.
>
> It looks like you missed Jakub's reply on v2:
>
> https://lore.kernel.org/netdev/20250123071201.3d38d8f6@kernel.org/
>
> The above comment is still not sufficient: you should describe
> accurately how 2 (or more) CPUs could actually race causing the
> corruption, reporting the relevant call paths leading to the race.

Hi Paolo,

Added the detailed description in v3.

Thank you,
Gui-Dong Han

