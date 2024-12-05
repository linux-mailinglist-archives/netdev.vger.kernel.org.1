Return-Path: <netdev+bounces-149494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65189E5C84
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657E8285656
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9459221475;
	Thu,  5 Dec 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgRMLaLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE3218AD3;
	Thu,  5 Dec 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418396; cv=none; b=o0HvxZjCXlxLdqvQciulbhVJTya5AcXcF6p1bxIStpqzFNGiuFIpi0s6l9rft5+UmXUBv1demYKKlAEpuICw1s93TJ3fCNMF9H2jC7D5YEcfnNjqndX05YYhds4ZSHeK/tR6hN9ju6iFYdP89L31E1FUM8hDp1kt0GzvUMsARmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418396; c=relaxed/simple;
	bh=iPT5M0klK62MYU+wd2cp4IU14x9+Ef4oWIX3kmTIAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxbHos+YzT0pgtVd+R5pbfnYp0lAY72WKWc5rvJjdJcos6n5e0yE8mM6yMmXUGQI0lgXIymMxBBc42l1/u3+g4DSuZ+KZS12ZoZaFqaU7keLonbu6klDDpMqooHUUs2TaUtwLaKugFdBgDiCmQMBBB78re5Ee7mBN59Ap3BpTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgRMLaLh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0d81eff58so177761a12.0;
        Thu, 05 Dec 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418393; x=1734023193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjMs6gUjd0BG/RW8WnCIcN/BRNzXbUwn3T+OLY++VM8=;
        b=TgRMLaLhOIh379PtsnLvA/oD4ZFISLefQn20q2Pqc+iDGd4kXGeC+f891ZXLzKNT1o
         V7/uo0iqs3qw0RrMwrsZsruwIv2zWNCcmCCJSFlVurP/0d/q0H/Djuo/zUMJK4icNY9t
         Jd5yI1nxbE8Ry9Wtc+S/1ENeYekis5KO2Zyy2lnrwjCNdcD/vV9Lkyxqgpaki/ZQTgX7
         seJ2l2HrTMikyfqryOSfFUdFNoYRt/IjQMkp0ciVAJAezTJhTD6RNswNqJ7+/XV9Dx0u
         xRkDyL1EW9LRBvLrbDjBtj8VegAab0NCKTrUO9Ku4jKqVRkKwrcHR68OzJkGvEtDnQTC
         Nxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418393; x=1734023193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjMs6gUjd0BG/RW8WnCIcN/BRNzXbUwn3T+OLY++VM8=;
        b=RSmYF7nIxQ47FVEUWwUvdts5vrQiSJ+sbTL6O+csAb6RlNQoKJJi8Ss/fcd3CYnmZY
         qxirRc3j6b+WDzuyDR7CpPqf9aeVq3pKgMFycYUG3RN2sbCpwj+S9UoKNjXReh5dPQP7
         FwIQqR/5YH6OEfd+MIeDBy0MI6H3CcUzRiJZou27ZMQUFjSOd8ZF/55XXISLVc1/aCAL
         iQKZlsb3Dyj4q1KdMxHOLygKyHwouHuwd/9YQDJ1nd/FqcwhhEvEfvjffHOI5I2r5QP8
         R9ZEAi+MjbPZ0cIV+0EUt/ILsRnZirfoVgmfq0xDEUzNdPjwBIYMr66+zij0XHThRJ9N
         44bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH1PBCOliaWow7S2vHC89V9tF/YU/KvZ4rIl07WDwLYE3NHxRhjRVjsC2OkgA87Yjqyw9bJIFTClsZ@vger.kernel.org, AJvYcCVgHccQot2CsFfTPIuSt14kctKeLZA15NyxBkQD09pIvZbvbpgi9d4lVYJjlWj2njc7UrHc7CXU@vger.kernel.org, AJvYcCVzc6jTNSOuVUVAwn3KCk9vFsV8blLfWdrYg3v0nhLB5xCeoynrDa0yAKXB0lt7wLbWIhf11Q8qYh2xQyVi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mNJNxKzKlgwCl7V4c9WVPE0JL9A5HuwLv8bf46hUuG10qexB
	yUvyDsJWKuPvGXfnAN5Jo+TNZKXqRCkyZNXbKn57QgOf3du1BsL7
X-Gm-Gg: ASbGncv3DiwDL9zegCJWTfbMfZWA7h4A7Hxr1JN11vXc3ZA2J8w2IVlBA9Vrp1O/zXy
	NMN529iW1BsHIHpSmzQtz6gpvTPDDq2bsqxbXAVic+OWKCQ1xsS4cdO2aELmQnj2ODSj/iB6CRC
	MyU4EMl+m5n8g79WV4/Sy2oWvXg48T/oqjoi94SnbEiXPV2FFxOpwnD763GSKAiTBjXl4sKjurf
	x3XtFBVpqNbTTJWgPzk+Qbc0NZGfR2GYDyjE0A=
X-Google-Smtp-Source: AGHT+IGVP0gMvyh1uwNQ7wahF1r0luVrywYn93gUAbNzVHLatXVRhr85Yq515hba/uh806NJI4WL+A==
X-Received: by 2002:a17:907:2d8b:b0:a99:f388:6f49 with SMTP id a640c23a62f3a-aa5f7ece4c5mr459441866b.9.1733418393054;
        Thu, 05 Dec 2024 09:06:33 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e972absm116213166b.70.2024.12.05.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:06:32 -0800 (PST)
Date: Thu, 5 Dec 2024 19:06:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241205170629.ww7qcvgbqdf5ipcj@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145142.29278-4-ansuelsmth@gmail.com>

On Thu, Dec 05, 2024 at 03:51:33PM +0100, Christian Marangi wrote:
> +	.port_fdb_add = an8855_port_fdb_add,
> +	.port_fdb_del = an8855_port_fdb_del,
> +	.port_fdb_dump = an8855_port_fdb_dump,
> +	.port_mdb_add = an8855_port_mdb_add,
> +	.port_mdb_del = an8855_port_mdb_del,

Please handle the "struct dsa_db" argument of these functions, so that
you can turn on ds->fdb_isolation. It is likely that instead of a single
AN8855_FID_BRIDGED, there needs to be a unique FID allocated for each
VLAN-unaware bridge in order for their FDBs to be isolated from each
other, and so that the same MAC address could live under both bridges.

