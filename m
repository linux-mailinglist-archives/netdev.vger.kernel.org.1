Return-Path: <netdev+bounces-159649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60629A163B3
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E153A3084
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2CB1DEFC1;
	Sun, 19 Jan 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo4l8oGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5918BC3F
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737314202; cv=none; b=nXWBL/2JIT1j6+BH3Sx6F8du/5LmRSBGWgiSKX91j8Gli6Q4GVmyZEJ8OnOY5ld3BWbcfWCdd+WgMoYlAHGtNujIIvyVOkyq5JeG6T2s0z7fBThEQShOHUaqZc3KzaM6RkVt3OvVuQsa5s1aP2IUQIMV8HqZxwydFGsb7gEa4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737314202; c=relaxed/simple;
	bh=hYqXUA7XTRsbcA4sM4/WYlPFBTABXyl5jm1cY9QW/zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDAu++tIom9ajA83JIvk0R8hik3uJfcObcuGsa0YmOfBMlG09CaH4InsTij16jIgIZI0kERJ7dZKQsrMtGxK8aobP/FLqCl0TxsqH4PK5L888cP9dO1UXsXcCOUISFdW78tBcEgXMrqy+GKcfo+m2Fwsk5lA409AvXIzM2KEmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo4l8oGj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so88497435ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737314201; x=1737919001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYqXUA7XTRsbcA4sM4/WYlPFBTABXyl5jm1cY9QW/zA=;
        b=Qo4l8oGj8U9iXL6/M5S4pkPiYxKgQ50E5v3DrQL8ZsyLBTEbt1OyefkOASPRnB79w0
         MLlb9gdD0pmaHO6VIakmyYJSzwaC+6FOzHGe1UDvHFYXJEaKNkjsDzS5rDd1vCFFPLmR
         tHpWONUwv/ddN2Q1ZcYANwI/MggEZsJPocga3EZIvcZhdSYdTo885684Oc7/qOGg1Ia1
         uDLb6EmlRJoA1V8vZod40sMSPtP6WBPWQmfcJ2B32CZmnOpWj5qTOsRlEfhDIe4Dn8SC
         fauPQE6JNH3sC0m9we0POaEOqfd7aTprKaUKO+kiJ6vY0eVwcodXYWWuPo/UNnk21gI2
         rbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737314201; x=1737919001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYqXUA7XTRsbcA4sM4/WYlPFBTABXyl5jm1cY9QW/zA=;
        b=Wkrc+bjewz3Yv2iC3dF7tFppBdlKGsQnC+Pem8s7Bhhm6Cv4xpF4tzrTXDEXECgylb
         8FcsGIHAdMBAou/PoxI0TqKGis4fchc7YzWyDbHXNPeFMbesrJJYSAE3LBXivbkfOeph
         6AFuZ/UBAbUgNChYGDqnoWpqV5jnEjLLCDXx96VrCu/we0DkfhCzA1HDi/svJQBfTfiz
         wn3Bm0l+qRg5j/oP+jIMEWpt1N+x2J8rlfbxxseV+qloiczaKQcOeACCK7l9QBLLb97U
         3zOr+irN2fYv3b0VIhZqMLbndwsMFFr8vj/iYFTYPBZdwjkJHc6Z9tNTiWt//Q7Y+2Hw
         VWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVF0RNnkmcy8V3IlfiAFz8j31xjoyjizhjKnyoH20y/XqQC9AreHGxW4Vc7s2GgcBSCxrZEPh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByjYYvKV+dBbFz0tsU3j5oTGX8X8SvDuqkCwhmhQTD5WAk3UP
	kyql2CmPFGuq/5gCxQ4P1Z280Pl4XQcE7CejxudMC79aCaBuqwA+
X-Gm-Gg: ASbGnctgldugkwlrYFNt1KbZlyCss3QeIuUn7lhLIMLTkzb8q9s/l4nMQ2FBickjGEs
	2N7WL2tn/YcY0kCot8uutqUbIkIyTN3TBseIl4vk5l3fnX4BNMTBCl9gB1CIWNrbQoKDrPKKfRd
	rvmcMrz/p8tpx9vnqNMtFmC5q8UjDxu7Iz2sUUZQCiRPO7Z4369Icek5TWMFd47Xzfbl5VS6007
	lqBdyV8Ik95435hmpTly3cf7nXvyDei3xF0Wp8AoMXYwhXbncnfwZeHDu/T4WhLVS0bc4Z9HKFV
	ZTJZ9DDTN7qQBg==
X-Google-Smtp-Source: AGHT+IGoQD3GFaoHhL12jifkO80jOTLN5o3QsyM8twYcqP2MqUi8KOo2wdIpN/4vXlmOMn7ZkG50GA==
X-Received: by 2002:a17:903:2449:b0:21c:1140:136d with SMTP id d9443c01a7336-21c355fb6bbmr176259205ad.40.1737314200714;
        Sun, 19 Jan 2025 11:16:40 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30cdecsm5347064a12.57.2025.01.19.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 11:16:40 -0800 (PST)
Date: Sun, 19 Jan 2025 11:16:38 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 0/4] Support PTP clock for Wangxun NICs
Message-ID: <Z41PlhQC6c6fyJId@hoboy.vegasvil.org>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117062051.2257073-1-jiawenwu@trustnetic.com>

On Fri, Jan 17, 2025 at 02:20:47PM +0800, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

