Return-Path: <netdev+bounces-129786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737569860D4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFE1F27C93
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B610185B4A;
	Wed, 25 Sep 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD2SlGvM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11501798C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271392; cv=none; b=ajhi2T6NByhrVlmIZF6PsyccYxsT65cRljLh8c+ipQk53kq2CCzvNue4HeDx7L6nSMqe92650d+Twtb020jQNlYymHG/xq5OEqEoQPNRzlmsxGqToRkmjhWdTLz0OflSnLNODRjtjXTSQT9rRIk1eP/seKF3US9P7j5WqYGaZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271392; c=relaxed/simple;
	bh=6SwjuQFoyyTDnIBKQoc7xV4LNrWxqGEXmmkrLUg38D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG06KRchyd3AIBik3fooIogg+Sg2yA/N+PBefW9v6iyFE8ypac+gsAi3V1o2kNqnteZSWTfq9+OylicKYuyf7zhXutyKYsfKu0Jmt4Cm4zCF3vyxSX1KMChsV8mw6rj8nP6GdJKUw3a7Tsur5sDF5jVpX0V1Ml9doVXeQD6Xadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD2SlGvM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5b6069cabso767565a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271389; x=1727876189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KN4Zv/apNegyygaOv4t6KJ/pBYjtFLH00UEJLC0jcg=;
        b=PD2SlGvMOsveCj9c4OD3YLief/cN7CvzHHBXoPgfPNkQ1yA4sBV26PEWOspRyt086Y
         hhPxCTiEPHSb0UQlUDQMKnyKwnZBFSAiT+RiaiBgRZuvGVyrw+rmQhaDWA0n5bS+G9vF
         /mRZY50mqoBsePgXeMx04BqdVWo5QiY0V6s+HM7ShzXXIGjvUxF1sSzH77LABv71yl/c
         SpOAtn89WUP5yYpbWmbEy1kYOH3UL4v7C4+CP+eYNJ553oxFrotH0CYiO9PWFIEgkqDq
         WsFzkzSLXrPGzXZTByi+V3qWgvMC8sLs0tuEi+UDY3mzq1sc9GUthDQy2O2T0b4Vx5tR
         EjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271389; x=1727876189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KN4Zv/apNegyygaOv4t6KJ/pBYjtFLH00UEJLC0jcg=;
        b=ayZEsq9FJS3wWxmN3ILdYlW1vIz+V8WtBFTxX5hwQKINI+KdpQpOJh2sYUeWODyApm
         ZUWCDolokKo+qu9wzXMSA95scoqWBvmfKoGXlqPB6Cxkr8edcnTZ+C0b9OQ9eQtR+zEU
         +uERK+FN/wBw4hzSC0WA767zaOspsPlCwSsJFbblDnjryk/9AUkaPU1GrTY+OQAeatp6
         lTqgpxDKOcN5/wdd92f66fmbLuJ5o5+vOAFFBiQjDzoIKwtB4XEMvXMWn0pFOP1JuNql
         FUUGroIhTHKTDvABXgY+LORu5zlX+JGdiRyrEXXbwgCJ4wa+kMbl2QAntFSK6vjy5AdV
         o6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbqMqh6Cbmr+flUIkGXgsMUtlMbL+BIDDGnLIbw2UmOhOPdJ1ERwPsD+PyRahPTlYa1UOCzF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQejqk2lHZfZbVVpiGHKdcKzaAO5ROV/1pqcf0ZOQzhf/r+cl
	EgsDH5pUWCJWqTj/wv2M2zTwvCzAcueG9FuHVlNHTecACtJhhKoF
X-Google-Smtp-Source: AGHT+IGLZfbsBMGsUvkUzwwgYsHqnh+inLH39us1h6cw9TzK12tm2k4aAYtNfaclJ6ZMDoLFrAGcyQ==
X-Received: by 2002:a05:6402:3588:b0:5c7:1ea4:1680 with SMTP id 4fb4d7f45d1cf-5c720608dddmr942483a12.1.1727271388900;
        Wed, 25 Sep 2024 06:36:28 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf497167sm1866456a12.34.2024.09.25.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:36:28 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:36:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 09/10] net: pcs: xpcs: drop interface
 argument from xpcs_create*()
Message-ID: <20240925133625.4ahkfbqekfqjddhs@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjdE-005NsR-OU@rmk-PC.armlinux.org.uk>
 <E1ssjdE-005NsR-OU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjdE-005NsR-OU@rmk-PC.armlinux.org.uk>
 <E1ssjdE-005NsR-OU@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:40PM +0100, Russell King (Oracle) wrote:
> The XPCS sub-driver no longer uses the "interface" argument to the
> xpcs_create_mdiodev() and xpcs_create_fwnode() functions. Remove
> this now unnecessary argument, updating the stmmac driver
> appropriately.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

