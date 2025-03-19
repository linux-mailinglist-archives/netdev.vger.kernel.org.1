Return-Path: <netdev+bounces-176293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885EEA69AD0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED86C189D7C1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128022139C8;
	Wed, 19 Mar 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFg19veM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914A20B1FD
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419608; cv=none; b=im7wL8oDt5fLUTqPgiV1LMIXSlnwgDL3KXJM0yHetZqNHSRt8aJMJHP+A4EAx1JVPbN2F82DGXTmN5bZzUr6UlgTtW/APjJoW0dP/8jh7RK1o4Sw5j07BQffU/m1wTATEDh6LEn9TlqBaWnlI2a5JPLFSF20sP6Ql+VAbmViuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419608; c=relaxed/simple;
	bh=5fvpujABd67hZa4vLV4dPBve6CN7j6zxkq+ycK6E+lk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h0hE7kDj6luYSgTmkvkXEP6JhbKaR2rpaHvZ4yk6G2HI80iILdTDrI7GPwteNcL0LePzi3lFgN+WpR8S7GIO8na2CqFzTs/vgk2U7QPPucIb4xHwn27VG0eKKttIMQKnjuffFKCVK67cgw4jAGhm01DKHQVo41RtCHzvOg7Pw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFg19veM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=C6yg0SUCka3m5ZyMjTNPoLGHfhCXre3LNKVLeQ8qXNs=;
	b=ZFg19veM+gkq3QmubuVgwD8TtJGT0MV9bYK8sa11FXo745aoNFSjJ/VdTawcE7PxFYcUts
	/8rIF+SH/fmKNp7vmPFnFW+4p912WS0wrS5Y44TGcfOg44QP95xoCVbal35TO85dThBHoL
	S2wEfC9odxu4/1FYeSyrgwWOQHxmIkg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-0orgl_m-Nc-DdQE1LGqiMA-1; Wed, 19 Mar 2025 17:26:44 -0400
X-MC-Unique: 0orgl_m-Nc-DdQE1LGqiMA-1
X-Mimecast-MFC-AGG-ID: 0orgl_m-Nc-DdQE1LGqiMA_1742419603
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so616195e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419603; x=1743024403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6yg0SUCka3m5ZyMjTNPoLGHfhCXre3LNKVLeQ8qXNs=;
        b=HpKs9TGE98hIykUW4fZDTQguXfFKlY0kJc5yfqvu5EBuorvfIYxjn7D5SFoQ21iQ4v
         FGk21lBFyFSQPNJcBKv4BAmoB8aWvFAhDTetHeIh4vgdxMQnMcP02Tceg8zSXjhFNb0H
         BHRa2ZqkY1KURadugg3kdEcA+2E2IVC5Xugl6nZBGX3KdLarYv1NBY2IUkyVTj2OWb2V
         9CDjRRJSAJ/rP3+K0KkvKtuoa3Z5N7iMqst9bKAjaJc3m1gMEdrk+dumbUJwMQ2JJAHk
         dTYZi+H4FCMAjcUBEU1pPYQo/WLsJNZkbO+aEmXuGhyF054iTG7y91t24It4PkH0WCDb
         n0cQ==
X-Gm-Message-State: AOJu0Yx8sV3osoZR+umxW9N4b/qOVX0uAlB9aSmAynN2I9rQVqMC2K5e
	Onv5sarhsmiJ91EAQDkFnH2ezuENjJ5uv7QuRWmF+/uzXyZp1A4xY1GOxqNM5AOivXDtd3d5phE
	693cJquv6+3fFHr9wfRZRIO1j59msfQa4JyV1WLeYEYm/pVYGQj/hjQ==
X-Gm-Gg: ASbGncs/UYzNI8udfYz892iKdDywrKssm16vq4axj9WvKo5b2ylwck97YIQv0ZqsZNX
	8f+Z73n9sZagegYqKYhP5SSLkSExAEPFLrG1IgI7lj92fby/S47idf61R2OCjR8KuioYbtuOoxb
	ReD+7tyk6Xu18VHpDXGEjSTyq2GHNLIK7dRrema5yHHCY5EYpKevJNn1Meq9RzBNw+4lmHX4m4e
	oOXSMx9zOlex7E2Jcb1wEepol3GryDuzO2liTlG1aCVmrCtBvFA6zDHDK8/ckiaVXFJW23pYWNQ
	UT6qkR0ygF3Y9ByK/lT4EiXWonY8dJuwq8S55nuxFZhJdwjbK+VloyvCXfHzwAkH1bDAhA0=
X-Received: by 2002:a05:600c:4e49:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43d4953b186mr6488465e9.7.1742419602638;
        Wed, 19 Mar 2025 14:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe3jOMizdiHwneo6UdTXRgodHy3aN2AyqLwo0uKLGsxxyaPJXsX61Oc9JUfojN8fh+yRukoA==
X-Received: by 2002:a05:600c:4e49:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43d4953b186mr6488305e9.7.1742419602227;
        Wed, 19 Mar 2025 14:26:42 -0700 (PDT)
Received: from debian (2a01cb058d23d600155a5103ba09f99c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:155a:5103:ba09:f99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f3328bsm29158065e9.1.2025.03.19.14.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:26:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:26:39 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net 0/2] gre: Revert IPv6 link-local address fix.
Message-ID: <cover.1742418408.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following Paolo's suggestion, let's revert the IPv6 link-local address
generation fix for GRE devices. The patch introduced regressions in the
upstream CI, which are still under investigation.

Start by reverting the kselftest that depend on that fix (patch 1), then
revert the kernel code itself (patch 2).

Guillaume Nault (2):
  Revert "selftests: Add IPv6 link-local address generation tests for
    GRE devices."
  Revert "gre: Fix IPv6 link-local address generation."

 net/ipv6/addrconf.c                           |  15 +-
 tools/testing/selftests/net/Makefile          |   1 -
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ------------------
 3 files changed, 6 insertions(+), 187 deletions(-)
 delete mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


