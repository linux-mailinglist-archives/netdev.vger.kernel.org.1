Return-Path: <netdev+bounces-267013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fukEO5eWsmmKNwAAu9opvQ
	(envelope-from <netdev+bounces-267013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:33:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5842705B6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3150302290B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536333B27FC;
	Thu, 12 Mar 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfneSRB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qVcGTJtv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4635A3A5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311631; cv=none; b=k+WE5LTYr89tcRb16B0nRvIjDy+xzW5y8wDvnF2SjZ/tF+Dzy3mkIputMWpXMurKNZrdauuYf0SmnSP7oU5dB7VgCHOP5MJAyQRghwLrPfXHrQ+ujXD71vTX7lBbs2uuB7YkJeVzQxX6kTnz1ugN0WcgBqr0Ys2CP68X9Isu9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311631; c=relaxed/simple;
	bh=I92Dgb/jB1AYYveHEWh3vlctk8GDWQslLfVS20ovFMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjBKKDjldVy9ZKzO2oNjUkAuiagcOuHmVDAXQhKJQcHALYM3VXbQwT+fps11xWlqfuShN4RpZH2zVk8FdTYNc6TS3IFvKK4Rr+1xtYD9EmcNN7/0U+IEBpBGMuJRwsE7PcUMHJWp9CBQSjUc/vXC12KtDCvg17ewrlyvm+MzwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfneSRB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qVcGTJtv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJdYNZn0cGEQz1MWLeFDFxPGUmz2ObZieG8rujhYFsA=;
	b=GfneSRB7GPnm5+gKGJY5juQpMrgxKeTz8G77FhlnBw1Kgezz3wELtGPM1IJLEUFz8aWg3a
	1GFadKOQR14bigLMS3Q+32WKaLZg7imAt6SDrbzzrfD0pGw9uml5ZynHOKNJjyyu8un0jS
	XORebKot+lSx+Zu19uh7k6w3UWyfbOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-wDovPhfKN-qTXiSiNDrZZg-1; Thu, 12 Mar 2026 06:33:47 -0400
X-MC-Unique: wDovPhfKN-qTXiSiNDrZZg-1
X-Mimecast-MFC-AGG-ID: wDovPhfKN-qTXiSiNDrZZg_1773311626
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c54e0f6aso1055957f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773311626; x=1773916426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJdYNZn0cGEQz1MWLeFDFxPGUmz2ObZieG8rujhYFsA=;
        b=qVcGTJtvdm9813erDkTRUrZmuZP/WWT41Ou9/c55Q5/t3tOi/dzULqqc/BxVO4akmV
         0mEI7CnIYPKBhnIqhw2IBriNFifMGpP4xon34iGE6oiQjXDu9eXIEjIwFdj+efGp0lHh
         AC2AF8t6VI8tNM4VMx0tHbtyKc4GQW1TfAVm45B1ca5mzTQt4wkk8DHlP9IJRbLXOAl3
         Z9NJbQozP/vYLjKeILGHaeFnSIcznXLip9PIx1foWCJV6bXdW9ZhuMKJotEPU5QA3IjR
         HHCSPANz9GhdeJCtbVZ7G7ioBEAcg5rMj0n2VrFEUToAZ+PiS72O4DdQkLofGXemNG6X
         wCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311626; x=1773916426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJdYNZn0cGEQz1MWLeFDFxPGUmz2ObZieG8rujhYFsA=;
        b=F6hByLvFwn4Ew/hpD/cETIAbN178gEiiDq0U9/aX3F6gSxTDs220qpKe8j7IkQncoQ
         55X+yvhW5i3vytbb81vlwYSy9cv367GAbso/we7PJ2VsfNfd6zSWRxFo2YJgOK+iH7SP
         t7C+wDtA1kP3TQVJRb/sYPfn4+UOy7NcET8C+/qTcSW+o7sgyjhxTS6sC3YLUO8L+4im
         4CNDn+WEFAAhhF5b2XHClMzm7gmzU03OgcJizu2qssG7JAB+5fHHcigWKJh3uoR/z2x3
         7hlyJZz8BoE4e5WlWJSSzQZmqC+EKjq7Zl6hYuRq6AF93BwkutoJIKIm3DUsuYfkR27z
         +peQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaWmx+pbs+GI4d5SVc0Wi9G7zKIZIdL2nhdg4u5OUER4pbrD3mqZ84MjaAzQA+vHtRXte/W5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXILHmPxi19yR9UxPkry5FCHwmrqFauIy53YRjdMl4yoJtTmXi
	jqSdzDy2ne3d7by5HBDhF5GNrqAXvGLECgMdfonFcaVhl3ySP2HMfMz8YoFUDT0LPgUZC78L6lN
	57NjccldtcpoocrC5FBG/4D3T16uEqgmeo8RqHeaGJHspRvwhmvfo9wDRQg==
X-Gm-Gg: ATEYQzxSIGGCHApz88QnwLe5srIulFvHaxWLpVxA1QfG3EnZPAuMd2FTCErSJEwyH7f
	FCSUHCMHdqCfvCPwbDb97IJQ7Zw2SPNT9ctlYTGU5MkvtNd90jaGuKIR/r+lWo5azHuzJ7XQF3u
	48LJOG3+PHGw8uIv2IoQGEUcTviK/a3SWDSKXxqGleToQx9p3CwBR///MapQfC22vMSJp0Rol4J
	XfIEzRIJpFCViVf/gkYTsreAV6u/oOO1eYuV22dxScP7dEg3XL7MLiWUcMMyKHItpcZyyb9ziQQ
	fPj8Yp/2IIqAgJVZ3w7l+UTe7bu1W3yrfttxOSyAHkh8LT523lCJNg+6kHLFMekAWQ/Ql1CIsB3
	t8YiEg//wTPRvHliqjdnTffg0T2fxQrMDx9k8FwOTMTvs+xgL6GRB4P8rram85QuPFIZGH6NKBg
	L3
X-Received: by 2002:a5d:5f96:0:b0:439:b69b:3c8d with SMTP id ffacd0b85a97d-439fe199aefmr5646850f8f.13.1773311626327;
        Thu, 12 Mar 2026 03:33:46 -0700 (PDT)
X-Received: by 2002:a5d:5f96:0:b0:439:b69b:3c8d with SMTP id ffacd0b85a97d-439fe199aefmr5646799f8f.13.1773311625877;
        Thu, 12 Mar 2026 03:33:45 -0700 (PDT)
Received: from debian (2a01cb05923c9a00df57bce05e743070.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:df57:bce0:5e74:3070])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm7241612f8f.15.2026.03.12.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:33:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:33:43 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to
 NETDEV_PCPU_STAT_DSTATS
Message-ID: <abKWh_F-RgNUXpcD@debian>
References: <20260311123110.1471930-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311123110.1471930-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E5842705B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:31:10PM +0000, Eric Dumazet wrote:
> Blamed commits forgot that vxlan/geneve use udp_tunnel[6]_xmit_skb() which
> call iptunnel_xmit_stats().
> 
> iptunnel_xmit_stats() was assuming tunnels were only using
> NETDEV_PCPU_STAT_TSTATS.
> 
> @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> 
> 32bit kernels would either have corruptions or freezes if the syncp
> sequence was overwritten.
> 
> This patch also moves pcpu_stat_type closer to dev->{t,d}stats to avoid
> a potential cache line miss since iptunnel_xmit_stats() needs to read it.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thank!


