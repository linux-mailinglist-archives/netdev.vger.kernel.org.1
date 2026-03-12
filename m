Return-Path: <netdev+bounces-267165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFKAD1rusmnAQwAAu9opvQ
	(envelope-from <netdev+bounces-267165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:48:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD6275E8C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32D803035F65
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F13FBEAC;
	Thu, 12 Mar 2026 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSD11Ubg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaCIuvrP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBE3FB7E3
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334081; cv=none; b=CiXGjZqpAXbxzCY3y3Y/uSYzOPR4dbnS6EherhX8lHB4NuVpnJVXChyOjHasccwGvhmmYoE3n0BcBmt6F/Ul8JgYp2Zej2q6xR3J9vcgyP6C8w5oD/wjMmDHr3i5CryPyJTXCPIoeAytsJIN4lOHGq4mekn7RpiG4lOMRzt2KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334081; c=relaxed/simple;
	bh=IIb3lnFy9ZZgffcMQ1sb/OxpBNFDfrikKLoctgY2LdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm2tBJK4J7C+Fah4b0gZAAeKxuhmfY6LeDw7XHB9AN8ACHwF7lnr3hdJytxwVHaPhbwMG078vMe1VXKdAl6kxLychoU3WXJC15aFkJcrwAIdKcrPGg1cISrHuti+gPaq8gH6kdQEKIunW90E1r/Zb2PEhpJMV7dqcKT2wn2we50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSD11Ubg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaCIuvrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773334074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QopztaDQaDXdF0WurIHvj6v5UeE/ENNGQg9kHKBDRS8=;
	b=HSD11UbgDtNkzf8JWpCHmLPrl9FJef5AoIbzkA9wK77toHHJ5A+byksQ7VPmYA/FSu9O3c
	Top81AjbYKQWur9iVWX16m6CcggxM0psneK8U+Za07UYBFNULyOYZwTXyjsmtewmEBWt75
	qnTiIFXj8QD3Gl/DknC6FHz31yinO84=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-9yjsAKvkNLW56IjzoHwl9g-1; Thu, 12 Mar 2026 12:47:52 -0400
X-MC-Unique: 9yjsAKvkNLW56IjzoHwl9g-1
X-Mimecast-MFC-AGG-ID: 9yjsAKvkNLW56IjzoHwl9g_1773334071
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a1324aeb32so885607e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773334070; x=1773938870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QopztaDQaDXdF0WurIHvj6v5UeE/ENNGQg9kHKBDRS8=;
        b=KaCIuvrPozJl4hzNOEU/PrWY3Qnw1BOto9eRbhUazRMIM3Vj2cZmIuRFH3QzZSABGb
         pp5SQ8Th03YYwUHuvS5DYeLL04MmCb48zmhDextkfYJGb7KYGFmR2VKA15W4J0M7CTVc
         cywPEVyV+9Dmx7EgA9xTm18+s+tQQ5ZHsuDhmv2Gn3kLQ+2dHstXHzDAFkZyls25evG7
         wAowPw3dKTzpfGXuYEL+Zk+064kaU7Tj0aCxI8VyhEzhcyqBWHIPm6BxdQ+X5jJ0mu0t
         6Tfd/vr28O31+2hxtZlpBz/Rjj0X3rTV7kHH1Ej02e8x8hdGNTMOanSNC2DJv50X4+8x
         L0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334070; x=1773938870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QopztaDQaDXdF0WurIHvj6v5UeE/ENNGQg9kHKBDRS8=;
        b=s/tf1lchnZ1ccmVoVCig/TsOI5onfJaNk0g+eiphPA/NznKjhGxAHKPBPbjKhLDQUc
         AYZbX5eowbF53reoYY8HLbEND3rpna1G6vq/c9vby1cI5OUL2qXBIRq/VrmgSvtZOJUt
         BspYmpUismiBsywB7xzPHzqdmUBc1+tD5lqxRnEWt/Jn/TcJMHg1Zw5pFw5ykd6fZS7Y
         U+VMlDztoKihkh5FcFxmvQ3DD4pNgGcXvJgP8HA2JrGh99sJbHr/m4NIccGY0+8/9Rx2
         UQhOA9Du4fJtiiQ88xql/+KRxnXx8nIFRPdiaodU8R/A+0tYPxPiS/pt3smsUnRYVlsX
         zfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX26p41e84GXejkoAkIhQN1VGAkqGU9KgIxDYn+MD47KLhaWBhbabqS1CQODU4DIre+11rHHCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGwm03q8i9BZftYoth/9cHdFU1AhWtskWUhkwBZvj25kqAoKA
	n4s/xP8OfWAK6wtvHr8XaVpwjMzEDFOStYWIPhrznSqJFmpMpeAbZHmTIMZ2G3ZZX5EGobzXxAB
	8DKTgY9RcPkuVjPB+cSevSDX+y7AUbkfxTcWMIB5zE3g6B/DmN8aIffKB2A==
X-Gm-Gg: ATEYQzyNG8UyL5lzXZZAfBSihQm3EUhYq9d650MAMd3vZ/CvPF/prK2nx6FfYpdrOJt
	WXjKjAKVvWVha5ySC2XTZlaHFx5FvKWlV582c1l39Flv/LyVGWYzuOJMqX7N0g/QQgKIJdlkdtU
	2BRBvEKP7zw6rvoclwIEOK82vlGVfgU2IvDDafo91MfY4IHux1v1fib6s0/Yc388OLSmJt9Z7LI
	NJ/RJOrHOL4Fk7cVfsjPa3vhvPctwsb4xI7GxyCUmPVcrBaLEMKwD/OD9e5Qtn42n8fGBkLR9g6
	KADKxcXivjLSfYb8Igu++O8lAQnHt60DEzx4DSLHj3gh1Ml7Sc0rhJ1+lBiJyfQikg22JjaNuRI
	4aHt6CSMPC0sSeXmjXp81/dynBBmBtsOKs0c3ynmffi2X1H1azaZ6QCs=
X-Received: by 2002:ac2:4ed9:0:b0:5a0:ff97:4374 with SMTP id 2adb3069b0e04-5a162703bebmr82064e87.7.1773334070495;
        Thu, 12 Mar 2026 09:47:50 -0700 (PDT)
X-Received: by 2002:ac2:4ed9:0:b0:5a0:ff97:4374 with SMTP id 2adb3069b0e04-5a162703bebmr82051e87.7.1773334070004;
        Thu, 12 Mar 2026 09:47:50 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366b22sm1021366e87.77.2026.03.12.09.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:47:49 -0700 (PDT)
Message-ID: <2d1e0acc-efad-4166-b738-721d88d533ca@redhat.com>
Date: Thu, 12 Mar 2026 17:47:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features to
 ndo_set_features
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
 andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
 jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, razor@blackwall.org, sridhar.samudrala@intel.com,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com> <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora> <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com> <abKf8Fg865Fhipwk@krikkit>
 <abLPBEg_-j5rp4IM@fedora> <abLivB2KPK0JcTFR@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abLivB2KPK0JcTFR@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-267165-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D6FD6275E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/12/26 4:58 PM, Sabrina Dubroca wrote:
> 2026-03-12, 14:34:44 +0000, Hangbin Liu wrote:
>> On Thu, Mar 12, 2026 at 12:13:52PM +0100, Sabrina Dubroca wrote:
>>> Proper fix (so that the notification we're sending during
>>> upper_dev_link has full linkinfo) would be to move
>>> netdev_upper_dev_link() to after macsec_changelink_common() and fix up
>>> the error handling. I don't see anything in macsec_add_dev or
>>> macsec_changelink_common that needs the device to be linked. But
>>
>> If we move the netdev_upper_dev_link() after macsec_changelink_common(),
>> we will not goto nla_put_failure via default, right?
> 
> Yes.
> 
>>> anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
>>> on invalid data, so the "bandaid" should be included as well.
>>>
>>> Should this be part of this series (either just the "bandaid" or the
>>> "proper fix"+bandaid), since we never saw a problem before?
>>
>> Since macsec need the "bandaid" fix either way. How about you post the
>> "bandaid" fix to net. And I include the "proper fix" in this series for
>> net-next?
> 
> But I don't think it's needed in net. Am I missing a codepath (before
> your series) where macsec_fill_info could be called for the new device
> before macsec_newlink returns? If not, it doesn't really qualify as a
> fix, that's why I was asking Paolo.

FWIW, I don't see a codepath calling into rtmsg_ifinfo_build_skb()
before device initialization, so I would be fine targeting net-next with
the EMSGSIZE-related change.

Side note, it looks like that the WARN() in the rnnetlink code here
helped identifying a real problem and correctly returning 0 when the
key_len is not yet initialized will silence it forever, what about
preserving a warning for this kind of race? something alike:

---
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..82974d4fa3f6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4337,7 +4337,8 @@ static int macsec_fill_info(struct sk_buff *skb,
 		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 :
MACSEC_CIPHER_ID_GCM_AES_256;
 		break;
 	default:
-		goto nla_put_failure;
+		WARN_ON_ONCE(1);
+		return 0;
 	}


