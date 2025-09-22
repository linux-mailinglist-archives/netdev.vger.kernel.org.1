Return-Path: <netdev+bounces-225338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D3B92597
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635D2190442D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040E3128CA;
	Mon, 22 Sep 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQbC6712"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CB311973
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560972; cv=none; b=k9sQKh7hBS+9bEImru3OfeBoZ/32JwhweINaVRw/XTwuZXaJqKHmLdNtgjBlFX7Abrc3puJvoUE9T24UOGfjpwv2DaX7d7Mj+iiMGHUi2zVQ1EuZXiqv++xYgkfwMN3Npg/vot+red8LeDr8/04fPTlaV8SDSiD4Zo7dHYv5WNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560972; c=relaxed/simple;
	bh=fT/psD7+Vz56LrFxpZ7ZEzjPhzQjHq7F9NH1iMHhNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7GRA5r4E9OIfcVEq78Ni9TZ+z/AfmwmmFFa/BppwC+eUF6ncMHjhQgCz/ApPdGkYGxDvLTqcOcFgK0k9iAX6Vx+GmDLlyzV33HvbilqtBSzpiyuLQMOVcsbueWG3Gk/lBhi00LJwE6AiN5h3Iiss4XG7YBMGQICs9p5v5xgdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQbC6712; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3423116a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758560970; x=1759165770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMIgCfI8Zy6cU8RYUy/WiEQmMhMNer21IBatYzMRFPE=;
        b=bQbC6712jZYU5b+mfawQGA4nEWQP0x8lkJi+Wuq8gOPqQUAl1R80wSSXU+75EWC9tv
         n12vaxszJtUQ9sTw0QQ9MojBQkoCb9qEXJa8yjPL/vwpIWIKiMGy84iOKNRPVQ1ju6tQ
         upwvm14BFUiON6gBiH01XV2izHO77DEovChFEUrSiRUYkvaA1ww16O+ArKGt8Qefx2Of
         lbUdhOfPlk5W3VeWsrGzSUkDHO3s1jt2KaW/l5Wp24FRNRPh9++sRrQTdVEmeRu5bx/S
         TRRhoicZzxRc7NaMbTWF26ohJMOq31fXgcADB6Mdua0bWjLM4cr4EfUPGyMlAXCqKW/u
         MG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560970; x=1759165770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMIgCfI8Zy6cU8RYUy/WiEQmMhMNer21IBatYzMRFPE=;
        b=mD7ZikHAdnTcM7usXvWNjAOvbXfkt05VN0u6I5FvsuJeTfP1AeRSnsHoX/11sC8o/w
         WvbTJUXrahDyzE6t9KY5RWMyiAHzlxVIcZEHXaicIDv+YwkJycBmQbg+Xug+59JngW92
         yf6geHKdU9qya9mW732RFxyyJCK/UC5c4xTg09ZYDT5XSBnhfJGwEVBIKOOtKbehmK9S
         Bla3xFpT4H15ayCFxurOWDwYkRRxfa6OFupAIGs6/QYVuYGjuqOpJQDeOMCmdEy0VoW+
         vSRCKlXE4+k4A26HS7GYbOk5sGI/eVe1KDo5PPZfptKGrHw7/PJMmJ5E5YxDv7toiDwT
         nNyw==
X-Gm-Message-State: AOJu0YzZbxPxMN847Mb95M/y2FoOX7U5Gps4+nWl5nwWdDa8NtslzDdQ
	KUayMuz5chOteBLN3a7+tnajiD3UTicZrZDU0tdy+l/naw+E0ladE7o=
X-Gm-Gg: ASbGncvWxdC1jfSnIVTRU2bBf1qR3yBBs1ML+78/CfBrgrDoY/y+pm9h6c2Wf8+oVrT
	qlPx9W4fqUwoNRRZaM33hRiShcUizVoPl1EQrqYFPx6kpWIBF79JH6S6fzdvg+jhht4VPbuCVZJ
	nZzIRcWvOXIUz29QRtMJgtR6iou5FFHwbQ/Eno+bR0aj3eOlee88/Ea8MRJlmrQyJuTi+TVFqat
	/A1o1sEbeakVilXUYiRr+d/ku4g4kCPB0I+7Ne34nUtCFfBWZCs3r5T8oogrbXOMu+pbn7wwJGD
	covYKdlVDoOY1mnCoAvTeVmaRVjHD6H28KVv6De5Nf/r8GdLpaECimVGabLyniJazh0rUkKE1Wo
	H/Vr6M7uqfElwlb/EOyNidAmhdbrQCPlURwosmPSJlnasCK+oGqQAz07ZzZdbT3wQhxu/SHwmQA
	atfhYQRu7h1uv8QMIbQOfFq109CMMUjMH9ZF6rbMbr5ETm6j6b2waaU+1+E4d+hK7v3DrSehQ/G
	01H
X-Google-Smtp-Source: AGHT+IHlsA5stse+g6GM9QGHO/6DxDq7onh84HX4mDJJ7uM4MVYbwwbSHEc2sG845ZZJPboq6R2g1Q==
X-Received: by 2002:a17:90b:2250:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33090a1034bmr18932796a91.0.1758560970376;
        Mon, 22 Sep 2025 10:09:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-332a68ca99esm31215a91.1.2025.09.22.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:09:30 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:09:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 20/20] tools, ynl: Add queue binding ynl sample
 application
Message-ID: <aNGCyWRneDXiUWjv@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-21-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-21-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a ynl sample application that calls bind-queue to bind a real rxq
> to a mapped rxq in a virtual netdev.

Any reason ynl python cli is not enough? Can we use it instead and update the
respective instructions (example) in patch 19?

