Return-Path: <netdev+bounces-253546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMh2LNSbd2nOjAEAu9opvQ
	(envelope-from <netdev+bounces-253546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:52:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125B8AF86
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3275300AEE9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3553164A5;
	Mon, 26 Jan 2026 16:52:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9632FE595
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446352; cv=none; b=KuTSlKrSth3HR07E+c1KuVW/PnqkEW7wlYxsDol2zJT69qHkMuqwsBWkSvwmL73nlg3otMtGTJNTHGH4ArBvjL5mReyNBC47Z3sLXQahpWnLrigEbecN6Wthj4vS8OOTBWV/kmitKFde9bBO9DiuT2+aVGBLpqESZuOd2AHeVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446352; c=relaxed/simple;
	bh=NiHBSZZhoC4mVg0AtlJMN8hAj8NU53x4UkFW2EF0jdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2k5jvGPHcEgVU8pe4RLfi/ZTa5DQGQCp/6fZghCjxkzhdgEzKUMw7awBFGatA/cEZLKecBSVo+fdY+rve834yo9hvnFpHorBWvhIdbICLSMQr95Z8OqeUgnrcZzxe+ngiq1SHA7D1G3ylDVULmTTPAI42erqAGCfW89VXAFlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.221] (p57bd931f.dip0.t-ipconnect.de [87.189.147.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BFB144C4430092;
	Mon, 26 Jan 2026 17:51:37 +0100 (CET)
Message-ID: <4eae4d1a-8043-4186-bd38-87f47dd35eda@molgen.mpg.de>
Date: Mon, 26 Jan 2026 17:51:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] i40e: add an error handling path in
 i40e_xsk_pool_enable()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20260125140423.2077845-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260125140423.2077845-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[mpg.de:server fail,tor.lore.kernel.org:server fail,molgen.mpg.de:server fail,iscas.ac.cn:server fail];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253546-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[molgen.mpg.de:mid,iscas.ac.cn:email,mpg.de:email]
X-Rspamd-Queue-Id: 2125B8AF86
X-Rspamd-Action: no action

Dear Haoxiang,


Thank you for your patch.

Am 25.01.26 um 15:04 schrieb Haoxiang Li:
> In i40e_xsk_pool_enable(), the memory allocated by 
> xsk_pool_dma_map() should be released if some error occurs. Add an
> error handling path to do so.

(Please be aware to use the fully allowed text width of 75 characters
per line. (It wouldn’t save a line here though.))

Please add a Fixes: tag.

> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn> --- drivers/
> net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++++++---- 1 file changed,
> 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/
> net/ethernet/intel/i40e/i40e_xsk.c index 9f47388eaba5..92b853a75b28
> 100644 --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c +++ b/
> drivers/net/ethernet/intel/i40e/i40e_xsk.c @@ -108,23 +108,27 @@
> static int i40e_xsk_pool_enable(struct i40e_vsi *vsi, if
> (if_running) { err = i40e_queue_pair_disable(vsi, qid); if (err) -
> return err; +			goto unmap;
> 
> err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true); if (err) -
> return err; +			goto unmap;
> 
> err = i40e_queue_pair_enable(vsi, qid); if (err) -			return err; +
> goto unmap;
> 
> /* Kick start the NAPI context so that receiving will start */ err =
> i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX); if (err) -
> return err; +			goto unmap; }
> 
> return 0; + +unmap: +	xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR); +
> return err; }
> 
> /**


Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

