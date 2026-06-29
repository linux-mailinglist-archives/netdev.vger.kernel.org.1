Return-Path: <netdev+bounces-302603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FEOnMuhjQmo26AkAu9opvQ
	(envelope-from <netdev+bounces-302603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CBF6DA06C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=A8zoHkA2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302603-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302603-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE6D630258BC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896A400DE1;
	Mon, 29 Jun 2026 12:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073533FFAD0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735832; cv=none; b=QapOH2r7OypaPESeH2eJNJxIvsygEa5+NYJ/TyqkYqYasFSf96QPLWpDHYqYaXMC9zhMxqI30hPYxgR26RTt3Pen31doaoyzIOcMbrgbm9BXziCUE1JtytoaSUzcdvhd1JnUYa2GA/AaGq7eag0u1UrRmUK1ba0DXqBPeWrMN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735832; c=relaxed/simple;
	bh=JiweOcpD2gpG/D1UI6s63Lm84Lx/AQcHh2xZgunNp4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhG+L1VEyhOJD3RxDueG9A/mdg13XtGb8leu/uj+7r0hgi1FtTz3mXwJ8ctjuBqw31hz6fgbFSxAXWFJ9MkDI2cc/uvD13G6bGvG4woC51pxtgXiUHfqtd3JhyN6ApxEsl9Utk3v43dYV4BqpcWZHUFnfsSzDhgDe1RmLXIAUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=A8zoHkA2; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so5787540a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782735829; x=1783340629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c42ikaiQsX4R+I2gt7m3Uhxc5QLT/t1/qPY6OMkStPw=;
        b=A8zoHkA2gd+dw7bz2EaMOpGNULqy3f/dq6uWhXmOlktNLWm5FeqC3PpkAMWQQ+Zb2U
         tFTnWzMHlN3VjOFU5QWdMpl6cAITVfGDXp2Nu+z7QQ3D5WxEKSUpzzk95Owkz/xWQ+z4
         7MquCn+Q4NhIaY45VknAtk9g8rUrH2m8WlZV8okOutHUoIrqOyFjvefn4CIWPkNvkxSU
         rrTkJUWOhOm8/x1Sd4HB0PJ4+7deHg+hpYzf1hjlC4BrGfFUzlcP7jaiA7b5fqdRbing
         C2LeDFwgk8DI9MV+tmgN0wTxS6BcaP4Z4QMJW7LX0cuPlaoYZG6Ju6LS5YqSr3SuT06H
         9GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782735829; x=1783340629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c42ikaiQsX4R+I2gt7m3Uhxc5QLT/t1/qPY6OMkStPw=;
        b=IKlZ6A9sGF48fkCOfEL8h/WjuNa1yRzH9frmVgu7Qff0TRrJMUv5QjRjGLanVzeh+2
         Atqzinqp2/81EQnmSCzcjwG/3XKUv77A8D9WJ9a22sHhr5PJn0Wj+hzcmencvNj5VUS0
         HGiZefMETjViTkMWXq30GNf1TcMoQH8pWtplTMTwKcjpE6GEqUkf6G+pSu2Om6CJxVTN
         91RrV4RKINrmbviPgZ+IxbsULtizCi49ez+YvT0pwb1pfrraKJqIYvvBA1TkNHeiFzox
         PK5mYHMfqyPWqYQ66DoqJkjo1otouJQh9L2jsHfeykTIWZ4UrcWAF+8T7/3vydl9rt6I
         RgKA==
X-Forwarded-Encrypted: i=1; AHgh+RqCe9xNhf0Q2ToQR3JANX8ikKGV/1fYTud3UnuAu2zWGP+oapBtMApaPPmPmj8MR0P1Ar44n+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7IJbdH1WWyckWJ8nep9S8ugCcE7izu19JLtKeVs3jGqn0vdE
	RKUXlW6uSYItxVkNNPVy3VueWEagCnAjZ/VXfvcQ6aYXFQVHZou0lXAkQOLWhdV408R6
X-Gm-Gg: AfdE7ckeupunrtO878u7xn/lZQB+j7Jc4BK+Zmp04nn4fFiB+TIXGK9SF5a3SrB5Ehm
	vLqAS7w6xX4NVR8gUzssAm4E0ROET9mSL5zwszGnlXtqTULVKD6Qc14UuGSWlgyXy74Xv2Lt3F3
	CWg3jNGbMpKQpVCkf457SuuFCITMEH1htdwvW1JKvRiw/XGC7u0IWiAzd6yZ1b4t/OZTnMfZpwH
	m4nrbn7Rb5nbvox0pqasHj9LTfPqbLvetTw8ezLopksyiLkxTi0p/ktizXKdolwrTxb1aqY4CME
	a04u5zWpI2TjnsHDk3Lt68928yS+i21KBlcZntIFDdBHq/59F+NDioEQdPN29n+K+W++f2s2i2Z
	PTtrsh8LR+8oYu4EKhWzslWloSeeLm5imxr11Z+tfUd/Plz9Wxu3iftZfZjgqHQ7hGOLkcZq17T
	Y3IqmCzMY3FU8I3u8MMfScnlY+vu3TyS5bMqKQhOo5ACWf8w==
X-Received: by 2002:a17:907:d26:b0:c12:45fc:c25 with SMTP id a640c23a62f3a-c1245fc3060mr292629466b.17.1782735828774;
        Mon, 29 Jun 2026 05:23:48 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1256c8c643sm233359466b.52.2026.06.29.05.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:23:48 -0700 (PDT)
Message-ID: <edfa1b87-a28c-40ca-85ca-e11ac3482518@bynar.io>
Date: Mon, 29 Jun 2026 13:23:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] nfc: nci: fix uninit-value in the RF
 discover/activated NTF handlers
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260626090301.2139500-1-sam@bynar.io>
 <9f73948f-7045-4ef3-bc8c-731fde943c1e@ixit.cz>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <9f73948f-7045-4ef3-bc8c-731fde943c1e@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302603-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34CBF6DA06C

On 27/06/2026 19:41, David Heidelberg wrote:
>> Assisted-by: Bynario AI
> 
> Hello Samuel,
> 
> the fix look good, may I ask you to follow the Assisted-by syntax as requested in [1]?
> 
> Thank you
> David
> 
> [1] https://docs.kernel.org/process/coding-assistants.html

Hey David,

The :MODEL_VERSION was omitted as we use a range of different models and versions in our pipeline, making it hard to attribute to a single model/version. As for the AGENT_NAME, in this instance, would the correct syntax be to remove the spacing here (e.g. Bynario-AI)?

Once clarified, I'll submit a new patch with the correct syntax.

Thanks,
Sam



