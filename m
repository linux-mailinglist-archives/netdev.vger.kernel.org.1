Return-Path: <netdev+bounces-142321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E79BE45B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD6B1F23A0D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467751DDC02;
	Wed,  6 Nov 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzJcTNOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7A1D95A8;
	Wed,  6 Nov 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889351; cv=none; b=Wd5yWgLHSZuMl3B7KX62dqeepYigaNT+govKebzscR8M3jZCJTMutl+50Z35y+Ox9xhOIVOB5ukzI5ft1l0YlTku94XW/nmeSXSYyScfKuJL1qRPDLH/NvMDjLH0a9PUbtf43+/QCReXd6WS0UManC3LC3i4RWSwGsHjjYJN/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889351; c=relaxed/simple;
	bh=DxaNnpaSrtyISiuvpoAX0VUtUT9iRTDDxkeKlEYxEYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez9D4Ynmek7/FazsE/PGatJpR9ECP+sIkC97xrZBUYU9HII5i0nM6QXh5WGHfCihj6DbnDFNy5NyTQXBMy2g8lf4kj5gdegJHOwZajhtMVznSAq2kjJo1H+H0rVLWip+s+FsuC1SHrx6stZKG8jESPJKNkz+dDi4mLyOHDST6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzJcTNOL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-210e5369b7dso65663915ad.3;
        Wed, 06 Nov 2024 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730889349; x=1731494149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxaNnpaSrtyISiuvpoAX0VUtUT9iRTDDxkeKlEYxEYs=;
        b=CzJcTNOL3A4tA7QyU5K6anfgMkRmukCJJTTxJYxEdGx9cHrytKTR06Q136xmwfbJu3
         PXXBBspUbi5d6C6EkLRcjTk4dc5DDEj1GyY/ctZ4dPBfO63IYwkNT4ttHJLHqffmZKKn
         h7ZI+RUrkHqybmUu9K4+AhYHc/LnGgdwnQ+XOES4xakvorQgrp9JJudkwbww2YTWLhZ8
         od7ThvSpFxnCHwS7WImZ/1bzH8+ss4FsC4HFHkujNsRxHO7G0SZz0Ce4rJgYCAtzw+j6
         IzqFRwwT1PSvhzny+6FDybAQYJMx4Lg82vVYBCyn2MPvQEnwRUuajRMhU6dv0uZZOYQB
         R2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889349; x=1731494149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxaNnpaSrtyISiuvpoAX0VUtUT9iRTDDxkeKlEYxEYs=;
        b=O9vqAFsa5kCbDWGlzImt6oLSEA4oZTklmH2xjgR8x2CWjjDhUrtF5/crOELXcaftEB
         t6mydIGkiYs8PF0PhC2QOR0nRL99TaW4NMLgsvf5dOqh7+JesOan93lBhOT7FkN/ejyJ
         j8+so5L5dZeA9MG/nUN6mJlfA/7yp707G7/04ga7Z4D+ohYk1pseG0wBUH0r+4/9L5rA
         JA3LBxuWTWLOdqnAPLg1Fsc1stQQOBCOy0XI0zXP6rp8y24+WD1BUzHPLJGgyy0zbBd1
         7pAwlKSGHZmEZ3XWFmB7jZss75apSmf6EU3gK/dCrIpA/qHxyErVAVk+GLoF/Scywm/3
         21sw==
X-Forwarded-Encrypted: i=1; AJvYcCWYrgdXeQl8GemFrXka/A285kmMd7af0QH5dPt5hcbk6fYc4URn0RSAD8f57fFIw6a80HP8fUj04S0KxbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa+W9o7Kf40jPUJF2Jhujbj6cMXYNsB+pg4XI7opRJqxS+mpq
	RFssgHNOtY5/cZNSdhb2PdQ2ppZ3Ci2TU9l+eIpiPCySHbByOv2M
X-Google-Smtp-Source: AGHT+IHNFP09lUeDkc9TrQYkWD5twN6W0snjBYSgBtz8dKQI932g4slJjXNPXvd67McR6w08rwJY5A==
X-Received: by 2002:a17:902:f541:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-2111af2f399mr259888135ad.15.1730889349149;
        Wed, 06 Nov 2024 02:35:49 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2c18sm91236075ad.120.2024.11.06.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:35:48 -0800 (PST)
Date: Wed, 6 Nov 2024 10:35:41 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 1/2] bonding: add ns target multicast address to
 slave device
Message-ID: <ZytGfXLdoMoMhveY@fedora>
References: <20241106051442.75177-1-liuhangbin@gmail.com>
 <20241106051442.75177-2-liuhangbin@gmail.com>
 <ZytEBmPmqHwfCIzo@penguin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZytEBmPmqHwfCIzo@penguin>

On Wed, Nov 06, 2024 at 12:25:10PM +0200, Nikolay Aleksandrov wrote:
> Hi,
> A few minor comments below,

Thanks for all the comments. I will fix them in next version.

Hangbin

