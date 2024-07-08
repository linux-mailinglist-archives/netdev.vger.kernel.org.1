Return-Path: <netdev+bounces-109881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BA992A26D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEAE2810DB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732A7EEFD;
	Mon,  8 Jul 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYM6ElBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50611712;
	Mon,  8 Jul 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440839; cv=none; b=g2bmmQIy9mDaN592qzGpOqAfl/b3N8P8rby4ohvdpqGvhIvmczMUjiLjKPiOMt5PbXI6uVuj8gUxeFBYR8HSkqQvLP40PO54ldTOoiVvyBuJIKPZfMHrY/CdWfvn53HB7laOEQDi4DOFjpWAD2Z5dNC+P0XeEiDCur3YFXLQfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440839; c=relaxed/simple;
	bh=VIxaSTJMP4e83SuwPanq+HI++XObKHsfmXv0NSHYuak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOezLPetDYrrzKr9Z92wa1B0JtzDOQL3rka7t1+ZTYM2StTJGs2uIW8spLlbXrFp942l3yJUSZMrRPHW97vnwXti/GlTFXRIWd1rGEqIRqQVIfQAfM0uW1yvNomw2G2itxR3wEbxEw4uFRHnfk0jvKYWSBIuWG6l5P+OWjn+xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYM6ElBb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so16629695e9.2;
        Mon, 08 Jul 2024 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720440836; x=1721045636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeeftVXSInefzAV8X4+3PNovL2BBN2pSERX3ct9/JzM=;
        b=MYM6ElBbpldImEVXZgfNzUNjWP2NP4dfy7bex08y7BEJhuBZrJ+/4Iint+l4a/c8Gq
         Wjw/1wdraUdHvDJLuaziMT3sox956ZqKyDb3Ahyn+VwV5qKamiJSv5PH4zZsGx+t/ABL
         qQXH+8WhqfzpqG4XANr76AmMs1hZnmUiPkoIXS3Ueaq7h/a5nYXHqZmL1U25HX6qUc4k
         afO2U57zsQLsghAmqLCpF5j4MKjxxUiVIH/S6aFudbZji4Ko03o/ADe5iyLG/NpoPjEY
         W2ONxyb23GLDZsDmmQhOQLb0xt1M2dwVKraRCFsij1dHggtD16smoDaX+zxt7fv8V6tk
         Ii0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440836; x=1721045636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeeftVXSInefzAV8X4+3PNovL2BBN2pSERX3ct9/JzM=;
        b=GM0uMTkn1FsfIdnGofzmGpsSMXC8UjFipWCSgPReZaKb0DuVv/hBx0mUQ0pnVjl8Ah
         gW/F5531wyVPkzNmr5jSCUXOCoQUGNkjNeHW+8xW8r4bOB7dFg/3aBShnegjgo53Canm
         Pvd4mbnxW/K+Y0tdSgKrRwdPKOm6rk3UuNlChNVGVT8sbjQ+ccwdXTLHRJ9YOremlObD
         1bW2EwqqPGV6uS8CFf0btbeMnajgGdp8khP6BKmX4gQEiShfDI6psemqx0c2iYF7h5Xk
         xx/dfS1HY5h/slY3byYbeOORrTlToJdIzbozUdiKZbAVRHSCXoccdNfHWCC8P9D/FOGy
         njJg==
X-Forwarded-Encrypted: i=1; AJvYcCV09pZktzKnr/qPQMGi/T3v7Uybfv5eL+kd/Vr0FiiqN6vt5hK3ATZcIa/4dedeeEu0uwBu/lMQBXyPGFxtW0PKDn1+DpzlycAO3jKxgbfTuCE/GfrYRxOej2AFJbvwnMY6crPN
X-Gm-Message-State: AOJu0YwAolfscrzidqM62kpe3h/qCdUvQ5hop0zTwNVVH3c9d67YaFog
	34wEjYvBVPuFP/vHFk1oFP/WdZgn+Xug2wfMpMwOEZdZ1mcokqt0
X-Google-Smtp-Source: AGHT+IEPUB/CE/7/FTo9q3R9Q6EzwdPWS0D+NTCJD5ZMdzk4Th99z0AuoS1Pisg/BbLh/WUr+c69Kg==
X-Received: by 2002:a05:600c:2253:b0:426:5b3e:daa6 with SMTP id 5b1f17b1804b1-4265b3edee4mr51235845e9.35.1720440835759;
        Mon, 08 Jul 2024 05:13:55 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266303ded9sm70801745e9.34.2024.07.08.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:13:55 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:13:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Juergen Beisert <jbe@pengutronix.de>, Stefan Roese <sr@denx.de>,
	Juergen Borleis <kernel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address
 parameter
Message-ID: <20240708121352.gnhhjuvvoxpjhtpv@skbuf>
References: <20240703145718.19951-1-ceggers@arri.de>
 <20240703145718.19951-2-ceggers@arri.de>
 <20240704192034.23304ee8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704192034.23304ee8@kernel.org>

On Thu, Jul 04, 2024 at 07:20:34PM -0700, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 16:57:18 +0200 Christian Eggers wrote:
> > Name it 'addr' instead of 'port' or 'phy'.
> 
> Unfortunately the fix has narrowly missed today's PR.
> Please resend this for net-next in a week+.

How does this work? You're no longer taking 'net' patches through the
'net' tree in the last week before the net-next pull request?

