Return-Path: <netdev+bounces-129272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A0D97E99C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8841F1C21701
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E71940BE;
	Mon, 23 Sep 2024 10:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D661FFE
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086427; cv=none; b=Lf4lRZU0YWkSFDvShtP77T5pw8OiVVNgsPNvfY7ZdegfFSkU71UnoV6NakXtcOlH1zA1LIetjx8ZU2HibWOqhlstPBAsXhUoiwPqyrZf3g3gu2KR/G02xxMVkbceixwQ7dmqTMdkka8PkzLQk52TSDmtAZASxBCfBJNLzYrlzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086427; c=relaxed/simple;
	bh=EgROdx0GclWTRj7v8axnNPqyQa3BElp5KkVIsGNDDd8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bdpj+jcfp26qp3L7t6gGI+rCCrPtYogrqy2srV3kdyHN94SLp53z01KRM/SIl8IOcx4Kj7sItgCUVlQWY8YrSHaPNDEBFVimCqNHT3gCA4CHnAbs3IcFdtJOPAxQ8h7tOzmxHx5nq3NDX/Y94Hl8ahhVhgAuAWYdtS9eFP1FjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1727086365t013t30093
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.112.228])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1381846632311912272
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>
References: <ZvEyZGKt5elazWfj@shell.armlinux.org.uk>
In-Reply-To: <ZvEyZGKt5elazWfj@shell.armlinux.org.uk>
Subject: RE: Bug? xpcs-wx: read-modify-write to different registers?
Date: Mon, 23 Sep 2024 18:12:44 +0800
Message-ID: <01ee01db0da1$2196ac60$64c40520$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGT5VMiw8m9vIN9R83oTP0YAcVQb7LzdmDg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1



> -----Original Message-----
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Sent: Monday, September 23, 2024 5:18 PM
> To: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: netdev@vger.kernel.org
> Subject: Bug? xpcs-wx: read-modify-write to different registers?
> 
> Hi,
> 
> While making some cleanups to the XPCS driver, I spotted the following
> in pcs-xpcs-wx.c:
> 
>         val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
>         val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
>         txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
> 
> This reads from the TXGBE_RX_GEN_CTL3 register, changes a value in a
> field, and then writes it back to a different register,
> TXGBE_RX_EQ_ATTN_CTL. This doesn't look correct.
> 
> Please check whether this code is correct, if not please submit a fix.
> 
> Thanks.

OMG, it's a real bug. Register TXGBE_RX_GEN_CTL3 should be written back.

Thanks Russell, I'll send a patch to fix it.



