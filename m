Return-Path: <netdev+bounces-221597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC709B51189
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98487484B2A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152F30F80B;
	Wed, 10 Sep 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbXj/oYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812119597F
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493441; cv=none; b=UhgCbNlFay/vohbqAnjwnU+J26loZfsdVim6TVh5dy03rHVeTXXYpJr37Jm8CHQH+CgLO4IRLJectHweJskOUrSN7RPSTXr4SzDeUP0bdkrxaFak/wZNSmfNd0lyqYlTX7Bh9cNrZv8I6bb9QNwccnn4i4L81HBS4og04xgGaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493441; c=relaxed/simple;
	bh=LhMaFFyNz3QPdZE1rUgzQv4XXgepJOyQfEYh3oaTmqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8Dfil/OIOox+4k8yQK2oCEtHg4hUosyp/65b4iZXNtqcfCDGalZt6Tplyhd9ZpzOCPupRvpPY27Va1+Hz5aK92rJEJ87VqC2aeZqEtQjIMDbCTojnSbH+YL62Jlnb/v3azCQpdPXcaYZZLOTtSe1vSV8gY3ZELeCEXbujVtm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbXj/oYa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61ea08e565bso724032a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493438; x=1758098238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmt8NRxXiTXIxxt7so4xgdOFQzQhtk1IBnRJvL5Y6wM=;
        b=NbXj/oYai8y+ayrkuu+6HnnfIBVSesuaRH8NqFwLfPkzv0IIj59ewVawQop8REZF/q
         qcc/3tQ0ID/wKyEvVWonLLuyLw1jWk6DPCCDp7teGM+B/a9XTGS1BFo+aEDBwHwafRP4
         ehoUFxuj2TQweuoIXMRkfI3MTlKBfukPr/Vmqlot97amIqMwTxmrEbEyZP149/eSexAD
         XbDiLHcK6DuyNPDevW8Kab7CuCsaOKjlPddi25Zgdno7/jccIjUibS6M83DirJpRzb93
         eMRixmggfSr7wA/IX9/X9oyhAZRl+8PQjH9dqC0JZQv458LmcCGM9UGUZW6nqEkr0iJE
         9f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493438; x=1758098238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmt8NRxXiTXIxxt7so4xgdOFQzQhtk1IBnRJvL5Y6wM=;
        b=O8OkPptvSdIcSxPzBMI5ZpakOE1dBIzkmQTrmLzJhC8sjekTKsp0dsR5NsA7RRyCaE
         NM5dFnL+Z+V763NqFadQHnEx4YeQPa7g9M1QqAqWGvWpI5/kq8oKOQSaukxku52KDZ3S
         T0ahS513ynsuzXHXDG0V+n9XriTLFqKOAkKibNTOgHhikitEllyXgyrVlJtME8uxts03
         CsjJ+C4agVXUgl0cdrLvCJm06Xtr0vvpHgT8JGRQEdUutQpEWgN8BiDltCImcYZ1yCdx
         4rUwYLa/vEhYKw2FflnGTF2LxRweHbADA6BhkXOlrrjr7K8/sbH0duVQVcMtr6whbmGW
         49/g==
X-Forwarded-Encrypted: i=1; AJvYcCXxJX+Svz2L9RvMvlm4xUBKRhukTbtq5a99Am8r/yKpzdRg5DHCFkVMvNivYlIZ2Sz+4ycnSFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQgqqT14mAwUBlsnyd/ozW3CYxVrHzRFw8pOn7se4hkuFk6AC
	RYgZtYWdD8j85F1x8iRly0BnFbzJ+TD1m6AzlEEtQKrVZEathk1RmBB0
X-Gm-Gg: ASbGncvR7WGsGPGa/yPcpJpYZc1TdQF/irIcPKMd9wqg/L+FGRyrfyT106Ar6Z4VZuS
	qTYL1S8J8dYMYE7sonF2KixkQBhuVsuCoXrOg++eCZFMZqHyF+FEaM+8Ma8B5JCF6Bz1KqH77Os
	f2A3EJab7tC8WwUiVY9etcOEcfeDOBrI00CRhQunXdo/7o5geZKJVJ/JOisnBQRKilxW+strRgt
	Y+G33WmOK5V+ThTCl0s6S4FIO37l4YWCALrRbJbP3dgDeKJeNYFGl5YTHyUNf7B7QgE4hA0rbUc
	uT+WXsuZi9i3uQoaGPSs8wY8AxgQIYPmSLhCE+Xs16S6AabEZ91EFKa3nApgWLxtM4da33TNd/S
	lDjzdkoJjbSH5hzFByUx509lmWg==
X-Google-Smtp-Source: AGHT+IFidFPKBI8cS+d+4gYHVAlOYg3Lgm1sKTkF6r8WI6UG693yE4O5MLuodha7xFNpnvYnc+AT1w==
X-Received: by 2002:a05:6402:4486:b0:627:e2d8:459 with SMTP id 4fb4d7f45d1cf-627e2d80936mr4573364a12.6.1757493437828;
        Wed, 10 Sep 2025 01:37:17 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:6669:35e7:fc93:9b1c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffcbsm2844962a12.3.2025.09.10.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:37:17 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:37:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 10/10] net: dsa: tag_mtk: add comments about
 Airoha usage of this TAG
Message-ID: <20250910083714.gfrhsco3e2q7adxt@skbuf>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250910082017.hjlq3664xvg5qjub@skbuf>
 <68c1376d.050a0220.2085dc.675b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c1376d.050a0220.2085dc.675b@mx.google.com>

On Wed, Sep 10, 2025 at 10:31:35AM +0200, Christian Marangi wrote:
> > I think it would be good to present the AN8855 tag using a different
> > string, so that libpcap knows it shouldn't decode these bits. The code
> > can be reused for now.
> >
> 
> Do you think I can implement 2 tagger in the same driver or do I need to
> make a library of this driver? Just asking what is the correct way to
> generalize it.

Look at the uses of the module_dsa_tag_drivers() macro.

