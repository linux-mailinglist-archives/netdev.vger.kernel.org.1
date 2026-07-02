Return-Path: <netdev+bounces-303988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ejhwEaQERmq8HwsAu9opvQ
	(envelope-from <netdev+bounces-303988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E706F3CC0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:26:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LyTMJKPD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303988-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303988-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBF93046D6A
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD41386C0D;
	Thu,  2 Jul 2026 06:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64D3859CE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 06:21:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973320; cv=none; b=h+MFwknTcjJH7ACC/gcAuhl0Kkd1EyUiiRCAZK9qCxFkH4/ks/941Aki1M2E2gdVzHSi4rQZPZHDwSfmmpwOXMX70zcIZG11JHdYlJEiDxWRNzwpFZGeX/R60Gu2WVH1gzJSlFH8WhXGfUxjPqbcUW58GLwVM+qNgNRvgCGVr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973320; c=relaxed/simple;
	bh=Xz1wb76anL5E5ME/dtrL8oHkFhMXv3brH7Mycv91DBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTgaFkz5LLdf/izFwh7WiDvkyNA/Tk54x4GOxNkVYucQ1tqTnbwd2e8uGJV40ylkLznUD5bJD2oONYNWemCsET/lmGxEFpnGjQt0ZbkO0jakg1rW6WB/s+XXYfNuCKGswrIC7ZdI6bzQqeoGmfgHmWwKi5NkHpEYRqsLmvIGALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyTMJKPD; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso13317845ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 23:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782973318; x=1783578118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+AybXHCcO4BnLqFoauWvt1KwEn7CeMrNml46vf7sfE=;
        b=LyTMJKPDd9og/E13MDsh3ENnkIDwMeOKzw6jG4Jj7TYDr2XRO2kTbEU3n8yPWNRcei
         HPbES4ohp1delPdO4k3PPEvV/cTZFx8U8wiKV/yi9fEcnd09928PqkcF1ELhnuj/gjmx
         0yBITzT52K9WWDD4HPw7+uJWOXUYjLZBkW+OvaOuxupCTAM/DusJ1NkBnWuLRE/NdnlK
         YzrEUP0SQ11/3/hHINA7vDIMYg4G0uIx+0Q+RujQftafHXrwwuLKufttzo9IYtomWp6Y
         aeUMhQSTIQgrTpg4XFKkzRR4rU02Iiw0JUkTYDdGNdD80anWffpXHngDs2JFtAE8VOBh
         9kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782973318; x=1783578118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+AybXHCcO4BnLqFoauWvt1KwEn7CeMrNml46vf7sfE=;
        b=CMO8hW7nW1TdP7VmRTJ/r4gGneEiWNCG4NE247s4lAxY10feGyIpYGSpTLNHtlgQvC
         KIY/mS30/UegON9tB9L8Xf+qOXJzLyQqs/DrRF4AqRR4QOOU6vnNMHMr3a8eaE6tmjc+
         F8cFAmMBt+ybW82VqbCx90smr8UMLy18cjIHZrFC5bfvsGokaoBaD8R+F6A9q2slyedW
         NuJClODRj5iQ7SqYPQmhOm1nQsApoDCCwloCGs7VB2Aj5aIjdcLkEsR+QErJkwgM63hu
         Q/4qTCzoPM4ycIvMIDMNDXCRFU6E2FmfP32Lb+ZsPwcCUMrmQzDcJoCj+TB89fzTXJp+
         cz/A==
X-Forwarded-Encrypted: i=1; AHgh+Rpa/c2k6oLupf7IXd+y+PdLuj1zzlm8j+Q0IvkN4g+f8eNPGes3oqcBgMRZc9gh8y0OsxufkqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBl3WHxE5Cyy3dj/bDFCqgIgFSlkbmJgglJN4lcSbBCJEEWnn
	I5ianteb1sS/UloZ+WS/y67iepWIhnVPTks1nIh4QmnNkWGcfWUTWRae
X-Gm-Gg: AfdE7clipSftmq7dm8izCr6bkdUP8wMmmThA+zwaaPv3NFmHwuguCO9EqZU7AzwobRy
	pbpplqGKMRoLOc4MS6FojI9s5O0ZeCuptDZWroX8gcZrrLk4we8jiIDXpmkf1bpeDvFdZK/p5TZ
	yGRNpPyGg9BB57UIN2o5hhVgSmbU+yS8IEB8FjMsyI5/JogSl6A7J+eiE7940xxci6bG82ZUjD9
	iI6PlORZ4P9J+CivDYh/AnjiaFghA0MY/u5k7XA7onsSccqgKbdNIT1Q9vi479QxcsOcb74qqbe
	0J+V2q47ZObSWI22H8OgCyj/CSKUDlJ0rVrlM7PkI+3a4zfRDMhHQY8/gvmAGK2w2jCffziIMIg
	c68K82RGpPu2llVa+dS8UvOVNlhRfk7xqqRyxZD23z/NUjki/234/arwGO03YCyY5ABfb97Dl8Y
	Em/UqK2LMhYfYsT7P6nAgJiehchMbI+9MV+w==
X-Received: by 2002:a17:903:41c7:b0:2c9:c46b:129b with SMTP id d9443c01a7336-2ca7e67c028mr50539785ad.5.1782973317756;
        Wed, 01 Jul 2026 23:21:57 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:cce5:6a06:d746:c95f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm5296145c88.6.2026.07.01.23.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:21:57 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aniket.negi@airoha.com
Subject: Re: [PATCH net v2] net: airoha: fix MIB stats collection to be lossless
Date: Thu,  2 Jul 2026 11:51:47 +0530
Message-ID: <20260702062150.8291-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <akWYEf5wusTq9_ol@lore-desk>
References: <akWYEf5wusTq9_ol@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303988-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniket.negi@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69E706F3CC0

> > Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
> 
> Hi Aniket,
> 
> just few nits inline. Fixing them:
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 

Ok sure. I'll update.

> > +	dev->stats.mib_prev.tx_runt_cnt = val;
> > +
> > +	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) → {0, 64} bucket.
> > +	 * Accumulate RUNT delta in tx_runt_accum64, then assign tx_len[0] as
> > +	 * accum + E64_abs so each call gives the correct combined total.
> > +	 */
> 
> no new-line here.
> 
> > +
> > +	dev->stats.tx_len[i] = dev->stats.mib_prev.tx_runt_accum64;
> 

