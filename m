Return-Path: <netdev+bounces-274999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JynImqmz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:37:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F9393BF7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F203027B63
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CB37DEBB;
	Fri,  3 Apr 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bB0aTvmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B72DCF55
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216092; cv=pass; b=Z8Aq/mh7X4gGvaQpBVVkwxvWHXeN+oX1/JzEA2Pl/yy4stMIQwCyDEGXSg7OyNH/gY3Y6nnPJvzLkCoC8AzXtuZgLCSZqy4hurx5y/cnT8EceXjtXpaUxsz4Ab/Z8fnY3gMYKhTlIwo1SmrbqWGgQyjlta9vKM/AP27mvDtpqCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216092; c=relaxed/simple;
	bh=EK6As8t0598qij8p1oz0nFzE5poyh4dStAQ4im0YA2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1aZcI+CSE7PKsDWKEfjKBI5yGshi+hN6Mkl9fYFlGmDdAclKHA/IvwJObWAssrsAC001IqPcsbQqfX8/OkF8drMvHDTgdJTQEB5pLa1ZzteLRJMs0R+bpE+Oy3onB/wc54zf356LaZ+wLN6oUv+5ssTTBUwa52+5ShiJnZc7xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bB0aTvmA; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50bbc41677dso26474971cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216090; cv=none;
        d=google.com; s=arc-20240605;
        b=DNkgQjhKR9EMTp16MgRCUFTWX4DKOCaK4eoxeXnPu6dSaz27EW0Mrps69JcfOL20mb
         y1AayGKJVC89j230nT+rPTa3j4PLFbVBCoh70yhTY4F8wlKJR4kdl0zJHbkoBYF87X8/
         ppR8k+MPR7HKzRPI/HM00UfdfhkdQMrNabtDXKjCll7cRDPocme67ghUK/RpDqnMsHG/
         OG/OhNW8Wgag49WveK49+c6HREOkM6Wg5a8QYAnoGzE4LfMyHlT6YUjpktHFN+bc3F+R
         7Ej5FswnxUpFDdYdcNYMmWyXOSUFFs7YwGYYt+lE1RSoUA7pI65TOYAW/fvw3lQe8CXB
         jSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EK6As8t0598qij8p1oz0nFzE5poyh4dStAQ4im0YA2E=;
        fh=mUZ5A6FLWuoZDUPrteNiR3cIgzYiqNjeRn8lHfM8Zlk=;
        b=APKvzg7DgQkRALw7+vJe80ncMyoO0mdCRxPwZJoozOxsTKGvNTqzVofH/E4fUgsMB+
         ZOb3rlxzWdRtNqYFtqZF+jFdIbDc2JmDjAfMgv2NejOPQrSa0ZZpjwCaLuY6Jpu2Oprk
         sRJoS07D2qoGAs1Ly8uz+ObUEywzx5xiOr0KVS1GmZt5Iq26+Vo/ZUq7zTL4+jnhpNsb
         QBbqIWTx4poRpic+Ht/lpKvc7MAtz3DlYs7CbhIBqjTSYCihyASaIPpqsyGAakGACpi0
         I3Oxut8kPfcXeBj9BkizzdB1RhD5SeN+3eMz7wwZTiE5BPGlP0RKELxxfuRsZUUIOuVJ
         2R6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775216090; x=1775820890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK6As8t0598qij8p1oz0nFzE5poyh4dStAQ4im0YA2E=;
        b=bB0aTvmAT4cADm4a290iyBUM7kxIk8rtUCK/fzcXPkFfoKxws3dmnW5fwBFflL71bR
         5PMS4D6y36l2+mxMM9F5CYNxLcCJDs3G8+XLptZP+ipY3e0NqYTpWkFwbn1adzkQF/kV
         GCOrjA6ni39v3nTSoEjB+ttGMTK/OCbo88o+lFYAkdlAKV2Czn2nruE3pVrLqgwRKMjD
         ZnENU+5JebSk3Cl6luIyJJJEKlfUjh/WxYiigtg9sfLMq7MhvPq1JpXoEQw6d+qyJr/4
         yDylhGFPPAIekfOadhfTfuarRRfefdZDGnqpA4SXIE5WtzF+iHo9FBzxbshqw6R50wa3
         ANMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216090; x=1775820890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK6As8t0598qij8p1oz0nFzE5poyh4dStAQ4im0YA2E=;
        b=sbOeBZyQhEuluXRXvWBh2+SmUityg8PVeBWkDJT18SY14bfXmSrtc/5wzkdSjcNwIO
         QOx5m2tRknC+8+NJQsx7vxMnLqa8odHFEoZ5PqOokBtYVNdZynhC4Ze4OC6K6ssTK4dQ
         C0/xiy+Z88iLtCPNaih3cLZryDeG2MqHiHoRPNc+fuUAsqt1oF3ATSrptDFWLjgI3cjH
         6t4fBGYUf+lUd9NxDmypuOohe1q3NkdfT/RArk+17bEaqUS/O9cLpqhngG3v86sBia8/
         JUDVVxWthhsWSKQFNcbSV7vvMv13AeOv8SS2ZU0lUzzxUdvpvVb2ppnS10fqBLfl6zBa
         k1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWyiHrxpZXPi6tB7ljNRGWycgooVZonr8YCiVrSfgZCRap4y17IkXaUSDZ/MMBs/njHWt5Jb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1I8/MDlNfjKSQ86lSI803E3K4MGEe9ocU6osHJp2GgwqGUgn
	zIuh8OdUmN1r1GXNbuVenq7AHXmwKmhUgb/JaBhREcb2TuKKvmM7gtfGaIZffic0N3gBiyxmZXv
	bFp8lIhQu8qagOPjNjPXHpBoT2nj/VCCAJgQxw3ZY
