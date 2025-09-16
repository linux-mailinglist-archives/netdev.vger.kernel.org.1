Return-Path: <netdev+bounces-223598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB960B59AA3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F33AF40F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A748338F54;
	Tue, 16 Sep 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PB7HSN8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE3334375
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033639; cv=none; b=bbUi8DJ7umRhcbcY5o7UmnHo4E5MjZEo2n09Gh+YTe7N3oahLKa/VthifmDK9dnVhV5AJRX4L+Tj4lDnwwr4i7gXKJsFEzD6ryYzO3bgXftrlfdPYmgJ3m3TTUNgwUNxw0qDX6tkzve5SHhiKN/c99GLjmwJWKi7ZftGFXTRBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033639; c=relaxed/simple;
	bh=kAE/kP/8YfHAtmz/50ewqbMlclPzTuDXYPsLPzAXlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQP2cjcTITUYhuXyCXpOFuI7Y/rIUe4N9adzlXD65ZxNhucWO1jbBa88OSHC4h3Y9SOw+z0oz9ac9AF9qiZVQm9ptEoGobbnkZgPeujRjXdn8YQMgruTwiS3H9Trn3/Y57/9UUeoxahV6tOBNGAKjwidx1u0MVxNdg5E1Qxyogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PB7HSN8n; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b00a9989633so1070777066b.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758033635; x=1758638435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbBlPdVxLUiaaDwT7hPM1pqY2WWWX1/pW0PwvjmsMxY=;
        b=PB7HSN8n4OVhAt6PHhuyq87QtAHQbEYm2UVriBnM2D5xXiov2AldrKoXKQgTf03W/O
         MHh0zkQ5tW97HyoCZ8Nwz5Zk0qvWvu8FWHBVPNk1pGUyEacYsL4lqvVd/MqaNpL/NJs5
         vnGeEdEcs/CcQIkR+TdnY1FOu1igSGn7gEhdMpyoB6ov6FQsD8jqEVEFGobzgPL9MFCE
         0KkpEQFltdaRnwg3m3PK8++fWGyvn8XA2TcTkKkrPZEEQ6drYB3FXLaR1xemcahNN9MP
         oL1mqB5f3Ovd/p9ydEFDdRSIi40jXrwpzC6RtKGj8+jIIMljLMQJDbo1VvI3DdVkz3D1
         WVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033635; x=1758638435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbBlPdVxLUiaaDwT7hPM1pqY2WWWX1/pW0PwvjmsMxY=;
        b=jcvgd36laYqU5PBaWp1/3CPWodGf+MJl97zYS1kCEXQotzjYZn2nfUx7NHPWasLX3H
         0Kxbc92luGaqXC/aI+jDCjPYrn9X8tqdcqTXGxIDcJ3re0eXCAcB6GS2SfGr2/L4RnhC
         u6cOzetxPMhCF2iMslfnlAoHyZsFCiLQHrKo9CSbRMTWuZD6Ce2g48tQ6Z9oGauSUapV
         SePqNhbZ4cWm+7vLd40C7de62mvCXYyrXZljtemyyCYwQK0cMeSF0ZoPkTCzM3b31s0M
         d8L1UB/oBhUEuZB0i3e3Bv5VY3VRTeGpTIRfR+AtMMvdHHrHqM29RBC25K8muIrszxTz
         uOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW46syVTFYqnkxGG8jMSQbjffHI78ntnXtVgklsB4GZTZSSpGg02oXfZC0uUVb0LNoMir8ksw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrXB2FI+wS1/27ecOLX520SSRZlsxCAipMcduB7Sf+hh1x/7O
	MMp/1JrnU+xIkB0K5H8ltkN6w0RraSLDu8hl+bPB3CXfMqWAkvKXJ7EXAX2ChXOjHjy/IAW+vDo
	B9faK
X-Gm-Gg: ASbGncvBb+KSfPJRU+Co3KqaXyiD0iwkdQuY75dVjolFxo7hpj45gXTeKqLoc5y/miR
	STjPNfqF3TXDC14NBMtbJPc7I+Y100ELws3Adswhf221787jYL9+usOZPDYOSDsej2oMC/Qahoa
	CthbPc8351Gghh5eMhudmU5w1dWwX909SDxk9oWFU3KsHMhFe8M48bc1QSLW/ri5S1n+TEzuSuV
	hr1HIDpCc4cmXnpZGjNSB/T7TeCjMkN8NU9SQKJYWd3XT88lGT1Gl7Ap6MyGCtxgNMc9XPJ7bix
	LZ3DXmNbfmGsNmU4/mOzET2IwVKrzNxsQjNhtKJ5QW7VjmGJM0piFARz2Kg9naaHp9CmIe2a0Ai
	ckiJ3+8fBbkXGzqLeCZf+dEqmR/F2ggeq42Ug0perCenLFSqdScBybHb05xHsJwvlZbXiEVaZw6
	k=
X-Google-Smtp-Source: AGHT+IFFcTDwDiDOtPqR3E7U5zaFBMKY2xjU8p4A7q0S2luPNaRMxTxNX+e7Cw9Osx+vABmjXj5K7A==
X-Received: by 2002:a17:907:3ea6:b0:b04:3b97:f972 with SMTP id a640c23a62f3a-b167ea60331mr328183166b.3.1758033634639;
        Tue, 16 Sep 2025 07:40:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0bf0334ab0sm635180366b.31.2025.09.16.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:40:34 -0700 (PDT)
Date: Tue, 16 Sep 2025 07:40:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import
 script
Message-ID: <20250916074028.1e161f5d@hermes.local>
In-Reply-To: <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
	<20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 15:21:42 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add a script to automate importing Linux UAPI headers from kernel source.
> The script handles dependency resolution and creates a commit with proper
> attribution, similar to the ethtool project approach.
> 
> Usage:
>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

This script doesn't handle the fact that kernel headers for iproute
exist in multiple locations because rdma and vduse.

