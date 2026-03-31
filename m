Return-Path: <netdev+bounces-273416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDI2D+Yby2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD558362EA0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F62E3033218
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468C2FDC20;
	Tue, 31 Mar 2026 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxYaAqGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119D2F5A34
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918535; cv=none; b=mQAa+mS02bwvBVBY8kkucb2p9z4Wdb9VmsOAbvn9CZc7SPgL9aMhHQ1mpMMZikl9qzvuNeyClmaYAyEtLJmBuEUFpFo9YqgKbNOxdIu5dtlyECwZNAo0+n8lgwZw1DU1K8md1usRtIbUeurqmtINPefwzCUO9t6NCqk/5B/wlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918535; c=relaxed/simple;
	bh=pyy1txqt5pivYbU8uLVlMQpi3hhC7BzyurlJkBCp2sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQuqwYUYv4a+cWVS/bZ+ar/2qL+UPi7DBMqZgSbGYieXQDCpWJNI2p9de1W/9O45L2jQv2NzmsB1Rx3RtPi7s3LkyqilV28vul9hfv3B0nnURILgoaR3m6jEFJOdIv1AC6SxyMFIrzSbcV25ruasHL/zfvROWd2sgQr5vwCcS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxYaAqGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EFAC4CEF7;
	Tue, 31 Mar 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918534;
	bh=pyy1txqt5pivYbU8uLVlMQpi3hhC7BzyurlJkBCp2sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxYaAqGeR50P2O9/j78LtlqKCCO8sp3nu+zdoShqV+4v8busoUIB8D1oAfwhuWosi
	 UiBdu9AiNBXvv6NO4hoEzHowzY72xYhj3PaGwVAUzd/uTHtOJyfDTLPCiS2Gy9I3P6
	 kLnpsyTKmvvMv0Hpr7M5ohRPkQS981W5YunkuqU7J63E6uS26WR5bUw0VD34w6ncYJ
	 HR8F2fP3OkRqUBQeqI5bVP0eKPaBnqXxJf8fBPecbuMiaVkJibffPR5h62Ga1+izwu
	 E6Fre/hbpdgW2SzpSBguqJWwyYKm2RZVkoX63vrMwku5qJ075Yc0Ff4QE944wmc0br
	 wb+WOCmrXDsJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	joe@dama.to,
	larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com,
	leitao@debian.org
Subject: Re: [PATCH net-next v6 04/11] net: ngbe: implement libwx reset ops
Date: Mon, 30 Mar 2026 17:55:27 -0700
Message-ID: <20260331005527.3459556-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-5-jiawenwu@trustnetic.com>
References: <20260326021406.30444-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD558362EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ngbe: implement libwx reset ops

This commit implements the wx->do_reset() callback for the ngbe driver.
It provides a routine to bring the device down and back up when a reset
is requested while the device is running.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 8c9d505721b17..50a13dcf4b3c8 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> @@ -579,6 +586,32 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
>  	return 0;
>  }
>  
> +static void ngbe_reinit_locked(struct wx *wx)
> +{
> +	int err = 0;
> +
> +	netif_trans_update(wx->netdev);
> +
> +	err = wx_set_state_reset(wx);
> +	if (err) {
> +		wx_err(wx, "wait device reset timeout\n");
> +		return;
> +	}
> +
> +	ngbe_down(wx);
> +	ngbe_up(wx);
> +
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +}

Is it possible to use a standard kernel mutex here instead of a bit flag for
synchronization?

Looking at the underlying implementation of wx_set_state_reset(), it relies
on an open-coded polling loop:

static inline int wx_set_state_reset(struct wx *wx)
{
        u8 timeout = 50;

        while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
                timeout--;
                if (!timeout)
                        return -EBUSY;

                usleep_range(1000, 2000);
        }

        return 0;
}

Using a bit flag and a sleep-polling loop to guard a teardown and bringup
section acts as an ad-hoc lock. This approach bypasses standard kernel
synchronization guarantees and prevents lockdep from analyzing the lock
ordering.

Since this context is allowed to sleep, could this section be protected by
a standard mutex instead?
-- 
pw-bot: cr

