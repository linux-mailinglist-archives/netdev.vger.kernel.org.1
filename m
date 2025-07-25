Return-Path: <netdev+bounces-209955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6819B1174D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 06:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93323A5322
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EA1AC88A;
	Fri, 25 Jul 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+xFv9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB34685
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416570; cv=none; b=EkbecF4rjIbEUCvvhfVggeNXxph5Xpo+NoDJ7aEjGdyaUl2R2ArKtRYVOsqCgZxk6YN2cZxn6sgnjs2PaB/uP4I4vYn6XrSdgCmGuOQtKnONvazHSWT+6dwlcIoqUejeDvjvxnDz1UDnK2hdzGasV0dqgD5TXHkPxiQBgHKGBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416570; c=relaxed/simple;
	bh=y9K4kPetCb8hv9kqTGjg01FVaZfY9ZbiqF79cRnqkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEQZLRhH47X7wikD3T9JDUQdlTXDJFeXeTEEqt3+TNz44Y4iThwbdpspRtt1Ci0N4ubi0TNAisSx7J89uzq2ETCd8E5Yc9qhcIOuQ9diHtud0PgY+xeaWYISWALOfmtj2x997QQFIMazPAu2sFWoDmTFUWPL8FhZsWJ0z2zYiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI+xFv9w; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70f94fe1e40so30753847b3.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 21:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753416568; x=1754021368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rF85l8wKTRESci6/gSYswq1QM/FBwarIb0qRFDz1OpY=;
        b=BI+xFv9wKQyocvaveGhoPzXMyLXdT5sIyGemRGr3cNaTv+xcpmzPzDDwaNBFhdIA/B
         nVHf9eXAL/4GtvKnCShNQEkM18PKk0mAS9sjlLOHeUHCpNDsDgiDIY6x2Yj+A8QB8gQS
         Xwv3zgl77eRZLSH6+GGm6Lzw+BYyysH/2wHn/STB2fT5rN8jgZltupNLPMgctFszu41h
         5sWeLjNs3Km37lZUCRr6q5ho7snolHLu9MEB6yCgm1DqPKqxmkJ8UCKvEmiKgwJZt2v0
         Xd/b+mZYQ6fupd7lkup69Vwg+cSwJeY7U44TpV5r33xi2VDL8iDGGzTklU08UmO73bQN
         Hkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753416568; x=1754021368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF85l8wKTRESci6/gSYswq1QM/FBwarIb0qRFDz1OpY=;
        b=d+5tGuG0gGcyJFgXGQdRVbKvfpoYZke5kkW7zNXY2SdZkd37AAKCv+Cub2OHbK+ZJg
         52bs6Aw5G5JJmVB7uzZ3ZgPEvX7psjRZUSWcCF+JrdYFLFKE1OFtoHDU9I6NJg4LJkc0
         /EpfOck+qYSWQbBoKpNqhbQbH91z4omb6TzDqRsD7O+3z6RxWsCtn7Roh+/EqH5ugwH+
         n1oMl/XMt3hJmuAKFoLp2vSBGVMtenZQpOzswT+lNP64B6LavFvjv3ONIbu2MuQKNUkf
         5YrgekzqGpdDuNjSbO3v9AF+o4/48iLpFZlnZptdO/J/X3SXN6MJuPexhWZY7dqzvu6a
         K3cA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9PWTvi5cdLDlQCVuXug875sT0ybrieaPaizgr7j26LAvONwWf/G7Pabn0PIZ5Wf0r+i7ln8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5OW2CaFLsLmkw/cqmZ0uYhNKGPuVyNUY1FKKtLt9qrwanpg1
	JBkuLWcIR5QGeI+dFJjAKXby1J2cZK3OxNLGWn4vK5VD89UqTzjgp4zy
X-Gm-Gg: ASbGncuATmLDaqu61BufAUmol0zlFqayTnmkOgDkSPrJg/wdsI17ePIBN+ZWs2Pl4dk
	34p3nyQ3GpqyIYx0e9BSsPl683MzOQ+4MxDu+lIfn1Uc31v+0tonKuO+/Oxu65HAK/r9YtNtgG2
	5p7tpWYL/KqG2pQvMq7wU7yQqy5jNlNaZoxWl6NCMgNo/u2V7OMdV5nrUCEvl2OVsZWnWhfak48
	S4iUf+N+cYj7896Oy5qrSoxPkzJX+OluKDfcaAlDCLtrRYJD71/9qasI6nWuvyoqCCVlPgwoyEd
	+/10NPSnEx9j7vCiIecbgF+HRQG8Vk4UHv7bJORQJ7BgBMHWqvjhg4F4XUt1wL3Z2llyEeKq7Fz
	0uAWX5bJDgW2atVlw1ilaSiAUL7QDraFztur29xHbbg==
X-Google-Smtp-Source: AGHT+IEP3MTZHqUH7L/PpsPgaeaPNYTDUSmqjYkcaH5y0zo292/LM24t1CEXD80F4CWIUJO3ApCGwQ==
X-Received: by 2002:a05:690c:6ac6:b0:712:c295:d012 with SMTP id 00721157ae682-719e34364f4mr6416927b3.13.1753416568204;
        Thu, 24 Jul 2025 21:09:28 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719cb7a76c7sm7016797b3.11.2025.07.24.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 21:09:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 21:09:23 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	Julien Ridoux <ridouxj@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Message-ID: <aIMDc8JC4prOmpLQ@hoboy.vegasvil.org>
References: <20250724115657.150-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724115657.150-1-darinzon@amazon.com>

On Thu, Jul 24, 2025 at 02:56:56PM +0300, David Arinzon wrote:

> The first objective focuses on the use case where the PHC device
> is fully managed. The ENA driver, for example, exposes a PHC
> device, whose synchronization status and quality is maintained
> without any user-space application. This new ioctl reports on the
> clock accuracy and status of the PHC device to user-space
> applications, where ptp4l and similar are not available.

This seems pretty rare.  I can't think of any other hardware that
makes claims about synchronization quality.

So this ioctl would be just for one device.

Thanks,
Richard