X-Gm-Gg: ATEYQzx27qOCqvoKDiYWVOdJfzno03Ccq0sFgIg1aJlUI8oYOZM+t7a5bYCjnx+toKd
	/EfAMZAT//Wl7er0L76bN33wPC6tInb1XXgGla9SjKO5Xg63mvJGcbhrIqxjSB7hBJmOjDT2Sc8
	rasbrYSOkfMrRvXVJU+p4P27hmxtn4n6nAqn2u+ZC7ERxQGGAXQcVYyCrh41P1jZGSuljum8bFD
	FWq/1FUKNqsx+DTU7XQxJMAVtbwLEpzzpk0dM3ILvp2xZNhTXLba70C/fpzChXzem2H3NwD3+jM
	Z+aI+4A=
X-Received: by 2002:ac8:5a06:0:b0:50b:6a6c:ed06 with SMTP id
 d75a77b69052e-50d62ae8905mr41318841cf.49.1775216089248; Fri, 03 Apr 2026
 04:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403103654.15304-1-devnexen@gmail.com>
In-Reply-To: <20260403103654.15304-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 04:34:38 -0700
X-Gm-Features: AQROBzBS8nl5Dqcq_zQ_7_8Ft6Y7BZqD31_enXiO1jqYKo7-qFul7ptNmY_8_Bg
Message-ID: <CANn89iL-4-JBQLsumT_XGv6DYXUWtgKHYKVztec1pj3w8ksuDQ@mail.gmail.com>
Subject: Re: [PATCH] net: use get_random_u32() for net_namespace hash_mix initialization
To: David Carlier <devnexen@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Qiliang Yuan <realwujing@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,suse.cz,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E79F9393BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 3:36=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use get_random_u32() instead of get_random_bytes() to initialize
> net->hash_mix. This is the preferred API for obtaining a single
> random u32 value, as it returns the value directly rather than
> writing through a pointer, and requires no size parameter.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---

I feel a tree-wide patch could be attempted ?

Thanks.

