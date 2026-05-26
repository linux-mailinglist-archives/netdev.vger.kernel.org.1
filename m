Return-Path: <netdev+bounces-291633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOA0DIdvFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FB5D3DCC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA3530214D4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02742388E6E;
	Tue, 26 May 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WwByJnow"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59934251D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789054; cv=none; b=pfVdyVF/9EyvYKHVAfNcT8F2NeFsnDO9zNUK3vsvuXeAYKJ+ADbA+fenCeOt1BWMhwRirOGrSHdHWt3T/GotCh8nvETtehKFpx6ZQ+4qzCm1+MKeq1Usv6GtpFoROZCKSWcrPRpKqN5CcvkzDJFlNRXbWfcC/TlojziPzVbtOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789054; c=relaxed/simple;
	bh=Br+gzZp2U03rnfB41jwEpCS1U3yzxl+cff8eUuJ4Jnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmi20H6Z1inw6ylpLmQpCJuDy4Pfy+ZiEXHpjZFm/x22Ud3jd7+PMrle7ufh0qMW/TuVWppLhzIVw/KdNcSS6McAWFl6AYRDS9CVE4cwswb9pWwgpGVR/2n479/wg5lkExLosq1b7oHgHHg5WueLRxRYZ/u6pg2oAZPG0Y0raCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WwByJnow; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 468671A36CB;
	Tue, 26 May 2026 09:50:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 183E260732;
	Tue, 26 May 2026 09:50:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B41910888491;
	Tue, 26 May 2026 11:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779789051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cJrJ1B41t3W0Gjxp+wDO9wWEitwpNtheEP+n2m47NlI=;
	b=WwByJnowx8HBkNxY0WMCDfOs1WcQdYYITl6Pvq4wOnWpYHCR8gcPsTRjuN2rUjUqJe3A6L
	H86yGn0oJe9ZiV3Fnrnh2s1nsvzi+auSgYeRKr9A+pse1vTMqjC0X7dTrWdZTuPruKMkBH
	mOsQInzsDzeBgKuQ5seWxPkAH4WK+E5yxyAaI/AFzTBE09eE5fdKsjpxkuGPuLSZn6sSwK
	oP936HG0l6+ivYPL9/XT9fSa9JS1IdtYyXBfyXACBh15zrS+MxUeONA4/+Wa3sRqIrun91
	k60iglCMHwSr6paE+FgQG9KbH6ISL7oyrQpwzcAWwGcFUkYZD3P25LQH+o+QZA==
Message-ID: <9c697d0b-027e-4787-b350-6ab7fbf30a2e@bootlin.com>
Date: Tue, 26 May 2026 11:50:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2] net: txgbe: fix phylink leak on AML init failure
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20260526090559.2095680-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526090559.2095680-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291633-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:email,kylinos.cn:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 875FB5D3DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 11:05, Chenguang Zhao wrote:
> Destroy the phylink instance when fixed-link setup fails.
> 
> Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

Something still looks odd with the patch subject. It should be :

[PATCH net v2] net: txgbe: fix phylink leak on AML init failure

If you use git format-patch, the cmdline should looks something like :

git format-patch --subject-prefix="PATCH net" ...


Maxime

> ---
> v2:
>   - Add the Fixes tag and targeted the net tree as suggested by Maxime.
>   - Add Reviewed-by tags
> 
> v1:
>   https://lore.kernel.org/all/20260522070749.1634542-1-zhaochenguang@kylinos.cn/
> ---
>   drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index f0514251d4f3..8e301e7d1148 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -521,6 +521,7 @@ int txgbe_phylink_init_aml(struct txgbe *txgbe)
>   	err = phylink_set_fixed_link(phylink, &state);
>   	if (err) {
>   		wx_err(wx, "Failed to set fixed link\n");
> +		phylink_destroy(phylink);
>   		return err;
>   	}
>   


