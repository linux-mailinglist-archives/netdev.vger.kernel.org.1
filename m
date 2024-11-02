Return-Path: <netdev+bounces-141202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072319BA08D
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EC02822B1
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BED18BB8D;
	Sat,  2 Nov 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFA/NbEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87A18A6B7
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554469; cv=none; b=r5j41DcAwFKmJ0GLwBIxnLR+taDN71FJDjx9DnKLT+4HdAA/Y0+nHZ53XvCI44AV4bodNM1zMZ9l283Hchy8C/NdXR1UAN8xduaS6GWEtfvJhYGkPvN9LBqHXhFYm+xquA5zQxVHq6qjlpLUWDerjMedCA+T5pjL6uH/Ozdh4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554469; c=relaxed/simple;
	bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=lu2wekyEwwsB4CDJse0DpHOa996iYHRslEUDhGciPmIpogxDfxzouQgF2BuQzKHnzTmONXo7TXkA48S+gves3ZJztoGlo/EapmDeAxlyINXaBvp16XDV4RTM4UpKREXuIzbByNoFGa4VM503AbIDYNzzMKbKC1u40Ymn34oJbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFA/NbEz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e8522c10bso71212166b.1
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730554466; x=1731159266; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=UFA/NbEzSHhC/vALKV356JO9OU6U9TkB9zul+Na5Gqkmg2l6fwVQb6QBQgVQEx36Jp
         EIX4EDVbN86gdqigPSJRJ3dokFWiwcAY4aXiT/z7bLKtij7fkVBEGF3BBjEggfp7cf2O
         J97T6KRMUCJLS7HMi76Dv9Ke8ajZfNuFs4iyVBqQ8/OHaG7HG3heeeowkNet01Tf8eaR
         n+cz3nzbzzbd/iuUA/nK6FLACxo7H1WoQ772M41mK3mfP6q8j70E/O5Sy2Ehy9PLb/UB
         4nZbeWluW62BjgDfQsHDLLZgTjZwQzxFHAsru2dGZr/khBXt/FF5rsxrALs5LBG2lqre
         CNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730554466; x=1731159266;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=vKuEtQ0SmtuaDgc9GqbywFeSJVs6mTSoIuA3BMY2YiPMfX8cgB68UGIKkVaG0tKwir
         5QMWdU1qNp317e9/MlPQk6SB2zZaM3SAioPycjboleQF5WZaf2kpI0K5Qswe7/P0znTc
         uy0HXE1Lm/8C/Y4X2itEnqdl8wl00ZIcGj5jG9Jb2AQHThezAgwYRqiIeD5v/r3C8oEl
         2vN4UOSH4wVnTJ2i0riXsha/09WsKII6/77o+ksM3fkRoMRfFN6b9Bdg50vfY0A6qy0n
         JPxqK1PsFTIwOQVPhmMLgRybZUFNp6N3BoxANBukcZtlcEt2CRdcxhO7bCDrkHLidZVw
         4ViA==
X-Gm-Message-State: AOJu0Yz2hdGhGJSOkgKnp9wyIZbUxkVm2RUCAp9GQzLH2un1LN9EU0ke
	XFtZswLr99Ev8UUMLz2qc25mZZdVjFFJuIdKPt7J0h0MgVhPtEdSTImCvQ==
X-Google-Smtp-Source: AGHT+IEx5l5IlmujQClR/AqMbBYFM9FOXmzlDxbVK2hIwgvuEZl+JcCRRdI+9sAon/g85KrGT2kgFg==
X-Received: by 2002:a17:907:7e99:b0:a99:5f45:cb69 with SMTP id a640c23a62f3a-a9e559df7f4mr949136866b.4.1730554465832;
        Sat, 02 Nov 2024 06:34:25 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5664931asm308951866b.182.2024.11.02.06.34.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:34:25 -0700 (PDT)
From: William Cheung <meamithila8@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <8eef490fb02b0a0d20d30f4235f35d6b7b20cc28a9b148dad97f33dcbe32db76@mx.google.com>
Reply-To: willchg@hotmail.com
To: netdev@vger.kernel.org
Subject: Proposal for you!
Date: Sat, 02 Nov 2024 06:40:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I have a lucratuve proposal for you, reply for more info.

Thank you,
William Cheung

