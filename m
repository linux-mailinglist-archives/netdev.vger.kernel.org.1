Return-Path: <netdev+bounces-221571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EAB50F0F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8272F7ADB30
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884530C347;
	Wed, 10 Sep 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUzrr3Yw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED83081B7;
	Wed, 10 Sep 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488507; cv=none; b=Rel8RJfnP5mRFkz7Oad1ozy1ikbuFXdj5lG6xEMf2xxLlnc49+OLo1fAW0Nl0CN6wgp9XU7cLeDtWTDZ7u3ln7TZmrsTFp/+yK6ySwNR0ZojqGldmjmGYYhTdEbIDozd54qLOyPYU+88w8CVqqonzTIHSh6XEVUfLXz8lgmy2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488507; c=relaxed/simple;
	bh=sM6630zadGmQZqR1u8pau40s9sWY4wkiWmZiLgUunsg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byCrnNvtrhnFgUa1MulwnrhRGyyc0MSRuE2LzfndWZgqnHVktOZev/K694opvUWPZTx3oHhng+hJ0UdMaQbszpWCr5xyAmEy/lg0eSph7Mhd3bw2qkwF2KDz9qT2UX9Gs++luYxJE4JJDyRSDsbOcyB5sxJB3wLpH/4KhcBx48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUzrr3Yw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3da4c14a5f9so148115f8f.0;
        Wed, 10 Sep 2025 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757488504; x=1758093304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7rviqFC6fi/TZM3n7DN7u+8LmUKozVvS35AUpDZHHJY=;
        b=hUzrr3YwUjsBbWShwt0VG07p52gI39toWLH0MvwePJBgt2yn8Py2yjg7XLbWuPYx4E
         V5JQh7vYDllJQkXNSMbmPf8Ip+AI0OCGu1git6EXibrEr6RSrDeGDRPjU74WaphUK6C9
         U2KfEL7mzoFr/p4HUFmp0yf4u90EbYVOlP5v6yK80DCoR2N3QDlc+4PE8VWKect5iv25
         /nUsmAOKUX8d46GoO2RM7I/cuQR4unXTuudiFYI/wD9f9XzwjA52WzXMstOEth75x2yS
         HEOriFzm7JJcBC4pJENpK6QOYW1LcQhRHbgtnSsWp1+QX/kfD8kSOfJER/T8NsXUkIq9
         dI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488504; x=1758093304;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rviqFC6fi/TZM3n7DN7u+8LmUKozVvS35AUpDZHHJY=;
        b=b6YnU3cl76A2IrLeDXh1ntlvEMKcfPye+TxEY5TBYTCbeBOX8tbWYcf7AVUi8M7bu9
         Bhs2NQSJazwyTU+vQl8ZmTUL47ZLKXhx1Tat/2MguK4dopjeurNe4CgzA33bceSZWIbz
         DIZ1L1APkebi/wyYgKJ1HuS/n1AAWQiMI/rxMMa90rB8XnY8G/19Q5/VJlTe6QgJuK6p
         lXdoIEItrbqClCVI4gZccOcFx4NZz4qi5voZYImzlHHbci8UVtMhMTYRdU0imyleQq5t
         MswazMIs82U01reaTkfJv5SVpsYdX3QLGDNcjYfLd5WD51L0bQDxHylKLMABE73HbGQo
         l20A==
X-Forwarded-Encrypted: i=1; AJvYcCUdY6raaDMhXYSkODyf9j6T8RvPccLJucMm+y8SmPgtSDjTQNRDrsP1btyfHYc9N07mBI55F8Gz8MF3@vger.kernel.org, AJvYcCXpCd0RSgPYMc2+ZcJ+cst7AvAOy/6g1QMLQImT8IW0k1R9JdBNs0ShW31M0aYSje2duU3vP1yehUhDpKn5@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvU+MDLGBtQAZTZd5Gw0k/IXlS1JBQGIyZumzgD0IOaLcGE7h
	J68vYJ9/dFYBxLedNEZrCWao/89RAvPFN7EPymHhW73vuZkE2fXgCs1T
X-Gm-Gg: ASbGncu9tngGoRClh3s2v9vTX1jLApVRcjSBxsQw55UVD53MOEaj4KbWcfEk/obx/cG
	MUvu4OFcougnKRZamDPO1aR3jgLQIjVYz73D+oABylqhcBlZh0OA7KVcIP6h8/K/e7g/5AQR3pL
	hOkaGy+7CnOQnVxqpHR3FkbQRJ3pUEm8TSKJ+pF0LKgZZirVIbjYrnRFEfEiypCewRH0sDLm49r
	F27mhO3Vct7gL+hQpA+VnSBPvOI1UzptQS9nTYScOKE5/u7H4VvIRLq66JHk7Hl3rp695vCqHA5
	i6jxxwnbOPLEMN3hYE+PNyGtQRYbfe5fm18q0Wh37igXfNECrDnmlaEzN53WF95qlD3K3aTCVSr
	sCd3l4WNPi8fXCggCLShb9R8fHeRy+tDAJYRfDCOR+WZ+d1RKDE/NaTLtcvSqyc0OvFk98HU9z4
	XucLh34wKFgF2ZXdA=
X-Google-Smtp-Source: AGHT+IFG+idW3YLhpTGmVPGFSEnkJNW+nzVsFTThsQbfnIgS3JeXNSm3rp7SBWpMcUqM9FIU0yiuDw==
X-Received: by 2002:a05:6000:288a:b0:3df:22a3:d240 with SMTP id ffacd0b85a97d-3e2ffd7fe96mr14642158f8f.4.1757488503299;
        Wed, 10 Sep 2025 00:15:03 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8259524sm15913775e9.21.2025.09.10.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:15:02 -0700 (PDT)
Message-ID: <68c12576.050a0220.37714e.38b3@mx.google.com>
X-Google-Original-Message-ID: <aMElcbso_bBVXRcR@Ansuel-XPS.>
Date: Wed, 10 Sep 2025 09:14:57 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Lee Jones <lee@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [net-next PATCH v16 02/10] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-3-ansuelsmth@gmail.com>
 <175747155888.3660326.7601418632786886363.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175747155888.3660326.7601418632786886363.robh@kernel.org>

On Tue, Sep 09, 2025 at 09:32:39PM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 09 Sep 2025 02:43:33 +0200, Christian Marangi wrote:
> > Document support for Airoha AN8855 5-port Gigabit Switch.
> > 
> > It does expose the 5 Internal PHYs on the MDIO bus and each port
> > can access the Switch register space by configurting the PHY page.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 

Hi Rob,

I'm about to send new revision of this but the nvmem DT patch got merged
in his owm branch so it won't be included in this series, hence the BOT
will totally complain on the MFD patch.

Any hint on what tag to include to the patch to make the bot include
that patch from the external branch?


