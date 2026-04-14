Return-Path: <netdev+bounces-278352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MVJJg0D3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:04:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F03F7A32
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1F73009165
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C43B38A7;
	Tue, 14 Apr 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bFMOJnxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2D363C7A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157318; cv=none; b=OUwCOMzYc0583S9m5PNhjGgLWRZGhWUOe0IjTLdvfdRVMJYIV7/ZWrhOAEfvnjlG/VtTwPlLWr6jkPeYuqii5mSLX11MCcffs1gSL/DZ95POjAFnjwdiS3yMBq/i5TtBJ+9k1nrj5dj0/kwGAONUXpguQjx4bP+hId77+EeK7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157318; c=relaxed/simple;
	bh=e+IyUK/7lf7e8pfgm2RWZh02o8d+iyt5En3eVRcJgOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv7Gck5uVMG5UgQY5R7d7JULtsOgSKFFrvNUC6vSou4opZRYJJRXYX7FU/CEGAQYsUqs6j//JMhHs4fH3riUbj1QLaqOB6UmRGTF3FoAlrEOaLFbiLEUMWcfzWBdI6aoZ3iRuzRcpKx1U+LXv6RMstgb8v8M/r+Vo5p8SfokuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bFMOJnxn; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60fce51aa55so549242137.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776157315; x=1776762115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rTEyBKT6Njdw9PVtHWzGseMUYn58QMzynPv/h9mMHMA=;
        b=bFMOJnxnIysE7PBC46irqPSG7JKLLmQBPXrv6yi9eCDVxZnZqLJzKoFvteuHGGVOTB
         Q8ZopSiyCsSs+f/+wclFcB6K3+Zn/2PkLZvL4xglh8n+sNH2bd4Fqg8tPv4CujTfywzp
         W/+8bqdSj+PSHgVLncY3ofv89S+/MH1TEn5gd9vadzsIIjqitmyQmE8N04P3M1AV9ATK
         NHiWnxkNiZZkLlou3aDDp4Al2L2ENR01gmI0V4abD48OhD4NRS4pZiiPhgNnlLVYVDEM
         uLwrIce+A70nMZEWfCpRwRlA/NgFTP63qbKyY/enThUG35hmaJqr50x7Q86dUGb7pH8I
         nZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157315; x=1776762115;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTEyBKT6Njdw9PVtHWzGseMUYn58QMzynPv/h9mMHMA=;
        b=s3rOaWyqenZjIfLxLrtH/TNZVeOaVc9YkXfb4Q8OaQjqB+B4yRWT1t9ni+b1/PHaGG
         REMZN6GhjXZVTcIzRI02Dj1DiSvNEJ9aAwNmzqMKmkrfAM6LHefmv+gooGhUA/0qZqa/
         cnO+af+NohvIGCsVDzZFcLqOu3H/tzjaF2LZNZQqYqMObHmhU38HWld5NHoFCn5ePNa0
         drOmEo1OrHHLTY6sHcMzhXdqqYRCHUYLv0NqcRS2Tkg+zJCrrI1HsuE6eLU4aXyxJ/HO
         +6IrJV22YCRbFW5FbB7/lOR0CvrZUwwYDDTUvwG9D9hmG9jvV6ubxOu00SUMfBn/F/Xb
         t5hA==
X-Gm-Message-State: AOJu0Yx7P7tqDiUN3vQQzX6q4wJK2EDQZd+3gz0DnwUAUx3HnAsvikro
	aYWSYPD8ARx581eauWSuOuzgeR246z8zlPt9gT3tus3FbzvWKT8cXSFo9ikQ/jXAwTpeK4QuQWj
	1j0mLr02ZPLYNoMXHmtMPjJ2tfn4yxgELfPvpblfFqJCtlZfuAxtJKIGdapM52caj
