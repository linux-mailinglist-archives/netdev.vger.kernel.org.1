Return-Path: <netdev+bounces-105080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F3F90F9C8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C65B21EA9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715215B14F;
	Wed, 19 Jun 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWR1s0i4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F342762C1;
	Wed, 19 Jun 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718839604; cv=none; b=o+4+Wa85SaCBGMrW5rbCmFiX4b46y1oK/s/kXrC8+zQ2BWhwdEVkT9se+i6MBaf7EWjgE96ug4duU2XsKPGGoEQOa4QQyIpwn5r/FUaWHhXty+7Mdvqhl9LqECxrRJsnXNLbFtizEszQYDXhdbmBzJOZL2KxdnkMPBgZwqs3Q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718839604; c=relaxed/simple;
	bh=LtTbeDwGyrVBMp8h9erKfHHqg9wGUZ8l9PdqfjyUg00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6qvkcKX9wiDAf1kd89DEVLBqEXXWs+WwdlweYS417Z55LeNIye+ezuMKeQkgPvZ2866dsp6CcB2H/RJy11vBPD2weDwC4/PhgyCkmuP6R/u+a/zopVjsNVSWLjINqcb5QWYQAhGi2tvsIuHYjeO5gaOZosy7R7/0U4DvFAROXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWR1s0i4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1150C2BBFC;
	Wed, 19 Jun 2024 23:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718839604;
	bh=LtTbeDwGyrVBMp8h9erKfHHqg9wGUZ8l9PdqfjyUg00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QWR1s0i4kNpNlA2Q93rqX11eyYTIQsSBgy4NsKctzXzUE6+bjwodlRwd4hGnkEh+e
	 qiGoChcPMZT51i2dCYhk3VCOqPYuY68vRp6KerrN1P7lDbL5O/JAvR81hnlHOO1xeI
	 DeO5vSM/eNBdQAqDo1mV0TqmXjiINvqP6DOerkjr6KNYIe4YfPrbY7GUNSJwJGZbG7
	 c46u8Pnyt8DLHmIRbk/H15p+KLr5TquYkBArq46sQ90gpVPnd72Bii3mN6FYegNkAB
	 UGGWZP2kcz2pYAiO5kdIuY71+v3yJMKnqlkDBpNcvyHN1vuiwjgtqm5vhyGqUgRFoo
	 Wu7jjFwLVv5pw==
Date: Wed, 19 Jun 2024 16:26:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240619162642.32f129c4@kernel.org>
In-Reply-To: <20240619200552.119080-4-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
	<20240619200552.119080-1-admiyo@os.amperecomputing.com>
	<20240619200552.119080-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 16:05:52 -0400 admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@amperecomputing.com>
> 
> Implementation of DMTF DSP:0292
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC) network driver.
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.

This patch breaks allmodconfig build:

drivers/net/mctp/mctp-pcc.c:116:6: warning: unused variable 'rc' [-Wunused-variable]
  116 |         int rc;
      |             ^~
drivers/net/mctp/mctp-pcc.c:344:3: error: field designator 'owner' does not refer to any field in type 'struct acpi_driver'
  344 |         .owner = THIS_MODULE,
      |         ~^~~~~~~~~~~~~~~~~~~

In addition, please make sure you don't add new checkpatch warnings,
use:

  ./scripts/checkpatch.pl --strict --max-line-length=80 $patch

Please wait with the repost until next week, unless you get a review
from Jeremy before that. When reposting start a new thread, don't
repost in reply to previous posting. Instead add a lore link to the
previous version, like this:

https://lore.kernel.org/20240619200552.119080-1-admiyo@os.amperecomputing.com/

See also:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested
-- 
pw-bot: cr

