Return-Path: <netdev+bounces-225707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B47B975E1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED8D420B20
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8F23FC41;
	Tue, 23 Sep 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLS/7CJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74DE27B4E5
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656181; cv=none; b=qJQsMpHt2i2+txpdZd7WuTmuF9yrM9AaNLeE8gw69bnF6bpPHSSGweqIwGasIVraHuQ0/5XKLIIsCaUeQjjdrqpAXpcoVHng8AQv0OYxVm2xxUmK6CuUCGgMW7iqy0Z3HKJfys4JampeZRCd0AF4xGd9MtOypsx1tHvFhcpjWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656181; c=relaxed/simple;
	bh=c3tHz3xkrAjXnLneXRnB/HG4W7YEuKrsOFMkwG9NOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgx6y95kfndJOIdKah22iPiVeBxfq3n2H2Zqd2gn8UYgVt4zMEUeGXxE83kStscSrpsAS0xN+f1uJyEB8DW9TrkfSFRT8bhV1MGhbOPHxxkzIfNwRI5gQQ+FDHp5hddiOG9rG0uyTSuYP1cyr7Qk/ER4XEIsy/JmaNT8qQxZtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLS/7CJ2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so2968099f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656178; x=1759260978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=dLS/7CJ2LKQZDa1BZFXiEuPRhxeXqgefHMgC9HFrxaHtxm22GjakbXqbw4VtOO8kUH
         CmIs5L8RkDCy2fQS9nrCpeVTtsp3OpZjHll4shDweygfAt7/Zh9tYYGePJJp5oC4xVyf
         sQrBEbxvOZif7EzPF+aWRenIDlfU1wOlPsnvOlQf7q8CGjAQUacDQ5QLva1UcPn4n8Sa
         evpWJajmQMyXr3Kw0C+VKRgAJ9wqHQ/xrmCl/ENFvhdcih036ryFD2hb85ZUiXb0Xo90
         g8gIOsCRSCsqYxqH0OW8uHzJFsl40J4b+rwiVPuvaCIUDzqdTQzBisUz0CmnX1V3ddVg
         F0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656178; x=1759260978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=L6aVRuFQuH2USfSikOZ4Cdupc/EzGWTwOgppWIPNBN3QcU86w6mrpQoNY/CNZu06DP
         5/ZYeiXwvteGS3YzzK62NnDRLWgYko5tnBW7vNHS6EanHxJYxd5924GnfgHSl1QV8E+Z
         dbXH54N0BWNq3t9GRxhnn+ZpL2kYzTUee0/m+FSRTNZ2Y1asNI//Qm7ZGCSeC80DUS5O
         m7dZ6kYFWZC8xE2Ks4Y04fJGkdfxxdUf9+7eMzB2M704lMSiNiGLoZ+buFRUN1daV/dG
         ihYbVnu9Oo+Sw7kFfQCYiChibXF5KmMccmAgo3iU0Asw2cQfFEJfAYgtTzLzwDFOblOE
         Rzhg==
X-Forwarded-Encrypted: i=1; AJvYcCV01xxH3A5gGiu7rkaJNmBAziWligG5Ma1UXcSk3xy+33LZjZFP44BSfCMtdn7VBkw97OzoKx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdikZ5pd6CDTX4YhvqK04I0yC9eWnRZXgOEez2NRr6W/lWl6pg
	xLrwfTyC5qXyTWJu0HZ5ReQdojtwX8yShIBdatfhq4Nr/sFPEFNwAuis
X-Gm-Gg: ASbGncuQSFh/0StOILeNB/VGXuB9Kp8cV6q4jwYlr574RtB23bYjBNoEejTEE3ylfo/
	Gv4qLpbP6Nom2jqaNfmOM+24BuUoQR1E/yMka0AcaiE6VIT61aTr/KIdKLADApuqvUcfuFnHkHh
	kmDb1Itd/5fLqMjOyMvZlwm4iEMBzzOJtAn1UI+kHpJgBKgQ0dzm0sKc/XetdyRKyCTB02B2knF
	+uCFlZR9mjINXYbgM5yCgEBJt/5sk7SR6A8XA3pB5EOWz3YzuK2598ml19g0V0trEd7H77jshsb
	rTVE77keA7dkHF4NPXYRlcRkOHTkwOPJcIMnyEqPSGse0EeVUG8gmUiKbtz6TqOcAcNv8vDcWVs
	e4SjlnK1mGTLgC95WIeo=
X-Google-Smtp-Source: AGHT+IG6c6liV4ES0cNIrz92wbRM89A4so/bGcUTAzztWwZQiXZipp0oMWflG0SI8mHTbJhLxZ8nGg==
X-Received: by 2002:a05:6000:615:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-405c5cccfbemr2973528f8f.16.1758656177916;
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm25526397f8f.60.2025.09.23.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:36:15 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <fasu2sp2g65b4kslaj4khckmjhaocqqbloqraaqhzmuvdotjvl@swdgrbci7jft>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <20250922165057.70eefc6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922165057.70eefc6b@kernel.org>

Hi Jakub,

On Mon, Sep 22, 2025 at 04:50:57PM -0700, Jakub Kicinski wrote:
> This gets hit in the selftest you're adding so please triple check 
> the kernel config that you're testing with.

Sorry for the silly mistake. I'll make sure to adjust my local testing to
include running all selftests with kernel/configs/debug.config to catch these
before sending the patches.

