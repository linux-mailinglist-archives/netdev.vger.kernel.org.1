Return-Path: <netdev+bounces-289404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKIyDIxJDGoMdAUAu9opvQ
	(envelope-from <netdev+bounces-289404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:29:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA357D986
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C649C32E9AE4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F2370AFA;
	Tue, 19 May 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQbOc1J3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qcYnXmmR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A032B139
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188019; cv=none; b=HHu5FB9fgVRqZe8PPR7vYCvn5UpkvHAZzKTmQiHfkCN2b4WVeJwR6//4ZpEr5T2Xz/e8YKPEw2bKmoeKdJGI7K0ELXfMvKoQkUpaJy9bqZWbror4J1AfyADBBDq9C7HpAoBoJpRkIXRFrXaIoRvaU1jBh9KbkeVpZBoEfiy4uS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188019; c=relaxed/simple;
	bh=UYOSZYHFO2lZQJ0YtPqaAa6+5g7gsS3w6AdB4rm7P1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=svRwJ/Lbl6EpJO6GqCRzMdjiIudG4R6eg6flBuNZdzUGqRNZ0m7lr7JX52wKE7C92Lq/BH5NHeJPLZiYao8MEykiNs2AvFGoMtk3nVSklSTncQ4qid4vEoUBNs0BPDdRowkbNMETtRyIV8A1WPCmPrPEEEMxZnTtwig5HgOY768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQbOc1J3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qcYnXmmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779188017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUFo6hIuf2ZxDrSoEBKNJqzPv5wXEukq1eF4NrWaHmc=;
	b=OQbOc1J3rWMeJY9gB/mViHhQ2cd/e6MS0Q88BbPeKs6Xwzg2V5BWLh1ErqNei+fLIXT08c
	s2UuZSsB6XfbnoLh5GluwfKOqHjaJMedZ7XVl2HtHJfb2znlAaAc22ogDjROrbpf9Q9K4S
	qVKmF9T5kRZfAghazDzQLluXd4g5K6Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-PpqLHbaXOS6ynyQdm390Cg-1; Tue, 19 May 2026 06:53:35 -0400
X-MC-Unique: PpqLHbaXOS6ynyQdm390Cg-1
X-Mimecast-MFC-AGG-ID: PpqLHbaXOS6ynyQdm390Cg_1779188015
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a52d5e572so2677543f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779188014; x=1779792814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUFo6hIuf2ZxDrSoEBKNJqzPv5wXEukq1eF4NrWaHmc=;
        b=qcYnXmmRd3s/lLivY1ajFkQnee3+G/k1U9IVBXT5FsUic4g92SQOanjIBs+0AGHF0H
         6OMMbUHn5c0ckJxhVUPfadQ5OaLbtJ6DwvbWW9nonK6DqB17E7d13wyN91i/iOSYvk7c
         p759nJX9sUL6GDTh2W71ZntFdhGbP3C+BGegIKWWtsgtB0VVSgWpMICB0F3QcSXCUlr8
         czkjpqcjc0g0MvBRTFGHBXWkE+NtCt2qNQHs1r+gYV6Yk4imcBpulL0KFt7fX/Ol5fI1
         6A/giigWNCSv6Cah+VxLokskLzGTwvb/Ei1d7Egq5oHJ+DGouwXtKLynDU56h1YWRlkc
         K+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188014; x=1779792814;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUFo6hIuf2ZxDrSoEBKNJqzPv5wXEukq1eF4NrWaHmc=;
        b=DweYE02w6VWlS+gOwRHPOjQXpK0v+1j0NhZO+trVmqrT/6UNWWPjxQtAbjTpBzLyJb
         iXboaKPzYPbMYg0j+4ox5sOx/2KTjGO6Vy5wHNEPhTio2NpK4QSCpNryGCDe7ctYA6tr
         0JT34q/SOKY2ZV9APWqmY8FRuhrByAltYOlYpAi8uBVdI/U5pE9wxcXc5ZB9jB/oMxWd
         xbVBeceRrv2qW80cwjItLefbre4lVGyA6f2jD+mB5OlFTXQA9csoacsM7nLisNN7f94Y
         2pGQSu/6f/uZxKLajoI2I8Gp0J4L46b2B6AhawYD5sj5uJAbA0hxNr6DYDvVAi+pwJHb
         iNBg==
X-Forwarded-Encrypted: i=1; AFNElJ/yTxOwiLo4ieK8iakf5qQbFnHPIC5pL08JyQ73zO4Q3ity4A60cbc6SjiXkBf7n3UleHTdRAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbTD3YilDQq+rw9mzAbuYCj9zMOIxr/tAItRYxLS+XWG52Nt3
	MWOvcY4qaKG1CsQ5cwo4NfIXzEIhrSgzDPZ2yD9pymMK8XT0QDH4BC//LBzGpKawu14HXrEkcdX
	2yOyUxfHLEd140TUkYItlSzfRorx8FjJSf6LlDnxTgypy0elXRjXKe+2csw==
X-Gm-Gg: Acq92OETVr2z44Sag5oSQz45/ht+e+GNbCykkaLX7oDc0tlsP+ETPFHyH2STIvZ1h4Z
	the0aJW80Fy1MKgSOxpGpRvtzUMOeBr7wXd28VsXCWhTUtzQUknGCcKRzphGUqbvsFeYDw+Y1Mb
	0CKGQIUqWyxov5kh7FJQKWPlKOEXtd9is/CHTv9xbFYkrU73Ygqp7mBH3uR8z5XImIZKQKoH4Eg
	Q1X5jE9PX+VgB9Zzy/uZGorFQa8k4KLmE/1pxFCrXp5hsfZi1TL3noSFDe9QnDUbJ/nauk0JzRA
	g8gn9TKkwh7hAURbKf1KDux8iNzEruUucN6iJ4uXhaxZ8hdzwGqJ23PPC3gAnvCTRiow+yHhH0+
	zca4DjQhzarnvIMj6Hhh3WDIhlPK+RYi9Nt6JA5WcjZVf+nhmtWbgy/rdr07YDEbNzg==
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48fe63253f3mr282542475e9.21.1779188014455;
        Tue, 19 May 2026 03:53:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48fe63253f3mr282541945e9.21.1779188014000;
        Tue, 19 May 2026 03:53:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe78aadsm101525975e9.29.2026.05.19.03.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:53:33 -0700 (PDT)
Message-ID: <3a390dee-38e9-4df1-a94d-7128cd4eb834@redhat.com>
Date: Tue, 19 May 2026 12:53:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/5] net: dsa: mt7530: clear flood flags on bridge
 leave
