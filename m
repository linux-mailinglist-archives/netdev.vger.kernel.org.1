Return-Path: <netdev+bounces-278303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME3KFwvl3WnDkwkAu9opvQ
	(envelope-from <netdev+bounces-278303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:56:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1853F649B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1B1300BC8B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894033F5B6;
	Tue, 14 Apr 2026 06:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28B2DCBF4;
	Tue, 14 Apr 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149739; cv=none; b=a9CLwyRrnjKGCobKMSukUTknreclRzAr1X6jUye4OCeXfr401u9WmliOKreLip9dg2PY0VuoqHtfGxV7CPc/k6zxzBIpTSH7Z3AnCy5hWtQMFvBG/IsS2/94uv46jEIExHS3kcAtee18UGPqQzbRD7h2qpqN/vZGOddkmwT5eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149739; c=relaxed/simple;
	bh=P0B2p6l5ufYG8pdbcjeSe9t2EgGMbl5gsQRwqpdh+Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf4HSlhpbFdjly7GDHM/oK3mcsFkg9O1k1X6To7wSaRn4GoYY8IWL5nWEgdnap1o7uOSpusThPLi9x/sq5gYAQqDiR7i+FgeMiddHp9l7RVH1F9RAnHlln8pYS5x+EBqQtYlZI5jD/unM4z4B9hOBTT3EtKMPa3sb4IPn5ENs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af0da.dynamic.kabel-deutschland.de [95.90.240.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA7B24C2C37D56;
	Tue, 14 Apr 2026 08:54:55 +0200 (CEST)
Message-ID: <afefe8b5-5bd9-4019-9d12-5ee2a7f577a2@molgen.mpg.de>
Date: Tue, 14 Apr 2026 08:54:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 stable <stable@kernel.org>
References: <2026041116-retail-bagginess-250f@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2026041116-retail-bagginess-250f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278303-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,davemloft.net:email,sashiko.dev:url,lunn.ch:email]
X-Rspamd-Queue-Id: BA1853F649B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Greg,


Thank you for the patch.

Am 11.04.26 um 12:12 schrieb Greg Kroah-Hartman:
> When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> uninit call will trigger put_device(), which invokes the release
> callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> iadev.  The fall-through then reads adev->id from the freed iadev for
> ida_free() and double-frees iadev with kfree().
> 
> Free the IDA slot and clear the back-pointer before uninit, while adev
> is still valid, then return immediately.
> 
> Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev

The commit hash is pasted twice.

> deinitialization") fixed the same use-after-free in the matching unplug
> path in this file but missed both probe error paths.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable <stable@kernel.org>
> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, these cleanup paths are messy, but I couldn't see a simpler way
> without a lot more rework, so I choose the simple way :)
> 
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 7e4f4ac92653..b7d6b08fc89e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
>   	return 0;
>   
>   err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	vdev_info->adev = NULL;
>   	auxiliary_device_uninit(adev);
> +	return ret;
>   err_aux_dev_init:
>   	ida_free(&idpf_idc_ida, adev->id);
>   err_ida_alloc:
> @@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   	return 0;
>   
>   err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	cdev_info->adev = NULL;
>   	auxiliary_device_uninit(adev);
> +	return ret;
>   err_aux_dev_init:
>   	ida_free(&idpf_idc_ida, adev->id);
>   err_ida_alloc:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

gemini/gemini-3.1-pro-preview has two comments [1]. Maybe the driver 
developers could judge their relevance.


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/2026041116-retail-bagginess-250f%40gregkh

