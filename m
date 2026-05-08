Return-Path: <netdev+bounces-300121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /DaaLYV3Mmqq0QUAu9opvQ
	(envelope-from <netdev+bounces-300121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:31:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC9698830
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EjSemAsu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300121-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300121-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C260830058DF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C773F4DC8;
	Wed, 17 Jun 2026 10:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C173D0918
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692290; cv=none; b=mFFP8aJLkKvnIUJflmHOjSQt/bisWlwxDgeHNMNXLnTVJZTHf6TNptVAFIqw6U3xXEsBhFxRDsRAaDv7JC5xNqs75NGCkP6XYIOyzzByI5AOE3KXKCoFPYshgJcR4poup5bJZlIT3expUmjZRa10TsgHTuWn4+6F3BLIcts3IwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692290; c=relaxed/simple;
	bh=Bsu2l9ONC7HbFFdEO+yhGrPMQm+vAhw414YH/f8veHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN9gxMiACQLmpVJ7AITbULHNSr8fExjbg7hlpzG2yn1qZMNaQw1mW5ITvivsIIrDnPiKmRa2DAf3ZiKaDT67JUgXmBGGvBLhEXs8pZGZ/jPONva+ZOcY7x/ZWgZ3rUQf4Fdcl2wdnwdqJBtRAzrUtZTxzbpwKtOWVeTb2SllSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjSemAsu; dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTL9CllX; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781692287;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=6MsmKmWCOsOVqQsn2afmiCg9PJfQEXeffS2heTK7guE=;
	b=EjSemAsuxeup90vhCTvViK+ujUtL59O+dFX2Anmtb/TvDRgzlnGfrhOUoZRFOIA0eM3DTU
	HxkOqZMAKB9lz7APCog/JyLbXVjOzx5IBO8HtE3FtbUR2M9wC2JGbWi/ndxlENEmqumJfE
	RF8QkXR/mU9M0+J/qo7dPIcaTNQeAfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-B9aYQNS7Nkq88ux_Emb7gA-1; Wed, 17 Jun 2026 06:31:26 -0400
X-MC-Unique: B9aYQNS7Nkq88ux_Emb7gA-1
X-Mimecast-MFC-AGG-ID: B9aYQNS7Nkq88ux_Emb7gA_1781692285
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa2f7009so3878624f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692285; x=1782297085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:resent-to:resent-message-id:resent-date:resent-from
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MsmKmWCOsOVqQsn2afmiCg9PJfQEXeffS2heTK7guE=;
        b=avDnY/dcOWUHpvGbdjACcq8b/RpEF6EKhqlv883YIyTDDPshWLqMcMJLQDKAgpyfiO
         9lLxIuiiWE6FzFuP5TgmsG8VNDCX/oygGKClCEPAd5XfVbfFeNI2sEjlv5PPv9U4oApz
         iwo+Ky6u9B3QIXOMUAJq0whfTSf4GsbVolGtV2t8HvBCx0EvSD7Zk9ggn4HbEWg3mCVQ
         VhyNPWlonmsh7USIsr8IvP9vsfyTW/MPbNQSVP1RwovXQ6Iaem+WDXg14lcNbeXW8j/D
         0UmMPTM1l24CFFCu0Dz+6dR6tybFM0tSFhI6cX5/sDHrpZd1JZbvs+RyD4rr0Q6ALSqS
         Fh7g==
X-Forwarded-Encrypted: i=1; AFNElJ8k15hK/f4yB/TxITHlN51PcP49qFXLrER8uS9AhrqdHzhW9q2w6W4qfuSuJStFRSGQOL0U3jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWjrrLWnDhv5wRA5RMGGpMHOUXkoGZMjAwKCmhu5AwYd/lHTI
	ptX/DYQiypGsiU62wjVItgGOkfJ0n+/Rujibz2ZKgXgUpuAHwC390NRYyrGGUzczgOyX9Wr4kkl
	J3XpR1vLGiixXzc164t2qFXi4HsvHH8PKlXMYwNbsDoLQjvgMTnuovztfVg==
X-Gm-Gg: Acq92OHcKz2+iqk9l7q/CcuLdDOgqpXJ2J63cPe2WWz0I/p2/blqRBs6QASzoNTJ/9g
	Y+vxr/1sl21tH3MWEJGedeDjCcquvO12QtYPlE5EgVMPEpQFS6Zw+yLUHLXuR7xrH8Tico0yPCd
	tkI+o+mbMLzcu06sYj4jnG/WQw3hBk0q1/4A+ddpt72HOMjgxvOKsnI5UhR7QB9bLqUG4G979vz
	1BreBRs4LKosOL1q1xJjKEjBSzTuNkPf0FQhkDK0L4xnAJ8yABpzrsZtBcHlL9wBsto3qfgvapy
	fOqRsa7ehTpUoI3/i4jtL1Xz+8rhPurP9Y+wyyu69jTZy+vi/DvNunmts7b4iu4YWKR1FbdfAPT
	xPcl7TV115M+FAi2PTndZE+4EITgv+G5g
X-Received: by 2002:a05:600c:a144:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-492333a02d6mr47278915e9.5.1781692285039;
        Wed, 17 Jun 2026 03:31:25 -0700 (PDT)
X-Received: by 2002:a05:600c:a144:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-492333a02d6mr47278295e9.5.1781692284528;
        Wed, 17 Jun 2026 03:31:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233bebc57sm35370995e9.2.2026.06.17.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:31:24 -0700 (PDT)
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: Qihang Tang <mst@redhat.com>
X-Google-Original-From: Qihang Tang <q.h.hack.winter@gmail.com>
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Wed, 17 Jun 2026 06:31:21 -0400
Resent-Message-ID: <ajJ3eaDYKRpaev_R@redhat.com>
Resent-To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Delivered-To: mtsirkin@gapps.redhat.com
Received: from imap.gmail.com [64.233.184.108]
	by tuck.redhat.com with IMAP (fetchmail-6.5.7 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Fri, 08 May 2026 03:58:44 -0400 (EDT)
Received: by 2002:a05:7108:3655:b0:569:1bde:8a97 with SMTP id e21csp58076gdd;
 Fri, 8 May 2026 00:58:35 -0700 (PDT)
X-Forwarded-Encrypted: i=3;
 AFNElJ99Ta1HxJbqNaF4Za2nDR7z/qPqWgYxroe5UjwNGil+caOGXbm73bfiH+nlNp6MrRhA0Y2BOzZINQ==@gapps.redhat.com
X-Received: by 2002:a05:6214:800c:b0:8b3:f59b:6c8 with SMTP id
 6a1803df08f44-8bc449ab1a3mr156788436d6.31.1778227115222; Fri, 08 May 2026
 00:58:35 -0700 (PDT)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com. [170.10.132.61]) by mx.google.com with
 ESMTPS id 6a1803df08f44-8b53db1a99csi260270446d6.613.2026.05.08.00.58.35 for
 <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Fri, 08 May 2026 00:58:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of q.h.hack.winter@gmail.com designates
 209.85.216.52 as permitted sender) client-ip=209.85.216.52;
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-bJBWsglNMV6TBvNenkWF3g-1; Fri,
 08 May 2026 03:58:33 -0400
