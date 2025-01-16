Return-Path: <netdev+bounces-158893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4CA13A88
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07295160930
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4551E991A;
	Thu, 16 Jan 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5/Djge/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4519539F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033023; cv=none; b=qNJyeYcVqpLEcodY/yAPOt9kIVQ8KiTh8sXUidL+J1VY9qaFpJ7e9V/W/vcBymdQxdCxPrKC9TWivGpVfTXjCMioIXm/IQmlnmJVNS8AaFnYLWcmdfsTNJ4cKp1QPvio0C6CsjYqT/p3hzIINAfvfwDqR7h7BePwPPSHMQDvuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033023; c=relaxed/simple;
	bh=XbtJDtjO1AzzG13YQ31Gos6JOzfzGVg68mtNqGPC6QM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VPY3+GJMcyvqLuK33FQSr3onPJgdVMiTIR7jV3G9NzE7h7qm5eFT4qjd+up7CUwlyQKuFXPDJGLPOKrz1lM9b2bD+JsllRtjasRnbUKVOOlv1GjR6Zw6n/UkhuNYx09wEq2MvTrY3qj//vILen3OZQIxXpWApgsIJsMSO2e3HTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5/Djge/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737033021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JMPXd/pIK34W8GzTwNPr5mzD4lfJU0TtT5BZPeG/Q94=;
	b=C5/Djge/sWw5tETOj1tfSs/UrJG3wttAhff2JlOrgfc8PKtoPDbO7t+EuS+OHP8t6mTkgB
	JZP4APYeiyJqBc4j4HIEYlvo38mksAWfAaSAkROu+DPMP3p8zqri6/S5BYWbLUe4do9V2b
	0xSkh2SX07chdWPgsbw/rWzT6SC21Yg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-bMhkDdxsM2-VBAzsaMXa0g-1; Thu, 16 Jan 2025 08:10:20 -0500
X-MC-Unique: bMhkDdxsM2-VBAzsaMXa0g-1
X-Mimecast-MFC-AGG-ID: bMhkDdxsM2-VBAzsaMXa0g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a684a0971so422692f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737033019; x=1737637819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMPXd/pIK34W8GzTwNPr5mzD4lfJU0TtT5BZPeG/Q94=;
        b=iKBsyHczCyMnd9A3/P1ItqdHBAEHNIrWguLLl0KjTPcYVi7DnbfhRq1MhfRm4uWLyG
         rxDE/ZCDhgWSUlVVxot1H6oPcJLe9NPa97s2qSjWfMZRZi1kkHFkrZM9l/UU3lAet5PS
         pa+IHwFWG3yc22Tp0SDxWolQnrdoqydsFUfvNitInAoLJ2ltdQoK6iK35ZzmML1IdQEs
         s45nwFhQSrtCwfhtX5OyKvTOkB0TK3u+8QGZv+0wG8gPkw0NVZxvvBM0PFyfuhHp38IN
         5JQaVgiR21od/PtpVTEEVKN89quPwm3tEoeGr5+TAFvteVLC32O5cFk5PEmC92naaUeV
         Fo9g==
X-Gm-Message-State: AOJu0YxGfMkGDzA5NIBpMXRrCD00iIl9d/anv3iPJwT66pzDncY9RbDC
	9R1Uz8cx4J2iogSBlIIxLxPW37Dv/pAZSUinjk81Xg+fMcooml3hoBw+4Y935gpqQl5jCjR5SsZ
	0jJo1iDt6Yth4mIx7T8FXxN0587tvKs58naQZvPegbZy2/S8yzaSUgg==
X-Gm-Gg: ASbGncsrlvIdMZlA/P3JCtcvs9JprUPDcxKr8S/Y6se4IImn0p3unTNxTUzwZBL1UBg
	kYkfj+9/8Zg6EZJxKdgO3tOoo90SuUa9MCIe2Hwh8FW9+tU6vTEk7o9yGjkVmTfzJU6umlkTU4z
	EWB9/ZCMssjVFxYgmSpp+4rWBVFjpbz0yh5Ujqnu6HmNAmDjjrnK93uXqei8p/zZ1vIkaxiK5sK
	bE/fB2jodEfB68pUub8DDz2W7ERfm2QkQB7hrV1V/YKMZKBb7VFROIJDgPjgkpEZT/t+XrEnPb8
	rVumgh3W0BdVj4Uk0IIStwVZtdrHhT83U0je
X-Received: by 2002:a05:6000:4023:b0:38b:e32a:10aa with SMTP id ffacd0b85a97d-38be32a12eemr8987427f8f.5.1737033018913;
        Thu, 16 Jan 2025 05:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwi6LQc4eWIr5l+YO7NdD5PedD20B7qjjCk+VK8z5YlzJYCUasg2J7ErNEJGNePlHHtcGpPQ==
X-Received: by 2002:a05:6000:4023:b0:38b:e32a:10aa with SMTP id ffacd0b85a97d-38be32a12eemr8987402f8f.5.1737033018549;
        Thu, 16 Jan 2025 05:10:18 -0800 (PST)
Received: from debian (2a01cb058d23d60074daf58b34fd2b3c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:74da:f58b:34fd:2b3c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bea3c2344sm3095668f8f.70.2025.01.16.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:10:17 -0800 (PST)
Date: Thu, 16 Jan 2025 14:10:16 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	dccp@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2] dccp: Prepare dccp_v4_route_skb() to .flowi4_tos
 conversion.
Message-ID: <208dc5ca28bb5595d7a545de026bba18b1d63bda.1737032802.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
ip_sock_rt_tos() which returns a __u8. This will ease the conversion
of fl4->flowi4_tos to dscp_t, which now just becomes a matter of
dropping the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Remove useless parenthesis (Eric).
    Slightly reword the commit message for clarity.

 net/dccp/ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 5926159a6f20..be515ba821e2 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -15,6 +15,7 @@
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
+#include <net/inet_dscp.h>
 #include <net/inet_hashtables.h>
 #include <net/inet_sock.h>
 #include <net/protocol.h>
@@ -473,7 +474,7 @@ static struct dst_entry* dccp_v4_route_skb(struct net *net, struct sock *sk,
 		.flowi4_oif = inet_iif(skb),
 		.daddr = iph->saddr,
 		.saddr = iph->daddr,
-		.flowi4_tos = ip_sock_rt_tos(sk),
+		.flowi4_tos = inet_dscp_to_dsfield(inet_sk_dscp(inet_sk(sk))),
 		.flowi4_scope = ip_sock_rt_scope(sk),
 		.flowi4_proto = sk->sk_protocol,
 		.fl4_sport = dccp_hdr(skb)->dccph_dport,
-- 
2.39.2


