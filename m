Return-Path: <netdev+bounces-294454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MwlMI9ViH2rPlQAAu9opvQ
	(envelope-from <netdev+bounces-294454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B2632C22
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g0Qeljjj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171AC30670BA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA03CC327;
	Tue,  2 Jun 2026 23:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D13CA487
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:07:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441669; cv=none; b=FHg7hC8vpOxIagIzYAdVpDObVPbOXIM+GuGTnM4KuoljT3eVjJbETk1VqpSno5Xq0ELeZFhwzkXiS1+V2ja+M5izD4HQiXm8AGWWxjkAB0gifbRXmYHspu0KsOiqB2M8B6BA86NzVopRO3LzeGX9+y7Ht+49Daa1JkVM+ej5J7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441669; c=relaxed/simple;
	bh=5chq1ZYL6r9BXlem4E1EUr+5R5J1k5Q21LCWXDRISUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCC1hOjqG+o756LTgjvfhjidXKpoK3F+uHJ0RqRPS/0nNySufaMSxksNj0pBiqwX2hqCn4uTQTQA68xKMP/sMc8hdpMO2ehrkd+PjtJJKhu7ltSe8KwnbL3ldE3Rdk+0rz7MUj5cq04qGsjsPTPM0bwrNtZ/2etcN/uvlTcAmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Qeljjj; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b12270b3so9716275e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780441667; x=1781046467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvSaS68IPr55Kp5FHpvrg0n0LohiEL0S8pivrepEpA4=;
        b=g0QeljjjZVRfch0Tv562TmOzSOJBhL8ujFnNlpdXl0x1fHoxAC80hk5vUbqtI6keb5
         dN6GvIY+/6KPLAPt+nptAK3fOIQGMUpyiPeAvndNg/+gozsMl1uKdb38DDTdyjz2CKsf
         P1W6WDQZF1/0B1qBjQ30EqXE7aq0QK9VRgE1FpZeLD09Et0PvqXZGbFjWX/f7K8PBxMZ
         EIMxvsA1XP0bqYi8v7JJpcE8boyJ7SburJV5nC8F1mvObatl+7o9H2Vgt4QQvh86SU5+
         7JLkm69aetHtPhoqjFK62BEHOIb1aItevXjVcnkfBNLI1pVeaxZ2ImvNnqLeOl+s6fnr
         KYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780441667; x=1781046467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvSaS68IPr55Kp5FHpvrg0n0LohiEL0S8pivrepEpA4=;
        b=q+IyU89MokUllRrvLlevhI7SZjAAIQX9NImShKq9SVDcgFgUsl5Ot4Nvt+sunPhz8j
         cO6km/bwkYz0d3h/4JOC9OghKKj3MbRRSH9XkOPIKZAaEmE3wpZNuXGoOIGhyz1fkpWt
         ouxxA1u91/NruVithWLsEjrbN4DtRSWFBCsNvfB39pp0EVtJUymK4Yifn1157tIHsnAO
         wIECTcw8Hrc7IomIh3QqAgKO0OohdZZipow+dv7Tzvli8yBXiI8h+qbxBSqz0OsRvXH5
         8ZQiycbMla1MClQkNuYNu6qUholfoJdprGSNQ52mmAqmDhupmOPVLKLwd/in/8wZRA43
         2ABw==
X-Forwarded-Encrypted: i=1; AFNElJ9hJfb+epOU4OVM3tQsCZiAkWeUZOBOnkf5VwJqueX0k27PmHewnmawb5Bi4Q1NuHrZKF2Dgpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1a1ukYxuenztT9N35Nuq6Hkp7bzA2LXbf2tONNpCVa60cWXLz
	/vPMf6siGcMUvBO/hWlwHsPgzlKS7uxzxk3Hp9eXZ2WxhckJabBo3m1c
X-Gm-Gg: Acq92OH6x2KoiZViojGqo/dkdGZHSaBA6rTBAQ7nBMQMJNnh4deZYJOaEmcXpsh0jfb
	3kGlnDqzahpk0Kz3/CyYZ+mjozAK6RQ93MwWluMwaKhggPPdoB9M4VUos2Escn3fYCChoryNHp4
	4xbSk9/4oV4qw9tyEkN2AmJQDcMVUm4MKBydPlcy3CsVYSkcnA0ZOahIdL4c7I498UOSD8LfH21
	k8HtJ2Iazd4k1DO7jQ4eUqIubEcxYypmDAtThL2/OysUxOHyC7qkipzqSmVyLWa7BQ8SGyPcCz7
	MNiZO8x/n1IkHryKcKCrANMQRrmsyNcUC5C/DmkHx0S6xpKKculv+opldUtZFnxy2pu6/U4owrK
	Gmndq8iAVnPwlnkf/aNSePK+l9PxcOfKLwdD0rubVKDxRnYhTFje/mtXmx+faa3So2m5m+Vkazz
	+rpKZoYjq/6lAWl3wIXiwfN6BG1gGbaJLku/tjqMLe
X-Received: by 2002:a05:600c:698c:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490b60fdd10mr11320095e9.30.1780441666946;
        Tue, 02 Jun 2026 16:07:46 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7a71bb7sm357295e9.10.2026.06.02.16.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 16:07:46 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 02:07:30 +0300
Message-ID: <20260602230730.138904-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ah9Yle5pd6mD9Ugr@pedro-suse.lan>
References: <ah9Yle5pd6mD9Ugr@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294454-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D80B2632C22

Pedro Falcato <pfalcato@suse.de>:
> (Askar, if I was too hostile, I do sincerely apologize.)

You did nothing wrong.

-- 
Askar Safin

