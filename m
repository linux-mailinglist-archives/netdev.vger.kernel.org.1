Return-Path: <netdev+bounces-267081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC4qEZrIsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:07:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB71A273143
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D55F3016AF8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E42E62D9;
	Thu, 12 Mar 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="kmFhNJzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F735837A;
	Thu, 12 Mar 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324434; cv=none; b=d2T4tcsZF9lcHd9mVdMCwN2LY3th8IgywShe/7hXFu4V9HLRD6WoAmkzwyq6Zv50FeTRQ1NIC/c1TPtqEpLSScqYXSuGMRepRkxmUXrkvGQLJ+4TbNqtHuXzBsvdU/uPBMsO2i3RkMbB8PUHrotxVdz5YY1/3B9WdGjr1+cWKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324434; c=relaxed/simple;
	bh=AMUOmPf3YzWQN0XIsJ+fj0a1g4aNwDsDMz/2FJPmar4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FxGnBGHZGrKHxLDLtND9DsoTyK8tzC9yblc76dfyKYiSkUmti50DJhgQb8Vg/SdyI+NohuFc6pQTCgl4v2OBpy0ClPg8VPelXhI2fPLocjBAFmcTfh2uX+cAGW45lWthucVOqw3GCAAiPrFDTH9hDzRdhtFK+DSSoQ/62c69qEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=kmFhNJzf; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:9741:e688:3e1d:6b46:521e:f361] (p200300C59741e6883e1d6B46521EF361.dip0.t-ipconnect.de [IPv6:2003:c5:9741:e688:3e1d:6b46:521e:f361])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 9EA88FA12C;
	Thu, 12 Mar 2026 15:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1773324097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AY1cJv64feAdqQrj/hyeBcDJc7YcUj5rjAkm4u7G2kc=;
	b=kmFhNJzfNU2Ty1S+gQmnWQl/sw0/M3YZ1ffKGQZztmyuNkGG6w/gk08sKzCsfbWF38+ACC
	Cf0Rod9x2FV/IUgoLphqtOnAd+QB49CQcdVogN0KNZDHyWu9Ezgc+ATl0HrxViiniLMyzC
	mg6sPQTfOMpwF2IzqFeV7loXr73cw2NKL7KMcTvcCpQPknCmBxTBq7pDlZp6P1OTqSSsGM
	vz/jyMnlmEhDTeTa1FFYJe8oVZxiPbnMJ3LjkKiJXtnQinu3+5thjRkzY9y/gbzorJgy8g
	Zhs/3wV2u9Xk/GTz7yjYgD3RmLrd5XcHwyjU+X7iqp2oMi01RwSux5x0qm1nSQ==
Message-ID: <73887540-2fa8-41f4-9644-640d00cbcc3f@simonwunderlich.de>
Date: Thu, 12 Mar 2026 15:01:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US, de-DE, en-GB
To: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Sven Eckelmann <se@simonwunderlich.de>, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
From: Harshal Gohel <hg@simonwunderlich.de>
Subject: [net] Unexpected -EMSGSIZE returned by tcf_fill_node
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267081-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hg@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB71A273143
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Kernel developers and maintainers,

While playing around with tc and iproute2 we discovered that dumping 
filters with tc filter show dev eth0 fails because kernel returns 
-EMSGSIZE (-90). We were able to reproduce this on an amd64 machine 
running debian:trixie, debian:buster and nixos:stable, kernel 6.18, 6.12 
and 6.1 and on rpi4b running RaspberryPi OS 64 bit.

To reproduce add dummy interface, add htb qdisc and add tc filter for 
all protocols with firewall mark.

```
sudo ip link add type dummy
sudo tc qdisc add dev dummy0 root handle ffe: htb default 0x0000 r2q 1
sudo tc filter add dev dummy0 parent ffe: protocol all fw
```

then try to dump filters for dummy0 device with
`sudo tc filter show dev dummy0`

This results in

```
filter parent ffe: protocol all pref 49152 fw chain 0
Error: Buffer too small for object.
Dump terminated
```

strace also reveals the return code (-EMSGSIZE)

```
...
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, 
nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, 
nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1773323104, 
nlmsg_pid=50516}, -90], iov_len=32768}], msg_iovlen=1, msg_controllen=0, 
msg_flags=0}, 0) = 20

```

I am not sure if this should be handled by iproute2/libmnl or in kernel.
This error is only visible after this commit in iproute2: 
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=05a14fc1218885ba6236b409fbf6b89976b8636e


-- 
Regards,
Harshal


