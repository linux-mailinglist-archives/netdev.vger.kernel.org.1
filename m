Return-Path: <netdev+bounces-272134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UlgUCaZgxWnT9wQAu9opvQ
	(envelope-from <netdev+bounces-272134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AD338815
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5FF830E1388
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC51413236;
	Thu, 26 Mar 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcXmX+gR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDF411621
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542383; cv=none; b=NfmCojpoEz3Ben5rJ0eu8Uik0AGiNNUmDvcaz5Lw0ofLQkWIzMTnzztcAyzKFoEBc29Gn9BaFsqICIpreZ2bK9yvfMeH3u0D7ju7cj+37OXJmCAuDSUmXb98q/+Oz7uramJvPdJWSW1CrkZUjQsssvieR/lsy4u7jamUHaQHH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542383; c=relaxed/simple;
	bh=hMI3wwYbiv755ypF1OFwUg5XQoKyqa1uTj8xyFKe2Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzSCjuOGAquovmG1VN/a/botKL30YwooIVrKhj1OvR3v8g94L48KRJgq4oDEI9Tk3p+3R1c1a1rCf3+gP0WsjHfHaN/J3paqw8kepNrUqJWOnhxVRyTBjhh7wA0FAaM0vZ/5saMHEtlq5t+kdMjbVLWUVBqEbgeAeqvGoEuIomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcXmX+gR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774542380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sISmUulqTuIkgKjT3+FKg8EXFc7ofXCMVqBMEjgagdk=;
	b=VcXmX+gROU/5GCHda5JxKwJQ1D5Hvx35oUqeyaDNyxcxEJx2x0Ta2Rb49ei176leU9YrvZ
	qjpvZ3C4aEpOjEmhChU41sPpaPPI+qCJl5z76hRr86+2WXyEDoWlASFbL6diSVQqGKUaNP
	KjReIK8+zYWwSAuJgicYdXeHvhx/lCg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-vvRkY6qxPkOnAdDiYxqGnA-1; Thu,
 26 Mar 2026 12:26:17 -0400
X-MC-Unique: vvRkY6qxPkOnAdDiYxqGnA-1
X-Mimecast-MFC-AGG-ID: vvRkY6qxPkOnAdDiYxqGnA_1774542376
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1797319560A7;
	Thu, 26 Mar 2026 16:26:16 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A88FC30002C3;
	Thu, 26 Mar 2026 16:26:12 +0000 (UTC)
Date: Thu, 26 Mar 2026 17:26:09 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 7/7] net: hsr: use BIT() macro for bit shift
 constant
Message-ID: <acVeIQ6K2ytmD5Yq@thinkpad>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
 <20260324144630.189094-8-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324144630.189094-8-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272134-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 7A8AD338815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:46:30PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Replace the explicit bit shift (1 << HSR_SEQ_BLOCK_SHIFT) with the
> standardized BIT() macro for defining HSR_SEQ_BLOCK_SIZE. This improves
> readability and aligns with kernel coding conventions.

I know that checkpatch suggests this, but I don't agree with it:
HSR_SEQ_BLOCK_SHIFT is not a bitmap but a number, so in my opinion the
BIT() macro makes this particular define harder to read/understand.

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_framereg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index c65ecb925734..cb731ee0ce5c 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -79,7 +79,7 @@ struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node, u16 block_idx);
>  #endif
>
>  #define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
> -#define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
> +#define HSR_SEQ_BLOCK_SIZE BIT(HSR_SEQ_BLOCK_SHIFT)
>  #define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
>  #define HSR_MAX_SEQ_BLOCKS 64
>
> --
> 2.53.0
>


