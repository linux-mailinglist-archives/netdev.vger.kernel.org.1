Return-Path: <netdev+bounces-134154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9AF998314
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5091C20C31
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57201B5EBC;
	Thu, 10 Oct 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AgNYZ2gp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935336D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554544; cv=none; b=exaikVlS+T6B0jliq9MhuMyXlKNG8w3f3Y9+Fy5Es0qpWwqMr6fI9WEouxyWJC1gDHPqTy/pW0pErTWHs/iBTJXrfGuwk59iiqS4kamL6AOMlx+6kBHf9JnLzQJAL32oBgSozNMPK9DIU7LYQZ+mwJ2e0LidlwMv5V367ojAyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554544; c=relaxed/simple;
	bh=WQDHxZ7RHNen+dXXq4rUaV5GIwNJxL1zv0834g9lGnk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N4XwPeW16p0lGYrGqmqBcWhFK5T1LFGVjANlR8HVPaUDmwPUzlTseQgc/OyCTdR197A3WV639CeK/y9MQhT//qNZazAn8rIVrY2CO1ERyy0Ga8wisZ88ia24wqv1+B8iAWQTTQ8ZRW26+bVuT6BuPMB3pX4jYy4jfBsQPFpiy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AgNYZ2gp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99422c796eso120975366b.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728554541; x=1729159341; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvnmMOFHMe+zdVmNJD1qBWqBU85ku4l7ssqzVIeTx/g=;
        b=AgNYZ2gpg4uw9+j7XXcQJfievjd4oMeZtAQEpFDE8+cR5pMqIyTtg9j7ctNtpqbuKQ
         AcMsEgdQgCnfJT2jfIpTxv3qZFm9MTPeQ7Mn/LypiNwWHHZLXJ/V+Pmt9SFPMDSP8Gdh
         v3Yy1yUGTZTn014PZDBoQK7ct2SJPQ2PN1+oF/CbMrj1sMVZKxq3P6QYpzHutJKdZMrT
         fEDHusYffEhfxgQcYS38mRbt2pIPX2uQC7zGXdCf/fIeQqVrdA6504ft+j8CASUM3SW4
         eR6GrDonGVc/G7r4ku4KiGNhr6JJhtKGL8ZbIe5WUKv8M2y5FgOfolBigMzyhHGb9fmh
         CAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554541; x=1729159341;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JvnmMOFHMe+zdVmNJD1qBWqBU85ku4l7ssqzVIeTx/g=;
        b=P+dcrlDM73BgqYMnM/VGURXus8Jy74Dd3PyxnU0WOZdx10ypvGFTa4S+eOwY2aybMT
         mfVVp4tkRMOIOB3hdVHd1vhwm8rl9dj6ioSSmg9DANfyw5ubBqSPOPcCkA3a7g5hxwoP
         qf2Ygh8IWJrxYxjnEAeHdcq9u+P9QIc+0tdlG5K6vH6vw0nOi8Fm2LiV4F7h7QV69pHI
         eEzuk4+FvjxtcfcrDFpV6xj83PKoNzAJAre5o7hJwi6ogfVG/PIoBtjXyJrJWe2rz8VU
         k34AuCCTLfzMXMvEnMJXZjicwNjNH9qIElC4wfevMk01ZJ/pK/wvwnyiT38hy01trRUz
         vCOQ==
X-Gm-Message-State: AOJu0YycTYfOcsujs6MgYQXcrjeuG6SB0GIHVJgIrchK5lo2cLQTTmI0
	xp7TRaJhnKL1k3FOOKtErPkRurw0ormwhJe+6IYxmhw359t0KigYoT+N321ufxN3+8RcTGx1xrp
	/
X-Google-Smtp-Source: AGHT+IEanaG3pcwDMgOHpC1UpmuABTR4yXkBEoAA6GCNBLbxVuu3r2UYsZprhdcvXSboeINBdDHoTA==
X-Received: by 2002:a17:907:7f88:b0:a99:3ebf:9371 with SMTP id a640c23a62f3a-a999e8f483fmr294050466b.59.1728554540669;
        Thu, 10 Oct 2024 03:02:20 -0700 (PDT)
Received: from ?IPV6:2a02:3033:208:98c0:9268:c8b7:179:fe6c? ([2a02:3033:208:98c0:9268:c8b7:179:fe6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2737sm65558666b.217.2024.10.10.03.02.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:02:20 -0700 (PDT)
Message-ID: <f6680332-ab58-4c48-9169-4dd701930e5f@suse.com>
Date: Thu, 10 Oct 2024 12:02:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: question on IFF_NOARP and NET_ADDR_RANDOM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

looking at usbnet a question arose.
If a device presents IFF_NOARP to user space and does not
come with its own MAC, as one would expect. Should usbnet
provide a random address, which would set NET_ADDR_RANDOM?

	Regards
		Oliver

