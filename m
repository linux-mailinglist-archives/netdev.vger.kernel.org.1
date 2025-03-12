Return-Path: <netdev+bounces-174110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD5A5D854
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A4E189F6E1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B72356A7;
	Wed, 12 Mar 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="aq81Gdwq"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-34.ptr.blmpb.com (va-2-34.ptr.blmpb.com [209.127.231.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCC23278D
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768657; cv=none; b=M8SZUc1vf/oF9xbXvNue0NGGVCdfBu5Qwd4JJXxCKr6SAb0qy3JDZeraTGsif7KKpaGW5kF7WKOqWtUctKY3VUsVOMibAOAHMx1jE6wvZK5G7uY2yaWah6AXIkgOFhIaH61OEwsyJnnb8ozcYi2zpaaZiRe1nHEcXaK7XXZjrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768657; c=relaxed/simple;
	bh=dZ/U74Rh+ToGLvwdoAOBqe6JgzHatVb7sOjLaSXraek=;
	h=Date:Mime-Version:Cc:In-Reply-To:References:From:Content-Type:
	 Subject:Message-Id:To; b=nj2sXno3L+hrPPkifbs8F7kA05bojkciWCN1pOCGbfJTE43OiIVZZ/CjXHjqzcI5csEwPL6ioWEXQCXN+Ea5Si1BLS197mSFftuS/AVC8UN54eSmuMFSEMFT65gfpvRWIZqHyCGS1yb8g+YccIALNPkSb7pxWHj6GPKPO/U7Jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=aq81Gdwq; arc=none smtp.client-ip=209.127.231.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741768643; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bhuk+PeW14vgTYJMG3U2DMj9cthsz+9tLGPahSp0psg=;
 b=aq81GdwqOZm+psu8kOM/4cD5S1PGinArPFxDTk3C2hzleINHfJ183kpavMwMNusWDK4nwz
 8b7wr8/keZ9gzQYfexD1jYfQggaQP3rp1HEsGpepeg17F/1XIWFtxx4+EE0BLBEs4VApYL
 oys14L1ZrmJPhPNn32kdZD8W0goukFO5lZwtTfaTd5G6ondbhkATulgfKsAU7t6qK4WZ+t
 mIppsRnBKtElTmGQJWGSbl6pE0HTWavavY+iS1G+DpImqXIv2wTzgxUAd5H1zoPjk7VVvd
 BqUpEjLkXHooAkuIvahd5gtfyrZW6vYE3GkQGOB/0hIMuUUHLIClkKGR00IGcw==
Date: Wed, 12 Mar 2025 16:37:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 12 Mar 2025 16:37:20 +0800
User-Agent: Mozilla Thunderbird
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
In-Reply-To: <a5366506-2083-4957-b269-71e0a343be10@redhat.com>
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100827.555320-3-tianx@yunsilicon.com> <a5366506-2083-4957-b269-71e0a343be10@redhat.com>
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267d147c1+43dd2c+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Message-Id: <73300d46-81bb-42ab-85ac-19100f2346fa@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>

On 2025/3/11 22:55, Paolo Abeni wrote:
> On 3/7/25 11:08 AM, Xin Tian wrote:
>> +void xsc_cmd_use_events(struct xsc_core_device *xdev)
>> +{
>> +	struct xsc_cmd *cmd = &xdev->cmd;
>> +	int i;
>> +
>> +	for (i = 0; i < cmd->max_reg_cmds; i++)
>> +		down(&cmd->sem);
>> +
>> +	flush_workqueue(cmd->wq);
>> +
>> +	cmd->mode = XSC_CMD_MODE_EVENTS;
>> +
>> +	while (cmd->cmd_pid != cmd->cq_cid)
> If I read correctly, `cq_cid` can be concurrently and locklessy modfied
> by xsc_cmd_resp_handler() and/or xsc_cmd_cq_polling().
>
> If so you need at least READ/WRITE_ONCE() annotations and possibly some
> explicit mutual exclusion between xsc_cmd_resp_handler and
> xsc_cmd_cq_polling.
>
> Thanks,
>
> Paolo

Hi, Paolo

|xsc_cmd_cq_polling|and |xsc_cmd_resp_handler| operate in distinct phases:


Before interrupt initialization: |xsc_cmd_cq_polling| is used to

poll for command queue (cmdq) responses.


After interrupt initialization: |xsc_cmd_cq_polling| ceases operation,

and |xsc_cmd_resp_handler| takes over to handle cmdq responses.


This sequential operation ensures that there is no concurrent access

to |cq_cid| between the two functions.

The relevant implementation details can be found in patch 6.


Thanks,

Xin


