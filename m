Return-Path: <netdev+bounces-247916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68BD00858
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 02:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C574E3061DD4
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6421CC55;
	Thu,  8 Jan 2026 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2QjA1Ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D021257E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833927; cv=none; b=WO5N/7KaNqgXqSnocngDopb650IR5Gw+BW6ZzmY3dyJbDNV5P/6S1B/QhcJd80QRDxmYmC7zzs/eF1iLBU5TNcD4X/7XOI4CLoTvuyNK4qbj6fh6Mi57Iuhx5i+6kKeelaNC6py/EA8CLaq4FNzgWdNsXlM49n5BhJclG4RCxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833927; c=relaxed/simple;
	bh=6tucM9ZQ59G0xrDfMuItsfF1GTt7N8xzYil/t1gA1PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ehgrejlpg6QKdw66gKX2X2e+JDpag+KKZzzQ8sg0mxk5bE0uoDBTnJBFZULJlQEzY9Aj0dRj90p4cEc04jupMEQWek99GizFpqp/7VKPYdDt9X47t189fh7iuzDicf5BZsGSB2icuCOLzgY6aaPDEh0ibWGajO/gnh5HgxxonEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2QjA1Ek; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fb9a67b06so28867057b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833923; x=1768438723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXRdbOnUYiudn9GxHVVfvuR3By+3aRth8g9ruHEmquY=;
        b=l2QjA1Ekya05GYHt01OxB2dyZAG1P5dMJwxi9qkXuZgkJOHcTH+LwfxBKo6PjaRmFr
         orpLTsra1X/PwHcIkfIUXSCKM9yGMtNWiRbk7AJEnT/cICaHlAe7on3rAMNtFrspKCDP
         HkLEy09D9hE7YbQWA1D+KBiobO3sAD8vZOqksl4Ed1ZxFC1spnitG4746M+oXJUOtGef
         Mfvgs5ki/n27Ejv2qoeB29W7ZTHniI27cZP9lE1S9OG0H9aPvvUsbPy3zD7pOxPvV8UT
         Xlw1cQ03tmZjfvDGPBBT6w7QzdBzsX+Nf8UQ+wDk0S4adMXN6XDS+8UCmb+rMLMCIi19
         KPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833923; x=1768438723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXRdbOnUYiudn9GxHVVfvuR3By+3aRth8g9ruHEmquY=;
        b=dqPXX7SI0r9Y//ZJHG5woS2xP26Jt0JEjKLlfJE7zf+/Z+1A/X2NgcizNKGRQvP8Q4
         tzskHx12QOuGCYaBMdIXGsie9FTH5dYVKp9h2ersTivskTXbpO7smjLvXcfr0JAtvR6a
         d1RH4iLlEMAXYbVderOGIZaEGC+7CqjH+WQ+9vPPxs+/6t4vneN4OxXewsH89pm509AF
         q6LWI7MwieBcymaVlw05ytBc7s4yGExCe0JbtoVoCptFmDmNmAfoEzcZtIWACI7EqK1Y
         cQO0krut1zKXBPdQYtiC1DjbpDeCWPbMq7qFthdwrdt5I7f7HM8ZScSuaG5lPSFOdArC
         jnpw==
X-Gm-Message-State: AOJu0YzrzYxZr+5WLbmPNrFry07iO6HGnoB74kC65n4RINjLnRCmrefn
	b7PzF4DUT127EsifPAPw0aBy2iE+dFhBudyNFvAnHgxeg+C+jcMSQEef
X-Gm-Gg: AY/fxX4GqGsc/sCPaGfADxY1TCd29q7Mj9CggluVCpqn3XJQggPyu18/gITYwzSY2xl
	w2j2v9Ec2WCOMzFGWVizbTDpAsPz433Yb+HqXyeVYhCGEnoDdcDRT+Cyoh907Ig6qVuogJVxNzO
	Ka3lMDOyFkMycMMx7O4b+aqsSuAH7GCqV/r0hB406shC37jBPkFpWe+JGCzG5bZaY+x7nlUIHUu
	1pTCcmdSQE3TnGpvEgJkddLSr/AbuOEcS+lpx3YJIm1x5ACQRU1wbqLH7ErBru9/0mjbR4hu/2W
	Ral8Yo/gOhGxgHyf0rkmfrLr+BMBKScsPB3JRPZP9aDKe2lbF1pjQo8+g3YlR4PzDBkc5uwl53R
	suJ8BtjF/1rjmlDGnpUvswoqWZLsF0CRyA44r9bjRRDG/dQNAXpeyke4n9cZapIl3XKke8zrSmp
	PViDO7HwS6
