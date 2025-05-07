Return-Path: <netdev+bounces-188554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DAEAAD5C3
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030C21C20C2F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6146B205ACF;
	Wed,  7 May 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdrYcr4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25841D61BC;
	Wed,  7 May 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598438; cv=none; b=O7V5MVEyjDbfRrvTE9y6PhbejEZ9x+8soXEKmdYIzk4/MKnO608lzg9siXq6hvnkZXaV+mYlZymfvfIJERIuN11ySytr1EFle+4w3p8Kl3S1AvaS1OivRd3lITusSNCrU/BwhKkEJgkdJr0G1yDiYUSCg4q3p5LQGO3d3vq4PT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598438; c=relaxed/simple;
	bh=YnUsldGaNeop6ZU8a+PZWGnLxriRPuTvgJ4+EEwCDBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/pt9xzn9nXA/En6qB4VcPapXaxY6yaBLjhgEBln6YLZcLgVz0C8JzQcJqzt6oyGk58Nr9bt6TfsAehRhi2oyXF+TyuiXzCRmf76o5vXFYjIzi+vamKT6J8uh6uy2qEk4U0qgKIj5xsSMMeMa+7z4S0//Kcp7mXqjm+JwNbmSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdrYcr4k; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a894cc07cso1644845a91.2;
        Tue, 06 May 2025 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746598435; x=1747203235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJDoQSeXwT5ngJPzWMB/K4sy4nXrJNfhpKUqA7OjnfM=;
        b=VdrYcr4klpgra8h2njDaL4cmQ8HrcfoBrZ1dj7qlHZ/eoaDvSVdBf2XLmWoE2Ey+uz
         HvKGnoTXKPM15TSq+0bonepEzLd86Is9QS9xI3lFC3XCZapwHf7cnN8HCYWsa79LUwe4
         l7orKp+T/7RdV5ahy8EylPYDmlnjsM0NO9wqz+BFSUOXGz3YNRGkJqdCxe9LCykqQyNv
         OzmeSpi5wy8EbXAPglaZ4hUkqCFb5FfElOq6IwuijHH+qPDsRYBC8xHKtTD+gu2nCPFS
         Zr3CiQ3G9g+SRT5k6E83XA8lospwWWFkEH6aAASdUPwQXCXP9VFzLDeVMk2sRrVPxslC
         O46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746598435; x=1747203235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJDoQSeXwT5ngJPzWMB/K4sy4nXrJNfhpKUqA7OjnfM=;
        b=EOSu4cV/4pcuLBkEF7U2XBhq/MkE+QVU0ZtyVDOlZcYLz8LV4Gubjduu7iKfgZofyO
         RawM5orgLhspyBZiPWVzNQYkXmvI6CsG6b+WTRGl6vlrBHiJCWn199c1eS26aoesEXtM
         9U5IkaUpGLuDqP+f0Fhg2LVUfIRbxyTUVtEmEbOypViUqrubNQky0EoJR2Z6RGZfQlEG
         I6x0ubn03kX1nDL+1SclpDkFIv1eCRN8N8IDRU66D+JHfDbLYdmXSak6rw9HLFedehHM
         lKl1FOVr4Ni5NOyIGSfYWlxRSzrfTNZck9983sSqJUsQqKA/9yvyzlt00cV0BDoc17D0
         veqA==
X-Forwarded-Encrypted: i=1; AJvYcCX/wzwULTkEdFjPItoh+YY1J3MMFGlYsc1+fUdhi34ED0PG7Bqa4coi6jkBe68GAXBpNditWsm2@vger.kernel.org, AJvYcCXJnR3Nk2Cec1VVYn7rQz8l5K6VSlyg6uZrCliRJEV2jQFXT8x9uA71Usa2u1MTQ5yfoymVsK/8vqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQBOyA61Z58SIgd2xigSWyiYawRlaFPlJPjQHUcUhGZf80AGg
	5Rt920bD5SQ3EUxg55qcav0ahdxAZn7lg5V5l6ULYninlzZJsgqhcl6ajQ==
X-Gm-Gg: ASbGncsXMEc+d3oQeM/CxaTwOcLmlj/nPxWxl3L8ypw7VmqyAXxE1TDZapTjVunV9sB
	eID6rN6MFysq8+1pMUgfSIbZoFzmvgZl9EF0qchdPpNJ3PiHkgZI5HFjkydfFBRuUQAvY9C9j/P
	YEgSv2rtwYBMEKhJgKNoPZaZZjlpJ0BmwLAWPj0rfaNyukFrU7ZE/6qQpnAMoV+P/+iWmV+8eIA
	S7yegSXuC1B1nYWE8BRZynCHXeHO1Mst6OqoL3+CN+ydDCJ3HzLQPqDimOYlxD0DBljW5SGzIuP
	xdzJcHhNSITdP2erhKIAp780UzypCjBOdCCJxykM
X-Google-Smtp-Source: AGHT+IFPRruQw4GtiAof5cXfix++wFVrArlzpdig8lOjG2DCP6NDOoXTGHN1ebuVPvzTx7lJR9wbrA==
X-Received: by 2002:a17:90b:3e89:b0:2fe:ba7f:8032 with SMTP id 98e67ed59e1d1-30aac19b5fbmr3555708a91.9.1746598434806;
        Tue, 06 May 2025 23:13:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaec2c384sm1062507a91.46.2025.05.06.23.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 23:13:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 95EC5423E4D9; Wed, 07 May 2025 13:13:51 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Subject: [PATCH 0/3] ioctl numbers list cleanup 
Date: Wed,  7 May 2025 13:13:00 +0700
Message-ID: <20250507061302.25219-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=bagasdotme@gmail.com; h=from:subject; bh=YnUsldGaNeop6ZU8a+PZWGnLxriRPuTvgJ4+EEwCDBI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlSP9iFPjnO2BCsfU49fYVZ47uriR1PlFZ3/PPyY7vVM NnrWwBPRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACaSM5vhf9zdV/NSdn0x+Ci5 4nLkwVDBuoO7VPrvrZjwddEF+xOK2y8zMry0vvp7vr9KkV+b9adMCd43Ott4RB9Wn790c+25Ezf WvmIGAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi Haren, Hi Maddy,

Here is the cleanup series following up from 03c9d1a5a30d93 ("Documentation:
Fix description format for powerpc RTAS ioctls"). The end result should be the
same as my previous fixup patch [1].

Enjoy!

[1]: https://lore.kernel.org/linuxppc-dev/20250429130524.33587-2-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  Documentation: ioctl-number: Fix linuxppc-dev mailto link
  Documentation: ioctl-number: Extend "Include File" column width
  Documentation: ioctl-number: Correct full path to
    papr-physical-attestation.h

 .../userspace-api/ioctl/ioctl-number.rst      | 512 +++++++++---------
 1 file changed, 256 insertions(+), 256 deletions(-)


base-commit: 03c9d1a5a30d93bff31b4eb0a52f030b4c7f73ea
-- 
An old man doll... just what I always wanted! - Clara


