Return-Path: <netdev+bounces-261312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH4bJro0oGntggQAu9opvQ
	(envelope-from <netdev+bounces-261312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19801A5686
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A348D3156E27
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0537649A;
	Thu, 26 Feb 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuFG2oxC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO6BTwyl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3235364EBA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106495; cv=pass; b=mN6drpSD0xwt3QeOp0CjFfkA8d19ssnuMCsH9qIGZvzXOwIlw9ItYw/0iVYRpAAHHCmk46zI5Js9n/agNdBqbovyxaIxbh0igTvrC12ooMp/yF/izOXcT0oVD8uJjIwyWZtzo/FDMq3OWNZF93M1XystbkVknfXecwO7W4zhj/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106495; c=relaxed/simple;
	bh=iG4+aWiP+q77ZjskdMgfoWMi21xv7Mz5hH8zT8534uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwjf5U77kS9t8PBMOYv4fNYi7rIIXwIW4lgB2BmgfKjA5B2lIdPy5/JRrP+YBjJBxetNkq7TgTUmBu03g/QryITrj4yqJSoOASqWKdYARRGjKmpqby5pMO7JQDr53WOvDbe37DuX3WapHXucT3NiC6peH6MqMbrHEcizRQHzhJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuFG2oxC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO6BTwyl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772106493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iG4+aWiP+q77ZjskdMgfoWMi21xv7Mz5hH8zT8534uA=;
	b=CuFG2oxC5n+uzd/zqjDHlCx6h6nSoIGZlPOEEymyQ+HBbqLGZBFw3V9L7v3Hb1k82AhMn0
	zN8OWIgWcbrGDLWjnbj1/htrOfCYeI2vS9WunBRnwINrsWscb8MjzbBx7jY8RenKRzOQot
	hNyVkuabFgbExThrK26ndNbbTY4mh2U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-NeOc0xBBPledWtdJkPn0-Q-1; Thu, 26 Feb 2026 06:48:12 -0500
X-MC-Unique: NeOc0xBBPledWtdJkPn0-Q-1
X-Mimecast-MFC-AGG-ID: NeOc0xBBPledWtdJkPn0-Q_1772106492
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7982c3b7da7so12077357b3.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772106492; cv=none;
        d=google.com; s=arc-20240605;
        b=P+b0M8HzOVi76gLY7XMwMrHfkz+1V1cyGw37zMJ9MsWgQcbppnL3+qHZlJDC0qycsB
         W6GFRFUmuswu6UqTkC0CNY40YKYGoFTey/15keuTfMB9rYc1+zYjwAkbK2lV+VzwEsLb
         I0xcj8YXN6cnPBNMR9jBbwokrvJrGFNpUb4yoh8bBNfKHS3Nwjn3U5kIqFDvXzdmeR84
         kC0a7YS7o6yGt+wF0QSsScwwIftsEP9+9KYpErsCHxWIgW3/gGkgVBC0Dqpjz4PDixuh
         2hP8x9CnfPrFalWjxCVLJFzJW1sFP5dpA0ljjzS3bl5XUsdf10E98sdEfYuwEkfjnmAX
         zK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iG4+aWiP+q77ZjskdMgfoWMi21xv7Mz5hH8zT8534uA=;
        fh=T/nNbaeKTOqQjGYqoazcyJbd48ZqU8536pTahXFD6+M=;
        b=A7ZQqe1qQI4tHu+4PgvNYRX/AC8/PVghofK86991mBjTkKk02C83W3JZGfHy/kgQcy
         5Z7JhD2UpynsxogDIi7uvBK1Szjbdh9EFuHAOSpRt0vzYFpwG+maimjq0KisqNn8GgHD
         +GP4N0j6TWk6YCYGeiCYnDWDPr8Ugt0s/xPvH5jadJFlfF7ZkJMW4Jt+ReKw8FtHph5m
         Y/xgQfeLvp88VW+e4p12tm9GLZAWfPvbTWy40JwpGyGR177ul0jbRgKquFjOgSXShgss
         4xeSc5IvYgiWKJuXyFe5JNJ+McigXYgfqUs7xlv07XhrgOlOoNIvsuzr//2jUiVsyLt9
         CIqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772106492; x=1772711292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iG4+aWiP+q77ZjskdMgfoWMi21xv7Mz5hH8zT8534uA=;
        b=MO6BTwylq1Qo/BGkecGUY+Ulmnr7fz5VL6ayU2Oj63XMyLXWtgmwCymdicSMvEM3xp
         r8dbOVy3jWQAYD8w1DlbF+nYE5OoT4Bd/G+c6PJNnj7Zq6jfQF4v6DUHrs9FNnNi9JH/
         xGMCSJuGZcA8s4pqMbqZKHL+THoCeoNHVAWbp50HvJywiJ3q3/DuzdyYUQvozxB72xlF
         duvprtQlh0D7D3/P/M9TiupQOSpnJQmoZzJpCDdiPcKXxFQoDWCz4Yl8uj+r79D7SnUA
         m9DXZ29NdnGO+ImXqmISuuNEIaOIdTLXzEL8UYifgUuoB4fYmFJTQQmIO1JqRKoGJRft
         DqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106492; x=1772711292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG4+aWiP+q77ZjskdMgfoWMi21xv7Mz5hH8zT8534uA=;
        b=rQrKMcPtFW/2DANTvS/Bj4W9NSrLldnNb5qeGBdV25cmbAoobMfLB8e+ylod8wiwG7
         0uxKW9i/1RfLZPKSk4NoHGnJPaG8uKdBKdv3RpQjDomVvj0WZYHYL7qS9ytaLLFrjhiz
         XDKdX6Te4+/QVCLaUCvmXZqLR6t0tr2n6Rui4TuanzJA01Ax8GSwz0vwZXJ37c+JuwQ3
         WEyEawS1LfR1RhcKBUWZs6Q1NhSLOCMEmKab5AaMjaJJ4Vw+5oePsE0hXWVWNUrxXY9e
         tQaFZHbwnpOoKj43ERG6JtBesIZ4kahzD3Gn2Kgakk5rqIj58QHtFMEzvTX4xxfCvVZS
         4bRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvVazl7CB2dXvwGikPnZhrXCMbGuUtyiiaP7KYTFj/E81ydrAFZ6QODj1VYGnI46ggXdB4V78=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZIRio2Keo3cSoKhZLBHXljBTxZGcioE4b5OepfyTw4qwrOY0
	xD62zJdExCYm3Q1UTovsx7x4RrVvDpvmimuzaB+l5GBw110KEI9isWKrm2ZfqP/0QRlCjBtTzLE
	G8ggSHw52w3h8gYU/VgZyMx+Xs77cO2HiYMOqEgOpFGewKyeQ7lAWztU+Jtw8hritC/Qrm6zYXD
	fPB3V6gKm6EjdoVEX2XNaL1gQNYkF6AyEh
X-Gm-Gg: ATEYQzwbk6RAdWZB+A+Jr0b7UQpgejVGo6ZVVzm6mLxJ4FTsGpddyyhYjO/jzGcX8+6
	dWv4hhUf1Fqt7Pcu2fqxwLEnD7sgk3a6bvYGG/DKkxcyhaSQq1Kn5N3BhI+1ALA3nDyjUrFATXc
	tKUQkZLor+0Pn5jPC6V21cP+8MfcMlOCLnCHnxV0RQj9pEUlMpd9yGPDGtddurFreImlMWEuBF7
	CG5pU3t
X-Received: by 2002:a05:690c:34c9:b0:798:6c25:f453 with SMTP id 00721157ae682-79876e4900fmr16440537b3.63.1772106492061;
        Thu, 26 Feb 2026 03:48:12 -0800 (PST)
X-Received: by 2002:a05:690c:34c9:b0:798:6c25:f453 with SMTP id
 00721157ae682-79876e4900fmr16440327b3.63.1772106491695; Thu, 26 Feb 2026
 03:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225130619.1248-1-fw@strlen.de> <20260225130619.1248-2-fw@strlen.de>
 <aaAOFygrzyyp2a_z@strlen.de>
In-Reply-To: <aaAOFygrzyyp2a_z@strlen.de>
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 26 Feb 2026 12:48:00 +0100
X-Gm-Features: AaiRm50ZL9RNmmzdTiw_9-16C73z21lzCUwUswljThG-Njp7LyCU7CVfR2pJpnw
Message-ID: <CAF6piCJis=8hp4o8puLH+N6jDiraPvMyBzk_NW1TsndekmRHPw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] netfilter: nf_conntrack_h323: fix OOB read in decode_choice()
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261312-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,redrays.io:email]
X-Rspamd-Queue-Id: F19801A5686
X-Rspamd-Action: no action

On 2/26/26 10:10 AM, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
>> From: Vahagn Vardanian <vahagn@redrays.io>
>>
>> In decode_choice(), the boundary check before get_len() uses the
>> variable `len`, which is still 0 from its initialization at the top of
>> the function:
>>
>
> @net maintainers: would you mind applying this patch directly?
>
> I don't know when Pablo can re-spin his fix, and I don't want
> to hold up the H323 patch.

Makes sense. Note that I'll apply the patch (as opposed to pull it),
meaning it will get a new hash.

Please scream very loudly, very soon if you prefer otherwise!


/P