X-Google-Smtp-Source: AGHT+IGSZsqPA4Z0otbmZ3NOTLwk4921dfCJ5SicHC0H7KIg1eX7bEw/y3LBIJTZ2PC9nnY65wqkaQ==
X-Received: by 2002:a05:690e:419a:b0:63f:ba88:e905 with SMTP id 956f58d0204a3-64716b99817mr4126568d50.30.1767833922740;
        Wed, 07 Jan 2026 16:58:42 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d510sm2724820d50.16.2026.01.07.16.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:58:42 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 Jan 2026 16:57:38 -0800
Subject: [PATCH net-next v8 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-4-92c968631496@meta.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update devmem.rst documentation to describe the autorelease netlink
attribute used during RX dmabuf binding.

The autorelease attribute is specified at bind-time via the netlink API
(NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
when the socket closes.

Document the two token release modes (automatic vs manual), how to
configure the binding for autorelease, the perf benefits, new caveats
and restrictions, and the way the mode is enforced system-wide.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- Document netlink instead of sockopt
- Mention system-wide locked to one mode
---
 Documentation/networking/devmem.rst | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..67c63bc5a7ae 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -235,6 +235,76 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+
+Autorelease Control
+~~~~~~~~~~~~~~~~~~~
+
+The autorelease mode controls what happens to outstanding tokens (tokens not
+released via SO_DEVMEM_DONTNEED) when the socket closes. Autorelease is
+configured per-binding at binding creation time via the netlink API::
+
+	struct netdev_bind_rx_req *req;
+	struct netdev_bind_rx_rsp *rsp;
+	struct ynl_sock *ys;
+	struct ynl_error yerr;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, ifindex);
+	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	netdev_bind_rx_req_set_autorelease(req, 0); /* 0 = manual, 1 = auto */
+	__netdev_bind_rx_req_set_queues(req, queues, n_queues);
+
+	rsp = netdev_bind_rx(ys, req);
+
+	dmabuf_id = rsp->id;
+
+When autorelease is disabled (0):
+
+- Outstanding tokens are NOT released when the socket closes
+- Outstanding tokens are only released when the dmabuf is unbound
+- Provides better performance by eliminating xarray overhead (~13% CPU reduction)
+- Kernel tracks tokens via atomic reference counters in net_iov structures
+
+When autorelease is enabled (1):
+
+- Outstanding tokens are automatically released when the socket closes
+- Backwards compatible behavior
+- Kernel tracks tokens in an xarray per socket
+
+The default is autorelease disabled.
+
+Important: In both modes, applications should call SO_DEVMEM_DONTNEED to
+return tokens as soon as they are done processing. The autorelease setting only
+affects what happens to tokens that are still outstanding when close() is called.
+
+The mode is enforced system-wide. Once a binding is created with a specific
+autorelease mode, all subsequent bindings system-wide must use the same mode.
+
+
+Performance Considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Disabling autorelease provides approximately ~13% CPU utilization improvement
+in RX workloads. That said, applications must ensure all tokens are released
+via SO_DEVMEM_DONTNEED before closing the socket, otherwise the backing pages
+will remain pinned until the dmabuf is unbound.
+
+
+Caveats
+~~~~~~~
+
+- Once a system-wide autorelease mode is selected (via the first binding),
+  all subsequent bindings must use the same mode. Attempts to create bindings
+  with a different mode will be rejected with -EINVAL.
+
+- Applications using manual release mode (autorelease=0) must ensure all tokens
+  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
+  leaks during the lifetime of the dmabuf binding. Tokens not released before
+  close() will only be freed when the dmabuf is unbound.
+
+
 TX Interface
 ============
 

-- 
2.47.3


