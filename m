Return-Path: <netdev+bounces-214395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840CB293EF
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9ABD7A7A50
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209B2FC881;
	Sun, 17 Aug 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjRycLF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A533176F5;
	Sun, 17 Aug 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446141; cv=none; b=r0jYirT/H3skxLlidMo/8e9qoHlZADDi/N6ddDeVqewj/kDpw07EUVeWQjjvDvCVihkKbuOgdkqW6OM7Qt4NPx1SHEm+kfe4P2+5GD94cSBDWZSt9gQPvTzq/Fk22gA+u65OxUpoTQDiKekbOd4Ng5JUFWM0fvi16QAXigC+IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446141; c=relaxed/simple;
	bh=gZTXDSV20kzqJmRo7QHwTRf+JxHngiIK1YVyv3bqDxQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bX6VXEJX3gzmUQpYt+YI8J1ZcjozGfKkAfGt5yFRUNvotbk6LHO227y82wyjnktVG9rKO2UA0BTeZBecz5phlXxnZEyRk2QPugMJp8xdQsXxIuhWuS2GT+Tu9z23HcVC+LYSm6ApqtW1W4cs5Iewj8hAf7yz5O9l0BtYun3GeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjRycLF7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-53b175736b7so2811606e0c.3;
        Sun, 17 Aug 2025 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755446138; x=1756050938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXTD9HIL4/zQLGaBxVvi1SzGVC30k2K2IVDaNBb+1ow=;
        b=UjRycLF7bVHxw2LlSPH4HIXhAnzsvem3tk/VFzc2iPedSCUGWQTBvFdT8gifuOiBZX
         VFbpnHrRW27L/73hLSNTeUpLGwMka3/nl5s8EjXaF8wQHjyitqaZdC6foKZsMUGLap8M
         3rSSJakeEpZPhEg6ZTk3wMhJXILhNMUUbaIvZ0QTKS0guSMUqLA9Xd1q1UI0y0gJ4XkQ
         6B1dn1Of3RWQ47wig/X2VKQdhaBy8KVdc84tFdxrTXgOMMQU3YUI/LOPupT1W63517iE
         MSTqThGo8Uihd/f6fP4xWY8YVglrOwig9VK1fNCNpheIq9NsmTla47nEkzVAidAjaKPj
         9kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755446138; x=1756050938;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXTD9HIL4/zQLGaBxVvi1SzGVC30k2K2IVDaNBb+1ow=;
        b=U91zO7MNR4hvtUN1YJEjKUxWveSy7w6h9ogQIBQhTs4d5T+rNBzM0vV59cGc0y0BVD
         4TRPa6q46cs48FGpfiEuMRK4h1vv2poq0cJsuiiJEJ5ebqNsLNUMNunsiz33QDXiFJwr
         JNHtD4LHHfSYYxtt815pdQHDkfATz22bu5WzAQWJR3rKRJ6Lq5wteHG/6yheOe2FraMk
         RNS1sMLGy6iVaCp7YP3/BsMBCucBCwi9/YT5+NqhUBdUj2NI3v7r96DQE5eFBYHr46d/
         DHH3Tx9a7jfYgwRS26eHm8sNt6W+ZE2vrZ+pLTJR01cA2TAYA97LfoZ1nxq43zm+V/6k
         HTsw==
X-Forwarded-Encrypted: i=1; AJvYcCVdvv+z2K7sDACX4S5OuYiJ+Nb4srQlxAWzOqvgHpD06GutkHoL2e+oGdM6IDP35fgMjr21L+eF@vger.kernel.org, AJvYcCWVOCsGECNF8Mrq/j3hQQT8e9HH7vvvAPPTxZG/t+HgFNL/ne7NfhU5GSFkpH4KnCJezxcmmyJ7GVaAMgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kOaSNgjelc1BR2phpa9zIBCDx/01Cf8YUTzaZ0CGobja7tzH
	w8AKIJIxHHemxZhbqiZSbif8F28ZTaD750GXt87ywfcb77O3zSE8UPvw
X-Gm-Gg: ASbGncuPaYcE7ZFdz8LYpMCKbu1+AanKQGcM+CyqQzcqxbOpN1k3EKBWDpHMWKasxgm
	MApyoaxnXjMkK/NqLFN02EwFKd5KRtNHWuPj5vZBX+RO/JCYn9J3Ge4oVIyxX/i7wtzElfAurbC
	DloI22EN3qcFypno48qdzuHFMMNtyrom0cm1GSzMLa69ZLJradMdWOKvM+ZnhWpujdwHpEP3m6B
	sEBBYbO8go71FgDvi41BrUFZtv0sk8DEnmEzJxvpv6KVIkceiscn7DF4ORMBv5lbGXMKu0qyM0d
	UXfdj7k5c/FcP7AMykT1NWDMJV6BEoqeNJrhBxlnyY4uLdQabjJY2uO9zFFmbRkp5Fm5lw0yaDc
	gyezZHmms4nChJghTPHcMlhR47Bq2gCOZN/wr8WHI8M+nQRBvpEv/GDI/Q/+70fuUa1vITA==
X-Google-Smtp-Source: AGHT+IHAsISfXYTxLl/pnz1PK5Vw1cZyJlILGpS8Pb0wGQzSasQYux7TcVN5KsdIwtXlChLmage71g==
X-Received: by 2002:a05:6122:180c:b0:539:58c2:1e0a with SMTP id 71dfb90a1353d-53b2b767923mr3525422e0c.4.1755446138397;
        Sun, 17 Aug 2025 08:55:38 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bed94b1sm1303559e0c.17.2025.08.17.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:55:37 -0700 (PDT)
Date: Sun, 17 Aug 2025 11:55:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.157558f062bfc@gmail.com>
In-Reply-To: <20250817144709.3599024-1-jackzxcui1989@163.com>
References: <20250817144709.3599024-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Sun, 2025-08-17 at 21:28 +0800, Willem wrote:
> 
> > Here we cannot use hrtimer_add_expires for the same reason you gave in
> > the second version of the patch:
> > 
> > > Additionally, I think we cannot avoid using ktime_get, as the retire
> > > timeout for each block is not fixed. When there are a lot of network packets,
> > > a block can retire quickly, and if we do not re-fetch the time, the timeout
> > > duration may be set incorrectly.
> > 
> > Is that right?
> > 
> > Otherwise patch LGTM.
> 
> 
> I'll think about whether there's a better way to implement the logic.
> 
> Additionally, regarding the previous email where you mentioned replacing retire_blk_tov
> with the interval_ktime field, do we still need to make that change?
> I noticed you didn't respond to my latest patch that replaces retire_blk_tov with
> interval_ktime, and I'm wondering if we should make that change.
> So we remain the retire_blk_tov field?

Sorry, this response was intended to v4. Yes, let's keep that change.
If hrtimer_add_expires cannot be used, then that patch is good as is.