Sure, You are reffering to both the spaces above and below comment section?. Same for rx_runt and rx_long/tx_long.

I'll update as following:
 +	dev->stats.mib_prev.tx_runt_cnt = val;
 +	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute) → {0, 64} bucket.
 +	 * Accumulate RUNT delta in tx_runt_accum64, then assign tx_len[0] as
 +	 * accum + E64_abs so each call gives the correct combined total.
 +	 */
 +	dev->stats.tx_len[i] = dev->stats.mib_prev.tx_runt_accum64;

> > +		u32 tx_drops;
> > +		u32 tx_broadcast;
> > +		u32 tx_multicast;
> > +		u32 tx_runt_cnt;
> 
> 		u32 tx_runt;
> 
> > +		u32 tx_long_cnt;
> 
> 		u32 tx_long;
> 
> > +		u64 tx_runt_accum64;
> 
> 		64 tx_runt64;
> 
> > +		u32 rx_drops;
> > +		u32 rx_broadcast;
> > +		u32 rx_multicast;
> > +		u32 rx_errors;
> > +		u32 rx_crc_error;
> > +		u32 rx_over_errors;
> > +		u32 rx_fragment;
> > +		u32 rx_jabber;
> > +		u32 rx_runt_cnt;
> 
> 		u32 rx_runt;
> 
> > +		u32 rx_long_cnt;
> 
> 		u32 rx_long;
> 
> > +		u64 rx_runt_accum64;
> 
> 		u64 rx_runt64;
> 
> > +	} mib_prev;
> >  };

Acked the change name from tx_runt_cnt to tx_run, tx_long_cnt to tx_long, tx_runt_accum64 to tx_runt64. Same for rx counters.

Best Regards,
Aniket Negi

