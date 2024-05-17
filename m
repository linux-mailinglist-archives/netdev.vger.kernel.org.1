Return-Path: <netdev+bounces-96995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E88C896A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB71C21EDE
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFFD12F588;
	Fri, 17 May 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg9uP2tq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1E12F39B
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960237; cv=none; b=CsNs0IJpPADY30LmDjFH6Eqn+5Gr2sbLnWScLDUex/U+ThUq71xwBEnA1yJi9u0JwC0rHgWIKQ+XZCoSXd/Jmpcah/vJv6EuE6YezDOMRE/11h09CwRsRf0TYjslBCScIWL3JYpTYkiooJbDokzJ4qyjq9H8sTFNxpegcRtv7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960237; c=relaxed/simple;
	bh=s9IKSXjQQ0F0zhaJQllp6OK0JSl6n8PIMwYIr1D3+eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVF5cNRaWcAEsbGmOOJzb3sNd1G0Eyz6QKGsMgDtdPe3hkM04LDbxfHsd+KbHGGaoPDg53bYcX3Nm4Zq+izx3DNSk9TRLAhHH3Dth+6xtardLus5zhEuZ2Bli7Vv6z/x9eGag5VdyCdFVLhI+rW/ffRZPGv1QwwCoIqDOGVbMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eg9uP2tq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715960234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DMaNd1X0EjIWhl5yZx/Dvg4/jtmNGNBT4wiHgYISUE=;
	b=eg9uP2tq//PbrZzY8DnJGjRZwaBWQcKK9R6q4jJWA0nz/BTM8TlKdeXczyPukxMPWgkZq3
	pluBR+63NnmS4Jj6CMQhb23dv3J2HagPxVoSflyq7h2qdB+gEgKVYSEq1yWjReYU8vGoh1
	KL4Z4qsKyMAQzb3OBy0vOkEYqvCUv/4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-WVt0THKtMum2QffuosTRYA-1; Fri,
 17 May 2024 11:37:12 -0400
X-MC-Unique: WVt0THKtMum2QffuosTRYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EE1538157BA;
	Fri, 17 May 2024 15:37:12 +0000 (UTC)
Received: from localhost (unknown [10.22.9.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53AB02026D68;
	Fri, 17 May 2024 15:37:12 +0000 (UTC)
Date: Fri, 17 May 2024 11:37:10 -0400
From: Eric Garver <eric@garver.life>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next] netfilter: nft_fib: allow from forward/input
 without iif selector
Message-ID: <Zkd5pmHsYqN0LBbR@egarver-mac>
Mail-Followup-To: Eric Garver <eric@garver.life>, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
References: <20240517151137.89270-1-eric@garver.life>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517151137.89270-1-eric@garver.life>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, May 17, 2024 at 11:11:37AM -0400, Eric Garver wrote:
> This removes the restriction of needing iif selector in the
> forward/input hooks for fib lookups when requested result is
> oif/oifname.
> 
> Removing this restriction allows "loose" lookups from the forward hooks.
> 
> Signed-off-by: Eric Garver <eric@garver.life>
> ---

I mistakenly sent this to the wrong list. Sorry. Please ignore.

I'll repost to netfilter-devel.


