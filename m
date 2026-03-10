Return-Path: <netdev+bounces-266205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UERAJhs7sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A16253BDB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8358D32A1D94
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2E3126CA;
	Tue, 10 Mar 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qfcVLi5M"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4518A93F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154241; cv=none; b=p8nx+xzhVvU3FkOR958csn7KEv+KelzGprRYjWFTkQlDVHxG2+TH/98woQvRSs5kcyRkoyUfmnIvk0Ui6hb28NMK2dYTlb3XKds9PxBjdJDE9BZW/Sl4lJsbfpo8l4BzF5xLmmZr83Lh1pt4RisKUpfcr6AZu9ebpDSWAgHfhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154241; c=relaxed/simple;
	bh=mLu8o4gLucrIvwy95G1zG1rpQUwOyhDjHL/WelH6wTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmUNVIZ6qyG0ZxPEnN39tnnM22G0S9XBobtD+WGv/WNoQTL9JtXXH+KQiBXL380D+gbT0FydaigFUtzFk06HO/S8Mbvn6rhTb0Fv5OYBQ7qnnHclRDFcKYcVpc71viYG3n+y4sQKYHvDiUlnrM+QyGJixk4KC3kF+NweqBX2w2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qfcVLi5M; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b69dbd8f-c19e-460a-b0b4-5908a3df4ef5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLu8o4gLucrIvwy95G1zG1rpQUwOyhDjHL/WelH6wTY=;
	b=qfcVLi5M7oKahIdyVWtRwer6YsiEa1OcI1kcH3ZeaYT6a9nfXYXkYvIErpdqH6dPK3FAmp
	FyVtilcfxGTreFSVW2x3F0KiSL4RSD5DMEnG66XP3oobBX65vJvAurTpU0A89PP1EOC4bo
	5uOBOJTvAtZDqLK7wxLhGn6l0X3tzqE=
Date: Tue, 10 Mar 2026 14:50:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant Add support for the Adva TimeCard model built on a Xilinx-based
 design. This patch enables detection and integration of the new hardware
 within the existing OCP timecard framework. The Xilinx variant relies on the
 shared driver infrastructure, requiring only small, targeted additions to
 accommodate its specific characteristics.
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20260310093559.222360-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260310093559.222360-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 67A16253BDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	LONG_SUBJ(3.00)[401];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 10/03/2026 09:35, Sagi Maimon wrote:
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Hi Sagi!

Looks like your commit message was squashed into subject line. Please,
ensure you have 1 empty line between subject and commit message

> ---
> ---
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603100054.UoKwTVMf-lkp@intel.com/
These are not needed as the code is not in the tree/

Please, wait for 24h before next revision - you may receive some
feedback on the patch provided

