Return-Path: <netdev+bounces-160911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B70A1C2A8
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D853418879A3
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A21DC9A8;
	Sat, 25 Jan 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuSFNdR8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A161CAA6A;
	Sat, 25 Jan 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800049; cv=none; b=XMELcnFtjNa+OvloXVElbbSNxNnKlPI/DVkLDJjZYVVGzcKo/9u3cu8WkNCxjolhY289fEb+VUWny3idActNnDSSAJSojFHTYzU+jW8Mw7d+QrgLa20Z9N7V4BxI9xVT7cmw+n/a9LxD54Vl3TYEEEhcNAR/j5UJ+6qaXxChCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800049; c=relaxed/simple;
	bh=dSCs6N2eFmFPO/thoSrFIuAPi1viLppNg2EpOPQ55eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncxpUrGLZ2BQoCw/MTPmcAAR3d0mhkU8yRWbaMZ8eHn6/yyffCTHhDNedNW7S9wQDO5fjOdI5qi9+mfPq681kxeYC48V5OzqyqpplcEvPGdEQg6LwBLta8BALQervlct0vvQh2FaGCR6ht7xJFzx+FXg38V2JezSs2512cp+A/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuSFNdR8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so18518505e9.1;
        Sat, 25 Jan 2025 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800046; x=1738404846; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwzHNxC5cNxCmCVA6PXpzf0Pi4M1KVjZgUBjgFvwL/Y=;
        b=kuSFNdR8kL60RkIoiC1GfPqDAYhhsD40dBLBqlR799QiW1g+zrfwczB4uhUR6ZCiYt
         2JT0bzL+lhxSem7wWULsMfcpoYnBYxmwviy3QiyuSQYRvM94SFfzJBlRw2dsIvXnj9mD
         DE9gBbsxklhlcTSYZ+Ur1zTsLpgxNmkBDxHzjtvUblX9PAxnCP6TM5aa6aWCAtr47TjP
         dSa2CBSJsO3pruVWFDC3wyLIvEaSXwqb9bJkwOXOKm9V55xvoukVmloyeHXTHbGVbBrW
         4xjH54HBb8+9aaTauTODEgeH4V+/4FduJo+ubf5sr2ZodKc6H6Mdfmqiw3PBhXOSq1h4
         CsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800046; x=1738404846;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwzHNxC5cNxCmCVA6PXpzf0Pi4M1KVjZgUBjgFvwL/Y=;
        b=h67zY9l50qD8ZXTq2e11fGWT77mkOr1n36CEKk7ZVrmRkdoW18zqEzUxbuuF1vfhug
         smFlfBbPv/eb0oqg5ZISY3kbkUmvIFP3hRWeIi8JcLfNcnFWZV82+ASKaiL+2lz//15Q
         E33LRYXHRB2rt+vbxrJ+KUlvWCDimbbC9OLYwZ8YnZRwYLltyyJa4zKj+Rvx9QI5ObWO
         SIe3ilMnxXjrS6Tu/RawCgtOWZqQ5zIDIf9Ql49rR+Z6LXcZNyJCpyZWK6ceIHBRFimk
         MU0+jLLT1kiDMyRyUQZi2Vt7k9c0wQ8yZ9AD6jbiIajMIuTBmigSdRNqXpbK3K8/8O2t
         DngQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1qJsWdayByFaTxlyaBGx4UQDU446YheJmuCjNGcRsOOU4CSeHPrLwYVTkloHLf4dcChNTWvLttmoWiUE=@vger.kernel.org, AJvYcCX4wuRjTSIXtJNxq6WNzakOeRquUt3pdpjGPcyeGZJ6x4UaXq6btICFLTuHfW6ir4hosKj74U6c@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIA9JtitNr37y5Y5SP29+LsBgDPTOoLbQ1z4Gi0Q1wGg5Zyrk
	QwEg+yk23bPfaYnq+7MEI94xSkqspwlLGKiHnGSG2UyQlj/Ly61c
X-Gm-Gg: ASbGnctBSmleEY+x/wHAjxhJ1ri9yKGTKoYJlh/0hCnWTWSy4A26FfSBI0lDqawOXzM
	N7HLCHVsLQU1RIt4E0Ic+PYRlzbfAohG9GF7W2jHQejmAv9OasSV4JFahf2ToewUeMs9ajNGenP
	4c+IYgPCYnzBc/9IZy4a5HkTd4q5R/bL5gEJHOZnGvW9x+lshqAo7kErv51cqMbxGOwdIsroSLQ
	IIIF/PuXjpeIKpv0A9BAB8P0AHj2fsNGor4umNuPH3jYdPH82uUvxNM3JX0OgexIdSgol0eWTkm
	e/nSR5U=
X-Google-Smtp-Source: AGHT+IFRDxceDHQjbwr+B4yDhJjvPnjr9EJ/WcGOcr4g/Jp40IqaG/WpblP7rxnGycp9v2ElXv3twA==
X-Received: by 2002:a05:600c:4693:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-438913bed10mr306385445e9.2.1737800045849;
        Sat, 25 Jan 2025 02:14:05 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507dc9sm56541085e9.19.2025.01.25.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:14:05 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 566C45A002E; Sat, 25 Jan 2025 13:14:04 +0300 (MSK)
Date: Sat, 25 Jan 2025 13:14:04 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>,
	John Stultz <john.stultz@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ptp: Properly handle compat ioctls
Message-ID: <Z5S5bCkBExVuuZVc@grain>
References: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Sat, Jan 25, 2025 at 10:28:38AM +0100, Thomas Weiﬂschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> Detect compat mode at runtime and call compat_ptr() for those commands
> which do take pointer arguments.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.fastmail.com/
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Looks OK for me, thanks Thomas!
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

