Return-Path: <netdev+bounces-64404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE410832F37
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20231C23B0E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576C5466C;
	Fri, 19 Jan 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LB7XBvOz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B541E520
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690727; cv=none; b=M5kZ7HY5wYMbZZeTj4sSTgWU1GSUrMsS3NNyz0dKrMB7oW/ewDcBhoA4dj6HZtKakRPQDQxvBLvrcH45WbYZjqEPiKDVDQJlgQVkzRASuBowPGFroCeKRUAOf30xYDI4rAJj4gy335+FsHRTxVEiY9dUv8NJqp3/0PrxWXGuu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690727; c=relaxed/simple;
	bh=Ec2J5Ltj7cDp68DNlvWy8+MbU9j6Vqplf3KOaM/Bl8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRK8dkwJIJxrloEepYDPNClrlDsCvf9ebEw5eHWnvvO/G/KJwxpkDqH8KdTUZ5FgUzxYx3FGKNwulRQohj9z6OpYqnOmO4nBqMmLTHVVWMrw5dOzESUr3GpOwawjS9syL/TkOiQBoN4AbyH2JcVv8NZ2Cr9nBKzTlOpUOPk9fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LB7XBvOz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705690726; x=1737226726;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Ec2J5Ltj7cDp68DNlvWy8+MbU9j6Vqplf3KOaM/Bl8c=;
  b=LB7XBvOz7oAli66spYSYXyDgcMUDGbTd7z6VdbX4PJpHHkszhqHh0Kya
   exsagE/x3i0mDPw0Yh2Zq01jobicf1QTiHYZz13fKcEraPt9dUhr9mz/1
   Lf/UzY5VTFb+U7lOhHmLN8l2Twewts4cn9bZymKH2jWctPIf7UInCyQqk
   6zztPricXGMFmULeiAkGRaAjCHqpKnJGczWA7QFI2sBscC/Sr74YlFE4+
   VFfg05IaD/w+oxkYtQYFFSkg/KsvLl31xgYn5vtI9FKWsLyysEYRjc2gw
   KSLbss5Z3vTax/TWftO8jm1c+rHwP+TxXKkPZ/MmgG4uGOtUCo1FUW0eQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="8194104"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="8194104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="27117033"
Received: from unknown (HELO vcostago-mobl3) ([10.125.18.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:58:44 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] tc: unify clockid handling
In-Reply-To: <20240119164019.63584-2-stephen@networkplumber.org>
References: <20240119164019.63584-2-stephen@networkplumber.org>
Date: Fri, 19 Jan 2024 10:58:42 -0800
Message-ID: <87wms5gnfh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Hemminger <stephen@networkplumber.org> writes:

> There are three places in tc which all have same code for
> handling clockid (copy/paste). Move it into tc_util.c.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

-- 
Vinicius

