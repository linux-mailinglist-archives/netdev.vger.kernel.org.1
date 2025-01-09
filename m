Return-Path: <netdev+bounces-156815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E6A07E4F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6D57A18AD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370F18C93C;
	Thu,  9 Jan 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DufuijEC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85F18732E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442366; cv=none; b=dU3PxuL6rvH3Fn0UQ6yRchZW4zVtikeydCvbSqslkSfHboEspc5OA2+XgrxiM0p/4MY15dFT/52/UvLtKkbsjV1lT/lqwzAXk554U4eGANDR/J8gviTwPCWO6WQd4MBlGHh+05ynU2TA9w7nboG2qHn27Zx57xx0u9gut4S/Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442366; c=relaxed/simple;
	bh=8m5sMg+Beh8VriMOeMof33vSJ9LlGivOddTw9WCsVDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xgrl+A0q+M3qIo3i6JUIEywSjhFCng6SnLXqGC5TWPtSx8TrDynRfy+3KXQhQoadQpop6BDIpuvsNDOB5enQjEEnsKujn3AcfERm3DRIUrFW3giz7Y7zQJuYLsJOT5zCPkm6TOBisq9mAPuMo9NjlWBX4QDYAOkgn5FqIb2Fn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DufuijEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736442361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7pf7Wn2QU28EsfVqjrlZatwpm0zwQpR3UPFPs2QSwc=;
	b=DufuijEC9uxVg7u0hUdCDWVH1KMjaLNm2UGUzzq8k341pHf6tLeoc1/zZ+BK+ozAcwZKID
	pt3tp66It3MiQI8/imr+cAP9rOR4zknt0rmECzqfIfF6RVGjj5+qCDh0lobt5zH/CD8pPX
	z1ZUdDdM28xfbo/g6wAWwpqHvzqhZ+4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-uqKHFhpUMxOemZegN4F9yw-1; Thu,
 09 Jan 2025 12:05:58 -0500
X-MC-Unique: uqKHFhpUMxOemZegN4F9yw-1
X-Mimecast-MFC-AGG-ID: uqKHFhpUMxOemZegN4F9yw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D12991956087;
	Thu,  9 Jan 2025 17:05:55 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B6A19560AB;
	Thu,  9 Jan 2025 17:05:52 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Friedrich Weber
 <f.weber@proxmox.com>,  Luca Czesla <luca.czesla@mail.schwarz>,
  linux-kernel@vger.kernel.org,  Felix Huettner
 <felix.huettner@mail.schwarz>,  Eric Dumazet <edumazet@google.com>,  Simon
 Horman <horms@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: fix lockup on tx to
 unregistering netdev with carrier
In-Reply-To: <20250109122225.4034688-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 9 Jan 2025 13:21:24 +0100")
References: <20250109122225.4034688-1-i.maximets@ovn.org>
Date: Thu, 09 Jan 2025 12:05:51 -0500
Message-ID: <f7to70fq5n4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ilya Maximets <i.maximets@ovn.org> writes:

> Commit in a fixes tag attempted to fix the issue in the following
> sequence of calls:
>
>     do_output
>     -> ovs_vport_send
>        -> dev_queue_xmit
>           -> __dev_queue_xmit
>              -> netdev_core_pick_tx
>                 -> skb_tx_hash
>
> When device is unregistering, the 'dev->real_num_tx_queues' goes to
> zero and the 'while (unlikely(hash >= qcount))' loop inside the
> 'skb_tx_hash' becomes infinite, locking up the core forever.
>
> But unfortunately, checking just the carrier status is not enough to
> fix the issue, because some devices may still be in unregistering
> state while reporting carrier status OK.
>
> One example of such device is a net/dummy.  It sets carrier ON
> on start, but it doesn't implement .ndo_stop to set the carrier off.
> And it makes sense, because dummy doesn't really have a carrier.
> Therefore, while this device is unregistering, it's still easy to hit
> the infinite loop in the skb_tx_hash() from the OVS datapath.  There
> might be other drivers that do the same, but dummy by itself is
> important for the OVS ecosystem, because it is frequently used as a
> packet sink for tcpdump while debugging OVS deployments.  And when the
> issue is hit, the only way to recover is to reboot.
>
> Fix that by also checking if the device is running.  The running
> state is handled by the net core during unregistering, so it covers
> unregistering case better, and we don't really need to send packets
> to devices that are not running anyway.
>
> While only checking the running state might be enough, the carrier
> check is preserved.  The running and the carrier states seem disjoined
> throughout the code and different drivers.  And other core functions
> like __dev_direct_xmit() check both before attempting to transmit
> a packet.  So, it seems safer to check both flags in OVS as well.
>
> Fixes: 066b86787fa3 ("net: openvswitch: fix race on port output")
> Reported-by: Friedrich Weber <f.weber@proxmox.com>
> Closes: https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 16e260014684..704c858cf209 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -934,7 +934,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
>  {
>  	struct vport *vport = ovs_vport_rcu(dp, out_port);
>  
> -	if (likely(vport && netif_carrier_ok(vport->dev))) {
> +	if (likely(vport &&
> +		   netif_running(vport->dev) &&
> +		   netif_carrier_ok(vport->dev))) {
>  		u16 mru = OVS_CB(skb)->mru;
>  		u32 cutlen = OVS_CB(skb)->cutlen;

Reviewed-by: Aaron Conole <aconole@redhat.com>

I tried on with my VMs to reproduce the issue as described in the email
report, but I probably didn't give enough resources (or gave too many
resources) to get the race condition to bubble up.  I was using kernel
6.13-rc5 (0bc21e701a6f) also.

In any case, I think the change makes sense.


