Return-Path: <netdev+bounces-118143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D4950BC8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A891C22460
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB61A38C7;
	Tue, 13 Aug 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNpmF0Yn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908C1A2C1E
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571866; cv=none; b=tzySBR7I9Cx8FH2vG6cFXKOfANNtfaPKykvF3EXRouNJsoXwuuoFPJgx6rsSH/YvxAvcBHCS9o01Yzs0QoUk28Fc8CQGV20XTWdkLm09gKu1yMkqjKcTBIzMLoQ/zcItYvUXDfts3Ui7wa86jucX2szPmr+3fdzIzaJTktgbeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571866; c=relaxed/simple;
	bh=SHz1GKFFgb9AaiVx3Pq25pOufSuR0vzRzZy14EXzgo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFQkkkB4kpE7kqZxpTCKUXc/vztvnfda+Xqm2Db8NBxVt4CM4FeRpc56NXSmTjaD74YSata7+lePgS5oiBOt8OwHPkEPzocCNJCoslQkTpzto4HCf4tq8b+gTLDovQIAn+BblSvAH8BDROC/4vZB10j3B8tSGK0BiZwVveuM4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNpmF0Yn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723571863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASoLU8Zhiy9oUF//nHih1NhwKLKsqjXxIcqWYEvihZM=;
	b=BNpmF0YnY02UajItPmHuJJDvwWUqjhhGP+N/ksz/l5JCNlZbpSjf+c85mkULHjBtbG8xTT
	7J7xzTQsQcJlbYpwTi40FOm8iklxDkHUM2zYRWUalejy5oFBu615+S33q1a7u05Y6hpdRg
	CkUNDSDG6B8B0ySJdvQ32pQeScXin6o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-OzjRpjuXO3G3RXWHoR6AaQ-1; Tue,
 13 Aug 2024 13:57:39 -0400
X-MC-Unique: OzjRpjuXO3G3RXWHoR6AaQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CD2B1955F3D;
	Tue, 13 Aug 2024 17:57:37 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.32.254])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A72719773E6;
	Tue, 13 Aug 2024 17:57:33 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  ovs-dev@openvswitch.org,  davem@davemloft.net,  kuba@kernel.org,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B
 Shelar <pshelar@ovn.org>,  Ilya Maximets <i.maximets@ovn.org>,  Florian
 Westphal <fw@strlen.de>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
In-Reply-To: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
	(Xin Long's message of "Mon, 12 Aug 2024 13:17:53 -0400")
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
Date: Tue, 13 Aug 2024 13:57:31 -0400
Message-ID: <f7t34n8cnlg.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Xin Long <lucien.xin@gmail.com> writes:

> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> label counting"), we should also switch to per-action label counting
> in openvswitch conntrack, as Florian suggested.
>
> The difference is that nf_connlabels_get() is called unconditionally
> when creating an ct action in ovs_ct_copy_action(). As with these
> flows:
>
>   table=0,ip,actions=ct(commit,table=1)
>   table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
>
> it needs to make sure the label ext is created in the 1st flow before
> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> be triggered:
>
>    WARN_ON(nf_ct_is_confirmed(ct));
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


