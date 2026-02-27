Return-Path: <netdev+bounces-261681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJf8OG8CoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:33:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 525441B211F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89B0300C00D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A442777F3;
	Fri, 27 Feb 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0tnKHDv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76820468E;
	Fri, 27 Feb 2026 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159525; cv=none; b=GydsUWcnDIPlIwTgyBDAqJXfoo0G3M+/qUjNf5DjA7zaN7vOBQTsC2Ftlki657+d8gnkbYg7uWDomMOMexp7eu5ytN7Z0hT6dDZcqP02VLsv/m6fSmf0hxjeq3nrbo1pHPN602EVJvccJL02onn7r7pnTPTtAbqaTdMgP7C+0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159525; c=relaxed/simple;
	bh=WVdflQPkcOnbCuaSo6d2/GAGYClxUgm83n9ew4xrfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvnNhFyJ2PjLWFMtsUT973JfQ+4Y5GGIRizPKahbZ2yaQFCm6fpBoaBbhLkEzerJ1TB8xbTIIYE/2oJibHVG36nk9qit8BT0wz5UCZIY0cZJs24JxtJGk5DQsZONHWnzHrKL/aLorhQohgB+n8bbXxk26/Z0C8NIhwhnwL/Cql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0tnKHDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B61C116C6;
	Fri, 27 Feb 2026 02:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772159524;
	bh=WVdflQPkcOnbCuaSo6d2/GAGYClxUgm83n9ew4xrfe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0tnKHDvZb27MgZ1Wg+6JBOhJLWZ7RSeRZeMXQEizkm3oeDkOZwz2EdGyUX6wJu5F
	 wFelC20erRiTYWRm3N3pOptUVk8Eoawm1skQMpHDJq/VdQvRVH6pViG7g5emr1vKgJ
	 gpB1EDl+Bo/wNpsGQCYyWtanDmkXx6yMked1MuYYcOxmgsWAY1Xo0fk7lxof9NP34r
	 6pNsIVSvApMaD2TPEKeTrPSTcOUzbGo1kUD+cLtqmTG2RwT5jfF2zs1cz5RpgUC2Xx
	 MDaE/4QpgpWklFT47p/H9iMod2AdDmb8pS01ZTit6D+5JXPL29tBg8FtnLkYPG8cHS
	 LxQ8gq/m3vXKA==
Date: Thu, 26 Feb 2026 18:32:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert
 Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: Re: [net-next v31 1/2] mailbox: pcc: functions for reading and
 writing PCC extended data
Message-ID: <20260226183203.4a1d808d@kernel.org>
In-Reply-To: <20260224231055.393329-2-admiyo@os.amperecomputing.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
	<20260224231055.393329-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261681-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,vger.kernel.org,codeconstruct.com.au,davemloft.net,google.com,redhat.com,arm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 525441B211F
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 18:10:51 -0500 Adam Young wrote:
> Adds functions that aid in compliance with the PCC protocol by
> checking the command complete flag status.
> 
> Adds a function that exposes the size of the shared buffer without
> activating the channel.
> 
> Adds a function that allows a client to query the number of bytes
> avaialbel to read in order to preallocate buffers for reading.

All the kdoc you're adding is misformatted, please run
./scripts/kernel-doc -Wall -none to error check

Please look around the kernel to see how well written kdoc looks like
-- 
pw-bot: cr

