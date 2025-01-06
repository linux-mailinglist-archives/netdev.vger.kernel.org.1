Return-Path: <netdev+bounces-155581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCEA030D7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15222161B2E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9C1DFE37;
	Mon,  6 Jan 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HH8FtIKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9B1DF961
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192714; cv=none; b=JO0JVriiIounVv5AeH/gOzUNczX3WwV++qXmFx5exgJ9K6a2+Ce8kKb5aVIlWJgBWi5c3s/7MBwDsP8yG0bAtg1Y8hYjmzeJmP+Z+WwO9zcQKRZZ/wma14VF83k3ee2QQs6hh40UnkGkoe8ifr0bUJ6f1rSmslghBP4ZRW+5Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192714; c=relaxed/simple;
	bh=PON9AGfTkBePM/HN7mtINeIQQyXBNnztwBb9zM8r/Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiy17Q5k94bQnTz0sPWQQFF8+iyt8CBETBA2ECUQlrYf6bkh07jyXpWD68EZCRF0LcHs+KykuqcNI2a0+aukiv2Q6/3MlokZ6Dk6IvCv14PGZ4TeMJEtMc6l/diOckObMsWl31GOwQuj7VeCdWfQDiNOREGQPHDs6XDHPtNsfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HH8FtIKN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29f88004a92so9821138fac.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736192711; x=1736797511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PON9AGfTkBePM/HN7mtINeIQQyXBNnztwBb9zM8r/Kg=;
        b=HH8FtIKNLwHm1dep5ArEYJKGPt/zHeuALa3NZN2iJ/7KGv+AZzB1BvLCeDkPaPDQhx
         LUTLsGiFKsNzHTW4qrOAgsJ2U0PJUjTWc6Ug0B39WLOySLkEmdYCxnqZ1jj30GNdUed4
         1bb7aD8kwLgiaG9KKsCrNf/ojEQyTNJMi3lfqvCNZyB59MnJnHIZC5Bglnd/F1DoC2ux
         akuUsqohIlHVtvuxsUQQy3iEwGdeZqgR/DDjFlK+KKSM6jgMuMVFyAQwrA9TGIaQ7ttC
         xwB3fZa3iDAxMBdbuNFEodbjHoNP7r0m773WfANQNWtx0R+Gpokj+UgaWmkioreEpKSj
         fYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736192711; x=1736797511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PON9AGfTkBePM/HN7mtINeIQQyXBNnztwBb9zM8r/Kg=;
        b=ZQJsZUFspf1nOlsb2o2HswcfGMdT45yaHwlaQQdANmXvpEOaOKcWfEXBwkUgHpXRAr
         iimb5EOkbSCxi4/op+5noZVzPi9bX/MlzHB3bgXRJDIfs/hoRKGkl7/CkzczTgmMfJiw
         dafZiBYnHVjpfL4GdO7Z+HsK+XSdTd9SFdWwvCrKPa7uVF8owXllzEgFdj1x0FA9A/bp
         WpiwcV1Q7sfT4m4VlKLbst5tvuDw7VLE6RmeBLHupW27d0XGCFwqQt7t2gQ3DpqS8AB6
         CdQ3Cr62BO9EOB7N1yu9CRUMwJoG62Bg5lAeNokJ3X68Ry9syQ+1DOcOBRse29EonjVo
         k60w==
X-Forwarded-Encrypted: i=1; AJvYcCUigOcSXT3qkTcs/70oy4Aw8R9cjMSUnfu1QHgOwGym+k55t8PDuweGsLvuZYnSY0RnKORkxx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCALLR+DSP61sD3vIBWj0oUNrwCYfpbtJNx25ssad6mP/fVr+
	R6Id10y0dursF3d44fxBOM9EoFn75HGc+5GPoQHh8P7YpNdtukoTSEEHJmmbaZ+HErfldi4oxqt
	kfjv93dARyjsAV02FXgBzbetImqrEa1irKsSlPA==
X-Gm-Gg: ASbGnctCYblwsseWwKm8a5gIQnxdDNF22meqkmJiFOTe/Fk7LGgWEPgitx52bfrvaJn
	q41NpyJ4delop5r04V7j3v2jTXSUSYkfAml13vA==
X-Google-Smtp-Source: AGHT+IH/4cA/gr7SwIwKKRIdcGKE51Fh3Zo6ASYJ6NfRiFOfMKsRW6ihD1j3orHlBus7mr6Ul2pftcwdws/IM+WpCIE=
X-Received: by 2002:a05:6870:9e8d:b0:296:e6d9:a2e1 with SMTP id
 586e51a60fabf-2a7fb0aa2edmr32715250fac.11.1736192711105; Mon, 06 Jan 2025
 11:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124819.6950-1-zaihan@unrealasia.net>
In-Reply-To: <20250105124819.6950-1-zaihan@unrealasia.net>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 6 Jan 2025 20:44:35 +0100
X-Gm-Features: AbW1kvannVtOGNsSoZKrWNjnhUUwIAtkh5XrAosMZ7f8wqwdeHXIySb2AMOe1mo
Message-ID: <CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
Subject: Re: [PATCH net-next v4] wwan dev: Add port for NMEA channel for WWAN devices
To: Muhammad Nuzaihan <zaihan@unrealasia.net>, Slark Xiao <slark_xiao@163.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Muhammad,

+ Slark

On Sun, 5 Jan 2025 at 13:53, Muhammad Nuzaihan <zaihan@unrealasia.net> wrote:
>
> Based on the code: drivers/bus/mhi/host/pci_generic.c
> which already has NMEA channel (mhi_quectel_em1xx_channels)
> support in recent kernels but it is never exposed
> as a port.
>
> This commit exposes that NMEA channel to a port
> to allow tty/gpsd programs to read through
> the /dev/wwan0nmea0 port.
>
> Tested this change on a new kernel and module
> built and now NMEA (mhi0_NMEA) statements are
> available (attached) through /dev/wwan0nmea0 port on bootup.
>
> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin <zaihan@unrealasia.net>

This works for sure but I'm not entirely convinced NMEA should be
exposed as a modem control port. In your previous patch version Sergey
pointed to a discussion we had regarding exposing that port as WWAN
child device through the regular GNSS subsystem, which would require
some generic bridge in the WWAN subsystem.

Slark, did you have an opportunity to look at the GNSS solution?

Regards,
Loic

