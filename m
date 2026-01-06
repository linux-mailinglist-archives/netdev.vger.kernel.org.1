Return-Path: <netdev+bounces-247354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E6BCF83F4
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6FFD300D400
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA6327204;
	Tue,  6 Jan 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wyraz/xJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4123322B79
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701235; cv=none; b=Z2YQCAomyYco+XcdJ6nJsCdnldoU6yPhKtGZDl+vG//D8JBRZW6BCVVDhMXU82jesD0SKEpAC0b/Qmdt8iSSg4u9/kuiO8cPuF17WyW3lEK6oTr4nyax4TRJ4cJSNR7b37GxSPJkrmW7sv/higLzSJe9A6yHaPHp6mgTQOHD7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701235; c=relaxed/simple;
	bh=a7zAKSyFvmFAFoFGg9nI8dmzMLb+e6EHwSnLvS4equc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKNS7Ipvih7B1DJaOeSsy0zlHZNwrpNHc0fKyrGSjuS/TquAyHAbsCcT1gJdGr14gMn65JHA0Uz4fjijBr9dDDdQC1uPZzA99BkOM5XdsyMyhnSvqyuAd3DPehUS3ECtN4PuirHwKC4YEIpyZkzv3EjsT8NcjkzF+EBZWjHCteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wyraz/xJ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1b21ca9-a26f-4584-b74a-c006df5fde0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767701230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0+BD0XsrZowSSpQicE7vkh6dvPYdYl9b712kH3qHrM=;
	b=Wyraz/xJEDOu8YdP/Oo9wHViDY0mb/5YqFwdUfBecCn954fJid5fGPpKCoIURm0vdda4zN
	1PMkqM9Z3X8avpxp8HhpaERwJYmoq4OeHaskIWKBQBPdoz3Xx12zX5bj/+ZMZRKuqgbDDY
	S/ckErbi3juEQk9CTZFU41OZW5GRJok=
Date: Tue, 6 Jan 2026 12:07:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/6] bnxt_en: Add support for FEC bin histograms
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Hongguang Gao <hongguang.gao@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
 <20260105215833.46125-4-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105215833.46125-4-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 21:58, Michael Chan wrote:
> Fill in the struct ethtool_fec_hist passed to the bnxt_get_fec_stats()
> callback if the FW supports the feature.  Bins 0 to 15 inclusive are
> available when the feature is supported.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

