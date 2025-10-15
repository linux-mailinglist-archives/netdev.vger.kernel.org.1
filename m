Return-Path: <netdev+bounces-229421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FFBDBF29
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2698345B17
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FB1A9F90;
	Wed, 15 Oct 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jSl1MXQ+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F91186294
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490207; cv=none; b=r3Ryo7OTRjpFXB1kDuR5yuRoOZ5h7s2cfPh4XOoCFTb1sNoQmiChSq9niWF54YwuSzIpAaPtylPrdL8rAQekp3j50Fr1VxkxV/pLbo6HpAmrr/cYYGHVtHLVAUH+HuAIpBvgh0dsBpONhdicQwE81RmibA7CG6JiWBEqOzkTPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490207; c=relaxed/simple;
	bh=hrCTI/HHe4IFxP2VQsZiuqQ5NMTLIl8DkzgLHOg3l6w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oeCG8PV/5RU8Zkgm38BIjsCCfpY/goOLj0CsBX41M9FhclBhMhwfyhnFhSc6r8VbQmLLkfKsJncTiRPQJgMMYvjlsKP6WaY7fK3h64Qg9m79V1ynFLLgp4gVcR0aK8axgXMUi9tJkhfZQz2aoYOSAQdkngeVzhHoTof3PHa3dJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jSl1MXQ+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760490196; h=Message-ID:Subject:Date:From:To;
	bh=hrCTI/HHe4IFxP2VQsZiuqQ5NMTLIl8DkzgLHOg3l6w=;
	b=jSl1MXQ+ziXToj/jSfpLkKFO04hO+ofBSixjq3MYroAppg2zNvQLh64/GbygCsZig6KT8qD6rxW16yKIX+NPX43nwUgzwk+/PGiETHrzhAnqNW1nMLmw8+RDPMt0lo3pq1GQderWd7Of3OQrkMUqVzRNtEumOvRa+6Ubl+TzW7c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqE3gHW_1760489875 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 08:57:56 +0800
Message-ID: <1760489853.539487-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 15 Oct 2025 08:57:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 alok.a.tiwari@oracle.com,
 kalesh-anakkur.purayil@broadcom.com
References: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
 <jhvl3gx63kt3xcgx3o4ppsqftgzupjojf3ygblnrapcneuks5w@cgfydxsalyii>
In-Reply-To: <jhvl3gx63kt3xcgx3o4ppsqftgzupjojf3ygblnrapcneuks5w@cgfydxsalyii>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 14 Oct 2025 14:19:29 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, Oct 13, 2025 at 04:18:33AM +0200, xuanzhuo@linux.alibaba.com wrote:
> >Add a driver framework for EEA that will be available in the future.
> >
> >This driver is currently quite minimal, implementing only fundamental
> >core functionalities. Key features include: I/O queue management via
> >adminq, basic PCI-layer operations, and essential RX/TX data
> >communication capabilities. It also supports the creation,
> >initialization, and management of network devices (netdev). Furthermore,
> >the ring structures for both I/O queues and adminq have been abstracted
> >into a simple, unified, and reusable library implementation,
> >facilitating future extension and maintenance.
>
> Is this another fbnic-like internally used hw which no-one outside
> Alibaba will ever get hands on, do I understand that correctly?


This device is included on Alibaba Cloud's publicly offered cloud servers. This
setup is more similar to Google's gVNIC (gve) and AWS's ENA devices.

Thanks.

