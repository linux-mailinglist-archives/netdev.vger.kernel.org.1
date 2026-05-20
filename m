Return-Path: <netdev+bounces-289973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPyCOyfHDWr93AUAu9opvQ
	(envelope-from <netdev+bounces-289973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E258FBCE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B09C731069F2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B03E9C07;
	Wed, 20 May 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHeL0SM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415C3E92B9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286618; cv=none; b=ZlGglXadHDovNZO+r0NETajCuu9Vx9aZ+s4Vxvu8J+9UC/+I1nJV5g6wQGOZe0rUwyUbJnRHlxmQe89MkKNeL2wv7iKm84DV0SiS0L2K94jK2fQgV3cMcysaWEASiIk8CDeVRpgJgO+eAjQ3Ok8VqhfchnjjFmCV4vNaLOTSXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286618; c=relaxed/simple;
	bh=7VFZ8F94wUu3BpT39Q6/44VPVbdrgBiUVDnaIyTiW3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiLQE4y1/HXGLwOOA9pExjQdPoig968YKOozObUegK6bbnWUo584PXLT2um56reO7hyuLaG6BECscqnphvXvki7fyExM383N6eP5ZroxuR8BLzDbEVampS4q550R78KJvCCSuW97Jo0LeSy4xjdDYfxGZvFb88hvBlickqRPD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtHeL0SM; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c477a3278so5154862d50.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286614; x=1779891414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRZUQeBmoTEstKWsMVlBg95hUFZXrJz+CK/C25lcLP4=;
        b=DtHeL0SMpDUYpXw44zCMEZvu1us6W32DyOVRj7rWQDysBuNQvj5o22ojsuiHZCVR2g
         ynI0uFOKi8UP2Y6EB+FDkT4JkJiqUA9YCiiuK2jLkUtJ6sTfeYHuXK+YG/1BYzIVLyCs
         ILCWPUcAxhfLV/0cDyHeJL/huhKC4njaiwvuSVi2PFg5mywnQmq7oSKl3mEVT9sxvX1V
         HhLjDCF7ac4x2gYSkx3FVwJr31DlTiLvEhbBm9p2hMqqSHLtWyVE+VYB3sQofHUj5D+V
         gXHFXzp58mmJ2aLA1aWohq6zoczHlsmUiGqo5w0VrT8JHioxDje2HUjBbE1COSXTX4TT
         a+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286614; x=1779891414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRZUQeBmoTEstKWsMVlBg95hUFZXrJz+CK/C25lcLP4=;
        b=UxgEtXkKORRF+HPiG3rFeFaumRqPPLqY7KLfOKQABVEWGqVHeXdVVE/SRfHC2VbRt4
         icGi7Rvhgm2Vu+ZJPWzUiFpVGeLE0fWJ5qAmOwI+klhPvC8JfxpA3GwG1qqQfRYmQGPU
         gRmBiivlRkmYp0etZOitp8mO2tvQ4aDVh7wNhVWd1pSjic1bZEvCXaaFhUzEcgufkH1z
         3gBnUH8DfUS3XDx0Yd1oMUQBe4PboJvK0LHCEprXuT8wG4EejP5Jv2DzFDdNdriBJg0P
         Evw4D1By1Ky0EPO/+47/9C90xmjbKogXW1Alja7/ds5Fb/cCQd/cdGVisYgNekK+hF33
         xm5w==
X-Forwarded-Encrypted: i=1; AFNElJ9Vg6hZ2fVqwpzows0aTG/k6sPW+Chq4tn2hMnkZlnjYjdl3Qok3RJ+Ac2w5d8dYDVNPC5Hpc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgifwtwgA8gF3VdGgGsadfNn+AzYqtfLZqLSIv3vNO191a28s
	UGcWJ9BU8XLBjqu0LX23XYqCBdsonLIoPR9dj1ZxG0cHC/apiCE8QndT
X-Gm-Gg: Acq92OHmh+dwxO7UbvXCVz5mMZNyqM4yIqHZAw+6lq9dPahHxmtXUDMBfMxIr3rTpa8
	Vv+eIOQuUUK9H0REdH7+EQvlYJRPfNsvn1QX+OaKL0FSSx2ojG+CSKqzf4BMsQ2dgmcVhugWpF1
	YJm9Zuwbxgm4FJ6/ilDNhW1O6t4tRgU4kRjnfBW6DP6+mcUwvklVkUTBbM1iPU1DgQALkZaArs1
	T00xvNo7BLPusMRRQOUnRI5tyXavTJOay4VrypyImgTVYihjVEeg5dT+Bbfjwba3t/pI99DRObU
	TcJ7QKvWLyeOlURbX3AB/0UrmiQlz6xHAlEj8HNB/ro1yNsyNd7eV6z0XDEQhm43eL+8r8X9JfG
	1VliDoE6iUZJhgLlmbsdgPOLiBX2C5uOlUiRVXLBXJ3j6/gcz4KW/6evi6u5d+PgPTe1+GK6tFh
	yp5CLXiKUWZTgHTfLNvW2XvCBlDmyq/zTDL1JGKEV0ooFIyIFoZM0hZioXeoovKEsmpGm6BAdE8
	K9u/9FEx06gF6gKlDNRwuFv6yxfN2Q=
X-Received: by 2002:a05:690e:4415:20b0:654:5d65:9fe1 with SMTP id 956f58d0204a3-65e22678067mr19136094d50.8.1779286613949;
        Wed, 20 May 2026 07:16:53 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] ieee802154: admin-gate legacy LLSEC dumps + un-deaden ADD/DEL
