Return-Path: <netdev+bounces-272201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDtYGix8xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:34:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B147033A2A1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45483082A58
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE03A0B1C;
	Thu, 26 Mar 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V46N4N53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8E393DE2;
	Thu, 26 Mar 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549141; cv=none; b=mnt1zxDDytmxZxKCJSOJRK19q7C64XUcdGowFcPdxTlFHXtyWKnNQs9y2YL0rRP6lJxN7sG1ZAkKBnYCUpazbzFNI7QmA8nTkd/NhZDF1fc7FdDpl3tWcdbkRtekLZkvyaSrTQye1cmVk+7Qb5rzNtmyhjj0+z5NwV1D1Dg1KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549141; c=relaxed/simple;
	bh=u7zUb6z4NROc2bFFfdZHwkQz7Cjg2WYcAnQhObyBRB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLzDh+zx2HBzkjKM7Zi+fBmfct6W2mBQIHUcvt4lObTUBMfLX63NiQTYi8bwO6Ypm2vG9WuLYslOGOZT2Mh5kCPmLqZH+4AHcAxwbZQisigK9LHBh/8Awokqi7Md2l8rlE2953tnD9H2gDRhErbT+ARpmxbLoZgdjvs34eETAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V46N4N53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12249C116C6;
	Thu, 26 Mar 2026 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549141;
	bh=u7zUb6z4NROc2bFFfdZHwkQz7Cjg2WYcAnQhObyBRB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V46N4N53AVrLMXSfP1OOHfzXueZY6XDZ2aqkJoCGbkbGcegX4dBKyAOXAbBh6YGnW
	 7zEL4PHWZWl9PWD0RBIo693xUHgieYtF9RKGfcb4swePIRy2tXAsbA2RxVkOhcu2cz
	 QVz/+e/UIC26hDm+DiqzioW20KzTD38aQVPhA3HvAPxff+6Hz7m5JeXEbNLMO7grlB
	 oxmmTbK+61bzlvsSy959Lx91zlGFwC3IAyCWRTSb6VDK8M4dZPwOk7JgS2xhFyob12
	 efz+9F3Gys+dQ7BEgLHyxJe9w1/SgA1kpaQfFxYjX6LroXn/E4y3NV91VPslKgMH5C
	 5RwjPvwg44/jA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 net 04/11] xsk: validate MTU against usable frame
 size on bind
In-Reply-To: <20260326114919.519456-5-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
 <20260326114919.519456-5-maciej.fijalkowski@intel.com>
Date: Thu, 26 Mar 2026 19:18:58 +0100
Message-ID: <87bjgacv3h.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272201-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,all.your.base.are.belong.to.us:mid]
X-Rspamd-Queue-Id: B147033A2A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> AF_XDP bind currently accepts zero-copy pool configurations without
> verifying that the device MTU fits into the usable frame space provided
> by the UMEM chunk.
>
> This becomes a problem since we started to respect tailroom which is
> subtracted from chunk_size (among with headroom). 2k chunk size might
> not provide enough space for standard 1500 MTU, so let us catch such
> settings at bind time. Furthermore, validate whether underlying HW will
> be able to satisfy configured MTU wrt XSK's frame size multiplied by
> supported Rx buffer chain length (that is exposed via
> net_device::xdp_zc_max_segs).
>
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

