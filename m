Return-Path: <netdev+bounces-103315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C70907836
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60D41C22797
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D41448E6;
	Thu, 13 Jun 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDd3zUU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F812FB0B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295789; cv=none; b=j9vnQhWJcAqgjMQRBKynL5O19gL0m59JxuOk8z81bg6hAS7y/yBNXZX2Vt1zUyzWCn4EgpyPehDrcSQuKI8Z+yLM6kfOjHH8gWQsp40kpCPXL07zOIsZXA4Wl/yAVJ6vLKwtceTwtVEE7JLUBTbHs07jDXXocnwv79KmM3LZfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295789; c=relaxed/simple;
	bh=4wYSLHs0H1qWUWO5bcMjVjVqRbczULLW2UjbvGozFVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WNNYYsE2+BLxCdu6+mShXQFmoB7nIH77qH3zsQbVMMrXC5wOn7gtrPLrzHfKtdPX8oOrKjSzvVDv4gUaUiKXF3muaYRxEkIvNMszeM8AXXw2GSKVQ8NNYxoKZ8GDg/IiQuGFqpxifoKHkftcdhD0I7NOq8Ua58Rm5CzSHaiyl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDd3zUU+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso6417035e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295786; x=1718900586; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wYSLHs0H1qWUWO5bcMjVjVqRbczULLW2UjbvGozFVQ=;
        b=WDd3zUU+t2V5WSAat6WSxItLkdsJGUusC+s6ZFQww7qOXDoOJrkkA2lF1eoCoiz3mU
         YH5m/auHTk2U+xGdYIwqTMHgjD9gdTHlUJ8+JeQD+++6qzlrX6FJytqhErK4A5v+8Plk
         fAt8V9RxoskmiCnTA31JVU+eqT9qUnXbfghYSh18pH6e355kP6iKSPKZNT87LufSM8T3
         TU4JtSo6fMVd6hyGeQTDQYGxd9jqpFbzU0faf9rysYQGlm8KF5UjFG3XqdYnOsZ7ZBjR
         W1PK6af5nggRE/ygK+0pX7UpADgK+E4WMumi7/9zo3DzTxeKH7oqH9oL9qGvFbhV4gpi
         DsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295786; x=1718900586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wYSLHs0H1qWUWO5bcMjVjVqRbczULLW2UjbvGozFVQ=;
        b=bIujoTCnwgdE4fOMHfNIorr8SALj5swTxh2gcGq+w89hcEAx9ok1xd2u7fTRrXSu3s
         bdOhG6oGx+xhLMcKueAugkTpDpgyw7YpnsUfYB8vG4ejYJ405LiSK7JL0fuBe6TEWGUZ
         l0w0sjxMM3Sw+jCYM9YK9sZeNXE2TJTi1f7z1Bcd9w7gH0W4Q2ayO+fdyYNwnPEyJedW
         mWg4uWSIOXQjddcHZGWXMF6A9/C1mtcA7tT9xdPIIoQSlGCqo/FOQjv7sh5VtlSbEq2I
         ISTjaGvpRqR6Yvga90PKUSZfR+0DoEbWVPxOEG4Kv66H3cl6hdXArXA+rpwWbKJ8trR/
         XaQg==
X-Gm-Message-State: AOJu0YxNStQX1jvRH0IbeR3UR7NQrTBSwe51Z9XzmJPDb0LthRUR8sbx
	zFdB9vchgOY1CJB83a9fBOyxomYtf1HhBCu7LulevjUAyNwQrPWF
X-Google-Smtp-Source: AGHT+IG1tFaPChnEI92g7+10On1mvcORm6Bw1dFnATsOeK4VVUgZS0y8W4ysIJuooLc/fUXtHWG+oA==
X-Received: by 2002:a05:600c:4c23:b0:421:756f:b2e8 with SMTP id 5b1f17b1804b1-42304820d66mr3177235e9.11.1718295786227;
        Thu, 13 Jun 2024 09:23:06 -0700 (PDT)
Received: from Laptop-X1 ([85.93.125.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm67983495e9.47.2024.06.13.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:23:05 -0700 (PDT)
Date: Thu, 13 Jun 2024 18:23:03 +0200
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Networking <netdev@vger.kernel.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [iproute2] No mst support for bridge?
Message-ID: <Zmsc54cVKF1wpzj7@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I can't recall why iproute2 doesn't have bridge mst support after
ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode") and
122c29486e1f ("net: bridge: mst: Support setting and reporting MST port states")

Is there a reason that we rejected the iproute2 patch? Or Tobias didn't submit
the patch?

Thanks
Hangbin

