Return-Path: <netdev+bounces-251903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEPJM4XmcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:45:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A958992
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F2D62BF29
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DDD48C8B2;
	Wed, 21 Jan 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMlHieK+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF11481A88
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003707; cv=none; b=q1xHKIUKOTwEXoksYd8xrHQYnxkR9qEsy9N+/5EXGzADJ3n8CPtsN2yx6sdBT29uNm8fdPR2VtsmcPr+y6oqHhKYl9DbIDKMO747Q1wsCI00y1c2LA2PLF9yz5sGa9KtoDR0hPNo9alBQ6bzMk0fVyTpVYMiBgWOAMLkbx8TqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003707; c=relaxed/simple;
	bh=o9U+KVB4x7Sv6Ufd57BAaWWxbcGxX33ZkaZFfpNPJpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RL6jyXJwIhxOn1F6IDNCQed+v5qT4XNN9Wkf/kaat2DulE/nByuaifIxe393o6s6l86EmQGhi4ykwv/P8ZC7CrDXlpyOIhDxlK0fCyB3yt9FJ4ljp7+shbxPAMtboIopFPBaqM3INv2GQsQ5sBWcACunAUHHIf2tUaHiwIPF5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMlHieK+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769003700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A4//f03SPoGuLjDdJQfWgDwAEuBLW5DTATCH/llYag=;
	b=jMlHieK+ZbpL+1OeYSF3wiuF7ZTCJdPrYI6NCOShCFyph54uUGWFN0LqKmU68qx+reG583
	GqN4prfeofxnlXayFJDy2vE9wz3PmKmGpi6b4Up6iOQ2zGvOaJRQcBiHBVDVV2PPlmmYcq
	YyyQ+j7DxaGgrwn4IwE5b0pZShi4WMI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-bgFHokJwOnOIrUdkZ-ztIg-1; Wed,
 21 Jan 2026 08:54:56 -0500
X-MC-Unique: bgFHokJwOnOIrUdkZ-ztIg-1
X-Mimecast-MFC-AGG-ID: bgFHokJwOnOIrUdkZ-ztIg_1769003695
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D13C41800451;
	Wed, 21 Jan 2026 13:54:54 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01B601800993;
	Wed, 21 Jan 2026 13:54:51 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  wangchuanlei <wangchuanlei@inspur.com>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: openvswitch: fix data race in
 ovs_vport_get_upcall_stats
In-Reply-To: <20260121072932.2360971-1-mmyangfl@gmail.com> (David Yang's
	message of "Wed, 21 Jan 2026 15:29:26 +0800")
References: <20260121072932.2360971-1-mmyangfl@gmail.com>
Date: Wed, 21 Jan 2026 08:54:50 -0500
Message-ID: <f7tzf67vzo5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-251903-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6A2A958992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Yang <mmyangfl@gmail.com> writes:

> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
>
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v1: https://lore.kernel.org/r/20260119181339.1847451-1-mmyangfl@gmail.com
>   - use u64 instead of __u64
>  net/openvswitch/vport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks for the patch - I did a spot-check of the rest of the module with
the following:

  ~/git/linux/net/openvswitch$ grep -nr 'while\(.*fetch.*\)'

and didn't find any other places that seemed to duplicate this
mistaken read pattern (at least in the OVS kernel module).

Reviewed-by: Aaron Conole <aconole@redhat.com>


