Return-Path: <netdev+bounces-287961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHcTCtvLBWocbgIAu9opvQ
	(envelope-from <netdev+bounces-287961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA6542367
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 606D6301B34F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077603C4141;
	Thu, 14 May 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMmZT0ou";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pL+vq/p4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D73D9023
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764760; cv=none; b=q6Y+McR47/Gk8xkK11GwJo3OkaFFThCy/DGoLhHf+PGaaShPY63SPt/lZLI9e/ert8Vj75W49zrb7Sem7evfplHo5BZ1d3GItaQiG5MjN8LO/f02birGuVeJI43nMPwpXZJoLXRgM7s23Rbr3hT4tsKly8EAn6ArEX9nwaWvu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764760; c=relaxed/simple;
	bh=80LqO0D6ZI6zzBP7dy7IDPTuTzNydob/c28DvxeRJwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqJL7tXN9B/l8i90uhjPysuGKHpQqQAz80u1FOfQ+oqqeR3Pk4YV6CEUusQvJv+NvNeePCoAx9mvQxuqLhnjLypAAR/4DptJzu6o0OlWaag2oGGAa6wC+GbP9GWSAceacYoWLYsQ12Wb9cBKHnK2Ym2LNSMvkUyJPHWHngIhq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMmZT0ou; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pL+vq/p4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778764758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9femd5hn/xO1FkQTMLfqDsP0GKz5uGcRFwZhMant7do=;
	b=jMmZT0ougjrxgwN1+H2ImpSQjrz7/VZOUfqrW0I+B9VSsIi1auYyEDnlssIY7XNGbs4Vi9
	cEJeWddEG5tphJitOslfNLcZImRYgYBcRVKthehXjmujk23Uxjj+j4pflLwzMmD6UnqhNY
	JWSvCveVVun4sFFrvFoOmNibsn/hA3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-eblGuJgIOdaQ7pyzqcZNLw-1; Thu, 14 May 2026 09:19:17 -0400
X-MC-Unique: eblGuJgIOdaQ7pyzqcZNLw-1
X-Mimecast-MFC-AGG-ID: eblGuJgIOdaQ7pyzqcZNLw_1778764756
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so45164115e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778764756; x=1779369556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9femd5hn/xO1FkQTMLfqDsP0GKz5uGcRFwZhMant7do=;
        b=pL+vq/p4x/KFUXUEQBL77LULgMvaSgkxXiYBiDgLANJsdJrgY1yrJeSh8sZFg1PM8V
         zgCVveBvxoJBdKEPZ3nxriHAM9AICe2fHe7loqQSUovTUDYARitGFuNmt3+5sc3MWFeI
         LMsbTrEBgzN/25OEXSRwbOFYpExsxzr3AzBIeE4WBFHWGFNznOvgBFPESqEf4Hfb3Gvq
         6+3031BKa41F9ulQaw0NgD/ANxbiHxYUYEsY4bN93VpQl0q9cr82srOqrUxI9/QGAZ3z
         KOekTvtOzVD8dfWGaw569VCp6o3H+P2F0JeFD0DIN+quCqtPSylUMobRpDEyoY5t9Gjh
         G1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764756; x=1779369556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9femd5hn/xO1FkQTMLfqDsP0GKz5uGcRFwZhMant7do=;
        b=cC0YJj/j9wN3q4fVPJvXTLpp1xM2FpHmn3c2/ItsWNRpkfHJyjRKM09MSh5ZrnTa8J
         +HT9p9yTZG/zGpUHeI30FHeYG8uU8nlnyOtacTLRAjJjw9VgKrNjckBDeZHBsuzPMYyO
         QxqNq66egISso4vybXjfKXwWbhFhxqhEqTM7ls6Y51qt/yHODnLkGuA74QbKhD4ndDWp
         TThkTFUBFNjeorUAE06TK3DQFd14/NS/ZVIkvlyajvp4k9krT6Ki35kKunNyfnEScGTK
         VWpICvOdg7FKA9MwfCGlgjdU7uXcyeeAAdwz/e1C/QkCHC21dHOBuLph/AwZAekCML1k
         1KDA==
X-Forwarded-Encrypted: i=1; AFNElJ/RKJfmwqcb7HYLDrETRUQFzCbZ7EGzPauA1q6cqP/7DUyWzcCJuoGO8kC3Zvab2tOLOsRQNGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiWdWFoKhTkpMM3PkBrTxkc/NmXgvF/EEchMs5RL6gIp7gLmA
	9N3ds0GXyPb1/0gJxZHycvJA/KT2RgweLJO+wizHQa9RzVYZpzleqK7GdAZOhC8P1n7UIyMI6aY
	A3iddq4PrI+jom3J1Gatnr9Z3JmKm/9UAqMQzMdf9W23BwdCkAMNST3AS9w==
X-Gm-Gg: Acq92OHmjGVcyhxMFfB4gAlI1Tfm/nW2H90UgYJGCyTm7HaDjjX7XstjrVjL8MkEGk4
	hiNJvUaWgYlRQ/vzggrVkrfgHaB9ijU/Fre9cPlAHIoO2bpNVA0mDgqMf8vV+utmVVygVq9drCe
	Y5geNw/Sz3XtMF+S4O4OtLUCFOcbPth1trnN+4BkcS7c4/XMLGl+ofzZDR5znaWQF2G4W+9udcd
	1N8PoZ6uzSkL/Q4g932IZ4YPOfHh4ah/LMnO8dn2hk7IRgRuu3wwf+4fW+tWv9b9dKiiafA0dmj
	1tuqvETNJtwZ2Ua6I/z6gLdoAh4JkB3+mhG78aBqzDye/4riNx71oywvokV4tsVA78uqdxzCG7r
	jMLTY1tiBxV3ZYuqgtB9HMlFv7sH4QwPYDlrX4+/0iiVQ8rUr4SQ3thI=
X-Received: by 2002:a05:600c:1547:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48fc9a02785mr112899795e9.5.1778764756132;
        Thu, 14 May 2026 06:19:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1547:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48fc9a02785mr112899255e9.5.1778764755751;
        Thu, 14 May 2026 06:19:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62df4d3sm30027455e9.2.2026.05.14.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 06:19:15 -0700 (PDT)
Message-ID: <d49120e9-7f1d-41ab-8020-eacff408019a@redhat.com>
Date: Thu, 14 May 2026 15:19:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: phy: DP83TC811: add reading of abilities
To: Sven Schuchmann <schuchmann@schleissheimer.de>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: maxime.chevallier@bootlin.com
References: <20260512071949.6218-1-schuchmann@schleissheimer.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260512071949.6218-1-schuchmann@schleissheimer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BCFA6542367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[schleissheimer.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,ti.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 9:19 AM, Sven Schuchmann wrote:
> At this time the driver is not listing any speeds
> it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
> for DP83TC811. Add the missing call for phylib to read the abilities.
> 
> v3:
>  - Fixed indentitation problems. no code changes.
> v2:
>  - Fixed subject and added fixes tag. no code changes.

For future submissions please remember that the revision history should
follow the '---' separator.

I'm stripping it while applying so no repost needed here.

/P


