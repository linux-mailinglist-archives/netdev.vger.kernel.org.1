Return-Path: <netdev+bounces-284986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOBqOx6C+2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2994DF1EB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3191C300CBE5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1C4A3412;
	Wed,  6 May 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="O9PgqXFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2d0UTaV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C14ADD89;
	Wed,  6 May 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090114; cv=none; b=MRjp+GTn3moOaMXudXF+j2AgXSHAlr3Dh0csw09kkqBFotilsjrILtZk17DD+kiQQ+JBraXK46MBCTh00LsDQureabIhvhbcnd334frmMxqV8v5qmTR5OwMaZscyAliUpW+Z2S69NI+rTsvlmunW09w22uqmTS1xNcDHsnurYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090114; c=relaxed/simple;
	bh=UvGzjB9e6II4OV2P6M+tCQNE8RjC2PTuEdYebG8fLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRLb+ZIMHQReWdMIB0h4xfpIZOja0PsQa2kj6Fdy1DuEVhL43EQNYU8CZderRkIMpZAzgdsAIuHu2i1T6kvOzkVDxF2J3PVD+683hBY6wFxmvjFUmGf6jg2qP4uEwjBh+l9PNPvtCoWK3vZe5XK8IjK5SKZolo1CZL3zZ3uuSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=O9PgqXFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2d0UTaV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CAFEEC003D;
	Wed,  6 May 2026 13:55:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 06 May 2026 13:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778090108; x=
	1778176508; bh=DPTcjFZ65zVQVyT0o+Z8OC8XMHP4Q4wnDNqmSpzZzWc=; b=O
	9PgqXFQAKKFqsn+5kb06l/+ffz44+UnvZ0o12VoYHLEufsPqyAFk0Aqzym1Wm4zY
	SE0ymGjFCFqTXmKmOALXx9B4rM9WgqG9dDFIYKOu9FCPCQkjOpJ6ONPRLJrN0I2N
	0aWFLdhQW0hN1iilenGgEQz6tEIjKF4aB+nm/oT+Id1y670l3nwIpnsF93J/apPm
	yEJZldZLh6Wgkn5R6EkeIxyFFFr9RCNBGqCR4N1tls40+VfQgShFktfvWp99YA48
	TEiagq2ESSk455TxybPzSiGHQpZQu40FgjMj3lOYfdZG8tfV4rlEOGLo2Qvym3fi
	RoZ+3g51rQLzEgqdkIhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778090108; x=1778176508; bh=DPTcjFZ65zVQVyT0o+Z8OC8XMHP4Q4wnDNq
	mSpzZzWc=; b=h2d0UTaVd2QYRLSn4rEND0Js9af+9gtlU61VANmaqlQE8lYzbGs
	dSXVzEKmvI/hDbXnm/WKxGwt6UjdBTwfpwUvRR39flrwostGUI8Y6LScTvn0kQPu
	tkO/Adh1oLCD22fLUoxYmARB/81WEAhXGeZHFU1TxJ5AqY6sUbDgkPd5/lLIE6+D
	oWj0dExmdNpyQQ0uI0R3GTQjpbgaO8xm6LWJf9LElleYhgiYgap6P0IgM+Xksh3S
	Aj1p0EfgOibQ0fIQNgwe3XSnEknWnrtbGJUGYwDPck2uHaO61wLnR4FDF7+CH9Jd
	Lxhp0xUSdItBSwNH3Y8H+0whcuRpa1KyGQQ==
X-ME-Sender: <xms:e4D7aTp0xUGDgsB83yIDJcpkLQRod1maW3DCiXOOsdqiIw6uU5gTEg>
    <xme:e4D7ab4ebzu3FaxhaP838j-9OsAbtYk9IbWQLd5OdxrNPfIvCTV0pBBot7pV5mD_D
    jC6Eyf7P2-2sPGbJyVOUS5qBR3A0_ecrnfpN6O8DyjpSZPDyiC8SQxT>
