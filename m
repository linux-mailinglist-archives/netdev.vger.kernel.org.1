Return-Path: <netdev+bounces-219822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867DB43276
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233683A72EE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9D275AE9;
	Thu,  4 Sep 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ekejYrX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404372750E6
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967702; cv=none; b=gMtHgmSq/nDXulBj5k892OE5rMBV3Rh6KYM+svyI9GrBKVEA9RuPLbo7riVPo0JBs4xVusa8B8mkS4bs4a1rUGX/vESbWu33Cs1wni5QfBp7qR4wOcyR10xw4FGg5s3tS0lftF7WV+WawdJtIKIqwdbRRSzahC6qeMeHuwZt95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967702; c=relaxed/simple;
	bh=EF1d9d6TM/5WixDRVpoLI/2mZi8oaT+MyfzNnMPvcno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkMC/FFlI2BkUyq3soCTWDMzYo8q3dxqagSPDxsxjefMyG9M79ZXy0pZ/MNQAwYIWoFv4TZR7didWic2BbXS2vOjouVHToyCyNuKUYeT+3uln9wqIZZWW8xLhHW03dmr7soO4TYY+m5C+W0t3pqfz1VgVilnsGaVJ+ItIHIG5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ekejYrX4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so2520155e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756967698; x=1757572498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ3Gc/O+sD8twCNzZA1nv6UYXB4RvutwP3PJpU6jpms=;
        b=ekejYrX4pecdMrGRxwxkSMrAgrFko81B47NfH763XKEyUxgNCyaKiKSbTRnUgh1nLM
         UWYcJpZ2dUtpCHjCpTcLymFktsueQ+neHGPSWjw6NXvFYnhIXAvqF56mf9dMk/pl41Dx
         XVu1PqOOj5AWC8OLf0Inf/dtWHfazPdXgHyo79rMsCPLcj7NLHwSnPvbAlto8aVRFIiJ
         /wlfHiOfKhAEQCwRfz6We92lloPUa7Sm0D8KB+WTu9PEAoBe7wkAargQI1SfKPjz+TsC
         1xWO4ni1cNagtEeuOzP2Lezs39RDhH98TOGO1ZORoHME5jEeHdXSL6seyduYgWqyuKxd
         QScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967698; x=1757572498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ3Gc/O+sD8twCNzZA1nv6UYXB4RvutwP3PJpU6jpms=;
        b=WDrCamnf5fTE3SoyNkmwtm2I5IFBgZTD9fxZAPTLrcMyEow95pkPAkK+lZrYYNSu73
         SpDBsqkwiX6rqoYT27oonWqssYUQueCFCQQO4MkkNWlcuQ9UeCYzRiet//XtlgxX3IWc
         ICur1KjTGr0bd546/5FidUfAs5b63H8ppne73e97RBr0MFwRUmgVmxzLdorS0ymHmZq1
         IjZ9vO/adnAKMKVYeUX/+NKBluTiE7wD5/ofTCcnke2+FE+KgMv7WV59S+PK+nbpK/hY
         xYa38+vdcV3h7qQ1h+GvB+fU0RMzcB4Ig0W9cb/YEvjTbJGVfoGEw7or6FPGYSSXjhQ0
         yRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZggQPJNV2wXj39y24CyOT+aEevR05ze2OTSlH6DbX0zcLfRIKmczUcIxTY2/kyfYGZ48KS/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dNMQxNDSaTiGnhhrfcHnSm6GtSZMMHXJ6RDIYybXqrdhB4Mo
	ktZ4/vVdOodcfnua+YSaBg4mxGgjD5VKwU+FSOhOTbxLb4X87S17hJdMuAT3B0tnSSI=
X-Gm-Gg: ASbGncvDXv3ms7OI/JJVYyeIMiu8sAUN/P5DP3L7ffsFPL9DuklKQ0a9uN/ECWOYrWY
	1LJUiB8yiRYV8wz7nlXfVgXb4PbRCGY/+TiW9+TPB298U7sZRNrE2bA359l6hBh7f5qW8TLWFjj
	lTIcdZyVYGz1bIpRlUawhKFpX0g9SdUMn5tfJ6c07L0qDPMKXifoFDBKvz3OFguCnqBrOzIBnhM
	lS6wzliqWBlcDnVAt4ptTlGmZwhPp7QulLzkwYh+m+1mqwdLpm8zDRhZ+oPr/RO/usQwZz6GU6G
	aA1fkGs3qlvrjm2Szbe89+RR0WN/8e7f2NHawwkCYrv7BOd2iClHggfy6xJIRrxhBDOSvVjkPyg
	B8vldM1oD1jD1YKcSK4QSSOERvzDi8NrZpO+iPj9xiXudtzNA1mckzw==
X-Google-Smtp-Source: AGHT+IHrCWv5mgqi9YiX+c+MNqNC7162B9DkMT4OdgROL1wmk5ec8Z4tHuuSyn2qqCkckUPvPlsj4Q==
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45b855983cfmr129194505e9.27.1756967698452;
        Wed, 03 Sep 2025 23:34:58 -0700 (PDT)
Received: from localhost (93-46-179-206.ip108.fastwebnet.it. [93.46.179.206])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dcfa3ec60sm23305275e9.15.2025.09.03.23.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:34:57 -0700 (PDT)
Date: Thu, 4 Sep 2025 07:34:56 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
Message-ID: <20250904063456.GB2144@cmpxchg.org>
References: <20250903190238.2511885-1-kuniyu@google.com>
 <20250903190238.2511885-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903190238.2511885-5-kuniyu@google.com>

On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes not
> controlled by memcg lose the seatbelt and can consume memory up to
> the global limit, becoming noisy neighbour.

It's been repeatedly pointed out to you that this container
configuration is not, and cannot be, supported. Processes not
controlled by memcg have many avenues to become noisy neighbors in a
multi-tenant system.

So my NAK still applies. Please carry this forward in all future patch
submissions even if your implementation changes.

