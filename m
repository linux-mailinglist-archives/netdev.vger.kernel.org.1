Return-Path: <netdev+bounces-221382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94DB505F6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2392B3B136D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECF303A22;
	Tue,  9 Sep 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP4SXPpV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528C303A09
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445260; cv=none; b=s0byJR7dRvdqqfCrPds3ZFuiOAsT5N1/aftItYtfwhD6tZr4bOLcVhQnGuvzZdBr2f3F0+mRf5vOmZp3pWBtPMARRpFoqy746lrlMyWCe8C7Mk0SR9Uy+7cj9ET5oLr95bfnpv8sjiyJz0waRtJ7ldnzjXua9Lh4mpUKrXh6gV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445260; c=relaxed/simple;
	bh=t/uQhL3RN2wW+hQA/fY5YP0hjzpGhCWqmvcXy0YhTqQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ug0neK1lID9fp+rxSLNTN2tD9SYfUy+awkyK7qkpxVo5kjQr3Ru4Pj4X5ut/TMH/GelifK8tGnXemk+e7wDBcXdLlQGrYrtTovtBjRokblbX6jAV/gHn6lKZQhfN83jfOsm45dygP1rzNEyl3ymQZYDTjc1JA7JR70mF0jySorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP4SXPpV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d44d734cabso4231518f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445257; x=1758050057; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeiuuWlOocElFkWVId2pG7XzczbitmPdfhUBpL6KXZk=;
        b=eP4SXPpVEWKiaR6O/FMt7ruaDEdN24f7Ab7bF9OUb/m21b9Hw9d431+Re3x4Jn/AwN
         ro08wHYtWPis9YVG0/pMdjA5dSLyLCgQAxBjucFfHG3vlvM75evxHmlTaQvFlE635raf
         yjAiiO1vBaVHIFL6/GUzSAnSMiRX67Jd7j5R7w0cPJ/8ykasFMoZ5SCbFQBbKNaEGFnC
         5Q9IgSgcazPnhd5vQNTeWO6BWcBvKN6/vADzbFnejKCXG6UfZMidP1pnvPGp+SL0a7Fq
         8uC7syfnBlnawkm9of5/PbRJLdoZ4YWCQdAe218ULtU1UUxzL29cDPWLtWl0pv0bLmYf
         qMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445257; x=1758050057;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeiuuWlOocElFkWVId2pG7XzczbitmPdfhUBpL6KXZk=;
        b=wS/r1UPCOVJbfFejhxIEGukcXtyhKQda1FmM82k9Ke/NYDnwjAE5Xj3+AJpzYx0Z7T
         NAE0M8ezhEUfWGCuraRxx5vlai7dGN24VWpr57VmhrzyGybHNRP19tRSNEa8yQva+vm1
         F9Qm/+SKHy1IUxJHvWQQtL/fnjuVFHYOiqPGWRobpRdpYG53bqd74cjdJktaWFHoT0qs
         oJ2siR7t33ZuTPVnWcnV6Wen20MQ2vYlvcafoYSvAVdejfvXyuncBL3H2qTa4yf4RqQp
         MoKkIz7GBFZYhAptup7dDnpNvJnd/tP1HO3QC5V+bV+4FWhorAxMUqNMp30fP031nUsG
         0E7A==
X-Gm-Message-State: AOJu0Yx6njxITkDzZNfbpywhFPFRM7yyeNdf2GKM1Yw8h3N/30nCn4l5
	dDldUge/VLg8242eDBp1ZsqgmazYgx0katfhmRAr3FZbVMgp8rkNLEqu
X-Gm-Gg: ASbGncveSZ0vju5a02nUNqbiLYcqH8fQZ7Arg6mhwnylDxLq4ApBw9thrUW7QtxxMK2
	KsZ1rSOClpKN7hsYU+0Ue808Rmyr/w4tAFfS3MlZbF+/JHrXNjdQSWupAhNb7SfePueAfC8w0bf
	cK75UM3PWxpJsv9A5yIWrmCSo+vxjhaLBK5r3k9yvmMergGfl8wFh/0YPUATwyKd7ajdiLejU0b
	YlNxZ6fn1IxQ0Q16wZ2cJ1mksxTScYuvCYxNrLYa6gkR0Efl5+UTh4wJsCdAx7KT7R3oaWQtxis
	zCoHY0FogcL7/pJRn1oLG6tNwRY8gqS9DuwC35WIRuIwaydwQjl7ZSROXro19uBgCVu127DtDWg
	Q/VXqhZX5xo8QstcUdpwnLMRw3TWg/iSTL87kIVODsdnaCDvbDleyLZiMFugpqFoz9ehxYJK+Ni
	RYpAQrOlNswfsV75Ol7yJXIwmXHEVf2Is/FQpqc0N3DeaIhCx46lmh+QDbRFWfSMMapo59x4So
X-Google-Smtp-Source: AGHT+IERvgimDEIahU9n68q4Abx0xQKqcXYLRkk0Qoe1c0XK+cPd1g6F2Z2mM482GFC6VWOPYdyQhg==
X-Received: by 2002:a05:6000:2182:b0:3e7:462f:ef7c with SMTP id ffacd0b85a97d-3e7462ff4e9mr5152326f8f.7.1757445257351;
        Tue, 09 Sep 2025 12:14:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f16:4400:58f9:791b:ab22:addb? (p200300ea8f16440058f9791bab22addb.dip0.t-ipconnect.de. [2003:ea:8f16:4400:58f9:791b:ab22:addb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e75223f3e2sm3836037f8f.44.2025.09.09.12.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:14:16 -0700 (PDT)
Message-ID: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
Date: Tue, 9 Sep 2025 21:14:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: print warning if usage of deprecated
 array-style fixed-link binding is detected
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

Heiner Kallweit (2):
  of: mdio: warn if deprecated fixed-link binding is used
  net: phylink: warn if deprecated array-style fixed-link binding is
    used

 drivers/net/mdio/of_mdio.c | 2 ++
 drivers/net/phy/phylink.c  | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.51.0


