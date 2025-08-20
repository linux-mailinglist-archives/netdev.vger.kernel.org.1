Return-Path: <netdev+bounces-215103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD66B2D1B8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB2E74E1D54
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828502798FE;
	Wed, 20 Aug 2025 01:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B9279331
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655159; cv=none; b=Janbl68Eepu/eKQ28nLJJoz18mPw4A2LjafABbv41mldIYzgW4uyMJuYREbWjkrUGZzRYXZe1UkTmLce0RNKPdgVEcS5tlIXHkb8If+g4oNnOlIZLAt3uPXg6qqb2vN7RYiyucXDySGR4++2UwxPkbSqjvwBFdwW3lPqmoGrzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655159; c=relaxed/simple;
	bh=BsRix858UdVobGHEoSnCDXw3NfG+R5prmBKLtiz1aKE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFTphbBMiUN/ns5hed43RomTcJx3LMKT5X8bYA2kH5diCCSokPrQBlxWHbfqDFR9zXhEOmnBDnlTaHNK61PYJT9t2OcH/OFbasB14Wgl37OZacMgV0mv9i6soS4+Rkbr3IHvGtnOPxdZCQyOMn1U7si1Z/hAbPt11f8aRfqG8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1755655065t197t06608
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.233.175.250])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3044220916234619391
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>	<20250812015023.12876-5-jiawenwu@trustnetic.com> <20250815111854.170fea68@kernel.org>
In-Reply-To: <20250815111854.170fea68@kernel.org>
Subject: RE: [PATCH net-next v4 4/4] net: wangxun: support to use adaptive RX/TX coalescing
Date: Wed, 20 Aug 2025 09:57:43 +0800
Message-ID: <0bea01dc1175$d1394730$73abd590$@trustnetic.com>
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
Thread-Index: AQJSp6GMsSi4kqJepxUFy3vdl3vtHAGdM6CxAmQrRkyzXF/coA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NDxI9psdf3YV4d/pU8DInthao9uehgNMtTZoO6wjFBtZ/+72TKJqZh5e
	qXDIyHd07T4LqA/wV8m2hiMrapnK0yDkNd8ZNibPbTrdvSRju26X3QTjKgA8Tnir/6r1Biy
	BXQN9YmAtztn5QUjeiSvItMgDSeNm7E2bRRMqoRDLowyZXjBXQ5utCmk4kiV/HbruCP7No2
	puPur9ZE4R+UvhG8S95eQkt0u+ggDvILjNvjKKzb/yOBKrZ7BySuoqag0BQJkPn1JQwi1nV
	5EoUojhabkop2JClxc8mq2RFNlH3hg91FJ6cvz0fmS53rMkpgBCgvRoUPOmA1o1sniLVKJK
	KUc3LmvxXY9B5oK82Ap4hwRt8JwllR4eDGBGeSj4nDhSbZWjaTwOXAKzMjfdOGX49LovTyC
	WUyW/M4xzH2QDybaSGpQaoD3vki8PUQwPGDpni7FtYKTZf0lVtzNPzWI8ez4mAsty9s8tXS
	bNdYlYYFubpqX3MRu2S++4KRvpluzozQkCo2ygRZZoue63UTthMNRrYoPkX8gmw7zRBtm21
	0fS4kzCKZxtQDx/U/IrYqUTEJTSCm+SimTyUsP+/3jBSxoqCS7L8pk3cwLxbu0YmZ63HUse
	tGiyQaBwPvVwF3HnUOitsrJL9RZw9gSLg7Y60E+OJ0TimMsVBw1AdqRJtgFhBfBZK8QWn7Y
	89smQxbLTUD2sBftO0jGaHdTPb+8IM9S7DUtqfrSFx9tBnFLN8rFPYqobZg9+flE1scKxUi
	/tGMWGdqeVW2/oWm3jPT+WJBmKhokiny1t8hQ59C6lSiq69nmpTXjVeZ0Aj3X3OtKT6MVK+
	TYU5hcYhzRe7w7yCkMy30zqGDr/SfHfnt1txDEJr/hjA9z8Nb5KjpBBGa/kc+U50qyqfvKy
	XtEZH0pvX/PLqPIeE1bBMmIiusBgXFGQ/X+zOf1KlFxu5hPvJj0vkmBxVPiTP8zOqDIzsHh
	7dK5G4ukWsUoP6I54FZy2BA1a72P/de305uzv40GUYC6xweMePBF0OaIGJXyWgh3ZhWta6+
	SaOSiAlKrABzzCBvIRsLwhTHGeH0RaNdzwuuuuvA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Sat, Aug 16, 2025 2:19 AM, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 09:50:23 +0800 Jiawen Wu wrote:
> > @@ -878,6 +909,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
> >
> >  	/* all work done, exit the polling mode */
> >  	if (likely(napi_complete_done(napi, work_done))) {
> > +		if (wx->adaptive_itr)
> > +			wx_update_dim_sample(q_vector);
> 
> this is racy, napi is considered released after napi_complete_done()
> returns. So napi_disable() can succeed right after that point...
> 
> > @@ -1611,6 +1708,8 @@ void wx_napi_disable_all(struct wx *wx)
> >  	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
> >  		q_vector = wx->q_vector[q_idx];
> >  		napi_disable(&q_vector->napi);
> > +		cancel_work_sync(&q_vector->rx.dim.work);
> > +		cancel_work_sync(&q_vector->tx.dim.work);
> 
> so you may end up with the DIM work scheduled after the device is
> stopped.

But the DIM work doesn't seem to be concerned about the status of napi.
And even if the device is stopped, setting itr would not cause any errors.

I can't fully grasp this point...
Should I move cancel_work_sync() in front of napi_disable()?



