Return-Path: <netdev+bounces-307102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rDN5JoeuVGqGpQMAu9opvQ
	(envelope-from <netdev+bounces-307102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF96749413
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307102-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307102-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F975302A68E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39495390204;
	Mon, 13 Jul 2026 09:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097733CAE84
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:19:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934349; cv=none; b=dQfetpJKnGrYgKouTG9tIPqXNsJm4KpzxXqTNEoNodLOdPo0kLdWiEhEFC4Rnf4E6L1dcGqwnab2JKAxifJDG1P2vzZo2hF1NVr8k9fkWdoL7eqk44SZhcbMEq6mB0wPe77U/Dp8WK66Pxq+Qy7au7uPFqvsHBhiHrtVvzxGgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934349; c=relaxed/simple;
	bh=66fnQPc6NfEMenLRaH1sCiuTu+74Ifuu6XqWtGQ7Xqo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y5nAaaKbA5rmTzYR7EuCXB5rzynUAhXtoXUemTqLwsN4rMhz8MX037um1rFCbwCPn9tA61pOa7MWUfiH3aEw1Sk2z4AYdvAOxl/b7PLcRWrvYF0N4X2GhNp0a6vCRbN21USXhjsb0owl88y0d1TZPsIYT0bhv62UycZ4P+JmED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid:tivesync1t1783934276t32a2714e
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.247.46])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11718294743674349415
To: "'Chenguang Zhao'" <chenguang.zhao@linux.dev>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>
Cc: <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>
References: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
Subject: RE: [PATCH net] net: txgbe: fix heap overflow when reading module EEPROM
Date: Mon, 13 Jul 2026 17:17:54 +0800
Message-ID: <0dfc01dd12a8$7c8639c0$7592ad40$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKttDZf9zIC+/JkuiYPfoZv8cLUjLTJ5Wcw
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M/ESU50hZOEX0nAH8kJtyvejKuq2fN6Wa9Yququ/ny4WFqV2dG6gJumF
	0phhly760fgg54SsuaoncMDRruNNUK4MZkM8idlm66mZKlBSCFVK8fGCCRegWaxGHY+76e8
	fz8mZHyK4wh/MuNvf5UDu9bI8jwt15znm6JWa6QNjnHYtFBo1VTd2kfstBICyi7Rlm6sq/P
	ylZlbN8TacdldBbSEgaGgHQ3MW6p5KX0mFMXyCT7geX5VFkA21EM+6+QdPs2oqbhWaewBbJ
	IdYmhn0pONGU7hjdlA716+pB1EDqrnsG4FE9rXmBqyDCCG3cOJT9fCOVFY+rGb7FOTOg04w
	PsigvsMAMNsA9B3CcRxg3uT5LqQg1N4TIv4emO/ek717TxvNB40S4KsDMIL3Bg36tXov9vj
	6bFboOPiv32d9K6t57MujWzaaWZmUx/jGjNftirpktLbobbfApnftQ9Zvq8wFEB/lL5PTLa
	QygRdYb9c0BdCRMlU1q65WFIlUrYEaROJr1lywcn7pfAcYAmJoPGf6/g9X9o4vGyvJYyUGn
	Ss9LsMiffMVlSdAQ8PRuXWcaxCWkX6Zrk8TFPXUMn7jRkCWATpN0IGLZua7TQS2RX/8BRwL
	ph7XxWmMkdE5316FVTMv7og0TAXbTrZhIiSiJYRHEMBbTXTTGHqw9hWcqeJLe3tlMsV1M14
	qHuc4aoe33yU+sL4cUvqaDb1GdqcIZi7MBEOpyq3B29nm3NmbkgHpYaIBiHXQtTRn11gCGL
	cOqLgl76sp4yIoOPS9sOTJRLzEAB3j8Hs58oWfMW4Rf35NvPzjIKI9PXD2ZTjgODmsHGIiG
	NshsQ8o0srMyZpb7tYeNn+vuFbZ8tYQoKKHAhrqjQ7RomKGT84tK+wvTaqC75RBJEzNsamL
	RJJTzI0+usi1PnnoifnTPLaHN5MUrdSBJGXQfUB1y6aXddv/h56BEPppyJze2iAaRS581vi
	Y4S2ZpoYS9jn71+L/ggfQepJexN48BK4c7FNgrzw1t6AEFbRXqznMvMtA2zChtA/s0DYHj+
	piX/16X553096ndIkA8X2HVWrFoUHhI+swbkL/XlZi2j8woBNDoeH4nLDjrv0lWzjhKPy2b
	Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307102-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:from_mime,trustnetic.com:email,trustnetic.com:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EF96749413

> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> txgbe_read_eeprom_hostif() always copies round_up(length, 4) bytes
> into the caller buffer, which ethtool allocates with exactly 'length'
> bytes. A non-4-aligned length therefore causes an out-of-bounds write.
> Copy only the remaining bytes on the final dword instead.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index affea1a364ef..26d0cfc58ee2 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -96,11 +96,13 @@ int txgbe_read_eeprom_hostif(struct wx *wx,
>  	dword_len = round_up(length, 4) >> 2;
> 
>  	for (i = 0; i < dword_len; i++) {
> +		u32 copy_len = min_t(u32, 4, length - i * 4);
> +
>  		value = rd32a(wx, WX_FW2SW_MBOX, i + offset);
>  		le32_to_cpus(&value);
> 
> -		memcpy(data, &value, 4);
> -		data += 4;
> +		memcpy(data, &value, copy_len);
> +		data += copy_len;
>  	}
> 
>  	return 0;
> --
> 2.25.1

Thanks for the fix.

Fixes: 9b97b6b5635b ("net: txgbe: support getting module EEPROM by page")
Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>



