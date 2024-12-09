Return-Path: <netdev+bounces-150366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D89E9F72
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563DE166085
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC319C57C;
	Mon,  9 Dec 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGhDRaK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619C19B5BE
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772273; cv=none; b=WdCpOdcFLVQQ3AtH/mSo6hNKr8Ej8/GkfMrT+PYyvx9QLzRXvYKKBx6lSjGd6Bv7CjhrwijePUnnLh+24ZZ2E/FIBzf2cYL+CRgXAt1Qd8Nja3g36lW2dzWn90kibhEEQ+wiruRe4uzqGrUpvSUZC0oVUeO1SiupmqyBm/GDgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772273; c=relaxed/simple;
	bh=1mI9r3RY6OtOdbMgJcr3dmM0fqDjgg+TrKbJ/avzDUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OT08Zhyyp7GB+u5+zlrI+8tuK2JNUdi/k2hiePh+U3qd3ZCuz9LjtELVrI2zZVi56LorBZMeC3oOeD5lVIiMICP2ec945QJ3LqrTruQoQqRxkoVjG8EbOnW2e0kf9msuTPtukXhnL2VdQ6IrXZ380wA+4xsXR3P1c1fdoDCKveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGhDRaK6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa69107179cso210145366b.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733772269; x=1734377069; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cBjOdQGmNgiwqrIwKSqTCOYt1YHEVUFAdErTtFcvPnU=;
        b=GGhDRaK6SnKpfi/uFLbo7MbAiK/Uqn+XAclxmxTkZoo8uFMyVT6XiGTSkhgmBDLuGt
         CwNS+3QG91wQJfRsXIm8aHd4Cd7dyE9J5sBkcyz82O53HiEXvRR90gr5PwVM/4tFgtVN
         wT9PtXRJDB8ikBtPrJs+xzo+9ot9d8G4X+JyxKZ6LgCwnjCQgcDFuxCnShQ4b9OFSIo9
         AHsJ1Bq0LOc5Hv3lUpxlGVEEVrpqLIyQgwnvth0OoUV3AVWXCe+VGPHi1BTON8mu1Z9z
         f83UBJSTeA7V2scBe3pBBKdPRlxVsSBuHIpySsukmXqEF915i6oKJxLG/sgK18qab/Uj
         0aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772269; x=1734377069;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBjOdQGmNgiwqrIwKSqTCOYt1YHEVUFAdErTtFcvPnU=;
        b=Ftwlki54G1yiNAMPt/Ud8uEM3DACoRs73T4CpcrQcYGKmbxNVTHw8NpOETaK/CHy3A
         QgIAbEeWGjCrEFkgfHamXO73KH5a8hAtuViV1zO4+OE3/FHRKQC8tpleLiHdFVYDeyh8
         WUaJim4TMXPIfFWSQ9c0t6ZRSMf7g033iq/WXEWRj/vDaQWFbWg5JI6CzFffctqiLUGO
         mBw1yuNQx2MZkL+YQECwz7lbsr66TIeIFgYYsCLjM2axE4QhIQa7EwyVnJIXL0VP433n
         OhffnAUJ9z9oFQVCWZq58BEI/PKQS8MdZdQqET593OBKO3KZXQUzpW71cMzzJvS4gVAf
         E3Ow==
X-Gm-Message-State: AOJu0YyA3B4FUdCCs1F7sZiTpXWBcx6EkNGk2ysFTcPJVyMzv63LL2/w
	/LKajwMa2esqMCnFNLm3BIm0oDQ3uFiOE9xTBkKivA7rbW/JbzWyCPx65JFJ8O2a0QeOs5DThAT
	/lLRRiuYDowOZ6kVxiMHx3p2LPYzVe26Z
X-Gm-Gg: ASbGncv/iikf7sRmh8yoGSKOjBVkMpx1YegAlffY/7Ht8NlrkW/U/fdAXHn3HSU+5r3
	8AzZnlwIDCQpfYwhm0QZmbwHrf/JVDv+3oj+MRbNsZaAXUqQ5HWKPDHZGY2dQA8AxfC9i
X-Google-Smtp-Source: AGHT+IEoH3S94oRzWFZFOeODer1sKK79Tcov3xv8PfZe5jFINj0fKAH/OISo3VXRopk61gXN6E8tfPA7nUdP23B2KR0=
X-Received: by 2002:a17:906:8a54:b0:aa6:a05c:b068 with SMTP id
 a640c23a62f3a-aa6a05cb27bmr57417966b.56.1733772269301; Mon, 09 Dec 2024
 11:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: dave seddon <dave.seddon.ca@gmail.com>
Date: Mon, 9 Dec 2024 11:24:18 -0800
Message-ID: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
Subject: tcp_diag for all network namespaces?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

G'day,

Short
Is there a way to extract tcp_diag socket data for all sockets from
all network name spaces please?

Background
I've been using tcp_diag to dump out TCP socket performance every
minute and then stream the data via Kafka and then into a Clickhouse
database.  This is awesome for socket performance monitoring.

Kubernetes
I'd like to adapt this solution to <somehow> allow monitoring of
kubernetes clusters, so that it would be possible to monitor the
socket performance of all pods.  Ideally, a single process could open
a netlink socket into each network namespace, but currently that isn't
possible.

Would it be crazy to add a new feature to the kernel to allow dumping
all sockets from all name spaces?

Maybe I'm missing some other better option(s)?

Thanks in advance

-- 
Regards,
Dave Seddon

