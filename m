Return-Path: <netdev+bounces-104662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FA90DE12
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA881F24984
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AA81779A4;
	Tue, 18 Jun 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wlmvvA6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E1741C7
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745575; cv=none; b=Ekh9kF/7BdCQjdUQ8cko3uAxAEputd0luco9kP57V5Vdk4td3q+KvqUuXQZKWwBGsMrgQw53Xa/iqxbaL7P7hDeMC3SuxiZHDOC7gWg/ZB5TJmcSmE58wg7y4cE0QrlU5nFSTAxYPm3zojiVT+5YrQjipk3fwSbFk/CGU+PS19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745575; c=relaxed/simple;
	bh=OmfcprcSrUb+Cz3hA2CEgypCro4sSFG4VGiwa764RG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbLSfmK261sTLxQbOGjYCBkbe3kUhsZx1yGQgPRuWaspemfdAbd+V/X/4mmzoWaqcNacJsV+923cVopYuHrizygy9edt3y+8ltd9gmsnkbs/Erj/2HDnEe7Nha8myTcJpc0fhF6GbRMRMf+WuwnPJZDfbl6xiC83vGG5EZYvSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wlmvvA6B; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-705fff50de2so171837b3a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718745573; x=1719350373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBOXu3AX8iawimeoI7cVv0ed5p6W28OLisBmj7DoqVw=;
        b=wlmvvA6BvEqyuuBoqUKOoJyj4PwPrQFUKWUY5IQnA6vyE+rc+I+4L8TXE9roOC9KNq
         2eJymBdop86ofjXk1IE38F6oSjUq+md1puHObDGI+MdxqRU5nQEp6UW9rX5M4v5LYOT0
         pSsjmDtQtKue4APmmOpq7EVYrK7dgK7bW7DwGXZT4qd9SKkorJbdJblZzs48AEgKYhu2
         wwpOPKhS+7Qbeg9aXb9GkAUJGL/lToe0/kw7SPHkL2nib6Mz2OTynozca04+VvrAakBW
         1lCILexuJFfGDD51T8KhsaBdHcnhkLg6pxMr5BWv8W4jefX10WrDxiM+U74GfJTXEzpa
         TEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745573; x=1719350373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBOXu3AX8iawimeoI7cVv0ed5p6W28OLisBmj7DoqVw=;
        b=DQbNaMuIHNdpU+EYKgxErwJ9Xz2AAJvAhAqe5FI443lj17jzvMR/9dotvlbgTSz7jo
         8GEuxvX++/FvcpuN8ryP95Dbay/MHgokd/2123Yd4bXVZ5kD+roiMl5o9kxlRxi94voW
         nQn3Z/Fh6PRB34GY36uJ54rZfRbnXLOVwlpsgYjc+JbATUYwfudYHE+36QfGAb8a5X3Z
         Ex0auf1wFVS3EEki+gH+wo3Sln+qvZn3fSVEKfRNS0Gr0bO5xwAF/pC7fwGcD3dtA1kN
         j8awst7fLWQ2d2RhLFlAsIDhNW5qAgAoe3KQsaCT4P1m7ZLgUO+ghXtH/1w9DyH02nkq
         uMew==
X-Forwarded-Encrypted: i=1; AJvYcCUT3H04jGw+4oMzoaKwEX/M/O4Iy9IcAF66YrPrVyWR/E/us7wFbpYYBQdacpT82ooVXBp4mPNB+nprhN4u34S5jNY59cb5
X-Gm-Message-State: AOJu0YytNc9HxHqYEwVfu38bEAjjW1gOqcCpkG/CRV/yVLqGwlupdcDE
	KbTP0D6eRZXBuYn5htWQbcrU1EEyLpMnwg5XdegeVShgBgUzOaICnfs3+cwYFyg=
X-Google-Smtp-Source: AGHT+IEDJdHgqhnpdjG6jF8Kggw629x32bz6eKrC/MAgTBCxU/oW9mH69BRNudTCCPM3Uu+J0MTMjg==
X-Received: by 2002:a05:6a20:3c8a:b0:1b4:b9f0:ffc4 with SMTP id adf61e73a8af0-1bcab0528d7mr5844124637.18.1718745573134;
        Tue, 18 Jun 2024 14:19:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-710744224c4sm390475a12.66.2024.06.18.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:19:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:19:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Joe Damato <jdamato@fastly.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "ogabbay@kernel.org"
 <ogabbay@kernel.org>, Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240618141924.5a62a3d8@hermes.local>
In-Reply-To: <16369c7d-af15-4959-9e84-8a495b6b5035@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
	<ZmzIy3c0j8ubspIM@LQ3V64L9R2>
	<16369c7d-af15-4959-9e84-8a495b6b5035@habana.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 19:37:36 +0000
Omer Shpigelman <oshpigelman@habana.ai> wrote:

> > 
> > Is there any reason in particular to call netif_receive_skb instead of
> > napi_gro_receive ?
> >   
> 
> As you can see, we also support polling mode which is a non-NAPI flow.
> We could use napi_gro_receive() for NAPI flow and netif_receive_skb() for
> polling mode but we don't support RX checksum offload anyway.

 Why non-NAPI? I thought current netdev policy was all drivers should
use NAPI.

