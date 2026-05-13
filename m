Return-Path: <netdev+bounces-287350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOKDDZ/AA2or+AEAu9opvQ
	(envelope-from <netdev+bounces-287350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 02:06:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEBD52B7D4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 135C23048AB7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF598BA3D;
	Wed, 13 May 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJeGwkFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC822883F;
	Wed, 13 May 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630812; cv=none; b=lbqpk19EZS5Vg+ynJzPVDQ39+NiqwJxqSbDCIdQiZwHwZP10fgsATtq+TjK73PaidWYtucFYgSV69m+fnBZ4N867WaXy+OPVhIimNBFoCjNCmV363rv4YHW4n42eDIKohkNSLgyi+zPuJnrc2opCBKXFcE2P+UQ+Ugosd5/oiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630812; c=relaxed/simple;
	bh=DToW+fuh/tneKrnx4rW0q0YfbWJJOyE7I2Z47WBrJfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBQZuo/WDhrfdDmWZj+81tukIXDFwJF1R+vwzU+KJ+qnPJjM9BBbxC3zboqmBIY3DTfcdOVB+38CwI+bBLck0AbMHxHN24Rmeq9vsR0I1Z0Tmk8V8rZ5hCqg5i5WAfWWhPnagF/warzosAx8ol/bt+x8srtjRwJcToNh/1CX/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJeGwkFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD61FC2BCB0;
	Wed, 13 May 2026 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630812;
	bh=DToW+fuh/tneKrnx4rW0q0YfbWJJOyE7I2Z47WBrJfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJeGwkFR2zlogn/hZ1XOQ4uz4Y8WCDMCh6CvxcnTAzu0y+FKcgg5jRfLCAaZYGiZs
	 +Pqab1hGRmcMrU+WbWXuatZk1DrLH7lkMWN9nryQTxQxB4ehkogNnof84TqYnp0Wkd
	 tVpPjn+EV6ZtR2KBRd5F+Tbe3we6eJuWGIBF1YcobJczYmAtvD6ihtMjThOT2fs+ks
	 BWjE5pCwcYmxsNzQ7BtejWbiv7YbWGz9ZqYx0917MngaMWTQuFqvf0dqQUDsQ/9CNp
	 dw1EcL/iRqMKw8ld6h2qa3BBA6dd9HEQxiPfY47K3/+N2hnebt2cnYFNk1CBumT7j4
	 6unhEvI29W/eQ==
Date: Tue, 12 May 2026 17:06:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, stable@kernel.org
Subject: Re: [PATCH net 3/3] rxrpc: Fix RESPONSE packet verification to
 extract skb to a linear buffer
Message-ID: <20260512170650.4acfad72@kernel.org>
In-Reply-To: <20260511160753.607296-4-dhowells@redhat.com>
References: <20260511160753.607296-1-dhowells@redhat.com>
	<20260511160753.607296-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BFEBD52B7D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,davemloft.net,google.com,redhat.com,kernel.org,lists.infradead.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-287350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 17:07:49 +0100 David Howells wrote:
> This improves the fix for CVE-2026-43500.
> 
> Fix the verification of RESPONSE packets to avoid the problem of
> overwriting a RESPONSE packet sent via splice to a local address by
> extracting the contents of the UDP packet into a kmalloc'd linear buffer
> rather than decrypting the data in place in the sk_buff (which may corrupt
> the original buffer).

net/rxrpc/conn_event.c:254:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
  254 |                 return ret;
      |                        ^~~
net/rxrpc/conn_event.c:250:9: note: initialize the variable 'ret' to silence this warning
  250 |         int ret;
      |                ^
      |                 = 0

