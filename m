Return-Path: <netdev+bounces-94742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FD8C08A9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB61C1F21402
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BB33994;
	Thu,  9 May 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrQOBY/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5A22EF5
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215740; cv=none; b=bTbd6j6TEXPEaP2mC1Z4p09gJ8D62Hkr8E4fZP4zULJnrfG3rIL8J7nmocWd8m3qNB14ieQZQ+bmX+BgV+c9VjT3Emx7hCcSs61/2YdzOt6lcZkVcuooWIkLA0M2ehCudFshA2qYSv5zHbClBRTJhvkXVWdd7lD+i2NAfHe+9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215740; c=relaxed/simple;
	bh=pAXSYOoxGWQ1Oy8UUmDP7TCzl7e1QUsXWxGP8fzUvHI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sPKVJF1hUerUioCKi2E6UqmMt/teRzQtKi71Cw4zgukXMs6D1goJHs7AMvoZhx4N8+M+vscW/+zsWmYUsrGXVtPBpc+POqY4bpoVIEYZIKrBbCsW61jRDLOTkmAkYKdhVF/MC51QQQevwh8vvCbMn7I2aWJDk89kjC7i9O3DOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrQOBY/Q; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b432ae7dabso93779a91.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715215739; x=1715820539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAXSYOoxGWQ1Oy8UUmDP7TCzl7e1QUsXWxGP8fzUvHI=;
        b=JrQOBY/Q97uh8WLPrZPxl7wXzTFYfQr4VJ1rtEOD212sSZskEVcViBSTlEAnHg/tcf
         n2gLKvC7naqsH/QERJTk+uj2vvLIZVN9sIR8Qdw5NXH0Iirlv6jE0ZDbzEGN5CYpVdSo
         m91nEya8e8T5ZD/kQfa5LbVIRrEeyIpe6hcGfosciGdFcdCwWeSVH/YoL9Sglzr4mWNG
         zpfQ/lWkrVFvsfixreiP5S3+hvPy58sPnyTel6Q8FgAO6PeUIS9VPr3Q5nVtFfiCJTyB
         fPt3wI4XmRE2pD3Hgce7rREyFXylIvvl77B19f9yH8yGqHag72x/O5Sfzoj/0gw6nAbO
         HEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215739; x=1715820539;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAXSYOoxGWQ1Oy8UUmDP7TCzl7e1QUsXWxGP8fzUvHI=;
        b=mA4mPKLxx/2Sa2i5r3WwGcy5m77p/QXymBpScOt7sBUvO4r9/rGVXcCqElZnBx5sQy
         Gk4s+FGp9/8eAIb2wKN216fWQaujXmfeC8XGhYWhQ9NFMBMKf4OxpT0YHzOllM5ht5Ym
         a36J7kLBCkPD4L+g3+asF9/Njnim20mg6mSNTMYe2LJn+DSaR3YS6dgUDspcVK6+25Zg
         zUKaLqS1DrGtnsl1gteyV8VgmmP2aiv9b90jI9e7ZprCGdk0T0+lazwdLobC0OMw19BG
         wR/nxGj2xSKubCcuRv4umo4jFFrD5MgZtKsRnQvuIA4fOGlsyIDRXPSbWSIbDxEcRWkV
         UwQA==
X-Forwarded-Encrypted: i=1; AJvYcCV/R1D/SfhtutvUNmeRRq6QIvqYWjV8atMMq1yyznoqYL27Ih1rFUiZY3Bg9O1ATrX6StiAh9JYfqsh4eDdJGlktlUuDBbD
X-Gm-Message-State: AOJu0Yz1tQ9htBF7JAKDRskJx38YEL5U6GQtViOWxIqkgJtxS30CZDYf
	MBVvVQSmxxyvgC6C5+uxWg9b7F6a8lTwb0ozbcTdYmJ+NGOaCFcp
X-Google-Smtp-Source: AGHT+IELCGRdI6cREmNJBX1JeaJW5Q2ofrIvsgAjuIcU8ab9SoNPq+IoG1FbCJRG2MX5RefBkHVEWg==
X-Received: by 2002:a17:902:d4c7:b0:1dd:b883:3398 with SMTP id d9443c01a7336-1eeb0992188mr46082515ad.4.1715215738832;
        Wed, 08 May 2024 17:48:58 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c037550sm1497065ad.225.2024.05.08.17.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 17:48:58 -0700 (PDT)
Date: Thu, 09 May 2024 09:48:54 +0900 (JST)
Message-Id: <20240509.094854.1899371066357616183.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <4a54c821-3b26-47c9-b99f-9b550d5ee706@gmx.net>
References: <bde062c3-a487-4c57-b864-dc7835573553@gmx.net>
	<20240509.080355.803506915589956064.fujita.tomonori@gmail.com>
	<4a54c821-3b26-47c9-b99f-9b550d5ee706@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 9 May 2024 02:15:01 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> Give it a try with the tehuti/bdx.bin firmware and check yourself.

It works for me too! I'll use tehuti/bdx.bin in v6.

Thanks!