X-ME-Received: <xmr:e4D7aZgOZTa2TDgZT-EsFNG1ujgcaBD1Z3j2bxkVoH4nfkEKgajsSjIBDj8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegr
    lhgvgihjlhiihhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifod
    hnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhi
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvnhihrghnghihrghnghegsehhuhgrfigvihdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e4D7aZ6ZKC_Irme7YFi_ZcQyp7m98eeU2MetqYPEtYVZgUllv-UqTQ>
    <xmx:e4D7aWF3wP97DrJvGdrnWR1X24Sq1rnKDNGx-vZiT0TwdsnKZccpmA>
    <xmx:e4D7aTJl0bh4gncf0tljph7FnNMEVP72gcrRkjAm-RO0lCGLw7ZKBQ>
    <xmx:e4D7abg7fECMIM_v0XSVB-7u2w8jg0yFJbhgIRFbUn5bZVLGaj3Hpg>
    <xmx:fID7aZIUncab5tQXGaJ18yTvVfpGvNTYKXaXczfrOrjc6bMINwAIQCcm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 13:55:06 -0400 (EDT)
Date: Wed, 6 May 2026 19:55:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: alexjlzheng@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shenyangyang4@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexjlzheng@tencent.com
Subject: Re: [PATCH] macsec: defer RX SA cleanup from RCU callback to
 workqueue
Message-ID: <afuAePPNaufo-9Bl@krikkit>
References: <20260506100107.388184-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260506100107.388184-1-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: EF2994DF1EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284986-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

2026-05-06, 18:01:07 +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> crypto_free_aead() can call vunmap() internally (e.g. via
> dma_free_attrs() in hardware crypto drivers like hisi_sec2), which
> must not be called from softirq context.

Ok.

> free_rxsa() is an RCU callback and therefore runs in softirq context,
> causing a kernel crash when the underlying AEAD implementation
> performs DMA unmapping during tfm destruction:
> 
>   vunmap+0x4c/0x70
>   __iommu_dma_free+0xd0/0x138
>   dma_free_attrs+0xf4/0x100
>   sec_aead_exit+0x64/0xb8 [hisi_sec2]
>   crypto_destroy_tfm+0x98/0x110
>   free_rxsa+0x28/0x50 [macsec]
>   rcu_do_batch+0x184/0x460
>   rcu_core+0xf4/0x1f8
>   handle_softirqs+0x118/0x330
> 
> Fix this by splitting free_rxsa() into two parts: the RCU callback
> now only schedules a work item, and the actual resource release
> (crypto_free_aead, free_percpu, kfree) is done in a workqueue
> handler running in process context.
> 
> Add a destroy_work field to struct macsec_rx_sa and initialize it
> in init_rx_sa().

TXSAs go through exactly the same process (destruct via RCU and call
crypto_free_aead). I guess they would need exactly the same fix.


> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

Missing a Fixes tag (most likely c09440f7dcb3 ("macsec: introduce IEEE
802.1AE driver")).

>  drivers/net/macsec.c | 13 +++++++++++--
>  include/net/macsec.h |  2 ++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index f6cad0746a02..dabd3d2598ae 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -174,15 +174,23 @@ static void macsec_rxsc_put(struct macsec_rx_sc *sc)
>  		call_rcu(&sc->rcu_head, free_rx_sc_rcu);
>  }
>  
> -static void free_rxsa(struct rcu_head *head)
> +static void free_rxsa_work(struct work_struct *work)
>  {
> -	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
> +	struct macsec_rx_sa *sa = container_of(work, struct macsec_rx_sa,
> +					       destroy_work);
>  
>  	crypto_free_aead(sa->key.tfm);
>  	free_percpu(sa->stats);
>  	kfree(sa);
>  }
>  
> +static void free_rxsa(struct rcu_head *head)
> +{
> +	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
> +
> +	schedule_work(&sa->destroy_work);
> +}

This is quite ugly. I'd prefer to change the call_rcu() in
macsec_rxsa_put() to the schedule_work(), and then add a
synchronize_rcu() (to replace the current call_rcu()'s effects) at the
start of free_rxsa_work().

In addition, you need to modify macsec_exit() so that it waits on the
free_rxsa_work() calls. Otherwise, if they happen after the module has
finished unloading, the kernel will crash. Currently there's an
rcu_barrier() that waits for free_rxsa() running as RCU callback, but
it won't wait for the new work.

-- 
Sabrina

