Return-Path: <netdev+bounces-211495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4853B196DB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 01:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F49170950
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E42205513;
	Sun,  3 Aug 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synclab.org header.i=@synclab.org header.b="jg7+kdfq"
X-Original-To: netdev@vger.kernel.org
Received: from k4.kb8c70eb.use4.send.mailgun.net (k4.kb8c70eb.use4.send.mailgun.net [204.220.184.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2F1A0730
	for <netdev@vger.kernel.org>; Sun,  3 Aug 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.220.184.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754264528; cv=none; b=ppVFoGLig7N47QbIx2pM7n7cAooMooTL/yrqLDtTD8vWgOnzUFM6s9G9EBbiCGo9u3rMV48jJDe8feq4gV8FTsJXtOG8uGFWTZOuSMy6VjUmo9xLwZ4Pv0sU9yqW7SPSLO0lc8GYCPSw3WBKs5HD12CkF0B/2o2mnRoIkMLHUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754264528; c=relaxed/simple;
	bh=juaeP4jpZOikqbpV4JJQl5rNQS1cH+KetwUgCoKVfnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOsZY9xrupKEmj3iJMUTJ9ZpfyAI11DKJgWTN11JhgRgY9GRQl8ov5c21KM+/SRa4cX10dY/38FpQ0Q6O86QidLLGidj/POOCJFpoHYoORqjSWFNVmmtyji1bfSNB524K+UN7WKh3hPGycjD5DONmqhsxO2WNmE8ZenrYrGw1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=synclab.org; spf=pass smtp.mailfrom=synclab.org; dkim=pass (1024-bit key) header.d=synclab.org header.i=@synclab.org header.b=jg7+kdfq; arc=none smtp.client-ip=204.220.184.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=synclab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synclab.org
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=synclab.org; q=dns/txt; s=mailo; t=1754264524; x=1754271724;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=1aUhJ8VfQNf/+TjpT8lP03mSYoUaE7NR9X5gpRuE4yY=;
 b=jg7+kdfqoQDftBYdSqvkJNQYP10R2C7FonL9j0i/0khxx4fIaF33AxHPwFZzfkgZmQaa0lfSBZHTJ/RKuBXFcFiDe7w3v5qU2bbYbbDbaxCBXYtAU9hBPoCA7Of4neHV89hCI/FI3LZ98+2SB47FA/RQFIBbOB3RqpJetnHjEHQ=
X-Mailgun-Sid: WyJkNWM2YyIsIm5ldGRldkB2Z2VyLmtlcm5lbC5vcmciLCI2M2VhOSJd
Received: from 7cf34de991d5.ant.amazon.com (c-73-53-2-7.hsd1.wa.comcast.net [73.53.2.7])
 by 2c9aa3619b58 with SMTP id 688ff3cc5749a13fe408da8a (version=TLS1.3,
 cipher=TLS_CHACHA20_POLY1305_SHA256); Sun, 03 Aug 2025 23:42:03 GMT
X-Mailgun-Sending-Ip: 204.220.184.4
X-Mailgun-Batch-Id: 688ff3cbe559a483732353a5
Sender: julien@synclab.org
From: julien@synclab.org
To: richardcochran@gmail.com
Cc: akiyano@amazon.com,
	aliguori@amazon.com,
	alisaidi@amazon.com,
	amitbern@amazon.com,
	andrew@lunn.ch,
	benh@amazon.com,
	darinzon@amazon.com,
	davem@davemloft.net,
	dwmw2@infradead.org,
	dwmw@amazon.com,
	edumazet@google.com,
	evgenys@amazon.com,
	evostrov@amazon.com,
	joshlev@amazon.com,
	kuba@kernel.org,
	matua@amazon.com,
	mlichvar@redhat.com,
	msw@amazon.com,
	nafea@amazon.com,
	ndagan@amazon.com,
	netanel@amazon.com,
	netdev@vger.kernel.org,
	ofirt@amazon.com,
	pabeni@redhat.com,
	ridouxj@amazon.com,
	saeedb@amazon.com,
	tglx@linutronix.de,
	zorik@amazon.com
Subject: RE: [RFC PATCH net-next] ptp: Introduce PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Date: Sun,  3 Aug 2025 16:42:00 -0700
Message-Id: <20250803234200.55698-1-julien@synclab.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org>
References: <aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 7/28/25, 8:55 PM, "Richard Cochran" <richardcochran@gmail.com <mailto:richardcochran@gmail.com>> wrote:

> On Fri, Jul 25, 2025 at 11:25:24AM +0200, David Woodhouse wrote:
> > The vmclock enlightenment also exposes the same information.
> > 
> > David, your RFC should probably have included that implementation
> > shouldn't it? 
> 
> Yes, a patch series with the new ioctl and two drivers that implement
> it would be more compelling.

We can include the driver side of this RFC for the ENA and vmclock. 

