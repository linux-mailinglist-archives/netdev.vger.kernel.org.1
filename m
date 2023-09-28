Return-Path: <netdev+bounces-36892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711D7B2130
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3791EB20C2B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF94F127;
	Thu, 28 Sep 2023 15:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DA38DF9
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:26:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB6AC
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695914786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5oWc884onPqzAbZ7aj2bLZwV3NwED8Rg943IUFuX4U=;
	b=DLEf2k4IXvJOWeG9NRaA2y0zv1YCGOCbXmXqetJN+g7yekhIFr/J1D7dxG+S1OTZgSnr7G
	H3+Etr+e1J9NdbGBrRFl/WXkHrlwpli2zI2vw5FwCA/7/M2k6a0zuxtMt4QRpIC6fPf6l1
	7yTCvqYZuknZbAq8D1vCVp+Ca5uvGnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-ZsW6DMDvM5uCPKEPkVeR8w-1; Thu, 28 Sep 2023 11:26:22 -0400
X-MC-Unique: ZsW6DMDvM5uCPKEPkVeR8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EAFF8039C1;
	Thu, 28 Sep 2023 15:26:22 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36D8514171B6;
	Thu, 28 Sep 2023 15:26:22 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org, Ilya Maximets
 <imaximet@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Flavio
 Leitner <fbl@redhat.com>
Subject: Re: [ovs-dev] [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive
 reduce stack usage
References: <20230927001308.749910-1-npiggin@gmail.com>
	<20230927001308.749910-5-npiggin@gmail.com>
Date: Thu, 28 Sep 2023 11:26:21 -0400
In-Reply-To: <20230927001308.749910-5-npiggin@gmail.com> (Nicholas Piggin's
	message of "Wed, 27 Sep 2023 10:13:05 +1000")
Message-ID: <f7tfs2ymi8y.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nicholas Piggin <npiggin@gmail.com> writes:

> Dynamically allocating the sw_flow_key reduces stack usage of
> ovs_vport_receive from 544 bytes to 64 bytes at the cost of
> another GFP_ATOMIC allocation in the receive path.
>
> XXX: is this a problem with memory reserves if ovs is in a
> memory reclaim path, or since we have a skb allocated, is it
> okay to use some GFP_ATOMIC reserves?
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

This represents a fairly large performance hit.  Just my own quick
testing on a system using two netns, iperf3, and simple forwarding rules
shows between 2.5% and 4% performance reduction on x86-64.  Note that it
is a simple case, and doesn't involve a more involved scenario like
multiple bridges, tunnels, and internal ports.  I suspect such cases
will see even bigger hit.

I don't know the impact of the other changes, but just an FYI that the
performance impact of this change is extremely noticeable on x86
platform.

----
ip netns add left
ip netns add right

ip link add eth0 type veth peer name l0
ip link set eth0 netns left
ip netns exec left ip addr add 172.31.110.1/24 dev eth0
ip netns exec left ip link set eth0 up
ip link set l0 up

ip link add eth0 type veth peer name r0
ip link set eth0 netns right
ip netns exec right ip addr add 172.31.110.2/24 dev eth0
ip netns exec right ip link set eth0 up
ip link set r0 up

python3 ovs-dpctl.py add-dp br0
python3 ovs-dpctl.py add-if br0 l0
python3 ovs-dpctl.py add-if br0 r0

python3 ovs-dpctl.py add-flow \
  br0 'in_port(1),eth(),eth_type(0x806),arp()' 2
  
python3 ovs-dpctl.py add-flow \
  br0 'in_port(2),eth(),eth_type(0x806),arp()' 1

python3 ovs-dpctl.py add-flow \
  br0 'in_port(1),eth(),eth_type(0x800),ipv4()' 2

python3 ovs-dpctl.py add-flow \
  br0 'in_port(2),eth(),eth_type(0x800),ipv4()' 1

----

ex results without this patch:
[root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172.31.110.1
...
[  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  46.7 GBytes  40.2 Gbits/sec                  receiver


ex results with this patch:
[root@wsfd-netdev60 ~]# ip netns exec right ./git/iperf/src/iperf3 -c 172.31.110.1
...
[  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec    0             sender
[  5]   0.00-10.00  sec  44.9 GBytes  38.6 Gbits/sec                  receiver

I did testing with udp at various bandwidths and this tcp testing.

>  net/openvswitch/vport.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 972ae01a70f7..ddba3e00832b 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -494,9 +494,13 @@ u32 ovs_vport_find_upcall_portid(const struct vport *vport,
>  int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>  		      const struct ip_tunnel_info *tun_info)
>  {
> -	struct sw_flow_key key;
> +	struct sw_flow_key *key;
>  	int error;
>  
> +	key = kmalloc(sizeof(*key), GFP_ATOMIC);
> +	if (!key)
> +		return -ENOMEM;
> +
>  	OVS_CB(skb)->input_vport = vport;
>  	OVS_CB(skb)->mru = 0;
>  	OVS_CB(skb)->cutlen = 0;
> @@ -510,12 +514,16 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>  	}
>  
>  	/* Extract flow from 'skb' into 'key'. */
> -	error = ovs_flow_key_extract(tun_info, skb, &key);
> +	error = ovs_flow_key_extract(tun_info, skb, key);
>  	if (unlikely(error)) {
>  		kfree_skb(skb);
> +		kfree(key);
>  		return error;
>  	}
> -	ovs_dp_process_packet(skb, &key);
> +	ovs_dp_process_packet(skb, key);
> +
> +	kfree(key);
> +
>  	return 0;
>  }


