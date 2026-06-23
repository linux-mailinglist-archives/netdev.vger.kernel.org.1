Return-Path: <netdev+bounces-301392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdlCIPWbOmpNBggAu9opvQ
	(envelope-from <netdev+bounces-301392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196366B7FF0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:45:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LCW8H1+H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301392-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86499303F965
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D53CC32B;
	Tue, 23 Jun 2026 14:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E23C199A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:45:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225907; cv=none; b=gDbw6Yk5H5sll1GAJnXKptI3G792M8jKdOWf1nuODaq1tfl5vE8vt6MChPVZO7pquxxZB3mD1iwg3KOne6oNRgjfugcD+j7R8T2Ci/XFe7kcH/CstOvHMxB4EI9a95YAtEaA97LkEmWfwuZ0poQ3liboKnJQXjJ2qQCsWXTPxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225907; c=relaxed/simple;
	bh=sZNi6xg9sflBEGhOc7EN8IGrWBPWKS1LHIHSe3Ram6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfRvKQceM24OzCcDPB21WfHFuB+fPIObS48ZS4BV7GGD8bD3lL6Uzez3deM06gt2/PQGzFAzP/JtDqO4W82UZplAuDzNowfs83uAX/gvyrpucZ0Wtdvi1r7lg7PliReZNH/04UGFrTE5nY/l3c6JW5i9LUnP1GAxLvRAtVDj4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCW8H1+H; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c858014845aso620809a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225904; x=1782830704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cAvGjsb7kwxKnrggDL0ESG1XH4uHWWvpVFC+MpwI9o=;
        b=LCW8H1+HnWXkd8L8LdOLweY1uEVX+0ymxJJ8yQnr94l0NhEKz86L5K/d9L3+VzjY9L
         t/Ayf9cUwfboJXLY+y/Ez6wmoEoR3ty3JXMYK1EW4R1F/ZsLyT/3PnXcm5DA37Mt6kmn
         Wx1C1mwnMwd9N8WlqWckjABIFHy7+rURt8vKWQF2XvKU+5Pd1ZfhDf1W+281gLncamdg
         dezVz32wbvHxCwA2qtluzKXvYVHSRxIPWCRFstM0n3DQCSt4NKCmvB3Y6rYWGxJv9kDf
         qYWKwfNeE2LQbdz0b0JMKgJdiS0kKI6E+vctTxQT5MFCEuYMat633DXM6FBdURwradB6
         S34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225904; x=1782830704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cAvGjsb7kwxKnrggDL0ESG1XH4uHWWvpVFC+MpwI9o=;
        b=LQ+sj76cHXYx2hZfREP/89/18RrrrkJvhiziDkZnCUGeckyYJwKPf7d+LuoApLg1Jp
         seZzm8u4xIT+0oISQ3UwOb7G6Zv6kSYIIlCDXx28AZXz71wo+nfcuN9x1pN29HEiBkT9
         AcPR0XsfbAbPUJfr4dOKE3ixPE8kNub7C2QdKqsOveDHDcoxtjhVGpe+5GadiKo87JV9
         Brg3JdZqEdBefPMUfDqcLPGkcBfLxLCZ9b8vYn95iGILoxxwWZ9fr0cA7yEFqI+eRFq8
         m2YmtnX/RaNGGXO54lTCjivVnKVsiaOTtSniPK9dK1o/aiEKGjD2vV04r2OUw+2hMs0q
         nWbg==
X-Forwarded-Encrypted: i=1; AFNElJ9sWSQiM71t95hI68izAFPf131U3yQK7DgO6ADTY/h7MgXqWxMog8Vsh4qpT//OGwH1tRa2gyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAPIcaryQ9jF/Zpu6v4fyvMzKvHclsSIe1AK2qM02RCVN1o9N
	Id15hzyMw38G6CMJyWwHmU20KLCypbBr1CI3BHr+oMWzKjcXrT4vyLqA
X-Gm-Gg: AfdE7cmGt+pb2CqytjNYQ/6LNhnM1mVckRi9LkFfqUboHpl6EwqArivWwLLNI1/ml58
	GIRMLw9teEdNasn9karg5MNNQPImNujMAx9mRTjwv2f+8nKnE+1BhUUu0cAOkN15rTDlkmCYWC9
	xrj8Cz/OFh9Tg8IEFapR4Yf3W/1Bc8vpBbCorYhQ+1KR1xhzGZ5nUiV82holuVYN3iyltxQ7VV4
	qMqnpzuUkkVkFYs+9jSuDiqhv7MgsMC75ptlublzA+gwi6NSllOrVJ//ZBQwcww6FjUtNcclWJH
	aWqr4Iy6iZFQCF3CuRbkNwKyBMe/QJhBZRhY2MSMWHs7s78cG/3GLr+ORbi1B1Evxq7sPUG7yKS
	/2MAPnbZYh0stPEun+Zjj6MDa8h489w0ppQ41hryQHObn7G0ir0o4mRy9I2MnaW8ZpCj5kPdk5U
	iSf4eSqu6zj0ZqItYO8Ujn
X-Received: by 2002:a05:6300:8811:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3bd10b3de08mr4191736637.29.1782225904306;
        Tue, 23 Jun 2026 07:45:04 -0700 (PDT)
Received: from i386.168.1.127 ([150.107.232.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1dc13sm10229638a12.26.2026.06.23.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:45:03 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,
	Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH v2] netdevsim: fix use-after-free in nsim_create and __nsim_dev_port_del
Date: Tue, 23 Jun 2026 20:14:47 +0530
Message-ID: <20260623144447.255326-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301392-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hrushirajg23@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,resnulli.us,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,m:hrushirajg23@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hrushirajg23@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6c25f4750230faf70be9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,vger.kernel.org:from_smtp,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 196366B7FF0

debugfs files created under a port's ddir (ethtool/get_err,
ethtool/set_err, ring params, bpf_offloaded_id, udp_ports/inject_error,
etc.) store raw pointers directly into the netdevsim struct, which lives
in the net_device private data kmalloc slab.

If these files outlive the netdevsim struct, a concurrent reader can
trigger a slab-use-after-free by passing debugfs_file_get() (which only
checks dentry lifetime) and then dereferencing the freed data pointer
in debugfs_u32_get().

In __nsim_dev_port_del(), nsim_destroy() is called before
nsim_dev_port_debugfs_exit(). However, nsim_destroy() calls free_netdev()
at its end, while nsim_dev_port_debugfs_exit() removes the port's
debugfs directory. This means the slab is freed before the debugfs
files are removed.

The same window exists on nsim_create()'s error path:
nsim_ethtool_init() creates debugfs files under ddir with pointers into
ns before nsim_init_netdevsim()/nsim_init_netdevsim_vf() which can fail,
and the err_free_netdev label calls free_netdev() while those debugfs
entries are still live.

Fix both paths by calling debugfs_remove_recursive() on the port's
ddir before every free_netdev() call. The subsequent
nsim_dev_port_debugfs_exit() calls become harmless no-ops since ddir is
set to NULL.

Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
v2:
- Also fix the same use-after-free window on the error path of nsim_create() as suggested by Simon Horman.
- Shorten the code comment in nsim_destroy() to be more concise.

 drivers/net/netdevsim/netdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 27e5f109f933..f2824e75cddd 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1165,6 +1165,8 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	return ns;
 
 err_free_netdev:
+	debugfs_remove_recursive(nsim_dev_port->ddir);
+	nsim_dev_port->ddir = NULL;
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -1214,6 +1216,13 @@ void nsim_destroy(struct netdevsim *ns)
 		ns->page = NULL;
 	}
 
+	/*
+	 * Remove per-port debugfs files before free_netdev() releases the
+	 * netdevsim struct to prevent use-after-free in concurrent readers.
+	 */
+	debugfs_remove_recursive(ns->nsim_dev_port->ddir);
+	ns->nsim_dev_port->ddir = NULL;
+
 	free_netdev(dev);
 }
 
-- 
2.47.3


