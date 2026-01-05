Return-Path: <netdev+bounces-247075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B925ECF42A8
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E52DC300D902
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69349346ADD;
	Mon,  5 Jan 2026 14:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D3346AC9
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622291; cv=none; b=kHxUcNjPtZ8c5BaT4oUPgGwmFUf4M9zzi7jQ1cscjUVDni8QOLKaaV3ne7sH2TAsPTjihWGrbRqKFNKZsS4AUHuc4uorEqpzjbO3hUMxXtig+uZc7xPIl4owV5BKSmUI0KeV0jBSHiwYp/KZsZ07Y129fYaBNRFCzWeIjpeVz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622291; c=relaxed/simple;
	bh=HN2CkVPM1eN6Kh9bWCQdL1MiYXNKTJ3dLqrwp7UfePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMvF0cUIp/7TtLjDVbIbWBmq6Iv/cKb/ocPFEMAaFMCw7BY4CnvysyoUlST/eLHxHo/KQIZNB4ppWeZ6zHlg0qKc7TPh5Og8Mzhq/tKkKKO8wzeCRDnKFJ7JHgLgPqb+NqQC2K0TAu5F1+MCaYMu6reBQCzjLtwsbW5DuqLxtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c7660192b0so9653115a34.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 06:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622288; x=1768227088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN2CkVPM1eN6Kh9bWCQdL1MiYXNKTJ3dLqrwp7UfePw=;
        b=nqAfijIdtuqwu8zWluFByNOY/bfuOJVwe6JyuM8FkUmKziw1poHl2fMSLLEdFjvt/0
         gK5vGH7q2uTR662LuqNpf3IVT9U2JAReaN44+qd/6ogfC0XKwI2MvDQroRexnRqHUu9O
         WzHIz/4ttshr7BEbjGn1a0UZ3r8gaCnAvLwFOB70eIC4vs/tuJ3wONXh+P8i2J2mDwut
         o9yclHJwu+E03VCfN3IJ53XNscYWMl4UkbXvNlBgcJlgQ0w7rW21kY8L44BqAUuA0wF6
         OMW+lal3hOdN1zuZZ9JcRc2FHJ68R0/hDGQTynNfvcu+DXc6o4/769J8+aZqtwWBrqqa
         /ewA==
X-Forwarded-Encrypted: i=1; AJvYcCVUf7dirMQoCO9qSAS0IeQz27qqRTcO0YuWG6JzDA9njRBMjgbTkf5mogzKzyL7WLmSfOAD79E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EbmVfqVpnKq7DTFWyDZWM5FjkNntCGAw9sROcvOG9h6dJUCi
	f7NqP5/ac6WXrCiOaffnCdE3FO1+NM5VTQ9g0zdN384pp/obOEzt7Rsz
X-Gm-Gg: AY/fxX4vdVvFh/L2Rs1FYc8HMxBliHFaO0iTUIY85JHQKNvsvsQlLVlo+gDL2TL8eLE
	42skO0byRVPiFWW3d6P4zsE/Z5UFvHU11Gv1qp+2OYv8j2KvUb+0bR61sezROkEQKOT4q1z6iOp
	bgfvSNUAXZOx38kAZKdq13tV5OHr1C3n9UlUgdeRySm2HI+vsLPGCJiqDe+BYEsQW0Umt5dP13U
	RzsJ5ansI0ZjvyqD9eLgM9W1LZFBIWZgIACuKeDhbtpcxV3BGUhXfNx2UA3pzl1iqTCZZzybFVf
	4/Zo5tB2fEGtDbx9NiM1Vo/NAu1hlOW5BYbnTc9z1V7SxgSXQWdQjvEa2veG0zWsypoxK9Z5Pwp
	ApIIXsELZz4gW874/+bbavlXCSLnVYEQXKM+wCDTxdd93Wi4hDf194zE66w0Orn+GaKib1oniKp
	2qRwh8PdaN6MzDcr+aIq9WP0g=
X-Google-Smtp-Source: AGHT+IFag+cDv1EyiaP4MYi1ZbK/LSZq6/9BQnh0bUb96hv7LJ+5A+T859z2mvDQYonPQSgWuytAgw==
X-Received: by 2002:a05:6830:34a8:b0:7c7:6063:8e02 with SMTP id 46e09a7af769-7cc668a4ba5mr27471112a34.6.1767622288604;
        Mon, 05 Jan 2026 06:11:28 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ec367sm33167544a34.23.2026.01.05.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:11:28 -0800 (PST)
Date: Mon, 5 Jan 2026 06:11:26 -0800
From: Breno Leitao <leitao@debian.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <ft63jjhpr2w5s6cdpriixbmmxft5phkvui25pdy46vexpawzz6@mu6gblhm7ofv>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>

Hello Russell,

On Mon, Jan 05, 2026 at 01:29:40PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 05, 2026 at 04:00:16AM -0800, Breno Leitao wrote:
> My guess is that this has something to do with firmware, and maybe
> upgrading it at runtime - so if the firmware gets upgraded to a
> version that doesn't support PTP, the driver removes PTP. However,
> can PTP be used while firmware is being upgraded, and what happens
> if, e.g. bnxt_ptp_enable() were called mid-upgrade? Would that be
> safe?

This crash happened at boot time, when the kernel was having another
at DMA path, which was triggering this bug. There was no firmare upgrade
at all. Just rebooting the machine with 6.19 was crashing everytime due
to the early failure to initialize the driver.


--breno

