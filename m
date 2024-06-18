Return-Path: <netdev+bounces-104540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1990D24F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A48286CA3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C731AC24F;
	Tue, 18 Jun 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqfFV30g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BE13D887
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716670; cv=none; b=kwHfYO1sD7zQitSwFpoyHkSvsSEChi4/oqq+YIX8ZtxRqWI6lQF1NVAq12em0N9n1Ri6gFwNOcFeTXZZUc6Sui8Kp/IHyAzoPuYXA29TkByesorUF5k6S/sp0P/JORFsVtFAaeZ9/Id44G5ydrD8i6YARk42kl9z9vXNH8BKP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716670; c=relaxed/simple;
	bh=0fFikviDWcprlSP9pQuMSjycM5eGEUhkT5N4rUYJUkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hg6KQ7b29ZLl7pUUiUmIPsorW8T8RErNmC1ukIhuuaAxex4C+q2x1wFPulQLWr/dA0TW8XhLRMpoGnnBqMMzEExZGfVoVmhjVC/L14CG4OSMe9ta3cu/S8Fx+FreBVjBDysDB2i7TfrsjuFWDG1EKlEoow6YGy9KDngqsYcb7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqfFV30g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718716667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkG/y0EVJpO2MLmRR695aEiMGaJSIz5IAvVHId9VoG0=;
	b=IqfFV30gzSO0nnjsJ3/4ye+QgSOGTx7vm7PEy7n8W7X/KJOog4q/AZAJZO4+wytVAxNNE7
	yYKRCtxCqLq8UNty5EWZWx0x5dmRuy9qTMcOwKGxmVu444wpKiLPb3DNEzbf7g8K9oonuj
	pxldGQMIpvv70p7iGwZ97FzEnTCgzYM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-Kjq8FwCvN92fgwMlDKj8fQ-1; Tue,
 18 Jun 2024 09:17:44 -0400
X-MC-Unique: Kjq8FwCvN92fgwMlDKj8fQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565A119560B3;
	Tue, 18 Jun 2024 13:17:42 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55DB91955E83;
	Tue, 18 Jun 2024 13:17:40 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: openvswitch: Set value to nla flags.
In-Reply-To: <20240618072922.218757-1-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 18 Jun 2024 09:29:21 +0200")
References: <20240618072922.218757-1-amorenoz@redhat.com>
Date: Tue, 18 Jun 2024 09:17:38 -0400
Message-ID: <f7t34pamlu5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adrian Moreno <amorenoz@redhat.com> writes:

> Netlink flags, although they don't have payload at the netlink level,
> are represented as having "True" as value in pyroute2.
>
> Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
> fails with the following traceback:
>
> Traceback (most recent call last):
>   File "[...]/ovs-dpctl.py", line 2498, in <module>
>     sys.exit(main(sys.argv))
>              ^^^^^^^^^^^^^^
>   File "[...]/ovs-dpctl.py", line 2487, in main
>     ovsflow.add_flow(rep["dpifindex"], flow)
>   File "[...]/ovs-dpctl.py", line 2136, in add_flow
>     reply = self.nlm_request(
>             ^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
>     return tuple(self._genlm_request(*argv, **kwarg))
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
> nlm_request
>     return tuple(super().nlm_request(*argv, **kwarg))
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
>     self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
>     self.sendto_gate(msg, addr)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
>     msg.encode()
>   File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
>     offset = self.encode_nlas(offset)
>              ^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
>     nla_instance.setvalue(cell[1])
>   File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
>     nlv.setvalue(nla_tuple[1])
>                  ~~~~~~~~~^^^
> IndexError: list index out of range
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


