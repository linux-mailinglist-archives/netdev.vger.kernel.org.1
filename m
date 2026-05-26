Return-Path: <netdev+bounces-291572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGuZLH9RFWrcUQcAu9opvQ
	(envelope-from <netdev+bounces-291572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:53:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A355D20CD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147E2303DA80
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B6379981;
	Tue, 26 May 2026 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OHI7MpeD"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398A372EE0;
	Tue, 26 May 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781849; cv=none; b=gyTCaiFMzyJdY55JNyfvTUK048poh/CqebStAWs/YvNfzOGmjzEmZy6jGTFx3lRXnaEkUKNzYveXvAvdQoH70K/DWNaSbRr2Erv7J4RkGuQw38LriVfZFyq2mtNpO4uvm7capFaVIAlVuaMdr1LbRGP+h4jRfjoXdaCqT5360sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781849; c=relaxed/simple;
	bh=3+8h2LVd6e6BfP7xiRmePnQ5IiM5uSfl15N9rF6uBLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0hY4zT3O9pWCRJyyqz6PmxcSDZgK1PwXLqJda94PYVcCzZ/jSfMGtc5iRKf7tcDq5yF2fO5PU5D4CZ4q0nXNrJD6zGk7vLiXLtJ4MFw5PqMUK+9KraYTforFmzTsiwWcDO/+YFYRXFU872mIrVRN7rPWrXhLCdKi7YJq7IvbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OHI7MpeD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 390A2205CF;
	Tue, 26 May 2026 09:50:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5EwdLk3yPXoC; Tue, 26 May 2026 09:50:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9C42120561;
	Tue, 26 May 2026 09:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9C42120561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779781838;
	bh=35U0GTtFRbefYOOkMKhTPCKYAjjE9t/vLl5dDLtNmMg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OHI7MpeDC3akK5HBYZ0Mz7mbC02niMwF7qdbvKw8Lsx4z7fyDeZgoprjgauq2aCHs
	 Zm7HSXOKve7UWOK8w+32rcZsUwhivq1lctV8AaW3po6H9BHFbSPgMK+1H+TWKwdICh
	 /VLhGf7tST9YSydYqFiKod27zwtGNMMuycvqD0oRBPhmON/qJQNr2qKYnNAy8VFZBY
	 1Emj6WSLg0YDQ3feblkDhcRK+KPBoQ4T0R15sjv1qn5LYknyVvqSvtuMZV34ARjvkx
	 zajPja0Mhsms7ILKBFQU2kRY1NvNdEQguStFC6we4iAa63xk4Q7pBBEpe74NTYZJsO
	 AjZGGmNyw8B8w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 09:50:37 +0200
Received: (nullmailer pid 84277 invoked by uid 1000);
	Tue, 26 May 2026 07:50:36 -0000
Date: Tue, 26 May 2026 09:50:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, e521588
	<alessandro.schino@sbb.ch>
Subject: Re: [PATCH ipsec v2] esp: fix page frag reference leak on
 skb_to_sgvec failure
Message-ID: <ahVQzN3zzHfRoTD1@secunet.com>
References: <20260520072717.2043-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520072717.2043-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09A355D20CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:27:17AM +0200, Alessandro Schino wrote:
> From: e521588 <alessandro.schino@sbb.ch>
> 
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache. The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes.
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>   3. Second skb_to_sgvec() fails -> goto error_free
>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> 
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags without checking
> req->src and req->dst, since those fields are not yet initialized by
> aead_request_set_crypt() at the point of the error. Existing callers
> pass false to preserve the original behavior.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> 
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>

Applied to the ipsec tree, thanks a lot!

