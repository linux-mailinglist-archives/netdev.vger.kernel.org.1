Return-Path: <netdev+bounces-197204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D191EAD7C50
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A707A9A3F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B22C3256;
	Thu, 12 Jun 2025 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="oETaLA86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847E1A265E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759775; cv=none; b=n7QH4a9FmGCA2lg6kSXuE2vU3JRRIAHWFhHcAPpYXsUtc2iA5GOSTagvvVRxPTJEFVNHbUcOLH+HmjZiqljfL6BS9yYlVCIXBvWJf8n7l/1pt8KbZ2xftvu+IMHu8w6yWIPOrr/PhuA32bRRK83sPmwIW0J3Cxsof2DuVvfCWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759775; c=relaxed/simple;
	bh=k+8qcqat19/l68bSpa8MpZylm2SaxNPNAiemLPlp424=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7QKYedYbtGbzSdgVHSoqFL2lgJYUGli5+VuwNXu5Yu1TKCsfuFVSzRPUWWEcuMoucLNHof8eUCLBhyyyucweSQxPtI/ZOFQmhcd94nlRyW/nleSTdAzc7ZTcPof+FJyB5GtdWrFeZ+CV2jKo3UNmmpaiR8Vk3zYLzC2948rOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=oETaLA86; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso956717f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749759772; x=1750364572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlTcxbxt8X33Mas2XcA4ZwTuUsj8P5XCjQiAPUa/TdY=;
        b=oETaLA86YBtbSXxqW61JdxQyu9WHbqTArGNERt8WffopwxFakQO2j1YzMtCxYk7FN2
         LF90K9wPrVx3T3V/BqBvmEcgp21dF/TjrpQoIOd34UfL/pAbZS1lj1KdZ4XJopMI6+E+
         ex6xjYL1US2C9tYAinBo/Y9iiht8Y6axmCDGsRKtKiDWJRsegOxb3xYkPbs45OqCE+o1
         g5Y828qX4sWt//GBAL2CcB9GbTL+rfecCfGMZLS44srgXUUwwd8aAG7MCuhpNkbYRWj5
         bfDoSzVoGZ822/AyaFEkQjcEjAeEOWAdL2rjYUyvYZa2pHyjzPp/yFp0lIxBdxnS1YXn
         eMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759772; x=1750364572;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlTcxbxt8X33Mas2XcA4ZwTuUsj8P5XCjQiAPUa/TdY=;
        b=griIkWyZ+jnaXEtY8yO4N2HjSZpTeCee7Y/ETW9IgMWgHSQbbhBTmxOmBy6v69qs2U
         fE3+8WE50XeU3p3iKqLyqEHE60OxsrBgXPf6Uf2U8QDSG/L8p7Z6TERRaQGYiwomVitj
         UDAmS68g0Fi66pQCpzPUB2ILDz+PMqlb2+p1nInDmzWkRsjR7pTAltSW5zr7E2ni1Fp0
         XuqV365jPqGNku9a8G7FeyHr1VieFh2hfibV+SIRRzOUP86gmUTFndtweyaFdihHkmTA
         VZuDnB7SaEdgsdAgflRK1qRbVvVJZb6sccgsiHBhmhjJRewffuKreVaTTUPkh1L2Z61J
         jhsg==
X-Gm-Message-State: AOJu0Yw/OvECtK50XTHVXa6sn1s9irHuMMW4ln90JEogzh0TNxljI9jX
	D8qSiBcKBwMbofTX3Yacv5BWXqR/lZVjIhc2X0djlWcDFTVidIVorD/x0+C6wov9e90=
X-Gm-Gg: ASbGncvA9nrp4TLfIuK1lEuG1+6Q21VPHAfaG03lu6mbq1V3EsFcU94g6WCG52XFfsd
	nWt+yZYQ/+yJzwMNNI0iKqKqugIaN3E0q7vsoxM6ii8OirVwnc5qVYL+A1Z9I34ZVpUzqzYaVlf
	Z+9e3xX6XQhKGxPTNMVv89fsu8lFUKBnmeDlpHFG471R436MOUUsXftKW0mwjdwX/5gStJUhW+F
	6xnm1LN12mnG535Q7s4uF5a92R2v6iUcGMYhU3Bmu4vzAtvHFyZ++5d89yuZ8/AZ7md7TLjVUcV
	sFEe5Sj7E2IIYqmor09SdlOY/DuPOQS9SkVJaIGeqFm1TCABho87f5PTXPs+ztNM5kA=
X-Google-Smtp-Source: AGHT+IF+gq1H20mJU4eexJoIkhCAQCtqebZZXUexoV64aJkjI/XmvNM4sYHXfE4os5j9Dm6p65O13A==
X-Received: by 2002:a05:6000:2507:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3a5686f44b7mr504689f8f.27.1749759771298;
        Thu, 12 Jun 2025 13:22:51 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a612d8sm307284f8f.24.2025.06.12.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:22:50 -0700 (PDT)
Date: Thu, 12 Jun 2025 23:22:47 +0300
From: Joe Damato <joe@dama.to>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: bcmasp: Utilize
 napi_complete_done() return value
Message-ID: <aEs3F49J-WMQbary@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250611212730.252342-1-florian.fainelli@broadcom.com>
 <20250611212730.252342-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611212730.252342-2-florian.fainelli@broadcom.com>

On Wed, Jun 11, 2025 at 02:27:29PM -0700, Florian Fainelli wrote:
> Make use of the return value from napi_complete_done(). This allows
> users to use the gro_flush_timeout and napi_defer_hard_irqs sysfs
> attributes for configuring software interrupt coalescing.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

