Return-Path: <netdev+bounces-274490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNr6HI1UzmmEmwYAu9opvQ
	(envelope-from <netdev+bounces-274490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B0238863D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C7830BDEE8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4C3CEB8D;
	Thu,  2 Apr 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE5veiJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB13CB2D0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129202; cv=none; b=r3mcxGQOSWaBqHhh+DW2RmocoTEE5b6f+Y3yI5n/u70ymWn4So4aIucuwqUzEe1NfMeLpAcBnt2ieZFsM78oPaig2s/lhs9jc+up1gM3DowN60gW5BZQLN2bAe+AibKog8OMm3C++1N0cFWAec0hhGq7REImmKJbI1F6xdktNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129202; c=relaxed/simple;
	bh=UFFlTW70THGmSkqg6ywoWIx/uIQmxDePKuS13kjxt+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4k42DAvXGDuoDU7GTOrQCgv8YNuLipJCY8deZipJX8Gw06ABIIhtwsPyhSBj6Wpo3Vg74VdONr8s0HKKZCYt9ZDhl4qQNGn07rAPpNQdK8aZARSrgyJXnvXqRTNb4YrftMuBp2nSKEt1DF/N34gAkrPchif1A5s45daHuVjUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE5veiJF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad617d5b80so4036455ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775129190; x=1775733990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngNHrZ3nxHjFo/kuGGH7BAmeQWcRuG1lwtVJUVhp3dI=;
        b=bE5veiJFXeirlDNbj8dziljyEZtfpUo+hlNnRPDyrimRySDaf7OFceXOKFSAodvmja
         2jUF/peSab3Y2iGfXVp6IjytRgo8Fvi5Al/mCy3WxjsTbTY4AxNswvdiKCakLhoiV+v3
         h8nsvKhYFkxP9BNYUukccDjDM2yPl8WENK6/AxTj+HFA8L5VpejHxjnBYpVLwllhaGmt
         wlQSZs4h36j+K79VJtBoG4ZeWLJMDqZ/ZUPMFA1ettkzpKf23Yni/KUp5f1r3t5GUDxG
         E/ggTYYudNVEJkQ+de+0c0oXOpXknoV8hDg2i/bQshySazwjm940ntMmNrOyl0K7k6g7
         eG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129190; x=1775733990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngNHrZ3nxHjFo/kuGGH7BAmeQWcRuG1lwtVJUVhp3dI=;
        b=MTE5+eJRzvxILLcbIRhlWPcI0E/gLMRm4URi2nMbANTJtvwhbueC7GvqSzIO3Mxpsa
         5dYIx+BOMEgwo6kGd8ExaoSy7W8cDiMBgSKnphIU+PheQ+hkRch83hgpOPgF9Gg1xaH3
         9mJCbw8ZUDCDUGF4KdFQoLJX327QBOYbYQLytJjOXp4+G/wVFXbr4oO922MKSeMA4Igx
         AhIZL9XJIL3mSgigq8QSagY/+UxVibkX+5c/pgymbAnTdSbLAw6uLIi5WNzRGz4Rrhmt
         hnkORxy+VhSIUOzHFW2clnqzsqY3++P1YGpsxz/I2sTE1l06AM+sApS5v665hkbLR+wH
         nqKA==
X-Forwarded-Encrypted: i=1; AJvYcCWUwtes5yD8TWnc/1LC6jxIBacisPgtuUqJJWxv2JWcAJMxivgKFwedY08DdxlNMRHt4MUBRKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+o9EMl8f+9dwIa/NTI5FSdRfv8R3zIm5zEti3ipg+NV0PVnf
	mQF5piRM8rsFzqo97l2tHfQaa4Z31VPYNPG/gz2SFTGjrSI6gXg52DODqFFnHN1gR6g=
X-Gm-Gg: AeBDievlIKW3SI5Am7vhhbTLsvVRdqAafomCHczPKLdP6Xcjl6IPnI7QevrGZycJSgY
	/JUpQecvWdVx3E6xREkx3fyK41qphFLGE48jiNeSlwVEqTZHOIbUm88eNEGEh5W7TaUE3wH2Bs8
	IezeCSSsJEI7ohYiWd7DgSwSZfOAEqAQhaoH39fnkKHEjrt2F257AzaGxj9MVbgxFAuRmR5Lo+U
	RTqV7K0wHWXcerWfPt7OKUPsad/Q5cDTI4n4V1q5XmII42AbA6YtOVpRXvhnSfri1O/gm8LBjLd
	fPznlFEWKkFKbkFLEkWH60Mmm3SwVPRvXcblDjfvBAvKatyQuWIZx2/9NDHu8ORfLTNYIQhHhZ/
	e9X7pFtawavEl2A8nxX+qWqd4BE7lI/UsnySmHZwAvnHjxBEeJPs4ZGp5h/u1FrirXmYIaqKoDu
	Uj7PFz4g62w/fQvddqLxJYSk/PXyM8cOCUZj8=
X-Received: by 2002:a17:902:f545:b0:2b2:5035:dc3a with SMTP id d9443c01a7336-2b269caa770mr68842155ad.42.1775129190366;
        Thu, 02 Apr 2026 04:26:30 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cdc61sm25977135ad.80.2026.04.02.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:26:29 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH v2] xfrm: delay dev_put in xfrm_input to after transport reinject
Date: Thu,  2 Apr 2026 19:26:20 +0800
Message-ID: <20260402112620.57920-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac5K7S3dBsINFafg@strlen.de>
References: <ac5K7S3dBsINFafg@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274490-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3B0238863D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 3, 2026, Florian Westphal wrote:
> I'd suggest do drop the refcount after NF_HOOK, i.e. something like:
>
> dev = skb->dev;
>
> NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
> ...
> if (async)
>         dev_put(dev);

Much cleaner. The reinject callback only uses cb->net (saved at
queue time) and dst_input, neither needs skb->dev, so the ref
only has to survive through the NF_HOOK call.

Will send v3 with this approach.

Qi Tang

