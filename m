Return-Path: <netdev+bounces-237154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF252C463F0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2383A21E9
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD822538F;
	Mon, 10 Nov 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g78AUBtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DE306B11
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774071; cv=none; b=WizO/B7YYP0JOHK4zgDay8z41bxsY/8NOT4njEfk+bJYD3H/RT+pJG+bm/y8Z3jShOKa5qyRZ0eEJbAfMwG/KrFdjv9EobgoFPkuyy96IQvgBbfuUYzL7p0yd38k5km8ww6HyQ27IEViQCzvSIuiBnDke+jaHVUU6Zv71Y7I+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774071; c=relaxed/simple;
	bh=Og6gZzTbLcFVwVJp2Xe2HjJ55+2gjOOyhbPQx84iv0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho8lpyzHDwMJEkUzn42Uv+J9krtB50zr7Z1uLDF5YpUmfRJgNfkPnQgaJKrMeknkBwYzyf1ssOh7BrlLJ3WkELZZVyEKxoKuOeaCVfjzpVSAMvSr8FgbIxwHEQcxolaOATFRDrZXzfU8r7PE7ggnKdffUtfQ5Zpqv6PoLPNU4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g78AUBtG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b30bf0feaso190018f8f.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762774066; x=1763378866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GyBD1eJ3sGWvFwDp4r+kroLdIedwCJCxMhA4JuDCDA=;
        b=g78AUBtGrDWux4v6e2FVRBqeXClasa8t8YsKIWK7eSedjXfxpx1tGwU4oAtxHDIO1l
         L03xRCLXVpGq2m6UUb16P+i7uSaruMlZ3h5PkwVyznMTQR0wECLpxjOUHjCO8Ro5lG6t
         EX7GEq3RyB8rHY0IsAdEvr6iCHDc0JRHslFxa6KdkmZF6hmn57NlwpedZ5CMaLuFBJx9
         cObIxSO0BD1vQhbJfr1ZIR9Ih/Ycg2chycOP1MkpuIrabC0gftPo1VBB4hyiQdMDTRd4
         wo9GLjVCKjfx6pVOxqfKAUragRjuxwbdEaO5uRfEMv/73dzVuqw86SGMuwNsLqTUgmxD
         qJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774066; x=1763378866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GyBD1eJ3sGWvFwDp4r+kroLdIedwCJCxMhA4JuDCDA=;
        b=VanP8LT4FPmLf4YhzbTa62MgbyYtOCjnTe4e1ro2y/2hGnf0S9ctJ3AzgZJrcMaqk9
         U4W59b0N3VXygHycYJc3dKPBONVJgBquP+riEyOoCK8iQyt5fA3JA5Gg6rRiIRPI2BoT
         wrKIk4l2TENmgSx9dTK8+KeZeaoTispJQyMFXQ/8x7i7PykMdrrZhDitZyXS8xXMzO+7
         7UPJerVnjP6UnDmZEEUdXHoS66h02xjFJtjpmGukooIeAe3Vmq2/EcATn5aHOn0Ivexl
         dZQlZxaaax+KM65/9yEwmqoV8rk+xwo5dtI+1JysDEGGYyzz8+wKSbhfpCRZMt/Okjj8
         Zong==
X-Forwarded-Encrypted: i=1; AJvYcCVaXDm+KWBTwHFtuSYJgFW3CEkI3zqxfLXi5uK0ydOGot6OsyWEnEnFaNl04EO8El2cLSJHidI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2jSBo7VfrmXo0Nm5BMfqFZCoRc8v9gkYPUPnnGkE8JPKc5Ao
	txBq4uuXuQH7pfvwt89v4v8pZbPOKq85RrFkvRrDoEN+RMBv1GsGDxJu
X-Gm-Gg: ASbGncsw7LuEGlibY7mUSdq8k9v9EMlEh05lIUrSBYaII1viH+SATUCNM0qbyiJ6Xqp
	CYZLrLdwLSzBXUuO1DbYtssHrgzx4f3UZJvwaFABplMMuOQbsBlq5Dd7qnumELPjxDSkenchh7Z
	Dfi6ktz6OirnafOzQhGOKy8Qt4oz6YhEjcUyHHVdmStd5IAuy8gzmPVpPFSUbWyTcambLiDP7xL
	3YDTgjW8fESUuu6tgzyWJU4jHKg49/XknO4EWSO6OZfQ69fQ2D3QwQQU6XDMg1fY17VFueEfWJl
	yFG2Z3s+3AwQWZs8zJmaJQfwVcgg1bbDlyEFCf9wgLcMkCE+VRx6EGLAwGKhzzx3XMAeXScF0L0
	hRRI5CvQFzcBMqltYNKB6id+/gMhsPTirYZvlTJY6EyFqA/D7nG55xdJ9BDLn+VXTkwdo
X-Google-Smtp-Source: AGHT+IGy+mEmRYt9xyAt+RSiMi3BHQQFvZBQgHHipXaKcZNDwnl0+njugiUT9oMNB9X3aCGpFD194g==
X-Received: by 2002:a05:600c:4f89:b0:477:563a:fc9c with SMTP id 5b1f17b1804b1-47773236215mr35344775e9.1.1762774065363;
        Mon, 10 Nov 2025 03:27:45 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:af04:5711:ff1d:8f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm311250765e9.10.2025.11.10.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:27:44 -0800 (PST)
Date: Mon, 10 Nov 2025 13:27:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: loop: use new helper
 fixed_phy_register_100fd to simplify the code
Message-ID: <20251110112742.bnl6dcnvv5r4dgcu@skbuf>
References: <922f1b45-1748-4dd2-87eb-9d018df44731@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922f1b45-1748-4dd2-87eb-9d018df44731@gmail.com>

On Sat, Nov 08, 2025 at 10:59:51PM +0100, Heiner Kallweit wrote:
> Use new helper fixed_phy_register_100fd to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

