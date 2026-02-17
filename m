Return-Path: <netdev+bounces-259145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE3/HtfSlGmfIAIAu9opvQ
	(envelope-from <netdev+bounces-259145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:43:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB61501EC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D6453013DE4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5F3783AF;
	Tue, 17 Feb 2026 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMrx36UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC3372B2D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360979; cv=pass; b=hQfZwFzAQwsfG5TRGcRH3S5nO+squeorJWmQhMHXLeS/8FkZLSHAgh6paRLqfV41w4q6lYbzcQRsA+nMyf/WqLatqCXdX6/7MpoBy+sRiSjApY+Qpz7gxSXyn1ohWCIXxwrbclQZY2lneYWFK3u7t73OgSLcSA7wRye+xZuHJRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360979; c=relaxed/simple;
	bh=qE5BJwxBhGE7NMqnHEZdoZLXL7/36c9CZsQZdxVxRE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nu6RQkqjPbJHJ3eHeAPhNgi88xxOf8LWUomn3uzOBs5h4Q1l7iJWfyB2hKhSnU44XygNA5Xkj87jElMn3JsxX+5HPcmyKgyvdxaIctfxAPSOuGINUQ/hxiNc4yd0l2VD4sxZ/7wUzz30nz8/KBgAZ5Sx7pSt+sSI6y028ZDYOLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMrx36UJ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124a635476fso5160456c88.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:42:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771360977; cv=none;
        d=google.com; s=arc-20240605;
        b=izOFX2xlHitFQOXNUECbmfuUgS0UfhBNrMrZfwC7yfquuq1xE6qwTcOQTtBM8M01wm
         kspxjmIjdzyQOnQf7tmTHzswUMkFZ0Y1xEfXalUfaESGNMhU0g7gjQL/bRIchMsePX1P
         qNgzlB0AbCf3qL3AOoucKMI8xCBHyT1fciifzyqyRr/6Fnax8FYh59EiNr5N+TVtOB5P
         WMilWPZprChgmTOjQ4BtRdm7qK4fT6M8M3nI+6DtJ4Doi7y+VMwkR6HTlYwX5nosL1Zo
         cjejttjd7QrMjm+efZpVIM4qgJm5ma7F/J9sNyafR/h/FB38InpAifdc+sY1qOJPFG4z
         VrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qE5BJwxBhGE7NMqnHEZdoZLXL7/36c9CZsQZdxVxRE8=;
        fh=0Zo1oRa+7rP6BcvxZkuDgcCy6i+MNNXp4sJ0UrUuEwg=;
        b=gUwhEW19VXFqNsxc3ovVezaizIm6RCcWwPVaMADcO3UqP8YzaOUtzZu+BJeeljlcwo
         BzShy/kDZBE+TqzBYCqtM1/wfMRgPnJuuQ3+3RqfmLqndiQy3if/ZCz12zojEukegL6F
         EnAvdgsel/0Q+CNoC3YibUy7DfQ+1dZjs8K9b7qohgKknpiBr5EWXCl+q9KTAfUw7OoW
         Y4NGWSkT9ShaiNWy4SPGSEYXEMHqsBcz7AZ22o1BqcvHtAO3BxNofMzJ6Zf+qEclRD6b
         dOaiTFMLjjAy7VrO8tb/zqvKFjyu2Akn5VH0W/WGeB1JqQPGe/Es2HyLdmITIT89uHOa
         13HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771360977; x=1771965777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE5BJwxBhGE7NMqnHEZdoZLXL7/36c9CZsQZdxVxRE8=;
        b=iMrx36UJXf4L03nla8mAwTZ1lLOZ80DmBdforSRbT8XHWIEntZkU/YCDKv9XlLbSQp
         U57kPRBRHjcXEzkBab72toGSFaTNU1jvIoK9gkWBOiHjb+fBXokISy1B6wh0NuasObg2
         Qy/z6gAs6jVlLggsoTQRo6O8KGfrmjgU+aS0mM6cDQpauK6ZdkPOECPyRikHXpCjw8Qr
         CscKguikyNTXs2xvq1GlsxWjy7F/foY6Wowk4MKXFGk6JPv6gbRWEn0jdF73B4sZ1BTn
         VqgUsC4cVIHEEn6Yy6BlTfsV+7+RL8n+sETs/L/OLSEQ9T1DQ8c4ww/Mq3E/R1lV470j
         BJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771360977; x=1771965777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qE5BJwxBhGE7NMqnHEZdoZLXL7/36c9CZsQZdxVxRE8=;
        b=m1XCQefugOSlxw/xNa9K2Tx0f8QfP8j5Wjiyx5KvgR8a64p482K7xzPx4V+x3TUD5+
         pMZ4Gcmo/T4CbRGaEtEvLqy/Mz294iJoBkJS+Bx1gVGpQdMzT6ONNmDSO3BndL+9Lozp
         kmRW6unDoQHX8tarGBlJ0OTi2hyq2uNBEJdQFwGD4ORvjuIpxVPB3hBSEqAcQGt80Jxk
         eri9mILvCP11MhzaDS/IGyXGROO1eOlvgAhdviWP7U05I7PP5YS2fq7cF4z1sNR7FMTX
         emwR7jUT/T3XHN5Y9NEVzCBbyMiR8O46EuV4gv0gTDi4/cJ+F66A4r1eWgIZIDvMICX9
         pLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDKP56WSweC7p5JwnltLDcYo88Ic1MWTGwkjvFYMP6pbQX4HZZ8xXf3pyVCC2hBVk0Ft1oGeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42eDzLsPUflBpAHMEmGPNMaj0miaxraRgkBD+KRpK9QE6KoaG
	mMKAuKP5EF+kMYZmG4XUALAnk+3iJHJGMXuMWxc6F+DQC3RJK4czMa8xJUnQa2Da0vEB42v7pKr
	llA/+dYP/LOgvcgF67NpTNI5dYB4sRe4T5+qs++gw
X-Gm-Gg: AZuq6aKX3g895XlVrPRV7eY1yf+sckzdJT1LDd9k7C9uhqiUtTYRT9ojo+9z59A31Vs
	h0cnvQkHDsf2COnaAoq0r3aB58I+6L9XrRiIHsTQh1tAlzawCg+Uj0EWNa797MEnMbTB2fbLew+
	rnDzjx2jojRoQW5djdF5HmnPJdF5TKWe4e55iS7vk+59gCla75Paj3OJnF+ZeVf0UhhPNfuNAvq
	qAyf6XzFObmKGlA7dQMgUkhu9/0RgtPUzfoLBs7GOuS49Vo+mzW1VIEh+U7B3NJ/FnuDDczWd4b
	yR9wAS8ocIshPQqnx1hQ0nieqavNsrNC7/cUJ/LxULaMqsE3KxpXSGXLcSZEcVYDmZ8y8g==
X-Received: by 2002:a05:7022:a9a:b0:11b:a73b:2327 with SMTP id
 a92af1059eb24-1273ae2ef59mr5755635c88.30.1771360976785; Tue, 17 Feb 2026
 12:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216100149.3319315-1-edumazet@google.com>
In-Reply-To: <20260216100149.3319315-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 17 Feb 2026 12:42:45 -0800
X-Gm-Features: AaiRm51-AErBkGF6Ec3rESz4luSe50AE1UNdemxIh2oAMaYtBDpWMDwKbmiKezE
Message-ID: <CAAVpQUB-W=gk+mGxu6gXWmbw9p3bVNww=A7kDih-9qojN5UV2w@mail.gmail.com>
Subject: Re: [PATCH net] ping: annotate data-races in ping_lookup()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259145-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 39AB61501EC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> isk->inet_num, isk->inet_rcv_saddr and sk->sk_bound_dev_if
> are read locklessly in ping_lookup().
>
> Add READ_ONCE()/WRITE_ONCE() annotations.
>
> The race on isk->inet_rcv_saddr is probably coming from IPv6 support,
> but does not deserve a specific backport.
>
> Fixes: dbca1596bbb0 ("ping: convert to RCU lookups, get rid of rwlock")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

