Return-Path: <netdev+bounces-227900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985FBBCE09
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E84D4E4B13
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E61DF75A;
	Sun,  5 Oct 2025 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecSn6Kes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D33FC7
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707304; cv=none; b=N4QTGBu3kTfCIbFY9aZzT40Cbp1Gf1mzzEPk8X94OZ2Wg4luBwOrLenPJl4qCr19V3NvhoGDSkJ7G9izjJM7E6kz7dkfl5i/Uq4gJATyzKgQsO2+BmgY12VR/bRvGvAdGq9iY8IttmFtHk7879FM9k074FqX65rRBjO4iy5jix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707304; c=relaxed/simple;
	bh=xotqYMZ9YU+BENzKLK/pOhIYZLLAFb3btLyE5+SSasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I43wpiv2P4DTnbTCagTaSGExJpzUwURFTbWSKxoO1b5HOVbVfAO8nJ7Srxcbt1uz7EQRC17+8La/I06DWfzyxc3IUhjSPm4QQgQ7mDPK0oj8mbnRFI4qqJiTsQXvkjcYFoxQ0HjXDMZznm8UOC/s6h09vQ9mAaMpybS36Q+Gr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecSn6Kes; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ac1ad95537so2697659fac.2
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759707302; x=1760312102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhShwqm3gQjPZCNm6kW8lvYi/GZrLquVLhihvLMlVd0=;
        b=ecSn6KeseTrlyh5GyU5g50WqJ0S4/KrTpup3frDgO9iFoTX05SaojjQb2H2p5lP58F
         tXjdrkO2kXy0CvDIHWM4+4/pbmuxkLlvaf/P6IEgeLgL4vuB5Qe8iJHr7LFPk05qvYjk
         Ebt1VaXycGCoA3Hx85m0wZ4CoslgecLtnLzzXqqjKu6owCBosXYCXpFr1NZt8nwsd16A
         PMIR4hdFF2xgTAg8nwQtDW6jWeCsu5YXTdw3mZzflrYUqXOLqHV6QaKLFKB0T+jw5DI9
         qjtLXJTDJnNmFftRXeh8ECY/3qUmZdln40a7sSGfSFMuyFBhRfjan9+wNrRbWMaSvvrs
         Ovfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707302; x=1760312102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhShwqm3gQjPZCNm6kW8lvYi/GZrLquVLhihvLMlVd0=;
        b=WiJ1ibVUIKpDAMtr4GegKca7KOaUSgaRzxQ4N0OKjCyHAIkkqhri7ch60WLbjPetlc
         P+PNy3zFtNc5n3W/Wma/t2qUzTEw17l7zxVEWVwkhaftxOITtEWT+u+IBHuXaU+NyDuE
         hCBw7XDmducNANlbjedHZ/Aqd6cEgC29E18cUf9JPcArk8KS4J7IpqfbC6Bpxk35e46M
         zt6IM5tFmiYXCXY/3/t1WzIDNAuStu+dhGiliFIjsNXNvtr+aSTYV0ozLIHOyWvrVKGR
         nUg0+jq7ef70zK98BDDggQt6SMBcgVWJC7yfC8dQIgsiHRFsE4d2bpqWI1zsPejASPil
         Akkg==
X-Forwarded-Encrypted: i=1; AJvYcCXUtiDG0d11jyORAmpdJIOyWVMvtFFB37naw+3rGqqgSlGVP6pr640CF5mZgwv5tN7SQyeMrAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydu+4RJz6rf8NllRQ8MGuvJ7zLdTiYTphtAv3Zefp0Dde4Hc7u
	sYfZL69GeFrcpGSEWGAkQ8awTYIeTW7gLgZa5XLMUoLQiO3IUf1/LPwbD4hGEMrqAReWccI6heh
	Xg/ui98zYDNtHkM5whmNNhFokJGIJqC4=
X-Gm-Gg: ASbGnct9PuC0lwm7FM8LpEBsC8ul4+AfSTJMjHg+vhbBTky/c1LilVR/zZmWDM/SncB
	OHiputjToLpOZOuLeFoaTiRVgsNROlL+SaPQs0YeCDWHSK6AJ7JzzVGaoUULbmUAj+liVGwjn+Y
	BmmwG7PRIEwuqXVRKmqneZQPrv+jjeaYkGQvVElmx4PJ6CqAjC3cMFWJDxuBrM/rYBhfK8NqSxN
	wWIh5d8YIw9GxXRjhUufQLAC89QCt+U
X-Google-Smtp-Source: AGHT+IHNBEUFJrzq7L+vyOQnFIA/X6Ux7K/Ubqa/yHibi5O0wEDjYIV/UxBlQ3Ph6gNT9/IRlo4z4Kw4f4yFvUQoZ90=
X-Received: by 2002:a05:6871:522a:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-3b1019a23c2mr6009274fac.25.1759707302293; Sun, 05 Oct 2025
 16:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com> <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
In-Reply-To: <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 5 Oct 2025 18:34:51 -0500
X-Gm-Features: AS18NWAFTrUrjHeUPhL2GLVdXXxvEsjDWhS5snu-HQnkYOkoSt4zyImcUMAWSss
Message-ID: <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Matt Johnston <matt@codeconstruct.com.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 12:13=E2=80=AFAM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
> Jassi, this one needs your attention specifically.
>
> Do you have an issue with adding this callback?  I think it will add an
> important ability to the receive path for the mailbox API: letting the
> client driver specify how to allocate the memory that the message is
> coming in.  For general purpose mechanisms like PCC, this is essential:
> the mailbox cannot know all of the different formats that the drivers
> are going to require.  For example, the same system might have MPAM
> (Memory Protection) and MCTP (Network Protocol) driven by the same PCC
> Mailbox.
>
Looking at the existing code, I am not even sure if rx_alloc() is needed at=
 all.

Let me explain...
1) write_response, via rx_alloc, is basically asking the client to
allocate a buffer of length parsed from the pcc header in shmem.
2) write_response is called from isr and even before the
mbox_chan_received_data() call.

Why can't you get rid of write_response() and simply call
    mbox_chan_received_data(chan, pchan->chan.shmem)
for the client to allocate and memcpy_fromio itself?
Ideally, the client should have the buffer pre-allocated and only have
to copy the data into it, but even if not it will still not be worse
than what you currently have.

-jassi

