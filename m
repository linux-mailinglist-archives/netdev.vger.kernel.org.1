Return-Path: <netdev+bounces-229367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E803BBDB3DB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E05854E36B4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C530649C;
	Tue, 14 Oct 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+bN7zMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38098305E38
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473336; cv=none; b=brelWSmYL+SO/GmQFTF1VU09r8O4U55vFnnqz6EasG73daAWUViW9OktyiHLzDn8nCl1vNt2Y6kiCGZpVLIrAXG/Jxw646w4J0QMw/q5IuRhaEGLAVBE75ltVq8G1wXQnYVwqCRiFYZRoGwtbYm+mzvG55is4TGi479nP0jCdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473336; c=relaxed/simple;
	bh=Z9jeuuKa3S8ctBCTdK9cDINmpkoLVy8JGR70/NdDNGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAB/LuO/tVygwj6KuRWdjw4/pEsbOpfTcovFFhoRBmYBTmH4ZfVxhzu/kSVPrb6pCzwQ3QukNhS96Llxt+w0esltcc8x49xKLNacloRDdtTDrFWTb1FTdpcAKmYGgDF4KnOG2Lw5WiiiH7S7W+2EAdtmEyWJ/20vBoqBVWb56VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+bN7zMd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2cfbf764so6431765e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473333; x=1761078133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0VN3N169a6sDZYSNbJZEW6EFloVcwzVmWscTgzu42Y=;
        b=R+bN7zMdr9Nk8KDzM4FKqWa8EUrpj8xRoR/QIcJb977eTYjTTlYeB9AzkvVXdXKWSs
         7A5NMyZFcOOaodtJWbQWwMgMraQZUUJh6dMMlPZ/ouxRm1KVJjFS27QZ+RLysvcsDVuT
         SOCkqV2I5Y4WbFCULAJwArG/FDeWTPuKxKs3Q1TZ+eQyBFwjk6sAlzaOZKpy12afHcbd
         pZgDXprkTtg7eyfHDZLTG2nLFvWrPyD+a3SWB8BIlzEEwmkbDg7C/rzFvyIkkD877p2V
         DUFFKzf3/e51BBQgBd+A64/x5u3mblo6+VEGpvumawM5EYUrE9Tx+vXEXJpnkA4TFUP+
         DGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473333; x=1761078133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0VN3N169a6sDZYSNbJZEW6EFloVcwzVmWscTgzu42Y=;
        b=JbX3e7WyzICu0CJgq05YG5BT9ua2PadCKcLnrh9xYCYig2r4CxF1a4HseUqpF/nCRL
         7eM78EI9WFGdzN5j6FF7MxqH/DNIEJbx1/+r5qL2c/JMW+Qi1vdTxHzYxr84jJk5EENG
         m7WE/8UGYwOARO7zdb7sgudI9fkzMagGPzZhue1LEIOWO0y7D+jFxqK99orX2SZOd4IM
         ThiuzMGdn0Y3YkRdNwRYk9gTXXo3yZTqDkppNsSYQGcu3q0F7ZTariFL5e1tAVMsq8+q
         AJ7N2SaUadZYs5xtNN16hAABzqGGHVT9ESF4+iIZ/LO1FQ3ut//PXB8IJCJ1Ysl4i+sc
         0WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNjXCtQxkk1ivenS7iZMwYBxYhRBpDcx/tmDI3dhDppchKe0s55EL9h/gwYs2H6Li1heBt18U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9HPUdln0AtWtUwfy9zfJ4ZlttWG6p0mhq7uTIAYjmG3nhMtl
	okXCh/qByKxBb8VUIc2qsSWO06Ae0H9m7Hn9+QoZP4j0s/JGcRvuIJ9C
X-Gm-Gg: ASbGncsck4XIm+ljrmXe/ruSQ+7OWAU01NWBy939dCq7u3rFqPWz6n9DoI1hxTHu+b1
	VetBQmdvBN+1Yzhwelposs9BbWjZZ4FwRriXh35A7cKMiAWSXfzrWQHUaMzG4rvuIHaTWrUOgGT
	lMQgnlCIElyY6Zu/ACeg4OrZgGACtWJgl6eFfEdMSqbCBIkMJ/kBV2YaL9LgywuRN1dTx3psl0P
	u3FKpmlF6ZK+2nwkYyd9/IvrWw5jzhHu0ycjxYXdJdUD2Nfq2kO6B0sGf7vuBrysLRJ6M6AJEmS
	BUjvpMkTQJ61L1NAaHWI8Ec88b1XSkGP4KZTFFMKQXy8o7fvVJJLUNxHXOZCQq3gLhqdZUvo70V
	5kN1m3GkhUe2KwP38W86oMwcX5rhrC2nNUbWBzuevQG4y
X-Google-Smtp-Source: AGHT+IEdTUKZQtk/f0LoaN0UjqFL8Av/IcntDztf41Mt6QHFX5yxGqO8F8kgqmQCURbbAmUt6ZVOUQ==
X-Received: by 2002:a05:600c:b96:b0:46e:32d8:3f4f with SMTP id 5b1f17b1804b1-470fca8c732mr1948035e9.8.1760473333487;
        Tue, 14 Oct 2025 13:22:13 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:eb00:dc9d:6aef:3136:d6c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm25331568f8f.30.2025.10.14.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:22:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:22:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
Message-ID: <20251014202210.wihb2hclgqzpfseb@skbuf>
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>

On Mon, Oct 13, 2025 at 08:03:47PM +0200, Jonas Gorski wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

