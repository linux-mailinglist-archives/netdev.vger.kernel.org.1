Return-Path: <netdev+bounces-106427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD09163D2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877DD28C32E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64B1494D5;
	Tue, 25 Jun 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="iqS7HEbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD214A087
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309051; cv=none; b=lbIKBdENTW8yjTA2/ENcU7ntD8i85U6sL7hyDCFMkYMbcjrO6LzPljDUBO7BA+YWcX4E32lgfvLWa9c+blkhNFOnzK1EOfTV71aOs33XDQOBA6QrqgXA1Yjq4CM6TUrqVaETPrZWz8Do/cI1vpTZqkylBysJTsWiBTQ81dWuH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309051; c=relaxed/simple;
	bh=9rNcPjvOHrGN2uEZCHy8MVfzOt/Px9SSQQBMTLN0k5s=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=qkpO4twFNpUz1dFd8IJRmqncPlVyrgjMWqXb4xj2mz7X7k2mZZ14QGCdI6dR2YNOAMiKDslM9+S906+KT8EU70y0pb1Kxde1VNn/6XIofp7Oq4eQJKF44z8zLqZfZCP7FHO9kMStvxlYnlTPouwKbLvRoe92CSlDcGiyABsVgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=iqS7HEbu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70677422857so1461251b3a.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719309048; x=1719913848; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rNcPjvOHrGN2uEZCHy8MVfzOt/Px9SSQQBMTLN0k5s=;
        b=iqS7HEbuPuuhFjhkywMgHLeBT/MKAMxoEGpSUIswMcehJqMpNMfhdMIpImIy3M8gDG
         cJkW9FeE+mSYIQ1JRT1m8TBXSpx+RLSCic3UsiOBzgqPWIGGgP3TRWzniEu3U1rUFHzU
         qID+/EOmEU6JFTLtsN61jom2SncCDaJurWpjT0ef60XiwFxJ1YMATi/pQd5nVR03hkTm
         XUR9LRpCalIFEd10oEzamVI386PBC4plvxwacDzCehaSgsIgInZGdy4MKTMjQigeumly
         8/t16sTmW/m5Mbr4o1xKtKL940oPn2YwSKTlslQBJkRueQMn9ICCac+xq+wNJACZSZbV
         jh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309048; x=1719913848;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rNcPjvOHrGN2uEZCHy8MVfzOt/Px9SSQQBMTLN0k5s=;
        b=Rmc8bYDn8F0pmFz1diD8waNoM6totZJ6TcVNBNR/IPeYiP6QDYPrTjZkPSZ8fAgLyq
         2qZacKZtMXSlWsAt0VGOXm0aJyN3iYyKA0VVMFXq38PkGhiewF3pN/xvner7OVeaphNA
         49rhuJjQjkGcdGtfGxS3b6SftaEt7rC3xaad7X3N7HKViYrl8qJpHpPlCCjTYg1+pRMZ
         1fVz9mTZTGYx0/rckgIBoSGz3dJ5VgE2lZyOGS07yjyhfNRQ9DkS9zNM1LCjaTur3WU3
         daqRbzRb7LnIOVfcO1RRUm1Q9QtKxNQ491eRn5e7Eqv8fCb9AMXRnEZUjFlGphPuPt+Q
         9wdg==
X-Gm-Message-State: AOJu0YwzHTaa/R+5TRDUPIFMGm+2fN8lRDq1gEsZVuTbgg4V8y1rBanR
	JDgEz22SxaxrA2VV+8FQPdxGFB56L5qFps9cdHrNikwyeXKn97baYOCIho9lteBe4SVy7M08/w+
	0RKqr0oPd
X-Google-Smtp-Source: AGHT+IFAxM1V7H3rrrdooIAjzfk3q0wKtYu0RZ+7K2pzaJT3zzDZnHvVC9h0XhYolDWXG0BHQjlEUw==
X-Received: by 2002:a05:6a00:1914:b0:706:627a:745a with SMTP id d2e1a72fcca58-706746f7202mr7100055b3a.33.1719309047235;
        Tue, 25 Jun 2024 02:50:47 -0700 (PDT)
Received: from smtpclient.apple (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066f660044sm5472428b3a.143.2024.06.25.02.50.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:50:46 -0700 (PDT)
From: Chengcheng Luo <chengcheng.luo@smartx.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: 
Message-Id: <31538AD7-9B05-4E08-BC27-D7F5BC2A6F03@smartx.com>
Date: Tue, 25 Jun 2024 16:40:35 +0800
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.15)


subscribe netdev

