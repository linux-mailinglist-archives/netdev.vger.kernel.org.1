Return-Path: <netdev+bounces-164682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B669A2EAFF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B71885422
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8F1DCB24;
	Mon, 10 Feb 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zF39tmod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49851C07CF
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186677; cv=none; b=Z0sFTF8CSMxzqg9YKXJh8IVhoqvqSjmBC8JIYwoIKv9y4SJTk6cnc/sQ3uP0l2F2Bf/IejeXndzIVLDm1N2N4Jgm1FutmW/am3QCy6en3v4zGmakO4SH0TL1pWDKKdpNPWrF3V0ECHXGHFFwwHNzfjoMqf/SySFy4JV0anWuKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186677; c=relaxed/simple;
	bh=tbatCdkWNAkuhZ08pL+ZTsXKAJEwYMN0UaUAzElVGXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7lICPOh/Alhlim5ZQXTjzL8/n8JE0dkDTq2XHXLQULaY+Gn8+V/fkte+QfCPpRqCeGNopXV+587sMaeXLRKooHW7rrrjIi4Gni7pXQ6ZqOA/MEYMdt2NstlTSxxXyFMmIk93GGBjNrtuLNkimAc0mnTqxsR42K2PKfH+Ff6B14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zF39tmod; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab78e6edb99so401596966b.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739186674; x=1739791474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeccGsM1J9i+FSRyPdKrrA6cczaJYGA2SpQWOuAJn10=;
        b=zF39tmodbH6MWHrblD6MDfLJyb8o/gF2+i/NdOLLxdgDf/wIwKq+wZ3wcJLtBNp0CP
         jbLXqVkcJ3R0j0GvUZFfw98SJLcW91K8ZdB1Rqh7lebK7gHCeX34/tnwzXjgqFRxDMK6
         kZJcyT0dUjFAqExz2/5rDbuOmO6Ob21hfhVuvpewYbFbLWgR5eBNJCdPB2T9EoKpIBzd
         0iblhkcUz9rz7SemR7zzMJkSRHvoy6hiqmpaFHhKSnof4DWSecekIPVgAelv6Cjh/m/Z
         9eHpFzsYbxnImwenpYohHt/GkraFOroCrpUmAHZlt9uW9KpELbZv9v/dNlAmBx8kIsCV
         VbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186674; x=1739791474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeccGsM1J9i+FSRyPdKrrA6cczaJYGA2SpQWOuAJn10=;
        b=Sbfc6L/IL8EkFP5oh4JE4JiRDreN/JBTMq/Ha8b7Q6Cr+WtRveIsw1DJp8nQT3OPbB
         azZN8yYcVe+EA7XWrFJdVWw6R01HHQqFkbEzS057V9WPYz4GvxhtDKNZ1F1n9RGfZWqn
         wliIynD4+4sTaWL2/hv+OqWCnzprworFbIWggvsKXpjXAPXxjQnBz+C41M09wWTtBp2t
         KEWu2FustRcRVvGKtBtzAeifO8YKhkf/4XqCTKLOJK+jEQyCqBNCeWNNAfQZWh1B0Aih
         yb1eUlKRdbiB8QuT2+WbB99vXwnGDzJHfkDU80Klz0Zs5CYDXeIBhPd0yA7V8ZOy/UjI
         utmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHuSc1mUipe1aLp7zgMt6dTYPooeEmYWpSqVzzs8NwedIN4KQhHaqYAYudJlUpWLDNhpYmsM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRMPNpzWcCN9fFZGSLHH5OWA/rgebBHp3CYLeBYmSdBkLzR0a
	hH83FyJ6/znVwlEsWsZxXdFE6e7d0n/06+RbNpXO3JlDevvZ2j01+ubZN045sz0=
X-Gm-Gg: ASbGncu5U3eFM4S4cYw46A+lRitnbOB+wO3rxYlMMrWge7s8VkbIWudar2LM0PCpWiv
	COwCvyw+CKLqcmbyRb0IT2L8iwMxvGzZP/rc21tbXno/2orUj5kHYW/P0gWMTWKjjQKHPWgKuNt
	i2TMs66JqrjGcpYvtEW+uCjTCbbwtJ1G684jGvTxg158cu+25ttRD9+zaifaJjVrO0bT72uEJF+
	6c9V3AZgMLC4SFVIghYiGYibdEQKqiS6v0/2vW//9Si/VwLlF2TIOIH2ZAEu5WUNXNCo4L5wWgK
	/cjGQeKCmOGtsfVUHserEAP9L1Y92dqsW73hiutD2oQVKQk=
X-Google-Smtp-Source: AGHT+IGgq66U81iP+J9yAhdkX8DCNNRiyyFNHezO+ySzpG7pm4xLBJh18mJVlLkywENiEvG1X55Bgw==
X-Received: by 2002:a17:906:5011:b0:ab7:87ec:79fa with SMTP id a640c23a62f3a-ab789c6d932mr1220682966b.51.1739186673726;
        Mon, 10 Feb 2025 03:24:33 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f893e9sm862826766b.65.2025.02.10.03.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 03:24:33 -0800 (PST)
Message-ID: <dd666dd8-f0a5-42dc-aad6-855b69ccef3c@blackwall.org>
Date: Mon, 10 Feb 2025 13:24:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] vxlan: Join / leave MC group when
 reconfigured
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Roopa Prabhu <roopa@nvidia.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
References: <cover.1738949252.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1738949252.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 19:34, Petr Machata wrote:
> When a vxlan netdevice is brought up, if its default remote is a multicast
> address, the device joins the indicated group.
> 
> Therefore when the multicast remote address changes, the device should
> leave the current group and subscribe to the new one. Similarly when the
> interface used for endpoint communication is changed in a situation when
> multicast remote is configured. This is currently not done.
> 
> Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
> possible that with such fix, the netdevice will end up in an inconsistent
> situation where the old group is not joined anymore, but joining the
> new group fails. Should we join the new group first, and leave the old one
> second, we might end up in the opposite situation, where both groups are
> joined. Undoing any of this during rollback is going to be similarly
> problematic.
> 
> One solution would be to just forbid the change when the netdevice is up.
> However in vnifilter mode, changing the group address is allowed, and these
> problems are simply ignored (see vxlan_vni_update_group()):
> 
>  # ip link add name br up type bridge vlan_filtering 1
>  # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
>  # bridge vni add dev vx1 vni 200 group 224.0.0.1
>  # tcpdump -i lo &
>  # bridge vni add dev vx1 vni 200 group 224.0.0.2
>  18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
>  18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
>  # bridge vni
>  dev               vni                group/remote
>  vx1               200                224.0.0.2
> 
> Having two different modes of operation for conceptually the same interface
> is silly, so in this patchset, just do what the vnifilter code does and
> deal with the errors by crossing fingers real hard.
> 
> Petr Machata (4):
>   vxlan: Join / leave MC group after remote changes
>   selftests: forwarding: lib: Move require_command to net, generalize
>   selftests: test_vxlan_fdb_changelink: Convert to lib.sh
>   selftests: test_vxlan_fdb_changelink: Add a test for MC remote change
> 
>  drivers/net/vxlan/vxlan_core.c                |  15 +++
>  tools/testing/selftests/net/forwarding/lib.sh |  10 --
>  tools/testing/selftests/net/lib.sh            |  19 +++
>  .../net/test_vxlan_fdb_changelink.sh          | 111 ++++++++++++++++--
>  4 files changed, 132 insertions(+), 23 deletions(-)
> 

For the set,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


