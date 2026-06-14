Return-Path: <netdev+bounces-299267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryYqN/L/Lmpt7AQAu9opvQ
	(envelope-from <netdev+bounces-299267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484F682069
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=vw1wPh76;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299267-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF0A430022CD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFF24A06D;
	Sun, 14 Jun 2026 19:24:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BE533D6
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 19:24:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465072; cv=none; b=I8nqq8RlTB0YXOlxIEmieNdpFMMYIufwsWI7uQ6xkNm9r+FNEd+5uvCqg87t5Des8LKjdmIZovqrzTs5QzPhV+1PEw7j4UhdoCMQIF6TP96a6HxZAUeTrdFmZ1CjZykO/IgWLxq5sfL+uKMi5FKulnfNWPMAcs71FSUPrXEosdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465072; c=relaxed/simple;
	bh=QZ0Iu7uqd6nREYzf3+aZ8434Ds03WTC083HUygnUYdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmEGIu4ag88bmKBM8f024CXivcCnfjBwXapzuvlFaZxiM7zLT74H2cBVcsckA55qF80SdyAr2gOikKr8seurLIdYjxMzXL3LVMoVn79No+vOl5m5EVwFjT53xbe12mo+3rd3AsYcsBtW9wP6GQz6pqU+ndXBHYQZbkl1eRFifh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=vw1wPh76; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1397e093f90so713274c88.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781465070; x=1782069870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmkQHforuHVg5fCxHEjZYleUAdWXFaE/8Zb2dqwS9sc=;
        b=vw1wPh76+weA+QAv9ICFpfRm7uvceRXglcyAd+mUgIaDbPI1E/Jy8sJ6EcKgSfPQGJ
         LNS72nt8SYc5YOJgok1IJbv4LCY86qmR7FK999ZFnrrqtIMzBB6mptFuU/oxx7znV4KT
         43zZhDB4N7d/oGIMAiLcLNmDLPqFOlJ6IUdgFnP7crLB11zPjXjTH9jiUpeNdc5/ylEt
         COdTmiwNGoxzEhefArIVwcjhUMrRVqhsTrb8pLwmV3F1jmKX2szSBrewnkT+5KfhcZJ6
         GnchDIQ2u8UE8q0qrsGwfxmd6GWn15Q4rCQElW4PkewLq+yA2MoaHXIedbR3oTjGLSsp
         IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465070; x=1782069870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmkQHforuHVg5fCxHEjZYleUAdWXFaE/8Zb2dqwS9sc=;
        b=nTBH5GyBgq7TtiOjFaU6FItc0T1Cjm/sMR2CJi+X/6XcdBIVsGVNpznoYUmbcr1miU
         LW0/4E82hn0abVX8ankX9HnnO/b4rn9VK37Zv/ixu2t3+10IbNRt14kBdKY0eszUYe2N
         1StRBci8fpVe0kdVp2tWj6essCOkEN6Ex15lcHM7MBkTOEZ/2Igqy2ixqyG1Slh0wjfl
         wanA2A4TaWMjhgTfeBnwYljfGA4eeOqSv5onAbRMar7pPytYbVdulRdQXFHoJg7nw7zy
         bQbsj2vi+wrzQdw3alyzr5+16j4+NdUKnlk8ix6cYTn2GQSH2v7B/c3omYHURjo7a9gF
         Paxg==
X-Gm-Message-State: AOJu0YyyXChu6uKZPMa4gkbGY6WI/8r07DEUFoVga0NNit7gfBvjXiRV
	Ra5G56fkk3kdGGFmDol49+P0nUriK1iSA9Vh5fsJuRIE3HsXiGnUJ0PdZa++sI1dF84=
X-Gm-Gg: Acq92OEgMdWGuvp4GYXYsW7l6Uwk5tfkC2Qenq6oXmlv9WLywv1jCPrEe24HqTAphkZ
	6OHpcBqzEu8YXRAQnyhhEyFKch25E64YztW2TEzOdcRfjMp/j+1Uoo6N/ahNfl75Bpvm9Gju6w9
	KGSdhrVnGRb010/ODppmz2O46HtOrWkSoouuvCXILG6GjaUUUZP6rB1H/ySSeX2EUOMOM7SXm3S
	bpQ5lHDvyn8Fj4CIrdoFui+3rBW6dpEGdiL/IK4C97cpxW0vRt3y9s40n8zrC3lDNexN9Ib4Baj
	ayAfdPuL6sUKQa/Wex0ip1q14PqOmiJfBspnFyZbKtasP6+S+Hguv3ynrLxUmHw3PLZWXLXFU2m
	dM3oZrEqZ9V2RtvFrsVipeyteL1gLZzDh9mjggJZcF4bU9SmcfEa3jQYncOT9luW3wFl9qZGuJj
	QeWJ81ZCMpp52KFH2PVRZ8PQtWhrkX37dX2G/vGw62Y9aj6gn0ykEHOcouEoCEcLAEme32EL09z
	IY=
X-Received: by 2002:a05:7022:4c:b0:137:ef8d:a58 with SMTP id a92af1059eb24-1384baee9ffmr4877889c88.3.1781465070305;
        Sun, 14 Jun 2026 12:24:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8fbde7sm8116004c88.2.2026.06.14.12.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:24:29 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:24:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
 andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
 jonas.gorski@gmail.com, horms@kernel.org
Subject: Re: [PATCH iproute2-next v3] ip/bond: add lacp_strict support
Message-ID: <20260614122426.764f0f95@phoenix.local>
In-Reply-To: <20260612143133.1638767-1-louis.scalbert@6wind.com>
References: <20260612143133.1638767-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,phoenix.local:mid,vger.kernel.org:from_smtp,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5484F682069

On Fri, 12 Jun 2026 16:31:33 +0200
Louis Scalbert <louis.scalbert@6wind.com> wrote:

> +	if (tb[IFLA_BOND_LACP_STRICT]) {
> +		const char *lacp_strict = get_name(lacp_strict_tbl,
> +						 rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]));
> +		print_string(PRINT_ANY,
> +			     "lacp_strict",
> +			     "lacp_strict %s ",
> +			     lacp_strict);
> +	}

This is a boolean value. See other discussions of how to show boolean values in JSON.
I would prefer using either presence (matches the command syntax) or use boolean attribute