X-MC-Unique: bJBWsglNMV6TBvNenkWF3g-1
X-Mimecast-MFC-AGG-ID: bJBWsglNMV6TBvNenkWF3g_1778227113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 E8EE21800451 for <mtsirkin@gapps.redhat.com>; Fri,  8 May 2026 07:58:32 +0000
 (UTC)
Received: by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id E3DD81944B20; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Delivered-To: mst@redhat.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.90]) by
 mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E01BB195394A for <mst@redhat.com>; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com [170.10.132.61]) (using TLSv1.3 with
 cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits)) (No client certificate requested) by
 mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 6BE99180034C for <mst@redhat.com>; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WFwogRdGNsKu-uINNZXqng-1; Fri, 08 May 2026 03:58:30 -0400
X-MC-Unique: WFwogRdGNsKu-uINNZXqng-1
X-Mimecast-MFC-AGG-ID: WFwogRdGNsKu-uINNZXqng_1778227109
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-358dff8447cso196191a91.0 for <mst@redhat.com>; Fri, 08 May 2026
 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20251104;
 t=1778227109; x=1778831909; darn=redhat.com;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to; bh=9eOOtVdqoKSxSunWaxEY4X/hAkaF8j15JgkixhnwJ5c=;
 b=OTL9CllXgmVyRCZZnZHVsr1S9Dn+EoD569opq+eqoVzeMRl8qGuYzflmWFdgcElGro
 moSpAzzZcxN/bKGcQZ60F1S5bpIqodkKOjjiapsjAcV9Efncd8wyJgP/L4fHQ2NXC91J
 OMZEAO1ZxjAjFpMrGvavZ04FNe00/4YFG4vJdu/V5H+V5hH5MG2Ewzuyaz2H683QMlmz
 savAks6kwl2KPCB0WkATWHrp3JMmlGE62OqjNNWqDGyq3YkTw+Lbl6tAhYeCHj2xSiRh
 1WADrOxnh4O3d7RLh1X4XWgUtUrWiAMT18AF5oUTxQ2KVkhYJL4GQ0v0SyhPv7dZpS/0 p7Fg==
