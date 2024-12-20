Return-Path: <netdev+bounces-153537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7179F8925
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 01:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B006F16CB6A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5FB2594B1;
	Fri, 20 Dec 2024 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKvaSeMT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C1259498
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734656292; cv=none; b=kzMf5rQxcBYQz03tmc22KFZVreNmqiZkuBk9Fc6/E6WGpv/3lDuipC9nKVjno8NiNm0hr66O8uMomUqADQ68Bhc+KKrmH7EuIQDKZIsxwT9lUebn14nKsUo0JmgtQJHoPZL6fgyT79xSAQzB5oqzLCvdsApWFBpSS5vEuderri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734656292; c=relaxed/simple;
	bh=9ygYcH4eWMfcGn6cYh2zXI6TouDtXXpqv++dKEhyJMo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ifhIWHVsZ0zXNIFS6Q82p7KQNZLYq2fSFPamUKdGWrFHv5H+lxtlAESwuoar1XMHsxa5BCWmfDvMgwdgR5iXtMhQmYNiafrSE99XaUPBIn652YMhJag5pI8vAYAoEClVIhqHtYM+qQQ8FXb01bWeGq1CkPmGCOTs20P8i7/8Mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKvaSeMT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso9595975ad.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734656290; x=1735261090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgZBjJj8vdrmEJh5aAPQ6xtnZUqt+/YhEohxYao6oNs=;
        b=mKvaSeMTi+Kxl72tkT91DyAfOgHAmVqHAX/nqe3HbRHLsJzknORYBh2acmgg5kJtDQ
         4r2bC+LA/DZyjp5dTrnooxqUaWj8YSA1TDcLQMoUeBeA8Ebg8j00A21RxugFNoBQM5WJ
         XBM5lxLY70shKJbNFdRJMfG+EZIWWZXdU8VaglHfQ7FFbWQT38y5g9UQvvhkZc/S574c
         TM55510Ejpaq40peCIEZzwQDxuaDRrdkjk/jpQ3G8AUSZApZoJZ4TGmzg7noVyNzwurv
         3ZiZ/SjSxJlsYyYNqIoPy7oJ4bZxdnteegBcKdYH9BmkX8e3/S2LMVFgqpX58oLRcOjw
         9KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734656290; x=1735261090;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgZBjJj8vdrmEJh5aAPQ6xtnZUqt+/YhEohxYao6oNs=;
        b=ZlQ6Kwim3fc8m8R2CVQsZsTROeMquh0FUKCNj918IzlcM7jjmdHya7/c0l6GkKNQIe
         TwzHDZVeExbjk4O7jrTAB8Nhd6CCS8vLnvWgrq8SwwxGzvu1RDcc9v/ovgCOeuOkbddO
         yLVI0iMweCv3KSQS+7hLgl6t/ot1tGKzkmftyY5AvaosOJlfpOofeITqqZluc0khdDe3
         02d13c70ZECXq2AGWXanEcRxJypw6e7PKHp1MrGbFTSAejaCkHtMDEIHQ1j5UKCIBoTI
         JiTAEUyX4f5jvWSBfwSnVIXP4dFUpyvpKiuvO5IWmWOtmKjAytySCP+rr9WXji4nAF7e
         q16w==
X-Forwarded-Encrypted: i=1; AJvYcCUDvnNohs+do7+kJ5R3sTWgJMxQo1vTc+NxahJ5YqMp1WXNIGnQia3MqSV4tzSRSOdC99wZN+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRq0HeKnM3aIy55n8wLBMi1yqdYjI/7tDdVaIKjNT+UcDsLmix
	kVCvO8sik3WUR0rcXT0ZnSync5A0dDdJT1DhWxoAmF/YXFJQm9ZK
X-Gm-Gg: ASbGncslNvSgnh4kfpdqd2weL9quRPKkocdPcaJ/mvoFQXV7rKm3MDYpSXKb23kvKpy
	PJpanJoiygKi1T3ftDZEL0wIAXhtXpEX3WARSwrxMXsp3U/NDXMUJDix+qA+82SCQ6ruxKfqNXn
	EtC9U9Sv39uSiw/QfIxkywdyBFieECMdRQ+q8ThwMLieEi3S0x+7VPyCN3BAXiSeVtcZjAeZw48
	viabon95O2Nk8WcT2HJVtDZAurdfZMpErtunMAKTu14bR2GdQzvYaGaZ1+fqSqcCM+VKwdckVfh
	dqVcQ9y+5cwVNFvPyw==
X-Google-Smtp-Source: AGHT+IFUJU5zaRM2h26UsFEpDaZeRiJv4hiVu3TLIM2WsDpX2iW/G91oDoD1T4en1wnx2OQ9W1iPGg==
X-Received: by 2002:a17:902:d483:b0:216:7ee9:220b with SMTP id d9443c01a7336-219e6e9e863mr11888555ad.22.1734656290596;
        Thu, 19 Dec 2024 16:58:10 -0800 (PST)
Received: from localhost (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01989sm18429975ad.239.2024.12.19.16.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 16:58:10 -0800 (PST)
Date: Fri, 20 Dec 2024 09:58:08 +0900 (JST)
Message-Id: <20241220.095808.2027516214326022178.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net, devnull+hfdevel.gmx.net@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fujita.tomonori@gmail.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241217-tn9510-v3a-v3-7-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
	<20241217-tn9510-v3a-v3-7-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 22:07:38 +0100
Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org> wrote:

> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
> of the tn40xx driver on these cards. Here, I chose the detailed definition
> with the subvendor ID similar to the QT2025 cards with the PCI-ID
> TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
> AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
> the AQ2104 is currently not supported.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/ethernet/tehuti/tn40.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

