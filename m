Return-Path: <netdev+bounces-100320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C38D88A2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA91F2304B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E3139CFE;
	Mon,  3 Jun 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHVk8bbm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C004137C2E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439495; cv=none; b=DmLRfNC3W1KUdaEyCT1AhgXajlqVoYWF/h6638NGqHoAzX1jvbddBxEP+vqjlrZNtsw4JANeqSQI9lYJsQAotiks6JypaeK9jEIgfla8JaTS5C2lBVtqRnYPJ1aIKlec0F9yf4mmf9JRvy3kGMFe5yfSfYsoBXzgNpWKF6u3QUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439495; c=relaxed/simple;
	bh=hLoX2IbM9Dc7g8XZC4sIIbm2xI5YIG+DCSbPVcZQL2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+rVy1jdcwrMsI+Vh8KAefuVd6tnPzlW4PEM7O5rFZTsS6Q01yv4mNAbtE3itTMbYFETOdIrtDhcMuFHEikwo07AahiKXvYvgKljoEGLLYE2NIVjCzaZticgfWzl5mVKWHZ71WO1tpJI8SqU0g9k9mhG9UQTEnN9acHK4qIoV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHVk8bbm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717439492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbybIFAPNiJYTP2dPOGJz7xcoG9uvl5NWDzivsSBGLw=;
	b=bHVk8bbmhJLj5oFW+mYHUL19+FYESytWobfEV1Is8XkYhRhTuPQ3xy6mat7t/rCYnqePqB
	7vAWfPZ9JHc9ZCGALU/M/71sNNJ0PgWf5uVzuMGkQtXNIUFM8XYlViZmwyhZ8PMZFxwktd
	7Siy8RqDm5vEMd3ZD3ag36mKY0ACx6c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-gdLL279nNteQGXOeK8LKTg-1; Mon,
 03 Jun 2024 14:31:28 -0400
X-MC-Unique: gdLL279nNteQGXOeK8LKTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 917AE3806703;
	Mon,  3 Jun 2024 18:31:27 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94870105017A;
	Mon,  3 Jun 2024 18:31:25 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: openvswitch: set value to nla flags
Date: Mon,  3 Jun 2024 20:31:20 +0200
Message-ID: <20240603183121.2305013-2-amorenoz@redhat.com>
In-Reply-To: <20240603183121.2305013-1-amorenoz@redhat.com>
References: <20240603183121.2305013-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Netlink flags, although they don't have payload at the netlink level,
are represented as having a "True" value in pyroute2.

Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
fails with the following traceback:

Traceback (most recent call last):
  File "[...]/ovs-dpctl.py", line 2498, in <module>
    sys.exit(main(sys.argv))
             ^^^^^^^^^^^^^^
  File "[...]/ovs-dpctl.py", line 2487, in main
    ovsflow.add_flow(rep["dpifindex"], flow)
  File "[...]/ovs-dpctl.py", line 2136, in add_flow
    reply = self.nlm_request(
            ^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
    return tuple(self._genlm_request(*argv, **kwarg))
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
nlm_request
    return tuple(super().nlm_request(*argv, **kwarg))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
    self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
  File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
    self.sendto_gate(msg, addr)
  File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
    msg.encode()
  File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
    offset = self.encode_nlas(offset)
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
    nla_instance.setvalue(cell[1])
  File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
    nlv.setvalue(nla_tuple[1])
                 ~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b76907ac0092..a2395c3f37a1 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -537,7 +537,7 @@ class ovsactions(nla):
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
                     actstr = actstr[len(flat_act[0]):]
-                    self["attrs"].append([flat_act[1]])
+                    self["attrs"].append([flat_act[1], True])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-- 
2.45.1


