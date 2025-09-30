Return-Path: <netdev+bounces-227350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E6BACDAE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C278D1925408
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D752FCBE9;
	Tue, 30 Sep 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjUTjdQT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648F2FC863
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235726; cv=none; b=YSqezNHCr8ij02pByoFUrS8noopEl41C4Z+DVJ69nipDcueZ8o6Vf7rzwYNETOZuNKZNCw5A26V7esLC25lBoVYpx8cl2ftqCzCHgrrZIw93NjGYGEmriIgGJXyfQJR2nrzZhVKOVhp1mDeQ9mz++Nzryo+tF4qg/+jXIu2xRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235726; c=relaxed/simple;
	bh=yM6tDmlWt1WChkIFaTtxrLwmPUG8oTR6CTdlN35Dv4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OwKTlnbnixxVxrVAMxCjpRWgfXF/6jhxP/SJ2TV6X9HlrhaspYzrSAB49umnQVZLx0j+ahvlN583T9YrO5taGc8wm3W0P3TNJznkNEftYtTihyQdKHjFzZiHJTWV85FrYIomYjGpCxo0ijx2N0wsfmWWZhRHurm8NAetpXBXdvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjUTjdQT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5195450f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235723; x=1759840523; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+weuOFR11RTE73x7k9JMqdyo0oGBleP6ZLjJS43ihs=;
        b=tjUTjdQTA4Ioh9a3kzYTjg0MIPt81iEf9pP5ONRdYWEXfeFrHKNmviNXrouOM2PoDC
         pUX0eBBhg5MYgAoqHZEGt5VcnHgNudKd3CEpNIcgL/1aZzh89H7rmf86dt27lQJ2jnXJ
         NK4eRiPkIIM3JQaxswtjjnqdkCMje3n8qai7ZURH4IAJm2v8nfV8NeVUxftG6sY5qVNY
         kECUvwaRRl8COZqCxtkPmoRDG/3WJJsAFob5CboGVD5RAAdCcXP+idujMCKhj4Vp9Mog
         WDv9M0hMwSAoWSXLgaEYL3BZ/PsIROhC7OFoDahhdyWYKocCXLuV7vU2uWGkNIuK3IWN
         JGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235723; x=1759840523;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+weuOFR11RTE73x7k9JMqdyo0oGBleP6ZLjJS43ihs=;
        b=it+FVPNiOKS+BXwt6LAVLJbQ/MU/a6EqdN6hJL4stzNG07Pi/Qw/cGbU9Nlm+02VM/
         lRrNOSFTaMcIyQvZ/klI0HZCNttrZtHZpMcea8jL5/ur7Ch96ArrjSGxG/wPyUXGNAQj
         7+3QZ+eM8uaUSfzSgfGd7baLK4EgQDxRfZDcgKgHRj6tG85VI1gqabs7i7OHfJOFMwas
         3BjMM/r2vCy5qDX4D9PONZCg+FeDe/+sWoIWnJrzYJKAixze/sNW53hlXtTsjomM75vp
         aSJA5cFbMK/+uDbdnA/h3BziWQE2adHnPMhNgV6A59ghmWae+U2GpIXgv3nZAWYM0/m4
         i/pA==
X-Forwarded-Encrypted: i=1; AJvYcCVEzBrA3F/EYSd/hL0DJxmebCqZsWuieuYa15MU/vdKSJBWD6CbYBaU6ardBFcMNFQ6I3EtKh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSjlrso4RgtQSd02GldGqgp5y7iFGwLHncv2ju99uc0P7uCtb
	uBiwDRy159R+x/LnmhxTXh5NT9nwIPEUPDOvfxEppqUF6poZ/ngPphJuzv22NXj+l1I=
X-Gm-Gg: ASbGncvyxoZsLiWbHKjW9h+jIC3qY5liaLS7tRW9gtsYEte/rgG0tbkYRYsX0tPkvfe
	YBwSkCzUFzyjruGFiuP2MFAVq2XVVRFoMx7MUgyYcHoZE5k1Bm+2IuSovL8nCWBMXoP83gAy64O
	vug0hNM86MUzVtyAcaeY68lpurkeoRwgufF0vEl2+AqKXrPWXZPgKCccoHT29cZ4DSsL4BNePZE
	0z7BDs/urCaxoRlv+77lx9VibOQmr67cevyXmjCXMZXxeobUbq6LjrGdX+SDK9BenMq9rAVNsOe
	6tciTQRG1VCVelOMYVVRoe/pu+Y7fPG3Qig8Tpj1xkVXVQsdCkdPf2RumMVktqJn/sAOF08xMI9
	3HrzfyxrlbjSrAg1k1V033ymYVqbWa9IPa2qOVSYUszvybv8FV50R
X-Google-Smtp-Source: AGHT+IExzhhRL4g0b5oYQkaGb8IxC1lzH1rFGpLqAVr20/EVyM1DlA4fKgF6AkHr74LMf2fRuZuupA==
X-Received: by 2002:a05:6000:200f:b0:424:2275:63cd with SMTP id ffacd0b85a97d-42422756535mr2370130f8f.48.1759235722774;
        Tue, 30 Sep 2025 05:35:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-41f0c467ecasm9793567f8f.38.2025.09.30.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:35:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:35:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] rndis_host: Check for integer overflows in
 rndis_rx_fixup()
Message-ID: <aNvOh3f2B5g0eeRC@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "data_offset" and "data_len" values come from received skb->data so
we don't trust them.  They are u32 types. Check that the "data_offset +
data_len + 8" addition does not have an integer overflow.

Fixes: 64e049102d3d ("[PATCH] USB: usbnet (8/9) module for RNDIS devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/usb/rndis_host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..913aca6ff434 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -513,8 +513,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		data_len = le32_to_cpu(hdr->data_len);
 
 		/* don't choke if we see oob, per-packet data, etc */
-		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len ||
+				size_add(data_offset, data_len) > U32_MAX - 8 ||
+				(data_offset + data_len + 8) > msg_len)) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
-- 
2.51.0


