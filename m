Return-Path: <netdev+bounces-107634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C9691BC93
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E74EB22056
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12B154420;
	Fri, 28 Jun 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbl157/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D991534E9
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570462; cv=none; b=GBeD5AvcMYNAASaOsa1AUxygJkCBJQuLvf4ODDXbhHqQEY6/UzwIQp8uufKJLnKwhFOkM8bIOX8FRyskL/P2A2BoET4dcj653dm8f/AoVFLhXEgBzHwAMGBxgG4CnoADk72km7DwOh105h8d+kTYXfczqaIgMdY61CiYmAZrEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570462; c=relaxed/simple;
	bh=HY9j04lqR74/OQFJpyS1JErCfl/TzHDSgHbGmezHzR0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Y1lWOXWUYYuQvHvgcS8QBIxkDtIZ4uNzyHAIfsaa4aZbi2NvUT1uKS6oVTe/yFX3bom5cDn0x89JgjNxZ1SP+OU3fwBIfVl94ZiP8I8cqD7abfIwyTycSBzbm9i/Q9CVEbbd0Gkng5Ox66vry+mSwo8z+y+o9mgeEpuVm7CCQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mbl157/z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36279cf6414so271973f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719570459; x=1720175259; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HY9j04lqR74/OQFJpyS1JErCfl/TzHDSgHbGmezHzR0=;
        b=Mbl157/z5Nr1SyA9DMiv0k3nrP2qHPra8sRtnzueV7MgfYPsm2X377MsQ+IdsBvNPM
         13Q55XzT4x7Y8823T4hwDLcPa1rpyJ7r4k9W2Mnsn4ocOr2bxxtzjt2VQnEVLUmUUVfm
         90oyROi1KVk5SlTFzH6AGuGg21xCoyahmrTy0kz68yMYN180NsDxQLayLXN0qB3khLUo
         k+C1ndRSfWFcGxN3iDJks6YjYTRaNrogLsWCc6Z9j4CkSIz5FPFV9YSMF92vNzhDVT86
         g55VKJjGUr5+NQQ5AkHOwLEqP0VainGqykv6R0RFc61zcppE0tMKP11qPOfpGtN0c9y6
         or9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570459; x=1720175259;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY9j04lqR74/OQFJpyS1JErCfl/TzHDSgHbGmezHzR0=;
        b=JEIVDH70X6Y+adbkWecYDfvN+W6/vAzDQa0wpPRef+BQh/iNrIQ7X4wppiX5PQ2Y1J
         CxfrBscFYA0Qt4OCBI92EGgnqdR73g5bf0uJecgZ/YFC2mf9S4dZL2sc4N38jN7F2rqF
         WNWGmaCa0n4ng25hL5Wpgb7Z+qd1TQpMALWlCLz5vgQxMX0YHt5Pi467UcIuqQ64LsO3
         KJvva8PQ3NYbbHl/j2AJjdTS5eYAQ3WacfmRVphsAIwqfMIxDlCanrm1TXB+4wERgYJa
         zZI/9H+B2px7CkddwzV7Lxlg6uL/oDgRI+jPQHUmUpxSdkJXxva09/TB76iaGqKMlgwg
         nHVw==
X-Forwarded-Encrypted: i=1; AJvYcCXqJjj5dtvILZBfs9XcNzLTRpEXvzpRMGQP3b7o4IwXvujsl0c+ALtOzy0O+gLv1XTdvXbQP1CzLj+jo+4xLG6o1GAhRVpg
X-Gm-Message-State: AOJu0YwdGRp/923wmsQfBTam9HFsxfuIOvDc48R3DzPPS6sj8gn4T40y
	osLF5h5DB7MfQP6gfjYIYzh75tloy0i3Qz9rF5RH3N4Zt5grLiSK
X-Google-Smtp-Source: AGHT+IFwD4NCVG/L7S8BgYznApgRjvx+99SDm1peo9xDf58qDmQvyhjMBA0afl8Y6mB1ZD6+rS1W/Q==
X-Received: by 2002:a05:6000:186:b0:364:4b4e:9310 with SMTP id ffacd0b85a97d-366e9465158mr9800518f8f.1.1719570459403;
        Fri, 28 Jun 2024 03:27:39 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:49ff:2a2d:712c:9944])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d00sm1820814f8f.99.2024.06.28.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:27:38 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] tcp_metrics: add UAPI to the header guard
In-Reply-To: <20240627213551.3147327-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 27 Jun 2024 14:35:50 -0700")
Date: Fri, 28 Jun 2024 11:23:41 +0100
Message-ID: <m2pls1bc2a.fsf@gmail.com>
References: <20240627213551.3147327-1-kuba@kernel.org>
	<20240627213551.3147327-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> tcp_metrics' header lacks the customary _UAPI in the header guard.
> This makes YNL build rules work less seamlessly.
> We can easily fix that on YNL side, but this could also be
> problematic if we ever needed to create a kernel-only tcp_metrics.h.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

