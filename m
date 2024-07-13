Return-Path: <netdev+bounces-111295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CE9307CC
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D411F221EC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88112146D7E;
	Sat, 13 Jul 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiUGoy9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCE17C73;
	Sat, 13 Jul 2024 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910195; cv=none; b=MwnVdI5qd8kIdqzS6Rk2mY9yFc9reV6hA0+srAck1hvizvY0iNDs/JFwhgeC/rf2gImjLB+5DakQIT0wnHuh/bTfHvLgti0ZjVXgtPS0u034HsKE3ol48K/0oCYY8vZ7bGy4iHSzR10Qh3fwiAVPNzDLK7GwOurnLvnlQOx919E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910195; c=relaxed/simple;
	bh=tv7QZ9kOrsAZpDIjfYR0IV6cYAK6lBdhToqGuWBNNiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl86/OqvBSh5Emdi8FNQgWzZjZHRiTYxX6duT9EApKEeqzwCJGVs3WzbosUs/jM8sJF63Xwyxjqkltu2/H/a9q5uz76rsW1n6+kRss/E9JVYW6Ca3Y27n/AoQRvSZIVIJFrGxEs4QCLe4f0z/wTEerXxvocsXiB9yMtDzcAkdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiUGoy9P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4267345e746so20831955e9.0;
        Sat, 13 Jul 2024 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720910192; x=1721514992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv7QZ9kOrsAZpDIjfYR0IV6cYAK6lBdhToqGuWBNNiU=;
        b=hiUGoy9PiLyMRtgmrLguuaT8lIDE1MQnRd3lV6F8UVSNOBjnrirphe7fFXDhRd2g4z
         M6K8GjI8y9ng6HuLADq7ajBn0AqslH8cDnP+Dh2qdwdFeTwHypELQDiBLWueJz47iFKO
         Fcxb+arguf7f/JxuxjVR5YpohEfG58opTC2yGtQHBJRsKPOAYwAxGE4iQRJYyxjbveGv
         u6IqDpFdlaczeEJsNMNHtro+13XNVNf8ZfQPzNmuvqRi4+buOJijBfuf3omKOFDS4xsL
         tvwuwcclz5JnQHvFtKSvFr5VV14YbpgPOdGj6qN3B4jwZJ8+B/ACqGOP1wu4kcakp+TE
         h9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720910192; x=1721514992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv7QZ9kOrsAZpDIjfYR0IV6cYAK6lBdhToqGuWBNNiU=;
        b=S/8bhOKohvCb2vNzva6ovaPQXAlguy696yVbRr1112g8OmCWQN83kN6WUs2fjaDjNp
         frQ2KIqHSNZNC4PhJaqAZrx9BZip2qyv+SQ043ns9VohjWkhkrGQYpuM45VQJTrIZMx0
         +pVaVUptY+lh6zxaSueXB1Qgddqjrv24Z5mGZ91hpH4rVV089DfrOJZkITxPc0l679PK
         JcCEfvxS0KA0wIAXQRaK+aLpjJpfw71YoQOaYYF3q2Oi7g7OFTsUTzbk84gDivV9Tch9
         dzZL1bCGmZ/Mzc/U8BYnWptDtdIiIKWp/SzLSThrn3Va9IROV9HjLIKQaqPj+wjEtxU5
         TJJA==
X-Forwarded-Encrypted: i=1; AJvYcCW/9UcLfYSFdH9P6RHPpm0XKMF/3my3L5GenIQ0cdQJC12BX9XuIGoKRODXJl4ozsmwk/aH64uqrz4SD3m7MMpg7r3c+IM4KuZycaa6
X-Gm-Message-State: AOJu0Yy5zEZeS7c46+gxsgWGorzZsvdiELlU0SLTFDRCImnX+UfYHZzX
	EE6Zq+OgDmJ4OTXm2WGFjK+mUsW9a7c51pPyTasEKfTiEzl9R8yf
X-Google-Smtp-Source: AGHT+IFowlHX+bnG1b+xSKNVPIhsSXI3q4y/Lc9uGn76y+Egz28w6yjs5NbYiGdrTmhWg7nrcs9B8g==
X-Received: by 2002:a05:600c:460a:b0:426:51d1:63c3 with SMTP id 5b1f17b1804b1-426708fa8e2mr99095725e9.38.1720910192053;
        Sat, 13 Jul 2024 15:36:32 -0700 (PDT)
Received: from skbuf ([188.25.49.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccad8sm2490737f8f.60.2024.07.13.15.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:36:31 -0700 (PDT)
Date: Sun, 14 Jul 2024 01:36:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/12] net: dsa: vsc73xx: Implement VLAN
 operations
Message-ID: <20240713223629.ncgkw4cg6blakv2e@skbuf>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>

On Sat, Jul 13, 2024 at 11:16:06PM +0200, Pawel Dembicki wrote:
> This patch series is a result of splitting a larger patch series [0],
> where some parts was merged before.

It is a good day for this driver. Thanks for your perseverence with this.