Date: Wed, 20 May 2026 10:16:38 -0400
Message-ID: <20260520141640.1149513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289973-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C2E258FBCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The legacy IEEE802154_NL family (net/ieee802154/netlink.c) builds its
ops table from two macros in net/ieee802154/ieee802154.h. IEEE802154_OP()
sets .flags = GENL_ADMIN_PERM; IEEE802154_DUMP() sets no flags. Among
the IEEE802154_DUMP() consumers are four LLSEC dump ops (LIST_KEY,
LIST_DEV, LIST_DEVKEY, LIST_SECLEVEL), and the LLSEC_LIST_KEY dump
handler at net/ieee802154/nl-mac.c emits the raw 16-byte AES-128
keytable bytes (IEEE802154_ATTR_LLSEC_KEY_BYTES, .len = 16, copied
verbatim from struct ieee802154_llsec_key.key) into the reply skb.
The modern nl802154 family admin-gates the equivalent reads
(NL802154_CMD_GET_SEC_KEY at net/ieee802154/nl802154.c:2978 with
.flags = GENL_ADMIN_PERM) so the legacy interface is the open side.

Any local uid with no capabilities can dump the AES-128 LLSEC keytable
of any wpan netdev that has an administrator-installed key. 802.15.4
LLSEC uses CCM*, so the same key authenticates and encrypts frames at
the chosen security level. One key leak compromises confidentiality
and authenticity at the link layer.

Patches:

  1/2 ieee802154: admin-gate legacy LLSEC dump operations
      Introduce IEEE802154_DUMP_PRIV() mirroring IEEE802154_DUMP() but
      with .flags = GENL_ADMIN_PERM. Switch the four LLSEC dump ops to
      it. LIST_PHY and LIST_IFACE keep IEEE802154_DUMP() because the
      modern nl802154 family exposes their equivalents to unprivileged
      readers by design.

  2/2 ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      While reproducing the dump leak the LLSEC ADD/DEL doit handlers
      turned out to have been silently dead since strict netlink
      validation became the default: IEEE802154_ATTR_LLSEC_KEY_BYTES
      and _KEY_USAGE_COMMANDS are declared as NLA_UNSPEC in
      nl_policy.c, which validate_nla() rejects under
      NL_VALIDATE_STRICT. Add IEEE802154_OP_RELAXED() with
      .validate = GENL_DONT_VALIDATE_STRICT and switch the eight LLSEC
      mutate ops to it. The dump ops keep strict validation; their
      gate from patch 1/2 stands.

