Return-Path: <netdev+bounces-99037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A290D8D37A7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E18A1F248CD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFC1DDA6;
	Wed, 29 May 2024 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgrnJGUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B84C70
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989497; cv=none; b=ZGw2SRsormEP9hgycsfcUzHfBKCPMsIvGEqNm9PJZoTFzE9hjbhjo9Ma2vWCfhHqQp/UHCCtNDq5CsH3LpLJADRl/o6HKGVQ2wsPvnnGxoa/X2RR+mOGIJ7474MwtAOuhUNSkjTJ5m1pGqCs3PchLog0YafADw9qu/mKyzPysCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989497; c=relaxed/simple;
	bh=9211Pjj7b9UEt345NOh0snFXcDv4Oyddq42m+TvYzMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRq7/B2E8pY30j5x/xK+S2Fc5a/5V8qLkOfQTnYnu0PvyD6TV5o7xbxC/20GQrAyPIJOn2kkJuTgSvmVPevTFLo8k5Z59YodzdB6+b0+NU/KgngNJGuEn71NCp1ukm1V9ntevu1/wSUNOGOTXmvfc1BPSAcIFTVLounEkqpnCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgrnJGUF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4211e42e362so18284905e9.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989494; x=1717594294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8TXWaSphknRyFXlwVPSJmNAWPWCjpoZ/IQzU41JOes=;
        b=UgrnJGUFUtqEs251J8YPen76dXi720R6QShsuN7W5J2WZtaDqvQijQn8bDG6a8LRrW
         dAx/2/U73le8U8XRk8ihcgmHROkJSceuwpaUCaC7UXjS9H19pDsMiq6y4vrJLLbcVCrn
         91Juit+pLAbIkXeH2nrGDUQdYtErPjbR1TgA7oJYtD7dims5EpRahmOloGRCsCuc0LL4
         Sz3NgZDEBmPsWSeQQ+MqAz/Ns3daRUrr2IM+SiImTNIPE9lfOGJ+5vSpipopBgNYJ02b
         aYq6/uGU2XV2+So9OQh56bYFXwsjbG5vFQgeEVR1nH5KDQ/VlyyQGxryBOTrdquik86I
         PQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989494; x=1717594294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8TXWaSphknRyFXlwVPSJmNAWPWCjpoZ/IQzU41JOes=;
        b=pbIAkAXLADLeoutEdMbioXN7fwp29/7gYNasxcTxN4JlHXS4URIWdFywNApLlhPeY7
         J6t/UTjitW8vGqUmes/8Twj3g1y8rcZha/qovfbEjeuXeBOsTBGbxdBitD5CtGpEqrmI
         G4glwVSzf3OHhevZ0O98CRta1y3skZwRS93K1aixz/O3vjYKqUx65MOKng6avjSBoWrx
         QyjB1qnNDOi9skamp+oQyMSU1AQooIOBkE1G/joNWFzXoERsalmdkcMhYQJEwPPvnFJb
         Ny9/Kt82mGn6cxqVIJA7d2WIw1DdwLG+Hx+UwmKhKmwLip7zA91VmZ340HMs+1GaSFHL
         isEA==
X-Gm-Message-State: AOJu0YzuvDC1fbxEIBszv719B4Yv4PHyengL3JwXZw2+LBPnWeE+eFHK
	ebpT3U4k8Y66sZoRIgB578hDEkIeaMFaPOLtHGGJCaZj329YQdsN
X-Google-Smtp-Source: AGHT+IEiSi8Wb4gEyoqJ0GwZKpXIPGUm/w8HEr8XL7jtptq7fAagbbYrv6g4/t7o18FgY0f3ugOtvA==
X-Received: by 2002:a05:600c:3b25:b0:421:2202:1ccf with SMTP id 5b1f17b1804b1-42122021e73mr18478995e9.28.1716989493895;
        Wed, 29 May 2024 06:31:33 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eeca80sm213624315e9.2.2024.05.29.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:31:33 -0700 (PDT)
Date: Wed, 29 May 2024 16:31:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, daniel@makrotopia.org,
	dqfext@gmail.com, sean.wang@mediatek.com, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	nbd@nbd.name
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add debugfs support
Message-ID: <20240529133130.namqhprxpvhzgkzr@skbuf>
References: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>

Hi Lorenzo,

On Wed, May 29, 2024 at 12:54:37PM +0200, Lorenzo Bianconi wrote:
> Introduce debugfs support for mt7530 dsa switch.
> Add the capability to read or write device registers through debugfs:
> 
> $echo 0x7ffc > regidx
> $cat regval
> 0x75300000
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Apart from the obvious NACK on permitting user space to alter random
registers outside of the driver's control.

Have you looked at /sys/kernel/debug/regmap/? Or at ethtool --register-dump?

