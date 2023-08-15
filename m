Return-Path: <netdev+bounces-27676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560E77CCD2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2971C20D0D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9A1111A0;
	Tue, 15 Aug 2023 12:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEB4CA5B
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:41:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6DF1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692103313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0lJ2vuAEwZYUtcg52X0lzmwo7LsDOCNc8rcgoSzWH8=;
	b=RWtSpsdF6XefPZbzThpqcvk7jLyQBATAKXFSpQhu7ueZr77hsNMPeJcNLsJ0H/RTOMFO5h
	rVCXdy95F8l4VOqHeVjq5jrU0LlbrkbashtOjAcoxTMQJ0T6qGmQ0J7jLw7ag74B1YSnkE
	/2o1s2yt7hKrAr3NzCchG6XC87A9nTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-86WRupqXPA2yf6LwsKrePg-1; Tue, 15 Aug 2023 08:41:51 -0400
X-MC-Unique: 86WRupqXPA2yf6LwsKrePg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57972185A791;
	Tue, 15 Aug 2023 12:41:51 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.9.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6C42026D4B;
	Tue, 15 Aug 2023 12:41:50 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  andrey.zhadchenko@virtuozzo.com,
  dev@openvswitch.org,  brauner@kernel.org,  netdev@vger.kernel.org,
  edumazet@google.com,  pabeni@redhat.com,
  syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: reject negative ifindex
References: <20230814203840.2908710-1-kuba@kernel.org>
Date: Tue, 15 Aug 2023 08:41:50 -0400
In-Reply-To: <20230814203840.2908710-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Aug 2023 13:38:40 -0700")
Message-ID: <f7t1qg4zddd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Recent changes in net-next (commit 759ab1edb56c ("net: store netdevs
> in an xarray")) refactored the handling of pre-assigned ifindexes
> and let syzbot surface a latent problem in ovs. ovs does not validate
> ifindex, making it possible to create netdev ports with negative
> ifindex values. It's easy to repro with YNL:
>
> $ ./cli.py --spec netlink/specs/ovs_datapath.yaml \
>          --do new \
> 	 --json '{"upcall-pid": 1, "name":"my-dp"}'
> $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> 	 --do new \
> 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
>
> $ ip link show
> -65536: some-port0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 7a:48:21:ad:0b:fb brd ff:ff:ff:ff:ff:ff
> ...
>
> Validate the inputes. Now the second command correctly returns:

s/inputes/inputs/

>
> $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> 	 --do new \
> 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
>
> lib.ynl.NlError: Netlink error: Numerical result out of range
> nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
> 	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}
>
> Accept 0 since it used to be silently ignored.
>
> Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
> Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: pshelar@ovn.org
> CC: andrey.zhadchenko@virtuozzo.com
> CC: brauner@kernel.org
> CC: dev@openvswitch.org
> ---

Thanks for the quick follow up.  I accidentally broke my system trying
to setup to reproduce the syzbot splat.

The attribute here isn't used by the ovs-vswitchd, so probably why we
never caught an issue before.  I'll think about how to improve the
fuzzing on the ovs module.  At the very least, maybe we can have some
additional checks in the netlink selftest.

I noticed that since I copied the definitions when building
ovs-dpctl.py, I have the same kind of mistake there (using unsigned for
ifindex).  I can submit a follow up to correct that definition.  Also,
we might consider correcting the yaml.

For the main change:

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  net/openvswitch/datapath.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index a6d2a0b1aa21..3d7a91e64c88 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1829,7 +1829,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  	parms.port_no = OVSP_LOCAL;
>  	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
>  	parms.desired_ifindex = a[OVS_DP_ATTR_IFINDEX]
> -		? nla_get_u32(a[OVS_DP_ATTR_IFINDEX]) : 0;
> +		? nla_get_s32(a[OVS_DP_ATTR_IFINDEX]) : 0;
>  
>  	/* So far only local changes have been made, now need the lock. */
>  	ovs_lock();
> @@ -2049,7 +2049,7 @@ static const struct nla_policy datapath_policy[OVS_DP_ATTR_MAX + 1] = {
>  	[OVS_DP_ATTR_USER_FEATURES] = { .type = NLA_U32 },
>  	[OVS_DP_ATTR_MASKS_CACHE_SIZE] =  NLA_POLICY_RANGE(NLA_U32, 0,
>  		PCPU_MIN_UNIT_SIZE / sizeof(struct mask_cache_entry)),
> -	[OVS_DP_ATTR_IFINDEX] = {.type = NLA_U32 },
> +	[OVS_DP_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
>  };
>  
>  static const struct genl_small_ops dp_datapath_genl_ops[] = {
> @@ -2302,7 +2302,7 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  	parms.port_no = port_no;
>  	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
>  	parms.desired_ifindex = a[OVS_VPORT_ATTR_IFINDEX]
> -		? nla_get_u32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
> +		? nla_get_s32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
>  
>  	vport = new_vport(&parms);
>  	err = PTR_ERR(vport);
> @@ -2539,7 +2539,7 @@ static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
>  	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
>  	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
>  	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
> -	[OVS_VPORT_ATTR_IFINDEX] = { .type = NLA_U32 },
> +	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
>  	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },
>  	[OVS_VPORT_ATTR_UPCALL_STATS] = { .type = NLA_NESTED },
>  };


