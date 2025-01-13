Return-Path: <netdev+bounces-157860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82731A0C196
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CF53AA758
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BE1CD1EA;
	Mon, 13 Jan 2025 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k7V16SuR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA611CACF3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796884; cv=none; b=QN7875bL1XrPHN8R/A2t4dmaJAneYizlsvOVNqrqYMHl7WrCQqEaulrT81VsO4WGGPhoNWeKUuocxff2LOhGt9JhNh7xaP+CzC5sAVDsYGtlVl3lRWAr+EWKxOc51hEjJ+TXf8usfwNnZ0+jaReXfjo3BE/YSTARs48CsEOfX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796884; c=relaxed/simple;
	bh=ji/m323FosdWhwRibPOoRy9v0NxVrPeppjXkoLto+dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXBHIw7IAAXwg7nEKkd33YNi4QDqLX+GTbsr//wyj7uEy7ZqCjLoiyYrXxjvK3dw7thfRe7jJnXZF+ozaH1Zoisjk/CturGqjWcfajXBrw9vQXXIZ5Xx5i4Daps3P7CC2qLoXUeXKQv6J84kvdND8B1eCrg1RS4oMilIB+Arm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k7V16SuR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso98035585ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736796882; x=1737401682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyPdsFxrIY2iYi7DBvszchKHPMKhyGkUldztRl/qGUk=;
        b=k7V16SuRhV946ehEGnqwHWy4FZyCxd9Z4+2tfXA67brGuqDHVgmGcf9fURlj1jyBOL
         eX9DkRUCDLI8+aaOL19RyvqcEcbLgTXZQecUvwnw2fYGCa0pwAwZHGsRpbQJ5Bv6xVVI
         yUiXfEdQb5prMl312QuUTi4Ve9JcPjY3kDLf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796882; x=1737401682;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyPdsFxrIY2iYi7DBvszchKHPMKhyGkUldztRl/qGUk=;
        b=kYfCUQkmRL4hYSnILo9PweawmAgdZ83z5hdvlXQhc/yDCMzZVVSDcKjKDiIV7SfPh6
         NaSwaaAbyD9prSKaU8Zwz4mgtDkitK6zFePMYMsPd+fHe0gi5V984455wsyHY6Mju9Q/
         rXN3pt/kmnqMfhMSB7M5oZQCr/uYOqYGL8fSbHrDL5B0fkKy4osQp4sDZyfz7wsY+K83
         uqdgWBbnEntElRRXuC/AGj7j8A53MNO3pXIC9n5+UykVaVEcxS9XiygcG1TDrhYnC8fq
         BC+6JkQi/GQjWViXsKFt/Ena7ZmQc6IFu40s5BJ8v0JvyifYN7TWKaPKW3sIYW0itZLs
         4pVA==
X-Forwarded-Encrypted: i=1; AJvYcCUdvv+fN1opigIGPbXhEP2jXNMVHgDGTbTzx14VyMGhsSWH2BhYZ2Vj9GHCBBns/cMPwEdPRL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9UN25MV4C4Mw/5IEembSavSy1gcGs+xqq+clFlLmBRqwBI5z
	WpLY4+1bChDIeI7A37PQuklfnS7O7h2TPxAwHFT9+tEqFWUlG1w2G2xjcDl4+Ro=
X-Gm-Gg: ASbGncszGZUzzMbspPuJdE7xoTW0XtJILyffD8F2NBmeNwC88B4VJ9+jmpuqALRq0/C
	3VCW/GAlldiy0WZ52n+fgee0qUc4kF2jdyks+Kgmo/2TNyo2D180rpuCSEHcMv0vN94XbPljK3M
	Uw21HEysKtVsNmt2fWG7ardsmmK2AVo7PwY1rxue8vvKaeDkVQcXvzvaPaujtXymLUFrPWDeWc6
	WPUKOHDQioqyReTV5kl1jaaRhmhBJLgWCXoOE4U2L5+bRrzEVfQoEmfpum9HNrUtjFrNgkUQHUp
	/yW0Ys1mj/CspwVzw5qkZnk=
X-Google-Smtp-Source: AGHT+IH+rwBTw2ayoxIiq6JhS+CD5OaeAUjlr1THkwiE1KD+FRRARZfF2CaLejcXZr32SyeTRIjDkA==
X-Received: by 2002:a05:6a00:1152:b0:725:f282:1f04 with SMTP id d2e1a72fcca58-72d21fcf2d9mr31580485b3a.18.1736796882215;
        Mon, 13 Jan 2025 11:34:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065a560sm6215778b3a.87.2025.01.13.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:34:41 -0800 (PST)
Date: Mon, 13 Jan 2025 11:34:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] socket: Remove unused kernel_sendmsg_locked
Message-ID: <Z4Vqz7x2RPHeuqMz@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, linux@treblig.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250112131318.63753-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112131318.63753-1-linux@treblig.org>

On Sun, Jan 12, 2025 at 01:13:18PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of kernel_sendmsg_locked() was removed in 2023 by
> commit dc97391e6610 ("sock: Remove ->sendpage*() in favour of
> sendmsg(MSG_SPLICE_PAGES)")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/linux/net.h |  2 --
>  net/socket.c        | 28 ----------------------------
>  2 files changed, 30 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

