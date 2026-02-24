Return-Path: <netdev+bounces-260440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF1fD5d1nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF1184FE0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E1EE3013B72
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE135372B20;
	Tue, 24 Feb 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9SUf12m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNCN77qA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225C36B07D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926909; cv=none; b=eycg00XPBN5a1/NOJnxzs6Ez1Z6oIVLpdQcnxVJwb0AY8OPiwHUrVAZncabOTYpb3brKpoJhZwxPtijJRv+wAEFSsQm7axkNgT2reZfqlR87nssjYZ80PLzWG+as7yIBhuUg4bHX0oNCdJ8JjRLx3s8TERAIPgePVkqL1zkPAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926909; c=relaxed/simple;
	bh=ELCHW2MDcGHyAOjCI5TzQdz1gK18QvxlUMKh2Jmx5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPzx2I95ZFVpb1YghZu+UdGLP7zvM3NdcLR5ATAtt9rk/OqjhjV3/5bCr6gGAuruTn+vSqy/on9WLcxgLUjrsPBLCbJkXxqws5lUfcIWJTA6fQ6vkqvqpYy99+WZGYSIKDYmxYBGbybm6CYZdHNv/dY1aVOEIQiHsAmM8ijcnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9SUf12m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNCN77qA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771926907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drtPn3RRebLcYs+RKWbzRzgsO6cnVFeivrQ9r6WAvBs=;
	b=h9SUf12mKp8L6g8zx0SBkMi+GkEPQyEidXukdRDlJeJPC7tGoodQ9BZJvmuh9oCsxqk22D
	FaxIlgHL2mQTx3wjDldPLK6q7CFWS5TzDNR9SpQIzfjS8Au55gBL9ZVU2XsBKdqnuXniyt
	91OqDowN1LGNHB6lhOFtfRwh1ywV3fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-qVt2eaUtPPOsKcX9FO6dqg-1; Tue, 24 Feb 2026 04:55:04 -0500
X-MC-Unique: qVt2eaUtPPOsKcX9FO6dqg-1
X-Mimecast-MFC-AGG-ID: qVt2eaUtPPOsKcX9FO6dqg_1771926903
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43635708e98so3182032f8f.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771926903; x=1772531703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drtPn3RRebLcYs+RKWbzRzgsO6cnVFeivrQ9r6WAvBs=;
        b=iNCN77qAuxKgOl13Y6JbhmY7+rojnTQ7Pl8uN0y90x0GoQRHbeKi4rOnF9oNpMvA6S
         qi6qO/4cw5/Gkh4CTxGaarb0ObhFnI9Q48GyfsXmOyuR6r4VTQn3CvMa4qcvADBzDz/6
         c1FEJnRNfG2zehtrRkY1T/iZ4zwnoPrdXJUQalJfuECTWhmAj7aGqM0odArHIsaLXM+b
         cYnLkyBPxazyMFVDBAxU0y3Qs9czc1BbcaDv9EiSDI1gitBRbyS7TFe7AFk3oH1eD7F2
         hLm3FX+Pu5mp25jTPk2i6L6qIzomvWhZt0+4VqRHawRf9kdfNa08hn1GEZbBVV4nT9E+
         oJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926903; x=1772531703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drtPn3RRebLcYs+RKWbzRzgsO6cnVFeivrQ9r6WAvBs=;
        b=GIGr/e86Mic+MO4VoEUVytynxSM//AV4hpG2TjvmekA99gkR+3/OJxjyVdzqYgt3Kx
         L54E4B8EMfl6jhd7hfK7/Fo+TswKlhocpMQfu9CCF3lEPBjXPMuAPOzxu1NvgYKdgNpI
         B4oyNU9BevjSDh6iY0btZUmxxpVrts3jqk8PUbevxfM1d8MAjyKdVqgHCOWbejfQ0r02
         BneKieP4QTmP0GWC/w4hAbvYmxdKkHcvljYo1MtBXH/V31jNinAke98QCCMbS978YJbM
         ddps6fB2yBzKbSGTfXuaBRkILp10WgnWiM+q471jlzfuPn/BG0hVcw1yHE0bko5TTih/
         u/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq1vOXsSHRzKYn9apTKQIq9LfGBSopQed+t3ZwJ0xT7AJ8TJLMT7rIiJ/YvPKMRaWBwCP0P8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvCu6TXi95O3TnAIlCsg2IyEDsQ7lKfpDK7Xhy6bk286Luwtn
	+cijmu/3GhyZXP7tvlL/N5ONsWrNWAr9QaTz3UkI59zqZnThjBw+70zpvGVvHMzIfA1kNtpffXY
	G182m2bgbdz0iHJjLC8lO3gAiPM4Pcu2DVUxkMnlOamrewuDu/R+EnUK2lg==
