Return-Path: <netdev+bounces-236069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75807C38392
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35468188B735
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201932F39AB;
	Wed,  5 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj9xuNqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA42F069E
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382581; cv=none; b=RuUfr/N/70fOlFKIu42d3BCLy459C3sMI+GrvvET2g24UuMEtf29hXn9DF8fnNtT5Ar5sOSxjtGxeM+sT26baICGLCujTmTaOoet4Xs+CtbWbMaiK3UHZHMvFwnuQGXX58VNeIJ89/66DU6PjUaFnBr8w5KC+C6Wp9sv4EMjJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382581; c=relaxed/simple;
	bh=DDJcM3o308lRznvcKXTlIS/CWI9gWk3xwBcIeYBXdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9uzXV0w8I559das7gCAW63A4EpCCIfNcrTTbJ27asK7coPdQkZNmG4ZPN0QjoBETKun+ktMSAiZKME4ucy2ycDX29Dyz1G5rRGtIMga1CB4fSYodLPfeY2aSV0NHi7XygjXzz9aPaJMl8GqJto6XFiyhfrV7wBgkuG4cBxplJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj9xuNqd; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fbed0f71aso395609d50.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382578; x=1762987378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=Rj9xuNqdQvDlG7CPylJcJWTerl4JwtQ7TF8/o/6FAkFhHTKzC304t/E46v4Rdd7/tk
         1qb6iqPby7wVdpQ7Yi7TgrdWNNMPnuKgtPIJJDlx1+MyaiBuYH7RAZUFmd8AvlIZcAN6
         DxcCLTI8c+4LZjnxXlnFd+75JShGtHtGbz01Tkmki/gpDDnXJF6A0ycYc1anhrP2unB+
         bEVM5grB6Ip/EFZTh0FgLeiR2u0u41TUtvx+aWcVjzjnaDOg6ju98Hz94sXfxn9XZhLl
         33ct00a+F1BxlVw8xjsepd5R5c6bykPdLgOkMqCE5PYvUGAiznJP0B+2BWoZy074Tkt5
         Ze9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382578; x=1762987378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=P63xhjoEXsuOy1dqAzzyDP6sbFaK/3IgXp4s42YOxQjVt1xkkjIRoc4333HzsFEW1I
         XKDIwnGZLfj3gxRYPJ2xuA2Sj+MDpmxt4NM+S089ZfNGC2lAC6JwShnEMR0gIgbxlUZ6
         7lSJX3Z5Ac3wumSL30nIHiKei8NMR9lTPw596IUXx8o9ZjZi9rsRbZRYRYsWEBdAkwIF
         WWNQEvKjUbxnFvgb9/DdyR1JsKTMa/EXdccEr+x4/Vv4vvcGiFk+00Km7WEURWZjv7oS
         ww9Z9yrg1e3jzrocpjsBCzByFA54d5cxSd3Xmck15VfrghPtWjPcc083MwNyrBEYkumK
         06Og==
X-Forwarded-Encrypted: i=1; AJvYcCV6dDEGed+fAXy5XIJwLUSpZhyJ7BsesjgL2cqYm0xMNT+1/RTawEJXwz/qJ5DBwReYbc3oXI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzkL7zbNSDTIp+eAReWPhAPR6UM8eTypexTtsLy7shzVLgWJd
	3kfvhlvJFJA18Dj6c75DNj0op7P1GJ0wYGV7Y6IdidPxPURr8gJe/aoz
X-Gm-Gg: ASbGncuoGY/5zp+50M8/H4Ritkbeuy7eObBt9qj6rpjXxSFbNpHGfXrxhQfAsUjRbmu
	7TpKDEOkU5DaYRiByi5PETqgvkJL3vQJB0X76KpiL0TybRZQM5jbNun2dBsfcs1sqBqJrW157uK
	EbY3RKZD5ZS62BXTWawVdg7tjS14ylMk/FXwzBVxpltdUvNJ7rR1ko54Byav+9fRo1GL+S0eatT
	aMUSd+l4gZqnUja/NvGgSEeXHEBBKP1V4lg75PPfeHwQLBY9SF13132ZSfY5OqU7EO/1Eufn4Qe
	MHFJeRrb4RAgWG4Y6GU75g5XhBEJd2gzs3mFs2asS7SJgYl67M9GpLtApR59pm/Ak0/QkMx9aoM
	toknlSpGOvOuc9FyPwnPCxKXrAb5+IFIBa2g0dff+6ONLahyMRqHxnZkFsLdBobku/KRsKS+8pb
	hs9nULOwNRi471dR16CVCb3XvoA6He/2vtEB52
X-Google-Smtp-Source: AGHT+IF4bH2tlcrxAWH8nMgSsZ+oa2FDYqK2kFDiy/QWN+ROxEWd8z1LH772DutB9P2i6rkfAV9wfA==
X-Received: by 2002:a05:690e:4289:20b0:63f:9a63:46e5 with SMTP id 956f58d0204a3-63fd34d6705mr3657566d50.28.1762382578383;
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b160e761sm2705947b3.57.2025.11.05.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Date: Wed, 5 Nov 2025 14:42:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQvS8GdzrfhVOhgx@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
 <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>

On Wed, Nov 05, 2025 at 03:32:18PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

[...]

> > 
> > -trap cleanup EXIT
> > -
> 
> Why avoiding the cleanup on exit?
> Should we mention this change in commit description?
> 

Makes sense to call it out. It's removed because it just isn't needed
anymore (vm_start() callers now all terminate and cleanup the pidfiles).
I'll add more context in the message.

Best,
Bobby

