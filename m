Return-Path: <netdev+bounces-290895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDYmA6aUEGpSZwYAu9opvQ
	(envelope-from <netdev+bounces-290895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCC5B8621
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4339730360B8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610A3655F1;
	Fri, 22 May 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+fDAlBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF8282F22
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471006; cv=none; b=T0n6Lk9zHEatVbnwPnaHhJw3zciqRLZu6BUoGWSP6sYG7v/aWtRvt2f0hbttKjODA/SwdMSHBiJT6Z/+ftqUqOGoGfzb53Rm4fnY0OgzT0jGcw5uUx5s9xaNiPLeKOicWgh9/Pc1LEnbU6bJYMBTYzcoSYfLHJcXOxKaGdLFds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471006; c=relaxed/simple;
	bh=8XVjLV7e/qCqrwn5B28+n8PeQ26e7x6xTFMr1X4a10k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DeA9V1bEWPeObL8lyxVffBTLmMwJNOIxS3dbHhUBOxr5E9QNysM5Wutg3JYvH6MRoGGY5WC7PiKARrid9Z4NOPM1mk7LiakvFyf9DAGULIRTKBapib9Vai0xqplW9Vh9NVZrmvP04aZZfITrJDOq4kcswwYy226hJBkLwGHDKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+fDAlBx; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914b616c670so126051685a.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471004; x=1780075804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ruwweWXQWmjxBpucpHESrzKns/pb62I6FD4wOqbNvgg=;
        b=t+fDAlBxnxFgWoBYFEjWvjNhmJNm1UzNFvec9bsE3xocTg5+Mgz+ipkEkfGVjsF4Om
         NFXtgvifzs8D0WEYIwe04smCcmaGm8YFBOrn+oV+DIGP7M0qe3XkbxNcyHaXgX87dFTs
         qZ1tlEAxet4W7wc1E6WpekOsubuBg1bc+nR4MGNHhOCuXJd2mTa1XD6XjrLRmfQirbe3
         OcpbpCEBLFEwWgS5JSw1AhTG+f0QJCp8GW8LMpdcvVmpSrNsEZkmR5Ts/OyNv70dmocc
         XYCcGqrv0HLtr927w2QZXJvxsioaUpW4aGhFyXXc6j4rW/bhUjzficAxhB4QQ6yjW64A
         SlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471004; x=1780075804;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruwweWXQWmjxBpucpHESrzKns/pb62I6FD4wOqbNvgg=;
        b=ixeYPTD8+0Cz2TY17z7bmjHj2EwaMxA7modthnfMq2mM+pltbkNYfKe8klRWqB6lJn
         QDTcVbKJ+x3Lv954ymzgeHuEZlfVRqf8uJeQIoO6g3smp/ofhREtNuiaOjls1rySQrBP
         rmjUpiH05WfCeVOMxB4RzBtJ4c77aekRLgdX5NBpBQCbTD9FaZ/AcYI0EgLjaEFKdbSH
         KlZ50xwVMdVnQDEWkOz1hC9pODng5bswvYoDzJ8YnLSx1mqz8I72GkSBPZgDqsg/Saeo
         p2fmfpWE8DO+Tc9RhoZRdEJhT5vR1RxyCTxE+DVLya9QnIivTjvtGrM7QKW25YfGsrBI
         uTZg==
X-Forwarded-Encrypted: i=1; AFNElJ/yn/uqLwXR5zpqEEC1Exny4oJJg0x4C9i4GjvrMT4KS0dW5YnQvjNWV6uESa7y2HlpdaCtwz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgPoiUiheZdsR7Mbltr1R+tHRZvg5a/mDF/ui7x7Fr+q5Ku81
	s8LS/yiHJ/PED8s3qKYQlCDZ2s+C4b9LJn5ZmIEQS9D6uMequ1CAMusQOSLipQzn8VGVpCwzXyK
	R3mb3YqUOChOrmg==
X-Received: from qkoj16.prod.google.com ([2002:a05:620a:4110:b0:914:bfa1:f96b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2243:10b0:914:b65f:6aca with SMTP id af79cd13be357-914b65f717emr391853485a.4.1779471004166;
 Fri, 22 May 2026 10:30:04 -0700 (PDT)
Date: Fri, 22 May 2026 17:29:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-1-edumazet@google.com>
Subject: [PATCH v4 net-next 0/5] rtnetlink: RTNL avoidance in rtnl_getlink()
 and rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BFCCC5B8621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)
v4: Addressed Sashiko's feedback.
    added 2 patches for rtnl_dump_ifinfo().

Eric Dumazet (5):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
  rtnetlink: do not acquire RTNL in rtnl_getlink() with
    RTEXT_FILTER_NAME_ONLY
  rtnetlink: do not assume RTNL is held in link_master_filtered()
  rtnetlink: add RTEXT_FILTER_NAME_ONLY support to rtnl_dump_ifinfo()

 net/core/dev.c       |   4 +-
 net/core/rtnetlink.c | 131 ++++++++++++++++++++++++++++++-------------
 2 files changed, 95 insertions(+), 40 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


