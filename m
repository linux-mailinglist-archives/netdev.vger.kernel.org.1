Return-Path: <netdev+bounces-132421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D74A991998
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977211C210F9
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B315CD60;
	Sat,  5 Oct 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/fS8a/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C615B99D;
	Sat,  5 Oct 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153779; cv=none; b=EUqYq5TJpCBxAWa0OfX95OXt0oan0He9qOKGfQ6K1XYIu31eY7fdaCOSWbyXcq+i57oaQUON9ndj123WF3o9odaEohznVIJq7ouPtq61SJtkd3abwIpvEvhyrqnebMMn9iiDYpzjgYs2sR325yVzq6rFaOs+uxDrT7qLmCtf4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153779; c=relaxed/simple;
	bh=RAyn+r5qGEII9ktFFEBImG/16L/65jXQKEIe7y2IPWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNempv+gfby9RQiVwx7WymfIiLnXAqsoogrqXUivVALp7p0HYja8WH2yY7X8/FqTJjDkSgX1d1Bivz6RrKdZXPlTESvnVNj0eMMcWgDsN8FBjeq6m28WhEZlDwP4nVI48Gk9vLrCV5QPkI0zAIWZc41dLbeBpPut5r1HcMH8yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/fS8a/D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-208cf673b8dso33985205ad.3;
        Sat, 05 Oct 2024 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728153778; x=1728758578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y25ZVefJdiSVkO3qfrmbNFhrm8ep0qVwTaRuxjJFhxA=;
        b=Z/fS8a/DazYRFiMKYfDZt55cKcf83Lc4L2J948Qzcy9fGUpFL+V2gsIY4o2uW9YXtR
         GLI+mX0O/eJS5gQEEZ0c4bpI2NR30N1v2pZAE/7eU+6QVVpUW7x+X12cTPxi141EsEQp
         iUywQLUSuquaRCtp7U/GkYoaiwxnIZEZhpx5c4lsOZszK0HGTsfrkFz3yvhsuHtbDI/s
         6K8CxvonXLGxWjGWMpsZgTUgbvB4lvDg12wMAJHBXls/PFMmbB3BzMvlQUiCsbs9+4Qm
         o4QbULKstk1hKlb79CmueHx04/OI07VXlFou18Rxi+A6/L48U3gAXeerZECsAP6F0WQU
         YkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728153778; x=1728758578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y25ZVefJdiSVkO3qfrmbNFhrm8ep0qVwTaRuxjJFhxA=;
        b=Pxh2FVwGE2Hta0El2pSWUAuNHvrRBZSrgKhGHzyonL/a5nnaL5K+2C/+oiFt73hIcR
         7mHCBhTiQwcS9KEYElwjeQ31tIVfcLmRlh1d8e6QzAq5dkIk9+2GuoWcAbjgPNspBnRy
         KTW/+xVpibVaikVZeKTtjdC84djxmDMb9hMXkWkrwGAO/g1R5HS9Qo3oZJjvmup/3Fgh
         22ANzD2YnhbTDrLuVnMpXcybzTuvaa6Z+H0Spw3OY4TAcCmhjhF0psLKbd5Ii27HslXM
         L1IZWNMoxtEXB+Ypdctz0r6A4Ldeq48/3jx3yXTOOYnE37wgw6beiZ+n0cW89nFiV8Ne
         b7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUrzSr6fvObiDegXkY2k0v/rSe+RNw16Ab0og9h/E2q2wBKD/+6rV/geCg6pRhWkUlEF76iV+l3@vger.kernel.org, AJvYcCVsZ9deAJImbd/3e1B6ZXAJk55q2dlCwzFnCadeatExIiXzbqHkChlPKBfv/asRditK+UYpDRoPcTuzAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQqI8iTEhCH1Lig9bRWeJCByYAf0Jdd+6nF+f/nCmuJ6gxNrD
	G7qHBp+pVETeGRx1GmvsM3qERQDK37S2O4H0OQhP7NHCh+Jmbn9p
X-Google-Smtp-Source: AGHT+IHhcll+kcFkGYE8ksAy5ZwFeEUVbMcRx09zIOpDDE8C9+yQ2hbOEJauPJE3AGk5Xle9Pvmqvw==
X-Received: by 2002:a17:902:e841:b0:205:8a1a:53df with SMTP id d9443c01a7336-20bfdfd4978mr120958685ad.20.1728153777545;
        Sat, 05 Oct 2024 11:42:57 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138d0f3csm16025155ad.116.2024.10.05.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 11:42:57 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Sun,  6 Oct 2024 00:12:33 +0530
Message-ID: <20241005184235.22421-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <8555d3b6-8154-4a79-9828-352641ca0a58@lunn.ch>
References: <8555d3b6-8154-4a79-9828-352641ca0a58@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the original code, we initialize ret = -EOPNOTSUPP and then call 
phylink_ethtool_set_wol(). If DSA supports WOL, we call set_wol(). 
However, we aren’t checking if phylink_ethtool_set_wol() succeeds, 
so I assumed both functions should be called, and if either fails,
we return -EOPNOTSUPP.


static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
{
	struct dsa_port *dp = dsa_user_to_port(dev);
	struct dsa_switch *ds = dp->ds;
	int ret = -EOPNOTSUPP;

	phylink_ethtool_set_wol(dp->pl, w);

	if (ds->ops->set_wol)
		ret = ds->ops->set_wol(ds, dp->index, w);

	return ret;
}

From your response, it seems either of the two function can handle setting 
WOL, if so shouldn't we check the return value of phylink_ethtool_set_wol() 
to ensure it succeeds?

Thanks!

