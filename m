Return-Path: <netdev+bounces-282231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULBpMaKB8WlYhQEAu9opvQ
	(envelope-from <netdev+bounces-282231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:57:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46C48EE7C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B318301A98F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468E329E47;
	Wed, 29 Apr 2026 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="oZxOoajT";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kWgGRYDo"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3F304BDF;
	Wed, 29 Apr 2026 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434777; cv=none; b=Z8GNA9EN6VrCciOsph6SLs7Sapk7X5UyZQPSbVjLgYRKkjBLgnJQ1Kzjmtsf9nEC66b8rdN8jvnAjXYgz94yYXQcC/BBSyZYihGv7JVoH68WGf1TyvuIawS84cXzxhJ8FI3exeZIeeRGkMTvinnLtAM4k5YyJl09yClClqbAv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434777; c=relaxed/simple;
	bh=B2HX1PM5n3v6UGf6lGhJXaxG5YbV920BqkBbCmtAv4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7F7lhP+1k2TM4wAu5xTuGz7NwNzqmdDyTaleDxgzgOs9yvGraaZjiH5mD85IvwW6g8b0Zylm3N44vriXNFkvSxcsn0Hpah1z+B+I3xXsUjrTog6g/fnYEVSk+5XX+DH6pkhqJZ5fQJ1iTJEwirWwxDGMh5sdfVf/nZyhxv/yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oZxOoajT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kWgGRYDo; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777434769;
	bh=B2HX1PM5n3v6UGf6lGhJXaxG5YbV920BqkBbCmtAv4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZxOoajT+YOjhYwgFm/dXcpF4GKMHC0dJ7VhdNRwkCfqZ4EaFn+OOGZv3nG6gISma
	 SZZP51glOz5DbZVc5Y4S9iZxAkaVzmTPpjrL64KB5i32jcyLnb+GHhxpNB9TA8TCQZ
	 v0QsNyH8Xk3qRdWFpnOibTTY+tcnLFowhG4F359nM9EZO6NemyDQ88Gw6nIU9n+Gva
	 JfQrnHt6G4Beaf2sBNH/7ycKX6i5Nu805jARpni7bTl19RGzplZSchhT1kvH/DQxBX
	 MmxBv0nnfsE9u/TU0gY/LW+SsyoaF9Rm5AMAswgcyYsXF0K7pSy5RncWf4yQNZz7m5
	 b4xJ0OkaDWeMw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 41F9047DF8; Wed, 29 Apr 2026 03:52:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777434768;
	bh=B2HX1PM5n3v6UGf6lGhJXaxG5YbV920BqkBbCmtAv4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kWgGRYDoO7Ge7fBRUGfGegL6TO2Y4W7UcT/wVTyd2U2J4XjJJWuNvoJQb2RA/CVZf
	 SG5n0IiEEkLO8ZzEOiIP8V0QA0StsZpzC3T0LqEjc++fkZ7AVIadQiD2gy/9TMC0vM
	 WwKctpjby1qSSCFuOGTCCjZ2Jteb4GXY29xqzJ5g74wM7rpde+Os2aW0+kSJxADo4c
	 TYEHTq7C5JKSmz/0xCYQIE51sR2y0ZsGyyvzHEUtJpV+yaeeF9RcMYof73nlQJhsib
	 sd4ODOVjApooJVGolS44ZIN2r/T6YiVaeQuhis6mcbNzCC8lS+yO3dqEA5AGBVHmfL
	 /87/8WAqQx9aQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5A06646FB3;
	Wed, 29 Apr 2026 03:52:48 +0000 (UTC)
Message-ID: <54e5e249-d947-4b0f-915c-e13bc4f6e345@birger-koblitz.de>
Date: Wed, 29 Apr 2026 05:52:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] r8152: Add support for the RTL8159 chip
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-2-52d03927b46f@birger-koblitz.de>
 <3e04d913-693c-44a9-a685-df9d0c9bd95f@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <3e04d913-693c-44a9-a685-df9d0c9bd95f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB46C48EE7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282231-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Hi Andrew,
thanks for reviewing!
On 29/04/2026 3:52 am, Andrew Lunn wrote:
>> +	case RTL_VER_17:
>>   	case RTL_VER_16:
>>   		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);
> 
> nitpick. The other switch statements seem to be sorted. So 17 should
> be after 16.
Will fix in the next version.

>> +		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
>> +		//nomal link TX filter
> 
> normal? Please also add a space after the //. netdev also prefers /*
> */.
Will fix.

>> +		sram2_write_w0w1(tp, 0x84b2, 0xff00, 0x6000);
>> +		//Training AAGC PAR (with uc2 patch)
> 
> space
Will fix.

>> +	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp))
>> +		return;
> 
> You should probably do something with the return value from
> r8159_wait_backup_restore(). At minimum a dev_err().
> 
I will add a dev_err() message.

Birger

