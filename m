Return-Path: <netdev+bounces-75731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA986B00C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2794D1F2137F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2D149E0B;
	Wed, 28 Feb 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uqK1EiTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591A14691C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125944; cv=none; b=jyqqXO/R6RBVHmP5PkGF5oclcT6fUk+7RfdRTRuY7PhJn5+n1/0KMv9K/iechiPMZiND6ZOPH+vuy1HEcRjqNQNfM3Az2GwmsmCHNsdmNUeUlPpCSVXAQhsjVD8tIAWrosEJmdzaXGH8WaalfM/9J6uI005bZQwB19pWcUc8oMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125944; c=relaxed/simple;
	bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGCOLskSXt6uKCsEwGN+2dAPKqQzzW84h7snQXAcs2wTi4BPjG1bini2mJNyYM+UJGwjOB9gvHXln40ahRQxU0dPxkuJTwCcDI+VKltB5+zTzYsYBP6s0QOCrWbg64MabKquU9O27bpkXZh6pFPygvBUSHbUOZ1CZqUHWoTOQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uqK1EiTh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412aec2505dso12184765e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125941; x=1709730741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=uqK1EiTh3xel+0qm7EhNE1wrmPIkHwBuvsPN9ed1KKFieLgrMMcj875f6MPNHStiO3
         5/tgtrcsgWS/1QpPJATY+kIh/6WGvKESqnCypzvq3Hf6u6bbQ+SwBAJ0svB4wq0CGoIs
         JidN1OVsX66nsMI5C/qbqXNzYTz+/RrryIDTbYsg1Tp4PwvLQRfz4LWtaSE25nARWCL4
         0HZSJmDLBaXpTd3akC45U1hXQB5dOGfNIuD7F03HDO60NSsCynekGmd88OfZplUsc7Y8
         4RGWr3cAKne7MCn+dQhT62U5z72CHmXK/58lqkVebazcJij2xNhxnQOQOHIWDmknXI+M
         QAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125941; x=1709730741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=Myx7ARsGBaPyMLnrkxtojIbLvF77iplwjPxP6262mEGrwF0/ipYXk2T9J986JeNcvb
         jYt/d5KxnUoRVcbTh4f7z5GzYlGIznwVhHwi+K0Y8taeUUvO87P9KbxKZgjaHzDIDkym
         qps8zOm4hLSqyKXSqc9r9YjkebudMJ/++yQ1KjNiwpUNTRV4Lw4kPZZcL6l3N8taLEhv
         zf7nKULO/gIF7+kCPJFddpWYIowhv+97wSM+Js9Ptxy0vFrLexHEJmCqqvtIvydnoctV
         K45Be0FSU65FHQFHIBS5BKKMHb4H0JeC8KtNkrn8qbUaZOVpO5uouYc+/RP3MGCxJxUk
         Zn9w==
X-Forwarded-Encrypted: i=1; AJvYcCUYh5gs6ztrJriTMpf4QLNRWMj2qOQYbaEeE3LPIMpJ98e2OZoBYc7vAxa5sN4Q4tZb7rT7IOuYumR7/2qO6+FkGCF09tvJ
X-Gm-Message-State: AOJu0YxBtMdPyQuismBTMav5v9ADCBAxVfNlRP5McjCbitA+0YYswF3X
	RF8SeaXn63z73uddG1kaIVHtaepZ03uHsRx8WVxfcau5cqxXeVu0+9tC5f64xj8=
X-Google-Smtp-Source: AGHT+IEm2GPfTV3ssQeU4XVkZjEXwj0yIajzxFEe5Z89HZRUR1knrmaQTBO7zoB7PCjicKbgFQLtoA==
X-Received: by 2002:a5d:698f:0:b0:33d:2d07:b567 with SMTP id g15-20020a5d698f000000b0033d2d07b567mr9499056wru.24.1709125941487;
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm11954467wrb.68.2024.02.28.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Date: Wed, 28 Feb 2024 14:12:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8xMsNFaF6ZE5AS@nanopsycho>
References: <20240228120701.422264-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228120701.422264-1-pvkumar5749404@gmail.com>

Again, you sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

Could you please avoid duplicates like this? Also, note there is 24h
rule not to repost the same patch. Could you please read:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