This would be a good time to revisit this thread from Alexander Aring:
https://lore.kernel.org/r/20160725121450.4093-4-aar@pengutronix.de

Ten years later the legacy interface is still in mainline and
(per patch 2/2) silently dead on the doit side anyway. Maintainers
who prefer to revive that deletion series should NACK patch 2/2 and
pick patch 1/2 alone; patch 1/2 plugs the key leak whether the
legacy doit path is ever brought back to life or removed entirely.

Reproduction
============

Tree: mainline 7.1-rc2 (22be7671cc3497f68d14555285c0ac221597c8eb),
x86 UML, KASAN off. Conditions: CONFIG_IEEE802154=y, CONFIG_MAC802154=y,
CONFIG_IEEE802154_HWSIM=y; one wpan netdev exists; an administrator
has installed an LLSEC key on it.

Harness: a userspace C program opens AF_NETLINK / NETLINK_GENERIC,
resolves the "802.15.4 MAC" family, and issues a CTRL_CMD_GETFAMILY
followed by a IEEE802154_LLSEC_LIST_KEY dump on wpan0. The dump
response is parsed for IEEE802154_ATTR_LLSEC_KEY_BYTES nested
attributes and the 16-byte payload is hex-printed. The runner drops
privileges to uid=1000 via setpriv with --bounding-set=-all and
--inh-caps=-all before invoking the dump.

For patch 2/2, the same harness shape sends a IEEE802154_LLSEC_ADD_KEY
request with policy-conformant attributes (frame counter, key ID
mode, key bytes, usage frame types) as root. The harness measures
whether the doit handler is reached (ieee802154_llsec_add_key()
return code visible via the netlink ack) or the dispatcher rejects
the request at the validate phase.

Stock vs patched outcomes (per patch):

  1/2: stock dump returns the installed AES-128 key bytes
       byte-identical to the unprivileged dumper; patched returns
       -EPERM at the generic-netlink dispatch.

  2/2: stock LLSEC_ADD_KEY as root returns "Unsupported attribute"
       from __nla_validate_parse(); patched reaches
       ieee802154_llsec_add_key() and installs the key.

Regression-adjacent runs (per patch):

  1/2: LIST_PHY and LIST_IFACE dumps continue to succeed from an
       unprivileged uid post-patch, mirroring the modern
       NL802154_CMD_GET_WPAN_PHY and NL802154_CMD_GET_INTERFACE
       behavior.

  2/2: modern nl802154 NL802154_CMD_NEW_SEC_KEY (which is admin-
       gated and uses NLA_NESTED policy entries, not NLA_UNSPEC)
       continues to install keys unchanged.

Mitigations: a system administrator unwilling to ship patch 1/2
can mitigate the leak by building the kernel without
CONFIG_IEEE802154 or by ensuring no LLSEC key is installed on
any wpan netdev. There is no per-process mitigation.

Selftest gate: tools/testing/selftests/ has no matching binary
for the legacy IEEE802154_NL interface.

The trigger harness sources are available off-list on request.

Scope notes:

  - The dump handler reuses the same struct ieee802154_llsec_key
    storage as the modern nl802154 NEW_SEC_KEY path. Both interfaces
    expose the same backing keytable; gating only the legacy dump is
    the minimal fix.
  - The two new macros sit alongside the existing two; no existing
    callers change beyond the four LIST_LLSEC* lines (patch 1/2)
    and the eight LLSEC ADD/DEL lines (patch 2/2).

Michael Bommarito (2):
  ieee802154: admin-gate legacy LLSEC dump operations
  ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation

 net/ieee802154/ieee802154.h | 17 +++++++++++++++++
 net/ieee802154/netlink.c    | 36 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 18 deletions(-)


base-commit: 22be7671cc3497f68d14555285c0ac221597c8eb
--
2.53.0


