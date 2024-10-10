Return-Path: <netdev+bounces-134191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2099856B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557D8B20FCF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE21C3304;
	Thu, 10 Oct 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RA6GjwHj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F671C3306
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561604; cv=none; b=L+QilI2At1ZQG/HJxLOpLsX5Viw8i/Hp7s8gNAqTm9SXbNNrl29vm3aaNcDaOPjYYe3vEUQmXXRGhjhb+cr6PkiDjPRE5WWUiEve9hDw1Jc35xY0t8hF2qBcOcyNdsPsvdXgB58CT2LNs/pglOnNho7a9fr+mKZIaZYwoQfkEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561604; c=relaxed/simple;
	bh=cps4l5o9l7YxbjuwbtsqXI0ouqQFhZDxu43nUYycFX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY8Lvnq6cRBvAFiXyQYPt7le+zChGXuMw1sq/IqQ4EKbtiCoL5nPdS9UhjmFW0hK1IZKMm0KMgjlmBSjSVnFCMI4oe1Wch0KlE3dKU1Hd3X6MC7dOKhrEWu39K5J/uejadLujEqXgga7ddonXs4+6wNDUnOpvXqjf0ARHJpoNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RA6GjwHj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561602; x=1760097602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cps4l5o9l7YxbjuwbtsqXI0ouqQFhZDxu43nUYycFX8=;
  b=RA6GjwHj1fKspO7XNb171PcsqULbz+Rhx/YfdOrghHGK6qIWl30CMWZl
   twJ8Hr1tCzfc66qNZVnro0XGlyXpb5ilC2k5Rc+Ry05tEXY0ZaKYGpUbY
   PI7n9IqEum+kfBsMzJYqvYYQjN4KzaGKHdz+C0bwuQM8jDTNjNa14HPjr
   irUkNL/MIHFx3ecs/Dawb+/NS3dAPGVfWH+4w+wsUpinpV3ginMdbsFk7
   zoqoymmWMgObMLfsGB70sVshkTLVloFaoYTdE4WlNfL4GgMJDaw3zGpUQ
   neg8HOhvOrJSMTJ+zBsoZUsp9LiDxTaPsF3V0PGjOQj+411chhLUp9i4y
   g==;
X-CSE-ConnectionGUID: PazXVJ3DQEeVdRVcM5761Q==
X-CSE-MsgGUID: QR93AAuqS4q8sK7axmV5pQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="200279044"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:00:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 04:59:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 10 Oct 2024 04:59:39 -0700
Date: Thu, 10 Oct 2024 11:59:39 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/2] man: Add ip-rule(8) as generation
 target
Message-ID: <20241010115939.wmmvfps4fmnlzdev@DEN-DL-M70577>
References: <20241009062054.526485-1-idosch@nvidia.com>
 <20241009062054.526485-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241009062054.526485-2-idosch@nvidia.com>

> In a similar fashion to other man pages, add ip-rule(8) as generation
> target so that we could use variable substitutions there in a subsequent
> patch.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

