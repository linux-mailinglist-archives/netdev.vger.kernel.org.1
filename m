Return-Path: <netdev+bounces-302184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FzJzKSyEPmqcHQkAu9opvQ
	(envelope-from <netdev+bounces-302184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:52:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 039026CDBAE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:52:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MzfXNWwm;
	dkim=pass header.d=redhat.com header.s=google header.b=rjAFw1E6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302184-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E721F30948F1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890293F7A84;
	Fri, 26 Jun 2026 13:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52053F8224
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:48:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481715; cv=none; b=ucRxj4pam+wN4FJO24F7RdUPK2dQ6XQlnd0VQVuBfKqx7gyORXWwUHUAGceHD+5p2DP6UXCWDwaYVQ3/Dfmvj1c9rZmm+oP6FQoYATG98E9DrdD/t3Cu0Td3l64XioGXuH9R+WDT6IJVPMMH7U1DRPfmNIaLU+gwKu2M8Ju+LIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481715; c=relaxed/simple;
	bh=Z0WPHV8/Mv0LIJVrKuAdJ28C6sgGsMyxIyrReBvVNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NLqWLeifPLjs8oEBJStHZfJOz+jz2ZHrFWBMfFmoDQl2mrZvtsip/Tty/XuYpAV+cnvCerhBGJYStRBJmdKvILeL1axh82uu6MJpruQjrs43kwNpeNI0fYQ+PRHQfzcR5BzuW6uUw19i7kfnFK4x0rBiViqshNS7t8gDf64dsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzfXNWwm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjAFw1E6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
	b=MzfXNWwmgSCgmwiSXBNedfxzyb2KWW/bYLJfzpFg8BIYD2jVgLOdbUC99nuTg9wt3y8Sbm
	yk//ftvl+R4kfuvpZ590lFxtijqOJS3NwffxoE2tItZwMyoaD3m+rQwdkGKXGRvCVANUTG
	rTR3N/kAkZr0hI9K6XNvq1kX71wlrww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-_4xarlOsP4C_o_sa0lEhug-1; Fri, 26 Jun 2026 09:48:28 -0400
X-MC-Unique: _4xarlOsP4C_o_sa0lEhug-1
X-Mimecast-MFC-AGG-ID: _4xarlOsP4C_o_sa0lEhug_1782481706
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46cffa7200bso638659f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782481706; x=1783086506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
        b=rjAFw1E658uQsQk1AcBH0QsphNx6dHH2WyoaVxn8D9JHB3RVm2qCS3jGLVLq6UmhF9
         Fgf2Hb7EAvmCE0axwO9+HkDZWUNvN+vYL46RYctwRflS5XdozIht+PuSQ69ckb3dq2WH
         Dw/SpR8D8lOUM8RSWNWHgFEdx+F6olMBtzFcmrLvWEQBj3T5ZI2yY8PYzpeeTvCWVRfQ
         CnWCtKSzeXMoZOXtFn5tXgfHz5aMBoH+AFya7d9FGYHiUphX/c6z5o4c+J973X2Nh5Dj
         +MgZluAcIJ7E6LOOxbl3LNL5CWVO/jAkX/S+7fIFF+SM5EYnIq7v1aAQ2UpSlVwgGa6A
         BbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481706; x=1783086506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
        b=mXTMhuJTeFl3AEXORAxFPURmy+OLveZcB03qmn6QzvcjUUT6cd8Z37Yq0B7x1Swkcr
         QY3tXP72Bd0VjpxSzsuTlrb2EMGSX6rUr4f7qpHHgOjSkPGxOW7N2PXcUFIPMtxlPmbt
         Dxwyz+0q9S+jRq6rJ/Vft5Yr54xf3XCCH0P4//15iYiEoVtkAAffA10M1dzZlOeDJbxa
         TCLvyOXT+itGA1dY26Ex9s9o0pQXX057sELNXccfbUiCmlBqC40Dp39w60oba/EEOx/X
         VXLccqD/QF3t1BNRvAyXEOEhIIPxh4M1k8z/TgzbXvgw9fRr5BFjKrYBIKohZqDkeT88
         xjAQ==
X-Gm-Message-State: AOJu0YxUxMl3QkHhCp3iANOfe0B0LigQ2k6HykRHErYpBSw2cYN5Biv0
	GYO/CbR4cGYM/OaCFmg8W166wdky/Y574GrrGmPV6mAe7bFDJ45XXmyaeohWl3BNfnXTBTFt+lz
	1dMpE0KRIiRR33zVtF0i9ibV4oPMrp3skIemG9iJb6/a7bLKhd8aRRUfuJ+fIQDnAmCUkbmRF2S
	o1+PFD+6KaTxZIUsvnwXKg5DV8SqAT0dwnXmJMiNI17w==
X-Gm-Gg: AfdE7cm1UXUyMGAwOKzLxBPApZlXfXgE9wLbDslShSCyvaYLjhH7HwZYNX/3HXPhY8i
	hjzNiiZOKmzlVZmfpH5OEl05I5lyRqfZXrw9GhTvOW2md5VoxAPfVryUeBH/tqS6a1ty3A/kNJp
	7UBHeq28b08JsIAWZ8P/FuNDpEKebK8fPlta1kJ/Q9iNf8WEgkg1D2kQp75kXIfYRax+Ac1WhGo
	dTAq+Ty0I2eeTyQra/9b9KygorqEhI7qRQT90gsPfTgUUFQTAXtP6cUb/LJXb16MdRq9+D0Jx50
	VhaU3Nn+xJnZhzCWyowzSkoCO/nAQs4OHNJOArTIDF/GjEkje7guI0zSf91XEldPdKrkLqW7pAg
	EWYRlQ6ZVAdYn8fUDwsfhlYoCDFg6+L9l4zOyB4TmRMWR/k4=
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779385f8f.12.1782481706472;
        Fri, 26 Jun 2026 06:48:26 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779337f8f.12.1782481705917;
        Fri, 26 Jun 2026 06:48:25 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm22722884f8f.8.2026.06.26.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Fri, 26 Jun 2026 15:48:21 +0200
Message-ID: <20260626134823.206676-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302184-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:sgarzare@redhat.com,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 039026CDBAE

This series contains a patch (the first one) that is part of work I'm
doing to improve the tracking of memory used by AF_VSOCK sockets.
The second patch is a test for our suite that highlights the issue.

Since Brien reported an issue with his environment (based on Linux 6.12.y)
related to the work I’m doing, I extracted this patch and tried to make it
as easy as possible to backport. Brien tested it by backporting it to
6.12.y, which now contains the backport of the 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

This patch primarily fixes STREAM sockets, but also partially fixes
SEQPACKET (with the exception of EOMs, which are kept in separate skbs to
avoid overcomplicating the code).

The rest of the work, I feel, is more net-next material and still needs
some work to be completed.

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 ++++++++++++++
 2 files changed, 233 insertions(+), 2 deletions(-)

-- 
2.54.0


