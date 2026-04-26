Return-Path: <netdev+bounces-281138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKoIKjXP7WmwnwAAu9opvQ
	(envelope-from <netdev+bounces-281138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44C469192
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D88A130039A4
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC4342C98;
	Sun, 26 Apr 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAdai5SP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1235F163;
	Sun, 26 Apr 2026 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192725; cv=none; b=N11vCrJT5owaWJ4KNBfhTGqWUVFHQ3yK8wl9cQ8QAWr7TucPV1BB2tvD6fWWdp56cyILeZzqI7AbkA3FbN6LGbaB+nLBbWrxDjaKqYIjCqO/Rj/AgtAoz7KkzGtrW8mHU03Z/H6qpMtfBpS9KF7Yf0u+Rycyjp73ILpT7hibgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192725; c=relaxed/simple;
	bh=DEuZxGDNoS/k0saZtUFGUorqUMXbG93zLkf9V7GuWqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/ma9Fhvp402h4Bz4Ah7/O8fDiKSIk9eKPov78jLaB69OkOuZnv5e5YER+6b6sYKaLR9sonFE9udmaq9AP3vU9NZ8ndqKTt+pdiBD8RwIxwN9CnVg3p+PGLm6hsuD2pJnEze8F0xtM+DE3d7smCe/XUf3wSe434UaYcemWz3TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAdai5SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A65C2BCAF;
	Sun, 26 Apr 2026 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192725;
	bh=DEuZxGDNoS/k0saZtUFGUorqUMXbG93zLkf9V7GuWqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAdai5SPHAGENTMNoAMdoe0RfuMRqVLvf/ifupj1B3NMlZzvAKt96SzVW/obS2tGC
	 NzgfFCT0HFxrlPtwzXamUvVnIhRIiChDrIepuF9RIMHSSkaUqp7nON1L022pf2e/Hu
	 h/pzvSjtyZ13gOOp9VqovOmt1uPrjyCOIbwJtHRFR13pPP+v2DJPdgi8FzvBHDMW4r
	 NMCsP5DVWZ+5nxfEaLbUBoMwBv7QOvLPfHZp9NFplLaVzMXveKXYRDq6asy6yPPDzN
	 PLOp1YBZkNH/zMdiwjnPrpxhoP2Fd2C6ncGzymM2WQIFAyiqeHQKkGnTAaneGQ+0La
	 XNqMNgxb1w1Dw==
From: Simon Horman <horms@kernel.org>
To: leitao@debian.org
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	k-keiichi@bx.jp.nec.com,
	satyam@infradead.org,
	akpm@linux-foundation.org,
	thepacketgeek@gmail.com,
	asantostc@gmail.com,
	gustavold@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net 2/3] netconsole: avoid clobbering userdatum value on truncated write
Date: Sun, 26 Apr 2026 09:35:16 +0100
Message-ID: <20260426083515.1127542-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423-netconsole_ai_fixes-v1-2-92b8b7de9a2c@debian.org>
References: <20260423-netconsole_ai_fixes-v1-2-92b8b7de9a2c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F44C469192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-281138-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
netconsole: avoid clobbering userdatum value on truncated write

This patch tightens the boundary check on userdatum values to prevent
strscpy() from returning -E2BIG and leaving a truncated string in udm->value.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 5713cb3783ef2..4bef003d9df64 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1074,7 +1074,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
>  	struct userdata *ud;
>  	ssize_t ret;
>  
> -	if (count > MAX_EXTRADATA_VALUE_LEN)
> +	if (count >= MAX_EXTRADATA_VALUE_LEN)
>  		return -EMSGSIZE;
>  
>  	mutex_lock(&netconsole_subsys.su_mutex);

This patch addresses the state corruption caused by strscpy() failing, but does
this fully resolve the issue?

The commit message notes that returning an error after modifying udm->value
leaves the internal state out of sync until the next write. Looking slightly
further down in userdatum_value_store():

userdatum_value_store() {
        ...
        ret = strscpy(udm->value, buf, sizeof(udm->value));
        if (ret < 0)
                goto out_unlock;
        trim_newline(udm->value, sizeof(udm->value));

        ud = to_userdata(item->ci_parent);
        nt = userdata_to_target(ud);
        ret = update_userdata(nt);
        if (ret < 0)
                goto out_unlock;
        ...
}

If update_userdata() fails, the function jumps to out_unlock and returns an
error to userspace. Since udm->value has already been updated with the new
string, the next successful write to any entry on this target will unknowingly
pack this new value into the payload, recreating the same deferred-activation
issue.

This isn't a bug introduced by this patch, but does trim_newline() handle
empty strings correctly?

If userspace writes a single NUL byte, strscpy() will successfully copy it and
return 0. Inside trim_newline(), strnlen() would evaluate to 0.

The subsequent check for a newline character would evaluate s[-1]. If the byte
located immediately before the buffer happens to be a newline character, it
would be overwritten with a NUL byte.

