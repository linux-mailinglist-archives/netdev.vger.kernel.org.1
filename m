Return-Path: <netdev+bounces-294810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tARLFZtLIGoG0gAAu9opvQ
	(envelope-from <netdev+bounces-294810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0763956F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:43:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RZFBe51C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B08331B65D7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD163C8723;
	Wed,  3 Jun 2026 15:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB33CDBAA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:21:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500113; cv=none; b=Ox9H2A+vfIfA7+dsHrYnQUqfbWrpMkoCLit/jphU0AzEjLbeQDLiO46mfbHJwaA9aIEjKKDTtPOoxhPxZOPmF6e1CRx8CIga75J4zUJHUYGloKKvLzDkx+nazTuFedgNS+eijmx81Bj0HjOce2aoshbavnBWbakHP+KU/6BJfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500113; c=relaxed/simple;
	bh=KKAucUBkHY0tTSDXi4Td41cnRpfz9ia0z+XaDJ0hHk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shIWgSMsWOnBgxI6VFLpehADlzw64LMOxtrvsejBS6DX0YIy3jH6MlApaLAcpXihokcYZkIGFA3VghtaAe/xR5Nla1R5nYvfDHy/9dl1yWWaMqNvPNNkj/TaG+682q7ROO1kFevsXjrnTIKhTqP05yddrZln9gdOWWtN5htCLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZFBe51C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8534A1F00893;
	Wed,  3 Jun 2026 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500112;
	bh=9GqcHWgkqcaxttl6OzG4CHcmpMvi1/Kp1c0NCL+PUtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZFBe51CkvEamG812ZXUhWKLg9RaZTrCFxskTA00Ct9kE2DrlpPavoG3xVUaA20Dm
	 NgQSKIvfkFOSgsxCajrBtopOAb1kUAg+yKlJ0bBV6BHdhZ0hAAXhx2NWw1DYyXExOx
	 lqopVfUHH+GNCwtIOXrSQs1Ij1YOKef0QcuGaOHsLSC9IqJ7kDX8GoKo+Zqpe+Cq4P
	 4PDYCEE9/yXsQSofz7Jl4mW7P9tjOksfVlumkBlFvbqVbPuo0RII0AeRSzvPtO/zhW
	 k88dygV/8FNmI8Fu6wIdVnN1Yak0VJb89HD7L5mFQzHhJFO0S8CfK2nJMRIeBbn2zu
	 q4A4h54bECYdw==
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Wed,  3 Jun 2026 16:21:34 +0100
Message-ID: <20260603152134.3794913-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529075147.88398-2-mengyuanlou@net-swift.com>
References: <20260529075147.88398-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294810-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50A0763956F

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: net: libwx: add support for set_ringparam in wx_ethtool_ops_vf

This commit adds support for the set_ringparam ethtool operation in 
wx_ethtool_ops_vf, enabling ring size configuration for ngbevf and txgbevf.
It also modifies wx_set_ring() to return an error code instead of void to
propagate allocation failures.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index d042567b81284..2e5dba88d04a1 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
[ ... ]
> @@ -3248,8 +3248,8 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(wx_features_check);
>  
> -void wx_set_ring(struct wx *wx, u32 new_tx_count,
> -		 u32 new_rx_count, struct wx_ring *temp_ring)
> +int wx_set_ring(struct wx *wx, u32 new_tx_count,
> +		u32 new_rx_count, struct wx_ring *temp_ring)

[Severity: High]
Since the return type of wx_set_ring() was changed to propagate errors, do 
existing callers in txgbe and ngbe need to be updated to check this return 
value? 

If they still ignore the return value, an allocation failure will silently 
leave userspace thinking the operation succeeded.

>  {
>  	int i, err = 0;
>  
[ ... ]
> @@ -3299,7 +3299,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
>  					i--;
>  					wx_free_rx_resources(&temp_ring[i]);
>  				}
> -				return;
> +				return err;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this break configuration 
atomicity?

If wx_setup_rx_resources() fails here, the TX ring changes were already 
committed and old TX resources freed earlier in this function. This leaves 
the device in a partially updated state with the new TX ring size but the 
old RX ring size, rather than cleanly rolling back the entire ethtool 
operation.

[Severity: High]
This is also a pre-existing issue, but does this error path free 
uninitialized pointers? 

The temp_ring array is created via a shallow memcpy from the old ring, 
inheriting the old next_to_alloc index. Since wx_setup_rx_resources() 
allocates rx_buffer_info via kvmalloc (which doesn't zero memory) and 
doesn't reset next_to_alloc, wx_free_rx_resources() will call 
wx_clean_rx_ring() which iterates up to the inherited next_to_alloc index.

Will this pass uninitialized garbage pointers to dev_kfree_skb() and 
page_pool_put_full_page(), potentially causing a kernel panic?

>  			}
>  		}
>  
[ ... ]

