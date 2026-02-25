Return-Path: <netdev+bounces-260969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG6oNl0Bn2lAYgQAu9opvQ
	(envelope-from <netdev+bounces-260969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:04:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A231987EB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52500301027B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F563B5311;
	Wed, 25 Feb 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Ecg6bt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvJYm+dR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38D7081E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028251; cv=none; b=L4cOOfbI7G0Hfz5us/j1fDbY/Uy26KAAqEJsMwIWQyI3BHKzOLzhg9BHGNU7LKRDrGE9/cEb98Lp9Ab2w5gvsHH7uheh8p/VXhUt8mn4ZgK95E6ktgdYJoohLhIQBH4ChSIVE96V6plEU5Gwfxtf4jw3Upu+zcZ7CVOdIoV+acY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028251; c=relaxed/simple;
	bh=wOSi5rx6f5nGUdvzxPTXmIrUP9ydcxmZUG6CbYDYbyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeNuwtGwKA6B5m0GysXby9K4gDoG9MlS79yZhqdy74EP+s5/zk1wOfqPCP74u5u/va0/8ahIspqNDvsrV07Uu2u2B/PLaAfWSPvF53uoV1pe+p5A5V+GPjahT5nM0546ZcfU1NSCTxa5YoTMorVY6sUjKNwu737DP46qquWukDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Ecg6bt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvJYm+dR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772028249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tP8jO23/u4UiTgyTAefvEVx29QmJIqpB1z8C2aG2V5g=;
	b=e9Ecg6btWSJ3FLdHlga7YNr3Bu5QKMUqzCb0ADZvXKMZfQ9pcxyXW5GMEqi5IqpbJMXER3
	o3RiIdsOQcCCbwUkJmt9/aWACqP9TNJ0zTnHwCeFk9n7TkzcW+NhBxaUurjhTD59nS5xwD
	lG22Lc0FEXUzrdh10NH1qOE7Y+iZfDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-owSgYUwoPVOUbUE9fPlzPA-1; Wed, 25 Feb 2026 09:04:07 -0500
X-MC-Unique: owSgYUwoPVOUbUE9fPlzPA-1
X-Mimecast-MFC-AGG-ID: owSgYUwoPVOUbUE9fPlzPA_1772028246
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48379489438so79734335e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772028246; x=1772633046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tP8jO23/u4UiTgyTAefvEVx29QmJIqpB1z8C2aG2V5g=;
        b=MvJYm+dR1zRPcZODaicIcyrWXCH34/MCoBWbC3JCrj738cf/K7ceKSleg+EH73aF7s
         GM0qVtx+bLJUlPArxCO4tZshQtsoQ95PAn+YBdIZqmyqiEiANRozlbUnyAgTbTXoIBNl
         1wyGPFa+VVmoinQEN5E0Vgbxn7y1XT+TSlOUHhmEnloHnVoikVkNuid/VcR4FqK1ZH4L
         zTWpnxplhOCLj+/BiK3KuhrianEVY5ZfySjLRx7NWFqsv6t8u/jCOTx6ZKMegMu3ftdF
         sOcrnZvrS6c92iP+XDdCMLzMnOWyvA/vKcpDTyhxVUI/tF7GGD3WYxjTd8srG2Gw+awe
         nWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772028246; x=1772633046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tP8jO23/u4UiTgyTAefvEVx29QmJIqpB1z8C2aG2V5g=;
        b=gHs/Lam10QScPOGPwyAuQUbkkUG68oe5OBMz47ymxBiJWmvBx9Fsf6AC+VOUL7MBPD
         LkWaIMTPGNM+LsncxnUfSCEP/kZ+ju4yB3y8pkx8hCHgnjBldRoAVGj888rsYgC3Vja3
         fwy1u2LS1qfWHIzTrFSXds17OkD6Wmpcnijmq2RaaRdEl1kYIx4jtmizFCV5M8xZk3KO
         E5woU95WXsKyrjnJeIqtwEhEQMqKluUGIuWhDJQAp+kVBefG6DoXJEn/AicSqeDYxm5H
         voeSxWTCBHDEfv8RqJ6fSKZMTvsDN9fazr8n0sHV/FJuBbnPjWN8oCRqJQ5Y4uIzhdAo
         7/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVWIXQnF84nQnj0l0mlBNmPI3GSu1RmVihY+ERBmz6PMr7i9KzjLZhlHdenmJnxNJmZFQjf0os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeh6rJ0Ev2sVBOeqNFCjmTnTHM8PMqdmwTlHQK838Bjyw1Y/0
	PGEOfAz+Z5owECcVDZCaNGAuBOc67tqlyJ/hMpU2YBADc4y/F99FfY3P7F2Ef2M2nlM2I3Nfo0p
	gfV+Hm9aKExn4CPydnQ1NsIiYC4Ok7RLEQhZK1T+luUxETVM/ZsDY91E2rQ==
X-Gm-Gg: ATEYQzyU+A6rgpN2+hBz+W1O9BfSb8riFM5C4tbs0EU8iZaEYesxoECL5QjRTxYTEjZ
	+3C1PbpkKb4WIa3+jVQKa4b/L7rAOzq43gEjUqgSwsvU1IDNj4FyaTWk68n/MAcK29hNLHeY9LO
	uOzE7nifh6wqHcetD47hmTii3fPXOwOszuz1Gh6bqNGxN7MIyl2sJD5QGIWs0s7mDSIunhLIy58
	k7xZWz8AxqsGBL4mGnSJM+OlBElG9lmWQQqSRQ4tVM4liMbbXMhBmHHvnWTBuQbLHnmiEDLZJmI
	DN9s96iz+Dc5wlG7PKkRQwgeg+CkVMDkLwo5peDNnlhppEN0hdoE0p2FJpGmxyaGVZ0jll/+sdB
	AmulmuuqcgeP8Mq85n/7o
X-Received: by 2002:a05:600c:45cc:b0:483:4807:210c with SMTP id 5b1f17b1804b1-483a95f5611mr291247105e9.24.1772028246016;
        Wed, 25 Feb 2026 06:04:06 -0800 (PST)
X-Received: by 2002:a05:600c:45cc:b0:483:4807:210c with SMTP id 5b1f17b1804b1-483a95f5611mr291246375e9.24.1772028245505;
        Wed, 25 Feb 2026 06:04:05 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f2f88sm73743565e9.2.2026.02.25.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:04:04 -0800 (PST)
Date: Wed, 25 Feb 2026 15:04:04 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: ets: fix divide by zero in the offload
 path
Message-ID: <aZ8BVHcOc1xkx8Nd@dcaratti.users.ipa.redhat.com>
References: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
 <CAM0EoMkBsSn_xpdtutUozEQyEjSnhFyf94MHQ6oVLmgGLNyoCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkBsSn_xpdtutUozEQyEjSnhFyf94MHQ6oVLmgGLNyoCA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260969-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59A231987EB
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 08:45:10AM -0500, Jamal Hadi Salim wrote:
> Hi Davide,
> 
> On Tue, Feb 24, 2026 at 3:30 PM Davide Caratti <dcaratti@redhat.com> wrote:
> >
> > Offloading ETS requires computing each class' WRR weight: this is done by
> > averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsigned
> > int, the same integer size as the individual DRR quanta, can overflow and
> > even cause division by zero, like it happened in the following splat:
> >
> 
> Was there a setup/test that resulted in the splat? It would be nice if
> you could document it.
> The fix looks good, so:
> 
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

hi Jamal, thanks for reviewing!

the test is a single line :

# tc qdisc add dev eth0 root ets bands 3 quanta 4294967294 1 1

but to see p_sum = 0 as divisor, eth0 must support offload for TC_SETUP_QDISC_ETS.
I see that netdevsim only supports TAPRIO offload, and I plan to follow-up on
net-next adding support for ETS offload on netdevsim (maybe also other qdiscs
deserve this, just to let syzkaller explore some  "new" areas).

This way, I can write a TDC test-case similar to those we have for taprio
or cake-mq. 

-- 
davide


