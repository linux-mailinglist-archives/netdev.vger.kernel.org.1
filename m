Return-Path: <netdev+bounces-228479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA0BCBFAA
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDADF4F120B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31D275AF5;
	Fri, 10 Oct 2025 07:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483124DD13
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082639; cv=none; b=iwOlFITJHwiaEo8MwEtZ7gRTwq3L3v9HXpCXxBoB8ApOYfXeuHya2uC7l8b4gJ1Wjy5TnGHKbfOWVC2ES0CBeRqOA4vzYbxJ9o9FnEagqh6aqTyV9Kj6yis5OuPiTXJfQvSbWGlWE+QlTnQDdHXQhVZxtg3dcBk/sPlsdlOywm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082639; c=relaxed/simple;
	bh=2/8RWGTkFXqnsdOKDBP4JJEmI1KUg2L6+igTX17erP4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WoY95F8wrQS2Wil/76mJk1kDnmwBpsOCVj8a/Et5uL4ti7+lp80e4ZradJxlTd94SDubNY0J+amJPcMBAPc21HEodxKjlxrpHI70aWwM/yORWOkSZ+avhxEzxRCm8uVSDoqU6M52zMToH213hsCN/kEKnRkPE1/dqt2z0bVSyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1760082538t304t47115
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.70.212])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 336740171036707060
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>	<20250928093923.30456-3-jiawenwu@trustnetic.com> <20250929183946.0426153d@kernel.org>
In-Reply-To: <20250929183946.0426153d@kernel.org>
Subject: RE: [PATCH net-next 2/3] net: txgbe: optimize the flow to setup PHY for AML devices
Date: Fri, 10 Oct 2025 15:48:57 +0800
Message-ID: <000301dc39ba$55739250$005ab6f0$@trustnetic.com>
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
Thread-Index: AQF9Ncx3ddJxbS4YFASGoFm3bIwFPAGVefx/An6Z7Fu1WGbqwA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MSSgvDzN53Fl4ykLeCVRRmhMgWuYZZWHeJAug9Xi/5UZ95NOCsFaeMWR
	0V4Ygkxf8crNBCg1Bo+9HHrluKrKUdy92ZnIDeiMNoXkzlRZ6qt5OO+x6psmBlMqbXTPO9V
	a3o6sZgPaxljRBrE48MALlXJbUOzI7OlB0UJm9x6uuEvcOxEBJznudjEXn91GPtf23x0J5q
	baPWEaPE599aevNy9VfpUhBx5X3P0cRxCXXZLSqgmFxIw6titVzTCZ8njIWLsxSpvOBC+o5
	0XcQweE9h9lSP+uWvj+S5zSDwXCJyDbX+nQqlGSAawaKlnEZAibbDKREttcs3Gg7bX2R2RO
	0GzAAeyfMevlGzdo4nhRsMChxsC7d9K84XXkex2ssd5HzKwQ9uY8+U1gXF8W9sLQH8Xy2/E
	pH4Mdsm2MUiR4L+dyZXedMvHbiW0PlyC7uFzFEAuSDJ4Q3HPjP3x66R+ZjEzcyJUlHJKY3r
	Pq+SHb85UOtqdwq5YgygvhN3CmXGexcnbUjQOrdlVZ16NB9BpaFZhWUiaSK6Y8BB4+DbcxW
	ceII6OnnDZlV25ez2tRWwNLH4I+1+j/ke8j5AHLJh0M9XYdbA1y3ZavYiG0q8gIjcJkWrQ2
	6CPbcecLzWApqtTumdXP8/yJ1NlBr5GaocYl0PGkMKp5UtIfUSpfcodEOcF01q4eUibCen0
	fupJx0qL9MT1KTbz6PjthwWL2fzqLlr9Pt5vE0VyhMiiAjJfzOeheWy28GULWcymPn+/0ZT
	AcEQoV0JnNwtbnrpp1CvSMMIlzqr9r1Rn3s2ptLNmrLemP6PGVMhNxxAp1T5TJj3WsmAXhl
	Ek0WVZBZYPhg9h7bIqwYrcj3hdHU9N3Q2EyOHq8b7xLk3E9g7zE0zOjUYR/CL4Z24vGmJO0
	tgiIc9f0jViRC1zZkh7qe2EhLm9aa8FVKHeD2eCQXoaMDRF0bVeKYNYJF2VAHmGcJV1HElN
	UbtbbveTYUM6GPAgTaMXW0EjSryaVDx9Ral0srOODf6Ew/TAA2VbnOnV9Rti1yiVXReYvbp
	1vFd+KkCzng8j2HkVTv/Wa9HW5XFdlK68C1GRjkJSAC0uQbvzDKwM6eej7+IL1Dnb6CwzJi
	oXsALesqwBFIMwAw5/aAC6O6VIJSMe2Jg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, Sep 30, 2025 9:40 AM, Jakub Kicinski wrote:
> On Sun, 28 Sep 2025 17:39:22 +0800 Jiawen Wu wrote:
> > To adapt to new firmware for AML devices, the driver should send the
> > "SET_LINK_CMD" to the firmware only once when switching PHY interface
> > mode. And the unknown link speed is permitted in the mailbox buffer. The
> > firmware will configure the PHY completely when the conditions are met.
> 
> Could you mention what the TXGBE_GPIOBIT_3 does, since you're removing
> it all over the place?

Okay. It is used for RX signal, which indicate that PHY should be re-configured.
Now we remove it from the driver, let the firmware to configure PHY completely.


