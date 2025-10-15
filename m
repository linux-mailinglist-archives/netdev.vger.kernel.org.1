Return-Path: <netdev+bounces-229801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ADABE0E85
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77AE44E7917
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D4305979;
	Wed, 15 Oct 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2x6/4kw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7463054E4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566364; cv=none; b=KLwFYuTdk08mV4U4JGCvvcm4Q8vK45i3xbQnyq3fB0Mqa0L8oQNp5F04mSzFTTlOTwuzUx3gGBRcpdp8aHMs4MYCWZdUt1h6JEKziImZXwZMkrx7o8VqbI5HzxORwGgebvIo/29FtM2TnxboIbn762xEvfKUZ+5478oSpoiMtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566364; c=relaxed/simple;
	bh=4IKbAWgA3H6OC5oCFfEcR4k3LkR86GPruUZV2iVfAJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WsJQyLeiqbKGBj+9F6FRkvXEAda08tGu6DIsG2K/+Ji7IYHRewJ6c8pl/i783wGe6XzCSPe/JUehYQXz7mQqaEbaQn0SlrTmHfwNo+Dge5HWyoep2I+Ak7YjsEBskb3xoWMkO8Sy45vIx2Ee2rf8qbkzzksbkjjTQepwb2wHZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2x6/4kw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-639fb035066so61417a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566360; x=1761171160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4IKbAWgA3H6OC5oCFfEcR4k3LkR86GPruUZV2iVfAJ8=;
        b=S2x6/4kwvfr/a4WwHAI9GCDDtx/U3GK5S8Ty2JHDaejDTH7YTcNb78LleERJZI5Y7S
         sYKLjLDBLDY/x89PyVbjfvSBnMCCFg/aShboylEgCvR62fckn5YJ3b9JZDWdeFl8cMbm
         4ROvcmi0vqDNn0SV3Hz8/N7spjsm9EeZTH16i8zU75ZxDorgCXk6Inb5hA8+alGOkuEq
         3EEcRLkeLFSnofT5SjGI91QI95zmYb+syoUMSp6pC4S8CF9Nf+p4jpQK8epm9ZqQWuOK
         12O7jbGG/iFv+/vjxBhy0UYcl3pI0wO6uXK/KKjjf16QTbHsrRrfqWUgEBuGXfXWNMYA
         Wv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566360; x=1761171160;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IKbAWgA3H6OC5oCFfEcR4k3LkR86GPruUZV2iVfAJ8=;
        b=TodRAPbCnLSWFPQZP5qcuroT77dalQhxSpyPgJrc07oEx4P2ALc10UezIaKolmK9wa
         0T914MpFheV565S+k61979/BSCdyxpXWu7Gb50V7UGzpCh40LYIBQuicK7x1PmEpRUM7
         U4tiJQ3sltzDrboAAJVEBMT5xSuiGPkkB6eEhXn+ZFPjzLTaEowqHgy8f3oG+YeOUcUz
         0hkpNVdDlaazGjBi8nuEADlTvtmpQK+HXnPH1PgbzB7u5gxHVXSZQTtgTPg7oPszKP3y
         2LDpDI6A+nRs1ubNVmJAKaBt26QbyCleH3WpU1hRF3oGQ19m/zzAoiHNAypPamQoW+gB
         B+4A==
X-Gm-Message-State: AOJu0Yy239TPU4gYIuUHmot4Xi5mSjh72/h29pLaHmmHaNNdR784X4SU
	WF5JkSQVsXKVb+gRqJNVlUaoVSEMCpXXT/K1yfvKuzxamamKYLJcVEOrNl7oHQ==
X-Gm-Gg: ASbGncvWcMfxMSs8wAjzC4MbAbEzBgyu4FG2Av2ToK0hLGJhawnsqQZf9x+h26Wyoyf
	YMGirlhFcMQ1V1p8VjkpE4HmYys6eOZLLJJcLPSo3yIIg084bSC9gBB6kolntWLSPH3t3ynLBbA
	kFmJnwUJu9DXWnMkt8VDaVK0XJ/4PncucnP0PzjyIXIg7q/SzxmyRjbNS5aI6PwupVRAinjvCrc
	mosTHmO9NRF057Yws2/OFtN4hFVmRjcD4L6+a4JqDWm+RXjZ7EENuHHSP5wZ2SWhvZM/4ftyf79
	kPg61TKuyDbMU/OfTUy3S8TGJM7mvs5JG4osDtAmA78BCBp1wattrL/Pyp06pJto7lzht5Gbg+w
	Ag5yByIStMjLqT9KeTVwS/8IxHSnkpo9iewZKYlIAHpyE88hw+cy+Ey0u1ccmD69imQZWd/zZfQ
	tf/KOGUwrsWVhePbvjeA2/BPs5cNaOyGqArPz2Ua55ChPlfqX2Y3MTpZtskcuWwW4V0zP4A7LzH
	ov0gDO+KzXKC/uYlV7k4oo=
X-Google-Smtp-Source: AGHT+IFR0KR2S5pXLFC44VWWdTv98MquvdPb2nW+92laXAi8QPBUxX9Ll1PRJMHw+6eTcri5M61anA==
X-Received: by 2002:a05:6402:1ed1:b0:63b:f59b:e5ff with SMTP id 4fb4d7f45d1cf-63bf59be8f8mr3395459a12.22.1760566360136;
        Wed, 15 Oct 2025 15:12:40 -0700 (PDT)
Received: from ?IPv6:2001:1c00:5609:8e00:d43c:e712:50a6:eb5? (2001-1c00-5609-8e00-d43c-e712-50a6-0eb5.cable.dynamic.v6.ziggo.nl. [2001:1c00:5609:8e00:d43c:e712:50a6:eb5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm14137720a12.14.2025.10.15.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:12:39 -0700 (PDT)
Message-ID: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
Subject: ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are not cleared
 when static on-link routes are added during IPv6 address configuration
From: Garri Djavadyan <g.djavadyan@gmail.com>
To: netdev@vger.kernel.org
Cc: 1117959@bugs.debian.org
Date: Thu, 16 Oct 2025 00:12:40 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Everyone,

A year ago I noticed a problem with handling ipv6_route flags that in
some scenarios can lead to reachability issues. It was reported here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219205


Also it was recently reported in the Debian tracker after checking if
the latest Debian stable is still affected:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1117959


Unfortunately, the Debian team cannot act on the report because no one
from the upstream kernel team has confirmed if the report in the
upstream tracker is valid or not. Therefore, I am checking if anyone
can help confirm if the observed behavior is indeed a bug.

Many thanks in advance!

Regards,
Garri

