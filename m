Return-Path: <netdev+bounces-286448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNzqL1lQAWq+UgEAu9opvQ
	(envelope-from <netdev+bounces-286448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:43:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D09507B89
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFE973001D4A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAA237C92D;
	Mon, 11 May 2026 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c33Ih2Zo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1535F5E1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778471000; cv=none; b=FJwL5fDRZ6QGsRQrYj+v6Hp21GY/Wt03qw5txluJewVeJe97FbR8iZdkC+1IFCo/seBBHeK3sgft0Nenbq75jQr/WqyqAjcACNJ5/3nxrt5ksMzcDYybDfBkXkkpcFLaUE3HyvxdqMz2/gglIGFCWSxm2lii8cbpPfBRsdwey00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778471000; c=relaxed/simple;
	bh=H4fkwwbYxPKm1ypzT6bOcfX/lK43QRojgcILtVu2XFY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Hj+vSFTnnOyriF/h6ZIVjtHjzYW++va7+nvzaWqsWp7jCqij+AheU4kAyxsLxSPklCufIqh2JHIse4+e7z9ZSUGfscdIsUz6zw6LAs5fAnkW6YnA3W2ILTiY5QERc3C8xsOe/+B8ScLiFaIlX3W57qqrspRNXv/lQH60KFum2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c33Ih2Zo; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bc83e74aso3837135d50.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778470997; x=1779075797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGClT6yKjio/U/X8taFr0YcBozUqn3DwsEV9alBjdFQ=;
        b=c33Ih2ZobpX0DhdBIiNyacY1orXTAn4rgx7mk0lUYWoa6mnNJZxV/TOXeNiUY9rhlr
         5g4iaV4Hb0/FYuGHxzDyeaUlwiCeQ8C9DZTr887rytbBMp7ivA4D45Jz0C7IsSnqeR41
         2zLv6yC/vod83+GoF0HmJS9Fptg1vW8Y01+ea8zyHfGdLuLOH6+/oiTbSpCdv26Cokxr
         P3ywRejaG8O8HHtDlyvYMLNHph6SR7675L0DXgsWCr6daLhBToNszN8UqJhcjdKPbBzO
         01ZUSjokqww7GwtX9B8eDbFqa60WD5pdpqCUKv9+MCyI3ctarGUnZ/9IegGK0ie/LSeS
         YJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778470997; x=1779075797;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGClT6yKjio/U/X8taFr0YcBozUqn3DwsEV9alBjdFQ=;
        b=rxRg90WAYe7DFp8VsHhkf2Hyxsg5qybgj1swEs1fq0S2G8PGMkxVtuoMJ2AApe4i0k
         7zBlV08QT8EBzJu5DQHd3QTt7NedqEHMY0DHhj6gWsm8YNFtE8zDnKrmyNxYGaAsz9/o
         wHFTlFWwzFIg1ZsZFTq2wVep5YYZn4CIrp5F3IJNvb902+QxdsirKgS0xU1H90J2BeNt
         h6ox1X6SsGm8L6Nf/YycJOXiVK2izSbtmc8752siXh3cVNmNgXxxD+oYazo1NrNVdJ1E
         7ESfVC99fpeaQwZDG5ZNTcuUeum1tZwzHISMeY5Giz7JAChRNWEI19T7JiWgZLmD5AmX
         NWFQ==
X-Gm-Message-State: AOJu0YyyoPljN98fXg7oTk2HKQg/EFQNVeWzBuluJnod1IGu+qhgB2RZ
	evTTH/Ph5Mo2l5X76HGnPIZY+HziE3eivT5WWIzZdGE8itGqjqKUtWPX
X-Gm-Gg: Acq92OEQEasTDHh9B1z/TlTMnAKC1w+cdXqpZh8sicHzwp7AzTZf5cq8/v6DkPYxX04
	YeEWmyA5v5DEB8spuSG+KMYtrB+a5QHpVTe9M7m04COSacr2GSxZKHTs3hhb7ycbY5DnHOYWwP3
	VR6m2ji11No2DUIU7OSc8uB1gkOKFofJbuOEz2lAa/9jKEgftFA7Gk3MNCw5Z5LkPMeA5cd9Sp4
	oZK80uCBl89P7igs6JEMk9ivJMaTbo+K9JFpyqRORQEy6G8Ed5c6ygSxc+c5UC0LOls7pYkOo+4
	2FLvjjt3MAq2MreFmwUQTJ0QdyLyoCie8UexIjfot/G/gvy9x/xdrQeOInGLNb4OBHw5H8lJYbU
	ONeftWUzwI1KY00m7jIB7gTQ3hip28Dzxv8/5qtWxp6lYaIZTKFgRUpzgQBJ3eG9RLHh+W1hERR
	xemFDNwxHKoCo5hCV2DhxuYmhtqJZwOSMrSGiwJMXrXJi47YKplhUiUcG++0pznNQdRi7Ke7cMb
	IolKg/Sr+O77ixVVu/HLSglqQ==
X-Received: by 2002:a05:690e:1759:b0:657:e42c:f25 with SMTP id 956f58d0204a3-65c79df9fdemr16415508d50.49.1778470996712;
        Sun, 10 May 2026 20:43:16 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d969fb85csm4673774d50.2.2026.05.10.20.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 20:43:15 -0700 (PDT)
Date: Sun, 10 May 2026 23:43:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.112c88eb7daa1@gmail.com>
In-Reply-To: <20260510174219.74aeee6d@kernel.org>
References: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
 <20260510174219.74aeee6d@kernel.org>
Subject: Re: [PATCH net-next v7 0/3] selftests: drv-net: convert so_txtime to
 drv-net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 63D09507B89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286448-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.991];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Mon,  4 May 2026 13:38:31 -0400 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > In preparation for extending to pacing hardware offload, convert the
> > so_txtime.sh test to a drv-net test that can be run against netdevsim
> > and real hardware.
> > 
> > Two preparatory patches
> > 1. support negative tests, where tests are expected to fail
> > 2. add a tc helper 
> > 
> > See individual patches for details and detailed changelog
> 
> Hi Willem! Looks like we have some flakiness here:
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-drv-dbg&test=so-txtime-py

Argh sorry. I should have run dbg mode, but hadn't.

The previous version skips all receiver errors if KSFT_MACHINE_SLOW is
set, as of commit a7ee79b9c455 ("selftests: net: cope with slow env in
so_txtime.sh test").

This achieves the same in the new version and seems to indeed mask all
the timing (and other) errors in debug mode.

	@@ -24,8 +25,12 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
	     cmd_rx = f"{cmd_base} {args_rx} -r"
	     cmd_tx = f"{cmd_base} {args_tx}"
	 
	+    expect_fail = not expect_success
	+    if os.environ.get('KSFT_MACHINE_SLOW'):
	+        expect_success = False
	+
	     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
	-             expect_fail=(not expect_success), exit_wait=True):
	+             expect_fail=expect_fail, exit_wait=True):
		 cmd(cmd_tx)


