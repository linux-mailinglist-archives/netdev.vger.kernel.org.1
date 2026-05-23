Return-Path: <netdev+bounces-291081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHm8CtqCEWqYmwYAu9opvQ
	(envelope-from <netdev+bounces-291081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4A5BE85A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69932300F51C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014835B62F;
	Sat, 23 May 2026 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ES/THfEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DB25B0AA
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532501; cv=none; b=HY7m8V7ewTMqHv++0K+lHBtFBUeGl1kp+MhqJXL8ec3vOcBP73790FHQDPZsj57xoHdp4jlpQngM4n64GL/taXaqhcSZ5MXTcSDNFtg0r09IxkEQ1LB1YAYwZ3GDLDqVcsOuiYTaLjPXfzUEw/IAQ7smPErI19uyXyxjpjdeAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532501; c=relaxed/simple;
	bh=UhDVeAgs5MM60bf4Z0fUuZTJS8vHpaji8I67tg2mEgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tABnUryC4zpH9GcJUn9OVNZobIGj8SZs0KVf+TK/62xPCA2yy7/Lr9m6QuSOYqAM1bSNu2Kc9NGvCTonmdoatsVGOv6UM/lK5IzWU0f7RrqkadPa5D2SigE7k78wIDOrM5xrkXAlqeXlAZT1LfWKCO7j0zzKQYWOU+vnUEvxXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ES/THfEM; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:To:Subject:From:
	Content-Type; bh=oij44dKMQDraqYM66PoX/o84/gh89pogadBAxRYI4WM=;
	b=ES/THfEMSqwLAi2rX7woOhYft2me3Kw16hy91UQXGF1nW2j0HetWlNAJdre4VL
	uweQS0mnPSc3vDTa8XP4Gjr6Dl9JLcQe307uxTV37OGDg1DdGgwlESpDDfQyfOQt
	wa7nkbDnwzy/SVq6/7usC6O8K0axrvrDJZXJ4rHFQIbzY=
Received: from [100.70.220.18] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgD3P_a_fxFqYOLFAA--.3661S2;
	Sat, 23 May 2026 18:21:53 +0800 (CST)
Message-ID: <a3a9146c-1f46-490a-a5cf-aa81988b312a@yeah.net>
Date: Sat, 23 May 2026 18:21:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: luizcmpc@gmail.com
Cc: edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <CAHx7jf_HP3HOENCWa-nb3tMa4U_RXgXpYL38CsVmuMFqhyUpDw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <CAHx7jf_HP3HOENCWa-nb3tMa4U_RXgXpYL38CsVmuMFqhyUpDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3P_a_fxFqYOLFAA--.3661S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIALuI2oRf8LBDQAA3l
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yeah.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[yeah.net];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E1E4A5BE85A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz,

I meet a issue that strongly resembles the zero-window stall described in Bug #213827,
and I found your patch thread.

Since it has been a while, I am writing to check if this issue was eventually resolved,
and what the latest or finalized approach looks like.

If you have a patch， could you please share it with us?
We have a reproducer/environment ready and would be more than happy to
backport, test, and help validate your solution.

Thanks again for your time and for investigating this tricky corner case!

-- 
Best regards,
Tangxin Xie


