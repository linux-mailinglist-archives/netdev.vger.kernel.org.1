Return-Path: <netdev+bounces-297904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sMhyHAMkKmrMjAMAu9opvQ
	(envelope-from <netdev+bounces-297904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3E66DE64
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:57:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lhO/52YB";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297904-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49E0930205D8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB230DD00;
	Thu, 11 Jun 2026 02:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859821C8603
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146622; cv=none; b=MBeyumtntM77JHXofuBVIY8hcPKfnnJ5DxzNWJtG6fDggpX/cVI0xczlyqY3s3+j60jRLaCuZ1UJ+3xxZ8TPKvYJIKBKZZhITnOcMXwDUcYJfiyefty7OLFqM2fmpWK+w2qQmXYu8qahHK4Zlj+5If8K3oQI9NnQ1tf+lAFE6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146622; c=relaxed/simple;
	bh=e/GUBI5y6udIvJIPdFh3I2NoVZarjuSWsF0Ua4MQmBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8OshuarX340WcrRDjn5apWizyneLIPFdxbbW8rGgxYCFqGM+Nxx7OcbRHsL4rn3y+PEA9Wk9Lxe99ml7WtQPzwUyLMqktNERzlQM5lOX/eZfACfWgF0NDaMrg0KNEqjlaGIENGlo7zK8h9BXMuTXPCNGsoI6e7c1sLNHYKbbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhO/52YB; arc=none smtp.client-ip=209.85.210.194
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842307473b5so5184836b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146621; x=1781751421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGTwoCtKa3qFsxEvMshBp4ypPZjRIYp49KFhfGyY/yQ=;
        b=lhO/52YBRlQkXsLkbZ3welXPJbrlRE9AYHSaOnNSshROS/5zSJE3b53YPrvjPt0CVg
         a3SO6R8b6YAuqiMuGNHLGPyLC7/D0YzAMWJxDUpCgDHjV/j3CZcXuIAiU+T7bVuoRSxI
         TqjMa+0KbLpnXaJxxn9BNOTUgKbcRcnjlNqA3UAnkcNC3WFjFVxZALEsv26GPO64XYTH
         KANGxz7mRfTaysL8hyG9CMsHJwfOLDVqay1gqPxGP9RVAwhWL1yCaP4AzKj0vhlQjmWZ
         GT9cUS+GeA7fdj0P4WpV4s4bwgnNHMGiROTACCVsEKHmzlrDugcGuN8ILv8bv3fjk61T
         AMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146621; x=1781751421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGTwoCtKa3qFsxEvMshBp4ypPZjRIYp49KFhfGyY/yQ=;
        b=YUzzfjJFyug0aK0IYdqk27SRDv0NTQAnXK/EwNnt8DAs+K8Ae09tHVsIEb6+DPEcuk
         mhY/QGOXLFblALKrhCAToQ6d8VgA2DLF+6/vUMvrMxoHIq0UGLlbhYI5ZGL34NTTfOI7
         zA39ypKUscmCvxjZUJt2/qPEuDPs2MdYYAqIf8UlWXBLrgoXZWhQEjpjVnYpsn4QIMlM
         LX3Vcs5JidojK6kb24f3BTHrxqXR/92KW0qssaDjidVtOY/aeRdTWHZP9clibfS91E2l
         rjrVeE+Hqcy6FSz/Z52S+Fpd51ddmLeaaUZ95f/mwT06gCSyIKWidmVvbZT4VgwBtEpu
         ADVg==
X-Forwarded-Encrypted: i=1; AFNElJ8gRXuXINH6RR9qcLv8FBlZgguRef8DZSIHeMGf8UTPKl66/pDDNy/WpW9OM80iZjJRTyXteRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZQdnMu9sThZmOzcFQIlUg+qztqdhXR5f45irbARWjJ/aayBM
	YNrrNeYGtRowVHdgvAtlPVQThNu8759vdQp9+EjP1BGGI/weVIyTFan8
X-Gm-Gg: Acq92OFoWCE3ggFvl2KrSQzMk/In7EzQApAp5IziPSL2OJJHVb6QANQ5jJ1S5wbdOU9
	wA1e0xZFGw2CbQcyIKjaLqxo0k+OcOcYlp9lO2/Mm7skyD+FpA82AW7CwnDF0AKEJk26xhGA/Al
	bncwllJEJYVPA40ROUM/h/9meo1B87ETWMYriCzvj07FNk+luoeC97WYZFFYDye1lr2BH6Qc0/2
	vJkFuwmQEMHp/Apis8sfUk6sSoCVNb2R/ogsMQygQWUE0HfZrtv9mXnw7w+QxMDrisFjpe2Wsot
	jvtu2oLyevR07WGYluvFUt9zhCNYFUpO1yCxb+P+e/pCxhlsnsKocqx03HKrzLFOxQjrM1vDUbK
	WD1UR64iCipTfUxC8Ov1ldVQrkhe/jQ6FUbGPs6g0MxhGwgQwGStKw7osb9vpABpbnGwkMzwZ0y
	WihjtDedSFUSD9IwilkV6gt/BB/2KHm+GwuVXqOjnay2LgbZGwVNo=
X-Received: by 2002:a05:6a00:3996:b0:83b:905:c9fd with SMTP id d2e1a72fcca58-84336a8c539mr870473b3a.24.1781146620897;
        Wed, 10 Jun 2026 19:57:00 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:00 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	minhquangbui99@gmail.com,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] virtio_net: xsk: rx and tx wake up
Date: Thu, 11 Jun 2026 10:56:42 +0800
Message-ID: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297904-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:minhquangbui99@gmail.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8E3E66DE64

From: Menglong Dong <dongml2@chinatelecom.cn>

In the first patch, we fix a race condition for the xsk rx wake up in
virtio-net.

In the second patch, we support xsk tx wake up for virtio-net.

Changes since v1:
- split the rx and tx into two patch
- add the Fixes tag


Menglong Dong (2):
  virtio_net: xsk: fix race in rx wake up
  virtio-net: xsk: support tx wake up

 drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

-- 
2.54.0


