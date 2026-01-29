Return-Path: <netdev+bounces-254804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCMbB0dhe2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:31:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E23B0679
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B562B3004400
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A22EBBBC;
	Thu, 29 Jan 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6xpqiBa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD61EE00A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693505; cv=none; b=aURfuxdjulh24sltfuSCIKlMDt5YImQznVA+dS0fXHKC/Bob+vqhhbzknd8O/Z0vP7V4n5ZUA7qVcgBaqrUE0ygsxBejRPhQG/6FERjPBqEBFTk6UQClMj079TiqKe1RfUdSQ1ffUen3zmyy6mllareKtVQ7DM9OdL4QSTpKYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693505; c=relaxed/simple;
	bh=76mmOFiyQQW8SFvFMkR35iY7KEqPo+B478jfdV4Vy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meeivIQv0shZc19xuhXt7v/iHgovkHP0fqEZ5LG7datYDyi2tIqBFLOSZ+eamvbUh8oHzy5iAyeZYWeNMmDVUrIfoTcmaOvanihjw7yI9bmUcQrcAN5lgN3E+N8v0utvksbVcZTJ7gkCvI+E8pm07LKyFK+4ZzqGuzyHwbX57uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6xpqiBa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769693502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uu5RdoWNelOc/iLKQPuo+ICKbKh3CoH2Iff7vRbPg0E=;
	b=W6xpqiBa/G0BCcffPVmpcy4lm/FFy80VfQTh1zVtBV3CrHEgauK1VwcpUDO6S89uC5Ouxv
	3xV1X1FToHU/MD8DM1MAGW/s83CU9tCFDWEuohus+/Sywf+7FcgF4KMqcxXKaMyRhPU60G
	3TLVo2/XykNTD9SSJg5IjuakQfW/HMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-b5eyKP56PgatVJpDFPR7Bw-1; Thu,
 29 Jan 2026 08:31:39 -0500
X-MC-Unique: b5eyKP56PgatVJpDFPR7Bw-1
X-Mimecast-MFC-AGG-ID: b5eyKP56PgatVJpDFPR7Bw_1769693497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CAEF195608E;
	Thu, 29 Jan 2026 13:31:37 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D812A1800994;
	Thu, 29 Jan 2026 13:31:33 +0000 (UTC)
Date: Thu, 29 Jan 2026 14:31:30 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aXthMlr6Hpas1LBt@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129110500.l2jOMEYp@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254804-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30E23B0679
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:05:00PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-22 15:56:56 [+0100], Felix Maurer wrote:
> > diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/testing/selftests/net/hsr/prp_ping.sh
> > new file mode 100755
> > index 000000000000..fd2ba9f05d4c
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/hsr/prp_ping.sh
> …
> > +	# MAC addresses will be copied from LAN A interface
> > +	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
> > +	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
>
> so I somehow started this (I think) but while browsing the spec it
> somehow says that the same MAC address should be used on both ports.
> Could it be?
> It says that the two frames are identical except for the LAN field and
> checksum. Also the duplication is defined on src-MAC + seq nr.
> Having this requires to merge the two MACs for a node and we do this but
> could this be a left over from an older version of the spec or a
> behaviour that was not meant happen?

Yes, for PRP it is required that both ports, A and B, of a node send
with the same MAC. For us that means that the two ports need to be
configured with the same MAC address. This used to be a common source of
configuration errors. Therefore, b65999e7238e ("net: hsr: sync hw addr
of slave2 according to slave1 hw addr on PRP") made it so that we are
now copying the MAC from port A to port B.

Therefore, I'm only setting the MAC of vethA on each node in the test.
Even this is not strictly necessary but it turns out that debugging is a
lot simpler, when it is obvious addresses belong to which node.

Thanks,
   Felix


