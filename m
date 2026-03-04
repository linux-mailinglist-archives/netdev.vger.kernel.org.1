Return-Path: <netdev+bounces-263618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG0wIu7bp2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:14:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AA1FB71A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAD683033202
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6C37F009;
	Wed,  4 Mar 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYLfQnGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9736DA10
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608485; cv=none; b=Uh3tSfwH6PO+qNaINEh3iJaYUTHRxMlpJ8Nc5rFe2byHDez6n12ELmxwHyFr+stey/ds0vsUM/j1U8TV46MMSPhbruJxYqlLBGOmX7yzHbbGtVF/EhUMgxzSENgmmc0j6zHMWP1CQ4qoJtiGd0ifTazXotAStr++W3i+fjtjdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608485; c=relaxed/simple;
	bh=zm6uH7lbs1Su/MXNKnukNeVRRnONQ9ev+i8I063DYBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fJ67fGneBJYngLdTUrnv8aawunnpSzAZtFmmr9pTUcFHUa3YPkpzzXyoYmku6/9aBe68lYKhqMVz/GKdkm1BkbCZmH3SQb5LieuPryEJaodMAZDOuD7+QMdQuluRFClAB2VGwMyr7yTGxfwZdiu8NVeQ0/JzNjHyUCpUk5297z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYLfQnGP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35984cd0335so1449148a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608483; x=1773213283; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0bYZftl8hUVUvxnZfoseYnSreklWWhonGyiL0jaY4Y=;
        b=PYLfQnGPs9txZJ2QRoM5sCpuzJtB6M7Ut/8IbF8YQ0zMAvcRje3+nPGKHJl48ZzQMq
         aGFfAT3rwgDRPgSMzU0nG7n/ZlqOH5IxXA4qJAWr7NgSohLXJzVx/Luqnr3T8XAU7CKB
         VIFHOl/8wxI1h9okD4V7H0LhxLaDyee34Fky/1XZOGX7UjeYvyVJVRxSDFo7kZTFav5P
         TVe7y4RGK6TcrwwSBrJJpVfPaWjjqtnf5nYBhVRuXBcJxAkHU0BnVEz+rXM85eAWNAQP
         AEWVig4fjYSzL74MWFp89eeDDp9WcZX5vprl4/MAo81W0hZIKkNsgx8oghGJMKCQ0vwD
         aoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608483; x=1773213283;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0bYZftl8hUVUvxnZfoseYnSreklWWhonGyiL0jaY4Y=;
        b=tRgb77K+PO8G4myUJTGXzUyc7t2IeDtywUI7+zbChz9Si1gZocSlavflE0lnhsKv13
         1cFY8tWZHVwu192xREFpaGKMAuxgnwc6HLdcflPakZ0MvMlNfrYPOKOaRkWnrllPv9Ig
         f4cgpThfNCKQsfRFIygjeWdxpXsaT4ol+dDOdU0psau5FK13D4irWhq17RkQCRiuxyTf
         K55/ehbYu40+DMU5HorMyayWUAR2SjWC4gJI/Hw2jKIp/qYY1FUXpUXWAUkKOfO9R+TW
         tstg9o2xIsG9NOA2deBuQ+JsyswP1UjOjRhIw2xHUZA/rByC2UlQNZqsiQbYQZaLvnFl
         PYIQ==
X-Gm-Message-State: AOJu0YyNe+Q6kVFQR2Htd036EX0LDrSxURDtN+2y0xBedctt+2j741Yj
	lSr2HprzHque/DJSTs44lIk3NltOoyEVWxDY84r+NQ8V8Tz1EHBMPWZk
X-Gm-Gg: ATEYQzwtKS+5R38WHXC6LdzxAQ74aZKNZtmQh1LWC/Z82UtpsN0ypChyuvQWR1Sm0ld
	NWae/bdPd8NnC3i4JPUOJRKW8QLs56+PdH4jvLUyCC8nH+H6YHuCfFE2z3tPCEK8+wLOK4adLID
	2ywHFGdKoaDyGg/U0eEycpKaMdPpasfOCbnpmxYaXn0/+yWpo38qNpmd3HKKPvmigl/LECNcr34
	R89KpQS8FC4pCno+uQ3RLSFwZsadJQMzw7BS2fmeGLNuEEIFIKwgv75SZJHt+TW+Sx0Udiwcy/O
	6IZpfXHjyNawwVeEN4rvNVhUTmUirwroj61IpsFvOR38CGHZoT/AGmyknEQmSk6dE7ruK81ogsw
	QjjLgV92dSfI6i/xJd++OnT/MA7z1KUw9BookrqxQuPLQUCyyPN8Czb6fSoY14jcGQmiD4AAz4W
	RXA+aV0DvUKBtjkc1HMwRELvOo0pvw/HBx9J5uQvZ6wZjEpvPNkzfdK+a+ObCOCkjmLb9l2lnSp
	UH3vDI5mzBhdqM9/S2q8xEOi8p0pOWjVNWB1OwM6u5NchWWn52y
X-Received: by 2002:a17:90b:2f87:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-3599ceb537dmr4168164a91.9.1772608482718;
        Tue, 03 Mar 2026 23:14:42 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:576b:6b60:293b:552b:9870:28a3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa3ebb2csm85731a91.12.2026.03.03.23.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:14:41 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] bond: fix 2 link state issues
Date: Wed, 04 Mar 2026 15:13:52 +0800
Message-Id: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAMBhGX0X/tdWM1vIqkrAPf2m0IVre3VLn5
 lycEynAMwLVWSSPiwNvLkmRZzQuvZsh2CYnJZWWpazEkNic7c7dYu0fobSGGVHIyoBStXtMfP/
 HhhwOat/3A46qHIJmAAAA
X-Change-ID: 20260304-b4-bond_updelay-266e8ce1048e
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jay Vosburgh <jay.vosburgh@canonical.com>, Liang Li <liali@redhat.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: EB9AA1FB71A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263618-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bamaicloud.com,gmail.com,blackwall.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch set fixes two bonding link state issues:

1. Broadcast mode incorrectly sets usable_slaves, causing updelay to be ignored
2. BOND_LINK_FAIL and BOND_LINK_BACK are treated as invalid states, generating
   confusing error messages

Here is the reproducer:

```
ip netns add ns
ip -n ns link add bond0 type bond mode 3 miimon 100 updelay 200 downdelay 200
ip -n ns link add type veth
ip -n ns link add type veth
ip -n ns link set veth1 up
ip -n ns link set veth3 up
ip -n ns link set veth0 master bond0
ip -n ns link set veth2 master bond0
ip -n ns link set bond0 up
sleep 1
ip -n ns link set veth3 down
sleep 1
ip -n ns link set veth3 up
sleep 1
dmesg | tail
```

---
Hangbin Liu (2):
      bonding: do not set usable_slaves for broadcast mode
      bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states

 drivers/net/bonding/bond_main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)
---
base-commit: 46d0d6f50dab706637f4c18a470aac20a21900d3
change-id: 20260304-b4-bond_updelay-266e8ce1048e

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


