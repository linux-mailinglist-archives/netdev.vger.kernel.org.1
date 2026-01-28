Return-Path: <netdev+bounces-254067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SxFRE25zeWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:24:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C309C368
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DF53008D3C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743B29A9C8;
	Wed, 28 Jan 2026 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzjxSObo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A22949E0
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567083; cv=pass; b=j7F1QpFq/i1ulwgQGNjyM4QpcOmLUbhcVLFbc2B6TsvpfkNqm4yxGG1ffqe5HBriO5awn/tqN3gYIVRhqetNVBpq4P4vV2dkOUAdkTfI4PfvxqC5L5len1QDcAZAl5Nka5WrML1HzpYbIK3mqltdkJ2cBjMSqZVzBV4vYr1lGeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567083; c=relaxed/simple;
	bh=qX+yMQ39LGCizFFNuDqgOnec8AaxqCwJovsLGmZdWqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8Xqp3KvoNXtQsqWcVgtUREoTbYIfSuvO2r+Qr/6Gfrf5zUWmJj8krtaPrOY2TMrffXJjLVrp+kExnj8tgSUt89Zmz3fiQBEa6GP+41xFxk/bPOTbVQ3yXg9hV54t6FmalTMhlk+NEr3yw2lpbromhTnx9+Yq6dVYMTgWz7Balo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzjxSObo; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so6044691e87.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567080; cv=none;
        d=google.com; s=arc-20240605;
        b=YpmJwzvoUwDxjN8uU9l54EOtjiBUnJKg1AknOimjWRHEpTpS9WSmGhb6o7rj4qq4W8
         91zNxmzrbEfanjJ0LodEDk18pr1wqkEODM616Cvd+BILHNP3FzYr8r04jjlVnfWlqQHJ
         /nIBwwwguOqWHDVdp7sbJu6agcC7RnzCZBHfrgkXOqKeHIkf63TmH1vKoYbmgTcPGG2D
         b8oPvg7NR6TouTp/oDwZcxPYDPpNRod5WYrN7h9XtKGxTfUpiMrOKfy6FFXOoIxyQppJ
         nsyr4h7Ou23QgqstNx5eCDPx4wXpYdi22nwOPZ8g0QvSBYyQbVv1uUioiCKocSJyk/XN
         np6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qX+yMQ39LGCizFFNuDqgOnec8AaxqCwJovsLGmZdWqs=;
        fh=KpBaa0fZ5VAJU7nTEAFVH6zhYhO/L9a5DhBKETz5m94=;
        b=YqpiLXqg/zy7CYLPEzz7/3gSFMyHWQq38RsZMDHdNs/IfW4sDdZh8hO8AkgaspJNj8
         i2eaz+9EondMlArUJHdN0IDFUA6li16hO6KjNw2GSivIMj6mH0lpNxgIFVxhbspL6RJm
         0Ab6woaJIvqAwjThbmNJQIJheGuwP3psaIiuqKBPa8rqzoLBK+Kevjk46v+KRX3n2w/i
         w4aNokEGUJM0g2F0KKso2+Fs9JCfEOReX0tFz+HeoQ0/aRx2fYqccY8tC60AzUORE55k
         SrwOS5d1xVq/1SlkU0/Ow3Nj0P7GEm0PklTKs6bxGuTOV7xOr+KtR4/Q1plHsGGawui4
         +Yqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567080; x=1770171880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX+yMQ39LGCizFFNuDqgOnec8AaxqCwJovsLGmZdWqs=;
        b=IzjxSObod3qTU5H0wLtD5UhreMGp8y6YrQpDwYRYqvCZ5bwjXAFNUXexiZnbN11Lo0
         rggKV9GTiIqp0ZQTeeqjoHsAqJr58bMjRV+X1eyw2TLUwDWvLF4oW/BeV+Lev1iIEXF4
         0sXLIxeDr2nT1JjbMTq3MrrM13aKp+8xTOGw/3s00I72xg19UlR0sayU7BgTsYSPLF+p
         mqyUtl4T8tM+ez3npB5QYSocz5mK+cHiuWsAKo56EWgppgA17iWeMk1Zw/pByk2Olnfb
         Y4YIwCwz85DvkBlzPTJ5wTWI1IESzMemf1tx7nyPa+jFAB2boJ66RRCNQAWccE25XV9d
         PVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567080; x=1770171880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qX+yMQ39LGCizFFNuDqgOnec8AaxqCwJovsLGmZdWqs=;
        b=YX+ar4U5BFBB4BA0XbrwC43gxFDOUenG3adxaF+IB7WdauBrQ5oY5ukEk15CZvpGrv
         JpXwWgH+YRUHriI9Wpv2xMpZrvbWmSilStOwiYmuECyAL3aE2EzpWAowWYTmLxpsCGiL
         2CWd/+8Vi5AxFjzgS5bUy8mCuJNin7EV9wDisZSZWCUhkPAOoz/zDmxKl2iNd4SNlSFy
         XLM5+YV65uW+zrdPQdqUtdJ667k9RX4CPcLPaM0DBBMYL1BJxFqEfuEBU9lBlw4ncXy9
         duUBx7VZA3jqPcS8eHFe0NBBT6Dbo2jRUJXzv6MUwmD8nm+Kjt9cIufcWBWCNubixJRs
         VGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZBw8BNCfGsGYCFpH7/5QSZSkuK/vDl+rn5Op3mLhw1m5al/l9dTTDXsElIXpXHGxtP83YHRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0o6fwog50CxT+ZFZUOpTF306Gtq9v/SW075v8T43lLzsX4UNP
	w3J0d5wxbegaJ6zz/lfoi8pMkZpy5dKrcQGsvn/abJ482OYaYB1EaXkzN671qMcTbz8IxVzqXLc
	hyUrfRzP9SsQkvGyuvUpw+DRJ5s89lnE+2kcMt/HcXQ==
