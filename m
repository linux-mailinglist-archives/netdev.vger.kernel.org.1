Return-Path: <netdev+bounces-131177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DA98D0F6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE45B22796
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3EF1CDA20;
	Wed,  2 Oct 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHSz/GEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19831E5006;
	Wed,  2 Oct 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864036; cv=none; b=rPEpZvvcnL3NzHWVXrhTPZj7LclnVawaZOLZF9MvMmq4oQ8pc/wkNdRRJhjG3a/iNiBsOrhMBwv0beE3FxrbpoXz1FmvalCSYR3smcFJWSwxB1x/4EksySMO7O3n/2kHGsTU53bGGBwH4UXBhV6HFkDjBs/deBuFC1XYv8ktM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864036; c=relaxed/simple;
	bh=M4uZu9021rjynKKxRMidjbaYQH46nr1NwvTOK/b2BGY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n5USFBLY52ZTllosLC57M67jCnTrPE5G1XVOQAnGTeEu2Xj9ZAv3EZd6o/kqB9ybu5ZERkuUzwdfv+oYXgGxlBeMv/xU9mK+zwoNR/VBtxX/dwsOx8f8gmiMFF9MLRhn/UfHEEgPufkmZbQ3wCzMqBRGppJsY4Lemwr4b+IO5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHSz/GEV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0afd945d4so4294684a91.0;
        Wed, 02 Oct 2024 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727864034; x=1728468834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFqbrfOiXdh2VkiSfYbXtCaDNcZt2F2tEGKAJtvElZ4=;
        b=JHSz/GEV2/vtjGHHtf1xzpN+lXfXddfrcvduQy20/OH6uaOC5b4E0vhyKUhHwiVHtk
         WRXQpoOo7I2GIZKLAertN97G4SbXVNHZUh6m6bRv37QaBmbghTYtFTh5nz3McqasLmZ4
         VXCgYWFfioygi49hSEJ8MMmDB3ZVy5GsHMsR6xV8qINhwstxOF3hf7hcufSn/z/hRL9f
         r4iXiT+rGu77Qw73BsG56ZmPNMoZlGS+E29Nv0/eJHRFBAS/O/FsgbTjwM7XStVxvFWy
         I79YZp8IKT6dFvMW9jFBoibFJkM+IC3M+Wz/nlkH5Z6IIdxSd+ETdk8DpCP61lRh5TJz
         COMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727864034; x=1728468834;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vFqbrfOiXdh2VkiSfYbXtCaDNcZt2F2tEGKAJtvElZ4=;
        b=C9rJvoVlAAyjIsW5XJEkNUZs41xrABu28vTnEVoNrSU1XY8+YW0UfYUrvSjhhZLI3G
         7pzl5kzyTCJh0+w3FKH44/15c5rS36m8kdKWA+jEqioeNO8ibDaJQHuxshzCf6ZkpEYC
         lhZNd4pJ66zpW0GzqDB01a9jM2IzSf9M4JoLTLlbkh6WnQd079V0oz84qtZsB/gCiQFS
         D5ChlzlPSnejRxbliBzU87oJpQGgmplRdvxaezxADHCxSG9c2G32UtcIgLImpzsGpWw2
         9BectGS7BMKD/gdjMJVqAY7YYj/08noKddMNCtbaBtoMA08woz3c0rWHRcbsxxl7A8Ni
         nNew==
X-Forwarded-Encrypted: i=1; AJvYcCUYly6Ave6IqJWCEWmD+81Y/+x87VTR/tZ+7z/FIKUI07HqG86+ydhNWn+N50WvUzly4mgw6YeZinYoo2uHugo=@vger.kernel.org, AJvYcCVNOenOb2gYoq1LuvQYkjgX6ilYRq8k9g8cRYhldJQ70pF/c+f/L5wFQDW3WqYBBHnegt8yFlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++9hQnquV6kHwk8SCgOVcIzLu5FLd4mg5m2i3qCR8/uF98Pkp
	RXVEfa9doF9XW24XPMh/H9M5IOhWr8/8J5ar0DaWro8GBNnSUmO3
X-Google-Smtp-Source: AGHT+IEyy/laAs9sAK7C51OkAFOZH+2zCmZaMA/JA4zikLr+7kLrEqqsudugID0IrQs0FZqtjNbSTA==
X-Received: by 2002:a17:90b:1a92:b0:2d8:f0b4:9acb with SMTP id 98e67ed59e1d1-2e184964970mr3154966a91.34.1727864034115;
        Wed, 02 Oct 2024 03:13:54 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa05087sm1172308a91.39.2024.10.02.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:13:53 -0700 (PDT)
Date: Wed, 02 Oct 2024 10:13:39 +0000 (UTC)
Message-Id: <20241002.101339.524991396881946498.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY
 becomes ready
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
References: <20241001112512.4861-3-fujita.tomonori@gmail.com>
	<CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
	<c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:48:06 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> I generally point developers at iopoll.h, because developers nearly
> always get this sort of polling for something to happen wrong. 

Ah, I had forgotten about iopoll.h. Make senses. I'll try implement an
equivalent in Rust.

