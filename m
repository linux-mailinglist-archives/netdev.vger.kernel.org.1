Return-Path: <netdev+bounces-300039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3GbHVk6MmpjxAUAu9opvQ
	(envelope-from <netdev+bounces-300039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF938696C46
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:10:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=QJPHpfML;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300039-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F79230837C9
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400113B1EC0;
	Wed, 17 Jun 2026 06:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924D3B19B9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676592; cv=none; b=qy4nblm/sXdLi7X9EYN2jSmBWLC7S9ZOMF3QKuwmX+Mn1u2cHZN/S65ngjo9A1/xWzcyy0Qp+AY+7lVt+LLoQ53WDSlI3452AcF+p8QtY1yACp7HvGYHvS0uJv6ASDGgf+lkP1mvW6IxHza1aMrN/nrQmCbdVzOEwhZHJqELaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676592; c=relaxed/simple;
	bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5YpfZi2qw6NxC3OJHvE2hgjVAuHH+B9Z4wDr+ahpkytHSPDzuFLkH1d/KCrwjMYVraKPIe1U2zeiuFcu+89V/rf2jrFOvWbFXbx/mhuXNL3QvfZJjhwR2wev2Rfgx77/b8fRzlw8EIwytQEMYvpj99tckFn1QMvBLZKhSDnnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QJPHpfML; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17D423F641
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676588;
	bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=QJPHpfMLLIJfuFFOCoAp5gIZIcp9aKgoU+JeGhewx4wI/ZBgj1wSCYz+RTW+v3OQt
	 USqLtj39NJwgg/NTDhI25oLAkp2kxtHULsgMKgf70P5Hcq/Xjc39aVeJOjS+johUHR
	 rqpH+gfcVl+mTx0Va7VYRAZXKfdW6cdNeqWMoUcdpsh2UNyOs2IZyjEQXtsY7wCu66
	 LaJ66vHBJ49WGMu5DxRus6SwoxOdujfxhQ2N6HE5F4OLKt2eNx9yoF9dLfJ8VvR5Rz
	 +4VB8HABChksd9uq7otjz7DA1CUzZDw0/pHUmkgGtI9Xomvp7wtYpOU2KEO2aJShxZ
	 DSENu0QBuYplI7RFVLrJmLBSSse2Jqx70cCxJM8y/+MghDTTvCtJPlK29l+/lzDKu3
	 jzvP507VojKtEPUvgU9pgXGEyw25Ue/Wqz1a2Zcc40qAOokmfkiMneMUqlY5743EWb
	 82Kdr+G8mC61qgtgiNuFsUgG5z1Pp9g63wacl6iyT/EqiN9k7Bf5swUyxm2bPFu52Z
	 77Ymw1hMYbQfkKjGrr8XEzf0GT6dZMgvwU6vKuLcsL3Eljt/5tLZ+USvr+ZW3NcFRf
	 6BWDPrxs4AtbrUEaAtPO1yBx+j/8ZeeoZcmfNQ+Js9HhEhCkxmrlVJONpMJwBRfAJg
	 xloPkTrqaUb7+OJbS4qrDPmA=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so34356255e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676587; x=1782281387;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNq2Np2owAOATAEvweRdUBgEUHLpklaQw2z58nEY6JQ=;
        b=nQ0+Vm9RItmlPDf5NewFBNYRANEX2SThLTtEyslt6GrLldv8E7bm0sj0EfMncrVL+d
         OyABKIGs96/6sgu1Te6rjxc/BGiTME4LnFxP2NF0T+0xgRqZS2PwjOgw9fO4DS+z5Qdl
         hj8Vlcy0BSzWunHnzsKbCrMgCJmtZLVKqJHFaN5Sud1vOV8FnMCoPLKrqChLoyuClcQY
         tXouh8yg4uXXL7TU3CZ94vQFznaxYRastrWezYe14ydXVO0V9UGExtkmtQzyvuivpC1h
         fkZ65kSUQz9xGiaow6vhzpxZJvLnkbS51DN46lkdgK69gUp/Pm4xiIE0iUT+oTJQk//v
         oAnA==
X-Forwarded-Encrypted: i=1; AFNElJ8wISuU9x1HHCdH55OL1U1LRD8iCpxEAnXrdE9fmC8SlGtXj7m44JN7bnt1jyeYEbOyBjfGFD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhpx3uyvPQAd0Smoh07TGP5Ng4NG37ZkU+yXh/YxTjp6Tu61q2
	FrFXR+y3D6svK2NMWLFFyIA4Ht01Ntt4L+msLLPdXxkSYUrTWdGUOmGkjWSJTpUY3rGwdQ4GTC2
	DnytRFYjm8JrM1VFw1odPLQQKguPq7euyrBZXQ+63MKEehAfReF1XaMqgNLZTCf8nVHOF8jq/7g
	==
X-Gm-Gg: Acq92OEI/0eKZPXExlhESFAdJVgU6goGssB4ckxcbOjgxfGop1DtT80h5YHN5Q3i2Oj
	Gow12lWh/gD1cpmWydGkgR6iztFS8jFtbVjIAweWke4A4gcdkuLtk4AAfyWU3RMmPaJJzU1/plz
	e+s+lgKtpb/loakgAhCAqaCdTFDtj5rhAFlfCm7BZl/0qH6AChTZFke8yeN3/De8b+sl8cLDuY2
	gYfQ5e+1IqLgjT1+PkSP5UC9yeSjGkLpIuyA5deAN1cvp5OMKWwjrBI4nfUg5JiEWzcrD73pZTq
	fP13b48u1pLgz5ueP0OilGWP+gFESP1tMFv3aGfH73AEDreni0kQvfK/gavYi6CwUkWNz3TmPYx
	H2ne7HzaVlb36EN3wN8SD46eY9trIJrMjiXgHGoDW
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id 5b1f17b1804b1-492334282b7mr37259835e9.29.1781676587599;
        Tue, 16 Jun 2026 23:09:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:490:d354:d15b with SMTP id 5b1f17b1804b1-492334282b7mr37259505e9.29.1781676587312;
        Tue, 16 Jun 2026 23:09:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:1562:8007::aac:41a0? ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm57092036f8f.29.2026.06.16.23.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 23:09:46 -0700 (PDT)
Message-ID: <0265091e-3722-4b93-a644-e9b3dbd57a3e@canonical.com>
Date: Wed, 17 Jun 2026 18:09:38 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests: net: fix file owner for
 broadcast_ether_dst test
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, edoardo.canepa@canonical.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 oscmaes92@gmail.com, bacs@librecast.net, linux-kernel@vger.kernel.org
References: <20260610062230.71573-2-ross.porter@canonical.com>
 <20260613213254.174421-1-kuba@kernel.org>
From: Ross Porter <ross.porter@canonical.com>
Content-Language: en-US
In-Reply-To: <20260613213254.174421-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,canonical.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,librecast.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:edoardo.canepa@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:oscmaes92@gmail.com,m:bacs@librecast.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.porter@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:mid,canonical.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF938696C46

On 14/06/2026 09:32, Jakub Kicinski wrote:
> Could the -Z root argument be moved before the icmp filter expression?
That's a good catch, I'll resubmit a v2.

Thanks,
Ross

