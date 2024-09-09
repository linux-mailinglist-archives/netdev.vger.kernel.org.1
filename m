Return-Path: <netdev+bounces-126619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED870972150
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669F9B21CC4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252856766;
	Mon,  9 Sep 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb1OBs9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDC4C74
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904113; cv=none; b=AlfIebHeEiY2Ur5DonzSkoQkK2mXSg1naKGcAlJwL8wzPk+VOAcIQUB+wp83rXbUhHa5ydHLpxR3aFz8wE+O7wKN178Sut+slZCnBetPWoj+jeDvEGaGgEVltsNWxNxeqzw7zzNAmZI/kxcsTduVpiW3MEq/wjd3TDFjtGcDeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904113; c=relaxed/simple;
	bh=BZ5vejJyig7bH2PlBQvJeoQWJmKbCDv0SBiCARz6LH0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kor0rdKcvLdFKUo0+UWH/+lE3P9gusVJtpNhESGIp/gJiVkRYOFforOfVrx1v7lBvKMEbx5OFHvXMk1E1uDfd9thEMizB2pvPEnTEI5LAO4MwyH6Yf0HELRpuDx45CESwJFoJNDZwAxIyyfV0V5jCtut5XmuIbVMxXGG5zD8QSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb1OBs9S; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-846b934981aso1259486241.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904110; x=1726508910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wguwWgQIpqRnF5G7+8yJWe20L+tHSPm8g3gsgcnZQY=;
        b=Jb1OBs9S54Ma6WSkKGU7O59x10Nk2tbjaEK76ycXo6jvGQ936MD1D1QRDcMvXv+6me
         vLajiGbNRBqfEIQiACeb8iICM0BC49oMzWUFNrD6nlFsOxHaZiBQXYncDRm9S8XajQht
         LEF4pajVYBdmtHYbz9iAEVU/MSQmqxkF7rnsSXkpqzxkAIXvq73f1dILCwI61IMFAFAh
         GLOS7N4n+XCanpPYpQDj0tb3Br5RmapTD43mOVdjQF5Q7kzvrjXbMxm8gLGTKgxzU+WE
         WEpwb3mZCV3sn3knj8NAjmNCBVl77s92Toy8wcrUOXfJvN9T9C8XPcor4Kco13hA+6Y/
         C/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904110; x=1726508910;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wguwWgQIpqRnF5G7+8yJWe20L+tHSPm8g3gsgcnZQY=;
        b=r2Sh+ij0shHqII6LLirdCDxqzl/1i4UvQ53Uht5UKke75ZNv3HDqVmlZXD900wDyeP
         g/cdYdrr68FizhnWsEb+1MyOKClxcVOLliIaIrLSQbB/l/36vvPEgoExIsxPG0bQJwFl
         YrqPNMhuBpRVUrha2BQhOkaf7FKS4hlLo/Qx/4/7ALcDn+o09Y5WpT4GDcj0cckC7KZ9
         hvl+nAT5xtqMFVcFxZYeBKf9mFGxGy3/Fb0idDl63JbBb4WUksMH587b927j3g/viRYw
         OBjTPEvHsCvoFSQC1oCITNqsknbfLwPC+q3P/FsDa4rxw9O+yZWCi0QG5R/xrk98Dryw
         Ph1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4QYovIJAXs/7I1lhuBC42vW6ezSIUc0dp9Ox1KIEzi/XmW708GW81MMhhIvR6UbLtR1kkFHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ADlMly+AOS4A1uKL9BWxLAMK18iwR5uxg5cmGNdzWhZRGJvs
	ssAO1zl30GWpmYzxgY2tF7C/we8yN8J9uu8z4lnHRMfkHf/ZHWGu
X-Google-Smtp-Source: AGHT+IHvDKm/dIYhI2F28lgAmIiNCc9u2LXqEAL5lqa9IxqqKAquL7LNf6WI0YoKZ7uCL0KAhfGYTQ==
X-Received: by 2002:a05:6102:c50:b0:49b:ccfc:6b5 with SMTP id ada2fe7eead31-49bde178c60mr14309288137.9.1725904110474;
        Mon, 09 Sep 2024 10:48:30 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534773468sm22344976d6.105.2024.09.09.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:48:30 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:48:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66df34edd8464_3d030294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909165046.644417-3-vadfed@meta.com>
References: <20240909165046.644417-1-vadfed@meta.com>
 <20240909165046.644417-3-vadfed@meta.com>
Subject: Re: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> The last type of sockets which supports SOF_TIMESTAMPING_OPT_ID is RAW
> sockets. To add new option this patch converts all callers (direct and
> indirect) of _sock_tx_timestamp to provide sockcm_cookie instead of
> tsflags. And while here fix __sock_tx_timestamp to receive tsflags as
> __u32 instead of __u16.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

