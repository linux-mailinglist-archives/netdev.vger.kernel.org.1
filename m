Return-Path: <netdev+bounces-253048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UlsBIupydGn+5gAAu9opvQ
	(envelope-from <netdev+bounces-253048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:21:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893387CCB8
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A17B30087A5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08E234973;
	Sat, 24 Jan 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Sige9voF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368253B2A0;
	Sat, 24 Jan 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769239269; cv=none; b=snkV5pd+nWPUGg3hkH91NisIuewLC271mQGpN0vV85mOY1moi0X5ugzxL7Nisp9BDJHGxVoxyJwevc6rLKajTDtRI4ZVUrX1aXnfWSNXhEMWTLvzR6Xo0O47Kz9veKUIRFMlZnnOOVbUm8mI2xxJPDLtUVVXENs+cAIOztWfgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769239269; c=relaxed/simple;
	bh=SoncGxoZMB7pbdKfAHnQn6jYRseJnb/LhiIsiXJyo5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8arsGvAW3ik9k0k1DxYkHcJmsNrpmGfcvVasvR7vbq2wbXJmZfKTNAaDodcSZQ3Z3tKCvkpFc14EfWf3RTH5jitano7U+RY10mFFe66yAZouFNCGmhAYtqi+Lx4OeRKcZd+X3403RnzoOPXZYfcWBiLrOG/8UdTNiJACnLvWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Sige9voF; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31d153bb2;
	Sat, 24 Jan 2026 15:20:59 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] net: liquidio: Fix memory leak in setup_nic_devices()
Date: Sat, 24 Jan 2026 07:20:57 +0000
Message-Id: <20260124072057.3914059-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aXOuByqgZ0iY81ak@horms.kernel.org>
References: <aXOuByqgZ0iY81ak@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9beee0a87203a1kunmaafecf32af447
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTBpDVklLTkNJTBlPTktDT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Sige9voFugN9P/glppitMBESTMD2o81ATQVlWjiUk3lBdOXvUj8N7MioAcc7iAD/OBDFuygrU1AGi1HKffVTcCZkbVuLoBnl6TLcMEJ4OeZUyHfuBdt79ffchuEf/QA+NHt7UrGmo/YOAeLyStq09Y8/VlJqnT8lI3jiE35crio=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=NtYZSyimttopK8O5npYCRbUNJYNJIPR7JxiwWMOWbL0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253048-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: 893387CCB8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:21:11PM +0000, Simon Horman wrote:
> Thanks Zilin,
> 
> I agree with your analysis, and proposed fix.
> And that the problem appears to have been introduced in the cited commit.
> 
> But I am wondering if we also need the following, probably as a separate
> commit, to ensure that liquidio_destroy_nic_device is called for the
> element of props[i] whose assingment your patch addresses.
> 
> Also compile tested only.
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 0732440eeacd..3ba2806f5d1e 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
>  
>  setup_nic_dev_free:
>  
> -	while (i--) {
> +	do {
>  		dev_err(&octeon_dev->pci_dev->dev,
>  			"NIC ifidx:%d Setup failed\n", i);
>  		liquidio_destroy_nic_device(octeon_dev, i);
> -	}
> +	} while (i--);
>  
>  setup_nic_dev_done:
> 
> ...

Hi Simon,

Thanks for the review and the suggestion.

I agree with you. The current while (i--) loop indeed skips the cleanup 
for the device index i that actually failed. I also noticed that 
lio_vf_main.c shares the exact same issues.

I'll send a v2 series to correct both files, and I'll include the loop fix 
as a separate commit as you suggested.

Best regards,
Zilin


