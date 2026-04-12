Return-Path: <netdev+bounces-277873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAzmLPvo22laIgkAu9opvQ
	(envelope-from <netdev+bounces-277873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AAD3E57FC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA643009CD3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9873002A0;
	Sun, 12 Apr 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc8aRcGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5591862;
	Sun, 12 Apr 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019603; cv=none; b=J7aCUYAP3WQskrHTyLhwafgGIfzjdBLq5195RHWGs/4jpuR9XKPDWq4UYCLcPwwhXM7Vm1Hm133FnaFGut3Gkllh1dwYF375Pk5Q1qDdz2Li2PKr3gtFAfWLJRNV2pAsKwAoIAOJwCP9O2OHGTN7G1iyZH5w5Jf6/AxfE7GHbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019603; c=relaxed/simple;
	bh=bmblPM62MFAHX2Ssa/u7FDD46Gbw/gjHVd/nq8Qzu0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrEb7Kkmkywv7XXPD3QF5Tiqdciy0CwovuDrRUpL+wZliBikQ0ZSQmq9Tg/bQKb/LlrtU0K/oWdVc5TPHXc1maFFz9++ZiBXniDmzCBJzKwDY20f8DJqQ+UmDxde/3JzBRUzNUF8cipm5uQUFdmMIQiUQH4U4P9oCfs3kdf6XJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc8aRcGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC3C19424;
	Sun, 12 Apr 2026 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019603;
	bh=bmblPM62MFAHX2Ssa/u7FDD46Gbw/gjHVd/nq8Qzu0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tc8aRcGJiedJrMoAjylE7rizetPjw8Uuod5uSh5PfInfw96RIxkxGtsEKWMQiBjSM
	 h65t+A7KwwC61lg3wrn0H1MyWsCgbt4iRoHfNT6N0qkIEnKkiTehlx6X+1vuTJiTFs
	 UhZKbr2egfnaotVL2ybPa12M+/hOmzHJJOmJ9x3mB32yFyuqAFiziu0RUYU3QEkdJo
	 Jq/OEnxyU2sz5WB79F1PCcvWbLDHjFGYK1Ui8Z5vws2q8yIGc6Sbarytuw6pgQJ4dQ
	 8aCVqbwvuSQUoqi0ZsjZOLRxlxxXsWFyYZ9PVqnEiMIZBIoZHIC7yO1k26pE3OKXZH
	 o/k3uH4VLwjMw==
Date: Sun, 12 Apr 2026 11:46:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kees Cook
 <kees@kernel.org>, Thierry Escande <thierry.escande@linux.intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>, stable <stable@kernel.org>
Subject: Re: [PATCH net 2/2] NFC: digital: Bounds check Felica response
 before sensf_res memcpy
Message-ID: <20260412114641.63024b4c@kernel.org>
In-Reply-To: <2026040913-rearrange-unseeing-fa85@gregkh>
References: <2026040913-figure-seducing-bd3f@gregkh>
	<2026040913-rearrange-unseeing-fa85@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277873-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11AAD3E57FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 17:18:15 +0200 Greg Kroah-Hartman wrote:
> A malicious NFC peer can send a SENSF_RES that is longer than the
> NFC_SENSF_RES_MAXSIZE (18 byte) sensf_res field in the onstack struct
> nfc_target.  digital_in_recv_sensf_res() validates that the response is
> at least DIGITAL_SENSF_RES_MIN_LENGTH bytes but applies no upper bound
> before memcpy(target.sensf_res, sensf_res, resp->len) is called,
> allowing a stack buffer overflow with attacker-controlled length and
> content.
> 
> Commit e329e71013c9 ("NFC: nci: Bounds check struct nfc_target arrays")
> fixed identical missing checks for the same target->sensf_res field on
> the NCI path; the Digital Protocol path was never patched.
> 
> Fix this all up by just rejecting responses that exceed
> NFC_SENSF_RES_MAXSIZE.

This driver's local definition of the sensf_res struct seems to 
be larger than NFC_SENSF_RES_MAXSIZE. Something is off here.

