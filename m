Return-Path: <netdev+bounces-304891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xoZ2GFtbS2ruPwEAu9opvQ
	(envelope-from <netdev+bounces-304891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:38:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962570DA30
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=doyensec.com header.s=google header.b=e4olLd2R;
	dmarc=pass (policy=none) header.from=doyensec.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304891-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304891-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22279337C593
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0933EB111;
	Mon,  6 Jul 2026 07:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D073C13FE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 07:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322602; cv=none; b=Mco5AH6CW8Jg6HxC794Z+fW4cLmuzc8xoz37W1xhUF+5TJKz7NaTXqo4MZJxTCXPj4SYLyARw4VIhTMXTMAr9IIL1+CTY9A7swy0VvJNwYc6iJZk4OQeSX08WhRt3U6yKi7wMK1qcvgVNL3c540laFZWIcH3ydVBl9tgZ/N48/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322602; c=relaxed/simple;
	bh=tDK3bJakbO4xc+RPImKY1vISrF9CrTpHMZcVbvB8fvk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ChZRDmHxTd3sYTsGpJVRGSzn+2vfTL1h+i5DLoPnxtrhoVSJ9BheBeP9EsTFdc048nRDDIXnOdkmB3J5k5P7NM/rlYyhQHb6lvE0rm7vPek7AAcBbZpB70MMc+HAuzvoGddy8wk4CvN3WCcvzUUS6gwIci/YOSptbK7ytmvjzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=e4olLd2R; arc=none smtp.client-ip=209.85.218.68
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-c1276f8414bso318419966b.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1783322588; x=1783927388; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXXZy0uXlVP9m5zzxq7VljNYsj3RxkcIAny3dfUaojI=;
        b=e4olLd2RcmKEog332rom/yHo6GvdQGV8L63+LTjqnHNy3e03llcBWxKLHelL+fPudB
         sV21v1HCay8Kxlm1wHrcHTFmWiLV9spR5qVpmIQmvofvBO7lsKxRF1pS55S8vnU1Jirb
         wOMxa87m5NUDjDTB/wcqNOZsGSfDvlVDpnT3sEGsMHXUfgXIp8EDKjHFVHPn036exFXF
         ei58NiyzOKdcVoSn51g6uw1CJqOmJOX6BWjy0z0a6yUuhJKqa0kv1aEDCbwWKW77fObK
         0bKaTWeVbtFiyoNg18y9frsGtbhVaS8ziQT+NIz5xqONvOxZdxYn6s8H8K/bMF/xj2ro
         W7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322588; x=1783927388;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXXZy0uXlVP9m5zzxq7VljNYsj3RxkcIAny3dfUaojI=;
        b=iQg6sxOOvzNT1I4ta6NiG9NcdQ+Q68DtUCt0uDJnTwEwWkvMFpiuDsXOHg2gIiMwOx
         ZVb6Ah05x+5nzeZt6r4wzzxN/jdrUt91trFEBsJgm+ddCcOd6oJYFNaUgq4Q0BCnqcot
         cWqmhBHbiVeDA3HLf8nVlh5QbJdn3nq10K2RcO9QlZ+7xUVU1GAKd2L6Wi89davv9haP
         FhXOYGw5C9MDYixXEYySI314iPh+9JJWI2HOkodqGdtuyT4YCVceHgDqseGUIa8TBbPo
         yN1CRtajsR8DmBwtmYkuu4QwnFK6Zrss/6d0K57ZTuCDekbSDLr/RFwgRfrvM+Qu3nTV
         SdwA==
X-Forwarded-Encrypted: i=1; AHgh+RrRcKoJf7X0bdMTKz/gBrOI+pogiSyV5haMs8+55nq6mN4LCcoh3KuUKzjCY0nYz7iIswug9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3g19RElz0Shjt+0T+9lhlnkzMTebJze1o6IP0Ruf+AJRM05Eh
	6caCwxtPPGpMNpa4uaFAjZGIOU8KRdMw1j6y3jlmc031P4D6JQblkN/uSdqeLqip+Bw=
X-Gm-Gg: AfdE7cmTdTlgoSQL9VPxi3c1LzNm3NntmQv9rZFoO6feSflL9NYcC9oMg9s2D4uXnrF
	7lGbWC8GlvyYJAQJahMYIa46qdz6FTR/47cy6pQkT33qOqW0kUo5LOSJd3Y5hzn394QGQ/msQ/7
	xMBfjdbw+GWusrxCdfh5ANQ9jaJH/30r4fJ29iCxb7nI8yxUiT5ZE+Vz/0CBLZJTJyoHVdLu/8V
	r4nAzblbdVijsAabWYGcPFVmB7Utylh3d5Rptaedk7TS4cNdU7wH0bVK0CcuQdRXAsY8zu4WDyO
	yJqZWGTHDa2nTbpuPSs5L52DjrLcmIIIUOMcprVAulavOl3mWsYIV/wM5N2wsZjDTUlRAY+dDgJ
	qJ5AHNVlYBdTpJaT/VyAuHq78XT7feeg5gacLWcb/OjbpE9b+IuwTXWxCa8F7QBac5ayRVfZxi4
	RaAP38/XrpaDfjjIY0ojahyGjqzZVU+0u/RFkr7Ckvk89QtKGLfEK8qVdgDfElV9xKbjKORKOxv
	PipVokT/k1YIFh/k2A642WhTv6fvOnqOszyiQPyP10HQ5Pf0hw3Gd8=
X-Received: by 2002:a17:907:ea7:b0:c12:8d49:48c6 with SMTP id a640c23a62f3a-c12e6c0c068mr364764766b.55.1783322587822;
        Mon, 06 Jul 2026 00:23:07 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.57.ipv4.supernova.orange.pl. [83.10.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f6e3dsm672525966b.62.2026.07.06.00.23.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 00:23:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
Date: Mon, 6 Jul 2026 09:22:55 +0200
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Breno Leitao <leitao@debian.org>,
 Taegu Ha <hataegu0826@gmail.com>,
 Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF830A2B-D69C-4233-B210-9AA7D9626589@doyensec.com>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304891-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:leitao@debian.org,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnault@redhat.com,m:netdev@vger.kernel.org,m:qingfang.deng@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,debian.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[doyensec.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,doyensec.com:from_mime,doyensec.com:dkim,doyensec.com:mid,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3962570DA30

Hi,

> On Jul 3, 2026, at 09:27, Qingfang Deng <qingfang.deng@linux.dev> =
wrote:
>=20
> Hi,
>=20
> On 2026/7/2 2:12, Norbert Szetei wrote:
>> +/* Purge after the grace period: a late ppp_input() may still queue =
an
>> + * skb on pch->file.rq before the last RCU reader drains.
>> + */
>> +static void ppp_release_channel_free(struct rcu_head *rcu)
>> +{
>> + struct channel *pch =3D container_of(rcu, struct channel, rcu);
>> +
>> + skb_queue_purge(&pch->file.xq);
>> + skb_queue_purge(&pch->file.rq);
>> + kfree(pch);
>> +}
>> +
>>  /*
>>   * Drop a reference to a ppp channel and free its memory if the =
refcount reaches
>>   * zero.
>> @@ -3581,9 +3594,7 @@ static void ppp_release_channel(struct channel =
*pch)
>>   pr_err("ppp: destroying undead channel %p !\n", pch);
>>   return;
>>   }
>> - skb_queue_purge(&pch->file.xq);
>> - skb_queue_purge(&pch->file.rq);
>> - kfree(pch);
>> + call_rcu(&pch->rcu, ppp_release_channel_free);
>>  }
>>    static void __exit ppp_cleanup(void)
>=20
> AI-review found an issue: =
https://sashiko.dev/#/patchset/D9C0245B-608B-4884-8A09-F55BA4A9F948%40doye=
nsec.com
>=20
> An rcu_barrier() call is needed at the end of ppp_cleanup().


Thanks for reviewing. I'll add it and send out a v3.

N.

>=20
> Regards,
>=20
> Qingfang
>=20


