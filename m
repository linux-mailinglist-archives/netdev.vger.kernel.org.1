Return-Path: <netdev+bounces-165433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65911A3203F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF87916167B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63511FECDB;
	Wed, 12 Feb 2025 07:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94E1D86F2
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346371; cv=none; b=cM724V/7yMkSETITq3CSDnJnyTnCgitcmpWQ+04yJLuUV6y3bwKUW8hHQR0bdlhq3b8oB8bXtHeggb3KaR90tV4vYeJ+K0idInRyDzYLuBt+M+qw+wU/QbOBwwgyXR/Ij1w3H11wD3y0K+/KPnHgg9dWGIER+zThlOlwYDu0zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346371; c=relaxed/simple;
	bh=hwWb1wVG+pxRACceH5Y/Z4L2LC/F2lEB6ut57arU0+s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7DzTUyn4elzJbacQuyE2REaHBEOxxjnGGKN+6z2qQ3Q6Y7hESvLboO4vZXuQ7Lnloo4tqv9RAmqgYdjVxCMPqt9NbWdwwS6Qp1IQSk7QVbQCpYIY2TXgjGVUU7+o8bpB3Zl95+VHHbiX0nKSOY9WjFWslbNoQJFYzo/n2OyfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1739346354t040t56172
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [218.72.127.28])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8872732260127881257
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>	<20250208031348.4368-2-jiawenwu@trustnetic.com> <20250211160706.15eb0d2a@kernel.org>
In-Reply-To: <20250211160706.15eb0d2a@kernel.org>
Subject: RE: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
Date: Wed, 12 Feb 2025 15:45:52 +0800
Message-ID: <03a901db7d22$24628cc0$6d27a640$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJXwZRMfGviYJJJcTt9wh3IJl38oQJEsXdoAdgOcqeyKdZssA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MfQnJH+7WKv67jG52lgqXD4r0dQSwOrIhLDsKH3rrmkKmXAqySQUVMqp
	RVjJdg9SWSsYaW/gB8qeOjApPP/2WV0P34K25PAKSVNJ7jBiO7H5mmxeE8YYDfQJLaGlELy
	C6HPxAFW11+knGcHZbxIaCf9hB5U+6OAWBMjE/1sh7Sm81qMU8UG5auJ6XdjO8b1Cke7oDV
	sJkXlMy1E7rEqrfS8AfGJjswvzv7RBcSRvanh5OAC+q9W3UWMf2MOxce5un1JX7XpcLwCGd
	5/XruPmmx8eUSkoSd53mDD7p6dyhS9PNTByNJWsInG3U5KLRccWmEI5RlE9rP/Zpb5FA4Pk
	hYUW+VkCyaQGTIGDPYDGOScp+9vb55QvwPd/ifYMmfIABFCSLHTrD2fobfLEpAdtL3JgN+u
	kVQvyQqZJrDYAVve7eKKp0rKDHwd0jxmZqYjps9ZiJWD9UvxT8GiB1+feSEjbBJ79XNx9dw
	zKYlRjXDZaxL279myeX461nhJuVKTNWYWXooi/ZmfQppbZvU4bRkUXG1JNNy0oyl0XJ1ub6
	xOYUA7EBNq/oYD5YWgd2OSrDttqLZbi4XzcXa+BmjF0hWpr+c1IzVnK/hvR9I628yghjKcC
	gXR/Z0k/g3oDI4Fn5xLMlatClEpvV4UBYOIA5bn/dnr7rB7rUgjwihl0sw5RRbxc8DJ2w+b
	uKPC+JL2Upyxi3lPdCkQXkvsFsqjs9HYr64vPrt3W7ionoeJdE2PRaopQsUopg6vZ4XU/rN
	XJDH4XNByeKhFal12FT7OtPzP/uUOZC//fn6y3APH2MVDPmX2xRCeEfwcnGoKRUoHUqMoWC
	+BH/DDw3M1nJXDadWjjcISVfiDDIPwJBN44VDuVL2qmEpHzMfTUWQYpZlCoVN0FR2BRXZ+E
	TtX2qfNEANi0INSOLEyLf7MP6cpHNmaecjQXQMsBjnY+KVfARdeVsGpjQusQqaEsM1HALwi
	Q9J+V/vBUF/KksrPMGDNaElKi5h2Gcb/t3XDoNo3H7Efb+Z5ZWCZXxrTrQFtHpktRurGxYc
	cc3vz0kg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Feb 12, 2025 8:07 AM, Jakub Kicinski wrote:
> On Sat,  8 Feb 2025 11:13:45 +0800 Jiawen Wu wrote:
> > + * wx_ptp_tx_hwtstamp_work
> > + * @work: pointer to the work struct
> > + *
> > + * This work item polls TSC_1588_CTL valid bit to determine when a Tx hardware
> > + * timestamp has been taken for the current skb. It is necessary, because the
> > + * descriptor's "done" bit does not correlate with the timestamp event.
> 
> Why not use the aux_work for this?
> IIUC aux_work often has lower latency since it's a dedicated thread.

I think this task for checking TX timestamp is immediate and continuous
after the skbuff is sent, and can be stopped after polling a valid timestamp.
But aux_work for detecting overflow and error cases is a periodic task that
is always carried out. It looks a little bit clearer if they were separated, but
I could also try to merge it into aux_work if I need to.


