Return-Path: <netdev+bounces-237646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03AC4E52B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A311882B64
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3733FE17;
	Tue, 11 Nov 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN/NGMP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10114332911
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870288; cv=none; b=UOVCJ2fHoFLM6+MexQQvMy8aWWwRtneU+SydVuH3QjTXqHBxZUtKYo+SNDVVtJm2BBeOm6ZQsL2xZ6cdNqEwvoe9DpLlBDw/Ngdj/zS2behrfDMcbYQruwQ48/YZR/gvitylQb73O99csU4DeQaw2p4FueU8CqcNp067Pk44Qmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870288; c=relaxed/simple;
	bh=PZumaDDW5gxsL+FXIEHsxZJTuzIAEKFvYmh9j9CICKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHpdt9JQzPLIb4gb8X/fOvS+i8EH3st+cjV4zIa6Y7SViNMPl9a9IhTtudZkXKHENkehcwGmUWCICJati3RogZFZDZKuYlGk/1yzTXILXXDq2jFd2iCyrKQi5aFkNqHPmrf/YOjStDt9hVtu8RK3HGQt7acFONjGlUhD06jvGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN/NGMP2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a2d9cf22aso7028791fa.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870285; x=1763475085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuCdQmKCHj4HkzfzDWSUNZHCHWQgXtus3sPe8OAt8NM=;
        b=HN/NGMP2wUwX6kPs4s/2BAJ1g4wmbo8YsICAEcZZjbh76hQnUSGH1EeZxELyG/kfti
         HJoCE6TANeJp9JjjrKYtOpKONzNuWh7Nd1dIhf96TQ/YpPw0CL+9MccX+lgVmpetJzlM
         +cTlNWF8EmBSSTWStxYJWkvwRpcywHn7CsJaCF9eSW7K9QUIDc37i+JplrhLi2/Mkq1Z
         4yZf//Zn1DtmHgpEQCob9ggTT6wenhWKZZLovm2euOOB3WHBE8E07UhwGAIzTiRwbjzr
         SKoTNuOtGep2MlmAStUTJtWE9Cp5lB+qr4hjM83r2b8MA5C3x6TtXlM49TANExzqfnOE
         6piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870285; x=1763475085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vuCdQmKCHj4HkzfzDWSUNZHCHWQgXtus3sPe8OAt8NM=;
        b=Q/RYJfPqKvY8cdk8aiGal1YzXGpctN5H2vK+OjhrZvj23HbDxQHFfrz3JjxItF2SEY
         dQLP83mIo3BQ/DYqOL93djYWBC8W3JDP4Y6AecBA7z2xAF58IZppH4oWISUCFKKjSFii
         xrvsNllwgb05oK3mbsHM6wzsl4sSOCxqGAsiiza/zQU2X9wJ6khIa5/OOBIRVLy8eu6/
         rclRIUZdkwbnmGxPyjEF27ZgymhhmNNUS4f1b+tG/jFiINOXkunyTvcwmbR7mYZF0AoB
         OaFm2Qn2Ihk7wv6HuT8UNOartVsNoRsNuvrfsCgo0rsKOJ2+rTBa4NBpcPjCDNiv3t+6
         w9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWtcW2nx8lydvq7G5RG4no63Y3fwu2ARCPoi4A+UnxGIPv0qujBbkI23sZKORZSp+ObfxnlJK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcD9CMVuatIo97gXDJwuUKR38RiFhb9sY/HS/Zox94qIWS8GIS
	lgTfxHkkZbIFfWTpHBB1X9UbZ2paH2znSFQF7OO05ijU6zQGGZXkrxc/3qoV/89FBO6GzPG0Wmc
	Re+XnZhOExZ8Tw/0qT8tbyulkrSq+/z/lKTS6DII=
X-Gm-Gg: ASbGncuTiZ3gy0/bVmV+OOlpkeN44iohZPZkoZNr36rSQ/Ess2KJSEXND6Ya1ulkuSo
	ZA8wxiyQum1/KCgYw5sG/ZCCZbAtcyyeS2bACTJfo/IUd+SyJBovTw/1fTNB9jq0qHOONeFuyFX
	fZB1Mdsag6TL37PWK77QDLcVYyr6rQyBL2CxsFs1kJB74OoJo2XVckHv6mqUBrfNIl/MMBqT5yz
	H92PmK/LQjsfojub/9D92Cnp19fqcBKh8vcubHHa4J4VsHrn0mhcR0awkeAuEtVYy4Ycg==
X-Google-Smtp-Source: AGHT+IFT7oIDrae/qE3wgtv4v+UXDVGgrtZ7bDYTyHuRVBbQvz7KKO/qlls4dqRA+LV25quIR0njnCKrmwU5mn4MedM=
X-Received: by 2002:a05:651c:4411:10b0:378:cd2b:5040 with SMTP id
 38308e7fff4ca-37a95398ea4mr7277191fa.21.1762870284951; Tue, 11 Nov 2025
 06:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214453.1843138-1-luiz.dentz@gmail.com> <20251110164321.75f7edec@kernel.org>
In-Reply-To: <20251110164321.75f7edec@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Nov 2025 09:11:12 -0500
X-Gm-Features: AWmQ_blTsx75uwbTjJKBZrdd7Jc-eEQec5pYYmSJLUJCXPvrmQX7faCowPR9WLM
Message-ID: <CABBYNZLvrYcYV4cN+v=sSxpJWZy7Fs7Y8BMwOo4vqOxuJuaF1w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-11-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, Nov 10, 2025 at 7:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Nov 2025 16:44:53 -0500 Luiz Augusto von Dentz wrote:
> >       Bluetooth: hci_event: Fix not handling PA Sync Lost event
>
> nit: sparse says:
>
> net/bluetooth/hci_event.c:5850:22: warning: cast to restricted __le16
>
> (I haven't looked if the cast is correct but if so it needs a __force)

Ouch, not sure how I missed it, it should be using __le HCI is little
endian, will fix it and send another PR shortly.

--=20
Luiz Augusto von Dentz

