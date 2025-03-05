Return-Path: <netdev+bounces-171873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27885A4F2F6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF5D1886789
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617521EB36;
	Wed,  5 Mar 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibYuRDu2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8175FDA7
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135715; cv=none; b=MSAQzAcvzpiUfh6zXDK523QU031l3U+JceYe4R/qoCgFWqtxAhQrR2hb6GzioO1r77m9OuSrvuVmjfDdLQFZk7lTpUqo4EnAVmO/BFwZ6OOwojwjPMn73R2/Can77exGAFPoDz7qETctLpqfdk3j8L128JBvvxVNEDBXP3DHVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135715; c=relaxed/simple;
	bh=c3Yy3nw4QdMzjfWCvdWZuNUP/Ly1yxVElNCRZ8rDRfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuaIa3vxDpzT7FlpzIbv9QnbCegu6hTN9JU7tDFb8RpKP3S9Gpw/kf4o45ATui5VcWY4pbBzEjL8lpM63TSvqKd+ZjuHH7t0cLZlVURsYSUA1TcNVi4korD6QLHC+k+WtYL1VS357Nmq3xLHgO1wkwgeglwm9iXBmBbEvr4QI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibYuRDu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741135709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGOBETMF1iYIsV9XCnrXXWNT5F0G1uXF7Z4J+GjajJs=;
	b=ibYuRDu23B8fhxptY0C9Nmi7pdeqvBIcswgdI6aQJ0lOmOcJMxdLUcDBoUY0o58SVl8zC5
	7DkbwKR3gaIWIMUrwSwLWI43RhafCzkg4SuOXTY+fk9/YlAea5wfL2/EjWOi1cvwO+gVlb
	jwzgPFZT3cqf1t1zzxTCR5CLxMPDWr0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-x0OOr80VOrm1F5oNq6l8GA-1; Tue,
 04 Mar 2025 19:48:19 -0500
X-MC-Unique: x0OOr80VOrm1F5oNq6l8GA-1
X-Mimecast-MFC-AGG-ID: x0OOr80VOrm1F5oNq6l8GA_1741135698
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFB93193578F;
	Wed,  5 Mar 2025 00:48:17 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9AC19560AA;
	Wed,  5 Mar 2025 00:48:14 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski via dev <ovs-dev@openvswitch.org>
Cc: davem@davemloft.net,  Jakub Kicinski <kuba@kernel.org>,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  netdev@vger.kernel.org,  andrew+netdev@lunn.ch,  edumazet@google.com,
  horms@kernel.org,  pabeni@redhat.com,  shuah@kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] selftests: openvswitch: don't
 hardcode the drop reason subsys
In-Reply-To: <20250304180615.945945-1-kuba@kernel.org> (Jakub Kicinski via
	dev's message of "Tue, 4 Mar 2025 10:06:15 -0800")
References: <20250304180615.945945-1-kuba@kernel.org>
Date: Tue, 04 Mar 2025 19:48:12 -0500
Message-ID: <f7tikoo716b.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski via dev <ovs-dev@openvswitch.org> writes:

> WiFi removed one of their subsys entries from drop reasons, in
> commit 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
> SKB_DROP_REASON_SUBSYS_OPENVSWITCH is now 2 not 3.
> The drop reasons are not uAPI, read the correct value
> from debug info.
>
> We need to enable vmlinux BTF, otherwise pahole needs
> a few GB of memory to decode the enum name.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: pshelar@ovn.org
> CC: aconole@redhat.com
> CC: amorenoz@redhat.com
> CC: linux-kselftest@vger.kernel.org
> CC: dev@openvswitch.org
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

Thanks for the fix!

>  tools/testing/selftests/net/config                    |  2 ++
>  .../testing/selftests/net/openvswitch/openvswitch.sh  | 11 ++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 5b9baf708950..3365bcc35304 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -18,6 +18,8 @@ CONFIG_DUMMY=y
>  CONFIG_BRIDGE_VLAN_FILTERING=y
>  CONFIG_BRIDGE=y
>  CONFIG_CRYPTO_CHACHA20POLY1305=m
> +CONFIG_DEBUG_INFO_BTF=y
> +CONFIG_DEBUG_INFO_BTF_MODULES=n
>  CONFIG_VLAN_8021Q=y
>  CONFIG_GENEVE=m
>  CONFIG_IFB=y
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 960e1ab4dd04..3c8d3455d8e7 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -330,6 +330,11 @@ test_psample() {
>  # - drop packets and verify the right drop reason is reported
>  test_drop_reason() {
>  	which perf >/dev/null 2>&1 || return $ksft_skip
> +	which pahole >/dev/null 2>&1 || return $ksft_skip
> +
> +	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
> +			      awk '/OPENVSWITCH/ { print $3; }' |
> +			      tr -d ,)
>  
>  	sbx_add "test_drop_reason" || return $?
>  
> @@ -373,7 +378,7 @@ test_drop_reason() {
>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>  
>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> -	ovs_drop_reason_count 0x30001 # OVS_DROP_FLOW_ACTION
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
>  	if [[ "$?" -ne "2" ]]; then
>  		info "Did not detect expected drops: $?"
>  		return 1
> @@ -390,7 +395,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> -	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit error drops: $?"
>  		return 1
> @@ -398,7 +403,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> -	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
> +	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit drops: $?"
>  		return 1


