Return-Path: <netdev+bounces-178018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ADAA74010
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C731888C82
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2226289;
	Thu, 27 Mar 2025 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqSxgYoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABD1AF0D6
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109750; cv=none; b=HiMBCf1LFIEVY/JVT09U5s/x9rU8eoMT7nsZ4AAgv3WHzhDjwTaTTKDnjeJwxVqZF10aFpq9Z6ZRXsog3E3pkuoHlLQtn8DrNlzgjP0lQBTcvFv3Axgy0ZwlSSNolN2hHRqdUeZ27l/5UILy+e4T6rzR2xCjhZ+MvlADGq3cfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109750; c=relaxed/simple;
	bh=VNQVYLZI0F/iQMuf6UB6TZ0y/ogSpxhg7GFPG1EFm+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss2HsSUoH8FpEDZiiPT0Z37ZQX+w0APWP4AJa0WfO1GRVK2qgcXxUou/urhyh///Xpx0nghPFR6zMVynQ/iy1TPyy/vX3Lpt9cl2k51OT+YopJgX5gbexAO8s5BItQ2bzLuR4B9nVuo0TynRX+KKP0LBU7oHB9NUP6PkWRs7O4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqSxgYoL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224019ad9edso39984235ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109748; x=1743714548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PChgSwSC8tpaCUAsGUDCuE1MmPcesb4X20PCdCY1ds=;
        b=aqSxgYoLwp8TvBmNnCMz2Ep9oCKURTCmvGDQShUOn06kleSCnp47nRuPsYxCnuUYMb
         T89RCMlGMXSkokdpsLDbrCQGyx87ttxGbbAzXUSKOhOK5soNOf/lrXLBmrrPn8P47BdD
         x/HJutA1eL0zJfsFzHwy2CoTZ0sXk457YwHUtGsyLmasOMEOz9L6vHI2ZdWh6j2IiNWV
         2bBD/XnTZTHNX67fIQN6KFb2kZC/D/RtnjAcqjGo2VreTQA/13cxg1M+o0xgCnJ9Nygm
         EYEVN8pRjJ860zYQ2FkcV7QtOjvCQv0bAHpHQKrK0Eigfep37prmKualswNGbwIkN3Q2
         r/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109748; x=1743714548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PChgSwSC8tpaCUAsGUDCuE1MmPcesb4X20PCdCY1ds=;
        b=SZiIlFtCy3P4JRbAj6H47VxHQwWr3fnwEgTVaLCULYQYguUD4/QysJBMcMHIRJcmwP
         l6tr9asSM0FIeGw3/7ef30decKYy/awwFkrX9SZ5126ATxlxxHYG9sSPjNPjzHd2H8Np
         S9J6tot8xM1amIp/QprBO7Cgn47kits0g8rn10cXb8L/68uL/LTVK+8o0WNclkXhaBy3
         LRNVVJE3GbQZTfRpOGg6jKDgiceRrH6fA89NtAGGWxuo11xVNNQxwMjAVn+PXTff4cOy
         3zHXxprXykIxrrgZWl1VNZ+YwP57aQja/M5KiZv8pSnxkgaoEsTRRjwcOh/B7ZOlaUEY
         Y9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV1hDA08vZbX8tQv9HUlHIQTty7z9lqHUsgNUM7kxlnEt/XWr/WrPhq84AJoamnFDYGiT53ggM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn84DhREgiFRFIu3XfXDEFJwW51ZmnnI2/slD8WRJTAlY84cUG
	YnCwtFxzQNAGDEzxaqnSydg+JfMdgberqGEJ8E+brz+FffDDHwg=
X-Gm-Gg: ASbGncuDWPjUlWYbhDAKmIHnTwyaYX30B+Y7VbCzeXkHNu8JZGaukqm/FT4wAKyAMq8
	6Gs5UIYdeZeGN8umhzMiR5Hd+tFTq8r/iym2Z2OeRAZzsIQvPo+0VrUXdcvA/9rtmbbP3L/Kppl
	89YgRcy4z35gP+xxW8u3rYWBgETPTdJmsp0Cx0YjCP4fDJGuze4bsnQCNW5BPVYnECSHVfAITNV
	zzrtiNl6tMjfTqLio8Y2aNAK3aeNrLRoBHcTVnAKP+WGJnWbJMnv1qPL3H8IigeN+KnmpEfHjDy
	60ihEmI1PwREMUtRHVTaQaqwmGGXLvaPtSYDjZp3ILYL
X-Google-Smtp-Source: AGHT+IGCZeIKOp6thpcxIrzy64gXil1g8Xcc+wZlo0Dm79FChEzCTxplJ+XKX2eyI9k11tIxK20LYQ==
X-Received: by 2002:a05:6a00:188a:b0:735:7bc0:dcda with SMTP id d2e1a72fcca58-73960e0be63mr6555039b3a.5.1743109748254;
        Thu, 27 Mar 2025 14:09:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970deee13sm324996b3a.17.2025.03.27.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:09:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:09:07 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <Z-W-c8RyFxg30Ov5@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-2-sdf@fomichev.me>
 <20250327115921.3b16010a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327115921.3b16010a@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 06:56:49 -0700 Stanislav Fomichev wrote:
> > +EXPORT_SYMBOL(netif_disable_lro);
> 
> Actually EXPORT_IPV6_MOD() would do here, no?
> We only need this export for V6?

This patch is touching v4 net/ipv4/devinet.c, so both :-(

