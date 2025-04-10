Return-Path: <netdev+bounces-181421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D162CA84E52
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41DD18988E2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33503290BBA;
	Thu, 10 Apr 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zp7u0iPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6F2900BB
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317686; cv=none; b=mA75tDFisgoCZ7Ke6HLGxmnzupHKvE76gNIr2LQYoEuVL6AkVdVqO8YVJdxiJUk+n2gLUuVGjD43cZYFiPOmFD3EzCijp3RoqXahNU1cAsOBb+ygHG4YAi+L0u80Uq57EWj/wZW/eGhutd5fU5+pKoKrng/auY5lRAcG8iSEB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317686; c=relaxed/simple;
	bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGQw8w8TgbM2FFzK6SNSKc4gINpNRF8NIXjdO2uSSEtXsiP4Pqxl8eiN070t8Z1rsnmtYkVqixx4YUSV2cT+QuOjg/KYWcLQDfcl/hNBoTS8QBk3tvmWhHOIbYJQpv0vdcdfPDPfXvetCACgJX8S3F/8keiLhvLlnLTSTF8aano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zp7u0iPT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed2172c58eso1263346d6.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744317683; x=1744922483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
        b=zp7u0iPTbmjyXgi1dvJUan1HEthMQgIPnTygh3JQCTfM112+Zf0DQ1UrMsLcjGXrSW
         2XmT8tsPl5ISgpBgCW5FQ1nLLimBnQezXfWX1mHF/+r3bMIcI3TSkXyG2oR+8yL64YlR
         wX4aVmsXiyHQg2qF6oNL4NfYBl/ylkcyJiVtemfu7PQU4J2okp5XRiF+N22UA++/U+K6
         u+ItclgwBzNHgsORQn8sybQLLviFV2XUrmsM+gieJnkIRb9ny7DBZSa+Va3/FxNQPoj7
         aSU1L5cwRQPACEEv1GpPDt2n6gLTcvHrii62It5an67ZpHkofAvfvPykV5R8RDzIGvir
         +cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744317683; x=1744922483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
        b=iADvmMpl5pxXFdYm0Mz5pzi82s94TSSaEbRrwtIYsSTPEIxzU5ERF6Gc9Nu4ucaVXe
         /xJvYA42Jg/MeqBLXHL+QW5EuTBmVpsCHloQx9rw/NZeHPFO381HM+Xf17Oro1ZO1Rbm
         vxjYBDPZZqcNOCKdweScFAR3ZsLBlNFpcmkbMXo63QmNbrV4IvxOAiR+HH7h82cwJvI9
         XykaS3zsbD9Ag5/VmyPxdi5R1kUMNPje7QIxdx4se/mgsUWmE/x+eV3wrq1Mkyc9ofgu
         lnqZ9ZJK5HSrF/VHfBumxhin1909IUhHf6EgD6rHgW5773YIXGdNIgQLwzxYFZiWzDSf
         q5DA==
X-Forwarded-Encrypted: i=1; AJvYcCWEbdmJ/FFNAPq7GXZZFH+KA8M5Il1/e7f/yKtcE9Rh9M2a1wv8mEJqPwTAGC3/l72pgE/1Wrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1u20qDqsBlURWDSY1+Rau1TQKdxPnWtiFRXfOf5sZQC5h4A2Z
	QSN+9JdEVZ0lKlT46l9AbU7jEAGQUY8RBPjvRhb/0+H/+AfPYr27bFTwVUH9f7EGbJd9bBDyc5G
	uVsdCBeg8E4rS7r/MuRnCSi/nZrShTknmdH5c/g==
X-Gm-Gg: ASbGnctDSYxBnY+95vab4Z3wZpFvzK75wb5NR8MVVAP780EELHJAF8+927ZFDvtm+OF
	JTd9OjRp3hKwRHPQ2RnbD+7ynB4717lnRbauJrI68XrCLlagq9QVkVC56qNxzFt077z10PD3OT4
	LYYeDiMI6Z6FcwgWK525BfUyAl0QrneaFhcF5mMbeqoVynz/L+KKpo/CKiEe1igmlGTA==
X-Google-Smtp-Source: AGHT+IFBlBXngPSSfXl1oYgUaFZeia9+FdGEdDZkF/oOJJJtPwRXqIpDSem5F/1LVxF8boATdv8onQUgOvspqX929R8=
X-Received: by 2002:a05:6214:2341:b0:6e4:4034:5ae8 with SMTP id
 6a1803df08f44-6f230d6cb13mr1827626d6.5.1744317683168; Thu, 10 Apr 2025
 13:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409182237.441532-3-jordan@jrife.io> <20250410202214.7061-1-kuniyu@amazon.com>
In-Reply-To: <20250410202214.7061-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Thu, 10 Apr 2025 13:41:10 -0700
X-Gm-Features: ATxdqUHVVlU7Wych9XoEDAx7bBQOWn_7AjvU5s2ITBzUq8wPn6_NmwRE46PoXIE
Message-ID: <CABi4-oijZi-=OajSPtSth7HBFUR5_QtsWtmck+v_=2Ge3H916A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/5] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I'd put this before kvmalloc_array() or remove as it's obvious.

Sure, I can drop it.

> The 3rd arg is missing sizeof(*iter->batch) * ?

Agh, silly mistake. Thanks for catching this.

-Jordan

