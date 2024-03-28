Return-Path: <netdev+bounces-83098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2712890C3C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30F51C26D72
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF413AD04;
	Thu, 28 Mar 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KNvcUyWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768413A875
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660069; cv=none; b=Leq02PBLH4690BG9cXkVFESX5YHRGsAQBO+dmycPAj1BVHcSevCq59b2BM8GkQFdHm0OvYTm8agxJfUCM+inzQF6gRlpG6cEgLrCk62ZCvx9/4cxFI4n46wsu8GD2ARJqiFt15bjtl/PVQ77vxWvIewKhwTnlxE8+yFYou13LmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660069; c=relaxed/simple;
	bh=TmkCS9jM7MpgxxtIOAWwrufoB48CaCg9AIUTLLa1ssc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIP5jrLDX2AbPCCUKCfAb9WA/a/5pwiBTjXf35JTmJFHGe76RlUPbww5XrEZg5zRJINmwm+SnBL4ENwHDfch/BsQF09hmjpVbyQBKIFv6F1b2g7416VK/yrOCm3aLfBstE3JrJAZpz1smAXJrlMw91zaraVp1HfP+nTTSuVUVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KNvcUyWl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0025ef1efso10882685ad.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711660067; x=1712264867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoe08oLfHPamqNE7SkYcG+AKQATabTcrNs03hfc/OQQ=;
        b=KNvcUyWl7FrFRAx+Iq+1Z3OAYdndM9O4fH8olXJt86o0BGPvWbjSlfsZhuHzqpE+89
         6ONAwuiUJ2WSKyR5gPgWY8EBsMID3lhCjG3W//MBdhxxlL3+LrK4wjtLXAap6Ydij7Ux
         sUIKPKPyKZCXf5SF9twsSc3/AbTC0YiG3Xhl0gtdPZUCoMIfWu/UmtkU1cV1Jd6oGyu3
         SRs9uLiNxgKLZ4nea8X/18vjQQZx55YHSazyWmR7CgHGkzWpYDrb+/Tc0f6i+Wld427n
         gYwp2eZh18VOFPtWSxMfrYqCUPUoYQxBfrSe6cUhZJ1gBaSr08WYZ+7Cv5SCaEpkhY2y
         y5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660067; x=1712264867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoe08oLfHPamqNE7SkYcG+AKQATabTcrNs03hfc/OQQ=;
        b=lBAz1TbmMcY2HUn2EPF8Zh4LCsMSGfTFRBMGpUT4Vcmco0l8Lpmydm9Wbll4AJfxEU
         R/xkLaduUpLGWf0gyCXYeFYEE6rVxVU66I/96FXdiRFuo6z/tptlKkR0bg/8N164ynAP
         C9qto3jbkizsmuKhPGNcmPrMDv6HXupDvOi3YRIeTOp8JYbsPFB5norsVwNuW3xNJ2zL
         xhHa+IuA9KbNq8M3SGUiXxyQMNhkRz7K1stPs+TWYkLnBn3liTyvSJKK8cuvBDpCjY6Y
         7Cl9PQRKFRk+BHLlaH+p69azBuxzUpF3sf0ut5ArN5QlP/7Vht+DXTAJY+e9UIz++TAm
         68Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW5BwSF9aaf2p1bUmwsSPOHrIynnCSYG1iWFPRARRbIqmeczslNxCm7QwUtGT36+PcQjk2M2tkP72XgufPvdEL7luhQrfAB
X-Gm-Message-State: AOJu0Yyz6XipdwKIs47wnD+Td+P3+Gb5YFxFPoehxMeNCr3mgRyzD8ti
	P9URbG4DWgN/EyYIbIw3YEGUdWPv4RChGFbjsF1XkHBDvF9Ri5oNfYPiIzaJ2vg=
X-Google-Smtp-Source: AGHT+IE7z0/TK1fMFS0Yvk6NaGjSry7T5aLMZtluecZUF0Xx3MLIsDvGnwum9NiAtMXBaJMCr5R7Xg==
X-Received: by 2002:a17:903:555:b0:1e2:577:f694 with SMTP id jo21-20020a170903055500b001e20577f694mr624724plb.61.1711660066861;
        Thu, 28 Mar 2024 14:07:46 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170902fa8d00b001e0c949124fsm2073287plb.309.2024.03.28.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:07:46 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:07:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v3 2/2] bridge: vlan: add compressvlans
 manpage
Message-ID: <20240328140744.7c98fa7c@hermes.local>
In-Reply-To: <MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
References: <20240325054916.37470-1-tjjh89017@hotmail.com>
	<MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:49:16 +0800
Date Huang <tjjh89017@hotmail.com> wrote:

> Add the missing 'compressvlans' to man page
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---

Marked this as superseded since your previous man page patch is already merged
in iproute2 (not next). If you want to update that send another patch.

