Return-Path: <netdev+bounces-163978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE985A2C379
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9D516A184
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8651E7C37;
	Fri,  7 Feb 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="G8Rlgpde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB101A5BB1
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934786; cv=none; b=nowQLVDDprrLsgnOlpyg0SUZE3BVJvUYjtsxLHb6PtUmfSMCKHAelL3IzWLoBAK9EQqWgrVS0fdnArOLeLUUZqp8hUVyYKdoKTPzX+tcp5tKih7eAOB2O7sPFsHkbqErqxIjw6UJuSQ8EwEVwlVGlzxI/14QezW5uZtwHS3I61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934786; c=relaxed/simple;
	bh=a0CRtm9KIAti5E0WSV0mfJdMV2x2rgx92X7qkdMqDXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM92XusbutQCP9LKuCC0q3JJsh88G64MsQQ+l3FkPb1fiEdVpV8Ao2ebYOAQi5rtwat/3D/UoDkDZq7+OJYNnCmBHsFgpjvLRJyvUBa9oMX4nmJZegMpKpiafsKmAHEIiuMm1eWGTEX2fhukBVMjY4vJ3p0U+OFSm0mnIfQXLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=G8Rlgpde; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f50895565so10208375ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738934783; x=1739539583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35QjS2mTIYO+gJZIHE49mfSaBK9urZetBSEHinYZAYQ=;
        b=G8RlgpdecQbDJ5HDX4uFNk6EdFOgd8pOux6q6OsGBpjUAWTYNoV+qizdq5qAur+yMH
         TZGf1OTvurUZeMre5tUq4RILgrhi9laBZxhlzBw1w92zGc3uWrJIJ2Xb3Xfz8N50n/JA
         XWOW4x3jFEglY6+4M7INbFibEZ5Eohbb2xxNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738934783; x=1739539583;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35QjS2mTIYO+gJZIHE49mfSaBK9urZetBSEHinYZAYQ=;
        b=YohGO6rM829zdDHQEXVsek7almZDx/h18YvuDdYAHVD5ahPaEtcgka7bvzUGJTw66s
         117d0wBdBkHjnWJCTZ7mRkqcJy+y1yl6Tc9hUSk3KUhD9oCA5hSEVlMJDbHJdo0odSXq
         paRz5X8vOF+5T20Bdfon6jV4MCGAfTvRFsRvjZu4DBZtSdC2Yq4MS7T6bvVlakqeEzVp
         +RmbuMEgwFi45/Bldeo4vNSQZzNigWU5JwUyLf/8mwddx11sZgUgcn12e1qvf1Nuu8tS
         ZfAeiMSzD6I4IaRvIzHmAkavAjCcmEMh96Xt+43wSAAMPjBfRWE210COiK6aywz3H7DU
         BsJw==
X-Forwarded-Encrypted: i=1; AJvYcCWEx/YTxbIDnp14vPhUoqwkz1v49sWwVmjXiAOSGPDX3MUcxdT1iX6pge6MunyQUlb5V3jixqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZE/o/tGoHpDOKDAhUoZOrafMXXDVwnuOCBa9DXDV6+6y45Ei7
	CwVg959cN0iXj0g9wLE9KfiescjS9NMIZ4cN+JQcWbAKlE1F6+hTM9HDmUYj2SznNK10jtCa7t2
	O
X-Gm-Gg: ASbGnct+Yec5cVjbyotz2zWbr6RYgcsahMOWCaMTZL8cacUVL8ydDvnmd5K4Y25kMia
	2N+H0KzqvnJD8vNFFk2D/mKRnq3BaGcsL/pRsSiWSKLJh907/6rS442EKcKco3k+RqyOw1wsVG/
	6+Fq2tkMi4XBYAY9gxFiV0AMGXXHIIbPICfDrBsdRGGzqmDORrdqDSF8X2DeYA/JTUlY+nkoXS3
	xuedqPYpgJazjgf4bdDfGhRQmxTHOzv6gMr74Eu6tw8eZPwWyIXMLA0Im5zhvwf4yxl5x9RDGJP
	oIsbDT3AB3DSJm3c1xj5ZRiWwEw488LsUMiB5KMCo6grLTi2ex7fqA0GAQ==
X-Google-Smtp-Source: AGHT+IGiKFyaTw/aK5AthVDYdZM7IzbZscYSuVsAYH2PMD0dc+PpHEArHTZi0M1IUfMhDs+Y9G+A/w==
X-Received: by 2002:a17:902:f786:b0:216:410d:4c53 with SMTP id d9443c01a7336-21f4e74480emr55611145ad.41.1738934783432;
        Fri, 07 Feb 2025 05:26:23 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d6e5sm30154055ad.141.2025.02.07.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:26:23 -0800 (PST)
Date: Fri, 7 Feb 2025 05:26:20 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: igb: XDP/ZC busy polling
Message-ID: <Z6YJ_LUD5Gpyb-at@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
References: <871pwa6tf2.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pwa6tf2.fsf@kurt.kurt.home>

On Fri, Feb 07, 2025 at 09:38:41AM +0100, Kurt Kanzenbach wrote:
> Hello Joe,
> 
> I noticed that XDP/ZC busy polling does not work anymore in combination
> with igb driver. This seems to be related to commit 5ef44b3cb43b ("xsk:
> Bring back busy polling support") which relies on
> netif_queue_set_napi().
> 
> I see you implemented it for e1000, igc and so on. However, igb is
> missing. Do you have any plans to add the missing registration to igb?
> Just asking. Otherwise, I can send a patch for it.

Please feel free; I don't have an igb device so I wouldn't be able
to test it, but I'd happily review it so please CC me.

BTW, I wrote a small series that updates the documentation and adds
a test for AF_XDP [1] that you may want to consider applying/running
(if it is not merged by the time you add support to igb).

[1]: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/

