Return-Path: <netdev+bounces-196970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F0DAD72E1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D1417E020
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BA185E4A;
	Thu, 12 Jun 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="G1MOtfez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323E433A8
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736907; cv=none; b=efhR1L5Len/PgOgsz9DZjaE8RV2sLJeiJ33pCD1he5H4qwGhyrMFyuuUCYHwC6j56mjo610o75Ych9nlB1lDc/8Jl2GBLMfbzEVWnK7u2ZL+I5N63NZsgdki72kC0GGWwLGPld18nHY3SYEKEYsZ7aHpxr2xwlsxNrxRZltz6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736907; c=relaxed/simple;
	bh=ZZ43kS8ldodA8ytEGpODD/ELIeuFK1PLrhz2Ds+7Vv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjJUDyw4Vd4EUJAVg7XmTRMPziGrHjZ3lnodCvHGnUO58AIQHhaEybWxHmb6qVULidVF3dcPgXCG3Eqdcm7rh1FvQIUvrnIlibUpO0/LUmxf5Ifd2Wwt/Vad3OY/9xkBXyAW3jeSt5UadA6omTLhvkCRVPf4vwtTOvDBUcMyMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=G1MOtfez; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so8097655e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749736903; x=1750341703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcnu5fvN7W4+2bj6XO77hAeu2WjhdtIOX66M3CMmvLU=;
        b=G1MOtfezASpfIf0qX8HQJCQ6GQ++sMFBGcJgtT6OflK7xN5KWPGfjIju3JGZkHbIgl
         wX6yAC21ZwNbx+x5poBr7636Ewmca1fVlBOl5dC9UPGafqDFPvT7U7myLrL01Bzdlc2k
         r5QGXmbaSdSDWqABUid8M3dP2n43MGpMBlg5CkNJJD3fbqzs/jCF8A4gOespsWUzbmTZ
         KTbBgK4RrAIG0jYptiNmw1M/YQCxn94Ncuu5qEegxDrfxttJ1jaeP6cJYS8n6ig7ROOU
         i04QJanD1EBFdD/Idh72GArj3I5IaXmHdjnhFbQWg/dbrVK416d2tlG1/LhkJC9E2cPN
         AKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736903; x=1750341703;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcnu5fvN7W4+2bj6XO77hAeu2WjhdtIOX66M3CMmvLU=;
        b=NA0IDzaV0yek02XI/aaKEllS10HUBZSWQC+7nwghay9f+i5iyNmuLdwHi4y5tOqNoE
         ws8dHMaCp+Fi3/c3OBvmh4bqmRpeRLXBYpe1B1+fPaZsQCRMtqFBXINytLAmiNXPW/xg
         UmNfxmKcJMJ/GsADHOxuEvoxUpDf+Rkahf2Mj7R+6UPn+01Zy0ErYqrWKINblTK2cKS8
         wyFxXdf34WOVyHo/x9DWy/4o9WzfqO6PM8535ulF0z6mxKLU9N+iA0EFgelPVW7IXxCr
         Nn5F7UGJAOr+Snt4VMZUR1pBJc2OFrzPvp/53E9fQ7dDDCIePdYrTntj0Td+M52Rd2ZF
         4V5A==
X-Forwarded-Encrypted: i=1; AJvYcCVyhk8gJUM81bxcDrlL8lPdj48kbAdyfIoyPpvuWZU3XS0Z5VzyPPDBjd/RbiwTekXrfEM7pCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF5fLJA16r24hR1O7HsE42KHHWbJ3lrk571r0/XmjNKT1ivwQ
	9nN0/dT7a41iBCxdr2p72rkmoQ8RMlOdaFsVGkCJ68YKWpwFJ+bO8BDYC060oJpMUB0=
X-Gm-Gg: ASbGnctXBSqrXfHVc2YH6uLzH+s0eRhOWXLRUpJo1y4wlA2Y99yIwqKhOzPL6DncaKQ
	7l2T/rE1Qk/QCihSwhiTonaNwADt+PBqI9c8RrrORNraELRudRNIS1nGh++tDkOyJv95sFQmuMa
	03x/bI0ey86te3G5kzxVIyjOZcGIIzvrWa/btXPpD+ggZzFbIWOW9TFd4ut/ig0dYKxzMEUy3hB
	3H44Wo4Ss3iAjQpYGxh/I/dMOG8/GUGxprnRx/zk232nN2DIs47KtLx49iUSIjG6Y8/m+RjTuyY
	17+hU9e2snbyMrpew9FZtZVV4N+c+drHKykOxh3Xgz1O1F9mz0ZGn8CAppIe4v0bBy1t4E4A/22
	Fag==
X-Google-Smtp-Source: AGHT+IF9vG727gdXjZJJB2mJs18JTWpDw9L1lyEsGwm5J9cJLF4nYoR1uT6I1BXoR1zcBSJ/THuMnA==
X-Received: by 2002:a05:600c:5809:b0:453:9b3:5b58 with SMTP id 5b1f17b1804b1-4532c2a48cbmr22424125e9.4.1749736902805;
        Thu, 12 Jun 2025 07:01:42 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25f207sm21571515e9.35.2025.06.12.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:01:42 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:01:39 +0300
From: Joe Damato <joe@dama.to>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 3/3] ionic: cancel delayed work earlier in remove
Message-ID: <aErdwwvIHq8L7WBM@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Shannon Nelson <shannon.nelson@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-4-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:44PM -0700, Shannon Nelson wrote:
> Cancel any entries on the delayed work queue before starting
> to tear down the lif to be sure there is no race with any
> other events.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 4c377bdc62c8..136bfa3516d0 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -409,6 +409,7 @@ static void ionic_remove(struct pci_dev *pdev)
>  	timer_shutdown_sync(&ionic->watchdog_timer);
>  
>  	if (ionic->lif) {
> +		cancel_work_sync(&ionic->lif->deferred.work);
>  		/* prevent adminq cmds if already known as down */
>  		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
>  			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);

Wanted to note that it seems this could be called twice in this path?

Once above and then a second time in ionic_lif_deinit, although
ionic_lif_deinit seems to be called from other paths (like fw down?), so
that's probably OK.

Reviewed-by: Joe Damato <joe@dama.to>

