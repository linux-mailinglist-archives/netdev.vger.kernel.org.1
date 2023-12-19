Return-Path: <netdev+bounces-58778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BC8182C4
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 08:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EF71C238FA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23DC2D9;
	Tue, 19 Dec 2023 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8A7vwCX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517415480
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702972676; x=1734508676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TX9aq9Or/fcKMYHi5Am9qe6ecLnIT6hcDHmGpXbECOg=;
  b=P8A7vwCXARx/ho0/8P7mJNyfg5t8vrS8SEYP/GvxfZAt/kIA8UZlgeen
   gmVYb72nGyITB5Ll/1NNZr6FKgPygzjotFhZ/TZ6JGoI/K9oD91QRQ65C
   zxEf8xeo9YNAFBk5306TUX+ITURNBnw1YVLvoSG2LDleis1yTiIQHBw3H
   owuV8zzb+rrVevJjb0yAXF/VEmZt1006KDY2iHDov4FXRJweDrnQm/Vgk
   f5IqPWyvfG7UqXLErEjLDHZ25793s9P92iar1eTbcYLvG0dW1p1Wpf3IV
   1AwaoyWGwbuJpNC1slEVWQFPKcQEjyIpwRfCDxSp8LMcw1NjSkEIATfgG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375773329"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375773329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107266039"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1107266039"
Received: from unknown (HELO [10.245.181.167]) ([10.245.181.167])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:57:53 -0800
Message-ID: <ee1112af-cb13-483b-b6b5-4489a39c57cc@linux.intel.com>
Date: Tue, 19 Dec 2023 09:57:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 01/15] e1000e: make lost
 bits explicit
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 marcin.szycik@linux.intel.com, horms@kernel.org, netdev@vger.kernel.org
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-2-jesse.brandeburg@intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231206010114.2259388-2-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/2023 03:01, Jesse Brandeburg wrote:
> For more than 15 years this code has passed in a request for a page and
> masked off that page when read/writing. This code has been here forever,
> but FIELD_PREP finds the bug when converted to use it. Change the code
> to do exactly the same thing but allow the conversion to FIELD_PREP in a
> later patch. To make it clear what we lost when making this change I
> left a comment, but there is no point to change the code to generate a
> correct sequence at this point.
> 
> This is not a Fixes tagged patch on purpose because it doesn't change
> the binary output.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/80003es2lan.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

