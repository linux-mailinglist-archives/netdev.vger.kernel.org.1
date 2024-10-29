Return-Path: <netdev+bounces-139791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E711F9B4198
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 05:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF061F231B1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EF1FCF49;
	Tue, 29 Oct 2024 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MK2zBclK"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE18858E
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176608; cv=none; b=a857tm3YrJ+4JfP8o9mNOL5Id1H4wtY5ypz6y5hNhi1vi2S5Q/VxKXemN/HKLrxf/3xcSBi30LVqQV4eAZqEugvmd829lo8K584m+kfKSgEW88r463Q1Hkj59bQaXtmiEWlDaSB8OlFkbMMwdpEv6ctGFQAlxSW/tx7liucG41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176608; c=relaxed/simple;
	bh=qSihGCHrEqLZx51iKlXNx7U4vgHGsEcWH3vlQqz1tk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mo7QwNU/+luwMkeZlCaZmrDqUlQGR3isIA9v5gLJuLTe57Uh9DuZjPXd1pkx3BSKi+w3jRSd0EEGPezOyLVeYsV3r+6VtjlDT6EtfRxRtJQUlz7eU5A2cJQ6KfzlkLQ7paA9FKqq7ZkFeILEGtdMVOrQfqSJoW2SIUk0mbZN1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MK2zBclK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730176604;
	bh=qSihGCHrEqLZx51iKlXNx7U4vgHGsEcWH3vlQqz1tk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MK2zBclK0VrqzsfkGPD5jAQY9aDcOH5LvmUe+eZv7cEG2R6EMAqNl043Zw2Xb9OeR
	 MsKw42eKF6PDGv9cO97cob5bEG+R30t47jaIWC8QxavopamEI3tGfPs16E4VylqQEK
	 uiuNrfCopYls7Ju7hkVSksVsnxAF4FgXO1uDWx8rEI/k/0EEICFIAp9m99x+tNnnNa
	 yvh10UVlJGaxrZ1/hnqUvqSTUXKLN3HtetOAPQTLYNev63WhM/1/gXHWegkIWp9usN
	 GEe89rQn/0X1irwPW3Atdb/Ia6lZyPM4x7HZij0GfiJgslWspG/MDB6XjDmVAPd5NZ
	 pkKRVAbg1utwg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E54616A1A8;
	Tue, 29 Oct 2024 12:36:44 +0800 (AWST)
Message-ID: <1cd43fd0c6dd6948935cee366024ad0cb1118ca7.camel@codeconstruct.com.au>
Subject: Re: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>,  netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 12:36:44 +0800
In-Reply-To: <8780e73e-78cd-4841-8c04-b453fe664bab@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	 <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
	 <8780e73e-78cd-4841-8c04-b453fe664bab@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,
> This all seems rather hacky. What is the mirror function to
> ftgmac100_phy_disconnect(). I don't see a
> ftgmac100_phy_connect().

There are different paths in physical-phy vs ncsi, so they're
implemented differently in ftgmac100_probe() based on those
configurations.

If you feel the driver needs a rework for the phy setup, that's fine,
but I assume that's not something we want to add as a backported change
in the net tree.

Cheers,


Jeremy

