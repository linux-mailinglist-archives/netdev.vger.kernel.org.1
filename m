Return-Path: <netdev+bounces-223175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A92B581B7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5484C1EA7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91E25F988;
	Mon, 15 Sep 2025 16:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AE25A326
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952664; cv=none; b=dOyo36k1URoNjwyRT2d1Ig2SCDXskJyhY0ClaYZHMj06gZXTGkPWT6MbLhOqO5AecdUQ/AcykrGVDBldcbtMI+mGqlQ5ShQsqN/gj+rH/UE4ECxrUTIIR32/JmXPqyx6+8sSamEuy9kuWwknOTCyk6yj9KtGZxNcUL+cQE1d0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952664; c=relaxed/simple;
	bh=vRcDzLxFzOnwqDG+Hu90o/UcT246cj345mgxykQiTf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/Cb9QgA8qh8ZVIPAg/QoStkWvgEEEyP3SWKerJBXYEB+cREr+u/YVyryKZKrN6AUKKPJUCuvqDcCxLGx/O6+L6mQT2k+jS/49DpolpkcA2mhuN8h2VzVF54Y6yaeBVEZ/Xytiqkxa7EWT/zmazlccEpZVz705VezC+7OdX7TQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8955A60288274;
	Mon, 15 Sep 2025 18:10:42 +0200 (CEST)
Message-ID: <89e50ff2-5382-4d5e-a121-167704ef5b1a@molgen.mpg.de>
Date: Mon, 15 Sep 2025 18:10:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] idpf: add HW timestamping
 statistics
To: Anton Nadezhdin <anton.nadezhdin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, richardcochran@gmail.com,
 Milena Olech <milena.olech@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250829175734.175963-1-anton.nadezhdin@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250829175734.175963-1-anton.nadezhdin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Anton,


Thank you for the improved patch.

Am 29.08.25 um 19:57 schrieb Anton Nadezhdin:
> From: Milena Olech <milena.olech@intel.com>
> 
> Add HW timestamping statistics support - through implementing get_ts_stats.
> Timestamp statistics include correctly timestamped packets, discarded,
> skipped and flushed during PTP release.
> 
> Most of the stats are collected per vport, only requests skipped due to
> lack of free latch index are collected per Tx queue.
> 
> Statistics can be obtained using kernel ethtool since version 6.10
> with:
> ethtool -I -T <interface>
> 
> The output will include:
> Statistics:
>    tx_pkts: 15
>    tx_lost: 0
>    tx_err: 0
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changelog:
> v2: Add testing information
> v3: Add check for port status to resolve driver crash during statistic
>    read when port is down
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h        | 17 ++++++
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    | 56 +++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 11 +++-
>   .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  4 ++
>   4 files changed, 87 insertions(+), 1 deletion(-)

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

