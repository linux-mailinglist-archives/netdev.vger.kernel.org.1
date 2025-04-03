Return-Path: <netdev+bounces-179021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D1A7A0FA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A640D1898109
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558B24888A;
	Thu,  3 Apr 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efFBcoKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27A243387
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676078; cv=none; b=C8THg9hGqzjaW+e1gtlH3astMr7wd2yD3ak8dqApKuixH1f2YQp670bnaWnWmSE+F7Vp0B3J8fMcAlOFw12ZuCR9f3EwWuBzC3VbGeT/9GxcJw+7MtCPWZmlQGZJoc3IgyozVYAtyCCy2XyGRNYRTcaOVN7sp1FQxKI2T7Ua/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676078; c=relaxed/simple;
	bh=7k2gAfLv/TjbmU2E9gLEUu/B+940PJmwXWnljiaXSe4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ppq8wWsvpIgyapNJpIzm+TmCZ2YAdPygyP4SnySBei5R5TVK6IV/4QiJjGGnC/zi+/ch4GtTu62BoADJXyzn22rXrBDwX8j1yE98ei6BDcOtwdWoHvEy/8YYEDUBno7bf6j/uHK2s2+VEdWJxO5whw0FbyUy/kReHboJjVJAnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efFBcoKK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a823036so6674405e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676075; x=1744280875; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEjPesjuUhxFCerSHMCc2d+CamBtL2ZeC+dIG1aIsUU=;
        b=efFBcoKKTGh2J9mFJoMuEXTT2W60SxZxUXQUnlClKaNk2kJNCA66uLiAU6Srievr1y
         OBAWmpfBhMaub+UMiXaCu1WgHtUzNB+2DGsl1r7EEe9vHgcwp//ljIbMTwNMltfoDd92
         mYFHxKe+VjOQkLnOPxiAMJdaUVG/HCA8ImfgoHOTguzxXncMqJjwrIFKJQk8nvQodWLf
         IMv6+2+HNQajijimpnjS4DkTub1T0uwcFBrau/346S6H6B/GCKHtJGnN9WhDFZZxUuqk
         oLOPM2lK3FAlJRfWkIbeFRQdpmWL/TnZZagLknp8pb2o4c+yqmiTxkm+1q3x8WdhR63M
         0RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676075; x=1744280875;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEjPesjuUhxFCerSHMCc2d+CamBtL2ZeC+dIG1aIsUU=;
        b=JFJ2nrO4R82iVf6BX1H4A3MPZ69mbVXL9YRyW4n/sQqGsB1WlOauZZ32SoiX5gfQ72
         VJLVpmcggsJkt6ZjAcdBC2AmLuvXFmrfSxmxDNNCk+W2PsTY6zuKLpZK9S+vVZii2NmS
         RoVkt6/7ex2ntNyZc+9ywhtEh/ZfqdvEhBjmFavo+8an3JIOAihqa397npg/0CdlWCg1
         NiDlPx34M4NNpN4TfHO6ZAkYwZ02xO7IOW8GTrE815NzjxFSXqN1uYCDvsVoAIRD6kUW
         NRrBOqG07BPRqprUH+Jei7YgGHj0CtSkPAU8oEVuM4JHlULpDnjKqJXj4IFjDMzKc0WE
         YaUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3TGNux2rmqo6gJaw1VPXIzwBvwGDUzpSc5hvxyAktbOkeT71NUiU2CvDtqyElZAxM2nXMpLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ENXbzW+5NtE9BARUt0C+KmI54CkvjBisLxBvldcHr8ZvM3zw
	pK3/h/ZiXkPhdlfqLrOm3dkOfICwVEEPFaU7nSAw7DRYukvVrBrvyHrqcA==
X-Gm-Gg: ASbGncvQRnsQjMW5l8Vq0bZCwvYsiF/m4nwrdUGFG/k5vbevKWow2f15x3j2vW432/Q
	tRO2Tlu+ABrTTEod0IADwVoOd4KI7XGpGERaja0V6JRYbl6hmhx4fErn2k+LJaZFfMJe1+yYC3W
	J/lDWfpgkflaAMT6b8meLHFxp2T4bAAuhCPdc8tAC7tURf6vy6I8Gyc85V/4jtGnBC60ELNdmcE
	kOfQp5ai0ZMYHTF+QWdXPrg9+P27Q6I+X4aHcJgml7ITNGTdk+IH/bSyf5zadm5gyc5mUviPF/M
	ctBlNpkWDBBJL3i/sluv5ip4PDiwHCsL7YfTfAXfQCWAFeLypbzXLXvkog==
X-Google-Smtp-Source: AGHT+IEPXQYP8luHSEIpYK2Qe6EvbPJ3TDE7i9D0/9DxugxkxC4KzrCBikvU8T2FDvXc8nymRtiDEw==
X-Received: by 2002:a05:600c:a01:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-43eb5cd1a5dmr53483585e9.27.1743676074981;
        Thu, 03 Apr 2025 03:27:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:45fa:4ac2:175f:2ea9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d92dsm1407051f8f.71.2025.04.03.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:27:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v3 3/4] netlink: specs: rt_addr: pull the ifa-
 prefix out of the names
In-Reply-To: <20250403013706.2828322-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 2 Apr 2025 18:37:05 -0700")
Date: Thu, 03 Apr 2025 09:36:55 +0100
Message-ID: <m28qohhc9k.fsf@gmail.com>
References: <20250403013706.2828322-1-kuba@kernel.org>
	<20250403013706.2828322-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YAML specs don't normally include the C prefix name in the name
> of the YAML attr. Remove the ifa- prefix from all attributes
> in addr-attrs and specify name-prefix instead.
>
> This is a bit risky, hopefully there aren't many users out there.
>
> Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - don't remove prefix from the struct name

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