X-Received: by 2002:a05:6a21:68b:b0:3a3:2195:b536 with SMTP id
 adf61e73a8af0-3aa5b4e0a11mr6420960637.8.1778227108860; Fri, 08 May 2026
 00:58:28 -0700 (PDT)
Received: from localhost.localdomain
 ([240e:47c:d8d0:4133:1cd2:48d8:fcfa:10ea]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm10998532b3a.45.2026.05.08.00.58.25 (version=TLS1_3
 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256); Fri, 08 May 2026 00:58:28
 -0700 (PDT)
To: mst@redhat.com
Cc: jasowang@redhat.com, w@1wt.eu, eperezma@redhat.com, Qihang Tang <q.h.hack.winter@gmail.com>,   kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v5] vhost/vdpa: validate virtqueue index in mmap and fault paths
Date: Fri,  8 May 2026 15:58:21 +0800
Message-Id: <20260508075821.92656-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260508063745.90506-1-q.h.hack.winter@gmail.com>
References: <20260508063745.90506-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xYBbRmrejl6wZYb-1BK7Pc6jkCvbRJL8CEXZ3d2v8HM_1778227109
X-Mimecast-Impersonation-Protect: Policy=DMARC Check - CHG0118091;Similar
 Internal Domain=false;Similar Monitored External Domain=false;Custom External
 Domain=false;Mimecast External Domain=false;Newly Observed
 Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to
 Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
 Dictionary=false;Custom Threat Dictionary=false
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Label: todo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[962];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,1wt.eu,gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-300121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:w@1wt.eu,m:eperezma@redhat.com,m:q.h.hack.winter@gmail.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52FC9698830

vhost_vdpa_mmap() and vhost_vdpa_fault() use vma->vm_pgoff as a
virtqueue index for get_vq_notification(), but they do not validate
that the index is smaller than v->nvqs.

The ioctl path already performs both a bounds check and
array_index_nospec(), but the mmap/fault path only checks that the
index fits in u16. This allows an out-of-range queue index to reach
driver-specific get_vq_notification() callbacks.

Fix this by extracting a unified vhost_vdpa_get_vq_notification()
helper that validates the queue index against v->nvqs and applies
array_index_nospec() before calling the driver callback. Both the
mmap and fault paths use this helper, and the bounds checking is
consolidated into a single location.

>From source inspection, the most defensible impact is out-of-bounds
access in the callback path, potentially leading to invalid PFN
remaps and crash/DoS.

Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 drivers/vhost/vdpa.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..ac55275fa0d0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1482,16 +1482,32 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 }
 
 #ifdef CONFIG_MMU
-static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
+static int
+vhost_vdpa_get_vq_notification(struct vhost_vdpa *v, unsigned long index,
+			       struct vdpa_notification_area *notify)
 {
-	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (index > 65535 || index >= v->nvqs)
+		return -EINVAL;
+
+	index = array_index_nospec(index, v->nvqs);
+
+	*notify = ops->get_vq_notification(vdpa, index);
+
+	return 0;
+}
+
+static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
+{
+	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
 	struct vdpa_notification_area notify;
 	struct vm_area_struct *vma = vmf->vma;
-	u16 index = vma->vm_pgoff;
+	unsigned long index = vma->vm_pgoff;
 
-	notify = ops->get_vq_notification(vdpa, index);
+	if (vhost_vdpa_get_vq_notification(v, index, &notify))
+		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
@@ -1514,8 +1530,6 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	if (vma->vm_flags & VM_READ)
 		return -EINVAL;
-	if (index > 65535)
-		return -EINVAL;
 	if (!ops->get_vq_notification)
 		return -ENOTSUPP;
 
@@ -1523,7 +1537,8 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 	 * support the doorbell which sits on the page boundary and
 	 * does not share the page with other registers.
 	 */
-	notify = ops->get_vq_notification(vdpa, index);
+	if (vhost_vdpa_get_vq_notification(v, index, &notify))
+		return -EINVAL;
 	if (notify.addr & (PAGE_SIZE - 1))
 		return -EINVAL;
 	if (vma->vm_end - vma->vm_start != notify.size)
-- 
2.39.5 (Apple Git-154)


