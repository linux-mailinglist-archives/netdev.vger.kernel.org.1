Return-Path: <netdev+bounces-131909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0CF98FEC7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD690B20941
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0C139D0B;
	Fri,  4 Oct 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J29d8zJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E206F305
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029778; cv=none; b=uccGN/El8QKlJAnHZAj2l2ISo4aqLm8PxQ+1Y4CgDcALfG8iDlDkEpx+looJc7wKT67bQHHmkTI3MJZnBdOHKNYzPSTUDP63jfhVDcQxx/4purTkF96pziY1Mnn4O0UaaNCp0NBpwbAzusotnHORCGyH9paxM6CR2ayy1GczwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029778; c=relaxed/simple;
	bh=lHjnSWzaRfgkH900nNJtk1lHyixZS+yJNy2GDIJfaiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WahQSWy+6HbMQ3wd8mOrULu2IeYH9r5i1Wm7qlZ9zp93++Y7bDPwrSWAdwxS9SZ1jupiIatSKK1IyOHC3NrLGT7l1SKyIHuqX97mYIaXhwFbENBFl2mwgOK+b1RijnkDiFW/geK98ISfCKWN2mXd5V3r61j3jGT02ykNeyAcq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J29d8zJ8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a858ab5a5so30585166b.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029775; x=1728634575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cj1CPc48LloNjk4E3aA3gH4l/rnv0bfAwXpSqlwVd4=;
        b=J29d8zJ8bkmROVVbTvAq6qxe1S3TfN6M0kubIM3tMIjK68R1czunl6WczAYt6tVzaI
         7Vf+TaMugKhtOxYUrdCuSJDXmH/c0eHU0wHUK+yipdTSJvpr1TLG7XY70f69a+5XN5Us
         n6NmHLaj7q+FApKJIGosiIXNY4ffYVthDtUSmz+FfklFNpYsy13M+hidkW3ABFAA+6z6
         2PGXdzEguJ0zRWAzK+/cdIep1hXCetT/OwLSuEQGWLDTfh2T8xMY28fETsdybQFw8SPw
         whV4l5tD/RDhuiPAC+1epEzOpXThWk3ttrlEcUfEIiDDEOB6PwBn1XbDCE0QUDFsTb4s
         lXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029775; x=1728634575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cj1CPc48LloNjk4E3aA3gH4l/rnv0bfAwXpSqlwVd4=;
        b=Ahod0R4UYro2+V2lFQinZ2qBY0KEeeXDfgj5t+2MgrQ8hxigaDDcGpLf8yizfZOhbW
         Qb8QClGARnszC9zrBIsCPo4a5ZBIgQHSUqLiLkVt4RDDxtxHaJNcWdlN2qKXpFg1VcTx
         gHIu8O6PD90ODaJdYUN9Rgy5ITk23W5ODQFSdzzEfZ7RhRH1f8EgEB3+vLx2A45hRf0l
         4EhoaEYvmoo2kI2Thg7u6LRLZZpvNrQe8FgKtlgXwPew5qyISCsE4k8E7HymetC3jV7W
         V1cYycn2bctAOkvxB6uLoG1eu+nphzlSNjD7tuIKoIl1YtDbOVp7PRtvXfRvaUIdeMpd
         n2fw==
X-Forwarded-Encrypted: i=1; AJvYcCUoQ/V4O5G4Bf3omb0B6RnNUERF9trH9RaCGLRiNFgZR5dOQi0usFvRjFR5klKnkG33+X1bD/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUeM7a34v2niMWFB4438bDb7VgCNU/RGTWrbIrmL1sJO2gW0n
	7rnh59xflvlkVvxoKuUJFI87vzvbWzFczdeukaAisJqbAIdeXn1YIQ9ZeoLh
X-Google-Smtp-Source: AGHT+IFIlCbnaewuHCE5rKKhw0NEznEelYnkzsumllJfhmmlebbRTb9MKBsh1SxiPqYh0SXDePS+pA==
X-Received: by 2002:a17:907:3e29:b0:a80:a3a8:9867 with SMTP id a640c23a62f3a-a991bdb8875mr86851266b.9.1728029775174;
        Fri, 04 Oct 2024 01:16:15 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b3115sm191255166b.136.2024.10.04.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:16:14 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:16:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "agust@denx.de" <agust@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Message-ID: <20241004081612.unhoxirrx4r756ye@skbuf>
References: <20241002171230.1502325-1-alexander.sverdlin@siemens.com>
 <20241003211524.ugrkjjc7legax2ak@skbuf>
 <b4e0dba3867bc16f6c0a26f2767e559d5a4156fe.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e0dba3867bc16f6c0a26f2767e559d5a4156fe.camel@siemens.com>

On Fri, Oct 04, 2024 at 07:26:21AM +0000, Sverdlin, Alexander wrote:
> Thanks for the review Vladimir!
> 
> On Fri, 2024-10-04 at 00:15 +0300, Vladimir Oltean wrote:
> > > +	 * switch's reading of EEPROM right after reset and this behaviour is
> > > +	 * not configurable. While lan9303_read() already has quite long retry
> > > +	 * timeout, seems not all cases are being detected as arbitration error.
> > 
> > These arbitration errors happen only after reset? So in theory, after
> > this patch, we could remove the for() loop from lan9303_read()?
> 
> This is a good point! Shall I add the removal to a series for net or post the
> removal separately for net-next?

That would be net-next material, as long as they don't intersect functionally.
What you could do is confirm that this is the case indeed, and that
nothing needs to change in the read_poll_timeout() logic even with the
simplified lan9303_read().

If true, lan9303_read() will always return 0 at the first iteration
after this patch, and after the read_poll_timeout() breaks through.

