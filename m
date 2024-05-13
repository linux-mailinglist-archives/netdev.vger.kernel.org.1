Return-Path: <netdev+bounces-95838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB7B8C39F3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DDB1C203B5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A42C694;
	Mon, 13 May 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz5PPO+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C3A920
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715565124; cv=none; b=n48PHLBncOhEqR1f2sYwLctS4mMw3viYoUbtMg7AXpyzqaeDTha7JxrdDhLjfGbct+qRC/QIu6HKZt5WYzN1gEvnyLXUlDE0kgG82gLgvHgo+NOxHWFzJt5G5Ud5HuigIYz5gsUPaJvolnl9F6pHynp1FpuywUGAsI1z96Mbrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715565124; c=relaxed/simple;
	bh=jXno2H7PU6itTMS3RY2GebabvBcByt73+atOpjWBfGQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gt718srfS6+sq+zbezlMLfrS5vib9Im1s2BFa6PjO7RRnXaLKIQn3Jm/nGRiuvN/fBfMrgdL73YxOFTRSFeIvCOATpXYrDbMJ/KuGbuX8emwnvUdwC1vtDl4KjzXwRug1OY4UvqnS77BxcH0P1gtlKOL3ciOLPnD8p09vUAcboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz5PPO+7; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bdf626beso353175085a.1
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715565121; x=1716169921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n3Y+BK+JF3KBjyDKKQrmaODzFAOjDRawtyKAUarq4o=;
        b=Sz5PPO+7hPCOa39Y56NodIap7X9rGHX0ECbO3xJ90dFQEPg8Ya7w4/2GhDr8w2O1+k
         LX5wG5oK+zscDzOzlnAckELxAyvm2hkFWLmHSJrfJ3D0KqaHVnOPr8bHCzbO3/xgd9U2
         reaesUNLp8Bn6NZkV31kBU/Ayv0Emvwwymr3eHtVg0B2aG8Dq1hcmDJje6JiWVILKLe+
         YYyVvulTEMjmUej6BmkR1qJf+p61T9lLa5S+oeoxQlUH9NDqpH250PyXDCwLlwpXGhmC
         B/uAochXvGEjNOmPzdStCPyZ5S0fEQt82IuctQ4LkL6+c5SXhAmrFZJAdIII2CFiS2U1
         ATIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715565121; x=1716169921;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/n3Y+BK+JF3KBjyDKKQrmaODzFAOjDRawtyKAUarq4o=;
        b=DejGflEzS205UO6cFM3/IUwGn0FPdh+2W5NkBTDMnhkKIjHCHdH+xdPalZ6kTPiHcI
         gKylolPJ2A/Jc3RKaTLeSO5MiCbvB9geJAS+T+7lt6nWJPxCiW8M1KLbuUEv9kcNAcln
         HbiPQWg7xGj1a1/XDwrzqWwk/9WJciQlXxo0dmOz0WDntRgK99yflj4DvnuSAG09+AXS
         M5Mvzhg5SzqzqtNsW/3OmiqhiJVs5VYBplW6C17rbMNscKPb63cZE0bHVE0JXjFTeuW+
         7kGsnXLW2CLuTCYYiWEUkPtqVuAlKfG4YiOuuUCkpiThJwFmYPoBueMNLuQeQDy0WT/i
         pL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVdnA7jaMGJntReS0eqID/9Ik9SwpIMs1+fRfMi7Ir8d+wWTZMeSsSFkWF7Cn925s28kcQuNno5znA4OVfsWpP2X4hWndV
X-Gm-Message-State: AOJu0YyiKeq7xqVuc7PBoJLHrz6/vxisDWwBceurliow7Pg+TtyqIBYN
	oAAPu7Z8RblCL6m79E97X/wHhcU5CLPz8Mv/MwSunB3qc7tD8GpD
X-Google-Smtp-Source: AGHT+IHn8Hl58eRqvUmV1Lvi0h5rEREAPCGqK8XHxJk5xbLD7Qs/2BWwnAXVCUq2d11Fx+5wa+WPdg==
X-Received: by 2002:a05:620a:3711:b0:790:9f13:2ed0 with SMTP id af79cd13be357-792c6c5ae33mr1727770185a.22.1715565121482;
        Sun, 12 May 2024 18:52:01 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm406820985a.58.2024.05.12.18.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 18:52:01 -0700 (PDT)
Date: Sun, 12 May 2024 21:52:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com, 
 Raed Salem <raeds@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66417240e4b85_1d6c672945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510030435.120935-13-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-13-kuba@kernel.org>
Subject: Re: [RFC net-next 12/15] net/mlx5e: Add PSP steering in local NIC RX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Introduce decrypt FT, the RX error FT, and the default rules.
> 
> The PSP (PSP) RX decrypt flow table is pointed by the TTC
> (Traffic Type Classifier) UDP steering rules.
> The decrypt flow table has two flow groups. The first flow group
> keeps the decrypt steering rule programmed always when PSP packet is
> recognized using the dedicated udp destenation port number 1000, if

typo: destination

> packet is decrypted then a PSP marker is set in metadata_regB[30].
> The second flow group has a default rule to forward all non-offloaded
> PSP packet to the TTC UDP default RSS TIR.
> 
> The RX error flow table is the destination of the decrypt steering rules in
> the PSP RX decrypt flow table. It has two fixed rule one with single copy
> action that copies nisp_syndrome to metadata_regB[23:29]. The PSP marker
> and syndrome is used to filter out non-nisp packet and to return the PSP
> crypto offload status in Rx flow. The marker is used to identify such
> packet in driver so the driver could set SKB PSP metadata. The destination
> of RX error flow table is the TTC UDP default RSS TIR. The second rule will
> drop packets that failed to be decrypted (like in case illegal SPI or
> expired SPI is used).
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

