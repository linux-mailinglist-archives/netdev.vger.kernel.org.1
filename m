Return-Path: <netdev+bounces-145992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60559D198E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05941F216AE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0C1E570E;
	Mon, 18 Nov 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYBDO2nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7414D2BB
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961212; cv=none; b=SHzsBCg4ZRGADUaFldfncbQJHTpNngLVj5ZyJWCL4UFpSpyJtQx7TabHt/VS4bVe/reQPrNQmYUoP0zDXQAhvXUSChqa6gat3BWhBqTOMZW2WfidRCZz40Y/00VD1o9bZ6Sgi0rd2GXyYBPPI/F84IIx4/durSUFBMcXcp9bNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961212; c=relaxed/simple;
	bh=qhcVu3yT16vGDU4gfzDyKVVEehK5enaQQpZLZJY5YME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r5LzkeuD2fQ0rI9DJ9H/MOtYBBJWmiDo51qOXbgL8AMUfnHaKERgiDuhceiaElTZq5MWJF0JzodkexjkYVfhHb7jEOjLjDTqLk1qBBKHpl5yF3C2v3tyzevdiww6/TfE9Mfbjy5uedjMfMwLAeR6ffznqrsj5mhvnribofVN9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYBDO2nn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609b968452so32221371cf.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961209; x=1732566009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ahISKzlICL7xq2thX4QQ9VUlIqfnO9jRpsSa3e/Y+E=;
        b=ZYBDO2nnHckQywDGP+KvBc5upWvuJvxVAprUknNLUgtv2C0qkuh88SwX9XPh78C/sz
         cZgx4sMMpR0mXY0NR3YhrawQAXB/zX9hxHpYnlheRFoHnHMbo9jHCJC+OIqE6Qs3U9ec
         udfAfeqq6qlFchlSTfBGo/u7ESj1fIZq+HQNH6NXMK1zccwNr1eEqAC4QEYNSHso2Jua
         kxOreM4UL2AD4lbCQ3XjERa1prbkKOLWrTshjtd3A7cwqOHIADlosd6JZsF+Nqpt1n1V
         WVLULABGn+nZGNZqK/3yS9Krm1g82SikI46z8J3ky6TOXTBtQcNkm+SRxWBV3I4UeGPS
         extg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961209; x=1732566009;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ahISKzlICL7xq2thX4QQ9VUlIqfnO9jRpsSa3e/Y+E=;
        b=C/fOaKhBb7a8opphCJY78Zx5IRaSzeBNowXbXM5h0PAF43tBnC6dzci5KzKSu6RXny
         nTc2VkvrKqPQd6aR/+IXcHNOy4MiV2UxuK1qRVggif3uZQJvp01kwXT9iM1oUqjVFkRL
         M9gWiQZPTsG6FeXo0yxj0s9bX+3mlygFOJHt1mEyLnanmlI0Y2sIcof50Liq/eb1Et4x
         lR6ghD33tNw/E8xEnbwgjaQJKuvpuId6MezdMcxOvDzSx60BQoaNpJw/5rcymDeb2QM0
         fnbzxj42Hm7/no0OTX/5697t/JSOp/mkfMrA7PevwNiu+4e/lKKKguz39tBitNrqlD5J
         giQA==
X-Forwarded-Encrypted: i=1; AJvYcCXovEDJ7TP9vXUpnMiLVAB1GYSk2R8RFVipc2UDvx2XEzrntrWBrdqaO4G47h27J97RRZfht2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykER0Qc+XgdBk3MDi7P02CRVXdIRNHEdfZaQAoMswAnSCILSI8
	GDwgbkB3dQvsvzd6IUg3uNY5ME5L0VCfZWEQhu7Y4xrqUPWZf/8lQcS0qA==
X-Google-Smtp-Source: AGHT+IEfUYGXm2endIie61adx4oO5PavWA3pDy4aoOstqc1HJS5sycG5XKjTF2hZVhZ4PVcRA1iDHg==
X-Received: by 2002:a05:6214:f66:b0:6d4:16e0:739a with SMTP id 6a1803df08f44-6d416e07684mr131030206d6.17.1731961209569;
        Mon, 18 Nov 2024 12:20:09 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc38854sm39612916d6.54.2024.11.18.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:20:09 -0800 (PST)
Date: Mon, 18 Nov 2024 15:20:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org
Message-ID: <673ba178a008e_1d652429421@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241118145147.56236-3-annaemesenyiri@gmail.com>
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
 <20241118145147.56236-3-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v4 2/3] sock: support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> The Linux socket API currently allows setting SO_PRIORITY at the
> socket level, applying a uniform priority to all packets sent through
> that socket. The exception to this is IP_TOS, when the priority value
> is calculated during the handling of
> ancillary data, as implemented in commit <f02db315b8d88>
> ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data").
> However, this is a computed
> value, and there is currently no mechanism to set a custom priority
> via control messages prior to this patch.
> 
> According to this patch, if SO_PRIORITY is specified as ancillary data,
> the packet is sent with the priority value set through
> sockc->priority, overriding the socket-level values
> set via the traditional setsockopt() method. This is analogous to
> the existing support for SO_MARK, as implemented in commit
> <c6af0c227a22> ("ip: support SO_MARK cmsg").
> 
> If both cmsg SO_PRIORITY and IP_TOS are passed, then the one that
> takes precedence is the last one in the cmsg list.
> 
> This patch has the side effect that raw_send_hdrinc now interprets cmsg
> IP_TOS.
> 
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Good catch on ipv6 ping.