X-Gm-Gg: ATEYQzyFIOBuRcTWopzYpQVXAp8Y3oiXVsF/ta7D3LA0dt3iViYszeqm5JJWLf0pTNd
	Z3iDkDJ+orQlk8omqMhdx5A6u02r47/4mPo22KNgUKAferNSRH5pIcdXcFdGhUcxyHM34l/tZjd
	OrT5GGcfhKu6d5qH1kXiLMtMzSEUZTs0pDw9DyAqRw+QfNISm5lKYyobtllWPS48Rb46h+wCoSm
	GXAIN+dZHTSNs29RlU3MNClqPhxayp0wBfox+9yRqXnWlL42+6CTMA+K2iCi1mZGp+pHbMwKOmZ
	P9gSHldKqQD5V9EzwWJklMy5FwuB+3ZPQ7sikUHZPJ7XgRC1lGNNeNhDyedyFYEnE8V+4nbtVw+
	VUKQ/ntX0JxTeYqIdbmX98Ji0G8PmpM5mHouC1tae/5D0jPLxDhKL4ET2EEpF7JQTTbffD1g=
X-Received: by 2002:a05:6000:2011:b0:437:6dac:458a with SMTP id ffacd0b85a97d-4396f18f82bmr19853121f8f.57.1771926903204;
        Tue, 24 Feb 2026 01:55:03 -0800 (PST)
X-Received: by 2002:a05:6000:2011:b0:437:6dac:458a with SMTP id ffacd0b85a97d-4396f18f82bmr19853090f8f.57.1771926902713;
        Tue, 24 Feb 2026 01:55:02 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm26032093f8f.17.2026.02.24.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:55:02 -0800 (PST)
Date: Tue, 24 Feb 2026 10:54:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl handlers
Message-ID: <aZ1oTufA5JkTBl35@sgarzare-redhat>
References: <2026022318-rearview-gallery-ae13@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260440-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B0FF1184FE0
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:32:18PM +0100, Greg Kroah-Hartman wrote:
>current->nsproxy is should not be accessed directly as syzbot has found
                   ^
nit: "is" can be removed

>that it could be NULL at times, causing crashes.  Fix up the af_vsock
>sysctl handlers to use container_of() to deal with the current net
>namespace instead of attempting to rely on current.
>
>This is the same type of change done in commit 7f5611cbc487 ("rds:
>sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: stable <stable@kernel.org>

I'm not sure this is stable material since these changes landed in the 
latest merge window (v7.0-rc1), but yeah, you know better than me, so 
there could be a reason.

If needed, maybe we can also add:

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")

>Assisted-by: gkh_clanker_2000
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>
>Note, this is compile-tested only.  Some of my scripts found this when
>looking for places that are missing fixes that were applied to other
>parts of the kernel.  I think the af_vsock code uses namespaces, but as
>I don't know the network stack at all I figured I would let you all
>review it to tell me how wrong I got this change and all is fine with
>the original code.

Thanks! LGTM and tests are fine!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>thanks,
>
>greg k-h
>
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9880756d9eff..f4062c6a1944 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> 	if (write)
> 		return -EPERM;
>
>-	net = current->nsproxy->net_ns;
>+	net = container_of(table->data, struct net, vsock.mode);
>
> 	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
> 				       vsock_net_mode(net), NULL);
>@@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 	struct net *net;
> 	int ret;
>
>-	net = current->nsproxy->net_ns;
>+	net = container_of(table->data, struct net, vsock.child_ns_mode);
>
> 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
> 				      vsock_net_child_mode(net), &new_mode);
>-- 
>2.53.0
>


