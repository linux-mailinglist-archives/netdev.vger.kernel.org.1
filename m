Return-Path: <netdev+bounces-275978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD/YLv/x1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:01:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298363AE114
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67184308398D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021C3B38B0;
	Tue,  7 Apr 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="veIelTHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84733A0E99
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563036; cv=none; b=OCNOZ6xE9lrLidOu1GU5jpRu+BfTediBKBfRdQM+5t7B4c2edHx2pBhKi6+tqz0+SoB2SY58a/LkMjOCF/66kv8SktVwlOdw01n1DY2NyYP8/Ib/VbHZNcBiWxES+pT+5MWJiB8tkjwQB/qUPtI8BnQidKZVYUn+G6DjefI1EiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563036; c=relaxed/simple;
	bh=SnRtdL0bk2VK3XpUacl4D5FW36L1OwnmQJR8u6w9IFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3yn6HLoF9Tw/JmF/BfhyK30M2F4AK6uSZ2rh2aBF+jvKG4uXFX6pHjBHumKhxpItsKLxOtpijks+4O2qpt51QLwQZ63fTAAxvL35Qr6sw+pUX0MtGknWTp8y3Yizzy1GoWH2GLE75VDCPp6e8enPGPMr2/bRrhpT152fEmzXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=veIelTHb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso30457785e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775563033; x=1776167833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnRtdL0bk2VK3XpUacl4D5FW36L1OwnmQJR8u6w9IFk=;
        b=veIelTHbcO/xBWfRvnhydPtHgMj3M61foGP7nfwWVWxzVYqFQbHt1vpFohBTeQ30Ks
         Yqqo9n+YKtL308JVXMmGsEAfiIMpB/geiqbLypTenHnUUjRPBfkwp2zNZSWW+kJKRxMt
         G0kVvA71sY8NyODTBCdbz6Qwquq9itczMUCHSS2cYBYTt8QnumW3vgIpQrtP8V855T4o
         tg9oQHFXlOkzH6hHKcEtqz236d82Oqbhv1P7EMQGESvp7zRZCXUZIQCP+D9yJO0VgsAZ
         dNwyb3K4YQDeMrVNt4BoConR6OhjyFDwgq9tybzFwGzg4dl+dblMupP3wTjN4DB2gm4G
         ntPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563033; x=1776167833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnRtdL0bk2VK3XpUacl4D5FW36L1OwnmQJR8u6w9IFk=;
        b=Fe+YCzerPtOXTP6Xj0ZjtZ1YEtTy6/n5sWIZf8J6jQzWn1JRZ2Zq66vBtOdrAGpYoz
         bb4t3cOwtMyEW/KhGerefO3xkwDbUlS0HlBPPVN9qr/Ix2yIcTqhlQNTdL/Bj3i2aFle
         ttU1koPNeV1kkzxDMfPVMMxy4nseS2ftC2uQuwY/+AXGgpumxI9Hy6XZIra8hXqOPo38
         IG16Oq7vE9K+mP972+PTXI74ukNFRnlXnkNY6doKGpXwRiMDCn0NLxS6nEbJTEwI/Bdg
         Y4tKzORtLZZssqFAsHoOSNALSsZAAAGKm5SdgGa7PKCfiHcJ3Jd1ugN4Crqr2vOI/9Rm
         9DZg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeR89MgMrt7VUHmHrLK35eNnZb0Z4DVnBhSscQNK95j+WdHqye29it4z914qyNMXZAzN081k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXdGw12YrcPaonKGjNFl9kj/yUnNwh2WeHjozYp3U5yB5USw+
	4yAJk/mzNNr7wzg3iMSFGMjpm1DUdiTDOJu38noo5BcQKHimB48yIanTxPXoK2Yrd3g=
X-Gm-Gg: AeBDievkYB2zEsZnUFcj+/RmVpCgecxKR6n1gZSkiJGVAYyeuHlR4UzsCtkXHn6EbDV
	oQYWM10ZDCSGbrgVKhTU2/2yGyfqdHws1Cr76e+UaFDPwUSMLZ2VKxwiz3459Il3eQGdtM1hvwY
	405UKkBRJbzcc1FdfbYNnuiE0SDycigdgJFEL6TUAayyGQzXwq+BWVaMKKqT0XiMj9IbZbnod5k
	rPNzBR9Msu6FMBVBy/OqirQN1pVZ18cVu5an6C3dcG3hKLwll8sluUKlzM5GIa1bdrhD9aQ+FU6
	MoCR4OToxaH/HIApBSj/ks8BgErVc3JOTEvqoBb7tMtyiIylqYTxWVZ7qoT7q22q2pCnFErIFXl
	3fDL7pd0OUOfNpfJlmdVNmxsBXVvrN/nPrdqx+b73vgFrn0x+68hj3YlX/01Y17gWZ9M38rXWua
	eo6VxysKmMIKmDMy+tvsDHQUpaUqB3KjQ=
X-Received: by 2002:a05:600c:699b:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488998f09dbmr274522055e9.27.1775563033390;
        Tue, 07 Apr 2026 04:57:13 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488be75215dsm49549305e9.6.2026.04.07.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:57:12 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:57:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/10] net: team: Add new tx_enabled team
 port option
Message-ID: <5pbks7curcynt3iewjlgjlae6m2ydpm4ztooyqka5vxlnwpemo@pbqd2mysixem>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-9-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-9-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275978-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 298363AE114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:45AM +0200, marcharvey@google.com wrote:
>This option allows independent control over tx enablement without
>affecting rx enablement. Like the rx_enabled option, this also
>implicitly affects the enabled option.
>
>If this option is not used, then the enabled option will continue to
>behave as it did before.
>
>Tested in a follow-up patch with a new selftest.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