X-Gm-Gg: AeBDietgLcvD6T6pRPFRnW6pBMIxXSyIVpYr2gE7i3Y8BY62VDWCeBTcNsSS9fhWJqk
	RN4ASVX87kG207iNMHaD1svhIP8fqqej+8xFsel+kfzbDT4CX0f47Ecjr6Ypm9BPwht3os4NijT
	+NTdMJBVq4DKXQGh5fiJh3bZOIG9BZClx6Tx4Us69KkqSyhW1c2xHQwt8/rin91dhzZvJGrtop7
	3qN8LsYLD9cTR33cy0S5Vucn6NDamAVjsIqcSRWdRZ8xGKH0FO232l2sC0BYy4vu362PskCUwqU
	xUWdWcjwmJm+mRxqYGXPEx+k/wvu8PKoUppwaIUNTTYCMh1QOAxuA6hb2WheX6qJk2Nqq55+eP+
	R7YrGAfrKZskQtl1wyFoY+HrzSHZRf+9XdCucypcNT2lrfH3ZuMAzhyjttHGm674RhmrjsfFP4L
	ecOqWm++TeOlCJkEHaD1UOciWk3Ue6yInjImw2Z441GJJjselAjUdsTVVURLIRBg==
X-Received: by 2002:a05:6102:1512:b0:608:a960:c852 with SMTP id ada2fe7eead31-609feaae6a5mr6754948137.9.1776157315458;
        Tue, 14 Apr 2026 02:01:55 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8842:dc29:5b0c:176c? ([2001:67c:2fbc:1:8842:dc29:5b0c:176c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8acb479aedcsm33448966d6.18.2026.04.14.02.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:01:54 -0700 (PDT)
Message-ID: <0eaae393-1869-4afb-810c-3495e3dc474f@openvpn.net>
Date: Tue, 14 Apr 2026 11:01:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] selftests: ovpn: fail notification check on
 mismatch
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com,
 Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260412221121.410365-1-antonio@openvpn.net>
 <20260412221121.410365-3-antonio@openvpn.net>
 <20260413170014.12316e9b@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AYGGhrcHM6Ly9rZXlzLm9wZW5wZ3Aub3JnFiEEyr2hKCAXwmchmIXHSPDM
 to9Z0UwFAmj3PEoFCShLq0sACgkQSPDMto9Z0Uw7/BAAtMIP/wzpiYn+Di0TWwNAEqDUcGnv
 JQ0CrFu8WzdtNo1TvEh5oqSLyO0xWaiGeDcC5bQOAAumN+0Aa8NPqhCH5O0eKslzP69cz247
 4Yfx/lpNejqDaeu0Gh3kybbT84M+yFJWwbjeT9zPwfSDyoyDfBHbSb46FGoTqXR+YBp9t/CV
 MuXryL/vn+RmH/R8+s1T/wF2cXpQr3uXuV3e0ccKw33CugxQJsS4pqbaCmYKilLmwNBSHNrD
 77BnGkml15Hd6XFFvbmxIAJVnH9ZceLln1DpjVvg5pg4BRPeWiZwf5/7UwOw+tksSIoNllUH
 4z/VgsIcRw/5QyjVpUQLPY5kdr57ywieSh0agJ160fP8s/okUqqn6UQV5fE8/HBIloIbf7yW
 LDE5mYqmcxDzTUqdstKZzIi91QRVLgXgoi7WOeLF2WjITCWd1YcrmX/SEPnOWkK0oNr5ykb0
 4XuLLzK9l9MzFkwTOwOWiQNFcxXZ9CdW2sC7G+uxhQ+x8AQW+WoLkKJF2vbREMjLqctPU1A4
 557A9xZBI2xg0xWVaaOWr4eyd4vpfKY3VFlxLT7zMy/IKtsm6N01ekXwui1Zb9oWtsP3OaRx
 gZ5bmW8qwhk5XnNgbSfjehOO7EphsyCBgKkQZtjFyQqQZaDdQ+GTo1t6xnfBB6/TwS7pNpf2
 ZvLulFbOOARoRsrsEgorBgEEAZdVAQUBAQdAyD3gsxqcxX256G9lLJ+NFhi7BQpchUat6mSA
 Pb+1yCQDAQgHwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmhGyuwCGwwFCQHh
 M4AACgkQSPDMto9Z0UwymQ//Z1tIZaaJM7CH8npDlnbzrI938cE0Ry5acrw2EWd0aGGUaW+L
 +lu6N1kTOVZiU6rnkjib+9FXwW1LhAUiLYYn2OlVpVT1kBSniR00L3oE62UpFgZbD3hr5S/i
 o4+ZB8fffAfD6llKxbRWNED9UrfiVh02EgYYS2Jmy+V4BT8+KJGyxNFv0LFSJjwb8zQZ5vVZ
 5FPYsSQ5JQdAzYNmA99cbLlNpyHbzbHr2bXr4t8b/ri04Swn+Kzpo+811W/rkq/mI1v+yM/6
 o7+0586l1MQ9m0LMj6vLXrBDN0ioGa1/97GhP8LtLE4Hlh+S8jPSDn+8BkSB4+4IpijQKtrA
 qVTaiP4v3Y6faqJArPch5FHKgu+rn7bMqoipKjVzKGUXroGoUHwjzeaOnnnwYMvkDIwHiAW6
 XgzE5ZREn2ffEsSnVPzA4QkjP+QX/5RZoH1983gb7eOXbP/KQhiH6SO1UBAmgPKSKQGRAYYt
 cJX1bHWYQHTtefBGoKrbkzksL5ZvTdNRcC44/Z5u4yhNmAsq4K6wDQu0JbADv69J56jPaCM+
 gg9NWuSR3XNVOui/0JRVx4qd3SnsnwsuF5xy+fD0ocYBLuksVmHa4FsJq9113Or2fM+10t1m
 yBIZwIDEBLu9zxGUYLenla/gHde+UnSs+mycN0sya9ahOBTG/57k7w/aQLc=
Organization: OpenVPN Inc.
In-Reply-To: <20260413170014.12316e9b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-278352-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_tcp.sh:url]
X-Rspamd-Queue-Id: DD6F03F7A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 14/04/2026 02:00, Jakub Kicinski wrote:
> On Mon, 13 Apr 2026 00:11:18 +0200 Antonio Quartulli wrote:
>> compare_ntfs doesn't fail when expected and received notification
>> streams diverge.
>>
>> Fix this bug by trackink the diff exit status explicitly and return it
>> to the caller so notification mismatches propagate as test failures.
> 
> Hm, this series nicely cleans up test_mark.sh failures
> but test_tcp.sh now always fails on debug (slow) kernel
> builds with:
> 
> # TAP version 13
> # 1..12
> # ok 1 setup network topology
> # ok 2 run baseline data traffic
> # ok 3 run LAN traffic behind peer1
> # ok 4 run iperf throughput
> # ok 5 run key rollout
> # ok 6 query peers
> # ok 7 query missing peer fails
> # ok 8 peer lifecycle and key queries
> # ok 9 delete peer while traffic
> # ok 10 delete stale keys
> # ok 11 check timeout behavior
> # Checking notifications for peer 3... failed
> # 1,9d0
> # < {
> # <   "name": "peer-del-ntf",
> # <   "msg": {
> # <     "peer": {
> # <       "del-reason": "expired",
> # <       "id": 12
> # <     }
> # <   }
> # < }
> # validate listener output for peer 3: command failed with rc=1: ovpn_compare_ntfs 3
> # not ok 12 validate notification output
> # # Totals: pass:11 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Similar failure in test_symmetric_id_tcp.sh
> 
> Only the debug kernels tho, non-debug kernels seem to pass.
> So probably some race / slowness.

We have to extend the internal timeout a bit, because it triggers before 
the notification is delivered.

Will get this fixed.

Thanks,


-- 
Antonio Quartulli
OpenVPN Inc.


