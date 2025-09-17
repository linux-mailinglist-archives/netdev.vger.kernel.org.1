Return-Path: <netdev+bounces-224055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC605B803EF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9BA1C21329
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182201E25FA;
	Wed, 17 Sep 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOmrmV2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BF2DE707
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120462; cv=none; b=tCbZKT6XQGKa/+6adQruqH3gXketYpn4BnDTjtNboWrcuT4NhQwszt6QKDrMEDw0f1VzytDWnVg32w+Cj5RIZbjziTqA5gx3MhY/hYeEtyIQCSyzoRPJeQsi3u5LgeLXqCB0J8k6IqBpYpI/GiMPYD1XTtUL4Khu1PHLSKl+VCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120462; c=relaxed/simple;
	bh=qfM/YHmtVWu3yzoUzyK/MCLy8fZrVNf1eUAi6FFeqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCKmv21RT6D9wF3Q25l/yRepqjeGo9wDsb8S8hf56c/qx+C+ea90avgDwqpzk3MTZQBTFrE88IOlviNEvwHf31J/lriJmLnQn1Nez3eCDf8C5hn9GdVz32yyB3wcqdZZ2neocfjN8zqKtZyAfhK0yNqxxSQEJ/J8dE5qcHcfix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOmrmV2k; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea5cbca279aso318848276.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758120459; x=1758725259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CAbzYUL8MS01KvGQ7W+ucZcOWy6JzeZgcC8xTWGjlU=;
        b=YOmrmV2k77bFUKp8AdTkEAxAgCEo5gxJmz0y5fQfAIq8iqq5ZXCcE0eL0BJB9+7b9+
         FO/yDj16zz77fV+8SuNBRWYyWSyIsI9zXf+KWNJhnAudKiXPBgLqsJhplPHrq7kPKFo7
         cBAHNYFv7Z7DsvAAkeWot01QGy0RRZOkmbSKud2I98MYFm2JlXTopZ/i5oUwcDUe/NrX
         VtnDsmovQ4J6UanXqR3X8vgHs9o2hBiqADyFrOgltKRuUMQ7rd1SjOE6l/aUiyMZqW2t
         hm4qAbZZLqinQlgKExys6OFjxBjEtD990dfQFG+UN/xxQxfBz0HAOPxQyB+lF1o25AiM
         MnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120459; x=1758725259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CAbzYUL8MS01KvGQ7W+ucZcOWy6JzeZgcC8xTWGjlU=;
        b=uwZ1pqUxhQ3/fO+JtQzXrr4MBDqHZentzzGfUnJ1Dv5Z36e05eOfauPEgUzYVA3ryC
         TNTHl+Pbz9MlDtmN+zjqkH8IQDFY2Bid4qCRmub06IEnOb2QU0zzFDJewNSvxWPWnHSq
         jfP3/OqFZ1rNSmf8lKWiAG2qJeSOrYCNUczykWDzBBG3JM5vtjwNersLPhtGeJg68JdL
         m1qoSiN0K88VA5SDPmHohjlvKemWnadCCmAA5z/dRQPziA0yEX92N1lBzORY3b9/UTn/
         GXQfhqFo6cKBIfvOS0HZYXHGA1j0Rnu4n5eD8KsA9ekZpPESxa1HhFS4vtRDyxB2NrmZ
         hFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJ2qbO4qfu7WDbezm/VFs100w/IeT0tn5rA2zEx6Uh6lAEA89o7enU5mYL8oUi6NCiqFJecg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzx6JuSiflYXrS8fygVze3I/soDcTdiUniqZ/iFDKkbe61Xxs
	3MQA4EU11r7nSGHb6ueSRBgNvb20706/+DGROfbX81Cc2lxaMtlhpsyr
X-Gm-Gg: ASbGncvug7/vI6lDcn7TN1xI12R5t4LFPWVUdsJzJp7NPPSrKVgoBpe1K0Kh1yWHlxn
	m0mnd58Pb0prm5tEEolorPW9Kx1BrV5IILekk0DXrGBhU5hJjEdwP4/y4qPwqWPXbjcDW6Ty8BP
	3mLQrwh9LrMQ020bq8y6OeLaeF+dh9uHQPWKzRQNSnOCcQcww0njSLU9cMoHTQcCBTSJp7qQI3E
	hXy4VIv1/jdm75HFmuR8v9OlJrll5gTSr4EkAyfpIlPtfzuct6koe+jBKhPvXIqpZzXrZMuAoQK
	bmoHFZmTWZ8UAEcTS25t9sfT5kdDWL1BEy0e3lJO+n7BA59EFaaE/VDBzfk7Eu/TnXiKW7zWsfm
	lXLqQdh+YKzfi6A6bagyf+qGDMGEgRDsVlsw33d8AHw==
X-Google-Smtp-Source: AGHT+IFkCUo8yIzooLYfXMOUMBxzTZH14qdmK33q31MankNnsUTy2IG/YdXpSknLnQlKrcxKcNDVoQ==
X-Received: by 2002:a05:6902:2b85:b0:ea4:156d:2cab with SMTP id 3f1490d57ef6-ea5c024a104mr2411587276.0.1758120459223;
        Wed, 17 Sep 2025 07:47:39 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea576bb11absm1747671276.12.2025.09.17.07.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:47:38 -0700 (PDT)
Date: Wed, 17 Sep 2025 07:47:35 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] ptp: safely cleanup when unregistering a
 PTP clock
Message-ID: <aMrKB2qDCTXURtxj@hoboy.vegasvil.org>
References: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>

On Tue, Sep 16, 2025 at 10:35:30PM +0100, Russell King (Oracle) wrote:
> (I'm assuming drivers/ptp/ patches go via net-next as there is no
> git tree against the "PTP HARDWARE CLOCK SUPPORT" maintainers entry.)
> 
> The standard rule in the kernel for unregistering user visible devices
> is to unpublish the userspace API before doing any shutdown of the
> resources necessary for the operation of the device.
> 
> PTP has several issues in this area:
> 
> 1. ptp_clock_unregister() cancells and destroys work while the PTP
>    chardev is still published, which gives the opportunity for a
>    precisely timed user API call to cause a driver to attempt to
>    queue the aux work.
> 
> 2. PTP pins are not cleaned up - if userspace has enabled PTP pins,
>    e.g. for extts, drivers are forced to do cleanup before calling
>    ptp_clock_unregister() to stop events being forwarded into the
>    PTP layer. E.g mv88e6xxx cancells its internal tai_event_work
>    to avoid calling into the PTP clock code with a stale ptp_clock
>    pointer, but a badly timed userspace EXTTS enable will re-schedule
>    the tai_event_work.

Thanks, Russell!

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

