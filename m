Return-Path: <netdev+bounces-227540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B19BB242C
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 03:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B33B1883E2D
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C747081F;
	Thu,  2 Oct 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPBnYoGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C29408
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368057; cv=none; b=lC4TXsIVCTfNu/zWpvE4N4CVHhLQtQHy50ePRfCFPSCDLageAxqt7Cyi9rCUgly9RHBHnE/PtA6UmmujCq6ZNF/ubR2cmqV+M0dd0SG+aT5opZQCoFqli6zpndULFa6M13XEExZy8Bpd7CeY1rHb4OiP5DOpDgjwerwQ3jwdtLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368057; c=relaxed/simple;
	bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdWC8mBhYirZupr/kDIYwj+GFRMuVuaHKSvSF4KIUEv8y3O2Jg52jD9H/mGGofmSemaEC9Ux61zOODAOHCVMQVHBwbwfCnVnABpj5/y52OChyPiDc9osY0/8ebjH3azqDwAL/D1yBmQCy59ysNOA7c8mnf0r79vhzlFqDF8eNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPBnYoGy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eed7bdfeeso5969585ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759368055; x=1759972855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
        b=iPBnYoGyD23G2zM27Q5H2ak9C3hyGVOxTWIL9tnGdcbP7ZLisa080VYIQztgrRULwU
         3x33toZSucOJJrerM/lRBThD0Yrnu3ljUtk6hNKQ472bcl2y/c4pCThm5yu39XD55mBb
         niByWu41SxqM5yiNZTbbaqzXe1qTuEMWFzfk5Cd209ZB76zHQ2ybfxGDc7/ECGiECnQB
         3jxXnr+pebb+yLWg6fqJ5nw6U60JIewdWsUeXYjuP4XVNhUDAkolvrRzoY1n0ub6jDzf
         2/ROq+3JsO0IcxROweqSJP6B48GZ851MtwILX4L0+iH7itQDwrqEewTP4ORvC6Y1zPcb
         FyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759368055; x=1759972855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41QyY0n4HiGjS42Gcj9FbnEZ55TMO+9hpoyZqI1VgY=;
        b=ogIabrjB66flinYSoyrqCzIq4maF3NCX9XYAwb6n3d/ypUCQXgcOKFgvNxo7I2R7E1
         S5pjQ2bGoWNXB/vMDUytgf3XYUuHKClNidL8JKsy9940qKvt4O2qUsdCZwKibLLCEfr6
         6MROBk+uXgf/x6Bl4+hasoel67ufF59F/q98xjA282DJGab17baNcuNVAPv7Ph1U3mkV
         Tg02Z9r7DHst9meolUSmqlCNcY9x6cfWqnqm5sdRGD9toxlpGQFzXOHb4DMWsmG9SIJh
         jIlS/QT0LGIeJ5mWfiVwrVhig3d8psdlAYsxu9JsdY0SXizNquqBT3xedzvzrSt/7piW
         lptw==
X-Gm-Message-State: AOJu0Yz5NrElGGDNJGdQvCDbSROcfUYOB5/Id9I5QvdwwETJPqXNAqZV
	WBkdit06mDStVPkuFqV2H5Dz57NIgDRFvJq8xVxSoIQkZfI6smcYi+Ju
X-Gm-Gg: ASbGncsdec3Kvn9J0RxJm+q4XkO9o8kMIxtHEsdDeKw5CGaylvwbpk99Os21G5nKlZu
	TgcC2KlHOGhTu8RWEmXGw2PK1z/6yorwrYUR7IvqiP0KJHdCtsVwZmU6piJJ72HzGqT4bIHjKky
	nt1noSNnSQiYy20Xt+zHTe0PVZHJVmAkBvYvhUyl6S93rsQPlMDry7GkfoAweewh6YmFPvkkbJC
	ZID7+MdWP6J/Ua2Z8LSJdHLQsy0zHAZO37g6u7V1ML64JYjmsx/PDut1TPDboVTL0zD2ksW451N
	QEbNPtxdVofINTd/c7q9IcjT11qAZA+T/DlbANyyWuyY+My8i5GVI6/a1+Q1B53JoA8rW6YpKRK
	LLXMSaciMEutqRB9OuBtgEW+eXGF01xZM1kiPXD5/Z2ObJdd7Qwk=
X-Google-Smtp-Source: AGHT+IEHwTg9edEG0pePemjlwRyRAUMtg4MTI4M+82HGHYEB70fkCi0HpVswM/WLP3OEkT4weA8pTw==
X-Received: by 2002:a17:903:246:b0:269:b2e5:900d with SMTP id d9443c01a7336-28e8d024a64mr20075435ad.5.1759368054835;
        Wed, 01 Oct 2025 18:20:54 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d584esm8685815ad.107.2025.10.01.18.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:20:54 -0700 (PDT)
Date: Thu, 2 Oct 2025 01:20:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add ipsec offload test:
 manual merge
Message-ID: <aN3TbpJ0nOg_VkKn@fedora>
References: <20250925023304.472186-1-liuhangbin@gmail.com>
 <20250925023304.472186-2-liuhangbin@gmail.com>
 <f4f61cb1-a2f5-4105-b051-0b16427fb12b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f61cb1-a2f5-4105-b051-0b16427fb12b@kernel.org>

On Wed, Oct 01, 2025 at 10:37:51AM +0200, Matthieu Baerts wrote:
> Note: A way to reduce such conflicts in the future is to sort each entry
> by alphabetical order instead of adding new ones at the end. Same in the
> 'config' file that is also modified in this patch.

Thanks for the suggestion. I will update Makefile and config to use alphabet
order next time.

Regards
Hangbin

