Return-Path: <netdev+bounces-242772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA84C94C37
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C9CA3441CD
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAE1FF1B4;
	Sun, 30 Nov 2025 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDWhMsDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB781FD4
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764490059; cv=none; b=nd5zQvsh5WaF5Wcf7IjeUqPYLVgW8TxmuQDMq6d+xuc7uYUaa1qGViG+p58WyGDi7O3ydEJcPfniJPk2RbPT8d2sMRptF672GVNrRGVi6+zPPrd/cjmpdaIlNuva7vXnYuoQI4g3h8cR/P/IWh06TRe89t2F5jHpJaT1KhTQiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764490059; c=relaxed/simple;
	bh=4BqR8i04DJ4LHGlawmh3d7XuP4glW6AD9nAnEQwn4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbCQlsyBBlwr7+mcJyGMjWHUrPhUJvmOGAaBfkBkT9hI4MBd7TFjzWBjQ6SLCUrtSBTo0A/N+wfn0ljUz3SQTxYJYPCRRExjNSS324Ud4BhFI/jyrRJD2s/G9plh9Zft2k6JjF6lhYVBw5AdbYMeX9chtYiuRxHnLqw8kSPQECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDWhMsDq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779b49d724so4489245e9.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 00:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764490057; x=1765094857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlsTM8X40xseZoss4FmEjFSiPfPo4hKAiGVqNHsXGAU=;
        b=aDWhMsDqBJKMQXfNVIHTsNL8BCw2LKygoSnqFA9hUPwJxuORsiRzy6AzDXPOA5xMbC
         oZYRf5TVvXXn+oIGRCZdyttLU++DW0X2OdAUuP5+e425VQurQLD8h/LcQfdIv4bNRIFl
         BjdgRdTcYsHDmDYPl+5RPWdrm5n3tWnqlECLPJ9/aW6uMSuQbYsaK2e8A9MetYZvfL9B
         xR5igGUh9aODBWfY5E+mnR7fL03AW2C7gRLn359isgHchZSdQSKRqmzt1aG6yYT3Sm+F
         96o+gABO6sNoVLK1S0sjMCJnBte4/BrQ9saA7BEk35rNvgpzRSJanBywRKOym9iSRjN/
         1lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764490057; x=1765094857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlsTM8X40xseZoss4FmEjFSiPfPo4hKAiGVqNHsXGAU=;
        b=DA4UMkzsuVzG/N8LxKMIJYn52cuBKB1fIUffIV+AU5OhgqPpdTeZgew/oYHtPT1kV/
         qZOk7WqHFrZuQpoAJJMyWczi1vUzZGeqUyBrmCtF1c/PucNWm5zZ45xIToW9Dt99gkRA
         jsZVevgQ+6KbcdCv//qoKyqb4bXGR6GqFRUvt3pXB4IBreGLFcpw52Z/KfCOanAtNepY
         NCIOpxNlUTKzp6gRsbikb97ZvcquDH1aNewFpNTgA+kJ09peyvZBuZ60QnS76ssgtICA
         VvWUK1CCm6keb5IQuZqv4qHel7C7xZgo/o6LKhApQiZ4b9znDb1UPucRNZlqGt7ij5nk
         waQA==
X-Forwarded-Encrypted: i=1; AJvYcCUIhGR1coPYE4B+FHKqTHS/n/11ZJRTH/dCPteiAq6qBMyzWgDbSiblE/DONUb0IefSbgxq3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQKMhvL6+PgUeEv9618Zr45H1pD7zQhfLgpPo+KqX1cu1sfZ8
	KPeGed0EBP8bzBBquP2jCYRyZuwH8DFMKnBzmvl1RHloEWcA6FalJ2kz
X-Gm-Gg: ASbGncvrUDq+yIQNR+HFdA51i0uBUeytU42yFzXAzAuC4ImXEdSQ055aIYOr4CtFLZB
	3ULIuvQdW3b/sNoZEOVuLeLQp4D8Wkrm923ETQL4L5qFOMrhhw/7ITZM8DSB5qDNcBrFk3j4YGe
	jEx5Ov7qCLlJtryqGLTtGN1xZXwHLM1fQganrahM5MNTHTcO9tOCqcy/NVlo+imztDyntZVStJ6
	NEQno7wdRsvZ24FeUhVpb2I/TaTjLe3T69173WyacUlIdWwa/8LHc6wGzQpOjrAQ8Xl8/h49tz5
	2Q7TD0PDaTIEN6/O5oX4ol2g++L2aFB4vSDLQ1b5pr2itNHQLUTNVG2Uet2BJAVQfObZKYuwoc6
	Kk/N9yeJmjlXZRDufmbG6DwGDAtjR/73rduQxc88c97yGLCdBxW5HaNWCskq3TDsOdZkOyqTHP5
	zmNg==
X-Google-Smtp-Source: AGHT+IFlU1lz0wAxOd6SVfn1aivlWfEl/Ou+5sEfrekzWHqCsdYXRmCmN0O23F/dtfV/GF8aZsAtOg==
X-Received: by 2002:a05:600c:628f:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-477c01bc376mr183264015e9.4.1764490056388;
        Sun, 30 Nov 2025 00:07:36 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:36d7:677f:b37:8ba9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040a9cf4sm134950185e9.1.2025.11.30.00.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 00:07:34 -0800 (PST)
Date: Sun, 30 Nov 2025 10:07:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251130080731.ty2dlxaypxvodxiw@skbuf>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>

On Sun, Nov 30, 2025 at 02:11:05AM +0100, Andrew Lunn wrote:
> > -		gpiod_set_value_cansleep(priv->reset, 0);
> > +		int is_active_low = !!gpiod_is_active_low(priv->reset);
> > +		gpiod_set_value_cansleep(priv->reset, is_active_low);
> 
> I think you did not correctly understand what Russell said. You pass
> the logical value to gpiod_set_value(). If the GPIO has been marked as
> active LOW, the GPIO core will invert the logical values to the raw
> value. You should not be using gpiod_is_active_low().
> 
> But as i said to the previous patch, i would just leave everything as
> it is, except document the issue.
> 
> 	Andrew
> 

It was my suggestion to do it like this (but I don't understand why I'm
again not in CC).

We _know_ that the reset pin of the switch should be active low. So by
using gpiod_is_active_low(), we can determine whether the device tree is
wrong or not, and we can work with a wrong device tree too (just invert
the logical values).

