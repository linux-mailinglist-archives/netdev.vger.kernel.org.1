Return-Path: <netdev+bounces-289307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBBtMLoTDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:39:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366A5793AD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704273030F79
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E763DA7F2;
	Tue, 19 May 2026 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lFwn1/sp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwF1wxRb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lFwn1/sp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwF1wxRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799423D9025
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176155; cv=none; b=BwMDKsyDTTXTNdH3qE05weWNNQ+CZUjXBoJzG1OCstX8at53I6sWHgLtFGRWKPm+e/SQR7j9g12g3JkbMuORU8FfwwSmp1XW13AzNUR6jvlGLetDZ6eltivhOLa0r78hTyG6bW9FIsMQRMU1fIXd6YyUH9qo72+hbuDhlPFnOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176155; c=relaxed/simple;
	bh=BBEaOE2kSFjEO1HfHPLWHbqdDf4bwILqH4Cd4p7Q2KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbhmuamLEdxhljdoLf5pG9ufeGNO5MiRPoh/HbhYOCmDZPuMPmDdoXQogtWB+nIvBn05DvZfiBvMTIBQGkyvJZAnQqcb3+CkS3HJ5H+C3rHIDWLpqpSgNt8F8EpHbPj9YpP7GJlIDCoUBFICtUog1NVumAto+a+ZjXd2tzoVlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lFwn1/sp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bwF1wxRb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lFwn1/sp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bwF1wxRb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51C726702B;
	Tue, 19 May 2026 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFureT96pnOMvipUwq84ExskMrDl8S0Pk11p8gNk27I=;
	b=lFwn1/spHRGg5snk0GjMtxyBFHidkqMIsLmPKmij4pgmcXPcsvvftXQiBKfvnY5xBIDY0d
	E4nYK7I5Eg45QaDvxk0VG87KeiZDOfqHZt6ofH8lhCU80VI9N7sfCagN6V5slcrhWd5Zqy
	YQUotrdVcLKqBnANwdbGBv8CGzqdiic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFureT96pnOMvipUwq84ExskMrDl8S0Pk11p8gNk27I=;
	b=bwF1wxRb/EfE+5qM9h7pVYf0e/nll8rZTeoW69m2HJqVFjztWQRBgLR/Lb43U0iIe+wOCt
	aVXk7N4Ho+RN9kBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFureT96pnOMvipUwq84ExskMrDl8S0Pk11p8gNk27I=;
	b=lFwn1/spHRGg5snk0GjMtxyBFHidkqMIsLmPKmij4pgmcXPcsvvftXQiBKfvnY5xBIDY0d
	E4nYK7I5Eg45QaDvxk0VG87KeiZDOfqHZt6ofH8lhCU80VI9N7sfCagN6V5slcrhWd5Zqy
	YQUotrdVcLKqBnANwdbGBv8CGzqdiic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFureT96pnOMvipUwq84ExskMrDl8S0Pk11p8gNk27I=;
	b=bwF1wxRb/EfE+5qM9h7pVYf0e/nll8rZTeoW69m2HJqVFjztWQRBgLR/Lb43U0iIe+wOCt
	aVXk7N4Ho+RN9kBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E4FA593A8;
	Tue, 19 May 2026 07:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jhrOCsoSDGrhVgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:35:38 +0000
Message-ID: <8d6f65a0-408a-479e-a2c6-054e1aa54c39@suse.de>
Date: Tue, 19 May 2026 09:35:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/7] nvme-tcp: store negative errno in queue->tls_err
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289307-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 4366A5793AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
> ENOKEY lookup failure and the EOPNOTSUPP initializer both store
> negative errnos.  The third branch, reached when the handshake
> layer reports a non-zero status, stores -status.
> 
> The handshake layer delivers status to the consumer callback as a
> negative errno; the other in-tree consumers --
> xs_tls_handshake_done() and the nvmet target callback -- treat
> their status argument that way.  The extra negation in
> nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
> value (for instance, +EIO), which nvme_tcp_start_tls() then
> returns to its caller.
> 
> Drop the extra negation so queue->tls_err uniformly carries a
> negative errno on failure.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