To: Daniel Golle <daniel@makrotopia.org>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 DENG Qingfang <dqfext@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1778766629.git.daniel@makrotopia.org>
 <cc8d2f494dd202304a6f68332f3a90ea0a8a4618.1778766629.git.daniel@makrotopia.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cc8d2f494dd202304a6f68332f3a90ea0a8a4618.1778766629.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289404-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[makrotopia.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3FA357D986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 4:05 PM, Daniel Golle wrote:
> Flood flags set by port_bridge_flags persist after a port leaves the
> bridge, causing unknown unicast to be forwarded to standalone ports.
> 
> Clear UNU_FFP, UNM_FFP and BC_FFP in port_bridge_leave so that the
> port returns to its initial state without flooding.
> 
> Fixes: 5a30833b9a16 ("net: dsa: mt7530: support MDB and bridge flag operations")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes
> 
>  drivers/net/dsa/mt7530.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 752ba92b0851..5b58e42bfda9 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1767,6 +1767,11 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
>  	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
>  		   MT7530_PORT_MATRIX_MODE);
>  
> +	/* Clear flood flags so they don't persist across bridge leave */
> +	mt7530_clear(priv, MT753X_MFC,
> +		     UNU_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
> +		     BC_FFP(BIT(port)));

I think sashiko has a point here:

---
Will these cleared flags be immediately overwritten by the DSA core?
When a port leaves a bridge, the DSA core's dsa_port_bridge_leave()
broadcasts the DSA_NOTIFIER_BRIDGE_LEAVE event, which triggers this
callback and clears the bits.
However, immediately after the broadcast returns,
dsa_port_bridge_leave() unconditionally calls
dsa_port_switchdev_unsync_attrs(), which calls
dsa_port_clear_brport_flags().
This explicitly configures standalone ports to flood everything by
setting the BR_FLOOD, BR_MCAST_FLOOD, and BR_BCAST_FLOOD flags to 1, and
then invokes the driver's port_bridge_flags callback.
As a result, mt7530_port_bridge_flags() processes this call and executes
mt7530_rmw() to turn the UNU_FFP, UNM_FFP, and BC_FFP bits right back to
1 for the port.
Does this leave the isolation bug unfixed since the register clearing is
reverted before the DSA bridge leave sequence fully completes?
---

Since the other fixes are independent, I'm applying them.

/P


