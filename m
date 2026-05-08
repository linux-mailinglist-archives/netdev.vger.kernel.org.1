Return-Path: <netdev+bounces-285827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB9EGhbh/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D44F6D2A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43604305637C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F53E0238;
	Fri,  8 May 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkiuW8Wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6712CDBE;
	Fri,  8 May 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245886; cv=none; b=KwN36T5DVXTj0AqnycHrR1hIoa+xjgAyqhosHLike7szaJ8aPr77USvgVDVB2L6EsgQVSw7nn/jHtOuZL8NG6ugBrkG+LPkD7EJp5zI+46I/xr7VyPhLvyO/A1Z5WRgMzQ8H7AHYxN6Cw4QQLtVLEMJNpYysYyj+JVNa4dED8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245886; c=relaxed/simple;
	bh=s4VkyW6Ymj0X647w5aPHLX8Impm8n/23UVTni3FkwDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FujBpkJikZknz6Ct5aV8/7+TWfLBW/cjxqSMbS2XyvoxATcVo2ElJxnRDfGGL9MrBamEDI9QRPzp4mtIW2mElUEqGamO3P2T8jcmNQEj4ZjcZmlzM1ci7TeIjy05n+zjWG0mcHL7UxmgtgKuQiW56D2BqXZsS0pv9dl0Go2uS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkiuW8Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD75C2BCB0;
	Fri,  8 May 2026 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778245885;
	bh=s4VkyW6Ymj0X647w5aPHLX8Impm8n/23UVTni3FkwDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RkiuW8WuvbCjoltHo2R7ImGHyTP1X+HJjXOvmiDGORAkoUjd7bRtnujJzi8NjZ62b
	 Aw5b2NBOr99kUVPPg8++4d+/pDa53NmlLoO2BLGwoNSkw0RtUEVA8GEbkewmHsyWXd
	 eHxGYOUp4BULphk4AXX6IKUdQS2UauhBaf4qdKhnvuJb8neHBdZ8kLyg/4fUqOvmIv
	 QDM5BONisY9nvg2Zgr5ZWVIrC1Ol+/muQ47FXI0P6TVmdTt2PunlkDgXyB30+p740V
	 xTW01VLSV+U84ccqsBgC1ZarJ+1JUI11CI2yA1GPwpw1lsV8BdDq/+zMC5huMpopMK
	 FodDD+H+FWwBQ==
Message-ID: <bb56ee81-dbcd-4aae-b5f9-64debb9c9bbd@kernel.org>
Date: Fri, 8 May 2026 23:11:20 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net: fec: do not use readl()/writel() for ColdFire
To: Wei Fang <wei.fang@nxp.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arnd@kernel.org" <arnd@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED1D44F6D2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Action: no action


On 8/5/26 12:46, Wei Fang wrote:
>>   static void
>>   fec_stop(struct net_device *ndev)
>>   {
>>   	struct fec_enet_private *fep = netdev_priv(ndev);
>> -	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
>> +	u32 rmii_mode = fec_readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
> 
> This is not an issue, but since you changed this line, the new code should
> follow the "reverse xmas tree" style.

Sure, will change in next version.

Thanks
Greg


> See: https://elixir.bootlin.com/linux/v7.0.1/source/Documentation/process/maintainer-netdev.rst#L380
> 
>>   	u32 val;
>>
>>   	/* We cannot expect a graceful transmit stop without link !!! */
>>   	if (fep->link) {
>> -		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
>> +		fec_writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
>>   		udelay(10);
>> -		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
>> +		if (!(fec_readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
>>   			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>>   	}
>>
> 


