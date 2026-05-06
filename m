Return-Path: <netdev+bounces-285012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGW2JyyX+2ladAMAu9opvQ
	(envelope-from <netdev+bounces-285012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99D4DFCA9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79BEA30071D0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D931AAAA;
	Wed,  6 May 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvd+kKoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B317318ED6
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095912; cv=none; b=XUOQ1VAgudEPdG2UBrDWXCcvHxsLZDT7kVaXK2tIs3XeMG5K8VIqRnKyqxllfLIgD7++X1whHOsrL+o4ZN263WiWF0vWejEzexyr+hWOSZHsnWvi02D3Yx58f87c8PgwVAY+Vd3UEMr5mtJXnGF/gu9ks6UCSU9G9Ijstyr5BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095912; c=relaxed/simple;
	bh=iZSa9x+NGfYe7SE7VaqLueKdW2vGNSge+YaCCBwijLA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XryeRb9Hb8jZzp/krKj5qSK9DoO7WOEFZmoZFHnbWG1lsnrLvRN3n1umjb1ARxcB3ods1l9FxNaOTS1hxy853uMhBKWautVDKj4RzFIg7ETwfEpa0VeGk4/IVwA5rtjun733w3BLFaz23oNZAZKtbz6tR6Lt5RYPCnVxqIFffII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvd+kKoJ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c37eafcbeso9544d50.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778095910; x=1778700710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8BkpSYgNobLaOaccEcCmnUd9ThyuPsAjj7zXcBaElY=;
        b=Rvd+kKoJdTQ4aR/2xY+py7GZxaMbX/XPcT8pMnU32n7xeqKD2R2fX/rpTViSiwjFQA
         btDmcTQ+ZeP74PhNeErtuH30JgQmYPhuH96dYb0BhRVs+xrkxH2Ybi8qxLeQo2Pq+CX8
         aolZ+CH2zWFEIUJXY+d/l1gANVoews6JuzylEBl43wWQnkquF+FAYhBhYl9ZyO2qH075
         ePsjh0KvVBxdv80g18fe2KocpivbFTtrM6FlTdJ6GaK7vQhmduscUvmTTc9WQW2uJacw
         DdOHkXb74AQYcnkW7a8UMDdLhnEXth14GnUZWIdX1l+oBnVjpNKW/+KiDlUKQlnWqYiP
         TMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778095910; x=1778700710;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8BkpSYgNobLaOaccEcCmnUd9ThyuPsAjj7zXcBaElY=;
        b=tN1pzI1I8F8v0TsFSaBC8BpxLEYN83kpp6jHZhHh0OS2891euJhM/6GYx/K09bfMz3
         8tw42k0bkAqozWuY5Q4oKUv8f0NFgvwuy1G0GulADAib6SqlMt0C7QL1+nO5EHB4qMY9
         udsyrWApcL2K19JFAjklfOGuZCQy2wpQoiJwvi/erUSmnWRPZJFwOE6b2rb9mFxkmB/m
         PO+E0mH+E5QqrZiO5KOrhZYYtrr8WujzvDoZCk9HnUJUdLQoM/EXNBGuZcS+3TfDVn2c
         ikT4SEc8YX68Bs6xaRVLPOlWPXg2XD0zjXnvUp0rwYjcY4qfPNd8R7IVDi0ksjkpYeXV
         ca5g==
X-Gm-Message-State: AOJu0YzRrzpZTUifOh79k9A85LO14CmjvDeL0d4krYQHx2xrRcgloVXA
	G6I+lgiR0k568TRsNdmwn+ud+aXTFrMA8Q51jv005+T7U8xISui+s/qw
X-Gm-Gg: AeBDievk09DGHNp8WTglz2LJNv4jVYxEc0aVwAUZxGg/cYLoziaD/i6+KQp9Qzbwkam
	/CFJ6fdvYnBtyZvRybSxIUBgFmVEtSmIQcpgeHZO3LOlv0CO0T4Ku6n1xmqRi7MP++k1AnoAvIG
	4xx6yn0PKntk1nM3lnmn/1ame2kBustZgNcyfl1btIuhDzLV0aUqc7zuJHYqksPxWik6+6aq4NU
	1qbomOT6dkP/0MaZazrtfa9DnT/X6hUpfbb1OtdzeImO+II6+kbPaNNnOix92Wk6XXLq8iAlF9R
	6TRW0o53BXn/VmybdwaN7Er/7OFDl9AfHml7aAt8fT6XPXiQdhfL7RvfwPr5nCDBHzLetDKZMm/
	xd0keXWe4yV87zbvzLUa//xV06whU5vH2euzrFy3ihixyX7uLkCxkWVoVl5iDxxyBPiogd7hkpO
	hdkS58qZhmnKHnkyAOwsuJboVsn93hN5cGDmTdA3GA4Le8MvlFO3fjd6oArG86JP9/ljfvzSJso
	oYOrjYnE2Bj+Z8=
X-Received: by 2002:a53:cf0a:0:b0:651:97ba:8507 with SMTP id 956f58d0204a3-65c79a2e692mr3769937d50.59.1778095910361;
        Wed, 06 May 2026 12:31:50 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7af99a95sm1524615d50.12.2026.05.06.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:31:49 -0700 (PDT)
Date: Wed, 06 May 2026 15:31:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.15fa63687b81@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-2-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
 <20260505-psd-rcu-v1-2-a8f69ec1ab96@gmail.com>
Subject: Re: [PATCH net 2/3] netdevsim: psp: serialize calls to
 nsim_psp_uninit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3D99D4DFCA9
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-285012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Daniel Zahka wrote:
> The debugfs write handler, nsim_psp_rereg_write(), can race against
> nsim_destroy() and against itself, causing nsim_psp_uninit() to run
> more than once concurrently. Two complementary changes serialize all
> callers:

nit: sounds and looks as if this would be simpler as two patches.
but no need to respin just for that.

> 
> 1. Delete the psp_rereg debugfs file from nsim_psp_uninit() before
>    doing the actual teardown. debugfs_remove() drains any in-flight
>    writers and prevents new ones from starting.
> 
> 2. Add a mutex around the body of nsim_psp_rereg_write() so that two
>    concurrent userspace writers cannot both enter the teardown path
>    at once.
> 
> The teardown work itself is moved into a new __nsim_psp_uninit() that
> the rereg handler calls under the mutex, while the public
> nsim_psp_uninit() wraps it with the debugfs_remove()/mutex_destroy()
> pair so nsim_destroy() doesn't have to know about the psp internals.
> 
> Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

