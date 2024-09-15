Return-Path: <netdev+bounces-128378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B6979417
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201B01F23277
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93666946F;
	Sun, 15 Sep 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mq0+5bfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F91946C
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363172; cv=none; b=hZaFA3JZylIER3HdmOi3zl5AwjrK1GvlvTu6XYN9dbMUi1Y2/uTxDFzpYHIzTRybYRFFZRhKkuWxwvLv9tIFPrFDl6ubr7Iqc3hw5eAt/N2oBmb5GHiEQhwScY6SHuF2AYYLZ0itnM3qaOa0/QMPEbkNKAnpAbxhIPHhxJFcR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363172; c=relaxed/simple;
	bh=EuaW4FnQJh+ko9mrbbs5IfkUEDZC4yELYDgRCjRezjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Bx5DcuhefXpD4hqKwZgcomakF2PhTaJZ4M2E76sV/vfKZPOlQvuFkorIjHqVwPZr7p+S28NqrMapr4VyigxsMv1ArLLZMA8DsZTutKG+BoMZTz8bCCn1VY2/xXL/WtEpmeMwo5P6cqLZKGJRNILmBbMnskoO9H0wk3Z6cYfNyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mq0+5bfn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2638327a12.2
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363170; x=1726967970; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLyCmT9A4d8YcWvLPa/afO2DGfhZ5JLM/zi5Nn9BJts=;
        b=mq0+5bfnvvTZ644fabHUNc3jCzUJyTBGnGjY4cZ5JYQ52/jIqpQxXFASUFr9GMJJix
         x17kWFvnG+a0CFSVM26mRLv7bf0izTiypXio13+p4hrTZkWTYTRKDFAH31NcAj0R67zt
         4sdoMi09lhyO9vx55wF/jiwzuwD24lMGRO8posEaC8U/aDkYK3E8C40ifBCKx0xtNMGs
         YaQ1VbK/UB3pZwComZKRgiQxV8BTS0T0ftFITGbAIcOqo08x6JK91zSyC1k9DygkEihe
         YNUh3KmCq4FqknHdqFDgMXxZgovuQrhzVDVxP6rUpteESaNKC9giBjQQx9f5a1cPHRgW
         +RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363170; x=1726967970;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLyCmT9A4d8YcWvLPa/afO2DGfhZ5JLM/zi5Nn9BJts=;
        b=qU6XJj3Jp3TvFkSYRL0DoBl2lV/GWC+1ZMPeHwuK4zalaZwbZhIxQozQ73oDJpZSRw
         HdQ39XsZnlmmWWRD3Fxwaes66VSu1RQSQmblEKYjzqWeIKeZWyCWdEscAkl0y5msa2lx
         ExnwlEfWwzRph01q4oYDro/XZqv6arwzRaAAVpIbzMsTCngXnEUGLSISUPyN6A1BvbFe
         sBrJ5hDHEjMsfcD/f0x28+uqzl2XqtSKPTTeUcisjnhCMXf/YJ+misqn5obK4gOXrXrw
         pkDcEFi78dH0PI1d6T8SqPUf9hwvDKOncFm72MFee2JUbFSY8EwshMAr84unv0rduy5W
         oGig==
X-Forwarded-Encrypted: i=1; AJvYcCUTerhTf4wXwFD/83eDoQT2olSXsYdcP4HkeOFyAT3uSBI22mV05dUfcl93HMqHmwnAGk7RJKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwluLbirZzI/Qtep2C4OFKpQkImTTsAOj5pTRrCej/YlkK49rR
	DXNQDqI07Zh9BQdLEoVzBl6yzzJKFvtNQo+xTxQjn8ew3WWlUkk//FfFPCdNjkk=
X-Google-Smtp-Source: AGHT+IF2UHBelhth2+1xufYsoelpTaniIMfonBmxDq1YLHlUWtYufWLhO9HlxpOnLIoogIrzsE5JRA==
X-Received: by 2002:a17:90a:d49:b0:2d4:bf3:428e with SMTP id 98e67ed59e1d1-2dba00659fbmr13985420a91.37.1726363170391;
        Sat, 14 Sep 2024 18:19:30 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfd252b1sm2217917a91.29.2024.09.14.18.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:19:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:44 +0900
Subject: [PATCH RFC v3 5/9] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-5-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tun used to simply advance iov_iter when it needs to pad virtio header.
This leaves the garbage in the buffer as is and prevents telling if the
header is padded or contains some real data.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..9d93ab9ee58f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2073,7 +2073,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 		if (unlikely(copy_to_iter(&gso, sizeof(gso), iter) !=
 			     sizeof(gso)))
 			return -EFAULT;
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
 	}
 
 	ret = copy_to_iter(xdp_frame->data, size, iter) + vnet_hdr_sz;
@@ -2146,7 +2146,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
 	}
 
 	if (vlan_hlen) {

-- 
2.46.0


