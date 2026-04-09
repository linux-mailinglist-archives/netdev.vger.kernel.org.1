Return-Path: <netdev+bounces-277111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFaHNZn512mrVAgAu9opvQ
	(envelope-from <netdev+bounces-277111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D23CEF96
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A80E73019763
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5692329E6F;
	Thu,  9 Apr 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncGZEAeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745992DA775
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761813; cv=none; b=fEL+aye2IsUlvI/f93XLpRWUTsoRO7EFsO6SN5k/9TQBHBcnCXq2Yl8eoKWJnhjxxD/wyrD61r2l8KMVCi/EGuY9469AN80f6r60FFRX8GhSw8r66zPm7Qn7rNEAIGXsrrUeQc9pnnknaNG7FmYE1fP5d50YwLezwUqUn1a5lEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761813; c=relaxed/simple;
	bh=n14zN3KADu4543DLvdmzoPnsMLU7ZRDnLP/oBDxar2U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ykk2xet4/QtYBX31HR+vLiugD53LLa+RDhK/dz5kFc/CFpTkJLxb3LwpS53cRNR2z1p1T4Eqs3PJkRccsgBjjtX2q5vW5Y4vlMrA8txDDw7h3C1aCHi7dtyetZfI57RwQo1iGVBRNOqikZnQlFurYiuwE5aqT/aCSlGtT2+YXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncGZEAeX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e0553bdso13859027b3.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775761811; x=1776366611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QprOZSDxTj82+CvyS6RGWMHqEGdQWY+21dIbE8xcXa0=;
        b=ncGZEAeXVZPXa8rGX/kwTl/7GQlA/GjBlVcM7kf91AuVXj3iZHJb2gjgcDAKetH/WG
         ZXsbBNqy3Q+N/AFN4J8STqpFBSAFxV8fwwDGYYaonDxaFNvjBlhcZpR2LM86xR0xenB1
         WbHtH5AJcswbNYH11HhivHOkCxCoTcj6kd7jJqzBD7bSSWqGBs2y9T7R/3hSJkoZKOzV
         4KxbbFhzWk+Kxoh9VwMIYgUborxDESSa57brx9i3csX10m3N4t0hmcemjoFq8oZmw48k
         fpLqEkkgr2QVORl0dYHGO6dmfmY0dCJfEkYs53CSD3iRHKX9O+F1gV/OkCKN9agkuyGB
         Rt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761811; x=1776366611;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QprOZSDxTj82+CvyS6RGWMHqEGdQWY+21dIbE8xcXa0=;
        b=G5OCWTznhvyshRwi8QdddCtUrskCUWuw9/STRnQHVPKfCdaNEZ/AXZoAWPso/Bw//m
         JY6DyiT0PekqrHcHvsIsVMOeOsHQH0u0O2fSg3uxOJiwFLXB3skxCFzYzQR+rDgY6S+l
         4+FWzYmsfJgXonLT7tcvNbjPNZza0ddDrlIg0xFyKwe1nHuKh3wG0R8ymM2CdqMjzdam
         Rj7OTseIN5maFcRfbV6BPhirF78A8u/z5HgFbI8BW7nVsWok6ZPUHS0/D9FfCcXzIeR5
         J64Mix3LsFlpM9Aki/gvRhxJpUsTdNfUXiJ+8Ts93tMTyyN3Z1SeK+B4UOCkfJPBAs2J
         f5hw==
X-Forwarded-Encrypted: i=1; AJvYcCX5w896FfbBS/+TopdFApvAYRjb6hg9FGRgmL+yf07z0e7uKT6ClRUPenmsdhTYGYV/CgoGrgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKjBM9FVIBwJP42Drgb4tQj7rHliq4/lg7Jb11G6q73vslUBP
	UzUfppOGEKVcJFOEbuzBQAdobOs5DasaA7eCnx1RiszMWDTeSTwwVau2
X-Gm-Gg: AeBDievzcoKjPkAJVl+796WKpixM/Yz7RDSg48X4fIq7Ib01XDCvg84ecCk0QBBncnX
	oALbqVa1/3amcAySif9TmnDCLcdhaN2dar5bh89dZ8p5nKqKptopaRDMGS5wbHtvSH9/ugAn15S
	L4+U+h74Ej+6tCIZuGyQs+p7ZWvGqm82USWDJ2G/WuZvzXqQzbReGYLxxMSz4mfbk8t1rh+CXyi
	wYG0pwLuwnXFp8r3eGO7wdMrVI7ZwqEhUjzPAxO0FdF2hr8YG2odq8fijDZyf6bD6VWbV8bza6n
	vIe8JrOfxeo4wbT8GVoEu65Vsv4yyWXSL/DnJaajQi7Ysrz6tz15uPTMK/dDkgFxNQFavfmcrQr
	nnR5YvA9oPaaBcoaH2I4f/ITSNLkxJd6Id/pIcj+eZbMoh9v3iOddnzfePXasM2owvcSMRUp6iF
	20KWxhf2j46vAwSf1e6CdS5h0XW2rKs5bsRIahP+hWooFXCuA9EqFbQzdb2oZgHt5DLaMT+UnzJ
	pJd
X-Received: by 2002:a05:690c:1a:b0:79c:c51c:7f57 with SMTP id 00721157ae682-7af71479a21mr1697637b3.27.1775761811124;
        Thu, 09 Apr 2026 12:10:11 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa0618fsm2881137b3.37.2026.04.09.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:10:10 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:10:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.b23e27d8b455@gmail.com>
In-Reply-To: <20260409164238.661091-1-willemdebruijn.kernel@gmail.com>
References: <20260409164238.661091-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4] selftests/net: convert so_txtime to drv-net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-277111-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[so_txtime.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C6D23CEF96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Also update so_txtime.c to not exit on first failure, but run to
> completion and report exit code there. This helps with debugging
> unexpected results, especially when processing multiple packets,
> as in the "reverse_order" testcase.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

> +def main() -> None:
> +    """Boilerplate ksft main."""
> +    with NetDrvEpEnv(__file__) as cfg:
> +        # Record original root qdisc
> +        cmd_obj = cmd((f"tc -j qdisc show dev {cfg.ifname} root"))
> +        qdisc_root = json.loads(cmd_obj.stdout)[0].get("kind", None)
> +
> +        ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
> +
> +        # Restore original root qdisc. If mq, populate with default_qdisc nodes
> +        if (qdisc_root):

I evidently couldn't resist a touch up after running through pylint.

Unnecessary parentheses. Only a warn. But I can resubmit irrespective
of other concerns.

Again, could add a tc helper (in a separate patch) to hide some of the
open coded ugliness too.

> +            cmd(f"tc qdisc replace dev {cfg.ifname} root {qdisc_root}")
> +    ksft_exit()

