Return-Path: <netdev+bounces-106574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF45916DC1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11BB1C20CEE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74B170838;
	Tue, 25 Jun 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX1wl3Hi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5C73476
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331666; cv=none; b=Cn0QXnDE1uFmvdmZCaySwPYfJjSBtgM0Egp72OFaaU3mdhx8vYm9WwBsu/yn2/ttG91Q0ycBThRpK7IcHJiMF8r/ksmz44bfPzRR216o23TqE5/1MJaNsv1P+PPZIMkZ4IdEAxLiFGuzyLH9SB9W219+uvzZZq6AgC+0AFyusKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331666; c=relaxed/simple;
	bh=kCm2deqiEf1p0hnoueOTW9f+7OXb2C+i4YbXlUuW128=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Ef1+3zA6YsU/gyAHdFAqSTOtoHVhNGcCQfiLlwqoD1u6I4PTcnFETeUIjFXiTWMcybSr/tBkhRj27ZawnU0oBhQuzN2WERYw61ArWr6ME6mJG5i6PVBU+zKT8ASGpL3K8rU95kLm97lGKgX7SJYq8cedF5k2VuUyY8c60UrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX1wl3Hi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso4100637e87.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719331663; x=1719936463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfBb/ipZJEfi6lU7mYeKdxi0zx3WSHEriZ72UwUp+QA=;
        b=HX1wl3Hi9AC/onic0hf41kbDXCLAq1TusdC/ZqAbmjfOnI9y6G8r3D5ySvnkDKj27H
         9/SLn4xUVgpK2Qbbv0pkVQ2UIhygF1TWRcChoqUYTFjpQGyfp9WU0aAUhgV6XQtjZkRW
         OqVmYhPP2FLpTG1sLL5tQMAXX0IXT7jzVnxcTwF506z45bW0ak12DwUyefb+Lh3d6i1P
         I65bn6t8PdGNayWste0P7vQx8PYLeiHr7052aXNrLnujN85OyjDHJzxtGqezxmPKTtgo
         hD3bb8KSpVXLMXOMh1WrWUrG7sHN5r51VVuMtNxlJTDJZLurSqEbbPSWRk6SrYXv3znC
         JDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331663; x=1719936463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfBb/ipZJEfi6lU7mYeKdxi0zx3WSHEriZ72UwUp+QA=;
        b=uqQk7OgdQb8oXV8H5VyQ2Q0AaB47DgKlVwxY8K4WkclScQjTAZOI0o9yScJfP8/8CJ
         IND60NYKkj6CDWqbXdHXvbfP5rgN7P25OMrrCpPihVwd0wbqBwvFxV6BS+4lSofdca8C
         w3AuB0SloIBfBwND5fI9kb/jHYCLXz9/z+0g7SjtkE4sNlEZ1QLG2Qu5K5w0xk5rdkwg
         gZIdCmBorAebyOIEWGP6yKd9aFN0Hf13mRR9OHYNDM2jv69GUIF8uNsYjvZH1fj0dTPA
         RoZ267giK8N8utn/PeOJcbnZ+37DjgpQjYumK9hVhrBkQKPDgrR1waM19eeQ0vMxo49+
         t/gA==
X-Gm-Message-State: AOJu0Yz9GwAmCoJv1sPb64tBfXzNf5pDPshXpaNdEV+VeqEPqGe0NBXY
	D9WWeUEqGMHMVqe5cAAOWJAeVYw03GvImcQmMip8clrgv7Z+UW0nFZCn0Bzs0SdNZMSMOxucUbs
	LGfydA9kQFr1W9c9H2d2WMAGhj98=
X-Google-Smtp-Source: AGHT+IHB12ookDPsPwLOOIIaNtdMJKi+q0Jf+x0POQ/6oJrQZEZOliK77BwBqQn7sRgE9tk94UWali5FCXzHEOfDZ6E=
X-Received: by 2002:ac2:46c4:0:b0:52c:e312:249c with SMTP id
 2adb3069b0e04-52ce3122574mr4712739e87.7.1719331662675; Tue, 25 Jun 2024
 09:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932615131.3072535.4897630886081399067.stgit@ahduyck-xeon-server.home.arpa>
 <4bf37ab8-2a2f-4692-959c-531519651949@lunn.ch>
In-Reply-To: <4bf37ab8-2a2f-4692-959c-531519651949@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jun 2024 09:07:06 -0700
Message-ID: <CAKgT0UfZ5k6PrV=hpx_vr6K5fDcO-n2Kp7QeXdeX4N8k1vCb3w@mail.gmail.com>
Subject: Re: [net-next PATCH v2 04/15] eth: fbnic: Add register init to set
 PCIe/Ethernet device config
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:01=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> A nitpick:
>
> > +#define CSR_BIT(nr)          (1u << (nr))
>
> Isn't that just
>
> #define CSR_BIT(nr)             BIT(nr)
>
> which makes me wounder why bother? Why not just use BIT()?
>
>         Andrew

Actually BIT is an unsigned long, whereas this should be just a 32b
unsigned int. The general idea is that CSR is a 32b value and
shouldn't be extended to 64b. With this if we mess up somewhere and
define an out of bounds bit it should generate an error about us
shifting the value out of bounds.

Thanks,

- Alex

