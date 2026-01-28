Return-Path: <netdev+bounces-254082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bQBlF8N6eWlbxQEAu9opvQ
	(envelope-from <netdev+bounces-254082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:56:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827309C6F4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFF6300AB1F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82335250BF2;
	Wed, 28 Jan 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDhdNG6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7D1F95C
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568960; cv=none; b=L8WsG94fni2EYgHTXU8nP3cL9Zvl7bpE386wI/Go550ssAOwv/Dz55yKevDiV4bTsHXm3HvmBiAljnPP2OJDQIgXOqqzsNwJbZRbplmaVBzFAkyKDcO2E2o4gd99Un5l569EFNWejwIhSQmBnZDd0+apdd6rJXHkJZrNL6bo4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568960; c=relaxed/simple;
	bh=j982pDnofHYNBgQsDPqjFMdsuN1MAaSO3+M2cykRu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMO3C7ZX0EjsO41WmtqJu1DlS4EQwgfbI6XxeTFyT77Vl4OcDsFlK7pwK1WwelaD8lOvwU5FeNBAik033yJfRraSktOQzZyq1eIs6dSV9jM9suvKbQjChniego3gEkbk7xrGjKcbKrc1OGYKDdiHN3F0JWA95m6XlSA2WZjKubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDhdNG6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600D2C116D0;
	Wed, 28 Jan 2026 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568959;
	bh=j982pDnofHYNBgQsDPqjFMdsuN1MAaSO3+M2cykRu3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDhdNG6w4Mw/0J5H+9aGf7Z+1DFTKb+cjzpbr7N6HXKcuF3XUCash/S8K4nLt/r+v
	 CI9dcT+fbqBUIfCBaUIbKvnJjId/mQGtdFhiliuSEYIkYXP5f64EhR2uOwquBkA2gd
	 t45DMbOgjwT9icFuEwnJg6fxBOpOM19Er941GRkFYEqY9q6o5JTJaD4OwMebm8vwoO
	 a9ELFsEJPgdsImXYFtPPnkFvfuOKk1g12lnrCWur2BKnh64dg0r1JvvmzDD+9Idcbe
	 M78v8zdM8q6UbRwYJFOZfslmzmT1f9DN3Fql39/3DwGcha16zA3gitZ/vCMvUk4xYG
	 YLLgbo16kUtzw==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	jhs@mojatatu.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	km.kim1503@gmail.com,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	eric.dumazet@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net,1/2] net: add skb_header_pointer_careful() helper
Date: Tue, 27 Jan 2026 18:55:56 -0800
Message-ID: <20260128025556.4169217-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127144433.196836-2-edumazet@google.com>
References: <20260127144433.196836-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,davemloft.net,resnulli.us,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254082-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 827309C6F4
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: add skb_header_pointer_careful() helper

This patch adds a new helper to validate negative offsets before calling
skb_header_pointer().  The commit message states that negative offsets
are supported "as long as the zone starts between skb->head and
skb->data."

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 86737076101d..72679aa7af58 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
>  				    skb_headlen(skb), buffer);
>  }
>
> +/* Variant of skb_header_pointer() where @offset is user-controlled
> + * and potentially negative.
> + */
> +static inline void * __must_check
> +skb_header_pointer_careful(const struct sk_buff *skb, int offset,
> +			   int len, void *buffer)
> +{
> +	if (unlikely(offset < 0 && -offset > skb_headlen(skb)))
> +		return NULL;

Should this check use skb_headroom() instead of skb_headlen()?

The commit message says negative offsets should be valid when the zone
is "between skb->head and skb->data" - that describes the headroom, not
the headlen.  For a negative offset, skb_header_pointer() returns
skb->data + offset, which points into the headroom area.

skb_headlen() returns the linear data length after skb->data (skb->len
minus skb->data_len), while skb_headroom() returns the space before
skb->data (skb->data minus skb->head).

These values are quite different in practice - headroom is typically
small (2-128 bytes), while headlen can be up to MTU size (~1500 bytes).
With the current check, an offset like -100 would pass validation when
skb_headlen is 1500, but could read before skb->head if skb_headroom is
only 2 bytes.

The existing offset_valid() function in net/sched/act_pedit.c uses
skb_headroom() for this same type of check:

    if  (offset < 0 && -offset > skb_headroom(skb))
        return false;

> +	return skb_header_pointer(skb, offset, len, buffer);
> +}
-- 
pw-bot: cr