X-Gm-Gg: AZuq6aLmnsFbO8SVWAIjdTIZBY42L5IiwGG79W8WybEV+VdfNIFTayXL9uqbjkC/lNH
	U9jZ2khjRecwLzhverSrzFLx9U2vqbyu6o9EN+xiGaKOM42aWfI2MvxPwfGj+EzZYaTfEcYsfkR
	i/XspGgFREyo9bjXcvk9PzMPe3TSsahvzM7eoxXtwEw+uTuKpZCNthSvtlA4cE0uxSLegYzCnDL
	j+8nXH84YTIOZRecPPNxFP/e8rS6+VbDyh26lZxLvGqKn1t8JzTRpA04NDdT5Ynk8Iy+5Ar
X-Received: by 2002:a05:6512:3406:b0:59d:de1a:6eb2 with SMTP id
 2adb3069b0e04-59e04029958mr1618386e87.38.1769567079505; Tue, 27 Jan 2026
 18:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127123828.4098577-1-edumazet@google.com> <20260127123828.4098577-3-edumazet@google.com>
In-Reply-To: <20260127123828.4098577-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 Jan 2026 10:24:02 +0800
X-Gm-Features: AZwV_QiiErBdQIh0GZXWbSIuOFl2HBDSswsO28xzZ8CIq3FqaRnO8vCq-nVw4Fk
Message-ID: <CAL+tcoDwkkHNhsq=hJbM_-fe_bpfL1pkExVVdt5em8EgfOZP8w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254067-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 96C309C368
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Test tcp_tx_timestamp() behavior after ("tcp: tcp_tx_timestamp()
> must look at the rtx queue").
>
> Without the fix, this new test fails like this:
>
> tcp_timestamping_tcp_tx_timestamp_bug.pkt:55: runtime error in recvmsg ca=
ll: Expected result 0 but got -1 with errno 11 (Resource temporarily unavai=
lable)
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for the test!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

+Willem

Thanks,
Jason

