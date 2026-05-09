Return-Path: <netdev+bounces-286096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEVKAzGh/mnTuAAAu9opvQ
	(envelope-from <netdev+bounces-286096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F44FDC16
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BE273001A4A
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7311337AA65;
	Sat,  9 May 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSZenLvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AAF334C08
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295027; cv=none; b=mcnzYQAb9Y7U5Gc0o0So2HOgp68Rz9UY0XVWyMMHrmv7gqMUEEYbzpzoRt8Q0+vZgKCQo5qyZT8EKtFJUjgMNIq2SPgFlfEwcZylhTwDG27ntRQxxj67ATaEk4p7TlNvKMIkRK7kI+YAcejKo4G1jiNFozKYQjHQoucyLixTWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295027; c=relaxed/simple;
	bh=I0nhWTWxcCerkqcySYaaLJdVnpal3by0Mdqd8aZt2pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAKkVNIi2CXMCFnX24HAd4+rEfJejgC890C5DPxTZ2PrNFWkhalTVTTa+fo01hx6I/3UgWWQmJl6fb+KXRFdCth0x2gKHX2McsfNlPyFD6pXZHTI+4a8epdz81by/M4icB4n1jKjbRFUBst0Lqjrh5FiETJPDXnxiKPonsVn5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSZenLvG; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0ad52830cso4077784eec.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778295025; x=1778899825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0nhWTWxcCerkqcySYaaLJdVnpal3by0Mdqd8aZt2pg=;
        b=hSZenLvGSd3aC92ee8VzDkaa3JGaiT3IL1pPYVD0UYejSTNFUhWlP8TRr1c7kLj5VN
         x9CqZPh8bM64zJqVpykI0YMpY38XeHPBpZe/Umj0B1gfPk52JbXf9V69z0N6OwjcXI9h
         37pxPmkGTROqnjczQmssfJC6u4v+djoVQEd/r0C58jceMclDxeZ880NW24cWiyjfcWE9
         SMd0jbmYREgxvyAFx40O2bemk+MLzM3ZEU4UVYYnyrXDNO1BjNBzE8lPpOsZefV828xk
         tuG60Zq47fKJ+CTTmpTAccDH+MR2ue1hyFhZ9hm9msJe/i1qp/szTquH2AwT/ghNT/eS
         Jp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295025; x=1778899825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0nhWTWxcCerkqcySYaaLJdVnpal3by0Mdqd8aZt2pg=;
        b=nL96Ji9w4H2pX7z5HpKlR6o/QRSXo2fd9WRxjVwRC8VynEK2p6qencNDiSd8XQz2or
         M9lBNQwx8oO2Ikj624ZYB642gSZG8gEvr7P/I9RlSGKh4OhmOYJUAYE8Dys0tQWGpLXf
         7bUUORER+4hsn4l9k72fNwULq2X3WmdN0sPlyGnnwwPIcpDEE38kvtyA9AYYw8QKRC5s
         VSw55lHwRD4X7Wt/XX1PYxDcoC6iWC+tXOasd/8GhtTOYfW0AtTN0CZ7ddjp2VLx9JA0
         jtpVy3vTb4N6Hkb3LA9RHHSPmHpqeHNKAI8l2IPD66hV5AzSN6zaym8Wd7DEW/qkngnr
         aRfA==
X-Forwarded-Encrypted: i=1; AFNElJ/QNtQ4O66w57NAzpkpu3oStk7a2jfooQ2xlqBefqXxst8OGCFB6v8pbCpnliT2XX22pfK4bTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Fz6u1yzXHQ2Hx1L2/kA3ZK2b22BCHNN6ATgkAMAnX4kNByuC
	OC+Vm9w472bTqzQykEmI2ko7NeZiM4M+cSxPYbx0JMqvUPh4DkLSKxY3qSCwJF9l
X-Gm-Gg: Acq92OENsPno5fki3v0+t7lk+QReDUb4IpVGrS7AcPiJEUDJmQKa/5g9hqmcujlPm5h
	Jw5novcBsyJFqXi1XapggbaO1JA5cLMqXteOnVzajeGd2/2SI8CSFr0Z37IxTpADci943PFobEc
	ZHvFF0/dibr1xqzZ6zF7dJIG2nQrvQGVvt4lB2E9GUFQZQ2IIF9oTP5VHWgxxY3A/YVkmAPMB8s
	p7SAWKI5u8urxFw+5jZUdUT4UR1DCCP3RHZKVwpY1VkCdcm97yslJmkioaVhEkh0CdO5rhuTodi
	SBTVSvnAJ63kk1JhTfRRaLcxhY7qFrE9Lx/j784HU/I2vi6+CN9tfv7GqWvi900utxLCS6QKf4d
	EQAx6qXhs/i3tPURWrAO0AF8dnocKmV734ikvgQ8i4t2OhAiJIgAo0egNs2fCHdZLKEsEh/6vC+
	C2A4Qn9T51s/gjth4ur/iAffDuf6WxfxwANiGodw5xug2THg==
X-Received: by 2002:a05:7301:4195:b0:2ed:e12:376b with SMTP id 5a478bee46e88-2fb5ff83223mr368282eec.33.1778295025028;
        Fri, 08 May 2026 19:50:25 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f885edb83fsm4711690eec.7.2026.05.08.19.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:50:24 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: kuba@kernel.org
Cc: albinwyang@tencent.com,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hannes@stressinduktion.org,
	horms@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	shenyangyang4@huawei.com
Subject: Re: [PATCH net v2 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Sat,  9 May 2026 10:50:22 +0800
Message-ID: <20260509025022.1804166-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260508191923.3978b8fa@kernel.org>
References: <20260508191923.3978b8fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 115F44FDC16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[tencent.com,gmail.com,lunn.ch,davemloft.net,google.com,stressinduktion.org,kernel.org,vger.kernel.org,redhat.com,queasysnail.net,huawei.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

On Thu, 8 May 2026 19:19:23 -0700, Jakub Kicinski wrote:
> > Regarding the label name: "wq:" follows the existing naming convention
> > in macsec_init(), where the other error labels are also named after the
> > resource they clean up ("rtnl:", "notifier:") rather than using the
> > "err_xxx:" style.
>
> I can see that, but we have to start somewhere.

Good point, will rename to err_destroy_wq: in v3.

> > Regarding rcu_barrier(): in the error path of macsec_init(), the
> > workqueue has just been created and no MACsec interface has been
> > registered yet. [...]
>
> TBH I didn't check the code, you may be right that until the genl
> family is registered there's no way to an SA to exist (even tho
> macsec devices may have already gotten created).
>
> Either way, I'd just add that barrier. We're basically leaving
> a trap for whoever tries to add another piece of code to this function.
> The error unwind path and the remove path should generally be kept
> the same.

Agreed, that's a good point. Keeping the error unwind consistent with
the remove path avoids subtle future bugs. Will add rcu_barrier() before
destroy_workqueue() in the error path in v3.

Thanks for the review!

Jinliang

