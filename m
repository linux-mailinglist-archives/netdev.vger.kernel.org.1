Return-Path: <netdev+bounces-217377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E31B38806
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB32B18849C7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0C2C2ACE;
	Wed, 27 Aug 2025 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTRJFLp5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6B28137A
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313436; cv=none; b=EBSTDVBDpWetGgTwv/tJj0SsWqU+DWpiwxj2J7PRjNiHiMWagVkx+b5VPjGL3ikjHMMDhpHf2haZCYamn3qRDbb8HVOJ4WPuHHytHss/xLT5IYHL4TQpNePmd6vCkJg+XhFEKFv0dGbrg8DOSdVVkAZLCFGYz7PL1OCR0xD5lN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313436; c=relaxed/simple;
	bh=22GIxkBX1xrNa1ykLDpOgZJWIQwCEtlddDjC4I/7hKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aeST7zCNzziWZyIxa0qdVUR6k2ckCmGltclgPlyPiqpx0+QsAv3aO9382ltLpRIxSKkM3ErUJUeKNco3PmeTUutz+OnwYHiDRDv6gmFTTnFCm/SdN2SuPHguaURMGm66P/dqmeuGgkmzHLDxxyOuwrSxRxMlfRZmIUP59oaLtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTRJFLp5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d603cebd9so74986557b3.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313434; x=1756918234; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22GIxkBX1xrNa1ykLDpOgZJWIQwCEtlddDjC4I/7hKk=;
        b=KTRJFLp5b5gm1PSwxWyGvLfgb0gief66rEYuazn2i2ScxIwF+PUM7kWrs7zk985Y2X
         mbJnBO/M7ZtvTLcuLpYejVZaiw20elACq2A4WrAadnwAGrj+QOZ8Ax23q3/cnAn0T0PQ
         W4DEcsujEOcN3uZYdcXpHWj0wIjb20rXsvXzrb75OAnnqrUGTp+5jt33fDe0GLBOg0DY
         qS0eIdWEfiQgsw2lyUFntlxXp/2On7nk0KY4r0xHIZLax5NlueX1c5hEHpwLRJkXgRcl
         5aJjBq/LtSJgcOlKMkdyEXxWLuwvTi2TA93Eju1ff5trNMce5DXByyaTxqckB9rx0G2u
         0iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313434; x=1756918234;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22GIxkBX1xrNa1ykLDpOgZJWIQwCEtlddDjC4I/7hKk=;
        b=dzUEwR0uE7aPCA3g6YCfdGIAjOj0gFa0E/hWReZuSCV3HHnVjyR5J443J1wdYxZzHN
         1GRHlt48OQH+U8XcK2mAx2Vnx2CRCAEjm0kdEwRkYn8pBw8MuN4mrEn8boN3r64RmRkz
         ruM7GVp0LEsS/3tghuOsZdv2Xi1bxJ6rOVYMnyvN5xgcJAsYll8bTQ/fbb/3zShrA4NL
         NCPiOyIKkF6gysPnhR8VspL7AHh/b7sVEr46g031tc0ee+l7bCR1ij/eM35se4dr0eD6
         KDCXEp2/vtbcUsMyTlnVPkBLZJKgvHsDYhcdc/JgUXWTuJrDE+XqN04he3uBdNyffr7V
         c1qg==
X-Gm-Message-State: AOJu0Yy7HxxBClYlddVtqe5paKUvzjXt/rrHPTXWOIJCy8N06/eftGsR
	+anybetE/iMQ2HjZOsA+N2EBa2F8+0lpIsBSEA7LNlkkpCnWXD2wS2Dyypjo3Tz8vV4lIJuHXaj
	O1PIXGO3BYNlRJomrmqKGxdleB/zwzuMCrqK/
X-Gm-Gg: ASbGncu9DTKB91b6FGghztE+EwMStAepkAJ/uVqraYPuo+0kFkXfG1iUEWEUdrGle0d
	Ebw4aQhY+qmjm/JPAP8RK0bN1UYVIQCnG2jk3rlXEjAJP9lppnCZ0hXYeb0xC3MobRHgebNP72S
	6zp6sqEvWTvIsxb3X0Y7yvaPSBg5YJtMN2KqV4rbJvR+eKaAtf94L4e6xA1Yhq7JHArB+ZWGOwS
	4wi+g==
X-Google-Smtp-Source: AGHT+IHFQNP61outegm7oPdyqL2OlTp63MEx0Ae+0VOqMlSEITsVcenz43baKwSvtafnvhZMYyDz43MHH34cN0yLiW4=
X-Received: by 2002:a05:690c:6608:b0:721:40df:7383 with SMTP id
 00721157ae682-72140df79a7mr50988727b3.41.1756313434097; Wed, 27 Aug 2025
 09:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF4aUuukN6wde=NrLcPfZPkLiudUYjSvb5NvoY55EhP3ssLx4Q@mail.gmail.com>
 <c804757c-6bf5-4053-8a32-43e21781633f@gmail.com> <CAF4aUutwOusxj_UGJzNo53Z4DFSKe8O6npxx40gEiKMKY8_JDw@mail.gmail.com>
 <aK8c1j7NYj5JhwB9@brouette>
In-Reply-To: <aK8c1j7NYj5JhwB9@brouette>
From: Luis Alberto <albersc2@gmail.com>
Date: Wed, 27 Aug 2025 18:50:22 +0200
X-Gm-Features: Ac12FXw2O3lDsyhENzhPMDxNXdhg8qurffZdfzBzg86sOszxpTNbmKO3kSJkH5k
Message-ID: <CAF4aUuuBs3eFNpKKrZgnpHfMvX2yvAn1vWEFKhO+vUmiA-zj7A@mail.gmail.com>
Subject: Fwd: [BUG] Network regression on Linux 6.16.1 -> 6.16.2 (persists in
 6.16.3): intermittent IPv4 traffic on Wi-Fi and Ethernet
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Forwarding some relevant links shared by Damien Wyart that seem
directly related to the network issue I=E2=80=99m experiencing.

Many thanks to Damien and everyone contributing to tracking this down!

Links:

https://discuss.cachyos.org/t/internet-issues-following-last-system-upgrade=
/14123
https://bbs.archlinux.org/viewtopic.php?id=3D307778
https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.ne=
t/

