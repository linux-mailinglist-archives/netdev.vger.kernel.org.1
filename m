Return-Path: <netdev+bounces-220193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF83B44B6D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF2A07807
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC488128816;
	Fri,  5 Sep 2025 02:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBD946C
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037682; cv=none; b=Oj88fudh2oR0f2kwtW+OY3VnhOz32V+V1FCDA1ANA+nn27F6H6aCYJQ+cvhbp72LILjr1O9uXZ/5gxCqzY4fdMTHMef0HRNkgwME9Rjvcz7YZ9l1TYbgqixocbgRxGN0FsQFkIntYs9Il5Ku6ClITOCmWns53E6i0y+jULAJ4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037682; c=relaxed/simple;
	bh=p61RKDsd+Lac+YwuGayk9ws6t40hsEBkD07IiMZEWRI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8unQulYAId7hUzCNGyBzDLUf0MnYO2FQ7roNZMSB4k7LCfAq01mlRmN48ZFe60ahZdmA4gKsPmXJ9Shnagkij1dwYFwuF3CKzYXaxtODzNSt15z2lXoUvN/8pVvEq7ujx0+HMZzzD6+eRE1PcW5RrBUT9sRqyRhmsI/2NFL7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1757037599t879t34409
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.151.161])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14616842366964705409
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Alexander Lobakin'" <aleksander.lobakin@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250902032359.9768-1-jiawenwu@trustnetic.com>	<20250902032359.9768-2-jiawenwu@trustnetic.com> <20250902174116.080782a5@kernel.org>
In-Reply-To: <20250902174116.080782a5@kernel.org>
Subject: RE: [PATCH net-next v3 1/2] net: libwx: support multiple RSS for every pool
Date: Fri, 5 Sep 2025 09:59:58 +0800
Message-ID: <010001dc1e08$c8758970$59609c50$@trustnetic.com>
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
Thread-Index: AQIaTc5Womd1Gsm0xQF2e5KHEhRSKwKUQxyHAokeMkyz3omjgA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OWCWkGO3FSKj+QK+uGpr5jzRaAK9TOBfI1gWkAMar6MlXFwK18dmBevf
	7VITqZuvEfTwkoGDyMZ24QLmHs7rgLePm+k24EdW4p9FH/cO76mInJY+sfFSyTkSTp01N8F
	tp3Iyp/n/mV38WYDhnTqVUkzSZx7CkYQRl53XTKpg3UwOsRMq6Bqn0NTaobUIV/ZAL9qB2+
	AiEzF5hk1Wbk7S8iBWHkpNrof7wcrgpfSdsEjVmyFcSfDAIov8abNdeh+SfD8+J4Mf530+w
	JBSaTQzD0WG15WF/+fgy+ZPjxxE4/dMm6zFY/tbNN0/soGP/r7xUhKRYx4nXCzRcLDVYvYV
	Sa11HEmz8ax0BDO57MXlzJGt8dyZXrn3dykoL4INpt6ZKJAdKdAWtnER7lhJmYnrUoS6ycf
	mISWDHz9/Tgo00KgX3R+PQEIfYSRbCzkNQUfb+PLrOqb7+9qVLKFeOq1vgQd1zGWSS5ls4D
	YvbnXsBQyK5zJgHQvODr16IVWe4WUfZEyfUa71oVII0fctxYDk9t0SG30DzEhuF8QV8POuc
	8KNj8wS0R0mEUXtrIet+bo8QV85empYA8SdBiCPzlsLzi6lvMwKGHcf+PP11g+GY6YA7F5e
	np/6QDakgKbP4xSISQQy6O8nJ9gCIeXfVs5XJBXVigiBGgelngCuWCuJkplnDG2OKDKwq4k
	1WD7+tiu1avX1NkX3EE3hI6HHBYQPsh81GMep/x2u2ze43yF0+M9TsUWfQsQR8Ntycc0zA6
	XNSV0OPMy26mz8/EyR53wAfba1wzMTGBaI4ED2xc8FYVEmvVsJMxiRvSotQTciTZ4H4tL9T
	bIi2Xbed908QENt1zmC6Rh5Sfrgqcpp2/PbEDgK5ZGoWh6njLejk7f3aYirc+kKzeIDrY/k
	ReT8QwXlHSetVUCwWKfgEU7IXW7oCzVeIam2DpEqEomeVx3KlWOb746RTUkTzCzBw7CmVCe
	IUziZTnTBMx5/s3JUTnWrukjgznGVi6N5Ey1pU8hLTIaTAkgxETvaXeFxIhOFmz4hzKUdP6
	h8XFTTZlLhzyNoSPdP5c1r6tJ6tmCFFkCJJrhXgA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Sep 3, 2025 8:41 AM, Jakub Kicinski wrote:
> On Tue,  2 Sep 2025 11:23:58 +0800 Jiawen Wu wrote:
> > Depends-on: commit 46ba3e154d60 ("net: libwx: fix to enable RSS")
> 
> What made you think this sort of citation is a thing?

So should I wait for the fix patch of net branch to be merged
into net-next branch, then repost this patch series?


