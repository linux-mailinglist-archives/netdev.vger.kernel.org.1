Return-Path: <netdev+bounces-163595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5112A2ADE7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869BC16B0C7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30268235341;
	Thu,  6 Feb 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5pBC3/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7E235368
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859676; cv=none; b=k89FP59wx7qseF0fJQQ0kde0TSaOR9P8kUVn3wk258zbf9bFjZj7a3pHQPoRxBq1JMzjnNgfDdPxLd+7pZZCJXlKtWDRFuc58Yz6sHbn0BmZIoHXQrDeJXTAOAafJCVitld4Aj1BrME4RFiU5nzqCVtoEe31WOHcONzBinLm7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859676; c=relaxed/simple;
	bh=YuhFrpk68BX1Hw5/mo4aVwMWRcR3JFDVVP+RDDLsMoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5kqzWjc2J4GCcokqz0TligKxLgg+4ylDb76stKwsujO8gSQymdqcVFnPuL0F0UlfqKUJe9plGQxKBzWRYLpybQM3BVCpgKWZ+HQYDEDB1Y9jgX2wsZ3mCztn651pIa7VlBtB/RcNfGlLMlTJ9A0IhAulBnTdDiRCntHJmJ/GEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5pBC3/D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f032484d4so35205ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738859674; x=1739464474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuhFrpk68BX1Hw5/mo4aVwMWRcR3JFDVVP+RDDLsMoE=;
        b=j5pBC3/DeHkrbNrpaBFYoaOOnVu6u8F4Y7rPoTavE+CcPn2lMPfAPNrAGT7+ApRmD+
         Tf+VO/ygGtiXk9FIXey3eqhjcafX38J8ehGZwGdKHHaBsEDr97Id58t9JixPUrZjhbwb
         khFLIeIU3+RmjApwVKTr+xuRNwkTQ8qoSLhuSfitGKaQ3nS14DnY/7Pr2TVpqsyAscRA
         f+5mH9P+K4NiZMbkYF46n+sF2QC0I0oq2sU0sD9I3eLdQnpRFCz9EmMcq5wwwFEP2SvV
         mORr804fbwRx9AcFDDf2+yf1vE3V2rVOugIkvVDy1DqnPcR9W89ZFdssxHCtl5+boefb
         5VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738859674; x=1739464474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuhFrpk68BX1Hw5/mo4aVwMWRcR3JFDVVP+RDDLsMoE=;
        b=eNtqGGLw/D+0GbRDGBb60zd7c5wwhMcrVLllM6P43EtM1nP4qL3dWwCM76NTwgva+t
         4f0whEyTzvQ9BZPmUWVXxDD5VWBjOMk9/7ixrViC6ZGHGAvCcbbnEfHZsQKc0+tPHzrd
         rbPB/7ma6aPSGB8a11scvoVePe+DUnWOHVFSAgK8xKEtm3tD9Pa9yyhrKFClx5R6SA0C
         UQTcs25WBh8FcuXLlkkGjynqjNhg+Ye4VbXEfvh20d7igG114WB1lrV2qyNS2Lu6fn32
         rMBUuLx7H2TuQly+dCUuPnc+KjjqmgCnk2o8FB5MVRMTgPMSZIW9UU0i60vk9ea7+C27
         XL8w==
X-Forwarded-Encrypted: i=1; AJvYcCURt6dNWHtLZw8jT2baO8tFVivtKstG0mxL/tvliIhkw7XruIRnNr8c3GPzmaaStYxXFK2GTs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3ZMmgxxAXx4jOokVg2XpueQQaD9HJQCZvlDGqhSdu9TdSWmT
	VvwNnzqHWbbT422MsC46k4D4wT/bsVK+whMR2bPV6+hbini2fAz9vv9TLmjZaqezHOUwqMp3Q96
	P6S9UU9gKE0HQCphPHPZsTkPhrOosYQvdBcJx
X-Gm-Gg: ASbGnctgW3lFVRoC+yzcQnQXzpz7VvGSoEWwFk+RP2u9s7FBkGNn/SnrOhTEQK6mdCU
	iUXp4RBTuIEF5SeGD3cwUy5NHhvtGywieR0wl1kA4KTa5jv/BFazl7EDffV8ncsC/NFVMC/Ev
X-Google-Smtp-Source: AGHT+IE5i8Tk6PtRa7pX5CUnr+zWe055Ccg26CQoEx3LrnmJlnv3bZwPamBZW4iMQ0IfcCRbTwXh1dyu40X8J78UciQ=
X-Received: by 2002:a17:903:19cd:b0:216:6dab:803b with SMTP id
 d9443c01a7336-21f49ee6c8fmr492445ad.18.1738859673520; Thu, 06 Feb 2025
 08:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190131.564456-1-kuba@kernel.org> <20250205190131.564456-3-kuba@kernel.org>
 <CAHS8izNgVd_bPDCiFD5mN=TgkcaKmQK1RcLgw_051GRHcLXHvw@mail.gmail.com> <20250205172632.61f41a06@kernel.org>
In-Reply-To: <20250205172632.61f41a06@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 08:34:21 -0800
X-Gm-Features: AWEUYZmvjoe9prQ7jXseJRL8Pla3nvb7InnpupaQk0edT07aYPoGKeNStUzLw64
Message-ID: <CAHS8izNb3-Ly3D5qmczHjObD1zWkgOAbovMN5FY=6uqTyBHC3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: devmem: don't call queue stop / start
 when the interface is down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 5 Feb 2025 12:35:30 -0800 Mina Almasry wrote:
> > Why not return an error if !netif_running(), and change the call site
> > in net_devmem_unbind_dmabuf() to not call into this if
> > !netif_running()? Is that a bit cleaner? It feels a bit weird to have
> > netdev_rx_queue_restart() do a bunch of allocations and driver calls
> > unnecessarily when it's really not going to do anything, no?
>
> The bindings survive ifdown, right? So presumably they exist while
> the device is down. If they exist while the device is down, why can
> they not be created? Feels inconsistent.

Ah, good point. I guess binding to a device that is down is WAI indeed.

Another approach could be to return success without doing any driver
calls at all then, because when the device is down there is no running
queue to restart. Although that would have an effect that devmem TCP
would start working on devices that don't support the queue API at all
(I guess the user could bring the interface down, do bindings, then
back up).

But this works too, so

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

