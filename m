Return-Path: <netdev+bounces-269921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAyFGrJTvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:03:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52D2DB857
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666663019B8E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BB3B8D4C;
	Fri, 20 Mar 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jyyHasAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f102.google.com (mail-lf1-f102.google.com [209.85.167.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C83B895B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015184; cv=none; b=H6eTuMQ22cqkW0DYFZNqLRAH4thi9tvwT+RzSWRi6LeOkntQEJCroJ4TS4zC63vc83Fdl4w3ckXNxiZZdiV46kRhlFlbY8iZIm8SpRzgJWsQ7/GZvL2GQ7m+WmQyZfvz01LhEewmBqWz2tP4uervTyv9wkz/OwYQ5aR6bhetG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015184; c=relaxed/simple;
	bh=HJ8qsX+MMbTfZi9vknDYQd88/18JXr68jIDE3434AcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXF72hWbamYzVFs47KpJa+WZ6kipP3BFIUQ3Hhca2w8IfWza5jrAjR3ZB0lQ7D9a5o7OyJBc0WUxC5+pCsNDynnEwyDiI32w5S6wpSkc2qYGOmgtu1WGs+RowkFrIuXaiMfPoD/3mROaZYxpsLqe1JasrcrCVSJOf3rnO2CrFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jyyHasAw; arc=none smtp.client-ip=209.85.167.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f102.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso714672e87.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015177; x=1774619977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqMFmPvWcl/YrfhzmFhFp5Jj4PZXtBv9JeSOVLZxFQs=;
        b=jyyHasAwEav8qi2j2Vp3/Z/K8w/Q5DIVDxMgV46SZBiaYGoHlI1YVSN+J6uSVNeswD
         1G+A+s/utVSjvuKWgRzVNXK76lhXu+3XSX5Qon5BC1xob+cbpM9mhWOrTvdJdEgUX00r
         6Zh5dG45MzS7JmWjMPL/iQxGZwFadeTGEqdc+KFT2oVb1CT+FyQkWzLZbL3nJ70GHj9B
         hy/J6NNi22+KkLTOj5EF/gcHGd9BPE41aHT5T+3svwDAh10sIJS1csXaZBpU88L7A/D4
         PVZU/2eMGVWDqK0p+HFXjyCtt975LTOy2a8vZD0U+1i4o5O/K0uCuxnDLM5uQ3yC/vfq
         WpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015177; x=1774619977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqMFmPvWcl/YrfhzmFhFp5Jj4PZXtBv9JeSOVLZxFQs=;
        b=qqvxhrllXSaBVs4JyhBcO9bqWTY1POj1sWSzoA41XzQv52fFCBbA+ibPdquHb6nJF5
         v9m+Prq505kfI0UXDzpkq9ph0QWvaOZm8+ylvN0V6LGHbSb3r0/ZlUfSct/1XVrKQyJz
         SFw4MAgIBL25VP+fbkXbT+fyjcMAoinzChCo7clStu3pVuMEB1fOgB9OHFA6ZKiaK+Dh
         5e++gCCI2qmyl19bPghJ9auAsW6Agzh0tVbCkySDplxfF59tF36wuvn1clFrCw48Wiv0
         k+SrrkHsOpL2pg/4mKSfYWWXe70ekebY6tvC3UiyAKWL0utqskc+5BWYAlLoH8+99ypB
         mISQ==
X-Gm-Message-State: AOJu0YyIkTSDP1MgrCDoMl0sqWA/PxSkf/FB9z0ftxXJvvTO7Jrs8TB1
	gVKWtLgJrrPUcr6j+BSddu0FVB9iLGA2vjv65oTPSKoR328O5Np8lWDQWiRa9u3MHFrlu0Vy4d2
	J2SwJpw++cgNjNMBiFYNjXandsHoSTCNrYM6L
X-Gm-Gg: ATEYQzzPQeLvzF8BA7qx4QrFoyGg+X6+Zw9JoxZ25HzkksqONLdOQXJHO53I8S+a+9T
	cj29aMfmbWK4SMLR84kHG0fjvJ4THI8RMtCpMVh4sxIUFvqUafplKL6mo5ShHt5EPqi17eIDchh
	q+umM4oAsxeZyTnqUJYDsvjBRw8QzIqYpNGKbqBLFUvbZHYysUtBO6Jbk6fiP3XjMEwORezbpOx
	gZT4Gmu7vGXOq2C+RjsmKMObNDWjJp/gK8OJOIL7NjH/W/h9zQYVgy4z/BwwtvatX+M2QrVeOO0
	F0qJ2aFRIXGdmUSEht85Hy/mXkBvr52EKfslA0fEXu082JgG+YWu/x4AtF3RH/zYLXeBVinBMIW
	ShgWHBlmGton4PLNAJ4GOw3m1la7PPMQ/QRcYM4qvoJLoV7+QyTVI3kOT5Ma+0EsIvKYgk4blvA
	==
X-Received: by 2002:a05:6512:3e28:b0:5a2:8239:431 with SMTP id 2adb3069b0e04-5a28589cb49mr1184943e87.0.1774015176641;
        Fri, 20 Mar 2026 06:59:36 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a2851ad742sm221821e87.23.2026.03.20.06.59.36;
        Fri, 20 Mar 2026 06:59:36 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 5D3921C271;
	Fri, 20 Mar 2026 14:59:36 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH net-next v4 0/2] Add support for per-route seg6 tunsrc
Date: Fri, 20 Mar 2026 14:59:07 +0100
Message-Id: <20260320135909.1729313-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-269921-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.937];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: AB52D2DB857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the new per-route seg6 "tunsrc" parameter.
Selftests are extended to make sure it works as expected.

Example with the iproute2-next companion patch:

ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0

Justin Iurman (2):
  seg6: add per-route tunnel source address
  selftests: add check for seg6 tunsrc

 include/uapi/linux/seg6_iptunnel.h            |   1 +
 net/ipv6/seg6_iptunnel.c                      | 114 +++++++++++++-----
 .../net/srv6_hencap_red_l3vpn_test.sh         |  95 +++++++++++++--
 3 files changed, 166 insertions(+), 44 deletions(-)

---
v4: silently fall back on encap config without tunsrc if there is no support

v3:
https://lore.kernel.org/netdev/20260316162955.1253225-1-justin.iurman@6wind.com/

v2:
https://lore.kernel.org/netdev/20260311152845.278354-1-justin.iurman@6wind.com/

v1:
https://lore.kernel.org/netdev/20260310141057.3353333-1-justin.iurman@6wind.com/

--
2.39.2


