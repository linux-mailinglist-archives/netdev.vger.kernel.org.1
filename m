Return-Path: <netdev+bounces-224460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4EAB85420
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83CDB611FA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4101E2206BB;
	Thu, 18 Sep 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IW8XJPNY"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3541EEA49
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205981; cv=none; b=EeY23bKpSnJa0dNs8oJJQhjn05dKJHGFIs5q+oEAVyp+Guqs270fTwcaQw1HPu2+puPKR7paulDdudbVZ/Wr2qw+wJbmxnabhlPl3FQ50bsM8zD+tVn1KscaG8Tr4WlFLJ30iX80Y71fGIaIoXzviHtpYnl0G3w4zugFuUcW5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205981; c=relaxed/simple;
	bh=Z5JuZtLoVa8kU5Nngjbb3iLNbTUcVIrXxaMMz6k23IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgsQDVITIKcSjkwV1IGDq/n5xcuzgu+BeF50vJa/JDNBoX8WtgXS0rO7gD2b6OImQQcvorg/YrQNMINthB4JRUC3cf3boUFx6q1zRMAzf6807myFDtkaaoTCmkCMMrPeqZu68LklzYNEA7km9kMWYv8cI2u6DM1u7fZpGKP5iTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IW8XJPNY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28315831-21f7-49e0-b445-b3df0cb123e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758205976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvzJjB6JkxNqyArsRR8uweDSR1veOY42ofn4kfEVgpE=;
	b=IW8XJPNY9yegNVOb6F57e3qRIOl9I107I4UXqUAFYXCXdiu7kMtxhPZRukjL+2LxJ2Io33
	GUfNeAtROKpKw0XFtfy5NCp/FAK98g6fkXIoqsE013npEwcY8Vs0rn8DRZ3fyVpMZPzK+o
	tCXzhdlamWaJAiA6Wr8GC8nLjQ7hg6M=
Date: Thu, 18 Sep 2025 15:32:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] net/mlx5e: Report RS-FEC histogram
 statistics via ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-5-vadim.fedorenko@linux.dev>
 <20250917174837.5ea2d864@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250917174837.5ea2d864@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/09/2025 01:48, Jakub Kicinski wrote:
> On Tue, 16 Sep 2025 19:12:57 +0000 Vadim Fedorenko wrote:
>> +	for (int i = 0; i < num_of_bins; i++) {
> 
> brackets unnecessary
> 
> in the other patch you picked u8 for i, good to be consistent
> (int is better)
> 
>> +		hist->values[i].bin_value = MLX5_GET64(rs_histogram_cntrs,
>> +						       rs_histogram_cntrs,
>> +						       hist[i]);
> 
> could also be written as:
> 
> 		hist->values[i].bin_value =
> 			MLX5_GET64(rs_histogram_cntrs, rs_histogram_cntrs, hist[i]);

this doesn't actually fit into 80 chars (84 chars long)... unless we are
not too strict in the drivers..

